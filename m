Return-Path: <linux-kselftest+bounces-35213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C323ADCD96
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 15:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E9188FEA4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82D92E2640;
	Tue, 17 Jun 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZcK8urI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE282E3AE3
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167442; cv=none; b=oIEjlbEQpxT/4RsB9UYIujUZzapqtL2ueHu1SdH2FIiFB5CR8lkLVbHOka+FMHlCdVKr4Ovm/zsmpjhoH3uXa7+NIPGOybS32LvBFGLxZMTjAEGMcYDs7ZTAQ3HJE0/262TCfyYEH0k9bOgKeNnD7+/199HKmNH+c4iR+gmn9s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167442; c=relaxed/simple;
	bh=xtt2rNThOOd0Ch0ay5t/SRPt0e7QyIQa+1AuoLWf+2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1FIURvZrfBcBPMPpbyopsEL6KE8VTF9WDflmrxpHnob0jswIRr5SVlnVQB5tyj+GcbR4Llj7vrAque2erc1PPjuKD82BjYWugwrnQTS2/BQcqU2JKZb8a8s24YRpXluohOPfAIouoT2C0qbGx6UBx59a9773ojNG/PKgfaLta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZcK8urI6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so8133735e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 06:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750167438; x=1750772238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IirAviWa54+DB/4fGXki7ILuYvAogeRyMVXvAl7uRo=;
        b=ZcK8urI6w0HZat+W0ETrhst7YwkcpUv2RNrOMD4e51q9NcdtuCa8LB1WZylPwpgd2B
         bSpseIJDU1r2cJ2GlZ0j4MjwBa7n6sDdDoKxrAu7Tq4dC+0vYIAFLrkeznw/hQXHPrTh
         KBtGAwMekGhwBmCPEKW4sZ1W7hN7/D/4ZmndrmXvsfnhOLhOAr5YcRAtMOUzooPLAifJ
         TD6gI1ImQ381LaXyPLL87o04QrQWuTiRKqvQctth9IJB+zM/LNUlYScY/xolpjhGWJEZ
         BB5iaONU6ouovoVBnR0PGzVU7u+ADE2Hj7uQ3GzgmVskyDdD+EXzqnfkt8xkwPpxpjIV
         mgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167438; x=1750772238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IirAviWa54+DB/4fGXki7ILuYvAogeRyMVXvAl7uRo=;
        b=E9lD6P6kaX2xJ2K/vWqwd6g3ZpKNJGzX+LRBMT0CQWPrU82MB5kaM7GCeyx7yW5gw1
         c2QV4w7Pf7l5QN9x4Pdcq0dxfhVC17W42Ccf/3EwrZvXtlAYRWK3pRR50QnR5u6ylVQf
         vnX/FWYDZwE1CxsnH+2/xywTDKrL1PT2aqcJXeHSonmcpPeNdEN1zBGbr1nOG8P4nNtT
         FR2zmHIa9hNkjM/XBZ90jXHuaZRhOq2VCmRSMmVxBHsLCkrAIiKe+qyKP3uGOnwIOTsA
         8Pm9ybK3PXDbJQJq7qJnd5jPydwcq4m0l+kfj8qqyf/VPK4SBvwnanSSySIcnPhw7eca
         8vbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFPgvGas55fZkBky/WBH4/JRgcv4RNoOedtQaz9Iw/BF9N0m5kW1Zps+Tb5gYxwsTgDkfbBVF4z43uzMQl/Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+1dxMF2HgeYxUlGN+y2663Y/9UNb7gpxfjMKL24sqO/xrJWx/
	3rdoHX4OOSwO/dxBUGx4XCbQPoGqxqgjWSwE6S+PhBga5Of570jSrF7NU2yGA1iBXXU=
X-Gm-Gg: ASbGncs1y6JqIY+K3YiQHVwJrNF9jEVHY8IrMiGkqe1hMI5Cl1DkaFJujq9tGBnbFD7
	fzcJ3heBVknoXkK+rL4yKbCh/4UVdb1lvtfv51WVJfp/a8MM7Fi9BhfdnxyhalJN7m8h8BxF0mj
	ji2s80Ll+QQlilHJZ0KEpnrk04KF5IY52LFguzEuWgGE660by3WUdLW77zzq7EhS4Ubt/5bDuvC
	rjDabE/WnbeygXGvpNkUiwvGbdyjHJbIE/E5GWBL77LIZzZtHAy+38rgc5DLW3zaFuPmG6Zust1
	GsKrCUtYaUVIgBr++0h8TsDrVu2VVyUiWUeriai6ddnPE2QDUXA0zmocxZa/gI4+JXnic5ttRQc
	=
X-Google-Smtp-Source: AGHT+IGrwE0n8xObbXy+xwulox5ORPMmG9dF8KEQ/VAwCkDtHw6tIijP1d7NSitWFCIxbglfxPVesg==
X-Received: by 2002:a05:600c:5908:b0:453:827:d0b1 with SMTP id 5b1f17b1804b1-4533b235e16mr90149065e9.2.1750167437646;
        Tue, 17 Jun 2025 06:37:17 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224888sm179494365e9.1.2025.06.17.06.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 06:37:17 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH 4/4] selftests: cgroup: Fix compilation on pre-cgroupns kernels
Date: Tue, 17 Jun 2025 15:36:56 +0200
Message-ID: <20250617133701.400095-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617133701.400095-1-mkoutny@suse.com>
References: <20250617133701.400095-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test would be skipped because of nsdelegate, so the defined value is
not used (0 is always acceptable).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/test_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_core.c b/tools/testing/selftests/cgroup/test_core.c
index 452c2abf9794e..a360e2eb2eefd 100644
--- a/tools/testing/selftests/cgroup/test_core.c
+++ b/tools/testing/selftests/cgroup/test_core.c
@@ -21,6 +21,9 @@
 #include "cgroup_util.h"
 
 static bool nsdelegate;
+#ifndef CLONE_NEWCGROUP
+#define CLONE_NEWCGROUP 0
+#endif
 
 static int touch_anon(char *buf, size_t size)
 {
-- 
2.49.0


