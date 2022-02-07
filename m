Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF5B4ABF93
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiBGN0S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 08:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445600AbiBGMmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:42:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6D2E033DAF;
        Mon,  7 Feb 2022 04:33:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 060CC1F38D;
        Mon,  7 Feb 2022 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644236293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUdGqqOL/AiENbReMRD7Dx9TxjZn7NTW8OeBOFQBruY=;
        b=syKK+oRx7HRZghKuXKJxOaqgXkuQ234dxQMVDFvHqsaX93Pknk+cCPMfxkHYeEw0jk+uzw
        1SPGHJ5iqzTU0Vy8kr4s/+owO2lP/pLWg/MmnyUj8X9wb+MQygfHMldN0Ffcm+JVXTPR/x
        cN1mEwthFVDCQsFbjhA26vHWnSsuR2I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D976113BBC;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MNyWNAQOAWLMegAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 07 Feb 2022 12:18:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [RFC PATCH 4/6] ucounts: Allow root to override RLIMIT_NPROC
Date:   Mon,  7 Feb 2022 13:17:58 +0100
Message-Id: <20220207121800.5079-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207121800.5079-1-mkoutny@suse.com>
References: <20220207121800.5079-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Call sites of ucounts_limit_cmp() would allow the global root or capable
user to bypass RLIMIT_NPROC on the bottom level of user_ns tree by not
looking at ucounts at all.

As the traversal up the user_ns tree continues, the ucounts to which the
task is charged may switch the owning user (to the creator of user_ns).
If the new chargee is root, we don't really care about RLIMIT_NPROC
observation, so lift the limit to the max.

The result is that an unprivileged user U can globally run more that
RLIMIT_NPROC (of user_ns) tasks but within each user_ns it is still
limited to RLIMINT_NPROC (as passed into task->signal->rlim) iff the
user_nss are created by the privileged user.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/ucount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 53ccd96387dd..f52b7273a572 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -356,6 +356,9 @@ long ucounts_limit_cmp(struct ucounts *ucounts, enum ucount_type type, unsigned
 		if (excess > 0)
 			return excess;
 		max = READ_ONCE(iter->ns->ucount_max[type]);
+		/* Next ucounts owned by root? RLIMIT_NPROC is moot */
+		if (type == UCOUNT_RLIMIT_NPROC && uid_eq(iter->ns->owner, GLOBAL_ROOT_UID))
+			max = LONG_MAX;
 	}
 	return excess;
 }
-- 
2.34.1

