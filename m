Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5D4C2194
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 03:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiBXCMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 21:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiBXCMs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 21:12:48 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEEA3916D;
        Wed, 23 Feb 2022 18:12:19 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:34822)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN3c8-002aaK-8v; Wed, 23 Feb 2022 19:12:16 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:55298 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN3c5-004B4F-Hm; Wed, 23 Feb 2022 19:12:15 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <linus@torvalds.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Security Officers <security@kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>, NeilBrown <neilb@suse.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>
References: <20220207121800.5079-1-mkoutny@suse.com>
        <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
        <20220215101150.GD21589@blackbody.suse.cz>
        <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
        <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
        <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
        <878ru1qcos.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
Date:   Wed, 23 Feb 2022 20:12:06 -0600
In-Reply-To: <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 23 Feb 2022 17:41:41 -0800")
Message-ID: <87tucpko7d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nN3c5-004B4F-Hm;;;mid=<87tucpko7d.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sXMjClQeoUPAVF231IDl3vRQn66Dcwoc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <linus@torvalds.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1736 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.6%), b_tie_ro: 10 (0.6%), parse: 1.31
        (0.1%), extract_message_metadata: 17 (1.0%), get_uri_detail_list: 2.8
        (0.2%), tests_pri_-1000: 17 (1.0%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.08 (0.1%), tests_pri_-90: 108 (6.2%), check_bayes:
        95 (5.5%), b_tokenize: 28 (1.6%), b_tok_get_all: 14 (0.8%),
        b_comp_prob: 4.7 (0.3%), b_tok_touch_all: 44 (2.5%), b_finish: 1.89
        (0.1%), tests_pri_0: 1521 (87.6%), check_dkim_signature: 0.80 (0.0%),
        check_dkim_adsp: 3.3 (0.2%), poll_dns_idle: 1.27 (0.1%), tests_pri_10:
        2.7 (0.2%), tests_pri_500: 52 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: How should rlimits, suid exec, and capabilities interact?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Linus Torvalds <linus@torvalds.org> writes:

> On Wed, Feb 23, 2022 at 5:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Question: Running a suid program today charges the activity of that
>> program to the user who ran that program, not to the user the program
>> runs as.  Does anyone see a problem with charging the user the program
>> runs as?
>
> So I think that there's actually two independent issues with limits
> when you have situations like this where the actual user might be
> ambiguous.
>
>  - the "who to charge" question
>
>  - the "how do we *check* the limit" question
>
> and honestly, I think that when it comes to suid binaries, the first
> question is fundamentally ambiguous, because it almost certainly
> depends on the user.
>
> Which to me implies that there probably isn't an answer that is always
> right, and that what you should look at is that second option.
>
> So I would actually suggest that the "execute a suid binary" should
> charge the real user, but *because* it is suid, it should then not
> check the limit (or, perhaps, should check the hard limit?).
>
> You have to charge somebody, but at that point it's a bit ambiguous
> whether it should be allowed.
>
> Exactly so that if you're over a process limit (or something similar -
> think "too many files open" or whatever because you screwed up and
> opened everything) you could still log in as yourself (ssh/login
> charges some admin thing, which probably has high limits or is
> unlimited), and hopefully get shell access, and then be able to "exec
> sudo" to actually get admin access that should be disabled from the
> network.
>
> The above is just one (traditional) example of a fork/open bomb case
> where a user isn't really able to no longer function as himself, but
> wants to fix things (maybe the user has another terminal open, but
> then he can hopefully use a shell-buiiltin 'kill' instead).
>
> And I'm not saying it's "the thing that needs to work". I'm more
> making up an example.
>
> So I'm only saying that the above actually has two examples to the two
> sides of the coin: "login" lowering privileges to a user that may be
> over some limit - and succeeding despite that - and 'suid' succeeding
> despite the original user perhaps being over-committed.
>
> So it's intended exactly as an example of "picking the new or the old
> user would be wrong in either case if you check limits at the
> transition point".
>
> Hmm?

That doesn't really clarify anything for me.  We have two checks one in
fork and one in exec and you seem to be talking about the check in exec.

The check I have problems with for a suid executable is the check in
fork.  If the new process is accounted to the previous user and we use
the permissions of the effective user for checking it that does not make
sense to me.

If we can sort out that the check in fork.  I think I have clarity about
the other cases.




The check in exec while clumsy and needing cleaning up seems to make
sense to me.  We have a transition that starts with fork and ends with
exec and has operations like setuid in between.  If something like
setuid() is called before exec we check in exec.

The case the check in exec is aimed at supporting are processes spawned
from a parent that have a different user (than the parent) and will
never call fork again.   Those processes would be fundamentally immune
to RLIMIT_NPROC if we don't check somewhere besides fork.  There is
existing code in apache to use RLIMIT_NPROC this way.



For your login case I have no problems with it in principle.  In
practice I think you have to login as root to deal with a fork bomb that
hits RLIMIT_NPROC and does not die gracefully.

What I don't see about your login example is how it is practically
different from the apache cgi script case, that the code has supported
for 20 years, and that would be a regression if stopped supporting.

If we want to stop supporting that case we can just remove all of the
RLIMIT_NPROC tests everywhere except for fork, a nice cleanup.




That still leaves me with mismatched effective vs real uid checks in
fork when the effective and real uids don't match.  Which means testing
for root with "capable(CAP_SYS_ADMIN)" does not work.  Which today is
make the code a bit of a challenge to understand and work with.

Eric
