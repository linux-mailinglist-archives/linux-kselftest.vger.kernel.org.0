Return-Path: <linux-kselftest+bounces-41946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE86B89970
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA355173B39
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142823958A;
	Fri, 19 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NlzSGwrP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00892224220
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287193; cv=none; b=C17cbmMYKShDQUvt8QC8Sk88XKjG9Xi3GsBsWJS4j0uTk7k1Q3MT/1mOWvxavnxpiTPygbzMCOVNpWJLUZV+CeJLQThW+b0gFi/JSZ3dtDntj7qsdMW2jeZxCl8nBV/1C/Kty+1h1SjCRN9NAGkEhRXQmmTjDvYAQmDWL6HgDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287193; c=relaxed/simple;
	bh=r9AJTIvnzjcfdGx5s5XBeHfnb2DJucUHE/cz3DMfgHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fa15hlMamuJHw+PJpNadCJsphXfBe44YkRwMrGe9CX7P+3s/J/eDfEI05CD371t0aoCup+yOp7GFZRNl1UhGe0WsYLiygJrCKwg8IpFZAv7UzrqEbfRXuwXDOQisYmhrDDYVnFPRASbJGI/CzhOgeBSkze6M9z5CeuuQhMeP0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NlzSGwrP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso1937929a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287189; x=1758891989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y44nOyA0y8OwFwmSdVnNikf+85sx5V+uPvR9b6gSko=;
        b=NlzSGwrPrHaZRi3wQNBC7Y8ZDF+dCbMg0EPslxHres3uzvhzagQvGApYsDHuGQGhAS
         WLn8G5I4uaYuTX5w+sYXIrWH+1o1pWLB30pgWfZm53zpwyWswlQnBI4Ph6PjNEDMiUCg
         9SkRXz7UwqkokizH55jRR0ihpiPt7z47Na1spFomeW2U33YFs9IbFh6QvJ1TV6EECb/D
         gscMONKPIhLpEBVWKs8/qesjEFOeZszNm1NFGi6Yy/IYJfDTBgsIxG7LteojGHy0xPKj
         VoEYV34YpcXtYu6mLnxyVmwSL9fxqsJDkBLO5trj57DLFXlNWKNM6UN+sLNRU8nx7+pH
         5Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287189; x=1758891989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y44nOyA0y8OwFwmSdVnNikf+85sx5V+uPvR9b6gSko=;
        b=M/30zaRAGbNG2zaZiGZc7A4ZBXzJdZUHKAUiqJIkKGISjiEMAbebsO2l+wl7pgxSQq
         1dy1D3teD58gGfhH9Mx7bHyhXmzxC0g1jISm6sEbTANii9t2bKBx+xwPu5yqJfRKO/j/
         t2/D5F+WUTernR1JVRHgRhkId3cozDEpjk/3/fI10gReqQVHdmCwJVGmjNzxQQRnXQYH
         Cc6SN70605enFw/ejiHXQdnKUT48/dC2JrZsRljHoCpKgbwN9gaXgKUS+CVuWDA1pEjZ
         dSvuXhiov7PeRTXcswcIymrRr8olvNBzTRFUsFqGl28fA/+rrOz/c0t1eKabvS5npd8s
         3RCw==
X-Forwarded-Encrypted: i=1; AJvYcCWu0a7Mc3JjPzPB9iniZ64kYt5Yc8yQAb0ZB3nB8uRRSkctnModCBC/pwKRguhoMucycQxe4KZ3kOUYMAVMAKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3998coannndNA/Csc9SfZb+a4iR5v3ou+XB6EUdHzGhdiUjH9
	e/N0uQKjAMbM4/RDurlKPCS2uvPRzH3pz5iei4hnCqkXCO3Hzkkr6eUPilSx7IQS+pw6YgW0UHz
	QiA4a
