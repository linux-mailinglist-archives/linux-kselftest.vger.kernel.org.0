Return-Path: <linux-kselftest+bounces-44571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6552C280D5
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCE554E90B7
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E482FB0BB;
	Sat,  1 Nov 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gN7eycO8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811912F9DBC
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Nov 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007024; cv=none; b=r5txYUJX6C99hFMQIsrP3/J2Sei4oYPP7fhktBGwReEcoPqY/zVysRBOtjqwCPrRawIJnLLKmG4ueUf5WC8VsjEJHnzQqAIMIk51MEvVGQ3dY6Txb02/agIx0e+zhMMj58ySwwVsg6pTY4RHkwlCET3zmbU62c0nRsQqB1kfg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007024; c=relaxed/simple;
	bh=yHqwthdjQR9NASx0Os0y7RkZY+CTnqkZiedG/ZfbJsM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+dg7/Rk7Sh2C3qfImyVHRU8rv9PMst1Oj6DhxfSppMezyIlnT9kslYpQk1qnpC6LvCT0XHls41pKPf6KFUM5ODZGh0/5A8M/9bQ79W/WRl7aN/8kv2pR6Z/z/NGpEk6CmPom32aXZYgosOYoPdmQ0nyNr6HfqDug0l5rQ5Xwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gN7eycO8; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-934e487a957so2826340241.2
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Nov 2025 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007021; x=1762611821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57rygU5OjDWbT5PCPIwncZxw1NBlZuRuRnZzBsppy54=;
        b=gN7eycO8W9hBtFwgbXMYmbIgawUgpGrbpoYURAUEQVZxFMrLP3ZULVAMwA7Tiw2n+q
         JU+NG6nxEUVIXRvxGHETXXpimzRta9F449hquKKDghUSwY+LzjG4Xl0wPSUyBbklSCa+
         hTa3YF2PA7nry36oNU3ZIt6WdDLaq15lguMUQfZGlstObc7CjRcPXPancdnK/v4wBy7V
         47X/8tL6dlU4lx0tWCx+DlFlj46Z+dA2fPtxBIkTnVrp6/qxY+XqG6bAViRPFIca9TPD
         nVo6F2YhIlUMbdWyl73lwoXZlMCosADB5wGnpf8RtzipK+9SAAKD+z0agucSl8q+RTyh
         xNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007021; x=1762611821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57rygU5OjDWbT5PCPIwncZxw1NBlZuRuRnZzBsppy54=;
        b=MSdKrxy/MNggCykJ1xI7SRKQYfYxb8mDiWcLAtPooq8mLPUC57mZEJLfUCF5bUM/Hu
         NS7tDpBMXRhmp3OkIFjmxPdxHxT77H2V6+2TODbzASO1q7COqV2EI8HXkF9MtG8BW1jW
         nyDQEDNoBUBzRFxFkuMLpr2IMiTCWB0kHBc713dnYI7omyJ8WMO/7yfF9f1/av8SHxVR
         QmnzrTpvfkN0RY10pjhCHo2x0vX6vLDG7iJVdgV0VXATq7V8y3h6vS8HjIcwu147vOJa
         87PlcjD1zCG2L4el+3dCp7CQjnvJGNMF9umhlWF8n4noYKMiwidqCdWtkhx2PRUkX+ND
         oklA==
X-Forwarded-Encrypted: i=1; AJvYcCVfDttOvYsC1RVMhsGTWU4f3DN6zpnMLnZ4ZFYdEpfe1XLb1Nla534p9oBF1l/LkdG/yypRBLP4+kxwM4kn0uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFK40Ll3rfZ5f1F3gc+RXle4/O8Hn963jJfT8Q+lPomvQhvOJ
	F5VbjEbh7CJ0LK8QAJVnlk97PMKlQ23KaflBoBFryxo2vD/r1yCxkoV+Td7BMswJTyc=
