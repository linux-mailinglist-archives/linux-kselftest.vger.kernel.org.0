Return-Path: <linux-kselftest+bounces-28784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B80BA5D3B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 01:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD897A76DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 00:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548B7082D;
	Wed, 12 Mar 2025 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YOouwTYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE81172A
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Mar 2025 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738888; cv=none; b=XJKbDlr/kGHDUJGpf8qEmPVfVfA7ppvPskxDGC9dGeGsBm1SrE2osSLrVzw6oCUPueK5j8AcT2TI7ESYLMWz6vPkQerq2/rtxQbdo38n/m6thFmTBLMkwKt6TNh0tP4zx47MA/3MZLb5bMAdM81toHnNksZw2aUa7Zsy0C7FwRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738888; c=relaxed/simple;
	bh=H5++SEOlYVvHKWlmzOVPPdCy7O19bFEfJFTgn0kXp6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fX7Loc+6zB+robZblHD+TG+Tm5ekm/1tOOIiibBvClqiU7lqqj4ZtOhUiV/WGbGGehJedwKVIPi5nLIjxYgHUxM5rE04Ezk8FmlDjsB7887bRpDJ68+WSzmZ/lpuEFpFIS7uZ9OBGmIA9ndZ2V6VQ3Yy6VKIj2GA9CxavLPIWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YOouwTYm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e616736458so576504a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 17:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741738883; x=1742343683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxhTVWfKMvwlygUn42tfW0inla3um9pm5PRUxvke0sk=;
        b=YOouwTYmElHEvDj3gkv9FMjcMJdW2j5KeLo5+lYVNsjbiPKl0EM7sFYbpvWXLzoBeW
         sm4bsJ6vDDil6mRIYFFkylR9sO2w1plR7RHp62o5JnNS2R8gujZRPMScPbwqg/LYh+80
         K10BSAPW32Z8bMCF6WBRSlNZLp3DKqTruk18Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741738883; x=1742343683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxhTVWfKMvwlygUn42tfW0inla3um9pm5PRUxvke0sk=;
        b=rca7I/dDw2+f9baHYXGmqLTXWlXLf4YBWb4ob+BdnVUR14kZDfVxz/tNWY50I6Ai8P
         XiyquOVrZUFGv/ljeFDtxX2W/DaavvHY3cdNniQOZpidy0DNpm+45kxXrXoj45MKWAXL
         r54f7jrXlk5qsgEt7Io19CNpkfugufWVXI/N/+/wYlEvWp0K3GOdKyLfBBB1YCKXbVRa
         rYntMEih4k10oapnZndVG8yNpcCvEZ8fHK0dEpaPq0JwCqCWO5K4N7wK/orV5xEYL+PJ
         86eWhUHtX0Ck8uMMy52EVg/Ga5/5pNpTHukF0ZQh63S5FKqbpir0BLH0Siei5PrNIsjh
         kdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0NWCjIqRsnxWNv1/uz+i+zFVhML/KeWxZGv3p6t7hxtb4RGUmNb48JAIB9lREOUlZezBEgQmhajBQLC/FlTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmahbBCM+4xEqE50d9fFQR2bbtq29p+9W9Z+HPm1tAxdklIXX
	08C/1XQAC4XGjMOp6hFKMFkHmelELiZ1IKo82vLOmUHZ9+bj+D0f1B7fzvV2bA==
X-Gm-Gg: ASbGncteTDUukOuHk8m+5I8coq2XFicH62nBREWlf5XWqcgEf1dQUdwFAeAp3/P0N78
	MYnrID+Tws7LMEGf0DWtx3Qju4LbcbLJ7I+AUhxVc8htd81WyXCdCV8V9iP4s1v5hBB/XejJw+Y
	VI7Py3wgkFjL7DUyehWtae12cXtb+h71Cp+cKklINNU2Zjd8uWTN9JrmH3noDWN+w1rz7AcHTJM
	jZPPU6jlnNP0P66j4awZ1tdh3J4bcOljW35eFJCDnFFWXcZxYXufynHFQFqyw8m8UzPYKt3jxQY
	pHOsqX29x4O3dQ+8C3cSDI4BtJDI7JcBLC2q98uvLOyFD3tgkoW5Hn+Sctud5747ICg8oWX4yBi
	szS28gb7B5ZI=
X-Google-Smtp-Source: AGHT+IFtgvPPWm2btr1Xtn33I57TNFhVpEuzGkQix5y9M7OehAhXbs7W3QjpSSzY3kDwK7gNa2Zc0g==
X-Received: by 2002:a05:6402:270d:b0:5e0:8b75:5470 with SMTP id 4fb4d7f45d1cf-5e75f2b404emr3051425a12.5.1741738882887;
        Tue, 11 Mar 2025 17:21:22 -0700 (PDT)
Received: from cfish.c.googlers.com.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7669fd0sm8846503a12.51.2025.03.11.17.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 17:21:21 -0700 (PDT)
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
Subject: [RFC PATCH v1 0/2] mseal: allow noop mprotect
Date: Wed, 12 Mar 2025 00:21:15 +0000
Message-ID: <20250312002117.2556240-1-jeffxu@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Initially, when mseal was introduced in 6.10, semantically, when a VMA
within the specified address range is sealed, the mprotect will be rejected,
leaving all of VMA unmodified. However, adding an extra loop to check the mseal
flag for every VMA slows things down a bit, therefore in 6.12, this issue was
solved by removing can_modify_mm and checking each VMA’s mseal flag directly
without an extra loop [1]. This is a semantic change, i.e. partial update is
allowed, VMAs can be updated until a sealed VMA is found.

The new semantic also means, we could allow mprotect on a sealed VMA if the new
attribute of VMA remains the same as the old one. Relaxing this avoids unnecessary
impacts for applications that want to seal a particular mapping. Doing this also
has no security impact.

The mseal_test is also modified by this patch to adapt to the new
semantic. Please note, mseal_test is currently undergoing refactoring,
and eventually will be replaced with a new memory sealing selftest.
In this patch, I only make a minimum change to make it pass. I considered
adding a new testcase in mseal_test to cover this new behavior, however, the
existing mseal_test is using wrong patterns and won’t pass the review.
Such a new test is better to be added in the new refactored memory sealing tests.
The refactoring is currently pending review [2].

[1] https://lore.kernel.org/all/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/
[2] https://lore.kernel.org/all/20241211053311.245636-1-jeffxu@google.com/

Jeff Xu (2):
  selftests/mm: mseal_test: avoid using no-op mprotect
  mseal: allow noop mprotect

 mm/mprotect.c                           | 6 +++---
 tools/testing/selftests/mm/mseal_test.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


