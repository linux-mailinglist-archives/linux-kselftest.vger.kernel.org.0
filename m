Return-Path: <linux-kselftest+bounces-6284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01546879E16
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 23:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849A7281CD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571E143C55;
	Tue, 12 Mar 2024 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UKdaCNSH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA09143C43
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280969; cv=none; b=D0Mmun+iNDsfG7hz5DXbKPZqGyln6MbxgazczURTc6Ju5P0Js72bWwZntwESr1XaXEShQrZskF4dnVD1FtdhYdGFzw+RPV7WucshfveLs63z3PU1AhTE+Dg8qV8Y4YvHZL9V5w1f5zdMDOpw16aXcX4LM2ij4WhEqyb0LYjkTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280969; c=relaxed/simple;
	bh=oexVpmdnuJzE5NnIT+grB7HUdJL7OkTLS1ozx4Z/KWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc6T0+0mn+dTalVUKZL0H0AMxjpTBN5pI/g2y+fGdt97aNeJM9T5x/7go3tOC3RVGC3lZeBxxvla7ey0La0HlufpoWeST9NhAc0oN8VBTqqxE+1MtyVPDPc/dvHxXgBQLMF4i1C1nRX0/eS3w+wLHdimjvvndlHB3z8+A9qN5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UKdaCNSH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6b75211ceso62105b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280967; x=1710885767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1akdFCp/NrQTZkdZoE61av7sk42pTtpjjQoFP3uV05s=;
        b=UKdaCNSHKEqp7yHzh1hBZoDxJwCzZjZRy6+JjsapHreO1jfLoFeUMD5jYHQjq/4bay
         /zCfBcW4JCaxFORrTCqjiPUfHGTTDSjcREvxdT247oraD4oDWaOeAD9ZlOHbwjvhUpM6
         OXbpZNcNfffCyei+nBKm03msxYqMhQxiZQgBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280967; x=1710885767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1akdFCp/NrQTZkdZoE61av7sk42pTtpjjQoFP3uV05s=;
        b=DFNA8hIKuXV4aj1E0YG6nHk4M29vbxa84W5lWdYeqkg2YEPaMy5P/jbsF89mzW4dcm
         UZC9BF7ZaMsnTi8Qv7YE4MEIYGTjAa2Objoj09vT7zexi2OQmYSpoHDF/SX1p2+aHek7
         IMuRXFB+7mUEb/mUzaxTB5QO2b2/GlkNs4VWiS7J6Ca5Js5jzB1JYg36gj8hBiGMXXLa
         8+NKhlOdlBsCKzc6TZTJzF0FG6fZdZfNJM160ykXq7HCnX3qL/QHWoJuLaxYTEU1fttb
         +XcFrb1hG4ZE53h/xkOPu0flpFsNAhw33LdrSQuLi/o8tGhH3yDsPlKzArAJa0fIfVWj
         8cJw==
X-Gm-Message-State: AOJu0Yz4kb29iOmv/8Kv3sQ3LT2z5wxiiJcR8isepztpv7Ibgc0tLY1I
	m23P3KbKVXyyECMgljHDtLC/kidQAowYcypEWKkYun0siHw/kW2j7TIDcm2zmA==
X-Google-Smtp-Source: AGHT+IFKZ+X2o3xvUM/DPjpn5dJMdSK/7jBm9riFOy6GxFDG2jNN2P7xmSx2+ecCvjPJ+atiR43WGA==
X-Received: by 2002:a05:6a20:9382:b0:1a0:efd0:b183 with SMTP id x2-20020a056a20938200b001a0efd0b183mr14145890pzh.44.1710280967019;
        Tue, 12 Mar 2024 15:02:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001dd6c0800b4sm7193896plh.188.2024.03.12.15.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:02:46 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:02:46 -0700
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@lists.linux.dev
Subject: Re: [PATCH 03/14] kunit: Add test cases for backtrace warning
 suppression
Message-ID: <202403121502.95F27A01@keescook>
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <20240312170309.2546362-4-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312170309.2546362-4-linux@roeck-us.net>

On Tue, Mar 12, 2024 at 10:02:58AM -0700, Guenter Roeck wrote:
> Add unit tests to verify that warning backtrace suppression works.
> 
> If backtrace suppression does _not_ work, the unit tests will likely
> trigger unsuppressed backtraces, which should actually help to get
> the affected architectures / platforms fixed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

