Return-Path: <linux-kselftest+bounces-40528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A832B3F815
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDB8482B94
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D1F212568;
	Tue,  2 Sep 2025 08:16:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC01DE3C7;
	Tue,  2 Sep 2025 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801005; cv=none; b=pmXcM1MrXvSiwJu1tf9iiyWS9kHeoGwuWGrCFiwGGNQYigSDiDjf0HCCBAxrAxS8FxZthM9h3B6xUQfp1il7AjYx/eNYn6Wh4SOm3JBowGmKagzcrZoRbIjxBJde/bLfuBoDReHzb9Yx8HI+Te1IcAtcW9mgH/ZCsog3s1BdhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801005; c=relaxed/simple;
	bh=JSDe1gGZYmvObD0iADroPzyrdhkVfSvDa8bptfqlX7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVijAkdvnEBsfU+augC/g0r2Z3rcTK1+bK5ddCi19wdx5ConLC88vCtcG/gui2a2NSfy4d01GN6oAIv4awLoHR9qSIIiyHGNBadxlrbAtsNSnHKu96HtCxlTIYs06GMl64xoa++j/LBUtcWGIS0drCMrlR5+x+ZQ7HIPxhlfx+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0415e03e25so290193466b.0;
        Tue, 02 Sep 2025 01:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801002; x=1757405802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aFTGI+1JnL6z0QFpguMaVD2tGxg5FIWkAc/1aGyI1Y=;
        b=aPoW6ahbWDmWQKiDZpJISzfTqgsm+ehvMfCe3oTz+RICqcvMWTF9kGtA6F/aPq08rz
         gLpRFoXOEWTtaEVI4fOGbeACCDioZt33QIaHGJ6eu/bFlBEw04ZUuLK2CigL9/IIp8pz
         TXjnyce2Qfr0uysDZX8AXbLB9+UtwQPvcbaGiwzhdjUjK7/d8Si/VUU+O+7ltVvyOYSR
         7F7ZQV+1a30xvDRFwWmH7JSQPxl4tQXUAhx06bx3ci00nybCMoNBLES0tfkSskoNBn1G
         EeJPKPIjdMRI4FBqXIf96rua506J9uq6iBsjnzqXCjapNqxY/sPqkldeDC2uJ6hrFYov
         gAwg==
X-Forwarded-Encrypted: i=1; AJvYcCUc0foFVClSon2Rzz3K4V5gZ6NOPZRbfkVgYK+Lo6HF6O0CgGnM+qt1xfEjSa+O64HBNvAfzq9u++Rv/rypynA=@vger.kernel.org, AJvYcCVck6lfXI6ZsvhkJUB3c+ttnd8S9vmq2ojj9IduQ+D2sCwTjQj7TmpBvtkESvB08G2JdEeXhuD7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2QoP9ALqPt+41il8OnEZT7x09JwtYP1Q+HhvEIkrTrCGtnbD
	dPvhACWdj/QVUgL3ou9ScogpFkxM1XUyTKdrCF8V7rw/jKlAFxlIVC1h
X-Gm-Gg: ASbGncvMlGJgX65y97pYWpgorcgydrkq5QLmwrHqpYaibt+sPzeX2d3z5KHmgkwlT7W
	O3Fkkyz7J0eK/ZzljKSQdKpPwpog/50ql5aDgsOME1VJQGSa+HaoK7jkLrqbPHndLVeJPX6KfMd
	WENFy8xTHl+9DiaRcOhlILKqtl5B5zSJtLIcavR/X2/x7T98XPrEjIZfkx+cpAEusjxqyYM6avq
	J4oTtvXiNwE8NGPh2v4nigfL+PDIZhQwJ8CJD/jZH31HVmRqgX5+PrMBVL7Q3ygCJHGlmWGl/NM
	Qmc86jsXHwl9oRsIeG+BOUZjEgEIUGEH7AeysVtNQrYN5SbFJW7xH5C2ialM6G3hVzSXr3F2FF5
	C+D058x2CLW4b4VWFtjAevGU=
X-Google-Smtp-Source: AGHT+IFLsrsqxYJdWu8E2cATJQ8y9GfXU0kjCUNUH+21HJ5zxZQYrPPJS1hLDiBfdimZpFPaYO4xTg==
X-Received: by 2002:a17:907:6e94:b0:b04:3662:971 with SMTP id a640c23a62f3a-b043663196bmr496306666b.65.1756801001751;
        Tue, 02 Sep 2025 01:16:41 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf588377sm2193250a12.15.2025.09.02.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:16:41 -0700 (PDT)
Date: Tue, 2 Sep 2025 01:16:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: py: don't default to
 shell=True
Message-ID: <jwnluocwcj2kubrxab74iyj65ehf7xm4wgifwdtce7jn5xawys@33a3vmcrjska>
References: <20250830184317.696121-1-kuba@kernel.org>
 <20250830184317.696121-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830184317.696121-2-kuba@kernel.org>

On Sat, Aug 30, 2025 at 11:43:17AM -0700, Jakub Kicinski wrote:
> Overhead of using shell=True is quite significant.
> Micro-benchmark of running ethtool --help shows that
> non-shell run is 2x faster.
> 
> Runtime of the XDP tests also shows improvement:
> this patch: 2m34s 2m21s 2m18s 2m18s
>     before:     2m54s 2m36s 2m34s
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

