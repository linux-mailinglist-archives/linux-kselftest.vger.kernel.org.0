Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE0F4DC33E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 10:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiCQJsm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 05:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiCQJsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 05:48:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD41D7DA1;
        Thu, 17 Mar 2022 02:47:23 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H9Nle7007155;
        Thu, 17 Mar 2022 09:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=r66Vjcp8xCMr0KNmkY2c6A0hM2rUUVwXppd5hXBJh08=;
 b=V4OVQb7BrxSNLUQZvqLaoeTMUcl7BuqJeoJLKPlPKKETSlg5U5+vEhX4XpXqsEB9xtRD
 uPkSsP9RuNF4fsS6yc0xZ8yrkKyxP9pC43oKM2ArpzZc7YlKwMB+AzwbqkkXVIEXHpFy
 GKV+9ppeu0WADM5BCxAzrvbtnNSzPEsq/owjjGUL83+JFZaY6oTEDNxZCbFt02xPVhY5
 ifGpAI7nfjSsLZx81UOQ3RVife9g3WTzN9LYMDRss7Px7vut+uDQjYL0Lh3o4zXNmjU1
 vrK5OyFh9OFvXA7kiDBP5AV4hUGsLc1yqvD33JtrdHy5kXxeEKtHYpXUIiwXDDatVOjH ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev2am0d2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 09:47:16 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22H9kaGK023406;
        Thu, 17 Mar 2022 09:47:15 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev2am0d1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 09:47:15 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22H9h2Wu029317;
        Thu, 17 Mar 2022 09:47:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3erk58sawy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 09:47:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22H9lChk42336604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 09:47:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3745A4060;
        Thu, 17 Mar 2022 09:47:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A568A405B;
        Thu, 17 Mar 2022 09:47:07 +0000 (GMT)
Received: from linux7.. (unknown [9.114.12.92])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Mar 2022 09:47:07 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     seiden@linux.ibm.com
Cc:     agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        david@redhat.com, frankja@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, nrb@linux.ibm.com, shuah@kernel.org
Subject: Re: [PATCH v3 1/4] drivers/s390/char: Add Ultravisor io device'
Date:   Thu, 17 Mar 2022 09:47:06 +0000
Message-Id: <20220317094706.4921-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304141141.32767-2-seiden@linux.ibm.com>
References: <20220304141141.32767-2-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iR2ZbLK9CwkIDz1FFE3sy2w-_JI4llgK
X-Proofpoint-GUID: WJFr5fu1xIbireDlPjyYtb0nZlTdONt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_03,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203170056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds a new miscdevice to expose some Ultravisor functions
to userspace. Userspace can send IOCTLs to the uvdevice that will then
emit a corresponding Ultravisor Call and hands the result over to
userspace. The uvdevice is available if the Ultravisor Call facility is
present.
Userspace can call the Retrieve Attestation Measurement
Ultravisor Call using IOCTLs on the uvdevice.

The uvdevice will do some sanity checks first.
Then, copy the request data to kernel space, build the UVCB,
perform the UV call, and copy the result back to userspace.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

---
The Kconfig entry was below the comment 'S/390 tape hardware support'.
This is confusing, as UV has nothing to do with tapes.
I moved the entry upwards just before the 'S390_TAPE' config entry. 

 MAINTAINERS                           |   2 +
 arch/s390/include/asm/uv.h            |  23 ++-
 arch/s390/include/uapi/asm/uvdevice.h |  51 +++++
 drivers/s390/char/Kconfig             |  10 +
 drivers/s390/char/Makefile            |   1 +
 drivers/s390/char/uvdevice.c          | 264 ++++++++++++++++++++++++++
 6 files changed, 350 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
 create mode 100644 drivers/s390/char/uvdevice.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 777cd6fa2b3d..f32e876f45c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10577,9 +10577,11 @@ F:	Documentation/virt/kvm/s390*
 F:	arch/s390/include/asm/gmap.h
 F:	arch/s390/include/asm/kvm*
 F:	arch/s390/include/uapi/asm/kvm*
