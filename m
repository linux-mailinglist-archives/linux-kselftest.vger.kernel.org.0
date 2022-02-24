Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D4B4C20FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 02:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiBXBd0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 20:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBXBdZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 20:33:25 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5449CB4;
        Wed, 23 Feb 2022 17:32:52 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:35060)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN2zx-00AMnv-Jv; Wed, 23 Feb 2022 18:32:49 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53688 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nN2zw-00EDEm-Bb; Wed, 23 Feb 2022 18:32:49 -0700
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
In-Reply-To: <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 23 Feb 2022 11:50:38 -0800")
References: <20220207121800.5079-1-mkoutny@suse.com>
        <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
        <20220215101150.GD21589@blackbody.suse.cz>
        <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
        <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org>
        <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 23 Feb 2022 19:32:41 -0600
Message-ID: <87ee3toxqe.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nN2zw-00EDEm-Bb;;;mid=<87ee3toxqe.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jQZBwXH9ZWGkbzMxdKBeobm1bR1k1t1k=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <linus@torvalds.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 635 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (1.8%), b_tie_ro: 10 (1.6%), parse: 1.55
        (0.2%), extract_message_metadata: 14 (2.2%), get_uri_detail_list: 3.0
        (0.5%), tests_pri_-1000: 14 (2.3%), tests_pri_-950: 1.29 (0.2%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 155 (24.4%), check_bayes:
        153 (24.1%), b_tokenize: 11 (1.8%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 3.8 (0.6%), b_tok_touch_all: 123 (19.4%), b_finish: 0.88
        (0.1%), tests_pri_0: 417 (65.8%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 12 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: How should rlimits, suid exec, and capabilities interact?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

The reason I want to change which user is charged with a process
(besides it making more sense in my head) is so that
"capable(CAP_SYS_RESOURCE)" can be used instead of the magic incantation
"(cred->user == INIT_USER)".

Today "capable(CAP_SYS_RESOURCE)" with respect to RLIMIT_NPROC is
effectively meaningless for suid programs because the of the mismatch of
charging the real user with the effective users credentials.

An accidental experiment happened in v5.14-rc1 in July when the ucount
rlimit code was merged.  It was only this last week when after Michal
Koutný discovered the discrepancy through code inspection I merged a
bug fix because the code was not preserving the existing behavior as
intended.


This behavior has existed in some form since Linux v1.0 when per user
process limits were added.

The original code in v1.0 was:
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

Does anyone know if choosing the real uid vs the effective uid for
accounting a users processes was a deliberate decision anywhere in the
history of Linux?



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
