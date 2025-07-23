Return-Path: <linux-kselftest+bounces-37874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9EBB0F131
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0038545DC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CE28B4F8;
	Wed, 23 Jul 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSHYJCZi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DC212D83;
	Wed, 23 Jul 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270258; cv=none; b=gtRkOP0s8xzn+mBcgg+UaDR4pKcjxbX+DCZepgOLnPsRI3+A0RJK6JcbDMF4LleWgiYkNbkMjOhKW2C969O9+c1OfmfqebvfEpcnsFORhFSMUe6SjLPEhS9ij6RwxkIF0xrxc7A/aoU2jBlxIpv6E0qE7jy3PQD11YvtLIBJAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270258; c=relaxed/simple;
	bh=PjHlmcHM0vDaqDjO7m2BVsQkGBz61UdSwEmfp9JfljM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBv3u3ACj8eIetVeXbaKHPHrkxcD9Px547hJiFMOFH+90aSI4jwGyJWmyvk01wlckNcMkG9+Ui2++vn4gryZEXQyjVg02kER9VqeK+I3apvllAy9o8fDZ9T/IZyUeq2gl9NmF/EbV92TNhxs4xMFSaOPbHoG/dX1T3OtQqswo/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSHYJCZi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234f17910d8so59385305ad.3;
        Wed, 23 Jul 2025 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753270256; x=1753875056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9FdRXwfhMMRbD/Zbezab/R43oU6uWy4/YgTXhpJSC8=;
        b=dSHYJCZiNotHpmg1xQOzmLarl3SSc0z6P9a/c3sO/73y/519846CpxN1tfQ34yLIOE
         iPqAR5vCMWrm1yUk1rl9tVU57m8NHBg8+DvtHB5n+zfLKGzMzgbMXSs1CI1DOu9DSzeQ
         jS63pF9HIytR8A01kZK8PYkcecaadnFe+278kV0xY+PGRUtc5h5yML9D3wu8iwkde0To
         JdWxxCBvD55/P+ZmgqSuWZTb0L0E1dCfZON3k6kejZtorVRjukIGQH7onoIahMVVGLqH
         0unYoaA4lGPzbdofKCipftznIiWo6izzmgghnDj6UnbIXm1iyjkcuO4llNPtjP0H4tqm
         1GuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270256; x=1753875056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9FdRXwfhMMRbD/Zbezab/R43oU6uWy4/YgTXhpJSC8=;
        b=AdOzmhEIhlH4kS1fldAIeWRGg9JFS0FvocOdT9fMOuH/my0LPnZCzXYn/ay41ThrOd
         hjm0xjhBquj8xgj0V1XsdQbyMmy1KVdK5mDFRfVyU8UWBQzpwrYwUu3rIAiD+0vJ/+sn
         XFo63hpaLSZaG0iLeiYC9C/7cDo8q27QXvdxFUMRkrHK/C8px8Pzi2qNPGT8ng3MlKcs
         T+8l4M607mlfiFl6JTAsaS6oUvevtz3LGBz+PBOBYEnTUuNhj9SvG5P7mmTYHKXd6li9
         aIjPVqDykFBrGKzmGKSMBfJDVprFlTlT7zBJ2ZC9sRXhEorzu8+he2A5Uatna93lcGqB
         ZFvw==
X-Forwarded-Encrypted: i=1; AJvYcCV3bl+/opgt0YsdmeRZwkFMLDRper2atwGWMkadOn2iXUwFj2zJrDL4rcKmxghAf1zYb6YCuihtQ8JZE9Y=@vger.kernel.org, AJvYcCWwM/U9OXZ2mU+UwjNi2IHLvqW9QquEix5X7v1bcv5XUe1GoL/mtO0kjAhjYoFt9/KFVRCYqALl0VtVvFOjROxd@vger.kernel.org
X-Gm-Message-State: AOJu0YygVQ3cqZWBik6rvL2AnFTtSa+Q8pHUnuKBF1do2MKTamy9pc2d
	vZAMtFjeNeIDeFdlXCiy9duxakybqYx1pBP8pJAQOwX1BpYNmy92l3fnp+Dqq/gh
X-Gm-Gg: ASbGncvYtdFFEpdsahlEvBPIwnoOZpOvwJolMVgcB/tZLVvjypZSiSo/vsGyRT6iZ6l
	T3jCB0wN5f1vxCdU2LcRG9ljk7fj651ZOb6sTdULQvE0RRUTb5pDFaBqjm8aFKEwDlozpN7eptX
	skm2VAvZEik5G9Knz30wNZsQZh+Gd1G6DBFlz+WZoxf3eoGhqkjjgofmNs/NW6IGgYkZz5VyTG4
	Bea6VMmeAPhHj40RGlvC/G1ibT9VXdXDtDQm7+7Lq4Xh5/K+sGtz6ymz87m1nOAoi5b+/YjBvSD
	KiZo0jnd2kzqT5fRoWy7YkM65jtPAoKt9luyuxQtXdUJ5QfsvNIx0ZxmPwpipGnWbiuON+bmGFd
	opbl9AQekCqgDh8rgW8wU3+0PexhHNqzpomrRg7/JfGAmv9a/SHA=
X-Google-Smtp-Source: AGHT+IFm5D42A8rW7gtmyR7fdzi/MOVmHdHVNS5Z+T+85KD48ZLmyVV+6boqMsrgb0UOxUyG/J0QjA==
X-Received: by 2002:a17:902:dcc5:b0:23f:9a4d:2764 with SMTP id d9443c01a7336-23f9a4d28bbmr17820135ad.30.1753270256034;
        Wed, 23 Jul 2025 04:30:56 -0700 (PDT)
Received: from localhost.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2de8sm94712285ad.11.2025.07.23.04.30.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Jul 2025 04:30:55 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: ziy@nvidia.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	broonie@kernel.org,
	david@redhat.com,
	gkwang@linx-info.com,
	jannh@google.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	p1ucky0923@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	sj@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: Re: [PATCH v6] selftests/mm: add process_madvise() tests
Date: Wed, 23 Jul 2025 19:30:44 +0800
Message-Id: <20250723113044.40876-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <1C468AC6-C55B-41A3-9335-65B03EF65B83@nvidia.com>
References: <1C468AC6-C55B-41A3-9335-65B03EF65B83@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Here an invalid address range is provided, since pid is checked before
> address ranges are checked.

> BTW, the size of iovec array cannot be bigger than IOV_MAX. It might be
> worth testing as well, if you want to.

> With default_huge_page_size() -> read_pmd_pagesize() fix, feel free to
> add:
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Tested-by: Zi Yan <ziy@nvidia.com>

> I am able to compile and run the test on arm64. Thanks.

> Best Regards,
> Yan, Zi


Hi Zi,
Thanks a lot for your review and the valuable feedback! The issues you've pointed out are very helpful.

Regarding the logic where the PID is checked before the address ranges, 
that was an oversight on my part and I will fix it. 
I'll also add the test case for the iovec array size against IOV_MAX as you suggested.

And thank you for adding your Reviewed-by and Tested-by tags when i fix this.

I plan to collect all the review comments, revise the patches, and send out a new version 
with your tags included in the next 2-3 days.

Thanks again!



Best Regards,
Wang Lian

