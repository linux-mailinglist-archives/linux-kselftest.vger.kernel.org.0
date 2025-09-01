Return-Path: <linux-kselftest+bounces-40401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6DBB3DB52
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB3B188E7D4
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 07:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FC02D7D2E;
	Mon,  1 Sep 2025 07:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/oSrnOL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258A2D73BE;
	Mon,  1 Sep 2025 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756712604; cv=none; b=VW4lvhpguxvg8jx+iSr9HarnLDI5mgTSLSi4GfVtSrTFtgx+KtEUX2BHbwwScmxsiG9/M9You6Cq8Xo9JHs67T94hnmUMs8VhFgzPzTEz1EOZJ5lI3FNQgkPI9IWPrmOqva8eyz7MReK3mJOClORLZ9Kv+9MKb1SZwyNkNkcfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756712604; c=relaxed/simple;
	bh=knhv0d+2nVhqYKiOMqbzbUPmyrliXFTOCtmL5s3WYLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CN3cJbdJ1vCMv2ctHHPe5ACj0fhZ5i9pYTI/ksrrUg/54B+1qPfKU77xQV4V4GVMWQzgYnmJnurkIp9mPLYh9VD3+9GZs4cM6cxcjf6xHGf8rDgdP/46a6TzWbKaExbjiyFPIoUrUPWAxZa0i3LU3TCHEVl7i4wXknr3rKDvcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/oSrnOL; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7725de6b57dso575411b3a.0;
        Mon, 01 Sep 2025 00:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756712602; x=1757317402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FITNQkMOh5aUaxME66iKDkVB32cbdFQ2UW0lX+cQ0kQ=;
        b=V/oSrnOLgIkE5A40jdgToo6jTyDkMrXgxq057huITRtMVuHBm764YtAlUfnxsUq3u8
         lMbzC3CV7uYNEhqXYHrVK9B4gYU8njeY70igd5T9tapkortIpCgy2/+9YkkI2iFW9BsV
         7n0/gWXlAU3qnjj6nQ+R/8OVlJM+k/bntB8G9Y6uDzal9WWzlSbOL70gebXTEbn18CUv
         lyzPYxL3U4dFALiou3KRwhNqgK7K6JM/0JUgf/CbUIbLUNxQLAeuAcg7QakxuSMdae8N
         ywVjojuQop5Kdu2VpHL/ssz5rWGtQ2w5xLm0EW6XZnhRYMJ1hTWZafy8yREjddlZUCHQ
         yfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756712602; x=1757317402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FITNQkMOh5aUaxME66iKDkVB32cbdFQ2UW0lX+cQ0kQ=;
        b=mwaq8eafOQzZs++30X8a9sAFTDP5zrO1jND8T/zjpvltarPeO+EJch2wSjTQ6Vr8ys
         Lm6ep0ldCHK4QaSaoYaB2ZaQe6BYE+hVz2nb0stwNvCNrNF7PrRpo1J2xsBm6HfXFAXS
         w04bI1qRl7G69FqkWcDZEkGJw64Z1ux+yCDcj6+C2CHuyIyB7FsvoMNhblvua/3s6OGl
         e9+Y5G3s9DTn/HWkUg3fgbClixXJ0N2jQD9jbTlZUM8Vhf11u4l/ts4QZXsPGcOPadXZ
         x2rK6SU98/eGnnqXlzv/rk5eAW6ZG1WursFJrlosDxO2cnho9o9bCJ0issunZ4EJFO7C
         hmew==
X-Forwarded-Encrypted: i=1; AJvYcCVFv9PNhCJa2CsKDUMbx1l3KQirNEriehHF8cwQ7GGHkB0w5Gk9z7FQPF2WVf5VbG50gej5YssRZjxVq3tj+K7r@vger.kernel.org, AJvYcCXOsZJkLQe9Q9eSspSDIXmO1hERpFY+GhtVeAYK3IBPt6jDeJXZ6nAaH0liLR+cUF41sYk=@vger.kernel.org, AJvYcCXblQ1wr/KJzUJUKy9hwjxv+ruzFzRKT/pM2SXIs9kFkKfVR517ZNmSlrQ8Nt4wJmWIm6+GVuxORf7kdO/n@vger.kernel.org
X-Gm-Message-State: AOJu0YwGA8OGwQrN6n09aWjR/TSTpI+KQs0dkhFlohevTnvXfymp0Jvb
	DkBzB897P1nsjJ9++UNkJG5lUbT9PXrAKZgCrOA4J4fFvopx/CObIouzc5cLxkAjJ9zAcQ==
