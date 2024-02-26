Return-Path: <linux-kselftest+bounces-5439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E83F8679BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 16:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6891C2B232
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666612F5B2;
	Mon, 26 Feb 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGapxLQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D4D12F5A5
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959659; cv=none; b=BnP/3kkmWbthIT1vo/qCAICLgq0gViqFxmPOgKUiW8bZcStxkOhCEuPn7AaGD+sgfUeYPW526ItoF7G4EoeruW6WeF8UQgPd9/qRm4PFk5aYmFW2ozEd0zrQe7NtdZtFC1FTRn7ZfZz4muUIxVgOuMBfZlX78bRy3Ujmp19lqNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959659; c=relaxed/simple;
	bh=oNM0oY+Lni54p25xgrBtlPRz9Li9UlUuI2Zum1J7ld0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrvlpwbGXbD/F2KsKdpoxcCCkWK1kz8GNEc4/xWLyIB5LSKz25OYQgDawBp02qsWU7Mw0xOnha6APkGu/CZivalsaVeOdLuNlZgE5SEfba7EGQ5q0mVHbSmTLoCzQ8PkEOflKMTvCKc8RB1Y0Ozdevvk+V71m/7AdWfzmvqRQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGapxLQB; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2409964a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Feb 2024 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708959657; x=1709564457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SOCVxdMAC5CxuI2QVnAhvqyR6Re2NAOafoIXIMNYRU=;
        b=XGapxLQBPHiwqagUO4AnXOb2aufFuHlQpa5FhzLAOqU4+A7eJhsr1DMT9/vShmvoxz
         36nqXJDAG7Rq13JIiQhQKKsGfvUun3AK26p8vR9/x7EdfkRq4VKmW2Vm7wTlx8KASi9I
         wyWKNHGQWufmZY1SS2ZprKMvTgeU1XGOpc7vxkWzAQ4cZ9bPfWezUX/y/GdxwktlJQdU
         UiLmHet1yQo6wwpyV6HbM+YlcP2MqQMXMF+IEzZOm+GRv8Sjeq6/coAzxXEfWBJwedHm
         J+WvwKE5ifh8PgzC4axbLLv2NzGxjOqOxXg/bnl/TSSaovIYzBAYfQMQmGUIRQy++vJj
         oMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708959657; x=1709564457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SOCVxdMAC5CxuI2QVnAhvqyR6Re2NAOafoIXIMNYRU=;
        b=KNEp/txtCmQK+3vYLfedf0RzhY+vV2S3kYNJDr2K89rn5hWAnchHdKmgE1ths8zLIx
         f3idvGxG1V1xHRb2V4Y4xtH/cIZwgak/ij+q8lGagcDCb/pWGsLFPlGH/QmBpT0YnYdN
         xn5CG0+RL1edh9DyrAPy6O8j2VgzxdqQ26N4nIQWQLqvZyTorZy8DTMw90vMjwtUkKrn
         PYGM47V3C42zdb00eS3yGlOlDra4sSaGe7PjQpLdaakwfD31NPsW8TYYdNsC4xM+3CaY
         95vjzSCJDNNknz5iTYKCMh0mzBDXuOHulwO7TkKFR3gZ2QJH5DE6ynjiwXGsZD0AZZ0C
         AnCA==
X-Forwarded-Encrypted: i=1; AJvYcCXD4Yi0cbH5KrDI19IP8D7xeIgWnDHnQxC/bFOWOEnuli9+FpkXKy1k5aMt/IHP58SD/paK24O7zgjpfTl02Ub1qPigH6KPXgPNQvxShGFW
X-Gm-Message-State: AOJu0YxdIiqr709ti1dGSaAH8h31cORgybpzii5U2LNT99MP17rUMDZ4
	MJUreg/SOuYMmt6Q/cOt4IwabPZhMvpYRNmS+cs7B8qLlCGSnaMi
X-Google-Smtp-Source: AGHT+IGlNUV+5a9/IwWtafqRkZrfaAk3U7bGqnt1bm3N4sKEnICZ4sFVcsYlU0CMvFdottYDggLJ8A==
X-Received: by 2002:a17:90a:f189:b0:29a:9fad:4ad9 with SMTP id bv9-20020a17090af18900b0029a9fad4ad9mr4118810pjb.3.1708959657159;
        Mon, 26 Feb 2024 07:00:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090ad38300b00298e11b600dsm4566985pju.27.2024.02.26.07.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 07:00:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Feb 2024 07:00:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kunit: Setup DMA masks on the kunit device
Message-ID: <b8cfa626-f427-4acf-a3dd-57af5ad0d73f@roeck-us.net>
References: <20240221125324.718192-1-mripard@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221125324.718192-1-mripard@kernel.org>

On Wed, Feb 21, 2024 at 01:53:24PM +0100, Maxime Ripard wrote:
> Commit d393acce7b3f ("drm/tests: Switch to kunit devices") switched the
> DRM device creation helpers from an ad-hoc implementation to the new
> kunit device creation helpers introduced in commit d03c720e03bd ("kunit:
> Add APIs for managing devices").
> 
> However, while the DRM helpers were using a platform_device, the kunit
> helpers are using a dedicated bus and device type.
> 
> That situation creates small differences in the initialisation, and one
> of them is that the kunit devices do not have the DMA masks setup. In
> turn, this means that we can't do any kind of DMA buffer allocation
> anymore, which creates a regression on some (downstream for now) tests.
> 

This is wrong. The mainline kernel crashes for me without this patch.

With v6.8-rc6:

[    6.401720]         ok 3 Above the allocation limit
[    6.407679] ------------[ cut here ]------------
[    6.407927] WARNING: CPU: 1 PID: 1592 at kernel/dma/mapping.c:503 dma_alloc_attrs+0x36/0x60
...
[    6.413161]     # ttm_pool_alloc_basic: ASSERTION FAILED at drivers/gpu/drm/ttm/tests/ttm_pool_test.c:162
[    6.413161]     Expected err == 0, but
[    6.413161]         err == -12 (0xfffffffffffffff4)
[    6.416872]         not ok 4 One page, with coherent DMA mappings enabled
[    6.420623] ------------[ cut here ]------------
[    6.420900] list_add corruption. prev->next should be next (ffffffff86d3e930), but was 6b6b6b6b6b6b6b6b. (prev=ffff8f3143621e20).

and downhill from there. Granted, this is due to bad cleanup in the
ttm unit tests after a failure, but the offending code causing that failure
is already in the mainline kernel.

> Let's set up a default DMA mask that should work on any platform to fix
> it.
> 
> Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

