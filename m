Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F283B8A2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 23:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhF3VrY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 17:47:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46890 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhF3VrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 17:47:23 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lyi0o-00C7rX-Pk; Wed, 30 Jun 2021 15:44:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:45966 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lyi0n-007gGb-GG; Wed, 30 Jun 2021 15:44:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        kernel@collabora.com
References: <20201127193238.821364-1-krisman@collabora.com>
        <20201127193238.821364-4-krisman@collabora.com>
Date:   Wed, 30 Jun 2021 16:44:41 -0500
In-Reply-To: <20201127193238.821364-4-krisman@collabora.com> (Gabriel Krisman
        Bertazi's message of "Fri, 27 Nov 2020 14:32:34 -0500")
Message-ID: <8735szowmu.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lyi0n-007gGb-GG;;;mid=<8735szowmu.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19aQL09HEdJngXqT3ixbdywo5veaWkBBOQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4916]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Gabriel Krisman Bertazi <krisman@collabora.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 510 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 9 (1.7%), parse: 0.85 (0.2%),
         extract_message_metadata: 11 (2.2%), get_uri_detail_list: 1.23 (0.2%),
         tests_pri_-1000: 5 (1.0%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 54 (10.6%), check_bayes:
        52 (10.3%), b_tokenize: 6 (1.3%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 1.85 (0.4%), b_tok_touch_all: 35 (6.8%), b_finish: 0.72
        (0.1%), tests_pri_0: 414 (81.1%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v8 3/7] kernel: Implement selective syscall userspace redirection
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Why does do_syscal_user_dispatch call do_exit(SIGSEGV) and
do_exit(SIGSYS) instead of force_sig(SIGSEGV) and force_sig(SIGSYS)?

Looking at the code these cases are not expected to happen, so I would
be surprised if userspace depends on any particular behaviour on the
failure path so I think we can change this.

Is using do_exit in this way something you copied from seccomp?

The reason I am asking is that by using do_exit you deprive userspace
of the change to catch the signal handler and try and fix things.

Also by using do_exit only a single thread of a multi-thread application
is terminated which seems wrong.

I am asking because I am going through the callers of do_exit so I can
refactor things and clean things up and this use just looks wrong.

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

<snip>

> +bool do_syscall_user_dispatch(struct pt_regs *regs)
> +{
> +	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> +	char state;
> +
> +	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
> +		return false;
> +
> +	if (unlikely(arch_syscall_is_vdso_sigreturn(regs)))
> +		return false;
> +
> +	if (likely(sd->selector)) {
> +		/*
> +		 * access_ok() is performed once, at prctl time, when
> +		 * the selector is loaded by userspace.
> +		 */
> +		if (unlikely(__get_user(state, sd->selector)))
> +			do_exit(SIGSEGV);
                        ^^^^^^^^^^^^^^^^

I think it makes more sense if the code does:

		if (unlikely(__get_user(state, sd->selector))) {
                	force_sig(SIGSEGV);
                        return true;
                }

> +
> +		if (likely(state == PR_SYS_DISPATCH_OFF))
> +			return false;
> +
> +		if (state != PR_SYS_DISPATCH_ON)
> +			do_exit(SIGSYS);
                        ^^^^^^^^^^^^^^^
> +	}
> +
> +	sd->on_dispatch = true;
> +	syscall_rollback(current, regs);
> +	trigger_sigsys(regs);
> +
> +	return true;
> +}

Eric
