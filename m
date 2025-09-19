Return-Path: <linux-kselftest+bounces-41941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8598DB895F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D25C7E4C60
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC29A30ACF1;
	Fri, 19 Sep 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ5NvNhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007D307486;
	Fri, 19 Sep 2025 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758283827; cv=none; b=Mz1UJW1Xo/rQ78M/zGCVYaQWN6/Cqz975Tb2EFxfIpv9y0iedVaouL5O6rl8cI9RbLBhFtCUose/aktCpQe3XVFFEO6AVl/eaYQor3/5l0Q1rSex9RGFdcckLeLjbF3Thk0bQrsbGL0hv0/QbZMTQ2lRgu33Q5CbMi8l36cmB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758283827; c=relaxed/simple;
	bh=7y5z6Pm9bVGvOL0l73IbXsYV7qMSg09CFWPE1ABf1e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVeUb20NkSrMZs21jMx/qm6FR+0curZbZcSeWz6WpOWKFT+gSU7bzxgi3lOcT6GePHPLtzX50eQ/I4Rz7ztsGigkyYiB58tcZeYLtyY6l0bCKKL7DQbVTVRqrtuk6pLkHtxhyx6K0Vky6ncN8V7LkMR6a/p9DS/XNYuqAxnGhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ5NvNhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C7C4CEF0;
	Fri, 19 Sep 2025 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758283827;
	bh=7y5z6Pm9bVGvOL0l73IbXsYV7qMSg09CFWPE1ABf1e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZ5NvNhb0Ine3bHnctf3ImXhWroL8J+izK9rZ990OtD2XKPvaL/hrBwf/yTgKNkG/
	 o8p2jBwn+iSaUemFJu9K+JcpCviki26rj6Q1U+EYrSlK4mvMVAcV8429xOytMvA/jz
	 jeJFiUNW1jdaAPxxuki3NDAdcmFL+Q8X/45YVRu/JvZNJgjM7LXHp5XFp6UnHTyvrG
	 6VeOZ5y4wasoyZxF2WLGkrxOcgZbRszWlApi6C+CevZPvfK67nDIQzgNDJegGqmtZl
	 p/8Q3AxjIZCdK4GjUPS+lq+KjAzcB9DpElVcBcQZF0P0Kk9Kol5JYWKV63Wc5MetDh
	 9DPgzHMXcWjUw==
Date: Fri, 19 Sep 2025 14:10:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, 
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>, 
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, jannh@google.com, Andrew Morton <akpm@linux-foundation.org>, 
	Yury Khrustalev <yury.khrustalev@arm.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH v21 4/8] fork: Add shadow stack support to clone3()
Message-ID: <20250919-unredlich-lohnkampf-d3d0836baeec@brauner>
References: <20250916-clone3-shadow-stack-v21-0-910493527013@kernel.org>
 <20250916-clone3-shadow-stack-v21-4-910493527013@kernel.org>
 <aMv9XRq_sAQbQwjI@willie-the-truck>
 <aMwtdtRHT7oHhYLf@willie-the-truck>
 <21954e72-94e9-433a-a155-222c9052d4c6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21954e72-94e9-433a-a155-222c9052d4c6@sirena.org.uk>

On Thu, Sep 18, 2025 at 06:56:02PM +0100, Mark Brown wrote:
> On Thu, Sep 18, 2025 at 05:04:06PM +0100, Will Deacon wrote:
> > On Thu, Sep 18, 2025 at 01:38:53PM +0100, Will Deacon wrote:
> 
> > > It would be great if Christian could give this the thumbs up, given that
> > > it changes clone3(). I think the architecture parts are all ready at this
> > > point.
> 
> > ah, I may have spoken too soon :/
> 
> Well, there's also the fact that this is based on the vfs tree (or would
> have conflicts with it).
> 
> > Catalin pointed me at this glibc thread:
> 
> > https://marc.info/?l=glibc-alpha&m=175811917427562
> 
> > which sounds like they're not entirely on board with the new ABI.
> 
> I think we're getting there on that one, and the main thing they're
> asking for is the ability to reuse the GCS after the thread has exited
> which would be orthogonal to this stuff.  I see Catalin replied on the
> glibc side so I'll direct most of my reply there.
> 
> It would be really helpful to get a clear idea of where we're going with
> this series, it's been almost landed for an incredibly long time and
> having it in that state is getting disruptive to doing cleanup to try to
> factor code out of the arches especially with the RISC-V stuff also up
> in the air.  I do think the issues glibc have with this are orthogonal
> to the changes here so hopefully this can go as is.

It's not great to get that API feedback is coming in just now... and
that it's not reachable via lore. So I've picked this up to have it soak
in -next.

Please keep this thread informed whether you're reaching consensus on
the glibc side...

