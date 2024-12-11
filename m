Return-Path: <linux-kselftest+bounces-23145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141529EC45B
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 06:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B4188AA97
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 05:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2551C1AB1;
	Wed, 11 Dec 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SlFjRhxd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BE4A0A
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895195; cv=none; b=oRsVk0jjAbnZrCSVXeM7njtuqaLIBE8DSE38qJwHfkRz1355pX058fnFVD0VUFppcUkkgovKkv+1pGcbiztCdDq49XoxBQnrFFOXzaiJdG5k2lPMCSmndtxaXUgdiE0SjtwgfNV83s3uXn2b+v3qEIXxeZsikmo6X6bSyHie7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895195; c=relaxed/simple;
	bh=h7gVITOrQkSkReYxOXpU0/sJiaPzKJ50gjtWWld/7oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXde4/DJ8RKLfei0yAEd5j7JaVIPDYV3S2xoSI28Gz1lp+43X2XE72fi5oqMVWQep0eQJFYLrepAW5LdR1YBszxitxB3Z/VoQIqm/mcx0VFzqg5QRz76gS8p4yARzNawkCrOvQ5HWG3o7TGBogax9eG6EZt173b/CezwUmaYAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SlFjRhxd; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee9b1a2116so719074a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2024 21:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733895193; x=1734499993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcPnvSnitIZYgE4SSPh1sjaLPoyZLCmck1DlGFSmRwU=;
        b=SlFjRhxdHb57OIm1Xj5HroO/7zQ88RGhxOTrr7V3TThkWDUecrPhV8s3mPSxlHGipX
         3hZrerj+sgz3wuvt3LkYy7t4kds3cEM6RgRoRasfXegQssvZkCat0Pf1Vbn6pbg1n2Jo
         pHR5dKjZ1f1l3R8I0zRYnl1dJ3dAn5o9Aif3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733895193; x=1734499993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcPnvSnitIZYgE4SSPh1sjaLPoyZLCmck1DlGFSmRwU=;
        b=HDxKJ06/8AnRAMPVUPwCMnUYsjzdNLANR9o+BVf7FeRpgjLy2B91f3umhgl7xR5Wxn
         +57m2CI+j40wYRCLDPkk5jseUHj18eAe2GLy90RGrgNXIQREf5zpPf9/p49jrpYSmZy5
         X3dAJLvF4c0PW6RlCtJ1WTLHP0uzAgVs0b1qmPfnr+qcd+SXwmVVVAxZaJNZEqaZVp0m
         6uk0jdLW9wp3b7yfiJqUz1sJwY/I24lz9MtzQw2sllZGJlxvYdmiPyQ+7LxqclFqQuoL
         blJ6XMjeNLNJKHlmiA3hYJgXn3amwVSoVJ3kZEyv8nATgqu1beer3/37NVGC7qdMSaQn
         SCxg==
X-Forwarded-Encrypted: i=1; AJvYcCWadCXgKlueVQ/jShSbxk8RXPv23YFg4v7U3PlNEewTyCgOJQ8rem1vA/n/Ahi1LSaA0/TE0mpgJ7ZH+Ly0zG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQjcexgj+uEOYvniFa7R3MW+53FeT3CbkU/afSpXSzMRXMbZu
	mmHXe2Q9/gkCFjedPLpw4K13/Pl0skB5TPpTSXCQHcKZwsVU5q/cyhCfFPWyUA==
X-Gm-Gg: ASbGncuUQqVpDBPGFqTrzV1beWwaMXe+Bd5j6N5DYGcBzeGcMz9PxgukGBLSZniChZx
	SVpxXRId7QWXKewSjiFzaCmgQyvqkKDXDsmRC6p7r7rSgKxvqQfcfB2uIRZh16mbpnAW1DV90Bh
	Wh7D1+g/ME8OuZnrrkrMDp5rWQQ8mroUFlxpelx4keDY8CJxVV396Y9n3MC8pkYJETJNX5c59+L
	nandqWmYFALEIPOoZ212oln7Nm3opGGlhbaPvlrCLcfETNxsK/LuYDiGqKa2wc91jQGaZfd57gO
	ua+CRu5+lUvt+IM=
X-Google-Smtp-Source: AGHT+IFhn0Xr1EvCCo7gWlc9e87/kYfh8vrGg7FJA2vVTx9fVRgwJXmWhxS6Xfg8pWi6I36Ea52j1A==
X-Received: by 2002:a17:90b:33cd:b0:2ee:6db1:21dc with SMTP id 98e67ed59e1d1-2f127f8dec6mr980737a91.1.1733895192980;
        Tue, 10 Dec 2024 21:33:12 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ef4600d109sm10721682a91.44.2024.12.10.21.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 21:33:12 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 0/1] refactor mseal_test
Date: Wed, 11 Dec 2024 05:33:10 +0000
Message-ID: <20241211053311.245636-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This change creates the initial version of memorysealing.c.

The introduction of memorysealing.c, which replaces mseal_test.c and
uses the kselftest_harness, aims to initiate a discussion on using the
selftest harness for memory sealing tests. Upon approval of this
approach, the migration of tests from mseal_test.c to memorysealing.c
can be implemented in a step-by-step manner.

This tests addresses following feedbacks from previous reviews:

1> Use kselftest_harness instead of custom macro, such as EXPECT_XX,
ASSERT_XX, etc.  (Lorenzo Stoakes, Mark Brown, etc) [1]

2> Use MAP_FAILED to check the return of mmap (Lorenzo Stoakes).

3>  Adding a check for vma size and prot bits. The discussion for
    this can be found in [2] [3], here is a brief summary:
    This is to follow up on Pedro’s in-loop change (from
    can_modify_mm to can_modify_vma). When mseal_test is initially
    created, they have a common pattern:  setup memory layout,
    seal the memory, perform a few mm-api steps, verify return code
    (not zero).  Because of the nature of out-of-loop,  it is sufficient
    to just verify the error code in a few cases.

    With Pedro's in-loop change, the sealing check happens later in the
    stack, thus there are more things and scenarios to verify. And there
    were feedbacks to me that mseal_test should be extensive enough to
    discover all regressions. Hence I'm adding check for vma size and prot
    bits.

In this change: we created two fixtures:

Fixture basic:   This creates a single VMA, the VMA has a
    PROT_NONE page at each end to prevent auto-merging.

Fixture wo_vma: Two VMAs back to end, a PROT_NONE page at each
    end to prevent auto-merging.

In addition, I add one test (mprotec) in each fixture for discussion.

[1] https://lore.kernel.org/all/20240830180237.1220027-5-jeffxu@chromium.org/
[2] https://lore.kernel.org/all/CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com/
[3] https://lore.kernel.org/all/2qywbjb5ebtgwkh354w3lj3vhaothvubjokxq5fhyri5jeeton@duqngzo3swjz/

Jeff Xu (1):
  selftest/mm: refactor mseal_test

 tools/testing/selftests/mm/.gitignore      |   1 +
 tools/testing/selftests/mm/Makefile        |   1 +
 tools/testing/selftests/mm/memorysealing.c | 182 +++++++++++++++++++++
 tools/testing/selftests/mm/memorysealing.h | 116 +++++++++++++
 tools/testing/selftests/mm/mseal_test.c    |  67 +-------
 5 files changed, 301 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/mm/memorysealing.c
 create mode 100644 tools/testing/selftests/mm/memorysealing.h

-- 
2.47.1.613.gc27f4b7a9f-goog


