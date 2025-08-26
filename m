Return-Path: <linux-kselftest+bounces-39994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBDEB372EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 21:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688B41BA40B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080922F4A11;
	Tue, 26 Aug 2025 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElzPFTtu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98057274FD0;
	Tue, 26 Aug 2025 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235843; cv=none; b=FtJraHEoVJHdoQ8yXBROjZkodFeq3AP3s8EA+8lsh++glBX5fdzJyH+Wq7OqRteAr91o5hNTFD5DihCWoGZL37d61Qw3O/O98zATyGAEhq+f9nzCmpb8oCf43CEFk/fzC3hUlSI6wIpRvVt2iPDwsgl/dpxr9jSrrpaZeEjRTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235843; c=relaxed/simple;
	bh=gNMm1ipkA7fYFXUs808DPedAVS4Dx81omm25zB7pYic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIoi4RJLYLjgHaPHHaVbOG1VNvjAkOGTyQlXHEHaVDIj3gOg5CVTERO3R/EXjqU0f87uJ/CVd+rcE/6UoqH1SCO04KTK1kCJtvphetQhLPbZvL99ExAZoKLSOfEM5p2odVe/YxyasWKLUXcKKmeOUKogJKF3KdutQiZcnFR4CKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElzPFTtu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-771e987b4e6so2040872b3a.2;
        Tue, 26 Aug 2025 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756235838; x=1756840638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PDBFaIWBg/DMxV3REtEPNJhHpj1jRSoIbPqwKvfDfdA=;
        b=ElzPFTtuzH2N6I8f+PLuGZl5Vg1uLSwdSCq1UMocKrOyOR6GPFsW4WEqJA1NWwVirg
         gqKC11yqmpnj/FDRL7iaCnnUTE8/N7OECjBU4dggQ1Sysq8TZzCnGR1cX5/9eT39IoCe
         aFJhCyImiuagTR+5sZBXrt3XqZSPI2puVMVWzgkRBwW262U7qBrs4vPBFpyQ6IzErxpA
         JpiRPbbJZdrpbnNwHqFpgNQRrLSw7FciIvvqVd0t7SL4vI2LYSorpRQ35lHBvE55UII4
         33CyOrMM84uLdTq9242FNipaB5iz8BaiFizj6bXlfC2txazEcH/g0/VzXRlx8c4MLqLO
         9wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756235838; x=1756840638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDBFaIWBg/DMxV3REtEPNJhHpj1jRSoIbPqwKvfDfdA=;
        b=DR9FjmSKAHKjtvvKesKyPZMqDykqsblxe/HDIWepTigUZUu9GvFybkP7ChKmfa6KLl
         245OM95ZLR+1FQxx6XGrG7arhTIB5uCfIB5viduFZjCFDPmJ0YCHeh229nkmE37H41yt
         4Fvo9X4f2fWz8HsrwBBtUCRqtzWawu/lwlGHq/hsyTpBIBQZuH6e8W6DFUMwSThcEfzq
         /HxRrxBmMP+FJPB0K9e+DNufqIM9PGI1ZVPl/mBFCUUHz3/RtMjTKAeZFsPfp2pCUuh2
         wa9fTPTgVKZX+/R4+kYCAbQ+Z+5viGRdcy06PfgR4xPLFLn/AVV97n6fHZNi4y9gtGiQ
         sIow==
X-Forwarded-Encrypted: i=1; AJvYcCURUAoFjhab4f17XFLMZNTUOL1/fK6Zw/cuDr/I3pFSl71ZS7jAD1E2rZHjgsF91G3AasnGMUJcMls/hTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHF3fjBhEPJpnNaPS0Cmt/AEYvDwGXXm4M0hdon3ZZGS3L+xU1
	S9x16NwG+iMYpryTK4VH36sRe+/OliAxeWw9wa48FT4AfytXpAsMUD3f
X-Gm-Gg: ASbGncvyJcSFPY3FJf65seq+9Y5XeidcqMPC8xNO+nvTr/F8A+VkpE0wjxf73PUJ8Hs
	HHr2HtysCzi4lQCSclGlIAUfTsETQd86JwOFfF/1h7duHLwVXcvOulCslv8zJGmNONodRGfIpkA
	jDITF1ckFUmk7xkHjqfglOavr5NFXjuotBHFwfhUMK5a8bobOMgBrKIIqnF9UwiD0+CTxE4R4V5
	I3anK9UuwB7PyzNhtiF2eHd6v0Fj55DC+cGzSt3MshRXAPKEixnnxfQ0zv47aegzVhoijU1Zh7B
	ueBz72rG1FSN3XLyzgYNP/2ljw4TpAhyedh16GcRFhZe+c7RUxVj6I2OzxGVLO1VOGuc7GI9Xqy
	OrcZ3NHP4IVf4D0yh1PSiSY2dJ7J2mYg3hBxBp4cvvMH0f9wusT5MVl5RMVapGddzdnLD7xaO
X-Google-Smtp-Source: AGHT+IEOTMNZIavUM5Iy5LIhtD1rVyHR5OcbyDpea0cdJbuixhaLMio9pOUj0ms7qn7MPHtCu/uxQg==
X-Received: by 2002:a05:6a21:329f:b0:23f:f934:19d1 with SMTP id adf61e73a8af0-24340b7ab44mr24060127637.6.1756235837661;
        Tue, 26 Aug 2025 12:17:17 -0700 (PDT)
Received: from linux ([223.181.113.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbbbbf5asm9754443a12.50.2025.08.26.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:17:16 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH] selftests: update SKIP_TARGETS logic in Makefile to allow running bpf and sched_ext targets
Date: Wed, 27 Aug 2025 00:46:59 +0530
Message-ID: <20250826191659.157458-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update SKIP_TARGETS logic so that these targets are skipped when
TARGETS is taken from the Makefile but not when TARGETS is specified
via the command line

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
Currenly you can't run these targets by overriding the TARGETS variable in command line due to
how the SKIP_TARGETS logic is implemented, i.e. bpf and sched_ext are always filtered out.

 tools/testing/selftests/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 030da61dbff3..42ff6bb4ea87 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -144,7 +144,10 @@ endif
 # User can optionally provide a TARGETS skiplist. By default we skip
 # targets using BPF since it has cutting edge build time dependencies
 # which require more effort to install.
-SKIP_TARGETS ?= bpf sched_ext
+ifeq ($(origin TARGETS), file)
+        SKIP_TARGETS ?= bpf sched_ext
+endif
+
 ifneq ($(SKIP_TARGETS),)
 	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
 	override TARGETS := $(TMP)
-- 
2.50.1


