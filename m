Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC84C3015
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 16:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiBXPnJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 10:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbiBXPnI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 10:43:08 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF151BE4EC;
        Thu, 24 Feb 2022 07:42:37 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:55030)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nNGGG-003tg5-Kh; Thu, 24 Feb 2022 08:42:32 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34182 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nNGGE-00649l-7g; Thu, 24 Feb 2022 08:42:32 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Security Officers <security@kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>, NeilBrown <neilb@suse.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <linus@torvalds.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
        <20220215101150.GD21589@blackbody.suse.cz>
        <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
        <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
        <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
        <878ru1qcos.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
        <87tucpko7d.fsf@email.froward.int.ebiederm.org>
Date:   Thu, 24 Feb 2022 09:41:44 -0600
In-Reply-To: <87tucpko7d.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 23 Feb 2022 20:12:06 -0600")
Message-ID: <87sfs8jmpz.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nNGGE-00649l-7g;;;mid=<87sfs8jmpz.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3Jux14MA1HuBGnaWTv8tG7ssEHPwrI1k=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1802 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 16 (0.9%), b_tie_ro: 15 (0.8%), parse: 1.97
        (0.1%), extract_message_metadata: 20 (1.1%), get_uri_detail_list: 2.8
        (0.2%), tests_pri_-1000: 18 (1.0%), tests_pri_-950: 1.45 (0.1%),
        tests_pri_-900: 1.20 (0.1%), tests_pri_-90: 122 (6.8%), check_bayes:
        121 (6.7%), b_tokenize: 10 (0.6%), b_tok_get_all: 11 (0.6%),
        b_comp_prob: 3.0 (0.2%), b_tok_touch_all: 93 (5.1%), b_finish: 0.98
        (0.1%), tests_pri_0: 1602 (88.9%), check_dkim_signature: 0.70 (0.0%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 1.00 (0.1%), tests_pri_10:
        2.2 (0.1%), tests_pri_500: 13 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] ucounts: Fix systemd LimigtNPROC with private users regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Long story short recursively enforcing RLIMIT_NPROC when it is not
enforced on the process that creates a new user namespace, causes
currently working code to fail.  There is no reason to enforce
RLIMIT_NPROC recursively when we don't enforce it normally so update
the code to detect this case.

I would like to simply use capable(CAP_SYS_RESOURCE) to detect when
RLIMIT_NPROC is not enforced upon the caller.  Unfortunately because
RLIMIT_NPROC is charged and checked for enforcement based upon the
real uid, using capable() wich is euid based is inconsistent with reality.
Come as close as possible to testing for capable(CAP_SYS_RESOURCE) by
testing for when the real uid would match the conditions when
CAP_SYS_RESOURCE would be present if the real uid was the effective
uid.

Reported-by: Etienne Dechamps <etienne@edechamps.fr>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215596
Link: https://lkml.kernel.org/r/e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr
Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

The previous conversation has given me enough clarity that I can see
which tests I am comfortable with use for this pending regression fix.

I have tested this and it works for me.  Does anyone have any concerns
with this change?

 kernel/user_namespace.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..5481ba44a8d6 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -58,6 +58,18 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
 	cred->user_ns = user_ns;
 }
 
+static unsigned long enforced_nproc_rlimit(void)
+{
+	unsigned long limit = RLIM_INFINITY;
+
+	/* Is RLIMIT_NPROC currently enforced? */
+	if (!uid_eq(current_uid(), GLOBAL_ROOT_UID) ||
+	    (current_user_ns() != &init_user_ns))
+		limit = rlimit(RLIMIT_NPROC);
+
+	return limit;
+}
+
 /*
  * Create a new user namespace, deriving the creator from the user in the
  * passed credentials, and replacing that user with the new root user for the
@@ -122,7 +134,7 @@ int create_user_ns(struct cred *new)
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
 	}
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
+	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, enforced_nproc_rlimit());
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
-- 
2.29.2

