Return-Path: <linux-kselftest+bounces-9051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFF48B5E39
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 17:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9834B20E1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 15:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D382D9F;
	Mon, 29 Apr 2024 15:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SgLmpnxQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAA81745
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406182; cv=none; b=LIHsK5u2vVWx/F2jbKQi7xSortVf8add8j1R6cK3ABdW26ZXlHQidjkgBF+FKatFEWSNuQnRpKpg2HM+eDnRM0MPXUhrcqyxfuMTHAjUnydRwojoohg6kEbj2gc7m8Y9Yf5jkqcFenYlm2IS+q163w3X6ft4CUWgMmGSAkY3Two=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406182; c=relaxed/simple;
	bh=ATY455EhGB1trAXJC1zlQW676b8T6ZW3Z87YtK/u72c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DumYAA2L0jfmXw3zJk7nSSI0KZ/gT8GcGinDoHBXuTnSyRXd1NAppxQ9Aw5taKEPXrpH+rixIIZ0C7BMEw846vL/b0XAOM3lzgs6QdsLYDdqa99tcOCW270T5LP89c3mOEAmV7zaEJrngPcuisYOfyDXsoqVuyzzEspyAKr/Eq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SgLmpnxQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6effe9c852eso4141579b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714406181; x=1715010981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kjGkCSeKh/CcNwm3m2uBf4bHFv/7owazitqwRQkEuUE=;
        b=SgLmpnxQ0lxawOMLyZWIQpPyCZSZ7fJXcSHPzxmXk74tG4zlVcZMECFZRRUKK3oRmo
         hLNszzTufGyx3aP+cpehy4+yT1YWF/sEEpWiGjofC8YvyRF1+VL4rHmvM2SrnA+rBKoS
         0Gq6bFt4yqVo/WZIO5OTle8oFYei8csCNJz6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406181; x=1715010981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjGkCSeKh/CcNwm3m2uBf4bHFv/7owazitqwRQkEuUE=;
        b=UwDmcbweo2MYZqfSXZbavOyDiY9ybt13pUklcQz9PYch+pT8sYk0dfKe/AUa9F/rC4
         ds87q0iczBXerLGn3XYOWtaJIX/cpYnkAR2Yrq8kPaV+M/MCAjLO1f6tfRxx9eBRqNY/
         W1jS+d57r4WWZ3c0nfaJOUWpGZAbucgmqMDSUOT0g1BkcPPlDhe7TzPUyKlkb3Y8h2db
         Twhav3brB3lPvx5uIuecnNIH26nN3IFGAlAIxp844jcJVKrZve0qQ8kiCGYEk+fAuBMQ
         3doEUC6TpM+EqWoyzCaw3V/j4MXaTGWvgPKzDcc4OH0Fa+uBaZjw+pqxzR9rXyM/e2i8
         1acA==
X-Forwarded-Encrypted: i=1; AJvYcCVlIDcJINSjzfeymYRNRmWPDrQzhikEg81q0O+sQvxQkeghZ8I4iloQpfrTmQog7qZ4dux3BCEmEBPyAoup2FdHTB4BS3eOJ37wnCjz3Its
X-Gm-Message-State: AOJu0YzE/8HplysKTmOtjyQhC+qps5uIMf11UJ8XNj+ZWor+SoUnLOap
	c1wLyelE45mPbXymMs+GeThXuvDaydPUV74aVj69CeUJe+jjjlmO8NuM6Xlfaw==
X-Google-Smtp-Source: AGHT+IEEywzon9guDpWHAHMoP7E4pXBs+0uOQkQO23YAwbVpobMsPRalzKbOZoYrJ3hUqSG/EDAvIw==
X-Received: by 2002:a05:6a21:7885:b0:1ad:89e:21b5 with SMTP id bf5-20020a056a21788500b001ad089e21b5mr12953888pzc.15.1714406180782;
        Mon, 29 Apr 2024 08:56:20 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lw4-20020a056a00750400b006ea9108ec12sm19390219pfb.115.2024.04.29.08.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:56:20 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:56:19 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 7/9] selftests/pidfd: Fix wrong expectation
Message-ID: <202404290855.34806C9@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-8-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:29PM +0200, Mickaël Salaün wrote:
> Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
> which will be actually tested on the parent and child sides with a
> following commit.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

I had to take a closer look at this one -- but yes, this should be just
checking for failure (negative). The parent/child separation is
afterwards.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

