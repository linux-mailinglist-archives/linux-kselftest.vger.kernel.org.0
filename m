Return-Path: <linux-kselftest+bounces-45060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED692C3E837
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 06:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91DF4E5EB2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 05:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A85029B799;
	Fri,  7 Nov 2025 05:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IWWAAkDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D29261B70
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493398; cv=none; b=lqRuoxPgsKAvhJ03jWALpSZFFVaXoFSmCGjIPTPtcqUQcEv88PrOI0YA9dnIzuIYfLqko/k6ZMx/Zh0jTK2zzqbmfXcFNBvNK3gfLh62DC9PUj0xh2K5d1NZvCxZ05VZGI0woyMe/7+bKU4TPsvoQRmu9NjtAGxN/EOPtWqA7sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493398; c=relaxed/simple;
	bh=t/n21pSuJSr8MBIv4gg6nnfTGQhILI1Rm200T1DKUvs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bmin6n5qVpxKaR2RLv8hch0IXPXAVMIKktF0YTHwYWd2TOP1WaQHolfgIPAU40lITpDD5TrocOujBP/XnMXk3aPchisgojA5XJQSkYmC0WvcllbtCtMt4bL4Uv/6b6sI/7qm11ZOGErH7PZU80VY94ocBDW8AoqlN3a2ZkMrpxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IWWAAkDp; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-79a3c16b276so9427956d6.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 21:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762493396; x=1763098196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WhJsbd8hQIgaMMcaCdsT9ge7ButLMZT3b1jbA5sMxQ=;
        b=IWWAAkDp0m/5FmGSvKI9SO/eJXKdJT0NuMn5MJv7uwCeTJa4FcFavHgumtYnojAVbg
         CzfMtpbsKZA+q0Z7lwcSnf5PH4cXfZh20SjqhctA0WuWPSaRyl9oDP7cmxbC2PKqdzCu
         wt0V6+vpQKdn52Q690uzhJucMdHqwlZJuSiFePZaK9c+Y8AH2YeKTeRv9fpfZ8avUUqj
         Q+lS50CuDlFAvN9f1qQloPskD7xbEgdQqn7V298uyflBjnHgvRAaWbsMJvVoxsN7GIla
         YtLxJc7ywyLilw/R63q/gB8uruiNTR80ZsdxPS8mPsEgzdbgL2MJcXZERVR50Ka+YFXh
         5NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762493396; x=1763098196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WhJsbd8hQIgaMMcaCdsT9ge7ButLMZT3b1jbA5sMxQ=;
        b=rRh2QUOG/H2vSb90A7QgHiZXYhLMKfyICJ8xpVk8Kqe4XeDLP0G/H8IOCQA3I3YeEY
         Mga3ELYbHxYEVizWwcIjt4W7ZU2sA/Zp+J3fqJie8l61tcoFf/oYDxAeLy3WTn9BStg8
         yLFN13oLTNWeqOuijyK6/Wxecuim8p+Xzs4Yz/66KBYI5OTtxGTWu6HfRWdTAjzXMdfk
         JYb3Cd9gqoqMKjlNHwpmuPG+FsjfkqZ/INeKjHNxMeG0t3gKw4ljtY0H4EBh1goDq09s
         vnqYAkO61Q2aNhL/qo1ryOmRet/VSO0CGt96jn6TOpA/4h6njxc1GysntE2dOzIMTBIY
         68Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVOiEKy3p7b/cpHOeX8gaeorJ4b3dQgpI7dmzSyfux2OMJUp/OrokRs8TLxfkWuwnC03WY9FB8Urc8rcGIMooU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQpUnZwzpEEGek0TEhvGaRU9xyU/5Sq+zzLeojtz+0EjTGVFb
	w6Xws6i4oZCu7m1R+9CoMyTjrPqx9MZjYhIJyoTLHR2AFHc4+ZElY5bYcuUc9qGl/mVc2WtHrgd
	tLw==
