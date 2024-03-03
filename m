Return-Path: <linux-kselftest+bounces-5801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8C86F5C8
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33272819A9
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984467C40;
	Sun,  3 Mar 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7olhd2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002067A19;
	Sun,  3 Mar 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479330; cv=none; b=aXTeIwe0BiUNdvbpJuza/sWb+lxg5hq/3gCDY7lL0mi6cf5bqL0nMCqZl/w4tl4ckutCRo2WmYytkAsyd/DrJk0zs7DknCyUG0ecZiASYD9Pn9/cMHM/LkOSEr9jU3pND3Csj9ElSXYuJID2tAmHpBC7joMDURkqAKdEG+8TBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479330; c=relaxed/simple;
	bh=3dJAW3wkNjRrd5xa/cVWyf2MR5TgewIlm1wiSL8y5q4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nXXqpyUQdW+BxO9NNv+KPbc43GdrKBiW31SdhOtGvsMvhgNz9oRUD8YzBIrBL4EtJgkGe319kXoNYEPZ51Z3OPoNGCab11lRR/dnSp700YEoPHtfPFy9lr45xUm+Q5LBhGOLzhFyJPCOGrR6Ep0S720i5KbTQykjIsvo6cU5QPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7olhd2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29BBC433C7;
	Sun,  3 Mar 2024 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709479329;
	bh=3dJAW3wkNjRrd5xa/cVWyf2MR5TgewIlm1wiSL8y5q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s7olhd2mfDb0w4zQovdhx3ZlLw9h/Pp4pBhiJdgndbbFrjOTT2RDLdIWUHvQJTArx
	 DIqWx/DMoKgm5INW/tpmyr6WH0Eclm47x3P9Zg6X+k/mPx5hiv+l3sPb09xL52ViBk
	 4gJ0wdZIt/d31h5nE865wW6A35xsX615ap6YWabLN1a9ML1vVmsvZdtTUfrHeF/2ik
	 sDlUjzOOAJNPuUtTfGFw9mk4YFi8WQtXR0qbFqhXPUysmUuHMsfKPSmTTwxdnxqeMB
	 PtQ9oRk931gxYGmFq6+Kz6BN8gYj3B4EygjZ2EW/rjmY+poMlBcajINzeDAmkLQrd2
	 8dn3dpThDGsLw==
Date: Mon, 4 Mar 2024 00:22:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tracing/probes: Support function parameter
 access from return probe
Message-Id: <20240304002205.d0a213af1969fda8a82dafa7@kernel.org>
In-Reply-To: <20240229224134.55c1c36b@gandalf.local.home>
References: <170891987362.609861.6767830614537418260.stgit@devnote2>
	<Zd9eBn2FTQzYyg7L@krava>
	<20240229145139.a215085c44add62302463312@kernel.org>
	<20240229153855.6fe3fb454cf56eebc6ea9953@kernel.org>
	<20240229161320.978190f42dcc1a521c192e7d@kernel.org>
	<20240229175216.96bb2e16b510f81e3802ef23@kernel.org>
	<20240229224134.55c1c36b@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 22:41:34 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 29 Feb 2024 17:52:16 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Lol, I haven't allocate the entry data size when initialize rethook.
> > That's a bug.
> > Please try below.
> 
> I'll wait to review patches 5,6,7 as I'm guessing this will have a v3?

Ah, actually I pushed this fix separately because it is an actual
bug and may silently cause an issue in the selftest. I pushed it
in probes-fixes-v6.8-rc5.

Anyway, let me send v3 it with that fix.

Thank you,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

