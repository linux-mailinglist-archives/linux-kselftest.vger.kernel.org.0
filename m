Return-Path: <linux-kselftest+bounces-41046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9934B4A94D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D60189534C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1081331815E;
	Tue,  9 Sep 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyrqvrah"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F58313E3E;
	Tue,  9 Sep 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412024; cv=none; b=jXWC7cOpLefwMKIvcH9kQywz93SflRLRmqBFD4IDmymIXlTLvzS5PwlJT94FyEEm8J2DnKP99B2D9EuVNGjfqfGwO5k50PWeDiX7E5yQlBMIaN+VYHRbmnjDLhnW5mfyDPKKFMircZ/RIXIB97gAsiPq74KyQWv5c5v8p4lQbAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412024; c=relaxed/simple;
	bh=sel26hbdubN+palGD2gZ0/eOdFAx9Akb98dFmcE1PVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnp/SGCzsadCTKy4Gl/7HW/q8Cw+usBW+jJZcDipRz1eQQiem41duO+dg/SlTi8Tusqoe17YKOcxlZXgMosAbNbUHAWRv/9TxTChV4I708atOMN8YKRqsTi/LrYyl17+j7yZ9PtGU5SCTIYfWTfJ4A5na/YuGA2gOTrktphenSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyrqvrah; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445826fd9dso64105425ad.3;
        Tue, 09 Sep 2025 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412023; x=1758016823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOx81+m5TMKBCfvFeUd2lc1fUQ8CVG2MRH89iHXYyPo=;
        b=hyrqvrah7hSvGOqxW563p5/ejvbwhbwGbleoOl/Mc4+KfRDyXhVb02Cp1FfjSBKrJ+
         oCOTXkhTWM46yWFgGO9fQHzbhZCIAD2kQBRy/ujRaw1+hgf4H8slS5X2K/Pq19DJI/XF
         GVGiI2lrixdCgKhrZX1Wyi69IUfGmm0A2oQ62ffoQnteBWUEFiL1HHuuGy/kedx9E8Ih
         eKVaf7C+j63PUikSlX9s3pEbXt5ebbvz1OH8kUG13E3vCP/tIoMc3vm10n/OXE/DdJhO
         AWugg3O38TVIoo9b0hj/K8Nps1UfhVQdwB6M3BovzOZQta/BsMczGx5K+sV4YbQrZq0I
         4sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412023; x=1758016823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOx81+m5TMKBCfvFeUd2lc1fUQ8CVG2MRH89iHXYyPo=;
        b=t6WA3nFtKzV5QIPLYgstwNpun9GtlfOajgjyezXLi6ywiAsggzOoU/YoFi5LcP3ZCq
         bWzfMlXhkavSvKqUO+r3hg8Hd3x2hN4dI6PS+p0i/XafJ3ZdN2Yn0RdcLPhxt3eifyzJ
         EBJ9KXBQSyMkQb10Vpy6Fnj3LovWbAHudsJ0Nn5xK1rGaUypACyPQ90CJSVWZRi5/cWs
         yj+uZDhMYYCrrKuazVlJGfJNWPHf6XjaRFYO1O3uXx035QUs+LO//Af6KQFBOzwpJ/mE
         icpZWxjHDGfjq0OZCf7MVvy0wmdLWHIh7EZHTzciHlLzMv3/GPKpItedHbap7k8nK7J+
         PlhA==
X-Forwarded-Encrypted: i=1; AJvYcCU+wRWaXFITv2qvEvDQhgGbll3rdJRKutjXcD2YfOypynrOnSJZTbtvDiGOUQdN3XM2BfgVDXI8@vger.kernel.org, AJvYcCUfMDYOnDxBVLbGzM0yrIqGJj4yYyQhDwHibpHG+Nz7+LBStwlLzMZZcVAtu+TSBtiMiSKAOFwqRJXkVS7vLSvK@vger.kernel.org, AJvYcCWpSHyLOW2BNUV3cDnG8yMpujCuHrTgqMhDXTJvS9ksYtB9w+6bfQKNNDyfdueHQZfELVVqiDIeF+zZZkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRNFoDOK391OBaduobUgjj8rPT9Mn7mlIzi4/zv5MfYUuvcgl
	jDonPPPxQO8TPM3l+A+R7ai212OCwRBwYFbPuML4E4SOY47gI9zao6Ng
