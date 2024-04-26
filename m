Return-Path: <linux-kselftest+bounces-8936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839FD8B402D
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 21:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48271C20B45
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 19:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09726156E4;
	Fri, 26 Apr 2024 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gR1GUEJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E71BC39
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160237; cv=none; b=qUrLlIKtukcI5JE0butYb9qnknhvY+vJ34ECNUWuIn4g+1yRZj4piTTVqid/6PWteMxt6aodoepS+PydLCTjLTPqjZymsdKuSE2mH1atoRKvS8n+2zjzBNj/gbCgkOeqI33iqtMQXAGSvcwQOJQkaFTuCVgcosJbHYK8Tm7b+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160237; c=relaxed/simple;
	bh=jb5PLg88KFivJkM3TAlFHS8u5PRzC/KTy4qpFDBoxVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaRceXERAImfhPUhjhQGzUKIoajPAHvH1QKxnDaqwqBEn9uKtL7XR7w9bH8v/SKPVeL1LfBKdlmposVCinawdCBGcLnSlHul1OFyMvWJuVo8P+Heo7vIQBWHLRIbJY6SaXruqb3Rp9+ZXEvB1qJNxiE7mfQuHh/e2O6O+OqMGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gR1GUEJe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c3aa8938so17429535ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Apr 2024 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714160235; x=1714765035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l4IeH0YroB0TFNDLHoRPFGcdQLBo1LHITCuFo2PzMNI=;
        b=gR1GUEJeB2qqxxHt3svmKsHNK8UGZAZodmITNtqq9kO4JUJIjJL8wiaqPMTtgBqkaU
         bjcowit1/ZrVA9KDFqf4gdWzJTqXSO7IkKdvaR9hLwAUcdjliDTd36wFVw5lxo1QWU+I
         H1bvB6h+Qr4rievQIgNrNn4jkHUqzlzA0wPnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160235; x=1714765035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4IeH0YroB0TFNDLHoRPFGcdQLBo1LHITCuFo2PzMNI=;
        b=BhBtwN+2i/P2+xjqGK8pDe/P7rDUaxW2Efl+2aMBMKDcMIkMug6ZMotpmF7btmbVwq
         gFuHOySJ0WRA5BxGvLxU+Qh4KEUDLyD9K6zcwgkb6KFkG8fSWxbbNzwhK+6z3sFy+4/t
         gAtWZcbwgf9frHkfYnIbm4va755+3scisqXpTPhDlD4YxD3ThgChdv4/oF1vSSn4DSt/
         60Z3BM4DYLdq7F677pUwxxEfr4y+7j5itU7rbPFVAi0wIRSclpbhzfHiKP43oN7ZCd52
         NP8GD5U/pT7uKP6rOz6FfCXa3uMxIVmSKP7eoOGe3BZaEbk9eC5jzy8eKoW9/J7YcK/M
         xOrA==
X-Forwarded-Encrypted: i=1; AJvYcCWyIfjyFkJIyXmVrVhSS/8cdXovN7Nix76DFohu4AcdVkhvdmV0JJeHMoNYl8DywmlfH/vwx4qZn/emwcDe/uofTwSK2AUO1nSerjQvpc3M
X-Gm-Message-State: AOJu0YwrCsDtdZyuT/+rexv6MgxytrBJUVRkHFYPtNJfDkaEwRKR+PyP
	8UUuMo5rgD+7dj5r1E3+mozm3F7BPjaEoRcT2oFgnBIJ2gSRXIYtYgrCAvI8NQ==
X-Google-Smtp-Source: AGHT+IEdDLK5hHuncyfOLsbtdyyDI2/N+rHj0WFpxqPN9FloJ88AQRsDewsELQepbziT+8O/qCo4jQ==
X-Received: by 2002:a17:903:1110:b0:1e0:b562:b229 with SMTP id n16-20020a170903111000b001e0b562b229mr4328820plh.47.1714160234763;
        Fri, 26 Apr 2024 12:37:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id im23-20020a170902bb1700b001eb0e9e14b0sm1536384plb.207.2024.04.26.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:37:14 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:37:13 -0700
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
Subject: Re: [PATCH v1 1/5] selftests/pidfd: Fix config for pidfd_setns_test
Message-ID: <202404261236.EDA64763@keescook>
References: <20240426172252.1862930-1-mic@digikod.net>
 <20240426172252.1862930-2-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426172252.1862930-2-mic@digikod.net>

On Fri, Apr 26, 2024 at 07:22:48PM +0200, Mickaël Salaün wrote:
> Required by switch_timens() to open /proc/self/ns/time_for_children.
> 
> CONFIG_GENERIC_VDSO_TIME_NS is not available on UML, so pidfd_setns_test
> cannot be run successfully on this architecture.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Fixes: 2b40c5db73e2 ("selftests/pidfd: add pidfd setns tests")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Ah, UML continues to be a bit weird. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

