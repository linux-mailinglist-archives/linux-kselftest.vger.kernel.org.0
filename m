Return-Path: <linux-kselftest+bounces-6385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B032B87E299
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 04:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC38D1C213FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 03:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4C31EB21;
	Mon, 18 Mar 2024 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ogn+bVi9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BC1E866;
	Mon, 18 Mar 2024 03:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710732921; cv=none; b=smzWdAm6ClZyM4qy4eE5d43ztS/lU5KH3VNqd9zNDKFiQrVy3tMMENp3mPwcP28W7LnwRoV7WetOS13MJ6qcY255K3QTYx0B2OWMsr7curFBMNM7zGVuzhf+429k04LqMPzpeabl9FGyX2ftbN4LvQMU0l4KHQgvt9uKz3zPbCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710732921; c=relaxed/simple;
	bh=srHab0CvgrTVsFnDbUyGDJnK/gDZ2myxNeNNeVJC15c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9HU0kIKHLrhFnNTyde+uldrTg+cvGzx45h6keiSqyehPTFGqz00quE6L6N4QEVcyHJrL7vVwwtLMGUJrf1y/0i0IvnRDOm8DJRqEj0JnYhBKp3Yaia9ki+aOOdf/KoYXhg3yQLoyFK1a0KZVNoDRZQpnQ2OfWCBGBBS8GJjwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ogn+bVi9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c38b719ab5so29856b6e.2;
        Sun, 17 Mar 2024 20:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710732918; x=1711337718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wrOYXD68fVx///jNgINMPnwrCj4qHGzpRc3DdPVkGqc=;
        b=Ogn+bVi9cotmunPBgtG1gKXqibTOilcfjI9YpwV9fjFLBn5BFYoD2/UHcwwGS3ht+p
         vEFdlZt5HVJwF1whZkYbScoGVkdxSbMBZPG0tIglxNzvhT4mj+7C8nB3atRi110+n8u+
         QCJ9lURSLdjnYilVYgt1E7GHVMy1DpLnxlsrzmPoY0yIDXRQdKIYsS6OMKv9zHoo289G
         dOof5/4KZhVr0zo2kaKNP8Ao6mWf6TNRrV0KofTEIllEo3TFeQRFIo99ulYb++9X24c/
         9t0PkSyPIsmZ8XGsWMYivkhNXfsHExXaTNdx94D7RV+0NtBAA0EaO3HBUsyg+1dQx7gw
         D4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710732918; x=1711337718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrOYXD68fVx///jNgINMPnwrCj4qHGzpRc3DdPVkGqc=;
        b=bG6viKo202y+bkLsNAV2/CdtGtl7nnMzV/UoP/981anIXcWDw6hPcepUePIVgOojM1
         zl5QKrwiI9Rpr6gmTmefVCy4h7fOnZGigJZJIWrVJ2nD/04PqopevJQ4M0aXdM9zn6xS
         iZYoVQPM5XnlMQG3cZYgsgI+TJSNg3sHWVvj/kC9PoE2LrG4SlIbuRYGXjm+qWlLt8LX
         PjsAIRzxxnfuFxWU8OZu59taoesf6qBlbEtq4zw9GX+mVtYmizzN97QcMXawwTTZ9g1j
         fmgpKmtt7Ukm8Yd9pHPGjyIEoVypOf83QbP8l6ZGiY7PEKAiMXWncvVL/ytFBTCbgdzi
         jSbw==
X-Forwarded-Encrypted: i=1; AJvYcCXMh1pUJcDf2sOyL8/uim8XQLhV5FejOp0krFT3EqO8mEhuuKcavk6LyWRzJywtKb7iRUDIiTlnXtxtnQeTKVlbQraDuzhjjdOI2QRVuB8RwoutRu7Vz5GcfepQdS2biFzxAdtUZHxCHCfdKP/7
X-Gm-Message-State: AOJu0Yw6S9i/6Zefag0Mxt3AEH3XMMFKUdeVZykytPOOx77tXITwl14G
	Aj35at3t6/rrOlIONCZ67QLYBjUGvT/E+bvKZKOyrhgu5MRr9Fu9
X-Google-Smtp-Source: AGHT+IE/uNSXoSrFg8tJozjHDVYN/SchdG9u6ImD1VcULJ9M33t1PQu81kTJDBuhxhesXPkGn8ELmw==
X-Received: by 2002:a05:6808:228b:b0:3c3:814a:fc6f with SMTP id bo11-20020a056808228b00b003c3814afc6fmr5118573oib.38.1710732918389;
        Sun, 17 Mar 2024 20:35:18 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y125-20020a62ce83000000b006e6b2ba1577sm7166090pfg.138.2024.03.17.20.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 20:35:17 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:35:12 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [BUG] selftests/net: test_vxlan_mdb.sh: 84 out of 642 tests
 [FAIL]
Message-ID: <Zfe2cGv_EWFAZXAJ@Laptop-X1>
References: <5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bb50349-196d-4892-8ed2-f37543aa863f@alu.unizg.hr>

On Sun, Mar 17, 2024 at 12:19:12AM +0100, Mirsad Todorovac wrote:
> Hi,
> 
> While running kselftest on vanilla torvalds tree kernel commit v6.8-11167-g4438a810f396,
> the test suite reported a number of errors.
> 
> I was using the latest iproute2-next suite on an Ubuntu 22.04 LTS box.
> 
> # Tests passed: 558
> # Tests failed:  84
> not ok 90 selftests: net: test_vxlan_mdb.sh # exit=1

FYI, I tested with 6.8 kernel with net tree. All passed.

Data path: MDB torture test - IPv6 overlay / IPv6 underlay
----------------------------------------------------------
TEST: Torture test                                                  [ OK ]

Tests passed: 642
Tests failed:   0

# uname -r
6.8.0-virtme

Thanks
Hangbin

