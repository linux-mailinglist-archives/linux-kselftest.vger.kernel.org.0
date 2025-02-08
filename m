Return-Path: <linux-kselftest+bounces-26113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8EBA2D8CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 22:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A781887BB1
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3C195B37;
	Sat,  8 Feb 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkNe093O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E8243959;
	Sat,  8 Feb 2025 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049253; cv=none; b=a3nKT53eX8vQzwxiQxRh0By7Nc5lWAQ/01ooOU4mgJ18IQ/WJZvyuYKxpfG56xTubUHbOQTra7guDvrA5rX/dOOCHFS292bZg2W//qb888hcQurYVQjF/yf1SKW7xaNW7gCD5Y89x5dVp97+Jpdf9rvITS2q6EtueNkoLtaBjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049253; c=relaxed/simple;
	bh=PzgdCtNcea37Vypz+NjnI7+eS01mALuFcn6+kUEP8fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI6Xir6/XljzyKtF2TWoNX5Rj4F7Zw2YzoIBI4R3y5NWVP060Z708o3JQp8fU8Uw7eYAibwZjQxx2zug2278xyfFxRX5a/lhi/qZ6tGBoqth/w5v2YagiK7JA9CiV10OEBhRjvMT20ZcRovUcTQOM+c4vfGrY30Z733n355PKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkNe093O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2D4C4CED6;
	Sat,  8 Feb 2025 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739049253;
	bh=PzgdCtNcea37Vypz+NjnI7+eS01mALuFcn6+kUEP8fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkNe093OQ1CP7oSFe79rPsACtX/YnO8szmjMJMWjL/3TU7qsJG+sHXN/msCgCq8D7
	 jWMcj6NLZZGH6u/53BAKGAMHghzqSlurU6N3lHDY/80Okje7YKp6QngthE2rTI10EE
	 YpfUC0zptcCEw1k8ml0ZruTRhxo1WhfO87Z27dxLg6vHfVXCpJIeMif4bOFfjIy57R
	 QlF0uZ1Jx30c+Wf7keAKySFcsCBwuO1wxZa/NXAsLk8WhQHxrgTP/YY37SM6SVKH3B
	 EOx/+Ay+kUB482P8AhLYYeI4N6Ur42eWxre6xntsoQlCF+GAqmU1A1t4T45wF4sePV
	 SFHZf+4uNTKQQ==
Date: Sat, 8 Feb 2025 13:14:12 -0800
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/6] KUnit test moves / renames
Message-ID: <202502081313.054EB7B@keescook>
References: <20241011072509.3068328-2-davidgow@google.com>
 <e67664ac-dd20-40f3-9bee-0785d428ecce@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e67664ac-dd20-40f3-9bee-0785d428ecce@linuxfoundation.org>

On Fri, Oct 11, 2024 at 07:53:43AM -0600, Shuah Khan wrote:
> On 10/11/24 01:25, David Gow wrote:
> > As discussed in [1], the KUnit test naming scheme has changed to avoid
> > name conflicts (and tab-completion woes) with the files being tested.
> > These renames and moves have caused a nasty set of merge conflicts, so
> > this series collates and rebases them all to be applied via
> > mm-nonmm-unstable alongside any lib/ changes[2].
> > 
> > Thanks to everyone whose patches appear here, and everyone who reviewed
> > on the original series. I hope I didn't break them too much during the
> > rebase!
> > 
> > Link: https://lore.kernel.org/lkml/20240720165441.it.320-kees@kernel.org/ [1]
> > Link: https://lore.kernel.org/lkml/CABVgOSmbSzcGUi=E4piSojh3A4_0GjE0fAYbqKjtYGbE9beYRQ@mail.gmail.com/ [2]
> > ---
> > 
> > Bruno Sobreira França (1):
> >    lib/math: Add int_log test suite
> > 
> > Diego Vieira (1):
> >    lib/tests/kfifo_kunit.c: add tests for the kfifo structure
> > 
> > Gabriela Bittencourt (2):
> >    unicode: kunit: refactor selftest to kunit tests
> >    unicode: kunit: change tests filename and path
> > 
> > Kees Cook (1):
> >    lib: Move KUnit tests into tests/ subdirectory
> > 
> > Luis Felipe Hernandez (1):
> >    lib: math: Move kunit tests into tests/ subdir
> 
> 
> These look good to me. Thank you.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Shall I carry this in the hardening tree? I didn't see it land in the
merge window, and I still don't see it in -next?

-Kees

-- 
Kees Cook

