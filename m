Return-Path: <linux-kselftest+bounces-40270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F645B3B948
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F35D5811C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 10:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B392D311975;
	Fri, 29 Aug 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF4rz0S5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361DB30FC1E;
	Fri, 29 Aug 2025 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464799; cv=none; b=jKR/MZgmHEwr/j8UKaSGYfreeH1ewmj0Ds84fHlQ99OM33UjWKnS/f9L537Hd5PSexzIxJE9BwVNO4gBjpFmU2YTihjk7CweyQ/J9zpeF3Vmt6Zblez/frqErtAFlhtxMroCY7I+ffLc6xjpg3/Ji6+qPghwC7tuIV+uFW4t4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464799; c=relaxed/simple;
	bh=hfWM5gPtVgoPnOifkHwbxrGhPNxVzmmMJ165dTe33yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0uwlY++eGE9MpnS8mv3bh7cve2LYOy0RHHH9ogIq9xu0/BYX9uKMfahk9yz1JNCs03Vi0mwft6NqBWDRSLc1eb7dREdACJQMOTV9ICwBOQEgTP/H+A+Pp+zwZB3MPgw163+/++trfgsXylcABPSzjPRgUZ135KGHuwkB4xWG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF4rz0S5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-770530175b2so1559546b3a.3;
        Fri, 29 Aug 2025 03:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756464796; x=1757069596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfWM5gPtVgoPnOifkHwbxrGhPNxVzmmMJ165dTe33yA=;
        b=cF4rz0S58mFnndSTdKd9wHETQqB6a5ydVaU5IAe8jNzR4wvJ7DOqn/75DN25hdpLva
         CY2MscBgCgeE0kXwbNmjF4rA/rBhSD91GjMJpwIPQ+dLqEAK+rJ0OJKHoc7pWupAeNGI
         McDsgVeKLfWs5OWJcn/NxvNuNjneMwniTJ476F0r0G5Uc+EST3kmSEle+zY8qClAWCN5
         ExbXHg7Xov+xxP/Nbj5ATFiCnfhkFNS8ilFcOaaAYuMh6aOlHNn8N6s5vueNJkE9Nz1r
         l5N+mzqOM5ZelOK5LGSZRp8dKb/sgpaqIdq/9y2UA2mXwN18fKqnMnm9FrVdHZX4MofX
         BBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464796; x=1757069596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfWM5gPtVgoPnOifkHwbxrGhPNxVzmmMJ165dTe33yA=;
        b=EMePqoaMRS2i4op6wMnBTGQ1SRAWXLGwop/KusA/ny8ZThlc7ft0WwTbE6BEmmW7TN
         nYxINEIIssv7G4PZY5DjYYUB782r4as3rT7rmQc8NbAuKbRDHIjxVrRvxh6ncRalcYID
         Oim32Mxm4G58LuFiDwPTJw8zerWP5Bh+h1nsJ5pqPdlDUC5JbSZ/+LAhmwuzgCUBy2JD
         i8jKYcDS7Kn2yW0OSKFkOINeG9i8IAaBQFzX8hATjaEVWVsGVB8ydHChzx/IIet+DwBA
         povDNvwSJBgStESXyJ130IL6lCLgf29Th/JudJVTwqjTewGIUIyh7DnxEzeKB8apUn+L
         O6lg==
X-Forwarded-Encrypted: i=1; AJvYcCUKoGH8ecWIPfGHo3VYxcfcMGIzARpMrBF+5teuiS22f/bUsiNJ40Bu0wC22UWVRl+EiNksp5kFGecdky4=@vger.kernel.org, AJvYcCVLxJ7BAvY/sDiF+CQ59srp+CfotnCHVIeJCR4PQX27r+Wemin8odD7egZvLU8QG6s/ImYO/L6ZzhByRnBhek4BVCeaRS1e@vger.kernel.org, AJvYcCVVEDnjHiHD74KkF15MK4ssVaoQDINk2jK5Sb7v9ByuFUBoT3L6oq3QONikeMY+zFpnbt5lH7sA7mH7urUgzb9u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7YFE7npGB3ONG44opvKHX9SWzxL1gw96T2Y3Hy2OEpcWfm2BG
	lRxA1vvRFQeQHZgpIP2/ZO47oJkXZ8/0X6AyphrEJ1OPSDUWuhjUdqw4
X-Gm-Gg: ASbGncsAr8+YsWSa1FhMvY72cbq9u4sYDHjGWXX2oyXmiCJ32IXdqUFdrJZY+8HvbZY
	0STufnkdo+BvOtRTGQ6F/uVvJn6JySImJADswkP7tuGDacDMIEll6+s/D+IhEnR915aqPH7Ne2R
	7VFlOE4py6zVksBmRo5wo8ohuVlvRHoTwFAWieSLXPSV5yRlYTWr+YHV4FiwU4WVidb52epd+kw
	0k4Jv2qx1Yzzxw9RmuC9QsSctaFryuj0UTWp6ZvglEDOqEphZmb0ZgfwkMFQJjEipq8ZnEdTzxe
	74MQ1EaZOHOe8OIo7iufKivbW34rh5euWVVy/i4XnOFaBkimEtMyJmay0xV7D6NwroaKicgO6IL
	V4+rPqPphEqLzR7qNdJi1NDVStOnpfJsQWivTxyubvB/KDPjfGWY8djA4GuGmF7T1XPNEgIjQbg
	NgnEyl+BHo2o9K0oWHvvnBeCFj6cZN
X-Google-Smtp-Source: AGHT+IGeY7PCESR6PZttPTaRE+UYm3QcI+YG1R9VvupfIk/fQ9aWIiMXNoIMcW7W4YR2qBrV1ijFdA==
X-Received: by 2002:a05:6a20:7001:b0:243:6f4e:fba0 with SMTP id adf61e73a8af0-2436f4efc69mr19121813637.4.1756464796272;
        Fri, 29 Aug 2025 03:53:16 -0700 (PDT)
Received: from server.. ([103.251.57.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28b38besm1900987a12.35.2025.08.29.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 03:53:15 -0700 (PDT)
From: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
To: richard.weiyang@gmail.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	davem@davemloft.net,
	david@redhat.com,
	edumazet@google.com,
	gnoack@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	mic@digikod.net,
	ming.lei@redhat.com,
	pabeni@redhat.com,
	reddybalavignesh9979@gmail.com,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: Re: [PATCH 2/2] selftests: Replace relative includes with non-relative for kselftest.h and kselftest_harness.h
Date: Fri, 29 Aug 2025 16:23:06 +0530
Message-ID: <20250829105306.6638-1-reddybalavignesh9979@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829014358.qk3zme4qlaojun53@master>
References: <20250829014358.qk3zme4qlaojun53@master>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


>+ifeq ($(KSFT_INCLUDES),)
>+KSFT_INCLUDES := -I../
>+endif
>+

This makes sense, but if we do it for mm/ then we have to
follow this for all subdirectories in selftests.. that might
cause problems if subdirectories are nested ones likes filesystems/.
Duplicating this across all subdir Makefile adds churn and can
lead to errors.

Another way, is adding `CFLAGS += -I../` as is done in net/Makefile,
but this also doesn't solve the problem completely as this also
remain to relative addressing.

But, if preferred we can add this snippet in Makefile to
resolve the error temporarily.

Thanks,
Bala Vignesh

