Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7F4571DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 16:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhKSPpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 10:45:03 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50880 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhKSPpC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 10:45:02 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:60492)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo61W-00FMjW-VD; Fri, 19 Nov 2021 08:41:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37662 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mo61U-005uJh-P3; Fri, 19 Nov 2021 08:41:58 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
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
        kbuild test robot <lkp@intel.com>,
        Kyle Huey <me@kylehuey.com>
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
        <CAP045Ap=1U07er7Y2XO9wmiRtKLoKL4u8zek48ROU668=G9D3A@mail.gmail.com>
Date:   Fri, 19 Nov 2021 09:41:49 -0600
In-Reply-To: <CAP045Ap=1U07er7Y2XO9wmiRtKLoKL4u8zek48ROU668=G9D3A@mail.gmail.com>
        (Kyle Huey's message of "Thu, 18 Nov 2021 17:12:23 -0800")
Message-ID: <87r1bcnoea.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mo61U-005uJh-P3;;;mid=<87r1bcnoea.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19k0jyUKHa4YvJuJv+kOTET/i526bgHId0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_TooManySym_02,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4530]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1365 ms - load_scoreonly_sql: 0.16 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 8 (0.6%), parse: 1.60 (0.1%),
         extract_message_metadata: 4.6 (0.3%), get_uri_detail_list: 1.68
        (0.1%), tests_pri_-1000: 6 (0.4%), tests_pri_-950: 1.77 (0.1%),
        tests_pri_-900: 1.41 (0.1%), tests_pri_-90: 58 (4.2%), check_bayes: 56
        (4.1%), b_tokenize: 10 (0.7%), b_tok_get_all: 8 (0.6%), b_comp_prob:
        2.8 (0.2%), b_tok_touch_all: 31 (2.2%), b_finish: 1.17 (0.1%),
        tests_pri_0: 1252 (91.7%), check_dkim_signature: 0.85 (0.1%),
        check_dkim_adsp: 3.7 (0.3%), poll_dns_idle: 0.99 (0.1%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 16 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] SA_IMMUTABLE fixes for v5.16-rc2
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Linus,

Please pull the SA_IMMUTABLE-fixes-for-v5.16-rc2 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git SA_IMMUTABLE-fixes-for-v5.16-rc2

  HEAD: fcb116bc43c8c37c052530ead79872f8b2615711 signal: Replace force_fatal_sig with force_exit_sig when in doubt

This is just a small set of changes where debuggers were no longer able
to intercept synchronous SIGTRAP and SIGSEGV.  This is essentially the
change you suggested with all of i's dotted and the t's crossed so that
ptrace can intercept all of the cases it has been able to intercept the
past, and all of the cases that made it to exit without giving ptrace a
chance still don't give ptrace a chance.

This change[1] has been tested by both Kyle and Kees.

Eric W. Biederman (2):
      signal: Don't always set SA_IMMUTABLE for forced signals
      signal: Replace force_fatal_sig with force_exit_sig when in doubt

 arch/m68k/kernel/traps.c              |  2 +-
 arch/powerpc/kernel/signal_32.c       |  2 +-
 arch/powerpc/kernel/signal_64.c       |  4 ++--
 arch/s390/kernel/traps.c              |  2 +-
 arch/sparc/kernel/signal_32.c         |  4 ++--
 arch/sparc/kernel/windows.c           |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/kernel/vm86_32.c             |  2 +-
 include/linux/sched/signal.h          |  1 +
 kernel/entry/syscall_user_dispatch.c  |  4 ++--
 kernel/signal.c                       | 36 ++++++++++++++++++++++++++++-------
 11 files changed, 42 insertions(+), 19 deletions(-)

[1]: https://lkml.kernel.org/r/87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org

Eric
