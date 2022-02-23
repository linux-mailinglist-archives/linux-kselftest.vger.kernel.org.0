Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB04C067F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 01:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiBWA6g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 19:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiBWA6g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 19:58:36 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0789B9FD4;
        Tue, 22 Feb 2022 16:58:08 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:48142)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMfyn-0077eS-9r; Tue, 22 Feb 2022 17:58:05 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53636 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nMfyl-00GFL8-3J; Tue, 22 Feb 2022 17:58:04 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
        <20220215101150.GD21589@blackbody.suse.cz>
Date:   Tue, 22 Feb 2022 18:57:57 -0600
In-Reply-To: <20220215101150.GD21589@blackbody.suse.cz> ("Michal
 =?utf-8?Q?Koutn=C3=BD=22's?=
        message of "Tue, 15 Feb 2022 11:11:50 +0100")
Message-ID: <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nMfyl-00GFL8-3J;;;mid=<87zgmi5rhm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18iPGCO4B276Z3GxX9JVuKlbTclCHijZRQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?*;Michal Koutn=c3=bd <mkoutny@suse.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 1584 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.38
        (0.1%), extract_message_metadata: 17 (1.1%), get_uri_detail_list: 2.0
        (0.1%), tests_pri_-1000: 16 (1.0%), tests_pri_-950: 1.38 (0.1%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 62 (3.9%), check_bayes: 61
        (3.8%), b_tokenize: 9 (0.6%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        2.6 (0.2%), b_tok_touch_all: 36 (2.3%), b_finish: 0.88 (0.1%),
        tests_pri_0: 1456 (91.9%), check_dkim_signature: 0.80 (0.1%),
        check_dkim_adsp: 6 (0.4%), poll_dns_idle: 0.61 (0.0%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 12 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/6] RLIMIT_NPROC in ucounts fixups
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Michal Koutný <mkoutny@suse.com> writes:

> On Sat, Feb 12, 2022 at 03:32:30PM +0000, Etienne Dechamps <etienne@edechamps.fr> wrote:
>> I'm not sure I understand everything that's going on in this thread but it
>> does seem very relevant. You guys might want to double-check the behavior in
>> the particular scenario described there. I'm mostly sending this to make
>> sure everything is cross-linked.
>
> Thanks for the report with strace.
>
> AFAICT, it's caused by setresuid() after unshare(), i.e. all root's
> tasks are (wrongly) compared against the lowered RLIMIT_NPROC.
>
> This is tackled by my RFC patch 2/6 [1] or Eric's variant but 3/8
> (equivalent fix for this case but I haven't run that build).
>
> Michal
>
> [1] I could run your test (LimitNPROC=1 actually) against kernel with my
> patches and the service starts.


So I looked into this and our previous patchsets (but not my final one)
did resolve this.

What fixed it and what is needed to fix this is not enforcing
RLIMIT_NPROC when the user who creates the user namespace is INIT_USER.

AKA something like the patch below.  It is a regression so if at all
possible it needs to be fixed, and it is certainly possible.

The patch below feels right at first glance, but I am not convinced that
testing cred->user or cred->ucounts is the proper test so I am going to
sleep on this a little bit.

I did want everyone to know I looked into this and I am going to ensure
this gets fixed.

diff --git a/kernel/fork.c b/kernel/fork.c
index 17d8a8c85e3b..532ce5cbf851 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2027,7 +2027,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	retval = -EAGAIN;
 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
-		if (p->real_cred->user != INIT_USER &&
+		if (p->real_cred->ucounts != &init_ucounts &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
diff --git a/kernel/sys.c b/kernel/sys.c
index 97dc9e5d6bf9..7b5d74a7845c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -490,7 +490,7 @@ static void flag_nproc_exceeded(struct cred *new)
 	 * failure to the execve() stage.
 	 */
 	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
-			new->user != INIT_USER)
+			new->ucounts != &init_ucounts)
 		current->flags |= PF_NPROC_EXCEEDED;
 	else
 		current->flags &= ~PF_NPROC_EXCEEDED;
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..925fb3579ef3 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -123,6 +123,8 @@ int create_user_ns(struct cred *new)
 		ns->ucount_max[i] = INT_MAX;
 	}
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
+	if (new->ucounts == &init_ucounts)
+		set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, RLIM_INFINITY);
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));





