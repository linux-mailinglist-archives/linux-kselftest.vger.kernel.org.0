Return-Path: <linux-kselftest+bounces-6915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B8892B34
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 13:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C21B21071
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03B37714;
	Sat, 30 Mar 2024 12:28:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF6EBB;
	Sat, 30 Mar 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711801681; cv=none; b=XMC/96MZSbgwj61e0gdowqy0FCkjyu42MF09+oZiehSzpXvXiQVif54H/QB7/7yjK1rzsj7HeoPAFMnOzD6V2AwAjUVxit3L3JxPr5vYhgR/ECEEBgtTqUEKtIfSHrSC4sSOLYRLy9SOuq8HJq5lL8u6QAzrzO2majlhjCWz12w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711801681; c=relaxed/simple;
	bh=+XibKb/dVHl63f9D33WQCt1jS1SK+C5P2v4d73y4tCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUlyYf7p366bQRa3JZqk4Cp6bt37v50Ad3tUe7DYPNyanyqj99e1dCTiSTgXuvgwT+fSzrSs80v6G5q+b6u+2UarYDQe0HTRHd0TzZRnzRuGeTC0ForTLXT+Bg6hepPoE3PO+qDKaEuJdXYoZLRM0KjuONFa5sumGwDZErecWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0898C433F1;
	Sat, 30 Mar 2024 12:27:56 +0000 (UTC)
Date: Sat, 30 Mar 2024 08:27:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>, Alexei
 Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet
 <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-riscv
 <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add
 support to record and check the accessed args
Message-ID: <20240330082755.1cbeb8c6@rorschach.local.home>
In-Reply-To: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
	<20240311093526.1010158-2-dongmenglong.8@bytedance.com>
	<CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
	<CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
	<CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
	<CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
	<CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
	<CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
	<CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
	<CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
	<CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
	<20240328111330.194dcbe5@gandalf.local.home>
	<CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 16:28:33 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> I thought I'll just ask instead of digging through code, sorry for
> being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
> before function execution to a return probe (fexit/kretprobe)? I.e.,
> how hard is it to pass input function arguments to a kretprobe? That's
> the biggest advantage of fexit over kretprobe, and if we can make
> these original pt_regs/ftrace_regs available to kretprobe, then
> multi-kretprobe will effectively be this multi-fexit.

This should be possible with the updates that Masami is doing with the
fgraph code.

-- Steve

