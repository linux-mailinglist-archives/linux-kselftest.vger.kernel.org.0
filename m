Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9819C4C15BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiBWOtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 09:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbiBWOtR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 09:49:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8D2B54F9;
        Wed, 23 Feb 2022 06:48:49 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NDfjo0023274;
        Wed, 23 Feb 2022 14:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EuFozQSkMbQs2TKeDBAa94wQvQyi6H8DM8Jc9HLMztE=;
 b=BSbN7r0KRPLZa3caYpcdyqurI0NTBwDa1Y/BdhDBJPlPw+uNkSDr8HQwPRx2Q7xAWqnv
 MPc4a4oFaNC+G4hewvPCFfSixLR3r4+kgrKbdjE1JkxgXfj0MbXEzEhr/gxKwcMRWAIc
 w63pxa5B150eVxeJRPB9WjaV0eV8VA7ccuDB+fOeGuq+Cd/yDWzwgDcBIQ0/pKSpYZ0c
 DLBv3+NUV0jH3B1NGikMiVw1hlZU+Yzo04HylTyifYkrB7UqE8mxZ0esKMTG9CYAgQx5
 //v8TigAyj6k0LFRNx6VRGhxLjipg0lSRW9W4BvFLagRtQOOeKM8KrdEgkQ7HnCdCMBP vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edp1jhn18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 14:48:42 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NEbT2C007972;
        Wed, 23 Feb 2022 14:48:42 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edp1jhn07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 14:48:41 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NEWUnw004070;
        Wed, 23 Feb 2022 14:48:39 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3ear6999eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 14:48:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NEmaAp49676644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 14:48:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02ED64203F;
        Wed, 23 Feb 2022 14:48:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B38CB4204D;
        Wed, 23 Feb 2022 14:48:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.12.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 14:48:33 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/3] drivers/s390/char: Add Ultravisor io device
Date:   Wed, 23 Feb 2022 09:48:28 -0500
Message-Id: <20220223144830.44039-2-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223144830.44039-1-seiden@linux.ibm.com>
References: <20220223144830.44039-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TTHwQJvMAUMu9iURoFtOJ64qxQxMeLjF
X-Proofpoint-GUID: gxcz7UgxF3NZP6rdAYQPu_6EPZfj7hVJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_06,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230083
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

Userspace is now able to call the Query Ultravisor Information
Ultravisor Command through the uvdevice.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 MAINTAINERS                           |   2 +
 arch/s390/include/uapi/asm/uvdevice.h |  27 +++++
 drivers/s390/char/Kconfig             |  11 ++
 drivers/s390/char/Makefile            |   1 +
 drivers/s390/char/uvdevice.c          | 145 ++++++++++++++++++++++++++
 5 files changed, 186 insertions(+)
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
 
diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
new file mode 100644
index 000000000000..60956f8d2dc0
--- /dev/null
+++ b/arch/s390/include/uapi/asm/uvdevice.h
@@ -0,0 +1,27 @@
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
+#define UVIO_QUI_MAX_LEN		0x8000
+
+#define UVIO_DEVICE_NAME "uv"
+#define UVIO_TYPE_UVC 'u'
+
+#define UVIO_IOCTL_QUI _IOWR(UVIO_TYPE_UVC, 0x01, struct uvio_ioctl_cb)
+
+#endif  /* __S390X_ASM_UVDEVICE_H */
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index 6cc4b19acf85..2a828274257a 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -184,3 +184,14 @@ config S390_VMUR
 	depends on S390
 	help
 	  Character device driver for z/VM reader, puncher and printer.
+
+config S390_UV_UAPI
+	def_tristate y
+	prompt "Ultravisor userspace API"
+	depends on PROTECTED_VIRTUALIZATION_GUEST
+	help
+	  Selecting exposes parts of the UV interface to userspace
+	  by providing a misc character device at /dev/uv.
+	  Using IOCTLs one can interact with the UV.
+	  The device is available if the Ultravisor
+	  Facility (158) is present.
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
index 000000000000..1d90e129b570
--- /dev/null
+++ b/drivers/s390/char/uvdevice.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright IBM Corp. 2022
+ *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt ".\n"
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
+/**
+ * uvio_qui() - Perform a Query Ultravisor Information UVC.
+ *
+ * uv_ioctl: ioctl control block
+ *
+ * uvio_qui() does a Query Ultravisor Information (QUI) Ultravisor Call.
+ * It creates the uvc qui request and sends it to the Ultravisor. After that
+ * it copies the response to userspace and fills the rc and rrc of uv_ioctl
+ * uv_call with the response values of the Ultravisor.
+ *
+ * Create the UVC structure, send the UVC to UV and write the response in the ioctl struct.
+ *
+ * Return: 0 on success or a negative error code on error.
+ */
+static int uvio_qui(struct uvio_ioctl_cb *uv_ioctl)
+{
+	u8 __user *user_buf_addr = (__user u8 *)uv_ioctl->argument_addr;
+	size_t user_buf_len = uv_ioctl->argument_len;
+	struct uv_cb_header *uvcb_qui = NULL;
+	int ret;
+
+	/*
+	 * Do not check for a too small buffer. If userspace provides a buffer
+	 * that is too small the Ultravisor will complain.
+	 */
+	ret = -EINVAL;
+	if (!user_buf_len || user_buf_len > UVIO_QUI_MAX_LEN)
+		goto out;
+	ret = -ENOMEM;
+	uvcb_qui = kvzalloc(user_buf_len, GFP_KERNEL);
+	if (!uvcb_qui)
+		goto out;
+	uvcb_qui->len = user_buf_len;
+	uvcb_qui->cmd = UVC_CMD_QUI;
+
+	uv_call(0, (u64)uvcb_qui);
+
+	ret = -EFAULT;
+	if (copy_to_user(user_buf_addr, uvcb_qui, uvcb_qui->len))
+		goto out;
+	uv_ioctl->uv_rc = uvcb_qui->rc;
+	uv_ioctl->uv_rrc = uvcb_qui->rrc;
+
+	ret = 0;
+out:
+	kvfree(uvcb_qui);
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
+	case UVIO_IOCTL_QUI:
+		ret = uvio_copy_and_check_ioctl(uv_ioctl, argp);
+		if (ret)
+			goto out;
+		ret = uvio_qui(uv_ioctl);
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
2.25.1

