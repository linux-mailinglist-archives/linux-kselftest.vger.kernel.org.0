Return-Path: <linux-kselftest+bounces-45273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D5C49B39
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 00:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C476B18893A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 23:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C42FE584;
	Mon, 10 Nov 2025 23:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3r9yfSy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872112F0C7C
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816052; cv=none; b=iaoWpdVTgO6+GJgy+mAV2SUQywcrSaFkH/msYdYAj+pWuU9HrquKLR6iwD91wZVZD3gTYG1STdoYL7YwQz+M+zIdfVpj8UlZF5rj9VPrWmgvcKRsMIWI4TZ10YYyAfWP1ZoxBgPeM2iyTQa7aC4RqoaLWdE24KJooTwAHCzyJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816052; c=relaxed/simple;
	bh=ifTxb2fd80Nni8oK6meGxFKTiLW9n9nNKijfIBRIngE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yzx6OdpgqmnknXMxjUFjSnhad7yQly+J5GmeWfbUN8pGwPL2rgU04Stf+YOZ/xSTaNcXQ7n4bcbziBMF3Dm9L9GsIcRm49ARpyquU39PNGpfvgRzqwBpOX4H7/9vP6qXOvDtpTlf6hjUVKt8K9rX28jFjV/3T/FBxlgWea5qpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3r9yfSy; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dbd3dbbde3so2894923137.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 15:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762816049; x=1763420849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+TEDRVllKiGheH9iPhSOnW7gc7oRa0YYtno5v9NCzU=;
        b=n3r9yfSyKE3IzQL9ORE1ZGcbG2uG7P5DX/Kqy/pLHe7WgBgeA2/PDMV+QyC1dFX2sx
         aIYtfX15fX2KuU0DwHQMlNT4rISWqVJyj9DEN+bwXDPP4djO+vQ85KQY7ZGGpzmgpNas
         3IVs8UZCbOmw9pfLkfNVerRp0fi3nhtDBFtM2MpDo0anbd0HoKpduCQTjuxZ26i5ycUD
         PKBGTo61avn4/6a3kUTl0hmDxTcPLsSKUmkDC80dQPEPQYn//TRKRZ31k0ZPGlUIt99v
         jfEdJFncRUavicFX8KUK5Jo6qv7iCoY6RbHVa8NBELvUwy8WSAXLGCKU9NcMOgDfs08c
         qECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816049; x=1763420849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+TEDRVllKiGheH9iPhSOnW7gc7oRa0YYtno5v9NCzU=;
        b=vUowy3coHZkuKZXWL/2R42Q8dnPRZo2nK89NulJUVZHa9V2OK6tpNIMufrEoOQFcYw
         pl9zn9Uwaz6XfoLhq9lZnb16IWCoTid6s0FxBlucVsiNHe2LIyYu8PYZ2/7hhBSverae
         qVuW2yhd18x7MdZsz0XhZsBd4NSVzmbD/aqrjwN+A3gIQ0yQE0lfghGYDBF3LyBgVXzJ
         IzIropPnwnZnC62AGAc4qIf/mKRMMJmyYk8NWMDVQauEIZnXNPxn6rS6Y91Jd+TG+tcN
         u6aiASW5pQQs3Mx0GrOYEsaMMXzEcZToUI2HtGFCGw9RrcivL2acDMR4D/d1c9vIvtAl
         bJZw==
X-Forwarded-Encrypted: i=1; AJvYcCVFZySgySvLchhEBmTPbvsJxeXjvaKceQX5pBc4oAlcCRU7vvsiooywAup/SP5r9ebj/ZFVbc5RAs2XYGKygmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+wyp9JKFNh3dcGBYYWlcAEStGiaN7ehJeEb4Xli7CdWcd0Hd
	R2J6R6qg0a1IOMoNAFnV8oB40JsYaKKXl7Ykb7ue77z94xNm8R6C8ig397BpM5uvHGnEWRy+Eri
	0xiY5YSiXqWG6vP8eqfi8zLLPcJh4fErf8v2U3Zag
X-Gm-Gg: ASbGncvYGEnrGIBp+N8A/mXBi2cHUNYqzN2vkubuMtXk3x5E3yxv31TqW616QSy8QVC
	VcmBGfIN51T1owvGdZ6/P0Mm2+LQrPeQrH8t32wUcXQpS6MOJGn7OmfALKHmJAbPvgU7QACvuaZ
	QlSzBkD7q7z9oGtPQvpgTYER/vdrDvtuBzWA1IfzIAgg4gJ+MUKswHAIK7RT0xBrTR7tv6aA0k4
	xdUxRud9HBYiJSOGmnEwvHzAmFKmbNRdCiRWAY6EL5a9/74rYuQG15VHqnju85lN3S2fZMhi+HZ
	SI5yjA==
X-Google-Smtp-Source: AGHT+IHjmwJDAFc2cXjg3msYUZA3lWk7d5XqAZpIUjQ6p7MF9o2gzZJ/MDrxTGoDvltOyMfSpTaTasHvkcT8023OaSE=
X-Received: by 2002:a05:6102:c88:b0:5db:e0fe:984a with SMTP id
 ada2fe7eead31-5ddc469b7f0mr3590347137.19.1762816049213; Mon, 10 Nov 2025
 15:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
In-Reply-To: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 10 Nov 2025 15:06:58 -0800
X-Gm-Features: AWmQ_blpug0sXFFcDvfwK6kurgehZgkyn7cusv2Dm36toryt7-1iUtP1-uzEui4
Message-ID: <CALzav=e5JD4_4+vqa6udd0dSymW7W-=8Fnf-q0VaBv20+BvXBQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
To: Alex Mastro <amastro@fb.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 1:11=E2=80=AFPM Alex Mastro <amastro@fb.com> wrote:
>
> Not all IOMMUs support the same virtual address width as the processor,
> for instance older Intel consumer platforms only support 39-bits of
> IOMMU address space.  On such platforms, using the virtual address as
> the IOVA and mappings at the top of the address space both fail.
>
> VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
> respectively.  These provide compatible arrays of ranges from which
> we can construct a simple allocator and record the maximum supported
> IOVA address.
>
> Use this new allocator in place of reusing the virtual address, and
> incorporate the maximum supported IOVA into the limit testing.  This
> latter change doesn't test quite the same absolute end-of-address space
> behavior but still seems to have some value.  Testing for overflow is
> skipped when a reduced address space is supported as the desired errno
> is not generated.
>
> This series is based on Alex Williamson's "Incorporate IOVA range info"
> [1] along with feedback from the discussion in David Matlack's "Skip
> vfio_dma_map_limit_test if mapping returns -EINVAL" [2].
>
> Given David's plans to split IOMMU concerns from devices as described in
> [3], this series' home for `struct iova_allocator` is likely to be short
> lived, since it resides in vfio_pci_device.c. I assume that the rework
> can move this functionality to a more appropriate location next to other
> IOMMU-focused code, once such a place exists.

Yup, I'll rebase my iommu rework on top of this once it goes in, and
move the iova allocator to a new home.

And thanks for getting this out so quickly. We've had an unstaffed
internal task to get rid of iova=3Dvaddr open for a few months now, so
I'm very happy to see it get fixed.

