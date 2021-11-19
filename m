Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624F745716E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhKSPLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 10:11:52 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:44092 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhKSPLw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 10:11:52 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:45026)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo5VR-00FJ72-L6; Fri, 19 Nov 2021 08:08:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36048 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo5VP-005oNa-1S; Fri, 19 Nov 2021 08:08:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com
References: <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
        <87k0h6334w.fsf@email.froward.int.ebiederm.org>
        <202111171341.41053845C3@keescook>
        <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
        <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
        <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
        <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
        <202111171728.D85A4E2571@keescook>
        <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
        <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
        <202111181553.A4FDEB1@keescook>
Date:   Fri, 19 Nov 2021 09:08:39 -0600
In-Reply-To: <202111181553.A4FDEB1@keescook> (Kees Cook's message of "Thu, 18
        Nov 2021 15:54:02 -0800")
Message-ID: <87k0h4p4i0.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mo5VP-005oNa-1S;;;mid=<87k0h4p4i0.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196d9OtmX5Dp0z9U9O8+EGR09fRQOafZdY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1634 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.34
        (0.1%), extract_message_metadata: 15 (0.9%), get_uri_detail_list: 1.42
        (0.1%), tests_pri_-1000: 16 (1.0%), tests_pri_-950: 1.82 (0.1%),
        tests_pri_-900: 1.72 (0.1%), tests_pri_-90: 299 (18.3%), check_bayes:
        295 (18.0%), b_tokenize: 7 (0.5%), b_tok_get_all: 171 (10.5%),
        b_comp_prob: 2.0 (0.1%), b_tok_touch_all: 109 (6.7%), b_finish: 1.81
        (0.1%), tests_pri_0: 1272 (77.9%), check_dkim_signature: 0.89 (0.1%),
        check_dkim_adsp: 3.7 (0.2%), poll_dns_idle: 0.33 (0.0%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] signal: Don't always set SA_IMMUTABLE for forced signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Nov 18, 2021 at 04:04:58PM -0600, Eric W. Biederman wrote:
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 7c4b7ae714d4..02058c983bd6 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1298,6 +1298,12 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
>>  	return ret;
>>  }
>>  
>> +enum sig_handler {
>> +	HANDLER_CURRENT, /* If reachable use the current handler */
>> +	HANDLER_SIG_DFL, /* Always use SIG_DFL handler semantics */
>> +	HANDLER_EXIT,	 /* Only visible as the proces exit code */
>
> Oh, I just noticed this typo "proces" -> "process"

Fixed.  Thank you.

Eric
