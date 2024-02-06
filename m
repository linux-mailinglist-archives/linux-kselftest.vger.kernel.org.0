Return-Path: <linux-kselftest+bounces-4189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2384B309
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 12:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0514D289E0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 11:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1B12EBDD;
	Tue,  6 Feb 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f57QU7Z4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E112FF68
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Feb 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217476; cv=none; b=E+x7+sBPUzCkLZNVDa+fqc1BD1TzGEKfjtCDdpcGzIl1v2BV6BYCpEEiK1Xi4Ql/4a8J2xbIJcZvnz2CsokZPgjftPFw5VwshNTd5aUuF9mc5RRslo0P0O2nSmBLF/TPKjfHGa5/xwfCuSKrLZa8eUi3uyfdBGpcei41M3qI4l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217476; c=relaxed/simple;
	bh=zLVrG5DEPYCkUeOG89F9N4ICOWJwgxPtAMWD+gTUT2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG/rAtD8IaLYihTP3ZElv7ugh7BL5MRTznhtrZEuvHwZ2Q6o8gzHGcxJjM3EOCPB7BNZacT+TUrF5zM5Xl6Menoc1qWU8ViF2NMeZ0FGSZVz94pHS9biM8EHQnQuJm6wwvVSLjm9GrNsJLUAMNOY/mOI1adpTwnH8tDDcVuaCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f57QU7Z4; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5957ede4deaso3473551eaf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Feb 2024 03:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707217474; x=1707822274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jdi57VxKHObnE5zoZGx9RhZHPRCTjhtH0EPbJ2FhTxM=;
        b=f57QU7Z48M+foNZupPTyPXOsbbRyEvjaJDU1nUaKGp0cdJ74QH5NcCczhuQY4zaFJO
         3kL+mkYwfcNQE55g2/1xhkbKo4nFTqFeEC0IPv/pju9pop7Q1imWei29LWekoUBPABnN
         gEbfXAx8QZeCSE2f7yTSPFouOTUaFD6ICSbFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217474; x=1707822274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jdi57VxKHObnE5zoZGx9RhZHPRCTjhtH0EPbJ2FhTxM=;
        b=fZe5Cgkn4pRz41k05/qFBP5PRW3k3Be5uVELFppmeGFE+FnKVKFL1nDHkgQJkuzhsF
         /5yceqLVPWSeWpG0v0GBQRT75fBkUtTZmGLjx/LVeQrc2aTmhSWEmPcVwdWoWdyBIOaX
         TItzcboV7Mg5WfObSxEGqCdUw67ZnBe55DiiXN3HqT3AbEuQ8vTmQp+/jh2aEZ06LdBf
         /ODTBqdu+B9a5VrtxiWKa3Wb4pOT/s1Ws+9EQ06MOxF7r9iwOT8a2U/zhR41vUGARSpA
         CvV3Hd4fh3J/WdxngXjmoZNSAtXi0Gy50UiMkHdY5zjoz1I+7J/99RiqPTL3N22PcdLI
         mbuw==
X-Gm-Message-State: AOJu0YwNBGHdbs8Ie0EgnP9a6gj27+oioQWXJcVbz7bHnDzfIv6z0qhx
	mojbM2sXLL2ZBG6ZoyRJNuvGMBhqCN3dVzwTtIgiIRZmst63TVpAXtxHZ2zoig==
X-Google-Smtp-Source: AGHT+IHmkZcbY3sAPTl3c2KxpO3wQmiur2lCIYnOMA40LrsrgXdjZRT26TwYW4zBmvnbyLlVNZ+ruQ==
X-Received: by 2002:a05:6358:d04c:b0:176:805d:4f1e with SMTP id jb12-20020a056358d04c00b00176805d4f1emr3626511rwb.12.1707217474083;
        Tue, 06 Feb 2024 03:04:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVwRvQs5rTJifiKdaxvcG2Sx4mbpt8XyfRJjYcKF6mrb/BoOQjFuX424biVNdjGoiLaw08GmAL53be4Y4xZEXPBivbMDz0DScQzlnqchZA/O1F6LmYS2VJS9Mhd6NBMAfAHUi1itFdVCTJtraiGOhYVJy25AIaUVNrB1JCgcaKmXPnyAuSUsZbKQEVX3EcWiHGMemzyO4E0+9DJc1r654ytVcjdzQT5k1y9wgImsBmpnnMeGYm6EZozhf/aRVVry2unbG5Tmd/A
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w10-20020a63d74a000000b005cd8044c6fesm1806452pgi.23.2024.02.06.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:04:33 -0800 (PST)
Date: Tue, 6 Feb 2024 03:04:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Pin benchmark to single CPU
Message-ID: <202402060302.C9BD99F@keescook>
References: <20240206095642.work.502-kees@kernel.org>
 <ZcIG8y0U1VyMsCAD@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcIG8y0U1VyMsCAD@finisterre.sirena.org.uk>

On Tue, Feb 06, 2024 at 10:16:19AM +0000, Mark Brown wrote:
> On Tue, Feb 06, 2024 at 01:56:47AM -0800, Kees Cook wrote:
> 
> > +	/* Set from highest CPU down. */
> > +	for (cpu = ncores - 1; cpu >= 0; cpu--) {
> > +		CPU_ZERO_S(setsz, setp);
> > +		CPU_SET_S(cpu, setsz, setp);
> 
> Is there some particular reason to go from the highest CPU number down?
> Not that it super matters but the default would be to iterate from 0 and
> there's a comment but it just says the what not the why.

I was arbitrarily picking a direction and all the examples I could find
started at 0, so this would be more (?) out of the way. :P

Without a cpu cgroup, I can't _exclude_ the pinned CPU from other
processes, so I was pretending the last CPU will be less likely to be
used.

-- 
Kees Cook

