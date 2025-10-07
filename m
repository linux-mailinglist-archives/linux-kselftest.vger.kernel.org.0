Return-Path: <linux-kselftest+bounces-42808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51464BC0183
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 05:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702903C360D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B021D3E8;
	Tue,  7 Oct 2025 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Co96UKJO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E821ADC5
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 03:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807875; cv=none; b=Lo+zNYJBUpNZCO6aX0nwe3AQbUZQtFPnrG4Rc1M2AotOUlQeWWEdVMW2KA1DiybgR3O3JhLG3XqhwnkHC71falKzAHgvsR7M5Rbr0+If7q7hbtg45WddoD3v49VUtTh+F3pkUadOtTCHyErz2XK6/DIkV+P7Dk4g4Aei4O5ytIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807875; c=relaxed/simple;
	bh=hXIL+PGMExM2O36pRQKCAP7Iwodxl63KTYS1axPZkVc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAN44j6HAg7Sn7rtpBKMBUPWp1JREQWw5eaACxsNPxLRnqigUTNGZ/0crGqoaU0n0e5bRfqlgRPLMZzGXL7LFM1BK8ouJTgFZo3RZeuJoN9SkOAbrwv+wf5LYiU/QpcPjVyrozgwLbTnG9bDvdcCdLAuyi3jqd6AWmD1x3v1oV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Co96UKJO; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5521c99636cso1974584e0c.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Oct 2025 20:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807872; x=1760412672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z64stFRl040LRM1yj9RgVROnladG4B1zFYyNLh4mpw=;
        b=Co96UKJOs/lXYzPcofkU0LI9M0SCJ2pozA7yEb7maXn//ZwO3mq4yiKKUFHfXvtmTa
         AvWpWbQIHXhwTAB3z0RIlJwHVrmk/uO7DRB63FbfZeXIKhMOHrTNb9LuKoWH+mfvLib/
         Su0/d3YQ+C/ZIAjwpOUU3kR8bwH+TsEBXrltPxzfvuL372xlHsysKEuAnPWsKFkPQuJU
         Ply/2T/8LozOQjOXBeaC+u0BsdGEavLj8/Km/WFyfILCzcmxiiu3X6Z/c5AqewjV+HvR
         nS2YBMeJ9gw46WHHWL3UDlColw79UE5ZKGsfn8DmeEoD9gXInF+1MrJCtTMIUJ9BGNC1
         fjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807872; x=1760412672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7z64stFRl040LRM1yj9RgVROnladG4B1zFYyNLh4mpw=;
        b=gLQwUYZ3ehS92eNZnchSdHK4TljEaZAFv/RuqsO357ry+PcPYFM9c5cEiLcuwJRyuo
         vqcDFpiph4tFqjtBXrDd7k4VPDqKyPfgybKvFBx9xj7zw72JiiMS7aNfUKXEIAoPDaN4
         e1/TmgnsoCQ/QW03tLeSK6JPXe8ou2HieuAsoksJFlbQaDOW+/137r/zkwWXoMn1f4wS
         q6ZeeslQgF3miTapU8zsZz/+AoRbIa0Zchp0JMDwL1b5QlE81lnISJN8EZjadOz7wGno
         djaXOEgeW1spgq/l26S8aXcwwBN5XQINGPhnOTLzy7h4jRQnhyYAo2/3ZY6oVZwlvKuc
         UBTg==
X-Forwarded-Encrypted: i=1; AJvYcCUv/0lYYojWzEVZA47WYO91zvth2JaLe1u4VImT5I7TsMUJUP6ImM7HrUIgJn0z+Yw+2nkKRIDXXkB9UpinuTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhewFAo3ZwTH/3wMkWbfStb9vNHZfivyWG5UMOBci8tJ7o3NwI
	JUzbMzNdE86t00fJeV1l1Hjsi5GhvHs+nRRPLNJr+g8BxpWuSUfH7suv7NtvK/QLg8k=
X-Gm-Gg: ASbGncvn4aQ9fZ3cLB2erd0vKP+E5fYm1E7DBxzG7KgVl9S4m+2DBc88+I0zSoOLwCz
	sT2rRg8C2VgVQ/b0yFGDFfwx6cCBkgQap5gMX24tG7cEGpUWaKTDAavC4KRykyjx4rgH0yMe6Od
	T7fG4KlsuF71KrMtjAayCSozaCxGJx4wUHWy38/c12/GCQieh8V3Ew7pTNeyT/LAb6w5CNYUYk7
	Yur99nliO1x1YFfg3Zzs56W3VBa2dHTpkV7NgZDCc9me4m4w6vKZCj/9n9c4UwoyNAE1z5ugJoG
	tun9LiZ10SLQeP/irLjZ1cWLk/Eu5o956lIMusf+a20aGtGHShh4Y1lXxQ1jqR9N676JNk/3fYK
	l/aeQp0Cn5CuC12LjkYQfV2cDA6WCHFTeXtYRnpdbgydfSx6XNsgZR8DbMGFOHG64bxCkUb5cBY
	BYfVpYoHQTbHmlW7ZjdI/Nh9FMfHPorOA=
X-Google-Smtp-Source: AGHT+IE4EXqWZRhl2HTUQHS0IRjtbgPekpf92eZABSKl8jPdM7uErllIFBlkrwrXfARb9nmkBXCE5Q==
X-Received: by 2002:a05:6122:20a5:b0:54b:bea6:a226 with SMTP id 71dfb90a1353d-5524ea29092mr4456170e0c.11.1759807872536;
        Mon, 06 Oct 2025 20:31:12 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:11 -0700 (PDT)
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
Subject: [PATCH v5 5/7] kho: don't unpreserve memory during abort
Date: Tue,  7 Oct 2025 03:30:58 +0000
Message-ID: <20251007033100.836886-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
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
index 77fd7dd991d2..902c30feae09 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1083,31 +1083,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
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
2.51.0.618.g983fd99d29-goog


