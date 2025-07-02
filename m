Return-Path: <linux-kselftest+bounces-36236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F6AF07B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2EE51C05326
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 01:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9211465A1;
	Wed,  2 Jul 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4/4E11C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B798154457
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751418299; cv=none; b=qwNdpNGmc5pYF52Dnlvl3BMClay/Z3kntxndktpgewOygjWk0/zsKFIFUl/0AzevGfPT7k4hemuuRBnSA3u+q2urjR2knHZo/VkY4fsrgh+pTa1ToQn6B/T+MoMoqoeS8z2SroC9Eap6cT+qmSLGXe8xQdyFOlVlM+C7nA0xw64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751418299; c=relaxed/simple;
	bh=XwSHl3R6x0geSRen2/MMqiPJvr7MDKRDFgnW0OKJPCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eHP8jYoTZzoKdw7RyPh85kALV6FqJPyT0yqIfqFlGWtWsg7DBjPiqOCIbyFG50N1oiWYVU6SWe+imeYwV92ZqV3Uu1KBHjRlp1h+A7zZjiCV6zeThvcJFTkiV26UI+LjQlX5akIXk2NNRPdu7pNvUBDCajctvcxuvADsQm5gxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S4/4E11C; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748d96b974cso5603780b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 18:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751418297; x=1752023097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ToBQsH2KBAAKqSrwB/wtB0CqIjOe4g4OmnGE6U2PU=;
        b=S4/4E11Cs45IadDAKWKIqLmKeUt9rTA/xRkun8aCNEDun7gt6RwpSdhj8FEV4JUVKP
         CLoxRhcY5sEowlbYVXpe9WAyAfiggvIlwW2+CyCoOk422ytoswjnGC3MiVfctgI4R/PJ
         Ng7P1ar18W7w9g7vKAFvzRRvtSGG/7ZJw85g3of3Q1FNfuLlY9Z1dvpVA+M2r/GyQ4gb
         q2ntrkke1enyF+AuBcZKevh5UwZ3VXnuHF4yOx9yqR3XZVxZBtIA5qSWZt5Usk7ln7wE
         GlaVRx9xk1yFkW9l/8BUE0P/uzsSX49dFzl38SblfcmNLNXboBw5dTWU6pWDfu3lJrV7
         qVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751418297; x=1752023097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ToBQsH2KBAAKqSrwB/wtB0CqIjOe4g4OmnGE6U2PU=;
        b=ZKfzRZr+p4fTnhyBAK4T04aaoQ7itGoFGLiOVh91bVr5ksWozP8MWtiIvCoxo6tiPY
         c+tEMFaGgiqYhbrt2MXDSIlU7tl70QYzkY06JwNKiVf2NQ4pQ2QEA2EsnbTEhKzRnBWD
         15VYwGs5p499q0AFfAU0Z35kTGvhhtmL9D/vX2vn7UplarAoEv5azBUDkK4N8SEUfBho
         gcFyQQZSbppV43/mzjt6cizPYkHSgMfDxy5zdING7u4C82t+I2Mg82xLt/0P5ofYLN1i
         nWwM/MFw3QoJEvAFRse2NGROrrJIM+Q2roxh8MfyoLGd+bLU15xCUXP64bi7m9hOArnA
         MKvg==
X-Forwarded-Encrypted: i=1; AJvYcCXz66Vh9y4STfUwX1xPYkLIhanHRaoZQtPZC8mgh+VAJe/xxCUWJO4XrHVgnPzc3325CxNofArv+HSB1pHqP1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqIwCLGbKrcA+FbhOOyr7c3ut2kF9reTWtknmhHIAaY1/YjgV2
	Nqx2Pju4Zju/irwbks3N8OiAXVdxFYiHLSsYv+hRSYLmjmheaL6JUFilG8t5c8NtvGMZ83RnIic
	A8nnwsT7mJA==
X-Google-Smtp-Source: AGHT+IHjxkJhNpPJlRTQPrSVhZEAgwC4vRTmDtOI94X9/M4vSCN6ez22PLOMuaeL7edmsjjLJkFV7JIuOA5k
X-Received: from pfcj5.prod.google.com ([2002:a05:6a00:1745:b0:746:1bf8:e16])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b53:b0:736:33fd:f57d
 with SMTP id d2e1a72fcca58-74b50f51d98mr1094467b3a.17.1751418297579; Tue, 01
 Jul 2025 18:04:57 -0700 (PDT)
Date: Tue,  1 Jul 2025 18:04:41 -0700
In-Reply-To: <20250702010447.2994412-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250702010447.2994412-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702010447.2994412-2-ynaffit@google.com>
Subject: [PATCH v2 1/5] binder: Fix selftest page indexing
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


