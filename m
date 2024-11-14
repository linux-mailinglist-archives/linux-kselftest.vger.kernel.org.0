Return-Path: <linux-kselftest+bounces-21977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF089C8056
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 03:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 872CBB22E18
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 02:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997E1C1AB6;
	Thu, 14 Nov 2024 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B60rTcsb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1B1DD0D2;
	Thu, 14 Nov 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549611; cv=none; b=bUKq4jirFhdNnj5lHOduNgu+aGJZPWbOT2jwZ91WyGF8DJPI0baJa8cpn3ty71DD6FmTvDUqApMmfTdqdBUFx+8OijK3/fnvykYF+p5CWuoALjvSn6snO9buk50OyWzQHtUG4eaQZag0ljlNS9KmrvbSB5evQguXh2+a+k0AXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549611; c=relaxed/simple;
	bh=Ve4X7IVO3nl79v11fD2EXNLyIU8oSwD2O6Sym1SrLQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PohI0dALht1uBYwlNY+syDJneAdRHNm0YyR85v/y9wiHxr4SPWrgYc93YM1sntAprl97lpBZJEGA0XJRy4+Ax1Dc56RSzv8c3e/xV69ITy008tUbNFR0PFuKzK5nTwZzP0VR5FljOUXaEdbwd67Ln3HteXqvkuYmwhGPQ491r7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B60rTcsb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cdb889222so600085ad.3;
        Wed, 13 Nov 2024 18:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731549609; x=1732154409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iF5yxHjvqla20B2piIyBykr361yQhNR78eoBjQwFpE0=;
        b=B60rTcsbNQqx/y5w7b1qfBxTqTAkv3Be0tMJSBYvcvizjF/sQ+Qs98EeiFaexcUY76
         VACQkdYDerJFqvwaTmPapbXDlc2aUrzapIDMzKIJhH8GoPjVCTsSFCvPexniPzkgCrWw
         MHdtH/lCYOVtJmPats42sQWZ+EKOUQ8jt6wUEjzTIbI9orQsSWAh2Da5XxQDqYeSyUwZ
         346ajE8K+gLq4Imf2SKsgK+FoLO9XvDDisMLNeh9Qwg0Ph5CXdCweV66ySYOdgZv/TdL
         GB21mCDDGG5b0KMVTuOw+XN6aZSwQqyKs+mHV9cY1cBtn+YlIgw2nhQ7yPlmsptATNrz
         K9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731549609; x=1732154409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF5yxHjvqla20B2piIyBykr361yQhNR78eoBjQwFpE0=;
        b=Bzl/aw0J6vmxYOmK2Os2zT2qQmHLKpV9MRkMbH4Zy5GnUXFnT3nFYP0tOT4EM9tpxm
         ZB9oa9M9xClLtVBerPpD8sQrM4Oj7gZMysgfeXgPZsm3Zj89+5jW/nJHzbNngoX5Zbza
         0LqE9Ld8ovZzMZiIRoV5B3vOweO0MdZkLKHDVbeSmoapTFeCstNhB80jIKwO370+Doht
         ew9H7Lu6MA8hV/t0k222fQgDUeEsDdEpOr3eC8gI4DmXXjKBgc3U7RfTvtp+hUxHp3nV
         dGvEaLhAsvh24YR/U6Qpfr03h6Cwzit0V5AbKQ+EuzKbJ2il4Z4mH9UiKAeDoBsQd6hK
         MAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRRBsyVAQ5rKcBGUogSNFRS9UcoeTUoe2lzbTl6PpDxfVPyL5jJO8kbcl1Wn2brMQt9tDat5HUD7p9EUk=@vger.kernel.org, AJvYcCVl53qt1yzvZ+N9cKNONygojNxONmku8hjtK7TmIwDP55g3sA/PNaKoZRDtCImhDV6IJg4bj+g5zF29T8rWV72w@vger.kernel.org
X-Gm-Message-State: AOJu0YxkZmRcgxP4WBnbxykzM3E8WPU101oTwPnXg9klrXyNJ9QBp1jV
	hnvmSLmN9na4RMDQYcl0que1+GOswR/yO6GhoaCMNBrWZzfmLWzP
X-Google-Smtp-Source: AGHT+IEfvB99QbORwPWIIC7wiKtWynIxgL2tFyHQBfCuM5lvLEToXrb84qeQ3YAKcymztx8re44DUg==
X-Received: by 2002:a05:6a21:6d99:b0:1d9:4837:ada2 with SMTP id adf61e73a8af0-1dc70450ee0mr8163121637.35.1731549609591;
        Wed, 13 Nov 2024 18:00:09 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9d67c6sm98764b3a.192.2024.11.13.18.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:00:08 -0800 (PST)
Date: Thu, 14 Nov 2024 02:00:01 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Message-ID: <ZzVZoe_N4_h4qWVP@fedora>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
 <20241113125152.752778-3-liuhangbin@gmail.com>
 <20241113115612.1717575a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113115612.1717575a@kernel.org>

On Wed, Nov 13, 2024 at 11:56:12AM -0800, Jakub Kicinski wrote:
> On Wed, 13 Nov 2024 12:51:52 +0000 Hangbin Liu wrote:
> > Add a test to check the temporary address could be added/removed
> > correctly when mngtempaddr is set or removed/unmanaged.
> 
> Doesn't seem to work for us:
> 
> # [+300.25] tempaddr not deleted for 2001:db8::1
> # [+0.16] tempaddr not deleted for 2003:db8::1
> # [+0.07] FAIL: mngtmpaddr add/remove incorrect
> not ok 1 selftests: net: rtnetlink.sh # exit=1

Is this tested with patched kernel or unpatched kernel. On my local side I got

# ./rtnetlink.sh -t kci_test_mngtmpaddr
PASS: mngtmpaddr add/remove correctly

Thanks
Hangbin

