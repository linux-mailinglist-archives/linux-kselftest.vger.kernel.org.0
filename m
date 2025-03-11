Return-Path: <linux-kselftest+bounces-28748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E84A5C260
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 14:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1077188CD95
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C11B2580C2;
	Tue, 11 Mar 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZLLQP4AQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B71ADC94
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699125; cv=none; b=lLFzpsLskwpVuhGL5jkr5dpVAnvzxIphm4O9UQwgWqzt6Y44HBaFIt5IhdfjoOe7w7bripZwXf79gE0OcT3NVk00eqWPEM1BZhMmudfptSJGOY+C7J/24rCr3ogTUH9IGalUx6RFBS6Th+LrbiyM/UI4RxwnVcSkLRscjZnGI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699125; c=relaxed/simple;
	bh=Bvrdg6/K54PEW5JZWuRIH9o+4LbgcalZobFw2iLsFJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=roJInCrHb2uIXIHpI9UETBE9UrUmfsiubt4y7guzbG4kzCFRaYfRBWqWpcNZX/pcxhAgQ149g+O0S/fcivSGSRMF/uofSD5bTW1r41G5SBGo04wDEeapqLYr27PpOrBRugOmU6CbFTzUZrgS+mpKTBY8uJikdnC3ahb9OeudcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZLLQP4AQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so1719315e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699122; x=1742303922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKUi+ss9u14qyT/Zwiy2mGBFpcrhT9F3tYQ4X8eVY2g=;
        b=ZLLQP4AQ/86m29e6rCRtWMtTeJ4eEWH/rlCpuDIVCXqMbKe8fNV+q1YlPeFtxuxIe+
         lAr8koA09fyMkn8vlutvIDmUd/99XooEfmYR9a0regP8NemB1GH4ktvpygDyoIYuODsj
         AFl4V8pwzyMqeK4ZCKYmKEnypV9+1BEKgQTBL5ACML5k8SWU+6u5ExAQnh2n+S7R5R9j
         xyG7Jv1ypj29SGit1zzZFooCWJY6vRo69jZyCQjHui9JVoa6TQCaH5oKRb+dUCORjpTP
         xvjiCOnEHtljnCeJWwENRqkIP869oshjj3KTJQBrP+g4v5vM2Pf7ywFYKd9wuh//0Hq/
         DobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699122; x=1742303922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKUi+ss9u14qyT/Zwiy2mGBFpcrhT9F3tYQ4X8eVY2g=;
        b=n/U8inB64nhcJB2c1Ofa6pcADrnY+m6lgnkCqTHJvw6TOpUs0WPgu+07qiQv1KJJfG
         9Xd1k/YK3Ryz6JHnPlrbk4OKOARhWqGF1lGShkQjWSwJ5hN2f40cH/v4Yr3zF6IZqJ0X
         3IK3gkqHq62Vb7eFKkeR19ST1uPvRnxXMAdRvr6It+11azwCikj3ei1NOJtHeVOMza9z
         Wqbnnf9MpU1RDXCYfc4AxlcwGucmarL0pxB7rklYbPyTCNT5R9BxYNyUAjrQRmZDRkZJ
         R1qRnc8eZN5+grhfdQkTcNBEOaxgN4mtVKYY0sUJunpAZqa4ZTiXY227zCVoUIXeZ4Oq
         RyJw==
X-Forwarded-Encrypted: i=1; AJvYcCVlW/i+zoURPSlc2Rx5qc+i5r3MVG2FaVGmyX+L25Hwf9gOQGBYzkIKWHWen7sYbUsMrehCjNN4t6i1AKQrXC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTdm6AR3A7PxWa+qX0nTyamayAKUvEKONFNYLfMZVcPWwg0K0
	yvl5pepW23vwf+9Gh7tox1E+gdlS1Es/IVVdExB03ImC//l1e7DVSmLIcPFpaKR+AbJDN38/7PW
	r806RdEv3zg==
X-Google-Smtp-Source: AGHT+IFEGPTY7Ml+tuTOynefjzLO+UpkB6moVI+rzTawpqu6Ohcjxyu/ir2TjMNVGvCGq6alb9Lb1cZqdGxcFw==
X-Received: from wmpz18.prod.google.com ([2002:a05:600c:a12:b0:43c:ebbe:4bce])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6d9a:b0:43c:ef55:f1e8 with SMTP id 5b1f17b1804b1-43cef55f398mr97810345e9.13.1741699121899;
 Tue, 11 Mar 2025 06:18:41 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:23 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-12-dec210a658f5@google.com>
Subject: [PATCH v4 12/12] selftests/mm/mlock: Print error on failure
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

It's not really possible to start diagnosing this without knowing the
actual error.

Also update the mlock2 helper to behave like libc would by setting errno
and returning -1.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/mlock-random-test.c | 4 ++--
 tools/testing/selftests/mm/mlock2.h            | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/mlock-random-test.c b/tools/testing/selftests/mm/mlock-random-test.c
index 1cd80b0f76c33f04ef01f4dee6602f28b6a7c991..b8d7e966f44c67e5606d384bd660e5a4e5e8fda9 100644
--- a/tools/testing/selftests/mm/mlock-random-test.c
+++ b/tools/testing/selftests/mm/mlock-random-test.c
@@ -161,9 +161,9 @@ static void test_mlock_within_limit(char *p, int alloc_size)
 				       MLOCK_ONFAULT);
 
 		if (ret)
-			ksft_exit_fail_msg("%s() failure at |%p(%d)| mlock:|%p(%d)|\n",
+			ksft_exit_fail_msg("%s() failure (%s) at |%p(%d)| mlock:|%p(%d)|\n",
 					   is_mlock ? "mlock" : "mlock2",
-					   p, alloc_size,
+					   strerror(errno), p, alloc_size,
 					   p + start_offset, lock_size);
 	}
 
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 4417eaa5cfb78ba2bb0f51d3418c9b768ff0fe90..81e77fa41901a095cc041e05d01da7dffbf2f4fe 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -6,7 +6,13 @@
 
 static int mlock2_(void *start, size_t len, int flags)
 {
-	return syscall(__NR_mlock2, start, len, flags);
+	int ret = syscall(__NR_mlock2, start, len, flags);
+
+	if (ret) {
+		errno = ret;
+		return -1;
+	}
+	return 0;
 }
 
 static FILE *seek_to_smaps_entry(unsigned long addr)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


