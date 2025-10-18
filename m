Return-Path: <linux-kselftest+bounces-43464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB949BEC238
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 02:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A9D6E6CDF
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 00:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B2225413;
	Sat, 18 Oct 2025 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="unQdP2H0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CB21FF5B
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746069; cv=none; b=mS12hpbTKnbPYEMGxjwr7V2jNElgU4LZ5EElbllFc3ROpF3Zi5BCRriWU9Mo8EKU2fCh9FEQk0Na3BRWZe7efzZm9akHSPeWZTyqWldpLHSrgCi7SLqMDc+qe1JRsJXyY/XicpG3Ti7/mKyWGHrZ1Osyml+pciXoigxvRh47/1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746069; c=relaxed/simple;
	bh=MLaNeyY6LKintgVULMgBH+iRQ/MeqKVKP+ROzIUgMg0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNXTmbNPOMGodk9sHNDEqL7j5IvRIE7XEG9JvyqhXwxOpe8zKjtw26gplFthilGkpzac3qLv828JyDFt89Elwscvc+R2EhgLXT2gHUjmQetRjKE92PCoJU0jCbmhdeN04kZG+qkYqoSc+mjbXK2c9WEn4Ytrbew4egPbEvGIKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=unQdP2H0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33428befc08so5267307a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Oct 2025 17:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746066; x=1761350866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h58y0LF9F4O7H0FAiRUz8ZqJ6jT9O63uu0+3MjjbyTk=;
        b=unQdP2H0pbmZMm7YAowZVqfrE6Wv87+7CAw/5Eu+skmj/IV97GCqzyF0V0l1my7KUr
         vohx3U5P7hQHnCsarv8YpAcABmgotcGlEKRIwQLhn0E3sa6Q7eDGgVgLSh4GNq/Lqzdh
         9fPUfA8OMd2WR4ik7vJWWW3Exx19mSGn4LDAbMaba4mrfd7ZqsCkd9DY7OmCSUasQ5Ov
         q4uIke6rNIxBOpcnejH3KzX3HHH/Ybg0aPX7A+9o7RlBsqwqS6eSXz+a9VJ0ou7zKUZU
         hIlPSjDS0D51i+Ab953yQnwp6oHN12hRLWNEofptrqp4sV2/OvP1ChcqfbbHmbPPuZGK
         tGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746066; x=1761350866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h58y0LF9F4O7H0FAiRUz8ZqJ6jT9O63uu0+3MjjbyTk=;
        b=Y6NL/Z8r28dYyTV2PyzVDMXm3H40I22fRWvq9gxna5HCDXz6kxjS7HF0U+oojgrQ0F
         TaTfy1MdMa8FeYqA3oL/xXgYD1JszEY32FyeoWt2cXl1oNEyeuqU3LO9BEn7aJruz6HF
         8XRANDPJr1/Xh+mwmQON0Ub7DdeJJKfemzR2ZpgkFcoA5sXQiHKYV+FREPf/j1nCwwX+
         w2wR9s+YkJT3BvTkTllRRiRMP0drzjwwfXI+ubx2bz/FiMiLnkZD4LFqggQjwgN48Q/a
         k6ubiZnswWqUoM0aB81+nXjRzUfAlCny0qICpQv89qN3pLDWjTYNCn91TO/p23b1cqL4
         LfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWomWS/iZytF93DhDVQz3zHCPKG2a3WA0Gh0NN9QqXU/Hh3rTJmIOstw++DMgSojOMz3IzXZNsoQCeOMRlGhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mBhbgQSiZblfbG50fi61AQrpR65ZJThcxTnDyMwk16/4Jlg3
	cPRU2+VFjhMuxsUAMlwJ6eBU9fpn3v10r1IqywdBki/P1e4vphR0lS92rHfazI0K905nBWrJfuq
	ZLRd16+g4cg==
X-Google-Smtp-Source: AGHT+IHXxYwtGcIKbQ0OizZ3waxlwzCfsSoob6MqMnOla+ZwoMWcozqueK+AEj/juH0UNpmrqm1CfPxSTVkf
X-Received: from pjbrv22.prod.google.com ([2002:a17:90b:2c16:b0:329:6ac4:ea2e])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c88:b0:338:3d07:5174
 with SMTP id 98e67ed59e1d1-33bcf85d01dmr6153736a91.5.1760746065605; Fri, 17
 Oct 2025 17:07:45 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:05 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-14-vipinsh@google.com>
Subject: [RFC PATCH 13/21] vfio/pci: Preserve VFIO PCI config space through
 live update
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