X-Gm-Gg: ASbGncuhbaBP3LU/rqSHbeamvr6nCD8inyZy9PleuWIuSIAN1GLTGnpiLF6Z4b/idq8
	sAqTGhTXnY8xdSA0g9Sp2aY3Fn6TZmllNhzYTR8zSpA2XTR5hnMadYarmLr+7RLvCDG50er4oBJ
	roTiy0F44wmpESS/eTBjS+PgK6qQywgts+Uu/C5CBnG+f260MIHdqT/drhiI1Uu/qfGGSMSoJeC
	5XYZaEieQKs9AnlhzJb+VdLf3OHWu+CB4REMPxequMLaJGiAZMYs8kP1gKvAfjHBK8hocahNQ05
	vVfbEu279RH3W353gThIBUh8P8HvaQn9gwhM2O6Lt7Inc5PF3Os5egLgjKbMIdaaou9H8YtobEK
	rSFA0csKltCZjiSh4kkEbEUDkFkcZtTkkKvhDCjU0V1veXQgfQA3BZCw/0y4t4+hKOSB0/q3Q2g
	e1bQiZZLvPIKs5AlYMSNl0LlBSKA4EMvKLGgKDls7VDo6jOVs89Tz3eQ86x879
X-Google-Smtp-Source: AGHT+IFHTA9MFhIfCaO4quOEqPC9MjBBViuMWnhpeFtjZfr2lHvftLMFFMHCzKtyyjM8DjV8X9i0hw==
X-Received: by 2002:a05:6122:90c:b0:554:e4ba:4408 with SMTP id 71dfb90a1353d-5593e006778mr2627356e0c.0.1762007021390;
        Sat, 01 Nov 2025 07:23:41 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 5/9] test_kho: Unpreserve memory in case of error
Date: Sat,  1 Nov 2025 10:23:21 -0400
Message-ID: <20251101142325.1326536-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is an error half way through KHO memory preservation, we should
rollback and unpreserve everything that is partially preserved.

Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 lib/test_kho.c | 103 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 73 insertions(+), 30 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index 9f7cfa6ac855..025ea251a186 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -33,17 +33,28 @@ struct kho_test_state {
 	unsigned int nr_folios;
 	struct folio **folios;
 	phys_addr_t *folios_info;
+	struct kho_vmalloc folios_info_phys;
+	int nr_folios_preserved;
 	struct folio *fdt;
 	__wsum csum;
 };
 
 static struct kho_test_state kho_test_state;
 
-static int kho_test_save_data(struct kho_test_state *state, void *fdt)
+static void kho_test_unpreserve_data(struct kho_test_state *state)
+{
+	for (int i = 0; i < state->nr_folios_preserved; i++)
+		kho_unpreserve_folio(state->folios[i]);
+
+	kho_unpreserve_vmalloc(&state->folios_info_phys);
+	vfree(state->folios_info);
+}
+
+static int kho_test_preserve_data(struct kho_test_state *state)
 {
-	phys_addr_t *folios_info __free(kvfree) = NULL;
 	struct kho_vmalloc folios_info_phys;
-	int err = 0;
+	phys_addr_t *folios_info;
+	int err;
 
 	folios_info = vmalloc_array(state->nr_folios, sizeof(*folios_info));
 	if (!folios_info)
@@ -51,64 +62,98 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 
 	err = kho_preserve_vmalloc(folios_info, &folios_info_phys);
 	if (err)
-		return err;
+		goto err_free_info;
+
+	state->folios_info_phys = folios_info_phys;
+	state->folios_info = folios_info;
 
 	for (int i = 0; i < state->nr_folios; i++) {
 		struct folio *folio = state->folios[i];
 		unsigned int order = folio_order(folio);
 
 		folios_info[i] = virt_to_phys(folio_address(folio)) | order;
-
 		err = kho_preserve_folio(folio);
 		if (err)
-			break;
+			goto err_unpreserve;
+		state->nr_folios_preserved++;
 	}
 
+	return 0;
+
+err_unpreserve:
+	/*
+	 * kho_test_unpreserve_data frees folio_info, bail out immediately to
+	 * avoid double free
+	 */
+	kho_test_unpreserve_data(state);
+	return err;
+
+err_free_info:
+	vfree(folios_info);
+	return err;
+}
+
+static int kho_test_prepare_fdt(struct kho_test_state *state, ssize_t fdt_size)
+{
+	const char compatible[] = KHO_TEST_COMPAT;
+	unsigned int magic = KHO_TEST_MAGIC;
+	void *fdt = folio_address(state->fdt);
+	int err;
+
+	err = fdt_create(fdt, fdt_size);
+	err |= fdt_finish_reservemap(fdt);
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
+	err |= fdt_property(fdt, "magic", &magic, sizeof(magic));
+
 	err |= fdt_begin_node(fdt, "data");
 	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
 			    sizeof(state->nr_folios));