X-Gm-Gg: ASbGncsL6NQDu+8OxUZ5JmAO5+7QtDzAr+ro81fP/g7wOCGPjV9pFuM3nTCID+IonI2
	n6MYf+cLbDUco8Ku+L+yYKN8aRvSHauUoWY5PO3lSIn40qoubLtZPQ7twStdlx8lZvFfLNmZAAW
	kXRlcJrKR12pi+4Rh5KazD1dyefMSO+26af+FZzatd0O+chHI2p1JQYZXc9uNUi/gwH4AzFEt3+
	+QTgTj1MiD27usmjplsOHxLL6m/Ir8HJi5LchT97BIXazpr91KelR/iZyDlz5krKQLkX21bSFZ1
	eaWbmKnS90sGXIMtC1SEJsbGjMXteOhqUlOYEo1jh7oHm3UCBhJYkU/ksTbOC9eFXlw6lUAftpj
	4gVXh+nAdAdNbbOLsQJHJHXB4
X-Google-Smtp-Source: AGHT+IFODb9BV49tp09UgtdQ81xWoNMdmIOHFlia0/7sBhuTUz5mRZhUGLhapz+IyBuFX8A7Wx0f4Q==
X-Received: by 2002:a17:902:ec8e:b0:24c:d33d:418e with SMTP id d9443c01a7336-2516ef57cdfmr170678475ad.1.1757412022461;
        Tue, 09 Sep 2025 03:00:22 -0700 (PDT)
Received: from [10.101.1.72] ([140.124.249.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca63c9e71sm161671585ad.95.2025.09.09.03.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:00:22 -0700 (PDT)
Message-ID: <a3d1c5ca-cdce-428d-8c1c-6a1f59e2dd76@gmail.com>
Date: Tue, 9 Sep 2025 18:00:17 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/net: fix unused return value warnings in ksft.h
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20250906-selftests-net-ksft-v1-1-f1577cea3f68@gmail.com>
 <20250908182018.28d9ff10@kernel.org>
Content-Language: en-US
From: "Nai-Chen(Simone) Cheng" <bleach1827@gmail.com>
In-Reply-To: <20250908182018.28d9ff10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-09-09 09:20, Jakub Kicinski wrote:
 > Is it just a GCC warning or rather a combination of GCC and some
 > misguided glibc decorator to force check the return of read/write?
 > Naming the compiler versions and the warning flag which enables
 > this would be useful. We don't see it building with normal warning
 > level today.

Thanks for the review!

I found that the warnings occur under specific build
conditions that explain why it's not consistently seen:

The warning appears when manually cleaning and rebuilding net/lib/:
   cd tools/testing/selftests/net/lib/
   make clean && make

The warning messages are:

ksft.h: In function ‘ksft_ready’:
ksft.h:27:9: warning: ignoring return value of ‘write’ declared with 
attribute ‘warn_unused_result’ [-Wunused-result]

ksft.h: In function ‘ksft_wait’:
ksft.h:51:9: warning: ignoring return value of ‘read’ declared with 
attribute ‘warn_unused_result’ [-Wunused-result]

This is triggered by:
- GCC version: 14.2.0
- -Wall flag (which includes -Wunused-result)

During investigation of this unused result warning and following up on 
the patch by Minh-Quang Bui [1], I also discovered an issue with the 
selftests build system: running 'make clean' from 
tools/testing/selftests/ doesn't clean objects in net/lib/ because the 
clean target doesn't include $(INSTALL_DEPS_TARGET). This explains why 
net/lib compiled objects persist after cleaning and why the warning only
appears with manual cleaning of that specific directory.

 > Can you not cast the read() to void directly?

Sure. Direct casting is much cleaner. I haven't noticed it... Thanks for 
the advice.

Would it be acceptable to:
1. Send a v2 of this patch with the direct void casting approach and 
more precise commit message?
2. Send a separate patch to fix the selftests Makefile clean target to 
include $(INSTALL_DEPS_TARGET)?

[1] 
https://lore.kernel.org/all/20250601142914.13379-1-minhquangbui99@gmail.com/

Thanks,
Nai-Chen Cheng

