Return-Path: <linux-kselftest+bounces-43733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAD4BF98B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 02:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB3683411D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FA211290;
	Wed, 22 Oct 2025 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cjgtpnfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49031EF091
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 00:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094650; cv=none; b=YSOI318JrVB6UX6gyY/rFTvW/Yqi9j1CWbOgffiupKXnLCKW0fekXlf49AV5yLePu/q6Dvd6HhsDgNsQLt8ZwJWM9iyuGNjp9M4jLsYnzj+elorAveJjZQKpnZuEDo8wJYpXoO5SGPBtTOpQM68a9pMmy/RMYF8UM3U83wMAEDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094650; c=relaxed/simple;
	bh=NGuveJk2P3XFlSgQ+moH+HF3wVf2P/A5UKylVtCRxfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ke2r/tXD3S4P6qEei8l8ibfl3W21Y57bbAzrf7nTCm6LAFX27rczLPUlzjULDoPrWRkH3+uF7ZBlUZeb4HN+wDzXcw6VQfuunF6XRMdtI5XZFPpargbHa+UUiHQNNeSvKBwcUWIQMy6NyemrzVFFJodqKIsQa+4Qg9dUoiShEZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cjgtpnfJ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e886550a26so2641041cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 17:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094646; x=1761699446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUTWKaAwDcLFEMDYOAPCNVz4GAFYSZN3Yq9aKSos2/I=;
        b=cjgtpnfJRQRa0bR+LN65GdHPNb2c+9dUntXfHLpWv+8cyIyvM8XpICbmsqZxj5NesR
         XD7Za7ot4g2AEsZdBEI6CtZuizwnk4hK5vtXgndS1uR7qfWQBfquLyfCY6zaq8CaBoRb
         J3kgAsRRE8rsk7QnEZ58P1seDxEXGRCAPTIyT12Xnity67H7/Ywxn36v9MygPQ3bIFy9
         a3pCB2suUME9/DBJDOaGJhtF3hW2NNl5cH2D7DXYGk2UOoekDN95jl57wpNIPDFZJQWm
         w/Vj8BgdezUFJTNd1hcf5RnPa/O1Q+IQysNpBn4dPzLdFLFWT6E6WvY/mo7xQLaInvXL
         VAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094646; x=1761699446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUTWKaAwDcLFEMDYOAPCNVz4GAFYSZN3Yq9aKSos2/I=;
        b=CwS+o31NWhNwDEniSpJKYiAMHyMo6yIMYtXAG1DOlxC1F2HpgUf60s4k7K3Jc2sKDD
         9/UtmVBsp+DCWy8BuEhCC5Xp5jdLG4ZArY3dUuoronLFsixi3Zl6E76RKp2GmaR+lxQM
         8Xm3dhEC7VPxPmunmdMyF/y9Y7ethC1pbHj57Mv1ZnwFu5jLZwS1+X/NniQp6TbyEvYj
         3wNP3E/T5yuwIKXQjlahk1t/7oU9WQdfcpKI7ws9qXdRG5VaeiFOhzg4v0zpLw47bAD3
         3jWZ/ncqD9UtHuuMSza1MuGMTWp1tI6+pMC5E+0vCWLXgOVVN/tBynknjWBwRVY4Ykaq
         auzg==
X-Forwarded-Encrypted: i=1; AJvYcCXIW90MAB7irgAHIOezdcpZDeXaH/cO4UhSwDpER1N5tRyzqnzLk06+CqN+VcxN0lELMOTnAKQLEDUZ3iXR2OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwntX5BNYu9GEM7Jv+ALjCF+GfYo1Gcjle5G0+P/QXSCQuNQcUJ
	7GluwPgzOxuv0a14c1oBiFwf7YjlYSuIwUPQq065HvDo+dFx5s4LKx7rZm+VaJqHoHM=
X-Gm-Gg: ASbGncvXBvnY7l1/X2Z6zMWdyENVAsH1aOAqwU4/WikKLaCsBOuWn79oJnB2g2AdAto
	ywDTEAIUKNP4s2DtGoqDGag6QEpNKyAxnlAhZTHJH32zP+aczdyZyc+6cfPqfljOAWmDrWSzEN4
	K4cnmkXyNHZF1cEtlkI6oJTfHXrVokF5AmDF7LfHTDbG4ZjV1z2dQ7kgwHyAFeqNgEmRbh5lK6n
	Kak0+AEf1KfuUREFsN3uf9wBTbfYhfYgyzTSl6LxOjAy+MHpOzGgD2ci74EyEWD07dzFsKfgMFw
	GyWggSChad2CgWO6KeF8O2K2wVNpUEWTk5wNzXTU00EHBRLcfx82Yun0Qy4SUsKUWKdPQPAdvFQ
	Zkaw1mZ0/wnE9rd1JxeNORlmIseAjUp/t4Jz5OA03N2Nv8sF4ZqkD02ikapbcmdSdF44hugYydP
	bHchS/qiejiEgGbElcDd06xc0g04UxkosuoUUVVxDmg1mnSwYDs+gKLuU2xB/qQVUHVpBirIOvR
	sEzv4YDM05BrfqMfgrkug==
X-Google-Smtp-Source: AGHT+IHQH5S7ZkBo/f+yTi+bMGIOL+QuMwmJCvKKYbXx1vIv8VH/9TwZ606gNIBVjYEELqz69qTPIg==
X-Received: by 2002:a05:622a:110:b0:4e4:6b32:697a with SMTP id d75a77b69052e-4e8b6e0b299mr139105201cf.29.1761094645817;
        Tue, 21 Oct 2025 17:57:25 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:25 -0700 (PDT)
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
	tj@kernel.org
Subject: [PATCHv7 5/7] kho: don't unpreserve memory during abort
Date: Tue, 21 Oct 2025 20:57:17 -0400
Message-ID: <20251022005719.3670224-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO allows clients to preserve memory regions at any point before the
KHO state is finalized. The finalization process itself involves KHO
performing its own actions, such as serializing the overall
preserved memory map.

If this finalization process is aborted, the current implementation
destroys KHO's internal memory tracking structures
(`kho_out.ser.track.orders`). This behavior effectively unpreserves
all memory from KHO's perspective, regardless of whether those
preservations were made by clients before the finalization attempt
or by KHO itself during finalization.

This premature unpreservation is incorrect. An abort of the
finalization process should only undo actions taken by KHO as part of
that specific finalization attempt. Individual memory regions
preserved by clients prior to finalization should remain preserved,
as their lifecycle is managed by the clients themselves. These
clients might still need to call kho_unpreserve_folio() or
kho_unpreserve_phys() based on their own logic, even after a KHO
finalization attempt is aborted.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 8412897385ad..89a3fa89db0a 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1103,31 +1103,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
 static int __kho_abort(void)
 {
-	int err = 0;
-	unsigned long order;
-	struct kho_mem_phys *physxa;
-
-	xa_for_each(&kho_out.track.orders, order, physxa) {
-		struct kho_mem_phys_bits *bits;
-		unsigned long phys;
-
-		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
-
-		xa_destroy(&physxa->phys_bits);
-		kfree(physxa);
-	}
-	xa_destroy(&kho_out.track.orders);
-
 	if (kho_out.preserved_mem_map) {
 		kho_mem_ser_free(kho_out.preserved_mem_map);
 		kho_out.preserved_mem_map = NULL;
 	}
 
-	if (err)
-		pr_err("Failed to abort KHO finalization: %d\n", err);
-
-	return err;
+	return 0;
 }
 
 int kho_abort(void)
-- 
2.51.0.915.g61a8936c21-goog


