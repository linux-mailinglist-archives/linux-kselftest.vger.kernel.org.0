Return-Path: <linux-kselftest+bounces-36497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E737DAF878E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 08:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED93560337
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 06:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A2213237;
	Fri,  4 Jul 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmYAThTu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5D9143C69;
	Fri,  4 Jul 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751609068; cv=none; b=GjPIfq7IrJVqghYHdHKzVdvw5JHPJU6H1HqdlRlkAuzdNDbGvWDYl3uEHRD0294HvBT2JrOvZ/MjO+B6bD3Yx0f6nBvREjMDUIFF5q6STwyeIWChAS95oF6HYGYMyU4G6yResZMI/3uVU4eea7OOlTSeVjBsLlD1lUnf9p8e4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751609068; c=relaxed/simple;
	bh=MbmmL2t8dsm71Q6onEmIu1cU/JkCOwof0cSGAukp3K8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KB1HyUoljLu97mcXZAPwN2xz5sZFm1Ssx0LYyg9sFMzgFffQdoyzz+ScSUt806xLTLuNU4r6w3Ufr0UR6GFKEi+STK/fE4a+eFTVnxxH+tHX+sFVVA/wyZn8Xbdzv9Ha9R3i8IfzzR2StajIxbjuq1cc694Om/kqBTP+oNFeW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmYAThTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F1C4CEE3;
	Fri,  4 Jul 2025 06:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751609067;
	bh=MbmmL2t8dsm71Q6onEmIu1cU/JkCOwof0cSGAukp3K8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EmYAThTudppLgEq8+urhoX0wAoNDHQVmzlh5lAz8kQ2ScmdvFZdWnlzTrB9qBEs3w
	 LsP3vQICexL1d5VPGyva9PlH313TUMawGjRh/b5mc3eyJVvBTXqEoQkQj2tJLKW7o3
	 1uQmDxZTL1/VBsQW6FFZPWm/0KB7ndHY+aiU9LyhDVWhtBRUwJ07kvQktCQYXNpMVa
	 q10bSBoC/lbMPUDlAZ4IOg6yrAMCSliGBI3iKt/ge8UZOcsEFL5n7oPmt9h655ZPwt
	 w+4Z7WWjtASUOfem+5Ne+dksLzOiYVVWtbisMOefuZ6WOKmrY15ZX1K1ffJM4sY4iU
	 0LCcbJkRT1vDA==
Date: Fri, 4 Jul 2025 15:04:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: tracing: Use mutex_unlock for testing
 glob filter
Message-Id: <20250704150425.a8a82c7768e1c99ee272e585@kernel.org>
In-Reply-To: <20250703103039.3559a7e1@batman.local.home>
References: <175151678585.2149615.8702513393985992418.stgit@mhiramat.tok.corp.google.com>
	<175151680309.2149615.9795104805153538717.stgit@mhiramat.tok.corp.google.com>
	<20250703103039.3559a7e1@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Shuah,

Can you take this patch (fix) to your tree since this is
a fix for the selftest?

Thank you,

On Thu, 3 Jul 2025 10:30:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  3 Jul 2025 13:26:43 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since commit c5b6ababd21a ("locking/mutex: implement
> > mutex_trylock_nested") makes mutex_trylock() as an inlined
> > function if CONFIG_DEBUG_LOCK_ALLOC=y, we can not use
> > mutex_trylock() for testing the glob filter of ftrace.
> > 
> > Use mutex_unlock instead.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

