Return-Path: <linux-kselftest+bounces-36006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C90AEC118
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0756E2850
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300222CBFE;
	Fri, 27 Jun 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdiHu0zw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749322A813
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056688; cv=none; b=DkibfK94kPuOgEzVZk4L9/2t4R82i4KS0ZB4YofWydWJyA6XSV4969QyrvFfaAFBpgVLDZK4jvh3CJ3W7+ugHfseBKejJB6Z3Sx8827vXY+3ZcauCECwlrS1pAM9UhY4z/BcCUXItMKqFCgU4IkFhQ6pFn4VQmB7j1PZjf+ZLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056688; c=relaxed/simple;
	bh=XwSHl3R6x0geSRen2/MMqiPJvr7MDKRDFgnW0OKJPCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lsfwzD1HOFu3yLaNf3vPoHs88PtzpspjADYYq5jAoOrziD3LdcGbx1qpuwVPWDxJyOjedlxoElpKBjspFcuhikvjYONHR1Frkx4kjNTUl1JkVlVNwFwhuRXg/2+EuWQBuEcI4cbMEvoTP1JQsOYzoaMfWog/QTn2H7TDmyqIexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdiHu0zw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7492da755a1so297573b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751056687; x=1751661487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ToBQsH2KBAAKqSrwB/wtB0CqIjOe4g4OmnGE6U2PU=;
        b=DdiHu0zwYmjAi1M9qk9LYBzby2s1YA3YsePDRdt2fckRErzUH8C9Fqtep0SHryZDRr
         prWY/W/aX4NofsvppCCTm4bDCXh9IkHHLiiEYWBiWJ42tnQIaf+HUQqRApZPyc2DV1So
         YmuN1cZdZ+NuezSCop/Tm43F5G8nm69QYQD3I7yKblzSJnH949MG7qzKc/9fNl1sNnSW
         3n1eLoF/d8bZnI/wQjzW4+zf3UhZe9/wK6tKwHeMtIS6q9V0a0qunH7BZxPxjgF5TMVT
         Py/w774k/lNsLjK0uYPHXNVm6ZC4J7FM9sni2KEqsXZ1K6i3fuwRrBneXivsAxZKwEtP
         PrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056687; x=1751661487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ToBQsH2KBAAKqSrwB/wtB0CqIjOe4g4OmnGE6U2PU=;
        b=u3eTJ1/IcD8Ipf11f9tscTEkikuY5Gkn/QUpAMZ2mZcHvsC5tvgnyd/UVOJ050MFoh
         +cgmoIt3Ir9iHyJKc+Zzb5dkUpwJhQJi6F8KMydtXsvKSUeTnH4GBMcgonMRMnKSs+R4
         uOi6aFWnL4/mL9olXi5HP8RV5L0MFAmlkWRw6L0nUAQh8pDqZgBcNDJqXG8P4R0VJB6h
         PJy9YpPdNfEWK5Z/0/0yHxBmQe19VuA5JxtOnz8/s7OkBezaRRzySWi/d7ItvkOQn8db
         398CpHsN2Ci8y0eEiey1bq6PjmZMcKUQDSamjSHxFG27rjpR0u9YNuHOjtE/xdXQxH7k
         +aXA==
X-Forwarded-Encrypted: i=1; AJvYcCWLdY54e14AExf+ETZQ+cFec9JFKjCEWzz0PvsaJOAQw+oEugoTK/pzAp2xA6CaQ5sbOvJSq95hA0uYg5Kdukk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBeiyylc67DvYqZBCU6XTNqz4AHECorPsL6dyhk9KgVKL6M48
	hHtpKxkyrANf6m/Dy9wRi9Ca09EbDPmYYvo8jMLV/0HoEMT4PJO/uAF4IaDHXI4mfSisUTS9zwP
	h8VMUrbnQWw==
X-Google-Smtp-Source: AGHT+IG1Mrm1GfWv2ZyciX5HSSEMNEm3l6zL7qGDpY7Ezj+upo8IhpSUE3/1E13yUIf6LuQtVaRH7SNBqpUx
X-Received: from pfkq22.prod.google.com ([2002:a05:6a00:856:b0:746:2862:2a2f])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:689:b0:216:1476:f71
 with SMTP id adf61e73a8af0-220a17ef9b0mr7428280637.39.1751056686793; Fri, 27
 Jun 2025 13:38:06 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:37:42 -0700
In-Reply-To: <20250627203748.881022-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627203748.881022-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627203748.881022-2-ynaffit@google.com>
Subject: [PATCH 1/5] binder: Fix selftest page indexing
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

The binder allocator selftest was only checking the last page of buffers
that ended on a page boundary. Correct the page indexing to account for
buffers that are not page-aligned.

Signed-off-by: Tiffany Yang <ynaffit@google.com>
---
 drivers/android/binder_alloc_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc_selftest.c b/drivers/android/binder_alloc_selftest.c
index c88735c54848..486af3ec3c02 100644
--- a/drivers/android/binder_alloc_selftest.c
+++ b/drivers/android/binder_alloc_selftest.c
@@ -142,12 +142,12 @@ static void binder_selftest_free_buf(struct binder_alloc *alloc,
 	for (i = 0; i < BUFFER_NUM; i++)
 		binder_alloc_free_buf(alloc, buffers[seq[i]]);
 
-	for (i = 0; i < end / PAGE_SIZE; i++) {
 		/**
 		 * Error message on a free page can be false positive
 		 * if binder shrinker ran during binder_alloc_free_buf
 		 * calls above.
 		 */
+	for (i = 0; i <= (end - 1) / PAGE_SIZE; i++) {
 		if (list_empty(page_to_lru(alloc->pages[i]))) {
 			pr_err_size_seq(sizes, seq);
 			pr_err("expect lru but is %s at page index %d\n",
-- 
2.50.0.727.gbf7dc18ff4-goog


