Return-Path: <linux-kselftest+bounces-37873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6032B0F0B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 13:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02B81628AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4469290BCD;
	Wed, 23 Jul 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNvnqvvw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8DE270ED9;
	Wed, 23 Jul 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753268772; cv=none; b=NJ3XM9/jljJBWS8mVA63beTum7wW9KJFop6bkziUX2OcoeEeDPLyqxeMC54dhAQlt4sCPaBZ5zousSiAGa/mOQHm9uyWpwdfS9b2pebGJYPdhSiOQZtxOWlyDu21JJWRxhb648jMaQuFv1EZiCzAt6Ywtv/MvUmUTQdelIHZskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753268772; c=relaxed/simple;
	bh=rLzvuH/xAJ/NxbCXzGz0I4CbxebZMmvV5T+XdQSnKbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LFyGVcnHwmEpbyyO/7w+VjJiRGtbjs8E1uUg8NOBYNELnSM9dBNffTfUxU85hfniQx8VbBjHUgs+B+38O6MUxSr6AH4EGmNueO8QQqKyCm/z/NLWQ7rmktt7AtARrxFladiYXTFWI93WrAwWIfhwzxEjnn/79LVkh6wixm85s0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNvnqvvw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-749068b9b63so4336468b3a.0;
        Wed, 23 Jul 2025 04:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753268770; x=1753873570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gggYC9jdzO8cIJk00SwXWq1Yluv2kBVse1A4jgDLjE=;
        b=XNvnqvvweyft2QaKbTDEK0tJjMr8bVsxj5eHkLJIgFDD1r/BYiJ8BL7DtjHjAdteUs
         +PXfuE8j1NVv4GC3tGfkePS1MVp/H/+lDkJVF/Gr216nTz34Cg/+YWV98+0wkkjCJDzN
         7EnM8DVaOV1wsfdfIgV5SZPMm2Rxpo204B3/uCqLHSSm72yXvtaiYcd0VOizkuZOwsgk
         wOqv9h48IxBSBJZHNwYQgkIPW5OQrHBhOCpR2eKGeRDRxpb7JZfRRl0T8EAKmdAY6MXH
         lRKo/4TlYr4O/Sk51KpU34dJYBsXSR0SWtmbSujYY/mElf5J91A3tXM3PjfMkpIsZ4w5
         7qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753268770; x=1753873570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gggYC9jdzO8cIJk00SwXWq1Yluv2kBVse1A4jgDLjE=;
        b=L5oOP2ZbpUBE6g9jlKJekcB2vCq/8PuNcZeD0chpye5fS3WmFm5Qhz+pXDQSZ+VEhj
         th36Rb1k8uee9BLIisQpP1C0LbY0DPh+YhAxBw+8t+9Y+R8ZTeKzIB8QEPeKkBx2VBkG
         WOLryv4NOYXaEwNBqtt0/NGSL1ffQo+BdgKJ89700V7Nc+6yRJGHpvYJpXCU+JxPm1kk
         K3eWZTNbQ8yfAoAY3wGQ3XnW345PKKkYmZrpHLy1l1/ZSz02cdoZOW74FlVwIYsQ6nlj
         1RY6kwRIjmBwUVfig4mKCCeybNpva1v9Tf3lr+NrXOlQKih19EIIhge76G9J25bQ7s7m
         KW5w==
X-Forwarded-Encrypted: i=1; AJvYcCUNz70sPEUfQjNCuEQ/f8vIpnbztTRR5gBZuLt504U8oGR0ulitMWvRFIpKK7VzgANYLJSUtCpJnWhIpQo=@vger.kernel.org, AJvYcCWkwR+D5e5smrmkG0YI5hD8sqykMJOhGUAbXwS0qp7h8AnjLE3d041l6myq+KbgmHCK4FOhguYaWt65CIzgVy5A@vger.kernel.org
X-Gm-Message-State: AOJu0YyYxy4Mb8/SKWBpCGfFnl0zO0gdQE5gXs4aBKMSfez3bfuM1yG9
	WOp/ekfE34YdwDku6SmBNFprSLyn+i0GqT3EWaQDIWA+4VyTTI+EoP6r
X-Gm-Gg: ASbGncuoYP32cHzGJus81qA0+bGT/AtiQlCJkaj0y3fsvFkLFoDJ2K06sRS7ks3xtn5
	vAOyLDu7e3X9ep04cRLzNVgCEsjaWjRVHTbu2ZWWOyKP9XiqdaCvFhb0bY/oNVttrd250v19FTD
	3+CaaroJ2XUHtIo8FOVa3oQIxm2MLz2Vn627YTCzuK/5mgyN7IV0EXKqfmZIF/DufDkD5ZCLBmW
	NwLzpaHqUIotkGomA2Gp6x79XLFi5avEz7mayu1aS8eSyXRM9efQs5WHtjnclpQZHUoFAkHSmQF
	p3sefs24s7dHS64qemRvrrlKsp5hyDZ9MutmRVS7g+/GJPcSUhoxWY2fiEtaMn9XyGpnvFUr2LX
	5I/zvVWO2HCDBxFQ0DTC7MBz7r2PLcQwge1FoLekzico/1izj7Hk=
X-Google-Smtp-Source: AGHT+IHDaD0SAIqDCHFQ5hg5e0ciI8y4TK/NnpJ9dwzw6/StwdgG/gRPzHcyj8m3t2GJUnEUQYB+Ng==
X-Received: by 2002:a05:6a20:748a:b0:239:d43:481c with SMTP id adf61e73a8af0-23d49141c0bmr4231501637.37.1753268769719;
        Wed, 23 Jul 2025 04:06:09 -0700 (PDT)
Received: from localhost.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8dc32sm8771650a12.23.2025.07.23.04.06.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Jul 2025 04:06:09 -0700 (PDT)
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
Subject: 
Date: Wed, 23 Jul 2025 19:05:59 +0800
Message-Id: <20250723110559.32219-1-lianux.mm@gmail.com>
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

From: wang lian <lianux.mm@gmail.com>

Subject: Re: [PATCH v6] selftests/mm: add process_madvise() tests


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

