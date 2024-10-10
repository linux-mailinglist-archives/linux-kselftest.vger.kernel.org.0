Return-Path: <linux-kselftest+bounces-19466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB3998E58
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 19:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A391F22C27
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DC119ABCE;
	Thu, 10 Oct 2024 17:31:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305218950A;
	Thu, 10 Oct 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581501; cv=none; b=cMohpbtEKFqPwHFSex9CuoQviflhW19OyAdgJCZTIayFEj02rozDbnyKw+iIkq+C5NPjWiUxrK0NItpMMDIF8+Q4WgdsFd0/Y8xdLAoe74g0B9EBX3Mib//r0zy2knTQEWOhccNLNPyB2TaAUrSBlB7Qu5k1wvMmDvRbUzALC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581501; c=relaxed/simple;
	bh=5KJvGciqL/2QEQndX3vFDA3rHY16clUl0xu0xROjom4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1DLFHdiX55WXMsDfnSxFwaBeADB5qtMTIGLiiLlZg/H3bot4VipTAynJlH8wtpu0E5XLe3qFCGcE7A+utKEai1Z+ZTbXHFh2SqCiBpwitqTCaU7O2reQtLSKnoxXpU3PHYgDtvJHoWSTLOASJes32B52EA/H2i4a6E3LBpnqeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEAEC4CEC5;
	Thu, 10 Oct 2024 17:31:40 +0000 (UTC)
Date: Thu, 10 Oct 2024 13:31:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] ftrace/selftest: Test combination of function_graph
 tracer and function profiler
Message-ID: <20241010133147.16058193@gandalf.local.home>
In-Reply-To: <63a7811c-c2cb-472f-bfa1-3b45bc65da10@linuxfoundation.org>
References: <20241004145618.18436d7e@gandalf.local.home>
	<20241008093314.8b263b6bd2e23c6a8345b65f@kernel.org>
	<63a7811c-c2cb-472f-bfa1-3b45bc65da10@linuxfoundation.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 11:04:43 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 10/7/24 18:33, Masami Hiramatsu (Google) wrote:
> > On Fri, 4 Oct 2024 14:56:18 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> >> From: Steven Rostedt <rostedt@goodmis.org>
> >>
> >> Masami reported a bug when running function graph tracing then the
> >> function profiler. The following commands would cause a kernel crash:
> >>
> >>    # cd /sys/kernel/tracing/
> >>    # echo function_graph > current_tracer
> >>    # echo 1 > function_profile_enabled
> >>
> >> In that order. Create a test to test this two to make sure this does not
> >> come back as a regression.
> >>
> >> Link: https://lore.kernel.org/172398528350.293426.8347220120333730248.stgit@devnote2
> >>  
> > 
> > Looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Thanks!
> >   
> >> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Steve, Would you like me take this one through my tree?
>

Yes please.

Thanks Shuah!

-- Steve

