Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2993A4ABED9
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382629AbiBGM20 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 07:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382733AbiBGMYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:24:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E93C002B4D;
        Mon,  7 Feb 2022 04:18:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9B090210E7;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644236292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4aAhbDoTDfRME9edOXYN8Xd3j7KeUJo6FCdttuCi7Q=;
        b=qcuQVmPAKpuli8d8JKcy9s2e+6GX/jOzZeZJNIji/24oWaLjPX8+Cz2+qzRBS1bRUmJPDe
        pYqkF0kg059Fuh0emCFA3zwXUDfANmYFDp+aiQv2AFBdtdSYZWeY8qy3+mQ+BfgWCYW2ra
        eFvrMzdhrvh2BOyfRa+Pli1YwbUwxbk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 781D913BE6;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AInNHAQOAWLMegAAMHmgww
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
Subject: [RFC PATCH 1/6] set_user: Perform RLIMIT_NPROC capability check against new user credentials
Date:   Mon,  7 Feb 2022 13:17:55 +0100
Message-Id: <20220207121800.5079-2-mkoutny@suse.com>
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

The check is currently against the current->cred but since those are
going to change and we want to check RLIMIT_NPROC condition after the
switch, supply the capability check with the new cred.
But since we're checking new_user being INIT_USER any new cred's
capability-based allowance may be redundant when the check fails and the
alternative solution would be revert of the commit 2863643fb8b9
("set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds")

Fixes: 2863643fb8b9 ("set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds")

Cc: Solar Designer <solar@openwall.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sys.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 8ea20912103a..48c90dcceff3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -481,7 +481,8 @@ static int set_user(struct cred *new)
 	 */
 	if (ucounts_limit_cmp(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) >= 0 &&
 			new_user != INIT_USER &&
-			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+			!security_capable(new, &init_user_ns, CAP_SYS_RESOURCE, CAP_OPT_NONE) &&
+			!security_capable(new, &init_user_ns, CAP_SYS_ADMIN, CAP_OPT_NONE))
 		current->flags |= PF_NPROC_EXCEEDED;
 	else
 		current->flags &= ~PF_NPROC_EXCEEDED;
-- 
2.34.1

