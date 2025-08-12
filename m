Return-Path: <linux-kselftest+bounces-38792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A902BB22D98
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850DD7A54E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42C2F90C3;
	Tue, 12 Aug 2025 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w/aRAEt/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62ED2F659B
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016191; cv=none; b=sd3SyB5hg5m30wtuyGbSEmT/S56cWyacAIocrINl5taiZi/TifTcadYN9vDxQam8SuJ+/LF3kE6mYWyB+ZBdv/shHp+hoHZjEDSzH2QAq7kp1MGh1/qgnTiB2JEHQvvBUmMy7eOIo6qthDOBRRvaOsAnsTNTkxT7/lSXI+C/cJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016191; c=relaxed/simple;
	bh=7zd+1Q2nXxKRhSiNSR0nkmbGVXeZVbtHzoCniviHQwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QMNBXeuMLt105AP3M8bG82YwHVYbCYqlF87xqsLH73ie6+EV2RyJNuhej9aPhJc01qDpIY/s3BcoEuVaMS9jx4tBjfSIe4/GOYnETD30bdpZdZjC8GDv2ytEZRy1mCu5EDCyp5A/4yGFaZBouiSPtf2BnRYQPeudLUuEh5sM1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w/aRAEt/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--marievic.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-70e5e6ab756so81854747b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755016188; x=1755620988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZjXcxnVV61K5zKiboHXun1MZgLxE+8QryKh9246KOjo=;
        b=w/aRAEt/fTCUljWMxiyGymHnb/huFZWQvBTSIk0NfHofXHz8m0L80dToBYnztuLq3a
         lA5KKA+OnK5EiI9RKtOntDaq4mcOgtdle4O8bwxpQA80ZBWDaWU+9GuOPRkbJP2RvvG5
         rUJ1+mK9RA9bHkhfxPcl9JPltRX9DhD1W5PyVYRBwzT7/IQurMUn+3x/39GemPYCbbYj
         0z2c5UYSaX3Pyww2d3BvnnGMxx6nmk+UIlMxYHMPFCK8JiHi3NuVEJSig/gNXABUEOyC
         BfG4j7BoLD5mDumlvBu+ZRaqt7BHM5PFDiSGtFx0P0LVPGmYS4OyYVWnWtjJ9/ihGwa5
         BzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016188; x=1755620988;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjXcxnVV61K5zKiboHXun1MZgLxE+8QryKh9246KOjo=;
        b=V4sbQw83KQF10v6KX5Y/j7asdr5jAsP9JgIKoCBcRbZs1qMBNawzg/nGaBQdmsw1RN
         MFTPvvEa+QNagVmfsvhe5PKI06WJYxqwwcncTJhz0msr6Q/HOW1a29fwSGmNCqRnXX2A
         UraxldW+drAy0pu2CShDWn5RRRoarLk/AJTr+yOtr8YarupOT3lue4mWrCPf5WDW9wGg
         pRx3CU0aIDr9unWY8bRILC+jYpVoUkRxyevMSYr7Mx+0HKLsv+t1sRTxf2JG+Kzp4Ib8
         gPW0gFnixTwDE3ZZPfR8Wp5ZRVllIu6htH2vgLMFfyLlY81O4C1ZLMeTfPgbOOQsmNAX
         YF1Q==
X-Gm-Message-State: AOJu0Yy4+5Cjby2WEvIHacfl4kxkmPnxrugNI7Wmf76xjIpIwdGFLejU
	zIsQ8XiVsNYHHfxINpEaqsdY7eTdrebErmWHER9Mrw/qx+sM+0wE3fKgwUMgMuPOB7eGiFzehBA
	RT6EMg2MNEfqhoA==
X-Google-Smtp-Source: AGHT+IGwKwv5249Eya7pfM/i3ivAXTfbdYzSlggsR5jJH18s5NNyJ45xevu3PM8ULW+3cMiHRHBvv36PcDumDQ==
X-Received: from ybka13.prod.google.com ([2002:a25:bacd:0:b0:e91:771b:592b])
 (user=marievic job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:610c:b0:e91:770d:439c with SMTP id 3f1490d57ef6-e930b77dbd7mr104378276.2.1755016187935;
 Tue, 12 Aug 2025 09:29:47 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:29:20 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812162920.2923601-1-marievic@google.com>
Subject: [PATCH] kunit: Release resource upon __kunit_add_resource() failure
 in the Resource API
From: Marie Zhussupova <marievic@google.com>
To: rmoar@google.com, davidgow@google.com, shuah@kernel.org, 
	brendan.higgins@linux.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Marie Zhussupova <marievic@google.com>
Content-Type: text/plain; charset="UTF-8"

__kunit_add_resource() currently does the following
things in order: initializes the resource refcount to 1,
initializes the resource, and adds the resource to
the test's resource list. Currently, __kunit_add_resource()
only fails if the resource initialization fails.

The kunit_alloc_and_get_resource()
and kunit_alloc_resource() functions allocate memory
for `struct kunit_resource`. However, if the subsequent
call to __kunit_add_resource() fails, the functions
return NULL without releasing the memory.

This patch adds calls to kunit_put_resource() in these
functions before returning NULL to decrease the refcount
of the resource that failed to initialize to 0. This will
trigger kunit_release_resource(), which will both call
kunit_resource->free and kfree() on the resource.

Since kunit_resource->free is user defined, comments
were added to note that kunit_resource->free()
should be able to handle any inconsistent state
that may result from the resource init failure.

Signed-off-by: Marie Zhussupova <marievic@google.com>
---
 include/kunit/resource.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/kunit/resource.h b/include/kunit/resource.h
index 4ad69a2642a5..2585e9a5242d 100644
--- a/include/kunit/resource.h
+++ b/include/kunit/resource.h
@@ -216,7 +216,9 @@ static inline int kunit_add_named_resource(struct kunit *test,
  * kunit_alloc_and_get_resource() - Allocates and returns a *test managed resource*.
  * @test: The test context object.
  * @init: a user supplied function to initialize the resource.
- * @free: a user supplied function to free the resource (if needed).
+ * @free: a user supplied function to free the resource (if needed). Note that,
+ * if supplied, @free will run even if @init fails: Make sure it can handle any
+ * inconsistent state which may result.
  * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
  * @context: for the user to pass in arbitrary data to the init function.
  *
@@ -258,6 +260,7 @@ kunit_alloc_and_get_resource(struct kunit *test,
 		kunit_get_resource(res);
 		return res;
 	}
+	kunit_put_resource(res);
 	return NULL;
 }
 
@@ -265,7 +268,9 @@ kunit_alloc_and_get_resource(struct kunit *test,
  * kunit_alloc_resource() - Allocates a *test managed resource*.
  * @test: The test context object.
  * @init: a user supplied function to initialize the resource.
- * @free: a user supplied function to free the resource (if needed).
+ * @free: a user supplied function to free the resource (if needed). Note that,
+ * if supplied, @free will run even if @init fails: Make sure it can handle any
+ * inconsistent state which may result.
  * @internal_gfp: gfp to use for internal allocations, if unsure, use GFP_KERNEL
  * @context: for the user to pass in arbitrary data to the init function.
  *
@@ -293,6 +298,7 @@ static inline void *kunit_alloc_resource(struct kunit *test,
 	if (!__kunit_add_resource(test, init, free, res, context))
 		return res->data;
 
+	kunit_put_resource(res);
 	return NULL;
 }
 
-- 
2.51.0.rc0.205.g4a044479a3-goog


