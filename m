Return-Path: <linux-kselftest+bounces-43466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1858BEC1F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E481355F5D
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB70C2264AD;
	Sat, 18 Oct 2025 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1yIOzaAu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2914226CF7
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746071; cv=none; b=kTTz4Obob5uKPrnZ350J8eZrQ4P6sYl2zNAYkJxXUFyzFp1juW2xLfwvKVP4zwqYio2Q9iHeygI2O1qEDB4lyK+RJm8JoD9+31X6AkIzoVrIWCrR6kqBjuqaHPGKg2mrllNYe5RkEj43wsmA2pjWiwuFsG52qAc/usfd0scavgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746071; c=relaxed/simple;
	bh=4zEfGNBAvfxNMJ6CtPOIgpCPNW5I0Ho4sTGFaBRv8jA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VFxvW6V23ajyCx3+lkjLjtG1zsFuRwmrOOfWSRSu1ODAqF452jHW9LpUmA+Mf7nPcDA6bgLr5r8fKLwDmB6wRgtS0fRnoiljNsSNaxzVBNANS2MLE7HfgcVXJTsYhKKoApnxi5geyvmaOMoyrRzhCBYLZz9m6FDfOwfbfyjb+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1yIOzaAu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33be4db19cfso2402370a91.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746069; x=1761350869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IKQ2m/8YVTtgALfOzv64urRQ/jq+jvTeg0iyjCDHzo=;
        b=1yIOzaAuyxpGWSVzU6J1NpSNaEYauiz4b8LeCEiSOWVaJZGscMulWouBJJs/9Rfppy
         bnetejwjUoen5Z10REavbbNc1UFLi8bJBGy2kxFzg32HWt0ipE9S/Vt4Ibf6Fn00nFFM
         1C4CzqrVqznV7dWT5LdcKZ6t/1/qw0pzaIslbNm+Gf19zmuqeOmI9hfIuFL0g43yEn1R
         kCs/oehZaQ/nw/F4qu00AQjsxdXOpuB+b491GwyjCrD7kXIG3VWvULs2xioj9f1eu4Qv
         qjKZzCnOv4vSz7mDmG76caWRAZnGnTZ7hVWTTausO7yxVWEelTStXCUdxBizlcwuFXoU
         Zj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746069; x=1761350869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IKQ2m/8YVTtgALfOzv64urRQ/jq+jvTeg0iyjCDHzo=;
        b=sL+IW0r50sMbNPWNVs6itb7Yyo2rsPlYCVfXS5JVTi6cbTP8voOt+NA4KwS9b5bkhQ
         +KBtsO/GArx5i3vQjPE00xzFMkC9Qx+kjqZ5X3Iu2K5Vm+TZeM4TK3sNuJHJbcZvHFvB
         4OmrRbC8OExokfsmueoSkyobGDphe1YEM8D3XACBgZguau3AaD824WSx3BuptKeolFy/
         0/mxHhpp3+bQvRv3Ej4E8YJ1+bp1pZDgz06lWuE5G4w8QC3QCNerRYVCZqI8qpEP0bGH
         MwAeUpAnNtpYpPPEUCP1r3QifXBdtFD+f/62fGbni8Viu1pxuPu62fBYM2OsH4vx8PY5
         Dr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyIt7EjrdnkSNILxb7i8T9BIS5HoAEAeUDQQSS8KEMkX/6wWHFIfs8m11aTxd4aOTaNlYxXC0dRQW4D38RVOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+iLT2QYnYVf3yAyYUGI9YRYAdvS9DcNrRecOYhF2z2PNwHTVL
	P5qQx5M08KTMS56m4m98UzUpp+9aZuwAcVH3ZEPgYGWkRBT0BH+ltMmS5FSizTi04ZIf4OUhzV9
	BOUGwNYy++A==
X-Google-Smtp-Source: AGHT+IGi63368+j4schUOx0wr2SHTaDZh32wZixnKr/b5gJJ0dBIteyX+gJFYt89f2kz+wLVliJYYTwPu7xP
X-Received: from pjbnu5.prod.google.com ([2002:a17:90b:1b05:b0:33b:c59f:b015])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:240a:b0:33b:d373:c899
 with SMTP id 98e67ed59e1d1-33bd373c8ddmr4671671a91.22.1760746069495; Fri, 17
 Oct 2025 17:07:49 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:07 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-16-vipinsh@google.com>
Subject: [RFC PATCH 15/21] PCI: Make PCI saved state and capability structs public
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
linux/pci.h so that they are available to code outside of the PCI core.

These structs will be used in subsequent commits to serialize and
deserialize PCI state across Live Update.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/pci/pci.c   |  5 -----
 drivers/pci/pci.h   |  7 -------
 include/linux/pci.h | 13 +++++++++++++
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd064006c..b68bf3e820ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1884,11 +1884,6 @@ void pci_restore_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_restore_state);
 
-struct pci_saved_state {
-	u32 config_space[16];
-	struct pci_cap_saved_data cap[];
-};
-
 /**
  * pci_store_saved_state - Allocate and return an opaque struct containing
  *			   the device saved state.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 09476a467cc0..973fcdf7898d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -197,13 +197,6 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 int __pci_reset_bus(struct pci_bus *bus);
 
-struct pci_cap_saved_data {
-	u16		cap_nr;
-	bool		cap_extended;
-	unsigned int	size;
-	u32		data[];
-};
-
 struct pci_cap_saved_state {
 	struct hlist_node		next;
 	struct pci_cap_saved_data	cap;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8ce2d4528193..70c9b12c8c02 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1448,6 +1448,19 @@ void pci_disable_rom(struct pci_dev *pdev);
 void __iomem __must_check *pci_map_rom(struct pci_dev *pdev, size_t *size);
 void pci_unmap_rom(struct pci_dev *pdev, void __iomem *rom);
 
+
+struct pci_cap_saved_data {
+	u16		cap_nr;
+	bool		cap_extended;
+	unsigned int	size;
+	u32		data[];
+};
+
+struct pci_saved_state {
+	u32 config_space[16];
+	struct pci_cap_saved_data cap[];
+};
+
 /* Power management related routines */
 int pci_save_state(struct pci_dev *dev);
 void pci_restore_state(struct pci_dev *dev);
-- 
2.51.0.858.gf9c4a03a3a-goog


