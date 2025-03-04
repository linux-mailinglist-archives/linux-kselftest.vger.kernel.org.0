Return-Path: <linux-kselftest+bounces-28184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCAFA4D58B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 09:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 142387A9E71
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696D1FBCBA;
	Tue,  4 Mar 2025 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="H95Yqy4z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502941FBC9B
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075175; cv=none; b=XjJz2aGeYQxE1SoB5E4LQiAEuMvh7t0v2dIvBFNCx7LEUsCfPnU3b1FwY0E628w3rhfd5CoCE/BKCm5nIAp4BiQ98sBbM3fV0MzeXkFxuvWem9CbD+AQc6+gOywBVzVDGbpJocT3wrK1Qe0xJeBBBUc5YK8UV4S1D+zzlBzosy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075175; c=relaxed/simple;
	bh=OmpLaD36OmgP2KxXvtkrxv7kXf2SUSNINdzlwSDRI24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8eZMnOGhyiJSvdZqLd980qv6Stbjd3EY9od2wCJaWcHdY5SYZgn7nydUi7Oy32Tv1Lbp8TKEiE6HdRXueIPjoHfXrSdcKxA2i//HeGqshN9E1Ds3bUOQKp8ewzKSDpA4kh9GxP2ylfpe3Wq4Pk1KG1yBxtR/5p4YN2RnhwMTUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=H95Yqy4z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bbb440520so21536895e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741075173; x=1741679973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0+vePg+vh0lu4DwI91iCUCQCjYjpI2M5+FTmi5A+xg=;
        b=H95Yqy4zb8y5GnWeR7+fYbXf7tcN0UFNXl4SMi2RcYP938bIlzl9UcqCdR41noA0zw
         /puJJKab9cSObHZGeFsi5KfaJqZ6dc0v+WRXdkZSThzArlDAeIK+3a2YpBZjWi8D53XF
         HL9Gi90qpIUm6DUdhgTYXsbDSFSedawVa6I3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075173; x=1741679973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0+vePg+vh0lu4DwI91iCUCQCjYjpI2M5+FTmi5A+xg=;
        b=QytJuYcDJSPWRMKAgHNSrLjRm4+riYSGKC9AI5LuB8dHYZl+1a3vnPFP7TfeU8/3KC
         c+AFMHnCRhuqAYtgZz3+mpTnb5BiuvhsAcovvMdh9MFNhCv7E5uQrkhHcCE716Ius6fv
         9UA9YOAjTFuFV2xlQAuabIEENZZOP0iwCbzeUppIijR9+W2O5gDvOwTfjPPUWR0MU3e6
         O43ftcmmObi0u6dM+95h5YdhHLC5EoQpVBkYRyRAH9Wm1lGj6y8r6n7Wgw2iSq4oJa0J
         WS8B6vLp6iO9Oz/tjyCC1MoCe32W+Tes2EGc2ilth5Tb7bH1bSpzHU+9JoRefpiHU1RW
         R60Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXFl4dWKB2b86NmuC29rRYHSrkcHy6WyO4vdi8GbeJl8dL+Taw49IsYB9nISxT/7d7k6Hp4tw1h1626ecO+ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAUG6rT40qjy3VNXw+oP6Pih5rV3G1/E/Oz8BSbaizyfllO6j5
	Imp3XwZNa+Fa0l/qUGetLum0hBjDYoOxg5cPGSEIpoP2JEYmAc0c3uTHUZ0lXug=
X-Gm-Gg: ASbGncsrUmpMifipNEiUMMLYDXNsIECqCGti0HMcGQ9J8gq68wgXw55C/x8gxoV3v6p
	BrxqxpojpT5VfFwJVEU8USP8sdqea/dLt02h6UWY9ZAf3E9/z2vStleP3im7PogAo4x3lGcaaw9
	81I5PmocjfssQMRhtOoCXuUS26MJ4Y2qTsf/YZxMzrRG+uOFMr3wsjWYzO8OlrhVs8DDqf7DXdZ
	Ky5h2HUiSTBq3skOl7bvAVBsWeLw/Iy4SQ+3vJETAFSoVoX503bwCA9Xo1cIRt/lfFGt4F5qMBP
	fHHx1pJl/ceWjAq8oRKTOnYw7//aq73R8pvE8oIQiENR/PkF5EZvFYVTSIpHalEZJQy6iopLUe3
	gZ+d+0w==
X-Google-Smtp-Source: AGHT+IH9+UXTVhNFEk7r+u4miSHhAhVXhg6fiMdMSbnv+lSnLx4G8t9lr0LTTlz7YiOkc87QvcbFQw==
X-Received: by 2002:a5d:5f84:0:b0:390:e9e0:5cb3 with SMTP id ffacd0b85a97d-390ec7cd28amr16223888f8f.12.1741075172781;
        Mon, 03 Mar 2025 23:59:32 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4796517sm16618101f8f.5.2025.03.03.23.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 23:59:32 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] tools/nolibc: mark more test functions as static
Date: Tue,  4 Mar 2025 07:58:19 +0000
Message-ID: <20250304075846.66563-5-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250304075846.66563-1-louis@kragniz.eu>
References: <20250304075846.66563-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was mentioned that a new test_ function should be static, so go back
over existing functions and mark those static as well.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2a1629938dd6..b5464ca8d050 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -807,7 +807,7 @@ static int test_dirent(void)
 	return 0;
 }
 
-int test_getpagesize(void)
+static int test_getpagesize(void)
 {
 	int x = getpagesize();
 	int c;
@@ -836,7 +836,7 @@ int test_getpagesize(void)
 	return !c;
 }
 
-int test_fork(void)
+static int test_fork(void)
 {
 	int status;
 	pid_t pid;
@@ -861,7 +861,7 @@ int test_fork(void)
 	}
 }
 
-int test_stat_timestamps(void)
+static int test_stat_timestamps(void)
 {
 	struct stat st;
 
@@ -883,7 +883,7 @@ int test_stat_timestamps(void)
 	return 0;
 }
 
-int test_uname(void)
+static int test_uname(void)
 {
 	struct utsname buf;
 	char osrelease[sizeof(buf.release)];
@@ -922,7 +922,7 @@ int test_uname(void)
 	return 0;
 }
 
-int test_mmap_munmap(void)
+static int test_mmap_munmap(void)
 {
 	int ret, fd, i, page_size;
 	void *mem;
@@ -980,7 +980,7 @@ int test_mmap_munmap(void)
 	return !!ret;
 }
 
-int test_pipe(void)
+static int test_pipe(void)
 {
 	const char *const msg = "hello, nolibc";
 	int pipefd[2];
@@ -1001,7 +1001,7 @@ int test_pipe(void)
 	return !!memcmp(buf, msg, len);
 }
 
-int test_rlimit(void)
+static int test_rlimit(void)
 {
 	struct rlimit rlim = {
 		.rlim_cur = 1 << 20,
-- 
2.45.2


