Return-Path: <linux-kselftest+bounces-37278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF67B04794
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 20:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA7516C71A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 18:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD78277006;
	Mon, 14 Jul 2025 18:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VEoVx/WS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849E727781B
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519224; cv=none; b=sMHa+LrM/QTbbJ+ZSHjgZE8rEazPHgVLz3rSoMqffODvFEBoMz2tNvgMel4n0ODHZ/9CSFkufjjVVbp6O2adwn6IlXax566FefWF1Mha75hr8c8MS3r+VGHQIrHCyrV30uY1PDJarHlDwd4WHAFHBq3Nx1npOfcN9+SmucvNTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519224; c=relaxed/simple;
	bh=/UeEGxlOewjC8jnB2qaVMXdrCNukFU+x+7O0REEOr4s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XO6ZWiAAszuuHi37JbXd9ZRLMDxNWap9qLfxqfDls/oAxUYT6s085yvhzkrVGLCBd3o9GLHbeNlNyGR4LqrOZ/j0HMfHis4Ols1J9zHT5yH2tBvvhlVPPwxLtqq0/SIzNChbd7LTZOK1p/lli7Bg/DC1PxLLgDCQPwmIgz2jwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VEoVx/WS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74ea83a6c1bso2054789b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752519222; x=1753124022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BSzIQRK9wYKqtO6q1xNWC7mMsqLr8/+7XvJF1HX+3iY=;
        b=VEoVx/WSPxvy4XBJuHGvgPaX7CQEFesAVHXl3ITt2fMfoKpwniXS1yXx+/MiZGcDcj
         alEyVgEgpKyEOmkBukUEx2ZHWOFwWGLjr1niUcTyYWMW65QUHxMZEzSS7UDM2VyBqLAj
         hG01MM4Qfv4tUEc8ciiOM9V3grAQ07d18VmkguXsin/ZO17L4bS3/arQA5q2rFWh2YWv
         c1pofVHirZywhqyt/bDO0jdqgz8K213CZcK40/FwgMX4yooz9keVqLKjDBLteZ5uasw6
         qu4KuNOd+LWKFXn6DgBK7N4BAclyozGf2cR7Za2WBQD/wi48qbwT1uYNcmLOmXEtL+ND
         +E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519222; x=1753124022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSzIQRK9wYKqtO6q1xNWC7mMsqLr8/+7XvJF1HX+3iY=;
        b=EegwDnESCI/slDAoH5JnU86qQIAr39M9JFUW62gbNPE7RMXxVHzjFfWgY+BpyPcoGY
         sjCeKE1LOHNVpLaLZdVQn0OSRT5KL8KyJwV1mp3rfkRisy0moJQ8WWUgWXrT4G5+6VYK
         07bR0601iRQe2FocwHOIGV4ZFhjbE9n+C29vSu1Gx47FCAtWviT3+n8quAJHT+d5U8h1
         doD3nAPyRg/t/cQaNqDHi7udT48wg+z5L/WRmNXC/DAMI+130hsAO0LDVOY0ZSm+lxzQ
         szVBvfn8TdHBhx6FA7fu3rEciayXfmZn1rheFsOBx0BN0iFaGHnbpm54wNyPpI+0EyKS
         eplA==
X-Forwarded-Encrypted: i=1; AJvYcCVQUjjXX8sODispcnLouy0BVt/ad/+t2YyZdiuhKjlMlwY3fVglb467eKeNtBvJTXNEnD+cnpSMoh2ICI3Gm88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5M+2YMT8oMASYoOFjz1lq4Q2WlQ4NLLsjObXKAl1GkHObrkls
	WSIERn/FcX3Mh+E9TlOKbjyvZ/7EnKqCY2/H1J+U63zXz/B0l8u3SEO27nRNAEAA9ddckPjAsKW
	9x6MfTNmyWQ==
X-Google-Smtp-Source: AGHT+IF07yPy6tCu1SdFlppIyRM/VDPyyOePOaj6ysHT2Tq1ycCysMq/tn27RC7mbbIVpnq5MOo0bbF6p0Xf
X-Received: from pfbmy27.prod.google.com ([2002:a05:6a00:6d5b:b0:746:301b:10ca])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1708:b0:748:e1e4:71ec
 with SMTP id d2e1a72fcca58-755b40b6e22mr3568b3a.12.1752519221734; Mon, 14 Jul
 2025 11:53:41 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:16 -0700
In-Reply-To: <20250714185321.2417234-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714185321.2417234-4-ynaffit@google.com>
Subject: [PATCH v3 3/6] kunit: test: Export kunit_attach_mm()
From: Tiffany Yang <ynaffit@google.com>
To: linux-kernel@vger.kernel.org
Cc: keescook@google.com, kernel-team@android.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Tests can allocate from virtual memory using kunit_vm_mmap(), which
transparently creates and attaches an mm_struct to the test runner if
one is not already attached. This is suitable for most cases, except for
when the code under test must access a task's mm before performing an
mmap. Expose kunit_attach_mm() as part of the interface for those
cases. This does not change the existing behavior.

Cc: David Gow <davidgow@google.com>
Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 include/kunit/test.h   | 12 ++++++++++++
 lib/kunit/user_alloc.c |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 39c768f87dc9..d958ee53050e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -531,6 +531,18 @@ static inline char *kunit_kstrdup(struct kunit *test, const char *str, gfp_t gfp
  */
 const char *kunit_kstrdup_const(struct kunit *test, const char *str, gfp_t gfp);
 
+/**
+ * kunit_attach_mm() - Create and attach a new mm if it doesn't already exist.
+ *
+ * Allocates a &struct mm_struct and attaches it to @current. In most cases, call
+ * kunit_vm_mmap() without calling kunit_attach_mm() directly. Only necessary when
+ * code under test accesses the mm before executing the mmap (e.g., to perform
+ * additional initialization beforehand).
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int kunit_attach_mm(void);
+
 /**
  * kunit_vm_mmap() - Allocate KUnit-tracked vm_mmap() area
  * @test: The test context object.
diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
index 46951be018be..b8cac765e620 100644
--- a/lib/kunit/user_alloc.c
+++ b/lib/kunit/user_alloc.c
@@ -22,8 +22,7 @@ struct kunit_vm_mmap_params {
 	unsigned long offset;
 };
 
-/* Create and attach a new mm if it doesn't already exist. */
-static int kunit_attach_mm(void)
+int kunit_attach_mm(void)
 {
 	struct mm_struct *mm;
 
@@ -49,6 +48,7 @@ static int kunit_attach_mm(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(kunit_attach_mm);
 
 static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
 {
-- 
2.50.0.727.gbf7dc18ff4-goog


