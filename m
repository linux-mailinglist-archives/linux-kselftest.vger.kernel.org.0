Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DB04C21A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 03:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiBXCRD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 21:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiBXCRC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 21:17:02 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B02BB0A;
        Wed, 23 Feb 2022 18:16:33 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33614)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN2rs-00GJkb-1D; Wed, 23 Feb 2022 18:24:28 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53352 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN2rq-0044iM-PT; Wed, 23 Feb 2022 18:24:27 -0700
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
Date:   Wed, 23 Feb 2022 19:24:19 -0600
In-Reply-To: <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 23 Feb 2022 11:50:38 -0800")
Message-ID: <878ru1qcos.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nN2rq-0044iM-PT;;;mid=<878ru1qcos.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/U781PhiDNIl7q7MwB3lIxUeSfdkrvwaY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <linus@torvalds.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 674 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.70
        (0.3%), extract_message_metadata: 20 (2.9%), get_uri_detail_list: 3.7
        (0.5%), tests_pri_-1000: 14 (2.1%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 124 (18.4%), check_bayes:
        119 (17.7%), b_tokenize: 11 (1.6%), b_tok_get_all: 12 (1.7%),
        b_comp_prob: 4.0 (0.6%), b_tok_touch_all: 89 (13.2%), b_finish: 0.93
        (0.1%), tests_pri_0: 488 (72.4%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 3.0 (0.4%), poll_dns_idle: 1.22 (0.2%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: How should rlimits, suid exec, and capabilities interact?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Linus Torvalds <linus@torvalds.org> writes:

> Basic rule: it's better to be too lenient than to be too strict.

Thank you.  With that guideline I can explore the space of what is
possible.

Question: Running a suid program today charges the activity of that
program to the user who ran that program, not to the user the program
runs as.  Does anyone see a problem with charging the user the program
runs as?

The reason I want to change who is charged with a process (besides it
making more sense in my head) is so that capable(CAP_SYS_RESOURCE) can
be used instead of the magic incantation (cred->user == INIT_USER).

An accidental experiment happened in v5.14-rc1 in July when the ucount
rlimit code was merged.  It was only this last week when after Michal
Koutný discovered the discrepency through code inspect a bug fix was
merged.

This changes the behavior that has existed in some form since Linux v1.0
when per user process limits were added.

The original code in v1.0 looked like:
> static int find_empty_process(void)
> {
>        int free_task;
>        int i, tasks_free;
>        int this_user_tasks;
> 
> repeat:
>        if ((++last_pid) & 0xffff8000)
>                last_pid=1;
>        this_user_tasks = 0;
>        tasks_free = 0;
>        free_task = -EAGAIN;
>        i = NR_TASKS;
>        while (--i > 0) {
>                if (!task[i]) {
>                        free_task = i;
>                        tasks_free++;
>                        continue;
>                }
>                if (task[i]->uid == current->uid)
>                        this_user_tasks++;
>                if (task[i]->pid == last_pid || task[i]->pgrp == last_pid ||
>                    task[i]->session == last_pid)
>                        goto repeat;
>        }
>        if (tasks_free <= MIN_TASKS_LEFT_FOR_ROOT ||
>            this_user_tasks > MAX_TASKS_PER_USER)
>                if (current->uid)
>                        return -EAGAIN;
>        return free_task;
> }

Having tracked the use of real uid in limits back this far my guess
is that it was an accident of the implementation and real uid vs
effective uid had not be considered.

Does anyone know if choosing the real uid was a deliberate decision
anywhere in the history of Linux?



Linus you were talking about making it possible to login as I think a
non-root user to be able to use sudo and kill a fork bomb.

The counter case is apache having a dedicated user for running
cgi-scripts and using RLIMIT_NPROC to limit how many of those processes
can exist.  Unless I am misunderstanding something that looks exactly
like your login as non-root so you can run sudo to kill a fork-bomb.

A comment from an in-process cleanup patch explains this as best I can:
         /*
         * In general rlimits are only enforced when a new resource
         * is acquired.  That would be during fork for RLIMIT_NPROC.
         * That is insufficient for RLIMIT_NPROC as many attributes of
         * a new process must be set between fork and exec.
         *
         * A case where this matter is when apache runs forks a process
         * and calls setuid to run cgi-scripts as a different user.
         * Generating those processes through a code sequence like:
         *
         *      fork()
 	 *	setrlimit(RLIMIT_NPROC, ...)         
         *      execve()  -- suid wrapper
         *      setuid()
         *      execve()  -- cgi script
         *
         * The cgi-scripts are unlikely to fork on their own so unless
         * RLIMIT_NPROC is checked after the user change and before
         * the cgi-script starts, RLIMIT_NPROC simply will not be enforced
         * for the cgi-scripts.
         *
         * So the code tracks if between fork and exec if an operation
         * occurs that could cause the RLIMIT_NPROC check to fail.  If
         * such an operation has happened re-check RLIMIT_NPROC.
         */


Answered-Question: I was trying to ask if anyone knows of a reason why
we can't just sanitize the rlimits of the process during suid exec?
Linus your guideline would appear to allow that behavior.  Unfortunately
that looks like it would break current usage of apache suexec.

Eric