Save and restore vconfig, pci_config_map, and rbar members of the struct
vfio_pci_core_device{} during live update. Use the max size of PCI
config space i.e. 4096 bytes for storing vconfig and pci_config_map
irrespective of the exact size. Store the current config size which is
present in the struct pci_dev{} also, to know how much actual data is
present in the vconfig and the pci_config_map.

vconfig represents virtual PCI config used by VFIO to virtualize certain
bits of the config space in the PCI device. This should be preserved as
those virtualized bits cannot be retrieved from reading hardware.

pci_config_map is used to identify starting point of a capability. This
is not strictly needed to be preserved and can be recreated after kexec
but saving it in kHO reduces the code change.  Currently, pci_config_map
is populated in the same code where vconfig gets initialized. If
pci_config_map is not saved then a separate flow need to be added for
just populating pci_config_map.

rbar is used to restore BARs after a reset. This value needs to be
preserved as reset will lose this information.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_config.c     | 17 ++++++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 38 ++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h       |  5 ++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 8f02f236b5b4..36a71fc3d526 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1756,6 +1756,23 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
 	vdev->pci_config_map = map;
 	vdev->vconfig = vconfig;
 
+	if (vdev->liveupdate_restore) {
+		ret = vfio_pci_liveupdate_restore_config(vdev);
+		if (ret)
+			goto out;
+		/*
+		 * Liveupdate might have started after userspace writes to BARs
+		 * but before VFIO sanitizes them which happens when BARs are
+		 * read next time.
+		 *
+		 * Assume BARs are dirty so that VFIO will sanitize them
+		 * unconditionally next time and avoid giving userspace wrong
+		 * value.
+		 */
+		vdev->bardirty = true;
+		return 0;
+	}
+
 	memset(map, PCI_CAP_ID_BASIC, PCI_STD_HEADER_SIZEOF);
 	memset(map + PCI_STD_HEADER_SIZEOF, PCI_CAP_ID_INVALID,
 	       pdev->cfg_size - PCI_STD_HEADER_SIZEOF);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 6cc94d9a0386..824dba2750fe 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -18,12 +18,43 @@
 
 struct vfio_pci_core_device_ser {
 	u16 bdf;
+	u32 cfg_size;
+	u8 pci_config_map[PCI_CFG_SPACE_EXP_SIZE];
+	u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
+	u32 rbar[7];
 } __packed;
 
+static int vfio_pci_liveupdate_deserialize_config(struct vfio_pci_core_device *vdev,
+						  struct vfio_pci_core_device_ser *ser)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	if (WARN_ON_ONCE(pdev->cfg_size != ser->cfg_size)) {
+		dev_err(&pdev->dev, "Config size in serialized (%d) not matching the one pci_dev (%d)",
+			ser->cfg_size, pdev->cfg_size);
+		return -EINVAL;
+	}
+
+	memcpy(vdev->pci_config_map, ser->pci_config_map, ser->cfg_size);
+	memcpy(vdev->vconfig, ser->vconfig, ser->cfg_size);
+	memcpy(vdev->rbar, ser->rbar, sizeof(vdev->rbar));
+	return 0;
+}
+
+static void vfio_pci_liveupdate_serialize_config(struct vfio_pci_core_device *vdev,
+						 struct vfio_pci_core_device_ser *ser)
+{
+	ser->cfg_size = vdev->pdev->cfg_size;
+	memcpy(ser->pci_config_map, vdev->pci_config_map, ser->cfg_size);
+	memcpy(ser->vconfig, vdev->vconfig, ser->cfg_size);
+	memcpy(ser->rbar, vdev->rbar, sizeof(vdev->rbar));
+}
+
 static int vfio_pci_lu_serialize(struct vfio_pci_core_device *vdev,
 				 struct vfio_pci_core_device_ser *ser)
 {
 	ser->bdf = pci_dev_id(vdev->pdev);
+	vfio_pci_liveupdate_serialize_config(vdev, ser);
 	return 0;
 }
 
@@ -221,3 +252,10 @@ void __init vfio_pci_liveupdate_init(void)
 	if (err)
 		pr_err("VFIO PCI liveupdate file handler register failed, error %d.\n", err);
 }
+
+int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_core_device_ser *ser = vdev->liveupdate_restore;
+
+	return vfio_pci_liveupdate_deserialize_config(vdev, ser);
+}
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 7779fd744ff5..0d5aca6c2471 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -109,8 +109,13 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
 
 #ifdef CONFIG_LIVEUPDATE
 void vfio_pci_liveupdate_init(void);
+int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev);
 #else
 static inline void vfio_pci_liveupdate_init(void) { }
+int vfio_pci_liveupdate_restore_config(struct vfio_pci_core_device *vdev)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_LIVEUPDATE */
 
 #endif
-- 
2.51.0.858.gf9c4a03a3a-goog


