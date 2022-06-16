Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED854E110
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 14:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiFPMr6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 08:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiFPMr4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 08:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3961114C;
        Thu, 16 Jun 2022 05:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2773161B69;
        Thu, 16 Jun 2022 12:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCB8C341C4;
        Thu, 16 Jun 2022 12:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655383673;
        bh=OZMc2lQCvSS/04yIpnQ3P1d1O/L23pKdNGLiprBk0uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQHVsN5V+YYkpFSH4OtABxKGFWiKRCEodBH9Xd38AhECTMjrJgv6nyKdMLObr4mSi
         rSQi2UKWvxhKKauCwN4jMCjSyu9m/PFWFNi3Br+T8ftNABjLR6f3XFgtqtRrBfrtp0
         uFJAGksyoFbh5hQfVbHRhECxx84aCRVnZuQWuRRmHrtIsPc2eyob7g6ZYa1o2nZjai
         727Sh+L2licGzwG2Ony1CCRR6ca2OkZZxGQI4J/8vYoyqZB9At7ZAE91qMbNUuNJ/a
         qcMTPE48OrVL7ioW3WP9tffMnVYd1+MPHSphWBPx5wDqNFTjoVTULPX+pengHs2Cud
         Myvt5YsAcMslQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/2] efi: remove deprecated 'efivars' sysfs interface
Date:   Thu, 16 Jun 2022 14:47:40 +0200
Message-Id: <20220616124740.580708-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616124740.580708-1-ardb@kernel.org>
References: <20220616124740.580708-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=24475; h=from:subject; bh=OZMc2lQCvSS/04yIpnQ3P1d1O/L23pKdNGLiprBk0uU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiqyZq8B9/0cBQfOc0QanUOqUK5XAZI0YvW8sOrRkF wm9k6EKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqsmagAKCRDDTyI5ktmPJImkC/ 917jXj84DVDGeK3pM+N+o+qAjO5B9oBCdLhnUbOhcPa5o90UXwLwxvR5LeTtv1hVgirHHcOVMugKff g8nQIM+Og4+CCz4/K98J9b2HUzVCNC2my2zNG6hD1TGu1lIreDzHMKuKkmp/CkH10oJHh9zXYW19Fy xm49PFyk93Ov2UuzOiqHS7QuApzEcQF9O1Tslnwwrhw3kiGs81HdgQbdf0r8o1h87TS1UwEbQtNjt6 GPijdt5YfHM81zT1Lv4qkTdMyqrpgi4aT9KXN2LvVfwXYymxRCiuFYcZFyzH4shzbGV0x2hJyFm5zk mb+3b32rJZwWQH+PCZWj5Dq55XGuib1EePGgrIY3Y0JxBW3McvFcqXq0Dq1oxbxNxrHSV1LsyCOI/j zgGzis134D2lFtNLjixjkYPGeP8quGCog9NTkA1+o2Ba6mgwbIQUlhKnBAujC9NN1+SwtCTmIv3kVw +IK8khjrkWHz91Tpef6z81ng12pssZkfyzQ6iR6542wLU=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 5d9db883761a ("efi: Add support for a UEFI variable filesystem")
dated Oct 5, 2012, introduced a new efivarfs pseudo-filesystem to
replace the efivars sysfs interface that was used up to that point to
expose EFI variables to user space.

The main problem with the sysfs interface was that it only supported up
to 1024 bytes of payload per file, whereas the underlying variables
themselves are only bounded by a platform specific per-variable and
global limit that is typically much higher than 1024 bytes.

The deprecated sysfs interface is only enabled on x86 and Itanium, other
EFI enabled architectures only support the efivarfs pseudo-filesystem.

