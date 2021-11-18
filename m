Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0E45653B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 22:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhKRWBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 17:01:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36338 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhKRWBM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 17:01:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:46794)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpQ2-00115C-O4; Thu, 18 Nov 2021 14:58:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:52636 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnpQ1-0048Wm-LN; Thu, 18 Nov 2021 14:58:10 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>,
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
        Kees Cook <keescook@chromium.org>,
        Oliver Sang <oliver.sang@intel.com>, lkp@lists.01.org,
        lkp@intel.com
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
Date:   Thu, 18 Nov 2021 15:58:02 -0600
In-Reply-To: <202111171728.D85A4E2571@keescook> (Kees Cook's message of "Wed,
        17 Nov 2021 17:32:20 -0800")
Message-ID: <87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnpQ1-0048Wm-LN;;;mid=<87h7c9qg7p.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX188U8Ali6pt3gI0MiWxDnFXisSnqx50bZA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4859]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 441 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 12 (2.8%), b_tie_ro: 10 (2.3%), parse: 1.67
        (0.4%), extract_message_metadata: 5 (1.1%), get_uri_detail_list: 1.79
        (0.4%), tests_pri_-1000: 6 (1.4%), tests_pri_-950: 1.74 (0.4%),
        tests_pri_-900: 1.46 (0.3%), tests_pri_-90: 126 (28.5%), check_bayes:
        124 (28.0%), b_tokenize: 14 (3.1%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 3.7 (0.8%), b_tok_touch_all: 93 (21.0%), b_finish: 1.08
        (0.2%), tests_pri_0: 264 (59.9%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 1.14 (0.3%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/2] SA_IMMUTABLE fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


SA_IMMUTABLE fixed issues with force_sig_seccomp and the introduction
for force_sig_fatal where the exit previously could not be interrupted
but now it can.  Unfortunately it added that behavior to all force_sig
functions under the right conditions which debuggers usage of SIG_TRAP
and debuggers handling of SIGSEGV.

Solve that by limiting SA_IMMUTABLE to just the cases that historically
debuggers have not been able to intercept.

The first patch changes force_sig_info_to_task to take a flag
that requests which behavior is desired.

The second patch adds force_exit_sig which replaces force_fatal_sig
in the cases where historically userspace would only find out about
the ``signal'' after the process has exited.

The first one with the hunk changing force_fatal_sig removed should be
suitable for backporting to v5.15. v5.15 does not implement
force_fatal_sig.

This should be enough to fix the regressions.

Kyle if you can double check me that I have properly fixed these issues
that would be appreciated.

Any other review or suggestions to improve the names would be
appreciated.  I think I have named things reasonably well but I am very
close to the code so it is easy for me to miss things.

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

Eric
