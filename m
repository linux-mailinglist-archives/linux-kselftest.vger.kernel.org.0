Return-Path: <linux-kselftest+bounces-43495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C245CBED4A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 19:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F109A4EDD9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45425CC79;
	Sat, 18 Oct 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cIuEA7cj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676F25B1DA
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807887; cv=none; b=ZmPx6AmJcyF3dwjQRGu2hdP9xMos7uhrG9W2Bysm9HC90DIBf5dsOubdS+XJPcGO040IpX0aUU6//Y8qWsN21OwFFSoHoFFIY5Wc43CECWdmNKtwQtaqlQkQ9N0mnxBli0H7OOoJU5adl+eaJq/yuWvlGdCnC7bcSWZltk1MYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807887; c=relaxed/simple;
	bh=C9Ra1j+hNcxx2B5cYdmhSumT/vB9fFQNVijx1jxEqF0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnBrGLtXvfDH4VVro6/q0Q8bR15yCrNQRIMNYqjwDDLV0DK8S0bWqQy5cNrB0h5Px3B+/QxOXnMPhJvSWFeHcWhnugswIIU48Csta8ccChSx0ytqXh/Ye7Np11b72ikR2GgplhlKaLO2oUVd3czboeqZWOYGYPbVxcZD6e1vdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=cIuEA7cj; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-87d8fa51993so13140696d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807885; x=1761412685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeSkThIp0BgOUgzAnruASuFbTYnRMFC8HwaL1xWtkt0=;
        b=cIuEA7cjKePY6w50215cBWsvRroZwjvzGJUyQIcJIDLMfSIUZhCCCCoatlfjEr9keA
         nVfhfbBxkx2EgIarigcZsPY2ZEROyiu+1zBwHCZ8LkCo3QGCT3sizv1Nz6HezPjFMexX
         upjeCg9/skrvGzMla+RfW6q1u3EsVmaqpZeLU9lt8jJzmVsQOdmtV5H1uUHCcaqj1HGs
         IBFLnKtSZN7HI9LDWzaFjzRfM70n4AlzurCNEJYeWqH27mScG6h6FKXiOIiTBCMluGE+
         BR9zq5lAOrOyuFuaQFR3UV2EtEKwTZpDq8fQ1mcYEHJ0b3Zt6yQHQ2EyvT6AeJ7s6bja
         MV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807885; x=1761412685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeSkThIp0BgOUgzAnruASuFbTYnRMFC8HwaL1xWtkt0=;
        b=JAzUE8sru+F0yJXfX92BF+o/oI3j1NCEsFgO0CXRMMDNC9oJffZVDUQCkB0l236LVT
         cRAPYbg5EzgZHT7qLzJwg7dTsGokkp6h0qmmCJBXqe6b3zwOxq3pcXAED3WcMrBgtiGQ
         kH531VW9MREaS6GQB9+JbvpnUDBJ8MNqLRUQ2G0p66BrkmvhCLSzbjIwn/vjg/fD9mvm
         JcKVMND7ChbBLJ37+HiDGUOkZiA6WG31RmzhQeS9EdYP0ZhHRMdt+QTHgnkRLObeCsL4
         j1G5sMmnjn7+bN/SCEraBkWs9he9LkAlhS+rA1UMQyDp/1J/njJ3UPEQMnqUmxYXTO2m
         //tw==
X-Forwarded-Encrypted: i=1; AJvYcCX1WuIMY+S7ClpZFx8ZTErLkEwJBPJ3tW2D6DYR+Wa7PBNf8/O1Z9EVGb9uOFUArgRSAB2+749Ic+7zGdL1YN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPP2NVY9O3GeC10CpDxe0o85iZd1NU6zaY9ow7d+Ju1UXHW1kI
	H1vqU6VaYXvxBN8rd2ykFveKnwuLWfSzn9H4Zs9lcAR853BdBV0NG0lGc9o0E61bABs=
X-Gm-Gg: ASbGnctISry9EP5jMTF3ZT3xQ+f2VEwF35p6fVq9cjPIduuFCoEGLQWAQmZP6bb0/Fw
	DRIuvfsgRgVrxPjkNziAnfM12aaCYR9BeoY1AgtObZCrIvO1r3CjQKLNIchOVkISlU5Cdfa0Upt
	A1KgndVmdygKToHWIjCArCGXinS+EjTBKTMmLizEJ3mFgQYvOuwMXoT6YKaBxcIkY2GkS+v9AyZ
	xFLM+g/AnitA+30NTto0k3tSaV+O/R7122aA5iODfrjw6AR5vFrWLZh+TItrys527w2jG5t9RCt
	YWOg0fuMeFQX/vcMCZB8//37ec1GzAaAxOo7aEGsbztYlTNs0BYgRPJRuMjJegfwOPie/dc2V6j
	vU1KOaSXpuVl3A25b7ektpxwncqOkrM6+hUNe+IWYkBKDEJuXgUCYyfjcGiMWXAzTUCg/R4qmiP
	/x7DhMwQiU28kykOg4pnbz1rn6wFI/lc9tNpCsnHcFseXjn98XWxmLx96hosaxW4rfZB5iTrmzr
	XczuyU9oOWiiZYuP9kMcw==
X-Google-Smtp-Source: AGHT+IFdBNVKA7wbdhBQt+CIgKi8/22s9Ed+9OmPWE+pFu/N1e12A5/0MkyaV4HSpQyJ88+n0QIffQ==
X-Received: by 2002:a05:6214:319a:b0:87c:20b5:6685 with SMTP id 6a1803df08f44-87c20b56795mr116436546d6.55.1760807884708;
        Sat, 18 Oct 2025 10:18:04 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:04 -0700 (PDT)
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
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v6 05/10] kho: don't unpreserve memory during abort
Date: Sat, 18 Oct 2025 13:17:51 -0400
Message-ID: <20251018171756.1724191-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
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
index 78acaa218c12..89a8f839346b 100644
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
2.51.0.915.g61a8936c21-goog