-	err |= fdt_property(fdt, "folios_info", &folios_info_phys,
-			    sizeof(folios_info_phys));
+	err |= fdt_property(fdt, "folios_info", &state->folios_info_phys,
+			    sizeof(state->folios_info_phys));
 	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
 	err |= fdt_end_node(fdt);
 
-	if (!err)
-		state->folios_info = no_free_ptr(folios_info);
+	err |= fdt_end_node(fdt);
+	err |= fdt_finish(fdt);
 
 	return err;
 }
 
-static int kho_test_prepare_fdt(struct kho_test_state *state)
+static int kho_test_preserve(struct kho_test_state *state)
 {
-	const char compatible[] = KHO_TEST_COMPAT;
-	unsigned int magic = KHO_TEST_MAGIC;
 	ssize_t fdt_size;
-	int err = 0;
-	void *fdt;
+	int err;
 
 	fdt_size = state->nr_folios * sizeof(phys_addr_t) + PAGE_SIZE;
 	state->fdt = folio_alloc(GFP_KERNEL, get_order(fdt_size));
 	if (!state->fdt)
 		return -ENOMEM;
 
-	fdt = folio_address(state->fdt);
-
-	err |= kho_preserve_folio(state->fdt);
-	err |= fdt_create(fdt, fdt_size);
-	err |= fdt_finish_reservemap(fdt);
+	err = kho_preserve_folio(state->fdt);
+	if (err)
+		goto err_free_fdt;
 
-	err |= fdt_begin_node(fdt, "");
-	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
-	err |= fdt_property(fdt, "magic", &magic, sizeof(magic));
-	err |= kho_test_save_data(state, fdt);
-	err |= fdt_end_node(fdt);
+	err = kho_test_preserve_data(state);
+	if (err)
+		goto err_unpreserve_fdt;
 
-	err |= fdt_finish(fdt);
+	err = kho_test_prepare_fdt(state, fdt_size);
+	if (err)
+		goto err_unpreserve_data;
 
 	err = kho_add_subtree(KHO_TEST_FDT, folio_address(state->fdt));
 	if (err)
-		folio_put(state->fdt);
+		goto err_unpreserve_data;
 
+	return 0;
+
+err_unpreserve_data:
+	kho_test_unpreserve_data(state);
+err_unpreserve_fdt:
+	kho_unpreserve_folio(state->fdt);
+err_free_fdt:
+	folio_put(state->fdt);
 	return err;
 }
 
@@ -174,14 +219,12 @@ static int kho_test_save(void)
 	if (err)
 		goto err_free_folios;
 
-	err = kho_test_prepare_fdt(state);
+	err = kho_test_preserve(state);
 	if (err)
 		goto err_free_folios;
 
 	return 0;
 
-err_free_fdt:
-	folio_put(state->fdt);
 err_free_folios:
 	kvfree(folios);
 	return err;
-- 
2.51.1.930.gacf6e81ea2-goog


