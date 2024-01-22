Return-Path: <linux-kselftest+bounces-3370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C24483756A
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F31E1C255E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A55481B9;
	Mon, 22 Jan 2024 21:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8iBUnCx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD7C481B1
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 21:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959097; cv=none; b=bUIwrOCk63z15lJuDn2ve2noY8G4fddr6T2oOekfUSa1CE+vZsZLVGRkxgDR2GU+zEm3OMfF1gi8PD85ymls5xfrYZmenlv46Z5Rudlv5fzDSC80r7Qd48R9dZic8KOiTTRpO6LDMAtYOXDB87ZGLPgLkzeNhK2QXkNRex+OcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959097; c=relaxed/simple;
	bh=ZT0OpjSVGgwunUY5YCyRq+HC+sk5few4F7ciRIXkoi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rE8at5UJZKffGcdaAfUcY/kqh73b3gZvOs1JRf9mPFFy2YLxmazVQyl6IpSJsGixEXDEG4zlxDkdtoHfgOvPCehNzr2UNV5HOllk1yL98N/lwpvEIU0pFE39gQpyolytfa4PTzop4z+7TSFWkbdEPLpSegM2Z6N838ay9Pk11yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8iBUnCx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d71e24845aso19239805ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705959095; x=1706563895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnqfpAGlSXCay/dPTpxKevvMK2f98rL8aVLpxsEQwh8=;
        b=k8iBUnCxiCZzgGo+MKeB4HLzjfb6GgPmS4tICxxfsPtkXX31xz9uduOEQwhtu5IeKO
         KGkpQjOkZEuLZ5n+ZMabmCz08XEz0DqT1HTTUZKHrpqrSzQpAGh+SX3eeVN1UncG22nE
         k0H1oOANVR7uHFhGmgU7pw3c2RG3wEyikfaZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959095; x=1706563895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnqfpAGlSXCay/dPTpxKevvMK2f98rL8aVLpxsEQwh8=;
        b=DQ1LXLA0VUy2w+3zs8Lur5fi0WTY0YRGsBibZPHZXHdMecjq2pNhawe4ebnQohwiyq
         fSwTGi5B2zw+BYCv42y7IsQG01uOCRLk9tfZncWfHD7ennKEVtrBMCgu0D/lNT5HVm/d
         gDTJlAhnQ4FvIIfyB8XI6tyts3JZGb0iSS57ioGK5Igupt0J7jivofSTwiLm0wpayt+q
         H1nCWkANbIUl5YTZhllWC3j/azwwbvLsCdRby/5MbeuA1xqupxHhp99Jy3tXr5KmAFo1
         AzJ1p7gyg8wdwdWMgWDzzWzSwnDFUhL6Sj/RgOMUgt8zohVh8JGQ4cYifqIttGsxgTLq
         ykfg==
X-Gm-Message-State: AOJu0YzMZQac938PRefseJiIMbE60TKSj2YPvNRxOj/aX8MBi2dXn+pS
	PK28n38fWaFVB2RK8c0ZXcaj9afMhkTXra0qR/RjoVDTWs6AgDOVXa8hLYlBu3JxhYH2kpzQrl4
	=
X-Google-Smtp-Source: AGHT+IEZv1af0Fh8VRf+gMeg2aGlHnwk7/dS6prxyiIYHBGG4vCIHzOBQYSidH0yp6ZviK/m1oBzTQ==
X-Received: by 2002:a17:902:6a87:b0:1d4:be4b:8ff8 with SMTP id n7-20020a1709026a8700b001d4be4b8ff8mr2290503plk.125.1705959095518;
        Mon, 22 Jan 2024 13:31:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d0ca40158dsm7691902plb.280.2024.01.22.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 13:31:34 -0800 (PST)
Date: Mon, 22 Jan 2024 13:31:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2 1/2] kselftest/seccomp: Use kselftest output functions
 for benchmark
Message-ID: <202401221331.313C61FDB0@keescook>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-1-aed137eaea41@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-1-aed137eaea41@kernel.org>

On Mon, Jan 22, 2024 at 04:04:15PM +0000, Mark Brown wrote:
> In preparation for trying to output the test results themselves in TAP
> format rework all the prints in the benchmark to use the kselftest output
> functions. The uses of system() all produce single line output so we can
> avoid having to deal with fully managing the child process and continue to
> use system() by simply printing an empty message before we invoke system().
> We also leave one printf() used to complete a line of output in place.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

