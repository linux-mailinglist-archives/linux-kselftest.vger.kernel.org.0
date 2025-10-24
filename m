Return-Path: <linux-kselftest+bounces-44000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51891C07378
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5189F4E8F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5596133A001;
	Fri, 24 Oct 2025 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i8TI6USH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C03376B0
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322215; cv=none; b=V7nitEM3HhwAsP9LcMe8uZQtuqZiFK0xg4phueMA3wnBYXE7Mc8Kqz+Ja4Ec9M8sRb5kK6du9DYtv/xJCMpPmHg2dXCH+cZXx1iiO5YyY3lgPzzs5e1k5dqjFbY0lsPVfWBUjuGOcbvUEFcUinxfegLMTMuQNIFK6zgZ1qvMmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322215; c=relaxed/simple;
	bh=Qk9S6IHmnrfw6wGq0UeG8nzAs7ZVD29vG6VZbpdt4P4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWnh6YosBPk6lwXIco3taMdQPAFJ0VSW1zKxoqiq+Rr3WCtvskvbgYEFjZo2ru4v9NT0J0JJo29+YIqVj+UKNJ7D4x+/PO+vv0jhD4QtZakBEoKu3dVUIiiw60tpTK82HEquSqd1mHidxSr57/mS7ZCCJlC0z+m2X7EBPjdTlyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=i8TI6USH; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-781421f5bf5so25511177b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322211; x=1761927011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqVXyF+IsYXkvSZaiTZ7JkU0PjsMFTNFd+jvNj7uHBc=;
        b=i8TI6USH3ovpUOvOqT7ES6/CEvz+kW1mdR/tOkbCef1KYO1Ff6QgleqdhlUOEcCBD9
         j0LL/Ir4RyOT81WiLI2jx5dXHieXzlYwfYYWiqbFKn+CcKPgAg1rJUKFkRpjsNksawQc
         gBU54fw24tRt3r3/7IJ4MWPzBj3T0edqKPIszJfTt3Ok8Im3IhvW0TH9HtvIqF1AL4rb
         0ChP1HWn6zETm5al/KiNgYE640m+17VmjkxYfv066qEJZree67E1oYk0Dxg77TAEJVlw
         GQ1RMsiaKqzK+YyoMDPpC7JiirTvQ3+3cRFaYvAOUs1obbAJKitVlhfV6Am4x54Jt9HP
         0mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322211; x=1761927011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqVXyF+IsYXkvSZaiTZ7JkU0PjsMFTNFd+jvNj7uHBc=;
        b=IqbDyeWPDZVERE5+Vbz8lASFhDYAD3+Yusj7OU5u9IUigK45IlNDhd4rpNkyDcU4ti
         bj0zfByaFs+ySMo1ZNnLazsBJVLuGo1BSpsj7TemueU8sP7a3+ssxENG/KelykHeTGrq
         aDBVZsDvBkSo89iWYPNtfCpwQjdtua/kHSn61xMIcNDuEV0WSxjDadgctnyFjbyccWp/
         rksNaUKvgnovf4axwIR3rPlSrw2wUYnAy/9sckqQ3xPJr9kNgZp8UexClzkm0teISLLE
         9L2G45khk4M1MqD5hODv4eVBwsEPPYCvTmxEvMGU+ABdQq9Hpo6vQ0Erheymh39JHYhH
         5AfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsz3xZVr7DsW7+/GXRVPQy6CrHfmHxi9dOZa+8sZBJneIOzFI2zQ0JG1E9HJwNuNMCkI40sNe6L+f5rQPMerQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJE9pjjW5+zedGRPZfGWGwRR1eGA9WGh/kxuL2ONEWhmD3v5Wd
	bhObNFQ8NLIENr8DtPvo4GOlQ18LBP7vTdPfj1iUn9zjEd/dHfH40tBiv4A1xj0aR74=
X-Gm-Gg: ASbGncvRRFpWNjbuLMS3g4549kv40qi9yemYNUgfMsgGSv8kDrf7gdBpTVWNAlLwUAB
	RKSS7GY/P5ZjRxxVkyxCcfx58tloSH9wMMlskmzpCAyMVCrvTNy0IAWe/li82LEARI4hhpYDuO1
	V6HVKt+f6tGMFlqPTWZkzhV3kLz00MEQLrS1FASD/LZbCg5M+mamXCcJazd+b6ZmwXewLkO8nB0
	u+SMgQjkWoFxOhd7q9rmzlw2DkaRg4H4NJji03gAu5uK3bFT7NFuuuhS/nkMhOT3qQ++4goHJ/Y
	LpelY024QQilculUWkgSEwJdzqwRDY8iIpIPfKv6arSxv+1bNETTz7tzvDKhM/nk/UFVNFCzrCf
	czasykcL57m9A7iWG+fu5t/k8AAvNXjHL/8EymGiZK8/PgQ5/47FaiAOzqIO9yd/qOWIAV7Qs7B
	SHnKGN53Wbv/1sJbBE0zkTPJ8zTg+CohkVva6FN6Lreb6FBHQoMCRiQz50qd9CZo4PfLSA6TLcX
	YIV3oc+/ik0JVfTX0TJuuh3rUpGr74I0g==
X-Google-Smtp-Source: AGHT+IE1Y1ssC3vDPwXKD9Vohv1X1EAngxcUz/MZcTAaLZ2Xt65ito/oPm7FTBXTLQh5v9nY6sOF/g==
X-Received: by 2002:a05:690c:4991:b0:784:8994:298c with SMTP id 00721157ae682-78489942dc2mr350965587b3.28.1761322209785;
        Fri, 24 Oct 2025 09:10:09 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:09 -0700 (PDT)
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
Subject: [PATCH v8 5/8] kho: don't unpreserve memory during abort
Date: Fri, 24 Oct 2025 12:09:59 -0400
Message-ID: <20251024161002.747372-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
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
index 994ee0b70757..6aa25d304bad 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1098,31 +1098,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
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
2.51.1.821.gb6fe4d2222-goog


