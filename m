Return-Path: <linux-kselftest+bounces-27074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D327A3DDD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44BC7AD4F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6D204598;
	Thu, 20 Feb 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D4qL/pqf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D461FF1DF
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063827; cv=none; b=AS5TseB1ER3ktJuDq8YaZN1//BLq5XHcqsDdabnKsjzjZn9nokSfA+sVBCj8RNojT56IF7EOoLX5rc2sD/44o5WdRiBzB55K8w/3KxlE+I3U3vBchsT6hkZhgJQ51nWa/w0Q70y0HrMhNGuwxPt1v1eRgRXEU27Ok9pJqwmUU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063827; c=relaxed/simple;
	bh=9/O8tij2wirjK4B8U/5x/9fVjzo452E6485tV+fUgJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iyrFVxqhIDP3bhCfq9nneizylp/6otAsqdfxbKtxXnRTs09KK0448LnDfFVT64gavVmZWuTMWxLt14jdtwG4DX86Hk5hpcIHi3MWnU7sFjpDmUf30GKHf+AzgDsArwMXy2B6qke/YEcCs+Bj+EGcZsEQgn52a70pxD5bIhJzKDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D4qL/pqf; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-38f338525e1so539544f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 07:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740063824; x=1740668624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnk8jRZQRXvEGJgMo7kX45MXuk74eHKcJOVD1/hcv8=;
        b=D4qL/pqfz7t6i5X9OGWOI/i6vUeNz4tquOFDin4XQLG9mcFZL3bV8eKrUhycSpYz7R
         PChUVwVxLugpvqnba4cbcBe+RaXB81Qy7G8qmRB5SyAl63nRkqlhLc8EjD5WvMixXESH
         1rBiSj481MKpTon1Awim9nqbzlIaxPGMGs4XZFE1bhQMoED0bBdZF6aqHCH75hUzCvBf
         R4HtebUll1A48MZVtxtEuJYF6nDDyCGcuITyEBOoPsWBlMH4AI/X2Of7qkxxXtM5pD+b
         BrZMiRQy/b7QJvC6Cq4vRzXCfU8d2vq8ZD2pEmVE7RIkODVxauiFHBJEBA5ugL5FOaap
         DYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063824; x=1740668624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pfnk8jRZQRXvEGJgMo7kX45MXuk74eHKcJOVD1/hcv8=;
        b=iu6L8Tjn0+xr5KSndw8sLOA3dyPyldb1I0/IadPNiCUE4D8MyD5sjEEOjMnGwwv7gC
         pDLEwbp+HbFSGYctF/CXn678Ks3n+j/gAkFoU1A3vB38zr31SO3Pb1ry6OMsdoxBVmcz
         DX2Rgc5zo49IJg2RESHXH9ifWOnwN2MbqlZMoFgjGIykvuDYNWFTskWfR1OxoXASx024
         ctuIoEwVciW8EaydbcML1jLY+qvvKySX0dRzaJB8lg/GufbkusQuyadMaQy7/aGjwsgw
         +7fAMXK3aQk8p4CHAAWHxCCf9N7GuVS6oxX5AwHP+G+GJ1yfqKSEKd3nwPhyQJ/AojK0
         dAQA==
X-Forwarded-Encrypted: i=1; AJvYcCVg70ig5zHq+SPFBm7aZ9nQ0VydguLv8ouYYMRYLuzLUIelkLd4E1DFlSdJx/PlbKOy64/0yMd8jP89A22OtGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPhB2BcTksNAG1cCdMJfzO5Z0SjDU0+gzmxcu0A5Qmd/mvfh8
	2NyzR2TgGLaCWljRYTfm1OV7GIeRR9f/hpUKVXF1vpoMJngWW4nqZ4CkrxSd084CkPiGKff13Tc
	6LsY9LRJSwQ==
X-Google-Smtp-Source: AGHT+IEZkoGqvABvYTvvXiRtV+S/mpL0J7HYkw5xP36OjVJpS+4DgqAiy+8j1WNNFXzaMG5CNB+I1Lj8O+cs0A==
X-Received: from wrbfu21.prod.google.com ([2002:a05:6000:25f5:b0:38f:3cf0:aac7])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c6:b0:38f:3344:361e with SMTP id ffacd0b85a97d-38f33f2e954mr20711279f8f.23.1740063824704;
 Thu, 20 Feb 2025 07:03:44 -0800 (PST)
Date: Thu, 20 Feb 2025 15:03:15 +0000
In-Reply-To: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250220-mm-selftests-v1-3-9bbf57d64463@google.com>
Subject: [PATCH 3/6] selftests/mm: Skip uffd-stress if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's pretty obvious that the test wouldn't work if you don't have the
feature enabled. But, it's still useful to SKIP instead of failing so
the reader can immediately tell that this is the reason why.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index a4b83280998ab7ce8d31e91d8f9fbb47ef11d742..db5366b4766e5bfa2d1150d2f3c2d32469a6e28b 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -411,8 +411,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	if (uffd_get_features(&features))
-		err("failed to get available features");
+	if (uffd_get_features(&features) && errno == ENOENT)
+		ksft_exit_skip("failed to get avialable features (%d)\n", errno);
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);

-- 
2.48.1.601.g30ceb7b040-goog


