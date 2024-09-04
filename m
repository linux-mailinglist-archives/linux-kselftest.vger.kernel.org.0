Return-Path: <linux-kselftest+bounces-17150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 919FB96C3EC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5F91F25DA0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EAF1DFE34;
	Wed,  4 Sep 2024 16:19:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87F1DEFDF;
	Wed,  4 Sep 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466796; cv=none; b=nAMsYnCurAPSXFYHpJ/WcVwl1ufXBJ0CIqbPrMAZWJVk0ShZeiimkGVIF9P0wTjQKzAVtY1Yzlv9UHT172+MiU2Nr8ZCp6CFxbvZU3vDmkV4eSZ+Liq+dIT5vCUwXQDXUoL8/u20NNIrJxmcGB/heIIhlFeMwSIph9HfP6ypwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466796; c=relaxed/simple;
	bh=LZt1qw0xtaBFFhAesFiNaQUQMrbWWv3ufVYvCTinRRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOahHq4WYaCJwbnoeCwHE4b0pEHIjG05TvSiVF+Od+Yjel1NUDi4UHYSkPySsZmntZjhzYyBJ7Bx0Xr7OYYtwZ91ryS566azAN7MsS4Fcu8kyt5+AFlsLFhtHHd9oFJ6DfU5TC2u6KdGBAWyyKdmx0TvXZ6pdgol5N1OdZJpzwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE05C4CEC2;
	Wed,  4 Sep 2024 16:19:55 +0000 (UTC)
Date: Wed, 4 Sep 2024 12:20:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Fix eventfs ownership testcase to
 find mount point
Message-ID: <20240904122055.71c4f38c@gandalf.local.home>
In-Reply-To: <172546382097.224182.6471842111781551515.stgit@devnote2>
References: <172546382097.224182.6471842111781551515.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 00:30:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix eventfs ownership testcase to find mount point if stat -c "%m" failed.
> This can happen on the system based on busybox. In this case, this will
> try to use the current working directory, which should be a tracefs top
> directory (and eventfs is mounted as a part of tracefs.)
> If it does not work, the test is skipped as UNRESOLVED because of
> the environmental problem.
> 
> Fixes: ee9793be08b1 ("tracing/selftests: Add ownership modification tests for eventfs")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

