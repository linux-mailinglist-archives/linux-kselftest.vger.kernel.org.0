Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA34ABF98
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiBGN1k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 08:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445594AbiBGMmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:42:18 -0500
X-Greylist: delayed 944 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 04:33:58 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB4E033DAE;
        Mon,  7 Feb 2022 04:33:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB2991F388;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644236292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CS9BI2kyakQST5h0Bh8iX4MIXucTQqH9EtpYM1r+SFU=;
        b=bqyOAR/Ayx8HfmqJm7xqDwfnnaJaQS1Qv9Tx/Q+FF33WDgwUGGTN7e3wbrcRLHYknmL5Om
        HmZMg8Jr6e/02m+nPGbCLFRtXL0IkWThH62+sbXAnZpweMZCIcEhJ8/G562/CYTQvgCl2M
        gtj0TNANCxXwxRIXLjvgdFspEH12zzE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA6EC13BE6;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +E37LAQOAWLMegAAMHmgww
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
Subject: [RFC PATCH 3/6] cred: Count tasks by their real uid into RLIMIT_NPROC
Date:   Mon,  7 Feb 2022 13:17:57 +0100
Message-Id: <20220207121800.5079-4-mkoutny@suse.com>
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

Tasks are associated to multiple users at once. Historically and as per
setrlimit(2) RLIMIT_NPROC is enforce based on real user ID.

The commit 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
made the accounting structure "indexed" by euid and hence potentially
account tasks differently.

The effective user ID may be different e.g. for setuid programs but
those are exec'd into already existing task (i.e. below limit), so
different accounting is moot.

Some special setresuid(2) users may notice the difference, justifying
this fix.
(This is just illustrative, it piggy-backs onto nproc_flags and should
be implemented properly.)

Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cred.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 791cab70b764..ed247daa1f67 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -668,6 +668,7 @@ int set_cred_ucounts(struct cred *new, unsigned int *nproc_flags)
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
 	struct ucounts *new_ucounts, *old_ucounts = new->ucounts;
+	kuid_t new_uid = nproc_flags ? new->uid : new->euid;
 
 	if (new->user == old->user && new->user_ns == old->user_ns)
 		return 0;
@@ -676,10 +677,10 @@ int set_cred_ucounts(struct cred *new, unsigned int *nproc_flags)
 	 * This optimization is needed because alloc_ucounts() uses locks
 	 * for table lookups.
 	 */
-	if (old_ucounts->ns == new->user_ns && uid_eq(old_ucounts->uid, new->euid))
+	if (old_ucounts->ns == new->user_ns && uid_eq(old_ucounts->uid, new_uid))
 		return 0;
 
-	if (!(new_ucounts = alloc_ucounts(new->user_ns, new->euid)))
+	if (!(new_ucounts = alloc_ucounts(new->user_ns, new_uid)))
 		return -EAGAIN;
 
 	new->ucounts = new_ucounts;
-- 
2.34.1

