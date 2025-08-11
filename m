Return-Path: <linux-kselftest+bounces-38651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073AAB1FD82
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 03:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B427E3AF6EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 01:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5700423F403;
	Mon, 11 Aug 2025 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gioo5E/I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BE35971;
	Mon, 11 Aug 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754875947; cv=none; b=fOQcbg1wDTusHiRE6DyWSE1vEU9gBtdGnGV1VgZwittz44ID5JWXzGLc5Co397fgE2cslTI4BT6gioL9PSiwx9NriAit8prnm81GIQ7Xt5+RCN4OOEQ8e8M5c9M1QuFJdynuEG8dpDlWvmGFpKntVloSHYL/gZkKxcvAX8fefok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754875947; c=relaxed/simple;
	bh=ea3MqeO9Ps0j8dDC7AbHgbi3QziiGd9Hvht8UcE3yOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5r7ia0zBDtksYSTCRcP6AwgL/Qm1dYl4H9HHEPPy2biZEbcJdKtdxpZFKBkm8hNEgeLdprv3dRB5bdj93uAo0oLxQs//zAuBl2d5fssjZcDa5v1O6Rc8+jcDP9fsnRnTxHxOMqwW7VaF0/tkaYknPCLlCNM+D0BIIR3uacAlGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gioo5E/I; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76b6422756fso5411993b3a.2;
        Sun, 10 Aug 2025 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754875945; x=1755480745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea3MqeO9Ps0j8dDC7AbHgbi3QziiGd9Hvht8UcE3yOo=;
        b=Gioo5E/IL2G8TuPVg9r6jJUqgUruD1HPDoGs2XoZn4k33T0eWW8qbGsmdTpQkIiN2d
         jeCAEpEavVm/NHZHM5GoMcSZPFv+okd58UdbZCzWzoxB6gkOHjI09TlHOsfExJim6zmi
         VwO0kxIcvLPn6MHVJUuKZ3ujd94CpJOMy4YJsxYy+16dk6xOPjbGpfXGof7gWycIhq3B
         Ue/cnKsGUFnrmxzzSK6bYkUsAlErNlo1U65UGzUsecr5aDJCl0kfkJM/0jWtulL2qomr
         rafm4kHd61qk57c2EDSAuc4/zQOZvCKn8W5zEZnT0YCJiAaDM4ntI4nRXWYk4dDx8NB4
         RxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754875945; x=1755480745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ea3MqeO9Ps0j8dDC7AbHgbi3QziiGd9Hvht8UcE3yOo=;
        b=MJU/laocREk9xOEXXbUkL5Y5UyVJAkx7Afw8vj3o0CSb+9ISDNmtqmsmnVjNwMhl5f
         iYKRa6gg0cvz9Qhc6ZFgHBmN72sha+Q8kGDaoCHfxegjzaEcvCT9EvdTiyzkJMqUmxP8
         CM5yv0dtr2WqRPyKe7PAluEfrV1FTaYV3+pU/1tLlHz4aIxiwNTRge6xpqmwI6jsWd0A
         YGQHAGz+2EiUzIfJpqvbK07OiM2Gdt/QLKTv/TjGrcmZTwDJKjctOpmtWtIjtZS2nzq7
         /Ro+qNFOzD6lQlOV6QkAGfeaIsrYOCuvcCCLY1kUUNdi4HFRy8Vhs33CTQBpsA8I3fuj
         K3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/G3lcy7yM7T8Hl6S8i+UP0zcPEryCRFF6+7K6+yYOmbSH6HZeswUK/AewlFL+5OXd4RKrzQ4BdDe66k=@vger.kernel.org, AJvYcCXlL/n7qlji2UleTrWdWPu5hZa1ms2aRK9Cvyx1EIUvIfmaVz5kdMWqsBw5izKwIm+4WDvK5hQ5ebxwmxKfJiis@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fwrA9WJPMSfNCHoN4ap55/vgZcHH1thoY3HUX7v7XQs+W3PB
	IXYZcblqjeKBvlZXZ2Vo9B0ggi7F4/ACTlqh3vrPnmvRRbkZ+kvqV42f
X-Gm-Gg: ASbGncsSv8XWwfva7zRCTrZAYFKvO1NOJxy2CknuHZ+bggvTjb4pEjlOFTkaIJcXzhe
	60h0/UFt3jjl4Qft8RzrVPDPB0u1U8TuV/kNBW7p39It3Z58AdlKH9cchibVabYkjh7uwztTpav
	/RQSpiNzSSRe79Q+FTrYfcq/8FksoPYcfK18e0uk52eRWnzGQZa7yLUUS1rOVijnSjc8z6bXJfM
	+wC1hBWSNKZhF8QQX4jV/AYtEPVLCneBB7IWagiKvDwlWicjVDANSks4TfyMn+Olxg/tism5+Ak
	Cp8QPb3p08KcrK3Z8M1J/3EO+Zdw9z2JNzbEy8TP37H8NQX67ylS+7R9eqS6GQtkwVEcAAm7vWX
	fRxaO2WzdxiEfCKV4W9pn453EfFbD0aUopFsKGbsmnyYN
X-Google-Smtp-Source: AGHT+IGpzJFikA/vM1MNktbjWzEslLwV0wXBaZB9sZ67jwW3oBT3kMRiGhbYbC2PB6j2JdOKoYlF9w==
X-Received: by 2002:a05:6a00:1a91:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-76c461b8d4emr14929265b3a.21.1754875945173;
        Sun, 10 Aug 2025 18:32:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:8900:21f8:86c:416a:76e3:d99:97b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c34d23f01sm10126909b3a.23.2025.08.10.18.32.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 Aug 2025 18:32:24 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: ziy@nvidia.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	dev.jain@arm.com,
	lianux.mm@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	richard.weiyang@gmail.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@suse.cz
Subject: Re: [PATCH v2 1/3] mm/huge_memory: add new_order and offset to split_huge_pages*() pr_debug.
Date: Mon, 11 Aug 2025 09:32:13 +0800
Message-Id: <20250811013213.54499-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808190144.797076-2-ziy@nvidia.com>
References: <20250808190144.797076-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> They are useful information for debugging split huge page tests.

> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Yes. LGTM.
Reviewed-by: wang lian <lianux.mm@gmail.com>

Best regards,
wang lian

