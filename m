Return-Path: <linux-kselftest+bounces-27929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648EA49F81
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604277AB0BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D48280A37;
	Fri, 28 Feb 2025 16:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qd77Jd84"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A8280A2C
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761709; cv=none; b=k2+s6PKULLUwea5uYjId9coJHa1hFpk7IVmr4dYqGrFqB4Rb9Lg7ml6i8u/NAY3Xd6wxQwQLiBxisUiStEP26ppIkCMuHUmt7lwBaVROSJRIuf11jLvssHZ8rya3MICiIFtguupCd60y6T5Mj/744Va7ehr8Zlqj/MsiJx4pg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761709; c=relaxed/simple;
	bh=7XspZM8ZAnG3LYxKGks+Dzhnygkc4NT/9ogDGinmMCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s8dPZxvWMj1v1KFvotspz7Rd/Ux4V/XqDNASqMUgo29ffzHZGFYMql0/ECzGki1qpBaZCea+S+sm3GBlfqH0ao9TGe5uNNXfMksD8ujWk2FITidr/SfIzf88WcilqcLQ39R3822e6iQoYRzp8xqwy8+1viTuPJ5iaTEhHO5xCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qd77Jd84; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390f729efacso32765f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 08:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740761706; x=1741366506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9d0/khHAO5zgmsRDUqio7iG7quhZmE2f4ksjxnf1MHE=;
        b=qd77Jd84CQ9m2DNLGHmTlx3hwx1X7C5PUcBsG8fI1f6fh6EaFKsLMx5/y2er1UnyJ+
         +fNkT0VhoCNYeC2Pl9mvpPcMOWSS+/1g98w5RKbG1RzCiU3sJSwmzqiGsxjFaZLxZSv8
         cdY4c8hVEPTCk2eyD+BX6tCcHM+DE0JRZLXaqze8KZ8dLhFuArrEmnHbpmJVHXojWtpo
         opWBky/yp2HrqR3RffICxm0Fp03Cy+Zxszn9Mjz9tc0wqBR7gqqBWzBgNPI/FQiFMnqG
         52wbOX53bh3wX1vzCf7XGGUJa/I8XGgpjIc2qNHgZt0Ly929UQXjMhkZqDojLXJ//Ab4
         O1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740761706; x=1741366506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9d0/khHAO5zgmsRDUqio7iG7quhZmE2f4ksjxnf1MHE=;
        b=clHYreGfJwbhvmO9Ipa9nJmAa4Z6flkOHhUx1BFq51nVRPTrSnbVqO7o5ap8lP6Koi
         h/lnBxbHC5fPYbMeGxYpO6jghZzQBm3qpoqcoe8Ada7VT4mqLCA41YUdVpkTJ+kUttOQ
         KljKoxki1oyluny/XLDe7MPwglTnSbl5vGPwfFc+Pp4MVJI66nNttx+JQGaTvG/I1moB
         wuQ7ifmbpK6fyGAE/WVr73NMkNvGKAnJLjCRxWLTV/d7Y+DmklflTvRP4Qqj22vsH7tw
         wgrJsc0u1zrmekEH4/Op/fcC4G/K2FN5VBa/1h7/JD45TKxk5qE5hBxiJg3Kno9ssEWw
         WyOA==
X-Forwarded-Encrypted: i=1; AJvYcCUVpT/1vGMcb+GpCTehGsjugkfw+24edXwj9naHxpJ1jKoAl+J6Dq3BWBVPMOgZVvX+gQOILR4daS0v1mNscCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsANYkIiTs5Y7Zk+UIadJ3RZe0gE68i43fUcakkEsatJDiAJ4
	g/0VPRKRm1TA03wZMylwQcwDcofnysNB8jlcvxymwBg7qTt8l97tDkOFch4OI4B5q7qRtRppXyh
	ex7GDGfG/kg==
X-Google-Smtp-Source: AGHT+IG11sEYt2OnuCbnie6xNgIUE5IX6nCNDcxXVlZV0z0FMYzaNDcNJwgRdo42mUkZXMNKwRZc5xmL/K51cw==
X-Received: from wrbfy2.prod.google.com ([2002:a05:6000:2d82:b0:390:dd74:bc9c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2a10:b0:38f:4d20:4a0a with SMTP id ffacd0b85a97d-390ec7d1dc5mr2770264f8f.28.1740761706596;
 Fri, 28 Feb 2025 08:55:06 -0800 (PST)
Date: Fri, 28 Feb 2025 16:54:53 +0000
In-Reply-To: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250228-mm-selftests-v3-5-958e3b6f0203@google.com>
Subject: [PATCH v3 05/10] selftests/mm: Print some details when uffd-stress
 gets bad params
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

So this can be debugged more easily.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index ec842bbb9f18e291fa51de0ed8d1fbf9aaf14372..efe2051c393096e237d942c04a264b6611a6e127 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -456,7 +456,8 @@ int main(int argc, char **argv)
 
 	nr_pages_per_cpu = bytes / page_size / nr_threads;
 	if (!nr_pages_per_cpu) {
-		_err("invalid MiB");
+		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
+			bytes, page_size, nr_threads);
 		usage();
 	}
 

-- 
2.48.1.711.g2feabab25a-goog


