Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881E3457159
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhKSPH0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 10:07:26 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:41824 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhKSPH0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 10:07:26 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:59486)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo5R7-002Hf7-5i; Fri, 19 Nov 2021 08:04:21 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35926 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo5R5-00CVBs-VE; Fri, 19 Nov 2021 08:04:20 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kyle Huey <me@kylehuey.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>
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
        <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
        <877dd5qfw5.fsf_-_@email.froward.int.ebiederm.org>
        <CAP045Aose7Lg_OE0-MijGBg27gWo+Sk3hbxuN3AtQ8OPC9w9+w@mail.gmail.com>
Date:   Fri, 19 Nov 2021 09:03:56 -0600
In-Reply-To: <CAP045Aose7Lg_OE0-MijGBg27gWo+Sk3hbxuN3AtQ8OPC9w9+w@mail.gmail.com>
        (Kyle Huey's message of "Thu, 18 Nov 2021 17:13:52 -0800")
Message-ID: <87r1bcp4pv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mo5R5-00CVBs-VE;;;mid=<87r1bcp4pv.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+b1KImkXCFkcQalCQRAXsz2WjlQf7929c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4554]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kyle Huey <me@kylehuey.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 649 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.02
        (0.2%), extract_message_metadata: 20 (3.0%), get_uri_detail_list: 1.76
        (0.3%), tests_pri_-1000: 37 (5.7%), tests_pri_-950: 1.46 (0.2%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-90: 108 (16.7%), check_bayes:
        107 (16.4%), b_tokenize: 8 (1.3%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 84 (12.9%), b_finish: 1.08
        (0.2%), tests_pri_0: 443 (68.3%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.97 (0.2%), tests_pri_10:
        3.5 (0.5%), tests_pri_500: 19 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] signal: Don't always set SA_IMMUTABLE for forced signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kyle Huey <me@kylehuey.com> writes:

> On Thu, Nov 18, 2021 at 2:05 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>>
>> Recently to prevent issues with SECCOMP_RET_KILL and similar signals
>> being changed before they are delivered SA_IMMUTABLE was added.
>>
>> Unfortunately this broke debuggers[1][2] which reasonably expect to be
>> able to trap synchronous SIGTRAP and SIGSEGV even when the target
>> process is not configured to handle those signals.
>>
>> Update force_sig_to_task to support both the case when we can
>> allow the debugger to intercept and possibly ignore the
>> signal and the case when it is not safe to let userspace
>> known about the signal until the process has exited.
>
> s/known/know/

Fixed.


>> Reported-by: Kyle Huey <me@kylehuey.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Cc: stable@vger.kernel.org
>> [1] https://lkml.kernel.org/r/CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com
>> [2] https://lkml.kernel.org/r/20211117150258.GB5403@xsang-OptiPlex-902
>
> This link doesn't work.

Shame.  I missed a trailing 0, but unfortunately that request did not go
to list that is archived on lore.  I will keep the link on the chance
the message winds up in a lore archive in the future.

Eric
