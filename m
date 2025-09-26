Return-Path: <linux-kselftest+bounces-42510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6357BA5343
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE2D3251D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 21:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97327F01B;
	Fri, 26 Sep 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2ik5e76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7E283145
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922023; cv=none; b=VKTm/sWBiOhzQBW8e06ox1yxh1GwimtU82/U1+mEfAKt9vCYSkxY7U6J5OmZcNAqlc3ctGInoYClB2g/2bK/g1NYugLPtOHjOpBS3/CEaFX2zarND+lPphtEQDbTkeooDyjXM34O9tOxcuHZcnf5B8GFCdzKc6ipudl5yyOalOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922023; c=relaxed/simple;
	bh=G1cYqelfWjz3TjSh+JGPX14LLVReCZN0uMRhfP+qQ/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6lEJeErsRpF+jKO3PHf5yaq88Ul5nuIK/s46bYzDeoE28VxOKdxathiS3LPuncALmT/z9v3oQYs1c+Hi/PUehwawufsLaKUiZOeYmspXYyPEqIP/fbb+OxluYKz/rVivUMccK+9zfxZNkoQ7NIkOvxvLLjeeyENS220xU4HrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2ik5e76; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso2368573a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758922021; x=1759526821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgNilygMgwHdZEs1ZnH5984F+hiJNsFdGmwbqZj2EaU=;
        b=U2ik5e76HuQGCQVSTsnTuSYVWnK2YhIa2FH9Pj6N+qtEL1P7CAwXdbSOWm14fjSUrp
         A+LF3R/l7e97/SnAaPQ6D2L9FEjpb2lyFOdBDgscYQ+u2XH7jm+l4RQaaxV5aVIOwpdU
         ZGtiQMmfcizNOMwFD69Kj1z+hjd6vv/2fDpysaqvsoeGVHz+hJ+ihP2+7gFoJ6HqLX8c
         P2rq7MdWiqZZiFzMN/4hv2qj6t/iOjstct9xuBsdIRPkI/SR5zzKk67J6tCx5hHt/uWS
         HiCxETx8kijpm7nQ2lSCD11S4lbhSmENRb4fYEVb7ILtxSEUv61qkj4k4EdznubDWyKG
         OEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922021; x=1759526821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgNilygMgwHdZEs1ZnH5984F+hiJNsFdGmwbqZj2EaU=;
        b=XNfiY/cNeFteatuaschROS801J5uft9OtbH5UwBZC9+hVrdSaB/RRVRW4rf63/dpLx
         hEW8OOQRHBmtfD8HwbNNdepiJmQ6LCoIByZ+Tg8RN+CzITv8sCoJmzQJQ1eF5jHMhAwa
         GCchePr6Bfqft5uRlogh0EBqH0xvL8mPTOblOpDRF7yIl/JEdhEEH9c6a1w06e/F9imy
         ssyNwrwbmPrqwgj/AYmEkcFwc8zjRQ1PCorw5gmBOrbL9i/Jf5D9S18jPIRqbrLaTAYC
         SNTatEt+T885ytUES+VVulszSXNPCG33XOYyIm2nWBaAKPIH9BR0EyekXOUir4ZV9ldG
         zp8A==
X-Forwarded-Encrypted: i=1; AJvYcCXGVrm/HQKlweCYfQT0YeNSohEClAN8Zp9eP8FMy6EnF3i2Wpx1A6FJbrKgwvAQk3WRVUTNfJFMbZMSE4trRek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/1pumM+1ZwGXaDYym7PZgcTwty6oGE8F/eUfEl8ckGOLc2vkX
	R8A2g3FmRdUMNcnykwhWdt68hUvPM+161D0bJ/wbydL5RFP5TD+R44t6
X-Gm-Gg: ASbGncudhDC4PbGc0+DtYkCvEZc2//Gw9PbQ2eGGmbhx5uzq0XKZHIqEux/mAd+jdp1
	WcI2k8aK4DazhvunG04uFWDh2TnrktAkxl2jYADPJR9ckUAHdRWtYwSQgM2Mu8mAPdwVUGpHvpd
	LZEeRzRU514uOUOIq14QYB9uGixN3xpYvSZBYKzZu/QKTJyxVx4Hwf77o1UWNUu7H6sneerqyHE
	++kYMpcGL2SUcfi/samV68GUkLM0o0GoJON0jtR+Ym4MsFL5QyWNrXyM/rrNkgiSpjDDfKUAb5B
	0PxtR9oe7SOUORWC6k8dPVWwYr50IAukn1uy4Isd/n83Vdifdrr/9lWuiaMg+IrWd2Nzmzk44Vd
	0x4GRPpaST6JXxb5dPza+2QsXMjCC
X-Google-Smtp-Source: AGHT+IGTzlIKcFo4sqkt3yWBD+x+KPNdidVuwiGXfNI0rgF3mQzrIl9N7B2rNacRAdOjJu/uukKemA==
X-Received: by 2002:a17:903:1a2b:b0:24c:ea17:e322 with SMTP id d9443c01a7336-27ed49df28dmr99920545ad.3.1758922021066;
        Fri, 26 Sep 2025 14:27:01 -0700 (PDT)
Received: from archlinux ([2406:7400:113:d078:5679:3e8d:9b65:9f1e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8c6sm62722275ad.56.2025.09.26.14.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:27:00 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH v3 1/2] selftests/acct: add cleanup for leftover process_log binary
Date: Sat, 27 Sep 2025 02:56:14 +0530
Message-ID: <20250926212614.684998-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922091042.149117-1-madhurkumar004@gmail.com>
References: <20250922091042.149117-1-madhurkumar004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The acct_syscall test generates a process_log binary after it runs,
but this file is not removed by 'make kselftest-clean'. Add an
EXTRA_CLEAN entry to ensure the binary gets cleaned up properly.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---

v3:
- refined changed log wording
- Removed patch version info from commit log (kept only problem/fix).

v2:
- Fix newline issue at end of Makefile (caused add/delete in git diff)
- Code otherwise unchanged
---
 tools/testing/selftests/acct/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
index 7e025099cf65..fd14128bbddb 100644
--- a/tools/testing/selftests/acct/Makefile
+++ b/tools/testing/selftests/acct/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := acct_syscall
 CFLAGS += -Wall
+EXTRA_CLEAN := process_log
 
 include ../lib.mk
\ No newline at end of file
-- 
2.51.0