X-Google-Smtp-Source: AGHT+IHYciVpqOb8pQto4TErUyowvJXcico5AhQjHPvT6LVTf1/3owC+ciDU1QPX5RZ1igpKDXNExBFvtA==
X-Received: from qvbrb8.prod.google.com ([2002:a05:6214:4e08:b0:880:6bc3:4888])
 (user=rmoar job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:d6c:b0:880:4982:3afe
 with SMTP id 6a1803df08f44-881765c5307mr25893326d6.25.1762493395647; Thu, 06
 Nov 2025 21:29:55 -0800 (PST)
Date: Fri,  7 Nov 2025 05:29:23 +0000
In-Reply-To: <20251107052926.3403265-1-rmoar@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107052926.3403265-1-rmoar@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107052926.3403265-3-rmoar@google.com>
Subject: [PATCH RESEND 2/5] ktap_v2: change "version 1" to "version 2" in examples
From: Rae Moar <rmoar@google.com>
To: frowand.list@gmail.com, davidgow@google.com, keescook@chromium.org, 
	raemoar63@gmail.com, Tim.Bird@sony.com, shuah@kernel.org
Cc: tytso@google.com, gustavo.padovan@collabora.com, 
	ricardo.canuelo@collabora.com, corbet@lwn.net, kernelci@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Frank Rowand <frank.rowand@sony.com>, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Frank Rowand <frank.rowand@sony.com>

Change the "version line" in example output from
"KTAP version 1" to "KTAP version 2".

Change version that should be used by compliant tests from 1 to 2.

Reviewed-by: Rae Moar <rmoar@google.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 Documentation/dev-tools/ktap.rst | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/dev-tools/ktap.rst b/Documentation/dev-tools/ktap.rst
index 387062b96c10..21e1b80fddd7 100644
--- a/Documentation/dev-tools/ktap.rst
+++ b/Documentation/dev-tools/ktap.rst
@@ -41,6 +41,7 @@ version of the (K)TAP standard the result is compliant with.
 For example:
 
 - "KTAP version 1"
+- "KTAP version 2"
 - "TAP version 13"
 - "TAP version 14"
 
@@ -48,7 +49,7 @@ Note that, in KTAP, subtests also begin with a version line, which denotes the
 start of the nested test results. This differs from TAP14, which uses a
 separate "Subtest" line.
 
-While, going forward, "KTAP version 1" should be used by compliant tests, it
+While, going forward, "KTAP version 2" should be used by compliant tests, it
 is expected that most parsers and other tooling will accept the other versions
 listed here for compatibility with existing tests and frameworks.
 
@@ -204,9 +205,9 @@ An example of a test with two nested subtests:
 
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..1
-	  KTAP version 1
+	  KTAP version 2
 	  1..2
 	  ok 1 test_1
 	  not ok 2 test_2
@@ -217,11 +218,11 @@ An example format with multiple levels of nested testing:
 
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..2
-	  KTAP version 1
+	  KTAP version 2
 	  1..2
-	    KTAP version 1
+	    KTAP version 2
 	    1..2
 	    not ok 1 test_1
 	    ok 2 test_2
@@ -252,21 +253,21 @@ Example KTAP output
 --------------------
 ::
 
-	KTAP version 1
+	KTAP version 2
 	1..1
-	  KTAP version 1
+	  KTAP version 2
 	  1..3
-	    KTAP version 1
+	    KTAP version 2
 	    1..1
 	    # test_1: initializing test_1
 	    ok 1 test_1
 	  ok 1 example_test_1
-	    KTAP version 1
+	    KTAP version 2
 	    1..2
 	    ok 1 test_1 # SKIP test_1 skipped
 	    ok 2 test_2
 	  ok 2 example_test_2
-	    KTAP version 1
+	    KTAP version 2
 	    1..3
 	    ok 1 test_1
 	    # test_2: FAIL
-- 
2.51.2.1041.gc1ab5b90ca-goog


