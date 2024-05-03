Return-Path: <linux-kselftest+bounces-9351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 078588BA97D
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59F6281F57
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F914EC6F;
	Fri,  3 May 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1q2O5mv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7661367;
	Fri,  3 May 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727445; cv=none; b=d4LYlBkGcR1skukfsVQgiMVzA7ReV/ptgs57qKP03MVvN1WOB/mjHlblHF6vLWWvS8ubp4P1se5/I79Zargg0Q0RTSKZzqQaKb2ARMQkzaPkC8AqkCff3/kzTPaE333jZ2CAaf4uGGCWpPzhLzgFLil4/bbjkluZyvUv/7Jhs1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727445; c=relaxed/simple;
	bh=WTDd8xTTFTmxmAFyzg5Soj8vzJna+d8YvjaUIxy/+T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1M9IqZ3o00shLSAh2egRzhpghwWVPrOwAx4O4Mw1MBsW/BWtntTKI3QlBOGrXQ7bu5mvWFD+x1HHrFZb6Tr0XKanNPTuVgV5tbEEJE0JhfqjMT5hhMNQ5Xw/2//9Hpeb9cMaVmYvOwVO+JYO8tDvJ6d2KFw2opJR2DtpQ3xRiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1q2O5mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F544C116B1;
	Fri,  3 May 2024 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714727444;
	bh=WTDd8xTTFTmxmAFyzg5Soj8vzJna+d8YvjaUIxy/+T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1q2O5mvo3cPCwkLySXkfpwl8YnN9PNkYtfmSoaliKWHUta39eI7uDK7j+8kEZTJO
	 tvj03MIXG071ielV4jEC94C60aKxnuxD62MM2e/PfK87qi40aCIqLNUI3nxTlkOnSX
	 Fl9ZbesgzSnk+xqe84bAcTfJjNLEGNkdFeDP1OWv2tX+CgWvXtnoDopQ9X9lO1JRp1
	 l15rWENKBnB4gDNq+iF7iHrFRkbri1Psr6cWE1GaLyTE4JGuV8POPogUVZrmzfS4g/
	 A6ELN1TCWKMZUZ/ADK65D2HqZqV02SLjhsEJo5GwpviP0EiVUoOBXRL09OeKlaZdml
	 OTBD7oRCBzvnQ==
Date: Fri, 3 May 2024 11:10:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <keescook@chromium.org>, Valentin Obst <kernel@valentinobst.de>, 
	linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/binderfs: use the Makefile's rules, not Make's
 implicit rules
Message-ID: <20240503-glossar-notfall-bd7c234c2da7@brauner>
References: <20240503015820.76394-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240503015820.76394-1-jhubbard@nvidia.com>

On Thu, May 02, 2024 at 06:58:20PM -0700, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...the following error occurs:
> 
>    clang: error: cannot specify -o when generating multiple output files
> 
> This is because clang, unlike gcc, won't accept invocations of this
> form:
> 
>     clang file1.c header2.h
> 
> While trying to fix this, I noticed that:
> 
> a) selftests/lib.mk already avoids the problem, and
> 
> b) The binderfs Makefile indavertently bypasses the selftests/lib.mk
> build system, and quitely uses Make's implicit build rules for .c files
> instead.
> 
> The Makefile attempts to set up both a dependency and a source file,
> neither of which was needed, because lib.mk is able to automatically
> handle both. This line:
> 
>     binderfs_test: binderfs_test.c
> 
> ...causes Make's implicit rules to run, which builds binderfs_test
> without ever looking at lib.mk.
> 
> Fix this by simply deleting the "binderfs_test:" Makefile target and
> letting lib.mk handle it instead.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Fixes: 6e29225af902 ("binderfs: port tests to test harness infrastructure")
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