So let's finally rip off the band aid, and drop the old interface
entirely. This will make it easier to refactor and clean up the
underlying infrastructure that is shared between efivars, efivarfs and
efi-pstore, and is long overdue for a makeover.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 Documentation/x86/x86_64/uefi.rst        |   2 +-
 arch/arm/configs/milbeaut_m10v_defconfig |   1 -
 arch/ia64/configs/bigsur_defconfig       |   1 -
 arch/ia64/configs/generic_defconfig      |   1 -
 arch/ia64/configs/gensparse_defconfig    |   1 -
 arch/ia64/configs/tiger_defconfig        |   1 -
 arch/ia64/configs/zx1_defconfig          |   1 -
 arch/x86/configs/i386_defconfig          |   1 -
 arch/x86/configs/x86_64_defconfig        |   1 -
 drivers/firmware/efi/Kconfig             |  12 -
 drivers/firmware/efi/Makefile            |   1 -
 drivers/firmware/efi/efivars.c           | 671 --------------------
 12 files changed, 1 insertion(+), 693 deletions(-)

diff --git a/Documentation/x86/x86_64/uefi.rst b/Documentation/x86/x86_64/uefi.rst
index 3b894103a734..fbc30c9a071d 100644
--- a/Documentation/x86/x86_64/uefi.rst
+++ b/Documentation/x86/x86_64/uefi.rst
@@ -29,7 +29,7 @@ Mechanics
   be selected::
 
 	CONFIG_EFI=y
-	CONFIG_EFI_VARS=y or m		# optional
+	CONFIG_EFIVAR_FS=y or m		# optional
 
 - Create a VFAT partition on the disk
 - Copy the following to the VFAT partition:
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index 7c07f9893a0f..9b4789af0201 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -44,7 +44,6 @@ CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_EFI_VARS=m
 CONFIG_EFI_CAPSULE_LOADER=m
 CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
diff --git a/arch/ia64/configs/bigsur_defconfig b/arch/ia64/configs/bigsur_defconfig
index 0341a67cc1bf..a3724882295c 100644
--- a/arch/ia64/configs/bigsur_defconfig
+++ b/arch/ia64/configs/bigsur_defconfig
@@ -10,7 +10,6 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_PREEMPT=y
 CONFIG_IA64_PALINFO=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/generic_defconfig b/arch/ia64/configs/generic_defconfig
index 8916a2850c48..a3dff482a3d7 100644
--- a/arch/ia64/configs/generic_defconfig
+++ b/arch/ia64/configs/generic_defconfig
@@ -21,7 +21,6 @@ CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/gensparse_defconfig b/arch/ia64/configs/gensparse_defconfig
index 281eb9c544f9..4cd46105b020 100644
--- a/arch/ia64/configs/gensparse_defconfig
+++ b/arch/ia64/configs/gensparse_defconfig
@@ -18,7 +18,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/tiger_defconfig b/arch/ia64/configs/tiger_defconfig
index b4f9819a1a45..a2045d73adfa 100644
--- a/arch/ia64/configs/tiger_defconfig
+++ b/arch/ia64/configs/tiger_defconfig
@@ -23,7 +23,6 @@ CONFIG_FORCE_CPEI_RETARGET=y
 CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
 CONFIG_KEXEC=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=m
 CONFIG_ACPI_BUTTON=m
 CONFIG_ACPI_FAN=m
diff --git a/arch/ia64/configs/zx1_defconfig b/arch/ia64/configs/zx1_defconfig
index 851d8594cdb8..99f8b2a0332b 100644
--- a/arch/ia64/configs/zx1_defconfig
+++ b/arch/ia64/configs/zx1_defconfig
@@ -12,7 +12,6 @@ CONFIG_FLATMEM_MANUAL=y
 CONFIG_IA64_MCA_RECOVERY=y
 CONFIG_IA64_PALINFO=y
 CONFIG_CRASH_DUMP=y
-CONFIG_EFI_VARS=y
 CONFIG_BINFMT_MISC=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_ACPI=y
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 98a4852ed6a0..7207219509f6 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -135,7 +135,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
-CONFIG_EFI_VARS=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 69784505a7a8..5ce67b73e218 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -134,7 +134,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
-CONFIG_EFI_VARS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 7aa4717cdcac..2e6032e26846 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -2,18 +2,6 @@
 menu "EFI (Extensible Firmware Interface) Support"
 	depends on EFI
 
