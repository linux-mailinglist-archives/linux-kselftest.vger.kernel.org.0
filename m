Return-Path: <linux-kselftest+bounces-10457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F678CA5F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 03:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DD7B217AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16CBA53;
	Tue, 21 May 2024 01:51:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C763CF;
	Tue, 21 May 2024 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256271; cv=none; b=U22Zfuow76z5alnoLJH40Wn2xEO5r5Eq3WCogHDA89UvBmALedYG8evmU/nzmZG8lOPjI+9v2P1NzCncD35j4xmTco49anqRuCRmVOnxqUHguTQoBJi2cGeD8LnmmofWf5ivol9fynxC+qlyfoZsLaKjF9356uu1cEZdIW7OGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256271; c=relaxed/simple;
	bh=q5aRll7RQ/7WEH2ClridL6kzsaKT2gkajP4Ouav6gYI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qv9dKeOPUmqxKQEkdNjbuEoeqXGx+1Q5TqqQoPI1k/oYe0+JZ7tnRfoWZuMBDv912ym2ZTj2CMIL3gwS6vzG4PUwQiHmws5nvq93Io0sH933IU0qddnaTtfEPcHhZk1IpdC5ipDJSoALih112NdcQxv314wBcnNLKLlvd0r4+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34079C2BD10;
	Tue, 21 May 2024 01:51:10 +0000 (UTC)
Date: Mon, 20 May 2024 21:51:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuahkhan@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing/selftests: Fix kprobe event name test for
 .isra. functions
Message-ID: <20240520215148.287e417f@gandalf.local.home>
In-Reply-To: <20240521104919.c8fd7a91b4a9c0435d17017b@kernel.org>
References: <20240520205737.5085e53a@gandalf.local.home>
	<20240521104919.c8fd7a91b4a9c0435d17017b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 May 2024 10:49:19 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > It is listed twice. This causes the attached kprobe to it to fail which in
> > turn fails the test. Instead of just picking the function function that is
> > found in available_filter_functions, pick the first one that is listed
> > only once in available_filter_functions.
> >   
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Thanks Masami,

Shuah, can you take this through your tree?

Thanks,

-- Steve

