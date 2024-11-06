Return-Path: <linux-kselftest+bounces-21549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0159BF861
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 22:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B261F22F13
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A1D20C31C;
	Wed,  6 Nov 2024 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VCtggFHt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928AE20C02A;
	Wed,  6 Nov 2024 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730927840; cv=none; b=nExq2abRLkUUbLLtCjsH6R/KlZUYM8WqBDUxDZaBjJIepoexZ3zeN7FK1smA+fds9Swo/zihFGVaiQdW3sR2HMwrirIjcVGAAhvdS17Os47gDd0djAB4IBF/Kf3TrKv6k6y4mdGqYHCKTrad7SwtMDYGB5SsvTKQobsiTJZvoJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730927840; c=relaxed/simple;
	bh=UVIVzkxgnorxFMAYc29bFffedWIX/7PJbZ8MAWTGHHk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZNRUqQzAsBLSSl+mvCygYVGBsCvxQheM5ypfkUlG2Ei4tK2Fc3d1Xp2uDXL3b37Zk43/9GyaoJHGfd7DUgRboeaAIFMAlBR7HHA98Ndb7EyZcOCHk6TfLEDRIWAo15KX8gfkErY3kyjxI7fY0BTkGWscsz0Bh5d+UaXHxfaGH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VCtggFHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2FFC4CED0;
	Wed,  6 Nov 2024 21:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730927840;
	bh=UVIVzkxgnorxFMAYc29bFffedWIX/7PJbZ8MAWTGHHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VCtggFHtCZJcnKvaL5gL67E9uejc+5iNSlBQMidKQzvPnqyI2/yN4GWvT5JzfsyOK
	 xA4X+UGM4DLOMeP0V7IEuK+qJX7KAUZBfjP8gApyYN9rxWY/TADf6n9xgqQ/vmbnfr
	 hW7g+Xfeh9/vGiHCpF1jbztKwOmDkYmug/9uOXnA=
Date: Wed, 6 Nov 2024 13:17:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, Stephen Rothwell
 <sfr@canb.auug.org.au>, Luis Felipe Hernandez
 <luis.hernandez093@gmail.com>, quic_jjohnson@quicinc.com,
 macro@orcam.me.uk, tpiepho@gmail.com, ricardo@marliere.net,
 linux-kernel-mentees@lists.linuxfoundation.org, Nicolas Pitre
 <npitre@baylibre.com>
Subject: Re: [PATCH 1/6] lib: math: Move kunit tests into tests/ subdir
Message-Id: <20241106131718.e0899c324941f63dc931f0fc@linux-foundation.org>
In-Reply-To: <CAMuHMdVQ-Fmnti80_HoX1+6L8wNUghpuJzqpT_g0SJQG-oq6RQ@mail.gmail.com>
References: <20241011072509.3068328-2-davidgow@google.com>
	<20241011072509.3068328-3-davidgow@google.com>
	<CAMuHMdUdotDYAgSDDrWi-TOj2o=5a53n452DydhD-Q0fjiGhew@mail.gmail.com>
	<CAMuHMdVQ-Fmnti80_HoX1+6L8wNUghpuJzqpT_g0SJQG-oq6RQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 09:33:55 +0100 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi all,
> > This conflicts with "[PATCH] m68k: defconfig: Update defconfigs for
> > v6.12-rc1"[1].  Of course the proper way forward would be to add
> > "default KUNIT_ALL_TESTS" to all tests that still lack it, so I can
> > just never queue that patch ;-)
> 
> What's the status of this series? I am asking because I am wondering if
> I should queue [1] for v6.13, or just drop it, and send a patch to add
> "default KUNIT_ALL_TESTS" instead.
> 
> I saw the email from Andrew stating he applied it to his tree[2],
> but that seems to have been dropped silently, and never made it into
> linux-next?

Yes, sorry.  Believe it or not, I do try to avoid spraying out too many
emails.  David will recall better than I, but things got messy. 
https://lkml.kernel.org/r/20241009162719.0adaea37@canb.auug.org.au was
perhaps the cause.

I'm sure David can being us up to date.