X-Gm-Gg: ASbGnctUK5ZfeJbfYXhQ3KBRBrjjc4kWZ0x/XMWpP5+BZU8xAtvhkTkbtY1qprjR0qo
	VGbW1tXPcaXytm8Dsn3i9CZVNKUlgyIPUbdp9huWSoa25V3yBaXnluYLRQEcQ6f+7fI4GpVCUNI
	TUCAXjM0VSSAHQj/vbqNFFMP9ACPp4o79Bg2uTRrwYk9QAqUDAOhlkGsK3v160mN10x6m+Tu6at
	cbx56Q07fATeq7L8l8iPIywtJT7R2tsJoOUxtJGgCsLSZMTZ2Qpu/TDlb/tAvz+xZBJbtYVHKQT
	8Fx201N2qQiMfVzxq1uhPbbIVPnrp867xUZqyq1IxU1HtEfEufc/R8FTHFoS3EaJSOKC0xGRgGG
	93vb0MzAf0tX9sXcuFjtc
X-Google-Smtp-Source: AGHT+IEvPBS/MlwX1UKLk1MxaxKky+HaAyFLDpxPgy8YZicp0ghomwNxHvuMs2voGHJ7SGIms/vBxg==
X-Received: by 2002:a05:6a00:39a0:b0:757:ca2b:48a3 with SMTP id d2e1a72fcca58-7723e259561mr7624017b3a.9.1756712602071;
        Mon, 01 Sep 2025 00:43:22 -0700 (PDT)
Received: from days-ASUSLaptop.lan ([2406:8dc0:6008:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e24e3sm9596489b3a.78.2025.09.01.00.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 00:43:21 -0700 (PDT)
From: dayss1224@gmail.com
To: pbonzini@redhat.com,
	shuah@kernel.org
Cc: maobibo@loongson.cn,
	chenhuacai@kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dong Yang <dayss1224@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v2] KVM: loongarch: selftests: Remove common tests built by TEST_GEN_PROGS_COMMON
Date: Mon,  1 Sep 2025 15:43:13 +0800
Message-Id: <33ce1d45589840824c64eeafab121501c8ae7b44.1756131957.git.dayss1224@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dong Yang <dayss1224@gmail.com>

Remove the common KVM test cases already added to TEST_GEN_PROGS_COMMON
 as following:

	demand_paging_test
	dirty_log_test
	guest_print_test
	kvm_binary_stats_test
	kvm_create_max_vcpus
	kvm_page_table_test
	set_memory_region_test

Fixes: a867688c8cbb ("KVM: selftests: Add supported test cases for LoongArch")
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Dong Yang <dayss1224@gmail.com>

Changes in v2:
- Add "TEST_GEN_PROGS_loongarch = $(TEST_GEN_PROGS_COMMON)" to include common tests
---
 tools/testing/selftests/kvm/Makefile.kvm | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 38b95998e1e6..3fd1c2ae68d0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -198,18 +198,12 @@ TEST_GEN_PROGS_riscv += coalesced_io_test
 TEST_GEN_PROGS_riscv += get-reg-list
 TEST_GEN_PROGS_riscv += steal_time
 
+TEST_GEN_PROGS_loongarch = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_loongarch += coalesced_io_test
-TEST_GEN_PROGS_loongarch += demand_paging_test
 TEST_GEN_PROGS_loongarch += dirty_log_perf_test
-TEST_GEN_PROGS_loongarch += dirty_log_test
-TEST_GEN_PROGS_loongarch += guest_print_test
 TEST_GEN_PROGS_loongarch += hardware_disable_test
-TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
-TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
-TEST_GEN_PROGS_loongarch += kvm_page_table_test
 TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
 TEST_GEN_PROGS_loongarch += memslot_perf_test
-TEST_GEN_PROGS_loongarch += set_memory_region_test
 
 SPLIT_TESTS += arch_timer
 SPLIT_TESTS += get-reg-list

base-commit: b23ff7e52a79f4fe2382e3564719b97b718166d1
-- 
2.34.1


