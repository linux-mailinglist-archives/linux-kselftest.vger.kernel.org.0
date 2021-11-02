Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B6443577
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 19:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhKBSZF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 14:25:05 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57560 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhKBSZE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 14:25:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:38068)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhyQW-00AJ67-Tr; Tue, 02 Nov 2021 12:22:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37228 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhyQV-00EizZ-01; Tue, 02 Nov 2021 12:22:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <YXrN+Hnl9pSOsWlA@arighi-desktop> <202110280955.B18CB67@keescook>
        <878rydm56l.fsf@disp2133> <202110281136.5CE65399A7@keescook>
        <8735okls76.fsf@disp2133> <202110290755.451B036CE9@keescook>
Date:   Tue, 02 Nov 2021 13:22:19 -0500
In-Reply-To: <202110290755.451B036CE9@keescook> (Kees Cook's message of "Fri,
        29 Oct 2021 07:58:02 -0700")
Message-ID: <87y2665sf8.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mhyQV-00EizZ-01;;;mid=<87y2665sf8.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/dOLwlXmVI7aCH/YYnczuKSEUIah1vXvg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4933]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1377 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 14 (1.0%), b_tie_ro: 12 (0.8%), parse: 1.56
        (0.1%), extract_message_metadata: 18 (1.3%), get_uri_detail_list: 1.53
        (0.1%), tests_pri_-1000: 19 (1.4%), tests_pri_-950: 1.64 (0.1%),
        tests_pri_-900: 1.33 (0.1%), tests_pri_-90: 110 (8.0%), check_bayes:
        105 (7.7%), b_tokenize: 7 (0.5%), b_tok_get_all: 6 (0.5%),
        b_comp_prob: 2.5 (0.2%), b_tok_touch_all: 86 (6.2%), b_finish: 1.16
        (0.1%), tests_pri_0: 1195 (86.8%), check_dkim_signature: 0.90 (0.1%),
        check_dkim_adsp: 3.7 (0.3%), poll_dns_idle: 0.46 (0.0%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 9 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: selftests: seccomp_bpf failure on 5.15
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Oct 28, 2021 at 05:06:53PM -0500, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Thu, Oct 28, 2021 at 12:26:26PM -0500, Eric W. Biederman wrote:
>> 
>> Is it a problem that the debugger can see the signal if the process does
>> not?
>
> Right, I'm trying to understand that too. However, my neighbor just lost
> power. :|
>
> What I was in the middle of checking was what ptrace "sees" going
> through a fatal SIGSYS; my initial debugging attempts were weird.

Kees have you regained power and had a chance to see my SA_IMMUTABLE
patch?

Does what I implemented seem like it will work for you?

I think it is a solid and simple solution to a pair of problems with my
change to use the ordinary coredump path for seccomp.  But I would very
much love to hear it seems reasonable to you, as you were looking at the
problem as well.

Eric
