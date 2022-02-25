Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540DF4C3A59
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 01:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiBYAaM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 19:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiBYAaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 19:30:11 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC4329F412;
        Thu, 24 Feb 2022 16:29:41 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:42592)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nNOUI-001Ewm-DQ; Thu, 24 Feb 2022 17:29:34 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:56954 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nNOUH-000XdN-5K; Thu, 24 Feb 2022 17:29:34 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
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
        <87sfs8jmpz.fsf_-_@email.froward.int.ebiederm.org>
        <202202240826.E31BADF@keescook>
Date:   Thu, 24 Feb 2022 18:29:24 -0600
In-Reply-To: <202202240826.E31BADF@keescook> (Kees Cook's message of "Thu, 24
        Feb 2022 08:28:41 -0800")
Message-ID: <87y21zhjq3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nNOUH-000XdN-5K;;;mid=<87y21zhjq3.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+tiJNf1YjykR+rfILbUT6/qjREErIq3zE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 634 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.7%), b_tie_ro: 2.9 (0.5%), parse: 0.92
        (0.1%), extract_message_metadata: 15 (2.3%), get_uri_detail_list: 2.1
        (0.3%), tests_pri_-1000: 21 (3.3%), tests_pri_-950: 0.99 (0.2%),
        tests_pri_-900: 0.82 (0.1%), tests_pri_-90: 62 (9.8%), check_bayes: 61
        (9.6%), b_tokenize: 9 (1.4%), b_tok_get_all: 12 (1.8%), b_comp_prob:
        2.7 (0.4%), b_tok_touch_all: 33 (5.3%), b_finish: 0.80 (0.1%),
        tests_pri_0: 392 (61.9%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 1.87 (0.3%), poll_dns_idle: 121 (19.2%),
        tests_pri_10: 2.3 (0.4%), tests_pri_500: 132 (20.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] ucounts: Fix systemd LimigtNPROC with private users
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> typo: Subject's LimigtNPROC -> LimitNPROC
>
> On Thu, Feb 24, 2022 at 09:41:44AM -0600, Eric W. Biederman wrote:
>> 
>> Long story short recursively enforcing RLIMIT_NPROC when it is not
>> enforced on the process that creates a new user namespace, causes
>> currently working code to fail.  There is no reason to enforce
>> RLIMIT_NPROC recursively when we don't enforce it normally so update
>> the code to detect this case.
>> 
>> I would like to simply use capable(CAP_SYS_RESOURCE) to detect when
>> RLIMIT_NPROC is not enforced upon the caller.  Unfortunately because
>> RLIMIT_NPROC is charged and checked for enforcement based upon the
>> real uid, using capable() wich is euid based is inconsistent with reality.
>
> typo: wich -> which

Ahh... Typos.

>> Come as close as possible to testing for capable(CAP_SYS_RESOURCE) by
>> testing for when the real uid would match the conditions when
>> CAP_SYS_RESOURCE would be present if the real uid was the effective
>> uid.
>> 
>> Reported-by: Etienne Dechamps <etienne@edechamps.fr>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215596
>> Link: https://lkml.kernel.org/r/e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr
>> Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>> 
>> The previous conversation has given me enough clarity that I can see
>> which tests I am comfortable with use for this pending regression fix.
>> 
>> I have tested this and it works for me.  Does anyone have any concerns
>> with this change?
>
> I'd really love some kind of selftest that exercises the edge cases; do
> you have your tests in some form that could be converted?
>
> But otherwise, yes, this looks like the best option here.

Let's start with Michal Koutný tests.  I keep forgetting to look at
them.  This cold has really been kicking my butt.

For this issue the test case was a systemd unit file.  Which is simple
and demonstrates the real-world regression but not really minimal in the
way a kernel selftest should be.

> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> 
>>  kernel/user_namespace.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
>> index 6b2e3ca7ee99..5481ba44a8d6 100644
>> --- a/kernel/user_namespace.c
>> +++ b/kernel/user_namespace.c
>> @@ -58,6 +58,18 @@ static void set_cred_user_ns(struct cred *cred, struct user_namespace *user_ns)
>>  	cred->user_ns = user_ns;
>>  }
>>  
>> +static unsigned long enforced_nproc_rlimit(void)
>> +{
>> +	unsigned long limit = RLIM_INFINITY;
>> +
>> +	/* Is RLIMIT_NPROC currently enforced? */
>> +	if (!uid_eq(current_uid(), GLOBAL_ROOT_UID) ||
>> +	    (current_user_ns() != &init_user_ns))
>> +		limit = rlimit(RLIMIT_NPROC);
>> +
>> +	return limit;
>> +}
>> +
>>  /*
>>   * Create a new user namespace, deriving the creator from the user in the
>>   * passed credentials, and replacing that user with the new root user for the
>> @@ -122,7 +134,7 @@ int create_user_ns(struct cred *new)
>>  	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
>>  		ns->ucount_max[i] = INT_MAX;
>>  	}
>> -	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
>> +	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, enforced_nproc_rlimit());
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
>>  	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
>> -- 
>> 2.29.2
>> 

Eric
