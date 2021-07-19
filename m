Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1373CD6FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jul 2021 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbhGSOCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jul 2021 10:02:33 -0400
Received: from mail.efficios.com ([167.114.26.124]:53258 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhGSOCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jul 2021 10:02:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 46A85368E44;
        Mon, 19 Jul 2021 10:43:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 26RKPd2CIvGt; Mon, 19 Jul 2021 10:43:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 063BC36909B;
        Mon, 19 Jul 2021 10:43:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 063BC36909B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1626705791;
        bh=de0GThxO6PSlD37MzhGtHRKbYXX9HTffYP5G6p3CMdg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=aFjed2K3OyYgZKzXWrUAG6Jc1NXo/aeMCY8/7L/GSef5XVm2xNIM2go3EVmiQiLCJ
         9brYsup+v5p5VCDopV2ynTVTutKHKU7LEy2/otAMSRlQUIJXlIOlzNWwSW30ogMDcO
         dVVfqLAAJJ866PlJb2jlBZnK5ALubPYl1EVr8HgEcmVhdeLB3ibdS8fidFkoIYkqzQ
         eY7nBTPfPigwTTyLp1kfqCyVg7bGcBAiGssowmiKEJ83QMXC3UsoeYhhAFKiovD9Fl
         ZtTqZZuHWXjDJAB46RBaXwb+TzkkReJTkfYxNeBrYnLut6EH80IsnNuEUUMHmN7LaF
         xj50Ic6dgliIA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sf-mVCvsc1_g; Mon, 19 Jul 2021 10:43:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EB702368CE8;
        Mon, 19 Jul 2021 10:43:10 -0400 (EDT)
Date:   Mon, 19 Jul 2021 10:43:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Vincent Chen <vincent.chen@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <1257037909.25426.1626705790861.JavaMail.zimbra@efficios.com>
In-Reply-To: <1583733592-22873-3-git-send-email-vincent.chen@sifive.com>
References: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com> <1583733592-22873-3-git-send-email-vincent.chen@sifive.com>
Subject: Re: [PATCH V2 2/3] riscv: Add support for restartable sequence
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF89 (Linux)/8.8.15_GA_4059)
Thread-Topic: riscv: Add support for restartable sequence
Thread-Index: korcCokQEeN3DVoNTVQS7BBBu9PEUQ==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

----- On Mar 9, 2020, at 1:59 AM, Vincent Chen vincent.chen@sifive.com wrote:
[...]
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -234,6 +234,7 @@ static void handle_signal(struct ksignal *ksig, struct
> pt_regs *regs)
> 	sigset_t *oldset = sigmask_to_save();
> 	int ret;
> 
> +	rseq_signal_deliver(ksig, regs);
> 	/* Are we from a system call? */
> 	if (regs->cause == EXC_SYSCALL) {

[...]

As Al Viro pointed out on IRC, the rseq_signal_deliver() should go after syscall
restart handling, similarly to what is done on every other supported architecture.

Note that there is already an upstream commit derived on this non-upstream patch:

commit 9866d141a097 ("csky: Add support for restartable sequence")

which is broken in the same way.

I'm not sure why I was never CC'd on the csky patch. Considering that nobody
bothered to implement the rseq selftests for csky, I don't see how any of
this is tested. I would favor a revert of that commit until the testing glue
is contributed. Unfortunately, the csky commit has been upstream since v5.7.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
