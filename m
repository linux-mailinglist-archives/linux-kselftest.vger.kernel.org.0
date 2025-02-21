Return-Path: <linux-kselftest+bounces-27212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD36A3FEBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 19:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D2C17C315
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B025334A;
	Fri, 21 Feb 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxQrTb4R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2669252919
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 18:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162356; cv=none; b=R4D7A6B86dn012oc246XpcYtrtxsAkRovhf2lsma2+s48TURY2zxW1TQlnflfoxBtnQIGWcOm5B41L/iZUg/89ZC7WYqcKri2mMRKUBV3SjZxg2tg50Q28r44S8fCoccQNLLh91JszEKzQsB2EkGpnxvv6tTcM3P8mFq3eXnKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162356; c=relaxed/simple;
	bh=gzIPq+/dDC83E2soNu2dyqFClQrNfRPSDvJ+vZsSemM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rMWGrXZWONmCUqYLEcXIoy9eb14HyPN19vDYFr8ZssgrCjCACqefP8eZPx0jHCoiNeA1bV8IEKnv3wLl7b00sTMy/GyfR46xpG5c5FYLfUv7r0OsEM3nGijs5S2MeLnp9aBZJiRl0+oOffRVmQVNw4w4VPlt/Xd5XiBERlN3ATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WxQrTb4R; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43942e82719so16389225e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740162353; x=1740767153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTcycxfD9DCcL+mqAzEBCNl+Z24hIPU7/F5XNHmMRAA=;
        b=WxQrTb4Rz9T/gcqB0bW3KVIm2SqqFN6mSdSu1fG6RCTCuSz9WiKEk4acJ3tmnw3A0t
         D5w2gZP902aakVxYEaV+XmMiJw+pBH/OouiX0n6Rs3c6MV8nvvrjrFko0rqdYlGx/mzI
         RhLATzRbEUkTzCB5r+XyDZg0AfxmU3EbqsWFtZcUQtrW3Ft/vzLCcSkfp+wEzgYe3zh4
         2KkbLbwEU2KZhCnAxwquYY+XmrI6FAIMOf9JZhmMHAgNn+FGrwUSftUdoo+FfF46e0U9
         //9oyHiZS26YKhrGuOLRcMdeprMxkRvFePatELVOgfkrW3JDSoGTR6uZT0gMeuHE5Cca
         GtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740162353; x=1740767153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cTcycxfD9DCcL+mqAzEBCNl+Z24hIPU7/F5XNHmMRAA=;
        b=T2Fgo+LX5rxCttBwEQm3ogMj13lz8SYATXacacy1HapBTCRlpbnWog5WXuggDwfZYS
         /FmxE/qNXWXa+jZI5rl26nkjO5dc0xF2m1fJijc9KCm6P8rNjf5xHnZrrSFFaDQPipXs
         JnxbZ2GotwapEL5L4mOiO29bJdAElausNb3TD17bqR6EAvlMAEtWtgm8ODGJAy8OLqG4
         8G49NRu6Rk3pYG6Uwo2m0/RKhP5RFGcBt1sjT9Hjgi/BiEwHkvze5+FmxRjxEZCeSA7T
         Y6PNAiPmEKOL49sDbPFcyq6vIEODaayvU6qJxNDcVvl2DTgZ1wpNt6N9eOZJ3A1XnmtV
         8o+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYKj/BmeCipy0DJbueCdHz9CpPtlrXy/f3HW0hhwyx10hInbGtjy0wGOeAJ9W4oGRN8ihJuaLLHBhfsVciWfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8A509SLWUIwmv/dU8yPXXkbgkEYbbAk55WMUrk12kEbti5Mh
	kYpl8ifdwDBAxCbfmnoLcbs4J+/0GI1ALmoamQ2cwi7RizMUsTUwNGFLryG4cvX8zzlp9p0aC8j
	7XOitTjGCvA==
X-Google-Smtp-Source: AGHT+IEszNIJhkJzwGv9AsQzVYAac3pftoItIw5cS1KOScI8cPLKnS0ZHcBEzvcUimaonjHx8RHsIBeFDU35jw==
X-Received: from wmsp4.prod.google.com ([2002:a05:600c:1d84:b0:439:942c:b180])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f86:b0:439:59cf:8e16 with SMTP id 5b1f17b1804b1-439ae21644cmr37029575e9.23.1740162353265;
 Fri, 21 Feb 2025 10:25:53 -0800 (PST)
Date: Fri, 21 Feb 2025 18:25:42 +0000
In-Reply-To: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250221-mm-selftests-v2-3-28c4d66383c5@google.com>
Subject: [PATCH v2 3/9] selftests/mm: Skip uffd-stress if userfaultfd not available
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
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
index a4b83280998ab7ce8d31e91d8f9fbb47ef11d742..ed68436fac62c76e2ca7060c661487f2f8a6ab45 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -411,8 +411,8 @@ static void parse_test_type_arg(const char *raw_type)
 	 * feature.
 	 */
 
-	if (uffd_get_features(&features))
-		err("failed to get available features");
+	if (uffd_get_features(&features) && errno == ENOENT)
+		ksft_exit_skip("failed to get available features (%d)\n", errno);
 
 	test_uffdio_wp = test_uffdio_wp &&
 		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);

-- 
2.48.1.601.g30ceb7b040-goog