-config EFI_VARS
-	tristate "EFI Variable Support via sysfs"
-	depends on EFI && (X86 || IA64)
-	default n
-	help
-	  If you say Y here, you are able to get EFI (Extensible Firmware
-	  Interface) variable information via sysfs.  You may read,
-	  write, create, and destroy EFI variables through this interface.
-	  Note that this driver is only retained for compatibility with
-	  legacy users: new users should use the efivarfs filesystem
-	  instead.
-
 config EFI_ESRT
 	bool
 	depends on EFI && !IA64
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index c02ff25dd477..8d151e332584 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -17,7 +17,6 @@ ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
 obj-$(CONFIG_EFI)			+= capsule.o
 endif
 obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
-obj-$(CONFIG_EFI_VARS)			+= efivars.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
 obj-$(CONFIG_EFI_VARS_PSTORE)		+= efi-pstore.o
 obj-$(CONFIG_UEFI_CPER)			+= cper.o
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
deleted file mode 100644
index ea0bc39dc965..000000000000
--- a/drivers/firmware/efi/efivars.c
+++ /dev/null
@@ -1,671 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Originally from efivars.c,
- *
- * Copyright (C) 2001,2003,2004 Dell <Matt_Domsch@dell.com>
- * Copyright (C) 2004 Intel Corporation <matthew.e.tolentino@intel.com>
- *
- * This code takes all variables accessible from EFI runtime and
- *  exports them via sysfs
- */
-
-#include <linux/efi.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/ucs2_string.h>
-#include <linux/compat.h>
-
-#define EFIVARS_VERSION "0.08"
-#define EFIVARS_DATE "2004-May-17"
-
-MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
-MODULE_DESCRIPTION("sysfs interface to EFI Variables");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(EFIVARS_VERSION);
-
-static LIST_HEAD(efivar_sysfs_list);
-
-static struct kset *efivars_kset;
-
-static struct bin_attribute *efivars_new_var;
-static struct bin_attribute *efivars_del_var;
-
-struct compat_efi_variable {
-	efi_char16_t  VariableName[EFI_VAR_NAME_LEN/sizeof(efi_char16_t)];
-	efi_guid_t    VendorGuid;
-	__u32         DataSize;
-	__u8          Data[1024];
-	__u32         Status;
-	__u32         Attributes;
-} __packed;
-
-struct efivar_attribute {
-	struct attribute attr;
-	ssize_t (*show) (struct efivar_entry *entry, char *buf);
-	ssize_t (*store)(struct efivar_entry *entry, const char *buf, size_t count);
-};
-
-#define EFIVAR_ATTR(_name, _mode, _show, _store) \
-struct efivar_attribute efivar_attr_##_name = { \
-	.attr = {.name = __stringify(_name), .mode = _mode}, \
-	.show = _show, \
-	.store = _store, \
-};
-
-#define to_efivar_attr(_attr) container_of(_attr, struct efivar_attribute, attr)
-#define to_efivar_entry(obj)  container_of(obj, struct efivar_entry, kobj)
-
-/*
- * Prototype for sysfs creation function
- */
-static int
-efivar_create_sysfs_entry(struct efivar_entry *new_var);
-
-static ssize_t
-efivar_guid_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	char *str = buf;
-
-	if (!entry || !buf)
-		return 0;
-
-	efi_guid_to_str(&var->VendorGuid, str);
-	str += strlen(str);
-	str += sprintf(str, "\n");
-
-	return str - buf;
-}
-
-static ssize_t
-efivar_attr_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	unsigned long size = sizeof(var->Data);
-	char *str = buf;
-	int ret;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
-	var->DataSize = size;
-	if (ret)
-		return -EIO;
-
-	if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
-		str += sprintf(str, "EFI_VARIABLE_NON_VOLATILE\n");
-	if (var->Attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)
-		str += sprintf(str, "EFI_VARIABLE_BOOTSERVICE_ACCESS\n");
-	if (var->Attributes & EFI_VARIABLE_RUNTIME_ACCESS)
-		str += sprintf(str, "EFI_VARIABLE_RUNTIME_ACCESS\n");
-	if (var->Attributes & EFI_VARIABLE_HARDWARE_ERROR_RECORD)
-		str += sprintf(str, "EFI_VARIABLE_HARDWARE_ERROR_RECORD\n");
-	if (var->Attributes & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
-		str += sprintf(str,
-			"EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS\n");
-	if (var->Attributes &
-			EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
-		str += sprintf(str,
-			"EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS\n");
-	if (var->Attributes & EFI_VARIABLE_APPEND_WRITE)
-		str += sprintf(str, "EFI_VARIABLE_APPEND_WRITE\n");
-	return str - buf;
-}
-
-static ssize_t
-efivar_size_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	unsigned long size = sizeof(var->Data);
-	char *str = buf;
-	int ret;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
-	var->DataSize = size;
-	if (ret)
-		return -EIO;
-
-	str += sprintf(str, "0x%lx\n", var->DataSize);
-	return str - buf;
-}
-
-static ssize_t
-efivar_data_read(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	unsigned long size = sizeof(var->Data);
-	int ret;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
-	var->DataSize = size;
-	if (ret)
-		return -EIO;
-
-	memcpy(buf, var->Data, var->DataSize);
-	return var->DataSize;
-}
-
-static inline int
-sanity_check(struct efi_variable *var, efi_char16_t *name, efi_guid_t vendor,
-	     unsigned long size, u32 attributes, u8 *data)
-{
-	/*
-	 * If only updating the variable data, then the name
-	 * and guid should remain the same
-	 */
-	if (memcmp(name, var->VariableName, sizeof(var->VariableName)) ||
-		efi_guidcmp(vendor, var->VendorGuid)) {
-		printk(KERN_ERR "efivars: Cannot edit the wrong variable!\n");
-		return -EINVAL;
-	}
-
-	if ((size <= 0) || (attributes == 0)){
-		printk(KERN_ERR "efivars: DataSize & Attributes must be valid!\n");
-		return -EINVAL;
-	}
-
-	if ((attributes & ~EFI_VARIABLE_MASK) != 0 ||
-	    efivar_validate(vendor, name, data, size) == false) {
-		printk(KERN_ERR "efivars: Malformed variable content\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static void
-copy_out_compat(struct efi_variable *dst, struct compat_efi_variable *src)
-{
-	memcpy(dst->VariableName, src->VariableName, EFI_VAR_NAME_LEN);
-	memcpy(dst->Data, src->Data, sizeof(src->Data));
-
-	dst->VendorGuid = src->VendorGuid;
-	dst->DataSize = src->DataSize;
-	dst->Attributes = src->Attributes;
-}
-
-/*
- * We allow each variable to be edited via rewriting the
- * entire efi variable structure.
- */
-static ssize_t
-efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
-{
-	struct efi_variable *new_var, *var = &entry->var;
-	efi_char16_t *name;
-	unsigned long size;
-	efi_guid_t vendor;
-	u32 attributes;
-	u8 *data;
-	int err;
-
-	if (!entry || !buf)
-		return -EINVAL;
-
-	if (in_compat_syscall()) {
-		struct compat_efi_variable *compat;
-
-		if (count != sizeof(*compat))
-			return -EINVAL;
-
-		compat = (struct compat_efi_variable *)buf;
-		attributes = compat->Attributes;
-		vendor = compat->VendorGuid;
-		name = compat->VariableName;
-		size = compat->DataSize;
-		data = compat->Data;
-
-		err = sanity_check(var, name, vendor, size, attributes, data);
-		if (err)
-			return err;
-
-		copy_out_compat(&entry->var, compat);
-	} else {
-		if (count != sizeof(struct efi_variable))
-			return -EINVAL;
-
-		new_var = (struct efi_variable *)buf;
-
-		attributes = new_var->Attributes;
-		vendor = new_var->VendorGuid;
-		name = new_var->VariableName;
-		size = new_var->DataSize;
-		data = new_var->Data;
-
-		err = sanity_check(var, name, vendor, size, attributes, data);
-		if (err)
-			return err;
-
-		memcpy(&entry->var, new_var, count);
-	}
-
-	err = efivar_entry_set(entry, attributes, size, data, NULL);
-	if (err) {
-		printk(KERN_WARNING "efivars: set_variable() failed: status=%d\n", err);
-		return -EIO;
-	}
-
-	return count;
-}
-
-static ssize_t
-efivar_show_raw(struct efivar_entry *entry, char *buf)
-{
-	struct efi_variable *var = &entry->var;
-	struct compat_efi_variable *compat;
-	unsigned long datasize = sizeof(var->Data);
-	size_t size;
-	int ret;
-
-	if (!entry || !buf)
-		return 0;
-
-	ret = efivar_entry_get(entry, &var->Attributes, &datasize, var->Data);
-	var->DataSize = datasize;
-	if (ret)
-		return -EIO;
-
-	if (in_compat_syscall()) {
-		compat = (struct compat_efi_variable *)buf;
-
-		size = sizeof(*compat);
-		memcpy(compat->VariableName, var->VariableName,
-			EFI_VAR_NAME_LEN);
-		memcpy(compat->Data, var->Data, sizeof(compat->Data));
-
-		compat->VendorGuid = var->VendorGuid;
-		compat->DataSize = var->DataSize;
-		compat->Attributes = var->Attributes;
-	} else {
-		size = sizeof(*var);
-		memcpy(buf, var, size);
-	}
-
-	return size;
-}
-
-/*
- * Generic read/write functions that call the specific functions of
- * the attributes...
- */
-static ssize_t efivar_attr_show(struct kobject *kobj, struct attribute *attr,
-				char *buf)
-{
-	struct efivar_entry *var = to_efivar_entry(kobj);
-	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
-	ssize_t ret = -EIO;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (efivar_attr->show) {
-		ret = efivar_attr->show(var, buf);
-	}
-	return ret;
-}
-
-static ssize_t efivar_attr_store(struct kobject *kobj, struct attribute *attr,
-				const char *buf, size_t count)
-{
-	struct efivar_entry *var = to_efivar_entry(kobj);
-	struct efivar_attribute *efivar_attr = to_efivar_attr(attr);
-	ssize_t ret = -EIO;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (efivar_attr->store)
-		ret = efivar_attr->store(var, buf, count);
-
-	return ret;
-}
-
-static const struct sysfs_ops efivar_attr_ops = {
-	.show = efivar_attr_show,
-	.store = efivar_attr_store,
-};
-
-static void efivar_release(struct kobject *kobj)
-{
-	struct efivar_entry *var = to_efivar_entry(kobj);
-	kfree(var);
-}
-
-static EFIVAR_ATTR(guid, 0400, efivar_guid_read, NULL);
-static EFIVAR_ATTR(attributes, 0400, efivar_attr_read, NULL);
-static EFIVAR_ATTR(size, 0400, efivar_size_read, NULL);
-static EFIVAR_ATTR(data, 0400, efivar_data_read, NULL);
-static EFIVAR_ATTR(raw_var, 0600, efivar_show_raw, efivar_store_raw);
-
-static struct attribute *def_attrs[] = {
-	&efivar_attr_guid.attr,
-	&efivar_attr_size.attr,
-	&efivar_attr_attributes.attr,
-	&efivar_attr_data.attr,
-	&efivar_attr_raw_var.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(def);
-
-static struct kobj_type efivar_ktype = {
-	.release = efivar_release,
-	.sysfs_ops = &efivar_attr_ops,
-	.default_groups = def_groups,
-};
-
-static ssize_t efivar_create(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
-			     char *buf, loff_t pos, size_t count)
-{
-	struct compat_efi_variable *compat = (struct compat_efi_variable *)buf;
-	struct efi_variable *new_var = (struct efi_variable *)buf;
-	struct efivar_entry *new_entry;
-	bool need_compat = in_compat_syscall();
-	efi_char16_t *name;
-	unsigned long size;
-	u32 attributes;
-	u8 *data;
-	int err;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (need_compat) {
-		if (count != sizeof(*compat))
-			return -EINVAL;
-
-		attributes = compat->Attributes;
-		name = compat->VariableName;
-		size = compat->DataSize;
-		data = compat->Data;
-	} else {
-		if (count != sizeof(*new_var))
-			return -EINVAL;
-
-		attributes = new_var->Attributes;
-		name = new_var->VariableName;
-		size = new_var->DataSize;
-		data = new_var->Data;
-	}
-
-	if ((attributes & ~EFI_VARIABLE_MASK) != 0 ||
-	    efivar_validate(new_var->VendorGuid, name, data,
-			    size) == false) {
-		printk(KERN_ERR "efivars: Malformed variable content\n");
-		return -EINVAL;
-	}
-
-	new_entry = kzalloc(sizeof(*new_entry), GFP_KERNEL);
-	if (!new_entry)
-		return -ENOMEM;
-
-	if (need_compat)
-		copy_out_compat(&new_entry->var, compat);
-	else
-		memcpy(&new_entry->var, new_var, sizeof(*new_var));
-
-	err = efivar_entry_set(new_entry, attributes, size,
-			       data, &efivar_sysfs_list);
-	if (err) {
-		if (err == -EEXIST)
-			err = -EINVAL;
-		goto out;
-	}
-
-	if (efivar_create_sysfs_entry(new_entry)) {
-		printk(KERN_WARNING "efivars: failed to create sysfs entry.\n");
-		kfree(new_entry);
-	}
-	return count;
-
-out:
-	kfree(new_entry);
-	return err;
-}
-
-static ssize_t efivar_delete(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr,
-			     char *buf, loff_t pos, size_t count)
-{
-	struct efi_variable *del_var = (struct efi_variable *)buf;
-	struct compat_efi_variable *compat;
-	struct efivar_entry *entry;
-	efi_char16_t *name;
-	efi_guid_t vendor;
-	int err = 0;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-
-	if (in_compat_syscall()) {
-		if (count != sizeof(*compat))
-			return -EINVAL;
-
-		compat = (struct compat_efi_variable *)buf;
-		name = compat->VariableName;
-		vendor = compat->VendorGuid;
-	} else {
-		if (count != sizeof(*del_var))
-			return -EINVAL;
-
-		name = del_var->VariableName;
-		vendor = del_var->VendorGuid;
-	}
-
-	if (efivar_entry_iter_begin())
-		return -EINTR;
-	entry = efivar_entry_find(name, vendor, &efivar_sysfs_list, true);
-	if (!entry)
-		err = -EINVAL;
-	else if (__efivar_entry_delete(entry))
-		err = -EIO;
-
-	if (err) {
-		efivar_entry_iter_end();
-		return err;
-	}
-
-	if (!entry->scanning) {
-		efivar_entry_iter_end();
-		efivar_unregister(entry);
-	} else
-		efivar_entry_iter_end();
-
-	/* It's dead Jim.... */
-	return count;
-}
-
-/**
- * efivar_create_sysfs_entry - create a new entry in sysfs
- * @new_var: efivar entry to create
- *
- * Returns 0 on success, negative error code on failure
- */
-static int
-efivar_create_sysfs_entry(struct efivar_entry *new_var)
-{
-	int short_name_size;
-	char *short_name;
-	unsigned long utf8_name_size;
-	efi_char16_t *variable_name = new_var->var.VariableName;
-	int ret;
-
-	/*
-	 * Length of the variable bytes in UTF8, plus the '-' separator,
-	 * plus the GUID, plus trailing NUL
-	 */
-	utf8_name_size = ucs2_utf8size(variable_name);
-	short_name_size = utf8_name_size + 1 + EFI_VARIABLE_GUID_LEN + 1;
-
-	short_name = kmalloc(short_name_size, GFP_KERNEL);
-	if (!short_name)
-		return -ENOMEM;
-
-	ucs2_as_utf8(short_name, variable_name, short_name_size);
-
-	/* This is ugly, but necessary to separate one vendor's
-	   private variables from another's.         */
-	short_name[utf8_name_size] = '-';
-	efi_guid_to_str(&new_var->var.VendorGuid,
-			 short_name + utf8_name_size + 1);
-
-	new_var->kobj.kset = efivars_kset;
-
-	ret = kobject_init_and_add(&new_var->kobj, &efivar_ktype,
-				   NULL, "%s", short_name);
-	kfree(short_name);
-	if (ret) {
-		kobject_put(&new_var->kobj);
-		return ret;
-	}
-
-	kobject_uevent(&new_var->kobj, KOBJ_ADD);
-	if (efivar_entry_add(new_var, &efivar_sysfs_list)) {
-		efivar_unregister(new_var);
-		return -EINTR;
-	}
-
-	return 0;
-}
-
-static int
-create_efivars_bin_attributes(void)
-{
-	struct bin_attribute *attr;
-	int error;
-
-	/* new_var */
-	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
-	if (!attr)
-		return -ENOMEM;
-
-	attr->attr.name = "new_var";
-	attr->attr.mode = 0200;
-	attr->write = efivar_create;
-	efivars_new_var = attr;
-
-	/* del_var */
-	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
-	if (!attr) {
-		error = -ENOMEM;
-		goto out_free;
-	}
-	attr->attr.name = "del_var";
-	attr->attr.mode = 0200;
-	attr->write = efivar_delete;
-	efivars_del_var = attr;
-
-	sysfs_bin_attr_init(efivars_new_var);
-	sysfs_bin_attr_init(efivars_del_var);
-
-	/* Register */
-	error = sysfs_create_bin_file(&efivars_kset->kobj, efivars_new_var);
-	if (error) {
-		printk(KERN_ERR "efivars: unable to create new_var sysfs file"
-			" due to error %d\n", error);
-		goto out_free;
-	}
-
-	error = sysfs_create_bin_file(&efivars_kset->kobj, efivars_del_var);
-	if (error) {
-		printk(KERN_ERR "efivars: unable to create del_var sysfs file"
-			" due to error %d\n", error);
-		sysfs_remove_bin_file(&efivars_kset->kobj, efivars_new_var);
-		goto out_free;
-	}
-
-	return 0;
-out_free:
-	kfree(efivars_del_var);
-	efivars_del_var = NULL;
-	kfree(efivars_new_var);
-	efivars_new_var = NULL;
-	return error;
-}
-
-static int efivars_sysfs_callback(efi_char16_t *name, efi_guid_t vendor,
-				  unsigned long name_size, void *data)
-{
-	struct efivar_entry *entry;
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	memcpy(entry->var.VariableName, name, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
-	efivar_create_sysfs_entry(entry);
-
-	return 0;
-}
-
-static int efivar_sysfs_destroy(struct efivar_entry *entry, void *data)
-{
-	int err = efivar_entry_remove(entry);
-
-	if (err)
-		return err;
-	efivar_unregister(entry);
-	return 0;
-}
-
-static void efivars_sysfs_exit(void)
-{
-	/* Remove all entries and destroy */
-	int err;
-
-	err = __efivar_entry_iter(efivar_sysfs_destroy, &efivar_sysfs_list,
-				  NULL, NULL);
-	if (err) {
-		pr_err("efivars: Failed to destroy sysfs entries\n");
-		return;
-	}
-
-	if (efivars_new_var)
-		sysfs_remove_bin_file(&efivars_kset->kobj, efivars_new_var);
-	if (efivars_del_var)
-		sysfs_remove_bin_file(&efivars_kset->kobj, efivars_del_var);
-	kfree(efivars_new_var);
-	kfree(efivars_del_var);
-	kset_unregister(efivars_kset);
-}
-
-static int efivars_sysfs_init(void)
-{
-	struct kobject *parent_kobj = efivars_kobject();
-	int error = 0;
-
-	/* No efivars has been registered yet */
-	if (!parent_kobj || !efivar_supports_writes())
-		return 0;
-
-	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
-	       EFIVARS_DATE);
-
-	efivars_kset = kset_create_and_add("vars", NULL, parent_kobj);
-	if (!efivars_kset) {
-		printk(KERN_ERR "efivars: Subsystem registration failed.\n");
-		return -ENOMEM;
-	}
-
-	efivar_init(efivars_sysfs_callback, NULL, true, &efivar_sysfs_list);
-
-	error = create_efivars_bin_attributes();
-	if (error) {
-		efivars_sysfs_exit();
-		return error;
-	}
-
-	return 0;
-}
-
-module_init(efivars_sysfs_init);
-module_exit(efivars_sysfs_exit);
-- 
2.35.1

