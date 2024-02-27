Return-Path: <linux-kselftest+bounces-5464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CDE868671
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 02:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B0B1F21672
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 01:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73A5C82;
	Tue, 27 Feb 2024 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOkTVtsh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC888D304
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 01:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998804; cv=none; b=VoSkIYncmYdI51VGxAnc1HnDW2b3MC+tuzmHyukAg/UKOEB0WY2JTJF5cfWNyY0YQfd8LIN2EpVYkymr8fk6cE3fo6InWIt7pvNvTwVoLWMP9HDobsASLRYGt1XQAoSpB2e2C/xcVmVn3MLUO+LykYwBeWclUqGjxPDh4kNKMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998804; c=relaxed/simple;
	bh=4S4jDqDL1DUGgGXSUskhjdsGXIhGNsCdJ9oLr7BFdMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8NKyEvCe6Rvv/TvmvA7748QHeZJWAXWznpPhoPQV1NRIuKwyMpe0y3FMqdZntRSgL9KunvGcXq+lK6lBEsU/y+XNSxHghWeACP2YPDJ2swBWBpUAVqFVc8uAvAX1M/6rpQW2X1h1P3SF6dZ96qEQF7UhRi5rfow6NvWVvTSJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOkTVtsh; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6089b64f4eeso37930707b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 17:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708998802; x=1709603602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6USE5wdkkio0lfiZ/tGqZ6PFDqZXdzVmrvIAXJ0Sak=;
        b=nOkTVtsh+kGttGerySO37MG2BO7RhVpjJ/TPfwXIkpCFZIdLulEmi9e0zuI0vQHjF1
         Mqhh6BtQ35KFuBxwbu9+y5SLRSzb8Czde8sV67OXW+pbkeDVzOOstzKwJZMknE2ZhX4O
         3BIAwcfv05eH8QSUMnl6Lub/stA5LZPgHJ7dIir5EaoNBBnncSg+CK90b9+eFSL1sVij
         co1JBqEnhU8i9ku3gMAT2SzG3aZHTfifaSl/qXOmtLIKY++e3P0TbC/Eu8QGibE0pkV/
         Q4y/mCxUiA5ijApE6nWR5VWY0pcA7+5d+QfQv/lVEnO31C6u/UFSNAp+35zTMhp5IW8J
         qYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998802; x=1709603602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6USE5wdkkio0lfiZ/tGqZ6PFDqZXdzVmrvIAXJ0Sak=;
        b=Py6YOoCbs49l00BVnNSDiuLLDREJAM/EuxpLT9PzdKDNPfBqdBH4ekzZQI7sdfbGT7
         lzQwolcaydlXOOaGYVdFqsuffT6NwxQSCa29tmuOo1I5DSC8NRDBBtSHQwSUZ81gAdbk
         Uhj4l1DVkVvxb6oq+Sq6zJLDungzyVYOrQ44Zx4fbwLtk27bvZ3KGg6BIajXbd0w8kG5
         bSA4sQ2Yz/drSukvPwwA9J+V1VsU48DBdhRgv05yIbyzJMjdOk2ZwalpfzqfAAQRGZLU
         NIE7AsvwCwwLGb+VCw8zue5pLrTKm828WMBaMH4xFc8vXpbBxfrGRgVim9b+wly2/dNP
         4KDw==
X-Forwarded-Encrypted: i=1; AJvYcCW5/H92QtMoVyZdvWKsgKGAI0SEDQ127mCC5huhgbvpwKBaG4sSZTbqQxW+RKajHxrY0nYn3lb0fzR62bBwEdrNgPquZ2AUhCdD3wSnS3NM
X-Gm-Message-State: AOJu0Yw/90L2VKaKvIi3kz+teLmTiSBsylAy9Zh5S2SRM676c3EF3e72
	e4Bzpo4dCHj2TReOhXsRnm9OZWl7wdX/L5jsxPlynrg0I/4WaiOs6BdDSXn6dFVJ1HJTCpI56IY
	5iv0RhdgcZ/FBevgPwewG5RE7c7v5KUEpWGub
X-Google-Smtp-Source: AGHT+IH3NLEq+kRwFV52T3PyanitX2Oeaf7rYJMYskdkACQ4qRASDE1wbegLDTCv2W+cgMJJRENl6Ce4sSz/CsZqQII=
X-Received: by 2002:a81:e209:0:b0:609:2104:3cf8 with SMTP id
 p9-20020a81e209000000b0060921043cf8mr817872ywl.41.1708998801798; Mon, 26 Feb
 2024 17:53:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226080003.4094089-1-usama.anjum@collabora.com> <20240226080003.4094089-2-usama.anjum@collabora.com>
In-Reply-To: <20240226080003.4094089-2-usama.anjum@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 26 Feb 2024 17:53:09 -0800
Message-ID: <CABdmKX047LoKGWAJrEyu2egpRw8K-_=-ZPkxQNZ5GXtwzb_V4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: dmabuf-heap: add config file for the test
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:00=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> The config fragment enlists all the config options needed for the test.
> This config is merged into the kernel's config on which this test is
> run.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/dmabuf-heaps/config | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/config
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/config b/tools/testing/=
selftests/dmabuf-heaps/config
> new file mode 100644
> index 0000000000000..34bd294836df0
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/config
> @@ -0,0 +1,4 @@
> +CONFIG_DMABUF_HEAPS=3Dy
> +CONFIG_DMABUF_HEAPS_SYSTEM=3Dy
> +CONFIG_DRM_VGEM=3Dy
> +
> --
> 2.42.0

Reviewed-by: T.J. Mercier <tjmercier@google.com>

