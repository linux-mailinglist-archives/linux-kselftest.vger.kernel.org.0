Return-Path: <linux-kselftest+bounces-46545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B3FC8B9B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDEB3B5F9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984AE33F8D8;
	Wed, 26 Nov 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbU6Adrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A54934104F
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185778; cv=none; b=mNGYBJKAE1Uj+PtRTLz+YVnYd5/IJ2UEO1i65VyMmR51Crxf8cywoaq0s/HbmaBPvCOAK/u4/vT6pHY9gE8rF5sRdyLpXttVfGlv/sdsZ4Ks1aiahOjQwyHQINOfpBT3EyCBHJBC/LU0FmLkU1gSsAGSFJ0Volvw0Ydfsd/VAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185778; c=relaxed/simple;
	bh=DgrTkiwsj7G+kzAv5Mmspt4Q8NbY6RXRBJtrpMsEy5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tw52kdUniYNj0BX/FcFVo0BOIcjl9FVnekxUmTEdXPxPBkZdJKWeiVBKz9lXyKDywbaq2OkI9PlNkFm7uYJy+Kbj8v/OboqU9O58hbQtQeBsrdiCWHt9WQPzzuKrNavOVC0GjqCRT/SDUAH0tEnWm9CG2gDP+7gphEmHsqSwTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbU6Adrw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e1cf9aedso1648065ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764185776; x=1764790576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4W8jO8YwRXmYQwem/Oi26baRXbR//DiNTTxQHZyVKU=;
        b=dbU6Adrw/r4HbB2gp1axytAQ3o43CYiIxktTc1NaQUbbgieIqOqSyN5L8pEVth1EjJ
         F3b4+FXxQRnSrd1XwMjcNsmTfIsWkJgUX9+1PJ92FFNhD4SJ3SbeYKpNZXA++d90+Qn8
         pPWLuJE005M8Mcnq/5AJppqd2ZQ8ix0Gj055ltkMvlss3XK+QHflkdaxzbiX1GRJkcBN
         43HUbvtflmJJGE8XyGlFlpcLebVvL1NIhknhVDX0RaSiDIGy1BAeDGNVYh5DuQ9I8S3o
         Y+hYJ7aFFs7hR941kGZxxfOFA4W32vUZtMCkAHOjkAlfO8s+2qTXCQRpmBGjHL5S/06O
         WIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764185776; x=1764790576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4W8jO8YwRXmYQwem/Oi26baRXbR//DiNTTxQHZyVKU=;
        b=h+1DDXotH77IadaFaHdHK7/ptZTsEsZ4HtVoMfXuSTTELjZcK2oZtLHuM8suoHmHlM
         g8DIKEuwUXGbD0f2rxCt1qcapo7PWVcvnwWGMq6J8jum7HVdOU5x4Ab7JnCYr/HDsIls
         mfs3sYUtAmZrOsFFPyBM7q+l6+khkd1GaqFwtX/Pii+fh0f8P7Mi1qa+7ns2qYwsWVrp
         zKa8j1/iVFMsXSF9uPkeBBoRlkXxknfetIBEgCN+qDJAX9n8n3/dUD7XBx9Blh0Q5G7k
         hNrOttBWdAfVX3opz0YaxXdRleGXQuAIaYXufVxLvSqgllhBKhtB00k8a7NrsRwNh4B8
         pfiw==
X-Forwarded-Encrypted: i=1; AJvYcCW3wUJEKjJ0CiRG6gjk1AADvVWM5HQxlXWxjqOWO5aniULKS6UBkbYphW3Scgv4JmE9Bviw9qQZE1mzrab8v4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GL5L/VNGWTziRaXQGBJF2DHH9xoixeEi7h62k1SzVdsTb9/e
	uLuk5vmreNZYHvLOOpY93wW9R1waaNhjW8g7FGCWMmhv6fFAmmtxdAvmrGx88R+FN5O3ubb7Sg5
	oJoe1yqGCycYdiA==
X-Google-Smtp-Source: AGHT+IH14W8+tVRPyICSHFhnhdie4VNOZ11aj2/eJVs/11OeDSQhWpHoOWodZE+UlFUV7qImHq1Artm+rlwecg==
X-Received: from plbjn3.prod.google.com ([2002:a17:903:503:b0:293:e00:bb82])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce89:b0:298:485d:556b with SMTP id d9443c01a7336-29b6be8c617mr237546495ad.5.1764185775828;
 Wed, 26 Nov 2025 11:36:15 -0800 (PST)
Date: Wed, 26 Nov 2025 19:35:50 +0000
In-Reply-To: <20251126193608.2678510-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com>
X-Mailer: git-send-email 2.52.0.487.g5c8c507ade-goog
Message-ID: <20251126193608.2678510-4-dmatlack@google.com>
Subject: [PATCH 03/21] PCI: Require driver_override for incoming Live Update
 preserved devices
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Require driver_override to be set to bind an incoming Live Update
preserved device to a driver. Auto-probing could lead to the device
being bound to a different driver than what was bound to the device
prior to Live Update.

Delegate binding preserved devices to the right driver to userspace by
requiring driver_override to be set on the device.

This restriction is relaxed once a driver calls
pci_liveupdate_incoming_finish().

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci-driver.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..294ce92331a8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -420,18 +420,26 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 }
 
 #ifdef CONFIG_PCI_IOV
-static inline bool pci_device_can_probe(struct pci_dev *pdev)
+static inline bool pci_iov_device_can_probe(struct pci_dev *pdev)
 {
 	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe ||
 		pdev->driver_override);
 }
 #else
-static inline bool pci_device_can_probe(struct pci_dev *pdev)
+static inline bool pci_iov_device_can_probe(struct pci_dev *pdev)
 {
 	return true;
 }
 #endif
 
+static inline bool pci_device_can_probe(struct pci_dev *pdev)
+{
+	if (pci_liveupdate_incoming_is_preserved(pdev))
+		return pdev->driver_override;
+
+	return pci_iov_device_can_probe(pdev);
+}
+
 static int pci_device_probe(struct device *dev)
 {
 	int error;
-- 
2.52.0.487.g5c8c507ade-goog


