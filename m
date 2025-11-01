Return-Path: <linux-kselftest+bounces-44572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD8FC280DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 15:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4111A2118E
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0952FB99C;
	Sat,  1 Nov 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bFlitAdO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF88214A9B
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Nov 2025 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007026; cv=none; b=sNyXFUlAb0eAvMwWKSgKGHBpWPAUtablrNbSSdcv7ut7360kwsLNVRGmtPpRwaUD2JGpWluv/T6KrYhxknLZgfOVC3FDuo+yGPY0wc0xHRg+7oMoJ29+e05eK8f4bJfNmpGP7i705mtJTqpjSJLv0ZJ+VQBMQvM2y5DiFQi68nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007026; c=relaxed/simple;
	bh=+LuQqkGCe84RIp2fAEq/d3OCjgqkDPmWEUoXD9tp6JQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmvtAMD365Be7dsvClOlurcXZYAV5xgwdbai2K9C46DdhWIOolbcmMVTlu2I/ZANusnhA5A7rrDM8cfjfcxo5e3Sp5742CFb+maY7blb6+ZxzvEEpG21rB1/6/Poy3nJpMNDqxGhnN/hTb3hLo7eg0S/T+dJxo9PohztmLSsBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=bFlitAdO; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5db52533e5eso2909987137.1
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Nov 2025 07:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007023; x=1762611823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3sZsODYdE+lXQW6sSfXvI4QX3oinLZLnJVK+OowB7E=;
        b=bFlitAdOMFOlBGqOhB/WtEoPPxWEoQnpku9XX5BdVj4stcmqVMraZiyeck1o8S6Hmc
         ihe9wpxvUT/YnAwr1SUOMoWbe45W5NBVIgepJ9YLjhrFHogtoJIPnm31qlnwf5e1jzzU
         /3/EH3VOnaoWdhkvNoMTGzlF5OdmWFhlEIsJkeItHKWL/W8KTqmyRjGbtzAPZnGzEARg
         s/1x0SRDsyR/VjRHVvopZpXoTUTBhDp9kmYGm446N1CqUm+JjpyU5VRkxbtxLa7n5dyv
         77Sz9h91Ca0i2Xx5wkoUP0Ib3YNaSP6KEMQ8P8tm8yybQ8moKDHUfM0gpTlykavElUOi
         KFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007023; x=1762611823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3sZsODYdE+lXQW6sSfXvI4QX3oinLZLnJVK+OowB7E=;
        b=vjt34Vrkz3AYV6jdgNwJ8uoTgkXz/v2snQQOsXgIURi2knFDHdlV0nM979f3TC0S0h
         dcybhi/2n8lgaOmtWF3jUu3Tt/HXxgZsM2IaPZpvuRCkJM5BBcvRgjNP1+m6ZHgagKWh
         6CbKjEfarD9kWl4rg6kUHhkPJEn2C50yxRarz8w72tKtawq5TzydIBq90lb5kgnLAs+n
         bBA2EkmkUj2QFHV8+pbsJoGJLzXaWygicYvcUqAEdQsiwwhhCpnDpZpTf9P3ppGy5O50
         fgQ9sc8UdGdHkQm1vTs8s/dqR38rk43yC5phadzOqHP2djezopPuZKGkYpeCzBQBpJVe
         1ZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9UH1J3t8tFXBLC4mNQMHpEzUOysGQn9j1Hd54Q3iB8K7iVpPtrLQCEVpvxL5urKpLsv5mxw9xA5PlHhmAX+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2RnjANPbFQ5sQ2vZiqBSQiC0KtmYrzNyD9blQjaF04YxYgt+
	OY2MIlmTwE1EYRXBG6XwSAmd/Gbxf8iIERw7m7OhQWQKjq0WF4k9ng4cqzyPFpw6qC8=
X-Gm-Gg: ASbGnctdZxe1rsC92Dq/xwqjbaQieUWI5skUVfZa+1vJ6wxXseF6dOdiY/me+MvhKVQ
	Glx7dNwbUIbhpGPl6JqDzgBlaqia8LblLmJZXADgInjdvYRUfcfVSG+RSBd3xDb94S1F1ViGwLJ
	9Y5RVpHs1mIHx4nyXT+4tnWKnESDHiY+7tw3GnKPdCtAP6DSicTXzZxglW8L5iTO+aklKNXHk8z
	CWjwSMfVUXs5/6022b0ANqhPohfznw4XtOpJkALm80mynqc17SiiUJDguyMQAN6epElM7kjIXWV
	pokQxMaxyd8V+XBHuMvPqmzXH2nuOiWBXy2ZkjJ0rt8ZBPSVif/C76hiJ3kzXuYxOzHjCJz0ATp
	NSPzDkkDAXV1on8QzQx19ePwwbLGNZmt4H2Fbv4M2Iw+GF/4E2JaYhGvDVSEwAZ7jbDxyWPzHIW
	N1nbUsOKX45ggovwsMmiZqgS1LWiXKgMWkmGPC6SHFQjGDm20z+YFqrU5oIQ5gBNJouaqaEbg=
X-Google-Smtp-Source: AGHT+IEW1fTK12XGUTtqXJsef8/76poVKTgBxu4YxD9HHtSEN7ne/NH+yy5cGEPUcuJdr6fOnT+fYw==
X-Received: by 2002:a05:6102:8349:20b0:59f:4f48:4e31 with SMTP id ada2fe7eead31-5dbb11f91c3mr1950860137.1.1762007023601;
        Sat, 01 Nov 2025 07:23:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:42 -0700 (PDT)
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
Subject: [PATCH v9 6/9] kho: don't unpreserve memory during abort
Date: Sat,  1 Nov 2025 10:23:22 -0400
Message-ID: <20251101142325.1326536-7-pasha.tatashin@soleen.com>
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
index c514b300ebe6..3adf86c7c2db 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1118,31 +1118,12 @@ EXPORT_SYMBOL_GPL(kho_restore_vmalloc);
 
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
2.51.1.930.gacf6e81ea2-goog


