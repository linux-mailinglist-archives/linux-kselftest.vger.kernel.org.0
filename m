Return-Path: <linux-kselftest+bounces-40855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ECAB45D58
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 18:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4F317C9D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BFF23D7F8;
	Fri,  5 Sep 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8rE4WEp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6820330;
	Fri,  5 Sep 2025 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088052; cv=none; b=l9pH22paZSCy81bNBq9GWX56FVBUZylB81Uy60qup0XqUSWh6HPSfIt2OuDuCWXq3XAHNhk1EDu+OLewhWJESIJHasAHwQIN20M1e7WDpx7JbqjbBMHJX1i2NaSoVrsWGCFufy88EB+4YtAkKcwsne/YWmeuL8lcwI1VnU8iL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088052; c=relaxed/simple;
	bh=R8F48XixHdf1G/WcAbluDKUvvQuIyQErT8a8h/wryh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDgUwQUH+bldacWYh+XVmCfGi/ehQfp3Dzm8UI/pKPvQZXXQ0oEdD2ZVBSjv7GOvVp9K98rvukp9r6IAZcLzibrct6/t9rD1McqGVMx2EknFpfn4P6eCmIYVCWtR1/TMrQ/FwMp/nwEJ/vjeLVH380DhN1P0Qep1z4Lsz2ehx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8rE4WEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D610C4CEF1;
	Fri,  5 Sep 2025 16:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088051;
	bh=R8F48XixHdf1G/WcAbluDKUvvQuIyQErT8a8h/wryh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8rE4WEpacVIEiGmJc1tdHqvQeePbOwG5flmUg3IaXwVQhSJukB8A5YbM4jLvJBS8
	 HJ7Dsz0nlpNTQcMtBFOVkE+doOrLP6Xg6uymd32GtbBg39/EaFKa4MIbBPB2mLz3IZ
	 UIMB847WVU4nX9wiVyFNxokSTrWMlrLrLtziIbOsUJ/zNgz7qFDfxhZow/XRN5YtNU
	 W0uWQ6ZH+x3WmZcmLoFwJzy2RfUnUS0JDEWFPrUIeO4vGJ+5cxvslWInSIfJRr7OLL
	 hiGBakGPvDiJLXdChL+7ZOsynymbnBl3bc1G3MVmk8kTOWoo03+mR5spW3KxQ3TZom
	 s2Io8nMXc8UPg==
Date: Fri, 5 Sep 2025 09:00:51 -0700
From: Kees Cook <kees@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, jannh@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v20 4/8] fork: Add shadow stack support to clone3()
Message-ID: <202509050900.8A01B1E6@keescook>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
 <20250902-clone3-shadow-stack-v20-4-4d9fff1c53e7@kernel.org>
 <20250905-nutria-befund-2f3e92003734@brauner>
 <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ff8b70e-283f-4d56-8bab-bcae11cd5bdb@sirena.org.uk>

On Fri, Sep 05, 2025 at 04:43:22PM +0100, Mark Brown wrote:
> On Fri, Sep 05, 2025 at 05:21:59PM +0200, Christian Brauner wrote:
> > On Tue, Sep 02, 2025 at 11:21:48AM +0100, Mark Brown wrote:
> 
> > > +		.shadow_stack_token	= args.shadow_stack_token,
> 
> > I'm not sure why this has to be named "shadow_stack_token" I think
> > that's just confusing and we should just call it "shadow_stack" and be
> > done with it. It's also a bit long of a field name imho.
> 
> I'm not hugely attached to the name, if you want to rename that's
> perfectly fine by me.  My thinking was that there's a potential
> confusion with it being a pointer to the base of the shadow stack by
> comparison with the existing "stack" but I do agree that the resulting
> name is quite long and if someone does actually get confused they should
> discover the problem fairly rapidly in testing.  ss_token would shorter
> but the abbreviation is less clear, whatever name you prefer is fine by
> me.

Bike shed: shstk_token?


-- 
Kees Cook

