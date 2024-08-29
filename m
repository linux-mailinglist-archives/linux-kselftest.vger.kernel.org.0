Return-Path: <linux-kselftest+bounces-16736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48445965236
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 23:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2FDCB2402F
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FCE1BA87D;
	Thu, 29 Aug 2024 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gfsC/wlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E21BA27F
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724967845; cv=none; b=tX+Kwq4vwmD4HZGnYVAv8O4MSAmKdrxglFAWWiyOEGbAyHE3QFhWP/N5g8qakrl1GB4PgPl5IvlGRg9PRGHFADf2se80qNx4Q2d9cFrjNgHJ2br7Sj7XjCFTB7fXXssfjv/Jg7T1WBZlJZxdzXBf37bcvNUHc7jXwUoXAXiCFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724967845; c=relaxed/simple;
	bh=eHI+f1Eqovx5OQwndHYsw55wZ2XeQdOu0E/2/hhAMrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXGDWi0yArU+hOBcu7WdegQgPZC5Qqz9F38Y6Kr+rXhM9OLmQufUKNT6yGf7BlE7G0AXE722PquZGsdlj8VUBcUazS2gy6YYJhNF1970QrcuKfLPrTBsDfSf8agqEc0uDooLr0OANn4UnBwcWImT+dOcNuiN0OOHCAhM33rnjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gfsC/wlx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3cc6170eeso182941a91.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724967842; x=1725572642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IK5nX6Fz7aZSj3TONXgJWUNXXUeXSM9VDMyRB+JVgZA=;
        b=gfsC/wlxKr5iTDLhfzCIHcbSHCHv195llFGSCvkAkx1aNgUZcAGC/O/kw8dtMJW6iJ
         VSGADQrtFQYtgD7Ybt3oRSCsPuPxtZ0rRHAyRSVb5Nhjz6aCNfgpc+bMfYP9BWuk4Azz
         IYPiBTfDf+7Awn7m2u11n51DE3l7SEeYWyXhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724967842; x=1725572642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK5nX6Fz7aZSj3TONXgJWUNXXUeXSM9VDMyRB+JVgZA=;
        b=K1II74G7fqkhBVlv0PrJKXEwxilC4PeupRqJg35swSZIz72qAKDhIeHuFfXEerX1+k
         ob2XMl9DuSIpbsAb/i2axBdzWlNiK6//+ZHyMpPOITAumYHi2rwa660VOHzyl7cZt99s
         TmcHSb2z+pjCYdbnWa6hgAbC254JxC0SszBIPrkgp7lA1/zqrbuDfSn1Zf9NgvLEFkiW
         lb3re2EU04T0uZEG87pUmyAh3bSvpjxg/5l3vLrvHsvpeUpunV2vBKsjoD85HRfJqm4c
         YVPys9LIhmmFjYWHZSK3/+4QYVqX9c7FieJgAdepju4QQFa+9HD5mlMVHjRTmh1SC3hr
         XCfw==
X-Gm-Message-State: AOJu0YxDpKFr5KUgFjOffA9UYvTAaaPdP9obqsXHJadD4HfOTQWgabfk
	o4rXkR4fvT2mM4pKGXiKG2AzXiFJzO68l24h0QZTpBPgnYyPO7uxpTi4UKfAzg==
X-Google-Smtp-Source: AGHT+IGFvjpKVKwU+AAy50ZE59B8TjM2zpkvqC2OVhuQeRtuultPa+ORe7Ydhsh/c2eWukZ+bzk+sg==
X-Received: by 2002:a05:6a20:6a27:b0:1c4:dba6:9eff with SMTP id adf61e73a8af0-1ccee3a8b83mr193225637.1.1724967842061;
        Thu, 29 Aug 2024 14:44:02 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-715e55a94casm1592892b3a.70.2024.08.29.14.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 14:44:01 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/4] Increase mseal test coverage
Date: Thu, 29 Aug 2024 21:43:48 +0000
Message-ID: <20240829214352.963001-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This series increase the test coverage of mseal_test by:

Add check for vma_size, prot, and error code for existing tests.
Add more testcases for madvise, munmap, mmap and mremap to cover
sealing in different scenarios.

The increase test coverage hopefully help to prevent future regression.
It doesn't change any existing mm api's semantics, i.e. it will pass on
linux main and 6.10 branch.

Note: in order to pass this test in mm-unstable, mm-unstable must have
Liam's fix on mmap [1]

[1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t

History:
V2:
- remove the mmap fix (Liam R. Howlett will fix it separately)
- Add cover letter (Lorenzo Stoakes)
- split the testcase for ease of review (Mark Brown)

V1:
- https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffxu@chromium.org/

Jeff Xu (4):
  selftests/mm: mseal_test, add vma size check
  selftests/mm: mseal_test add sealed madvise type
  selftests/mm: mseal_test add more tests for mmap
  selftests/mm: mseal_test add more tests for mremap

 tools/testing/selftests/mm/mseal_test.c | 829 ++++++++++++++++++++++--
 1 file changed, 762 insertions(+), 67 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


