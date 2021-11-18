Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6D45603C
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhKRQP5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 11:15:57 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52056 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhKRQP4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 11:15:56 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38314)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnk1u-000QC2-H2; Thu, 18 Nov 2021 09:12:54 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:43626 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnk1t-009y16-0L; Thu, 18 Nov 2021 09:12:54 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Robert O'Callahan <rocallahan@gmail.com>
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
        <202111171049.3F9C5F1@keescook>
        <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
        <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
        <87k0h6334w.fsf@email.froward.int.ebiederm.org>
        <202111171341.41053845C3@keescook>
        <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
        <CAP045ApYXxhiAfmn=fQM7_hD58T-yx724ctWFHO4UAWCD+QapQ@mail.gmail.com>
        <CAHk-=wiCRbSvUi_TnQkokLeM==_+Tow0GsQXnV3UYwhsxirPwg@mail.gmail.com>
        <CAP045AoqssLTKOqse1t1DG1HgK9h+goG8C3sqgOyOV3Wwq+LDA@mail.gmail.com>
        <202111171728.D85A4E2571@keescook>
Date:   Thu, 18 Nov 2021 10:10:18 -0600
In-Reply-To: <202111171728.D85A4E2571@keescook> (Kees Cook's message of "Wed,
        17 Nov 2021 17:32:20 -0800")
Message-ID: <875ysp1m39.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnk1t-009y16-0L;;;mid=<875ysp1m39.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19HyRikhcpll4xD3sce4HlUZw1iTZOuqps=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 424 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 10 (2.3%), parse: 0.88
        (0.2%), extract_message_metadata: 12 (2.8%), get_uri_detail_list: 1.32
        (0.3%), tests_pri_-1000: 14 (3.2%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 127 (30.0%), check_bayes:
        124 (29.3%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 3.2 (0.8%), b_tok_touch_all: 101 (23.8%), b_finish: 1.05
        (0.2%), tests_pri_0: 243 (57.4%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.30 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Nov 17, 2021 at 05:20:33PM -0800, Kyle Huey wrote:
>> Yeah that's one way to solve the problem. I think you're right that
>> fundamentally the problem here is that what SECCOMP_RET_KILL wants is
>> not really a signal. To the extent that it wants a signal, what it
>> really wants is SIGKILL, and the problem here is the code trying to
>> act like SIGKILL but call it SIGSYS. I assume the ship for fixing that
>> sailed years ago though.
>
> Yeah, this was IIRC, a specific design choice (to distinguish a seccomp
> KILL from a SIGKILL), as desired by the sandboxing folks, and instead
> of using two different signals (one for KILL and one for TRAP), both
> used SIGSYS, with the KILL variant being uncatchable.

I see a general consensus on how to fix the regression.  Linus patch
plus some tweaks.  I will get to work on that today.

For v5.15 I think all that needs to get fixed is what Linus fixed
and the force_sigsegv case.  That is my priority.



For v5.16-rc1+ the instances that became force_fatal_signal need
a careful review to figure out which semantics we want.


Having a clear distinction between which forced signals we can let the
debugger intercept and which ones we can not seems to be what needs to
be added.


Kyle thank you for your explanation of what breaks.  For future kernels
I do need to do some work in this area and I will copy on the patches
going forward.  In particular I strongly suspect that changing the
sigaction and blocked state of the signal for these synchronous signals
is the wrong thing to do, especially if the process is not killed.  I
want to find another solution that does not break things but that also
does not change the program state behind the programs back so things
work differently under the debugger.

Eric