+F:	arch/s390/include/uapi/asm/uvdevice.h
 F:	arch/s390/kernel/uv.c
 F:	arch/s390/kvm/
 F:	arch/s390/mm/gmap.c
+F:	drivers/s390/char/uvdevice.c
 F:	tools/testing/selftests/kvm/*/s390x/
 F:	tools/testing/selftests/kvm/s390x/
 
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 86218382d29c..760dda4024b9 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -2,7 +2,7 @@
 /*
  * Ultravisor Interfaces
  *
- * Copyright IBM Corp. 2019
+ * Copyright IBM Corp. 2019, 2022
  *
  * Author(s):
  *	Vasily Gorbik <gor@linux.ibm.com>
@@ -52,6 +52,7 @@
 #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
 #define UVC_CMD_SET_SHARED_ACCESS	0x1000
 #define UVC_CMD_REMOVE_SHARED_ACCESS	0x1001
+#define UVC_CMD_RETR_ATTEST		0x1020
 
 /* Bits in installed uv calls */
 enum uv_cmds_inst {
@@ -76,6 +77,7 @@ enum uv_cmds_inst {
 	BIT_UVC_CMD_UNSHARE_ALL = 20,
 	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
 	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
+	BIT_UVC_CMD_RETR_ATTEST = 28,
 };
 
 enum uv_feat_ind {
@@ -218,6 +220,25 @@ struct uv_cb_share {
 	u64 reserved28;
 } __packed __aligned(8);
 
+/* Retrieve Attestation Measurement */
+struct uv_cb_attest {
+	struct uv_cb_header header;	/* 0x0000 */
+	u64 reserved08[2];		/* 0x0008 */
+	u64 arcb_addr;			/* 0x0018 */
+	u64 cont_token;			/* 0x0020 */
+	u8  reserved28[6];		/* 0x0028 */
+	u16 user_data_len;		/* 0x002e */
+	u8  user_data[256];		/* 0x0030 */
+	u32 reserved130[3];		/* 0x0130 */
+	u32 meas_len;			/* 0x013c */
+	u64 meas_addr;			/* 0x0140 */
+	u8  config_uid[16];		/* 0x0148 */
+	u32 reserved158;		/* 0x0158 */
+	u32 add_data_len;		/* 0x015c */
+	u64 add_data_addr;		/* 0x0160 */
+	u64 reserved168[4];		/* 0x0168 */
+} __packed __aligned(8);
+
 static inline int __uv_call(unsigned long r1, unsigned long r2)
 {
 	int cc;
diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
new file mode 100644
index 000000000000..d40f69345c75
--- /dev/null
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  Copyright IBM Corp. 2022
+ *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
+ */
+#ifndef __S390X_ASM_UVDEVICE_H
+#define __S390X_ASM_UVDEVICE_H
+
+#include <linux/types.h>
+
+struct uvio_ioctl_cb {
+	__u32 flags;
+	__u16 uv_rc;			/* UV header rc value */
+	__u16 uv_rrc;			/* UV header rrc value */
+	__u64 argument_addr;		/* Userspace address of uvio argument */
+	__u32 argument_len;
+	__u8  reserved14[0x40 - 0x14];	/* must be zero */
+};
+
+#define UVIO_ATT_USER_DATA_LEN		0x100
+#define UVIO_ATT_UID_LEN		0x10
+struct uvio_attest {
+	__u64 arcb_addr;				/* 0x0000 */
+	__u64 meas_addr;				/* 0x0008 */
+	__u64 add_data_addr;				/* 0x0010 */
+	__u8  user_data[UVIO_ATT_USER_DATA_LEN];	/* 0x0018 */
+	__u8  config_uid[UVIO_ATT_UID_LEN];		/* 0x0118 */
+	__u32 arcb_len;					/* 0x0128 */
+	__u32 meas_len;					/* 0x012c */
+	__u32 add_data_len;				/* 0x0130 */
+	__u16 user_data_len;				/* 0x0134 */
+	__u16 reserved136;				/* 0x0136 */
+};
+
+/*
+ * The following max values define an upper length for the IOCTL in/out buffers.
+ * However, they do not represent the maximum the Ultravisor allows which is
+ * often way smaller. By allowing larger buffer sizes we hopefully do not need
+ * to update the code with every machine update. It is therefore possible for
+ * userspace to request more memory than actually used by kernel/UV.
+ */
+#define UVIO_ATT_ARCB_MAX_LEN		0x100000
+#define UVIO_ATT_MEASUREMENT_MAX_LEN	0x8000
+#define UVIO_ATT_ADDITIONAL_MAX_LEN	0x8000
+
+#define UVIO_DEVICE_NAME "uv"
+#define UVIO_TYPE_UVC 'u'
+
+#define UVIO_IOCTL_ATT _IOWR(UVIO_TYPE_UVC, 0x01, struct uvio_ioctl_cb)
+
+#endif  /* __S390X_ASM_UVDEVICE_H */
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index 6cc4b19acf85..e9b9902abbaf 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -100,6 +100,16 @@ config SCLP_OFB
 	  This option enables the Open-for-Business interface to the s390
 	  Service Element.
 
+config S390_UV_UAPI
+	def_tristate y
+	prompt "Ultravisor userspace API"
+	help
+	  Selecting exposes parts of the UV interface to userspace
+	  by providing a misc character device at /dev/uv.
+	  Using IOCTLs one can interact with the UV.
+	  The device is only available if the Ultravisor
+	  Facility (158) is present.
+
 config S390_TAPE
 	def_tristate m
 	prompt "S/390 tape device support"
diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
index c6fdb81a068a..ce32270082f5 100644
--- a/drivers/s390/char/Makefile
+++ b/drivers/s390/char/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_MONREADER) += monreader.o
 obj-$(CONFIG_MONWRITER) += monwriter.o
 obj-$(CONFIG_S390_VMUR) += vmur.o
 obj-$(CONFIG_CRASH_DUMP) += sclp_sdias.o zcore.o
+obj-$(CONFIG_S390_UV_UAPI) += uvdevice.o
 
 hmcdrv-objs := hmcdrv_mod.o hmcdrv_dev.o hmcdrv_ftp.o hmcdrv_cache.o diag_ftp.o sclp_ftp.o
 obj-$(CONFIG_HMC_DRV) += hmcdrv.o
diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
new file mode 100644
index 000000000000..b720dc8d0bd9
--- /dev/null
+++ b/drivers/s390/char/uvdevice.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright IBM Corp. 2022
+ *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
+ *
+ *  This file provides a Linux misc device to give userspace access to some
+ *  Ultravisor (UV) functions. The device only accepts IOCTLs and will only
+ *  be present if the Ultravisor facility (158) is present.
+ *
+ *  When userspace sends a valid IOCTL uvdevice will copy the input data to
+ *  kernel space, do some basic validity checks to avoid kernel/system
+ *  corruption. Any other check that the Ultravisor does will not be done by
+ *  the uvdevice to keep changes minimal when adding new functionalities
+ *  to existing UV-calls.
+ *  After the checks uvdevice builds a corresponding
+ *  Ultravisor Call Control Block, and sends the request to the Ultravisor.
+ *  Then, it copies the response, including the return codes, back to userspace.
+ *  It is the responsibility of the userspace to check for any error issued
+ *  by UV and to interpret the UV response. The uvdevice acts as a communication
+ *  channel for userspace to the Ultravisor.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+
+#include <asm/uvdevice.h>
+#include <asm/uv.h>
+
+static int uvio_build_uvcb_attest(struct uv_cb_attest *uvcb_attest, u8 *arcb,
+				  u8 *meas, u8 *add_data, struct uvio_attest *uvio_attest)
+{
+	void __user *user_buf_arcb = (void __user *)uvio_attest->arcb_addr;
+
+	if (copy_from_user(arcb, user_buf_arcb, uvio_attest->arcb_len))
+		return -EFAULT;
+
+	uvcb_attest->header.len = sizeof(*uvcb_attest);
+	uvcb_attest->header.cmd = UVC_CMD_RETR_ATTEST;
+	uvcb_attest->arcb_addr = (u64)arcb;
+	uvcb_attest->cont_token = 0;
+	uvcb_attest->user_data_len = uvio_attest->user_data_len;
+	memcpy(uvcb_attest->user_data, uvio_attest->user_data, sizeof(uvcb_attest->user_data));
+	uvcb_attest->meas_len = uvio_attest->meas_len;
+	uvcb_attest->meas_addr = (u64)meas;
+	uvcb_attest->add_data_len = uvio_attest->add_data_len;
+	uvcb_attest->add_data_addr = (u64)add_data;
+
+	return 0;
+}
+
+static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
+					   struct uvio_ioctl_cb *uv_ioctl,
+					   u8 *measurement, u8 *add_data,
+					   struct uvio_attest *uvio_attest)
+{
+	struct uvio_attest __user *user_uvio_attest = (void __user *)uv_ioctl->argument_addr;
+	void __user *user_buf_add = (void __user *)uvio_attest->add_data_addr;
+	void __user *user_buf_meas = (void __user *)uvio_attest->meas_addr;
+	void __user *user_buf_uid = &user_uvio_attest->config_uid;
+
+	if (copy_to_user(user_buf_meas, measurement, uvio_attest->meas_len))
+		return -EFAULT;
+	if (add_data && copy_to_user(user_buf_add, add_data, uvio_attest->add_data_len))
+		return -EFAULT;
+	if (copy_to_user(user_buf_uid, uvcb_attest->config_uid, sizeof(uvcb_attest->config_uid)))
+		return -EFAULT;
+	return 0;
+}
+
+static int get_uvio_attest(struct uvio_ioctl_cb *uv_ioctl, struct uvio_attest *uvio_attest)
+{
+	u8 __user *user_arg_buf = (u8 __user *)uv_ioctl->argument_addr;
+
+	if (copy_from_user(uvio_attest, user_arg_buf, sizeof(*uvio_attest)))
+		return -EFAULT;
+
+	if (uvio_attest->arcb_len > UVIO_ATT_ARCB_MAX_LEN)
+		return -EINVAL;
+	if (uvio_attest->arcb_len == 0)
+		return -EINVAL;
+	if (uvio_attest->meas_len > UVIO_ATT_MEASUREMENT_MAX_LEN)
+		return -EINVAL;
+	if (uvio_attest->meas_len == 0)
+		return -EINVAL;
+	if (uvio_attest->add_data_len > UVIO_ATT_ADDITIONAL_MAX_LEN)
+		return -EINVAL;
+	if (uvio_attest->reserved136)
+		return -EINVAL;
+	return 0;
+}
+
+/**
+ * uvio_attestation() - Perform a Retrieve Attestation Measurement UVC.
+ *
+ * uv_ioctl: ioctl control block
+ *
+ * uvio_attestation() does a  Retrieve Attestation Measurement Ultravisor Call.
+ * It verifies that the given userspace addresses are valid and request sizes
+ * are sane. Every other check is made by the Ultravisor (UV) and won't result
+ * in a negative return value. It copies the input to kernelspace, builds the
+ * request, sends the UV-call, and copies the result to userspace.
+ *
+ * The Attestation Request has two input and two outputs.
+ * ARCB and User Data are inputs for the UV generated by userspace.
+ * Measurement and Additional Data are outputs for userspace generated by UV.
+ *
+ * The Attestation Request Control Block (ARCB) is a cryptographically verified
+ * and secured request to UV and User Data is some plaintext data which is
+ * going to be included in the Attestation Measurement calculation.
+ *
+ * Measurement is a cryptographic measurement of the callers properties,
+ * optional data configured by the ARCB and the user data. If specified by the
+ * ARCB, UV will add some Additional Data to the measurement calculation.
+ * This Additional Data is then returned as well.
+ *
+ * If the Retrieve Attestation Measurement UV facility is not present,
+ * UV will return invalid command rc. This won't be fenced in the driver
+ * and does not result in a negative return value.
+ *
+ * Context: might sleep
+ *
+ * Return: 0 on success or a negative error code on error.
+ */
+static int uvio_attestation(struct uvio_ioctl_cb *uv_ioctl)
+{
+	struct uv_cb_attest *uvcb_attest = NULL;
+	struct uvio_attest *uvio_attest = NULL;
+	u8 *measurement = NULL;
+	u8 *add_data = NULL;
+	u8 *arcb = NULL;
+	int ret;
+
+	ret = -EINVAL;
+	if (uv_ioctl->argument_len != sizeof(*uvio_attest))
+		goto out;
+
+	ret = -ENOMEM;
+	uvio_attest = kzalloc(sizeof(*uvio_attest), GFP_KERNEL);
+	if (!uvio_attest)
+		goto out;
+
+	ret = get_uvio_attest(uv_ioctl, uvio_attest);
+	if (ret)
+		goto out;
+
+	ret = -ENOMEM;
+	arcb = kvzalloc(uvio_attest->arcb_len, GFP_KERNEL);
+	measurement = kvzalloc(uvio_attest->meas_len, GFP_KERNEL);
+	if (!arcb || !measurement)
+		goto out;
+
+	if (uvio_attest->add_data_len) {
+		add_data = kvzalloc(uvio_attest->add_data_len, GFP_KERNEL);
+		if (!add_data)
+			goto out;
+	}
+
+	uvcb_attest = kzalloc(sizeof(*uvcb_attest), GFP_KERNEL);
+	if (!uvcb_attest)
+		goto out;
+
+	ret = uvio_build_uvcb_attest(uvcb_attest, arcb,  measurement, add_data, uvio_attest);
+	if (ret)
+		goto out;
+
+	uv_call_sched(0, (u64)uvcb_attest);
+
+	uv_ioctl->uv_rc = uvcb_attest->header.rc;
+	uv_ioctl->uv_rrc = uvcb_attest->header.rrc;
+
+	ret = uvio_copy_attest_result_to_user(uvcb_attest, uv_ioctl, measurement, add_data,
+					      uvio_attest);
+out:
+	kvfree(arcb);
+	kvfree(measurement);
+	kvfree(add_data);
+	kfree(uvio_attest);
+	kfree(uvcb_attest);
+	return ret;
+}
+
+static int uvio_copy_and_check_ioctl(struct uvio_ioctl_cb *ioctl, void __user *argp)
+{
+	if (copy_from_user(ioctl, argp, sizeof(*ioctl)))
+		return -EFAULT;
+	if (ioctl->flags != 0)
+		return -EINVAL;
+	if (memchr_inv(ioctl->reserved14, 0, sizeof(ioctl->reserved14)))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * IOCTL entry point for the Ultravisor device.
+ */
+static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct uvio_ioctl_cb *uv_ioctl;
+	long ret;
+
+	ret = -ENOMEM;
+	uv_ioctl = vzalloc(sizeof(*uv_ioctl));
+	if (!uv_ioctl)
+		goto out;
+
+	switch (cmd) {
+	case UVIO_IOCTL_ATT:
+		ret = uvio_copy_and_check_ioctl(uv_ioctl, argp);
+		if (ret)
+			goto out;
+		ret = uvio_attestation(uv_ioctl);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+	if (ret)
+		goto out;
+
+	if (copy_to_user(argp, uv_ioctl, sizeof(*uv_ioctl)))
+		ret = -EFAULT;
+
+ out:
+	vfree(uv_ioctl);
+	return ret;
+}
+
+static const struct file_operations uvio_dev_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = uvio_ioctl,
+	.llseek = no_llseek,
+};
+
+static struct miscdevice uvio_dev_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = UVIO_DEVICE_NAME,
+	.fops = &uvio_dev_fops,
+};
+
+static void __exit uvio_dev_exit(void)
+{
+	misc_deregister(&uvio_dev_miscdev);
+}
+
+static int __init uvio_dev_init(void)
+{
+	if (!test_facility(158))
+		return -ENXIO;
+	return misc_register(&uvio_dev_miscdev);
+}
+
+module_init(uvio_dev_init);
+module_exit(uvio_dev_exit);
+
+MODULE_AUTHOR("IBM Corporation");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Ultravisor UAPI driver");
-- 
2.30.2