X-Gm-Gg: ASbGncvt0ZOpAD7MvFAF9PhVSI/ijbBbcdypX/nPn3sq+4UenGZluRqo6TJ/Z0WwLul
	3NW0N5JS0p26MQ7G9VfQC/1Vyr/EDH1G0FF4E7sizbh4lZmn7usjZj5R/zXmhfWGHRsdPxpy+Mo
	f+tGLrq/h2bBVSVbrd0TfDlMIkP9UKjYmBdKtZs0x2S67lqmpC+nMEeaTeSZQGAEbhkn6OGU9eG
	4XLcd4U8eCEiVV07s6GBAXcORyX5q8eZr24pJxaQv9eVhuGfCsfdpMNV1RhfW3ltEy4V3cvIG+A
	IPXK3XDoHLga9jOJjiv9USWrYERr3A6m1KzhjFGuPl/bMZZdqIvIl9BdoZLZNvjtLdf/Wo5N1SX
	UTE3hTSj6Ey2ooO6Mo1jwAQrRP22UTUw3R4atCwNA2Co00gQ=
X-Google-Smtp-Source: AGHT+IHbCYvgUOcFkkck27B0rfSlhrmfVapbla8Z6az+fBKLroeJB8snmFXCKURB5BgfWYqSEvjPWA==
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr46541595ad.17.1758287188922;
        Fri, 19 Sep 2025 06:06:28 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:28 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 0/8] Add selftests for mshare
Date: Fri, 19 Sep 2025 21:06:13 +0800
Message-Id: <20250919130620.56518-1-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mshare is a developing feature proposed by Anthony Yznaga and Khalid Aziz
that enables sharing of PTEs across processes. The V3 patch set has been
posted for review:

https://lore.kernel.org/linux-mm/20250820010415.699353-1-anthony.yznaga@oracle.com/

This patch set adds selftests to exercise and demonstrate basic
functionality of mshare.

The initial tests use open, ioctl, and mmap syscalls to establish a shared
memory mapping between two processes and verify the expected behavior.

Additional tests are included to check interoperability with swap and
Transparent Huge Pages.

Future work will extend coverage to other use cases such as integration
with KVM and more advanced scenarios.

This series is intended to be applied on top of mshare V3, which is
based on mm-new (2025-08-15).

-----------------

V1->V2:
  - Based on mshare V3, which based on mm-new as of 2025-08-15
  - (Fix) For test cases in basic.c, Change to use a small chunk of
    memory(4k/8K for normal pages, 2M/4M for hugetlb pages), as to
    ensure these tests can run on any server or device.
  - (Fix) For test cases of hugetlb, swap and THP, add a tips to
    configure corresponding settings.
  - (Fix) Add memory to .gitignore file once it exists
  - (fix) Correct the Changelog of THP test case that mshare support
    THP only when user configure shmem_enabled as always

V1:
https://lore.kernel.org/all/20250825145719.29455-1-linyongting@bytedance.com/

Yongting Lin (8):
  mshare: Add selftests
  mshare: selftests: Adding config fragments
  mshare: selftests: Add some helper functions for mshare filesystem
  mshare: selftests: Add test case shared memory
  mshare: selftests: Add test case ioctl unmap
  mshare: selftests: Add some helper functions for configuring and
    retrieving cgroup
  mshare: selftests: Add test case to demostrate the swapping of mshare
    memory
  mshare: selftests: Add test case to demostrate that mshare partly
    supports THP

 tools/testing/selftests/mshare/.gitignore |   4 +
 tools/testing/selftests/mshare/Makefile   |   7 +
 tools/testing/selftests/mshare/basic.c    | 109 ++++++++++
 tools/testing/selftests/mshare/config     |   1 +
 tools/testing/selftests/mshare/memory.c   |  89 ++++++++
 tools/testing/selftests/mshare/util.c     | 254 ++++++++++++++++++++++
 6 files changed, 464 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c
 create mode 100644 tools/testing/selftests/mshare/config
 create mode 100644 tools/testing/selftests/mshare/memory.c
 create mode 100644 tools/testing/selftests/mshare/util.c

-- 
2.20.1


