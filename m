Return-Path: <linux-kselftest+bounces-37276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF85DB04790
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 20:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D5B1AA00A0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04DB277003;
	Mon, 14 Jul 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+O7YNfs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795C276059
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519215; cv=none; b=m/DoLXVK3RdZIeHyNj/xpm0K/rzmFzJ2k0bkGiTAyKrS10dpepg/Zz93e3UovC9kIY1na+WLUvqmN0pOkSQlv8wZe7U9235JXxUh7sCZlcMoQhGFg07kYrvjUv76wrw5667rYie/Dzc8wT0e6tddeGzOVRklkmOkKjUSvNzdRaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519215; c=relaxed/simple;
	bh=XwSHl3R6x0geSRen2/MMqiPJvr7MDKRDFgnW0OKJPCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YJBJ3iYHn71nfY/PztyJhSjF4A3HmxvpHb8go86BhTRkXxv3aEbrv5Epfk4a0WBFXanwsbXodCbUokPkdjd9XA/kF7qiyj2D1GFRDjYQ1gPBW5bDyqioWPJz3CYDgGZ/LstMygu58sVDQydoxJGDSeKrEIfLzqhfeEkhkVMu+YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+O7YNfs; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2ff90c66a23so123456fac.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Jul 2025 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752519213; x=1753124013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ToBQsH2KBAAKqSrwB/wtB0CqIjOe4g4OmnGE6U2PU=;
        b=j+O7YNfs64EISFMnzJ77sAwPWhyHmP2fxsHGUIPfp0tQzkxaphWjqlYD71Wa3hUVkr
         7pAf+EaebfDYzx1UfoUSCAP7dT49muGT6eCvX768vwI8PINtOuVBN+6KeaR/XvNn0sW/
         aLQUCutPe3Pl2DUkLFnyZoifXW5fVHCbmELMEli98aVzdxKVwrfoD0frhkVoGf6SedZp
         7YRYEI3MI0U6Xp1tp+R45dUQbGp5nQdQAhzGcaJB6IqktUV273IyoCDvXal6A+HNulT/
         nyKeQus7IlSV0I8G55knBIuGdr4FmXuBtCcwmNB+Pm0QsepYvPbOY1SHk1oV3LzsJu9x
         rt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519213; x=1753124013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2ToBQsH2KBAAKqSrwB/wtB0CqIjOe4g4OmnGE6U2PU=;
        b=juSHKioRWyaTJBQiNw/hV9G61NPVRwSkrAWfb/grDoen1WRo0umXNw07XbE/+MWSDY
         9JkB0Y1TWpDl4AM067PMX/WoFYUXScXlvD71HUPiNZaINzLE0r+TWCnm/kYWulfw9HG1
         QFIW556+9/rSdzgWC1ChuIl51Nkf7EWZaMIHYzd+HEkdIGLL5lK2UXqim6xzNbMVndlR
         ummX+Htaysl0uemlVELTX/D8+y1sqsSpqgvVQfMD9FRALTguAvgBI2/x1QfpHQ3Gmz3V
         d/LVhzRjY4P1aKuh6X49jjmBTDUTxN0z1G1+tkUYuQFtY13efU41co49caLKxT0DxuBy
         RFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrbUtsTtsninjsVJ4gLAGU//Q1N8QOqtQIKwnL+v1Zb+Aev6hsM1IeGc4lE0/snuAN4obdwcWy5mRQi5RjhfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeAGqmGpJl7jBI7SWDXXtPv+dhkjMULfTYQdQMkcJi2tP/JNm
	9Jz74vX0s4yaXACi2v7UPIg56gDqJw01nPBglBN1VjIZyf8LIOpfNIuNZjGMEC1WsCAipdAFbWr
	C2JdClN1k/g==
X-Google-Smtp-Source: AGHT+IFitcv4rcRBTerguEKCsh7TKl705K/Y/N/RPPwgQCEScQ+VKqIuk28UlrV6d2EJBb5zRjTc0wf115oi
X-Received: from oabra17.prod.google.com ([2002:a05:6871:6111:b0:2e9:7781:2867])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:2b05:b0:2d4:ef88:97af
 with SMTP id 586e51a60fabf-2ff26e7a249mr9942418fac.3.1752519213343; Mon, 14
 Jul 2025 11:53:33 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:53:14 -0700
In-Reply-To: <20250714185321.2417234-1-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714185321.2417234-1-ynaffit@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714185321.2417234-2-ynaffit@google.com>
Subject: [PATCH v3 1/6] binder: Fix selftest page indexing
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


