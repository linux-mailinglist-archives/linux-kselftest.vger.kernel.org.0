Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25DB43E752
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 19:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhJ1R3C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 13:29:02 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37354 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhJ1R3C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 13:29:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:57008)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg9Ag-005L5u-IP; Thu, 28 Oct 2021 11:26:34 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:45048 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mg9Af-002PQl-Id; Thu, 28 Oct 2021 11:26:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <YXrN+Hnl9pSOsWlA@arighi-desktop> <202110280955.B18CB67@keescook>
Date:   Thu, 28 Oct 2021 12:26:26 -0500
In-Reply-To: <202110280955.B18CB67@keescook> (Kees Cook's message of "Thu, 28
        Oct 2021 09:56:12 -0700")
Message-ID: <878rydm56l.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mg9Af-002PQl-Id;;;mid=<878rydm56l.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19RQNkvCuNUQim9XPRcghzWw+Dpd4ik0TE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 421 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.2%), parse: 0.84 (0.2%),
         extract_message_metadata: 12 (2.9%), get_uri_detail_list: 1.82 (0.4%),
         tests_pri_-1000: 13 (3.1%), tests_pri_-950: 1.21 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 65 (15.5%), check_bayes:
        64 (15.2%), b_tokenize: 8 (1.9%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 42 (10.0%), b_finish: 0.82
        (0.2%), tests_pri_0: 297 (70.5%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 0.46 (0.1%), tests_pri_10:
        2.5 (0.6%), tests_pri_500: 14 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: selftests: seccomp_bpf failure on 5.15
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Oct 28, 2021 at 06:21:12PM +0200, Andrea Righi wrote:
>> The following sub-tests are failing in seccomp_bpf selftest:
>> 
>> 18:56:54 DEBUG| [stdout] # selftests: seccomp: seccomp_bpf
>> ...
>> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.ptrace.kill_after ...
>> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (0)
>> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (2) == msg (1)
>> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:2023:kill_after:Expected entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY : PTRACE_EVENTMSG_SYSCALL_EXIT (1) == msg (2)
>> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 12)
>> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.ptrace.kill_after
>> ...
>> 18:56:57 DEBUG| [stdout] # #  RUN           TRACE_syscall.seccomp.kill_after ...
>> 18:56:57 DEBUG| [stdout] # # seccomp_bpf.c:1547:kill_after:Expected !ptrace_syscall (1) == IS_SECCOMP_EVENT(status) (0)
>> 18:56:57 DEBUG| [stdout] # # kill_after: Test exited normally instead of by signal (code: 0)
>> 18:56:57 DEBUG| [stdout] # #          FAIL  TRACE_syscall.seccomp.kill_after
>> 18:56:57 DEBUG| [stdout] # not ok 80 TRACE_syscall.seccomp.kill_after
>> ...
>> 18:56:57 DEBUG| [stdout] # # FAILED: 85 / 87 tests passed.
>> 18:56:57 DEBUG| [stdout] # # Totals: pass:85 fail:2 xfail:0 xpass:0 skip:0 error:0
>> 18:56:57 DEBUG| [stdout] not ok 1 selftests: seccomp: seccomp_bpf # exit=1
>> 
>> I did some bisecting and found that the failures started to happen with:
>> 
>>  307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")
>> 
>> Not sure if the test needs to be fixed after this commit, or if the
>> commit is actually introducing an issue. I'll investigate more, unless
>> someone knows already what's going on.
>
> Ah thanks for noticing; I will investigate...


I just did a quick read through of the test and while
I don't understand everything having a failure seems
very weird.


I don't understand the comment:
/* Tracer will redirect getpid to getppid, and we should die. */

As I think what happens is it the bpf programs loads the signal
number.  Tests to see if the signal number if GETPPID and allows
that system call and causes any other system call to be terminated.

Which being single threaded would seem to cause the kernel  to execute
the changed code.

How there kernel at that point is having the process exit with anything
except SIGSYS I am not immediately seeing.

The logic is the same as that for SECCOMP_RET_TRAP is there a test for
that, that is also failing?

How do you run that test anyway?

Eric

