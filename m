Return-Path: <linux-kselftest+bounces-38667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DFFB201C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 10:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8531620CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843182DC357;
	Mon, 11 Aug 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBu0tV7S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1F42DAFC3;
	Mon, 11 Aug 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754900733; cv=none; b=hpjQfpkOHmQMUZjRYKkk4udgGot5Or9QYKj3cJJ6kEbRMoXUtPta8dfXJ5He+jhnL22wIqyRngJvCMK+11m2Cq0GRBpH2uwR7RzVhPtvBP0KLMsDTOegV5gWMhqxp9sfMC4aP3ctNATiKCjAyNZ7aaLY7lLg0Nj5XbmrYjee94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754900733; c=relaxed/simple;
	bh=AX4qbF1XwwQU81rpLwIDoyjLFeF3rSGWbifPTbjdHrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zg0uI+QriZP0JtieG0k/8w1GdR/oBPf3WiIGimtSp4zV3CQFXg4+9C+WyCsxX7BYb1irSRkTp6+oVuQIiVXeXWr1aM7vTkIa47dzGiMxb4LdgON/UQSETof5eeJp8DOE35/4QJt4z2SjZbY4McLkDvMUEQEsQhqlRhiL8wRCc5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBu0tV7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E4DC4CEED;
	Mon, 11 Aug 2025 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754900733;
	bh=AX4qbF1XwwQU81rpLwIDoyjLFeF3rSGWbifPTbjdHrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBu0tV7SisZJigpGLwfJlV2DUdG+zG1xMTy9xi/TIyeMR5QWWzL0vrHVWTDRyETLf
	 9wif8JusDG/lncKaw75hHOvcdqYqn/hmr+fqPbslLarR0lND4TxrjqOXleCy0VgHww
	 GueKwq1d+VQbbVudmODDZr+IKPx3dEjguWd30pfO49xBo595IUSrVNKUlqaptMEDm9
	 KP31uI9G5AP37tXrvaMBfcsjXU1W0CCSlWIXI4CgqU7P5fOOJ/Xo7AU7E4ynb4fCqu
	 n34r44Dg10BdzEJjqjj3L+enf9CPz3opBOem/pEGx2qDAobHWQmPbtyV9jD4PbU+67
	 7mhcCWzujOfug==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=DFschuh?= <linux@weissschuh.net>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/3] lib/test_kho: fixes for error handling
Date: Mon, 11 Aug 2025 11:25:09 +0300
Message-ID: <20250811082510.4154080-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250811082510.4154080-1-rppt@kernel.org>
References: <20250811082510.4154080-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

* Update kho_test_save() so that folios array won't be freed when
  returning from the function and the fdt will be freed on error
* Reset state->nr_folios to 0 in  kho_test_generate_data() on error
* Simplify allocation of folios info in fdt.

Reported-by: Pratyush Yadav <pratyush@kernel.org>
Closes: https://lore.kernel.org/all/mafs0zfcjcepf.fsf@kernel.org
Fixes: b753522bed0b ("kho: add test for kexec handover")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 lib/test_kho.c | 52 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index c2eb899c3b45..fe8504e3407b 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -67,13 +67,20 @@ static struct notifier_block kho_test_nb = {
 
 static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 {
-	phys_addr_t *folios_info __free(kvfree) = NULL;
+	phys_addr_t *folios_info;
 	int err = 0;
 
-	folios_info = kvmalloc_array(state->nr_folios, sizeof(*folios_info),
-				     GFP_KERNEL);
-	if (!folios_info)
-		return -ENOMEM;
+	err |= fdt_begin_node(fdt, "data");
+	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
+			    sizeof(state->nr_folios));
+	err |= fdt_property_placeholder(fdt, "folios_info",
+					state->nr_folios * sizeof(*folios_info),
+					(void **)&folios_info);
+	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
+	err |= fdt_end_node(fdt);
+
+	if (err)
+		return err;
 
 	for (int i = 0; i < state->nr_folios; i++) {
 		struct folio *folio = state->folios[i];
@@ -83,17 +90,9 @@ static int kho_test_save_data(struct kho_test_state *state, void *fdt)
 
 		err = kho_preserve_folio(folio);
 		if (err)
-			return err;
+			break;
 	}
 
-	err |= fdt_begin_node(fdt, "data");
-	err |= fdt_property(fdt, "nr_folios", &state->nr_folios,
-			    sizeof(state->nr_folios));
-	err |= fdt_property(fdt, "folios_info", folios_info,
-			    state->nr_folios * sizeof(*folios_info));
-	err |= fdt_property(fdt, "csum", &state->csum, sizeof(state->csum));
-	err |= fdt_end_node(fdt);
-
 	return err;
 }
 
@@ -140,7 +139,10 @@ static int kho_test_generate_data(struct kho_test_state *state)
 		unsigned int size;
 		void *addr;
 
-		/* cap allocation so that we won't exceed max_mem */
+		/*
+		 * Since get_order() rounds up, make sure that actual
+		 * allocation is smaller so that we won't exceed max_mem
+		 */
 		if (alloc_size + (PAGE_SIZE << order) > max_mem) {
 			order = get_order(max_mem - alloc_size);
 			if (order)
@@ -165,13 +167,14 @@ static int kho_test_generate_data(struct kho_test_state *state)
 err_free_folios:
 	for (int i = 0; i < state->nr_folios; i++)
 		folio_put(state->folios[i]);
+	state->nr_folios = 0;
 	return -ENOMEM;
 }
 
 static int kho_test_save(void)
 {
 	struct kho_test_state *state = &kho_test_state;
-	struct folio **folios __free(kvfree) = NULL;
+	struct folio **folios;
 	unsigned long max_nr;
 	int err;
 
@@ -185,13 +188,23 @@ static int kho_test_save(void)
 
 	err = kho_test_generate_data(state);
 	if (err)
-		return err;
+		goto err_free_folios;
 
 	err = kho_test_prepare_fdt(state);
 	if (err)
-		return err;
+		goto err_free_folios;
 
-	return register_kho_notifier(&kho_test_nb);
+	err = register_kho_notifier(&kho_test_nb);
+	if (err)
+		goto err_free_fdt;
+
+	return 0;
+
+err_free_fdt:
+	folio_put(state->fdt);
+err_free_folios:
+	kvfree(folios);
+	return err;
 }
 
 static int kho_test_restore_data(const void *fdt, int node)
@@ -291,6 +304,7 @@ static void kho_test_cleanup(void)
 		folio_put(kho_test_state.folios[i]);
 
 	kvfree(kho_test_state.folios);
+	folio_put(kho_test_state.fdt);
 }
 
 static void __exit kho_test_exit(void)
-- 
2.47.2


