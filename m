Return-Path: <linux-kselftest+bounces-8405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D958AA897
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9F71C20F42
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9323537165;
	Fri, 19 Apr 2024 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/owIBop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6E2E3F2
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509186; cv=none; b=f//O05Zd6dvtLzuFX1IH6l29ojLvWl7vu3nCVBFMrNh6mKEGK8hz0RvZaCyNXGSd7HnuoBMweTj1acF80I1YuoG+XnahQhvVh9AGHE5XikKTE0RrABLXk1mQ1NsV2T/cjGzCMbtgcingIM+Hwi5Vg7WNlRtoMzfd5sceMpL8LsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509186; c=relaxed/simple;
	bh=u0HF41IZwgeTJDQsNauxGr+WavqSpst5cZbgaiLVR9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJf4ExbFz8Z6e/7odyssWxPPZqEKl8WcyuQviGO5JTeUC8aajNB8NHUjpbCe+ndru8NMUGhWygHYYC8c0cT7bM8SlDydOopQ8SfAezZjELrZ+ihvlMDTZAt9W3WlE9Xpx2xynoeFSB+7zpUtB0Qxa5cOpDfXt49oaeXXEX/tYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/owIBop; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso1585987b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Apr 2024 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713509184; x=1714113984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=likPAjK9PgGVk5+qxCMBfysBI+F/PO0e/FyQV2RaWbo=;
        b=W/owIBopzOD7dPCYJ2XOmjBD+ELNGChEk1AqkXfin1HLtKqfC9Ro/ZUoMfdXCX641z
         N5qEgS77nHwatWXeSznhLBAayJa1oFLHEdmQcbM47Le2Pj9jGun9voRXQdxgATb41XCZ
         C8TMcsf065eZSJfUnVDgH9tfKWim8b84uKJNfi/IjpcJJyjUWIKof5KtcA6E4WKI3Wj4
         7QO649qpB260BNFADZdchzMGoMtTwMj80tLpIV0lQ3bL7UZQSkoporjWDEP3FIwsBQKQ
         4s21A7NzVh32IltPh3eCde9z5ECph6UrD16Np+cIOaHtYbUW+UXWI0jH4uVf3j+65hSJ
         XQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713509184; x=1714113984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=likPAjK9PgGVk5+qxCMBfysBI+F/PO0e/FyQV2RaWbo=;
        b=Y2ZWke7j4BcOXSGYCJX+FtJvaekPRRvothykvPZizkFpmGT1kAlaVKhXCDqJoPNJxK
         sA8m+QRG0hx21r6ODBI7QDs2qTPIHp5pEYV/wFKAetRDYkO/xBuapOKufIdgrSj8shdV
         Up55jYDy+Xt61WG/Vk+xetygNBSbk3C8AdjCVXrKI0r84DSzEO0WI3etplpvoJm4YB4X
         Vb+U4hUBK2v3I3LWgWgg/XYRcyXFTz/LhbIJZ4LFS+xaIURFQOj9inLuyUo9BVD/N5Sl
         F8GRLohiWdoyDP7+6ofMI4SzIsSOeTzY8eCpGHivkvHKLe8xs8EXyIX8RBfFByVR6geO
         GCIw==
X-Forwarded-Encrypted: i=1; AJvYcCWYtvNj63wfoKciNkdaoRDCJt70ecaDQGTjq4S9caK9EdeoQn0q8iGDDj3Ai5CJXXrNHPl7puJvL6OS6Yt4L12QV81vswGs6iGYv6ku0yjV
X-Gm-Message-State: AOJu0Yye73ueRz9d6ZcvPdqwrZWun3EEn9kKUWYXvJJwYpjMwdBN/Gc5
	XFUu4KcUaz0tpnM6hczWh3StGSskBxBW1eaNday8GoKN6UrOk9FuxAjeGlmzSgo=
X-Google-Smtp-Source: AGHT+IHJdn4XMlV/f4j2y8kUhBIVDEUhNZSWwAvnrLM5ep4RxiBIGPPNC3RiVuCyXUa4Dmo0aTOsfA==
X-Received: by 2002:a05:6a20:5653:b0:1a7:bc31:933b with SMTP id is19-20020a056a20565300b001a7bc31933bmr1492291pzc.47.1713509184494;
        Thu, 18 Apr 2024 23:46:24 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm905236pga.91.2024.04.18.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:46:23 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:16:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cpufreq: conform test to TAP
Message-ID: <20240419064621.a4qcqt6ck26te6up@vireshk-i7>
References: <20240418153146.2095230-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418153146.2095230-1-usama.anjum@collabora.com>

On 18-04-24, 20:31, Muhammad Usama Anjum wrote:
> This test outputs lots of information. Let's conform the core part of
> the test to TAP and leave the information printing messages for now.
> Include ktap_helpers.sh to print conformed logs. Use KSFT_* macros to
> return the correct exit code for the kselftest framework and CIs to
> understand the exit status.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/cpufreq/cpufreq.sh |  3 +-
>  tools/testing/selftests/cpufreq/main.sh    | 47 +++++++++++++---------
>  tools/testing/selftests/cpufreq/module.sh  |  6 +--
>  3 files changed, 31 insertions(+), 25 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

