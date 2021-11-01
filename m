Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC76442367
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 23:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhKAWav (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 18:30:51 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51480 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhKAWau (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 18:30:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:43408)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhfmq-0089EF-0D; Mon, 01 Nov 2021 16:28:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:38348 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhfmo-003ACD-IG; Mon, 01 Nov 2021 16:28:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <YXrN+Hnl9pSOsWlA@arighi-desktop> <202110280955.B18CB67@keescook>
        <878rydm56l.fsf@disp2133> <202110281136.5CE65399A7@keescook>
        <87k0hvkgvj.fsf_-_@disp2133> <YX7VA1JZaYkTQeSi@arighi-desktop>
Date:   Mon, 01 Nov 2021 17:28:07 -0500
In-Reply-To: <YX7VA1JZaYkTQeSi@arighi-desktop> (Andrea Righi's message of
        "Sun, 31 Oct 2021 18:40:19 +0100")
Message-ID: <87tugva4ug.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mhfmo-003ACD-IG;;;mid=<87tugva4ug.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/mPaO70nxwN5GBKRBuCc1ZdDoL/zlKqq4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4912]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrea Righi <andrea.righi@canonical.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 333 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.0 (1.2%), b_tie_ro: 2.7 (0.8%), parse: 0.66
        (0.2%), extract_message_metadata: 11 (3.3%), get_uri_detail_list: 1.45
        (0.4%), tests_pri_-1000: 11 (3.4%), tests_pri_-950: 1.02 (0.3%),
        tests_pri_-900: 0.84 (0.3%), tests_pri_-90: 53 (15.8%), check_bayes:
        51 (15.5%), b_tokenize: 5 (1.6%), b_tok_get_all: 7 (2.1%),
        b_comp_prob: 1.55 (0.5%), b_tok_touch_all: 35 (10.5%), b_finish: 0.72
        (0.2%), tests_pri_0: 241 (72.4%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 7 (2.2%), poll_dns_idle: 0.16 (0.0%), tests_pri_10:
        1.66 (0.5%), tests_pri_500: 6 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

> On Fri, Oct 29, 2021 at 10:09:04AM -0500, Eric W. Biederman wrote:
>> 
>> As Andy pointed out that there are races between
>> force_sig_info_to_task and sigaction[1] when force_sig_info_task.  As
>> Kees discovered[2] ptrace is also able to change these signals.
>> 
>> In the case of seeccomp killing a process with a signal it is a
>> security violation to allow the signal to be caught or manipulated.
>> 
>> Solve this problem by introducing a new flag SA_IMMUTABLE that
>> prevents sigaction and ptrace from modifying these forced signals.
>> This flag is carefully made kernel internal so that no new ABI is
>> introduced.
>> 
>> Longer term I think this can be solved by guaranteeing short circuit
>> delivery of signals in this case.  Unfortunately reliable and
>> guaranteed short circuit delivery of these signals is still a ways off
>> from being implemented, tested, and merged.  So I have implemented a much
>> simpler alternative for now.
>> 
>> [1] https://lkml.kernel.org/r/b5d52d25-7bde-4030-a7b1-7c6f8ab90660@www.fastmail.com
>> [2] https://lkml.kernel.org/r/202110281136.5CE65399A7@keescook
>> Cc: stable@vger.kernel.org
>> Fixes: 307d522f5eb8 ("signal/seccomp: Refactor seccomp signal and coredump generation")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>
> FWIW I've tested this patch and I confirm that it fixes the failure that
> I reported with the seccomp_bpf selftest.
>
> Tested-by: Andrea Righi <andrea.righi@canonical.com>

Sigh.  Except for the extra 0 in the definition of SA_IMMUTABLE
that caused it to conflict with the x86 specific signal numbers.

Eric
