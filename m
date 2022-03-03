Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7F4CBABF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 10:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiCCJyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 04:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiCCJyR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 04:54:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86214560B;
        Thu,  3 Mar 2022 01:53:32 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2239qajp018339;
        Thu, 3 Mar 2022 09:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Tvq0dU0QBR6SgkniRyVT7+6XnxgcT648Nia/6qZaPw4=;
 b=DkBxiPHO4iWiQge3j7NkovCpoTOm9rDL1NSSQHtClj+U4ObCN290n/AqvV9fo7d52f/h
 i0uulGeYOoim+8tXf+KXVjXibij03API0+eNm2cITNT4hZqfHgzx59R9EYB0PyeCBWaN
 TxT+3g6qtoSzRektdQtq4M7XxMG0HHJQYyreZ2cejMMWLps3mmi8urqV5z540auWeo/A
 FaFZOhZm7ZipN4P5CdLHV3LuBNf00dkQCcqBMEXLMs+Pm+m2UWw+L98fXWfBDXu8Pxx7
 70c1/fy4pZep28bFpYY4XGr52HpwH4WV1L/nmThj0n3tbfxK54Hh0xc/FIMnVE4dg6GI bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejue780hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:53:29 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2239qadW018357;
        Thu, 3 Mar 2022 09:53:28 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejue780hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:53:28 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2239mtCS019890;
        Thu, 3 Mar 2022 09:53:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3efbu9fm6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 09:53:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2239rJm434865562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 09:53:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80813A4062;
        Thu,  3 Mar 2022 09:53:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF5A7A405B;
        Thu,  3 Mar 2022 09:53:18 +0000 (GMT)
Received: from [9.145.8.68] (unknown [9.145.8.68])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 09:53:18 +0000 (GMT)
Message-ID: <cc1d8dd0-fae2-18b2-3ac7-02a760e06173@linux.ibm.com>
Date:   Thu, 3 Mar 2022 10:53:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20220223144830.44039-1-seiden@linux.ibm.com>
 <20220223144830.44039-2-seiden@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] drivers/s390/char: Add Ultravisor io device
In-Reply-To: <20220223144830.44039-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zkCtDL-TrJJz9jjEb0xvRo1Z3TBQYfsx
X-Proofpoint-ORIG-GUID: NXTCo0mmb_0Utn_xkBoPbcDdkA6aQd3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/23/22 15:48, Steffen Eiden wrote:
> This patch adds a new miscdevice to expose some Ultravisor functions
> to userspace. Userspace can send IOCTLs to the uvdevice that will then
> emit a corresponding Ultravisor Call and hands the result over to
> userspace. The uvdevice is available if the Ultravisor Call facility is
> present.
> 
> Userspace is now able to call the Query Ultravisor Information
> Ultravisor Command through the uvdevice.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   MAINTAINERS                           |   2 +
>   arch/s390/include/uapi/asm/uvdevice.h |  27 +++++
>   drivers/s390/char/Kconfig             |  11 ++
>   drivers/s390/char/Makefile            |   1 +
>   drivers/s390/char/uvdevice.c          | 145 ++++++++++++++++++++++++++
>   5 files changed, 186 insertions(+)
>   create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
>   create mode 100644 drivers/s390/char/uvdevice.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 777cd6fa2b3d..f32e876f45c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10577,9 +10577,11 @@ F:	Documentation/virt/kvm/s390*
>   F:	arch/s390/include/asm/gmap.h
>   F:	arch/s390/include/asm/kvm*
>   F:	arch/s390/include/uapi/asm/kvm*
> +F:	arch/s390/include/uapi/asm/uvdevice.h
>   F:	arch/s390/kernel/uv.c
>   F:	arch/s390/kvm/
>   F:	arch/s390/mm/gmap.c
> +F:	drivers/s390/char/uvdevice.c
>   F:	tools/testing/selftests/kvm/*/s390x/
>   F:	tools/testing/selftests/kvm/s390x/
>   
> diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
> new file mode 100644
> index 000000000000..60956f8d2dc0
> --- /dev/null
> +++ b/arch/s390/include/uapi/asm/uvdevice.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + *  Copyright IBM Corp. 2022
> + *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
> + */
> +#ifndef __S390X_ASM_UVDEVICE_H
> +#define __S390X_ASM_UVDEVICE_H
> +
> +#include <linux/types.h>
> +
> +struct uvio_ioctl_cb {
> +	__u32 flags;
> +	__u16 uv_rc;			/* UV header rc value */
> +	__u16 uv_rrc;			/* UV header rrc value */
> +	__u64 argument_addr;		/* Userspace address of uvio argument */
> +	__u32 argument_len;
> +	__u8  reserved14[0x40 - 0x14];	/* must be zero */
> +};
> +
> +#define UVIO_QUI_MAX_LEN		0x8000
> +
> +#define UVIO_DEVICE_NAME "uv"
> +#define UVIO_TYPE_UVC 'u'
> +
> +#define UVIO_IOCTL_QUI _IOWR(UVIO_TYPE_UVC, 0x01, struct uvio_ioctl_cb)
> +
> +#endif  /* __S390X_ASM_UVDEVICE_H */
> diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
> index 6cc4b19acf85..2a828274257a 100644
> --- a/drivers/s390/char/Kconfig
> +++ b/drivers/s390/char/Kconfig
> @@ -184,3 +184,14 @@ config S390_VMUR
>   	depends on S390
>   	help
>   	  Character device driver for z/VM reader, puncher and printer.
> +
> +config S390_UV_UAPI
> +	def_tristate y
> +	prompt "Ultravisor userspace API"
> +	depends on PROTECTED_VIRTUALIZATION_GUEST
> +	help
> +	  Selecting exposes parts of the UV interface to userspace
> +	  by providing a misc character device at /dev/uv.
> +	  Using IOCTLs one can interact with the UV.
> +	  The device is available if the Ultravisor
> +	  Facility (158) is present.
> diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
> index c6fdb81a068a..ce32270082f5 100644
> --- a/drivers/s390/char/Makefile
> +++ b/drivers/s390/char/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_MONREADER) += monreader.o
>   obj-$(CONFIG_MONWRITER) += monwriter.o
>   obj-$(CONFIG_S390_VMUR) += vmur.o
>   obj-$(CONFIG_CRASH_DUMP) += sclp_sdias.o zcore.o
> +obj-$(CONFIG_S390_UV_UAPI) += uvdevice.o
>   
>   hmcdrv-objs := hmcdrv_mod.o hmcdrv_dev.o hmcdrv_ftp.o hmcdrv_cache.o diag_ftp.o sclp_ftp.o
>   obj-$(CONFIG_HMC_DRV) += hmcdrv.o
> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> new file mode 100644
> index 000000000000..1d90e129b570
> --- /dev/null
> +++ b/drivers/s390/char/uvdevice.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright IBM Corp. 2022
> + *  Author(s): Steffen Eiden <seiden@linux.ibm.com>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt ".\n"
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> +#include <linux/vmalloc.h>
> +#include <linux/slab.h>
> +
> +#include <asm/uvdevice.h>
> +#include <asm/uv.h>
> +
> +/**
> + * uvio_qui() - Perform a Query Ultravisor Information UVC.
> + *
> + * uv_ioctl: ioctl control block
> + *
> + * uvio_qui() does a Query Ultravisor Information (QUI) Ultravisor Call.
> + * It creates the uvc qui request and sends it to the Ultravisor. After that
> + * it copies the response to userspace and fills the rc and rrc of uv_ioctl
> + * uv_call with the response values of the Ultravisor.
> + *
> + * Create the UVC structure, send the UVC to UV and write the response in the ioctl struct.
> + *
> + * Return: 0 on success or a negative error code on error.
> + */
> +static int uvio_qui(struct uvio_ioctl_cb *uv_ioctl)
> +{
> +	u8 __user *user_buf_addr = (__user u8 *)uv_ioctl->argument_addr;
> +	size_t user_buf_len = uv_ioctl->argument_len;
> +	struct uv_cb_header *uvcb_qui = NULL;
> +	int ret;
> +
> +	/*
> +	 * Do not check for a too small buffer. If userspace provides a buffer
> +	 * that is too small the Ultravisor will complain.
> +	 */
> +	ret = -EINVAL;
> +	if (!user_buf_len || user_buf_len > UVIO_QUI_MAX_LEN)
> +		goto out;
> +	ret = -ENOMEM;
> +	uvcb_qui = kvzalloc(user_buf_len, GFP_KERNEL);
> +	if (!uvcb_qui)
> +		goto out;
> +	uvcb_qui->len = user_buf_len;
> +	uvcb_qui->cmd = UVC_CMD_QUI;
> +
> +	uv_call(0, (u64)uvcb_qui);

You'll copy zeroes to userspace if the rc is anything other than 0x1 or 
0x100. It's not a mistake in itself, it just looks weird to me.

Also you don't consider the UV rc an error so userspace will always have 
to check the uv rc and rrc even if the ioctl returns 0.

And it pretty much makes the rc and rrc copying below completely useless 
since they'll always be in the actual uvcb data, no?

> +
> +	ret = -EFAULT;
> +	if (copy_to_user(user_buf_addr, uvcb_qui, uvcb_qui->len))
> +		goto out;
> +	uv_ioctl->uv_rc = uvcb_qui->rc;
> +	uv_ioctl->uv_rrc = uvcb_qui->rrc;
> +
> +	ret = 0;
> +out:
> +	kvfree(uvcb_qui);
> +	return ret;
> +}
> +
> +static int uvio_copy_and_check_ioctl(struct uvio_ioctl_cb *ioctl, void __user *argp)
> +{
> +	if (copy_from_user(ioctl, argp, sizeof(*ioctl)))
> +		return -EFAULT;
> +	if (ioctl->flags != 0)
> +		return -EINVAL;
> +	if (memchr_inv(ioctl->reserved14, 0, sizeof(ioctl->reserved14)))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * IOCTL entry point for the Ultravisor device.
> + */
> +static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	struct uvio_ioctl_cb *uv_ioctl;
> +	long ret;
> +
> +	ret = -ENOMEM;
> +	uv_ioctl = vzalloc(sizeof(*uv_ioctl));
> +	if (!uv_ioctl)
> +		goto out;
> +
> +	switch (cmd) {
> +	case UVIO_IOCTL_QUI:
> +		ret = uvio_copy_and_check_ioctl(uv_ioctl, argp);
> +		if (ret)
> +			goto out;

You'll have to repeat this for every command making the

> +		ret = uvio_qui(uv_ioctl);
> +		break;
> +	default:
> +		ret = -ENOIOCTLCMD;
> +		break;
> +	}
> +	if (ret)
> +		goto out;
> +
> +	if (copy_to_user(argp, uv_ioctl, sizeof(*uv_ioctl)))
> +		ret = -EFAULT;
> +
> + out:
> +	vfree(uv_ioctl);
> +	return ret;
> +}
> +
> +static const struct file_operations uvio_dev_fops = {
> +	.owner = THIS_MODULE,
> +	.unlocked_ioctl = uvio_ioctl,
> +	.llseek = no_llseek,
> +};
> +
> +static struct miscdevice uvio_dev_miscdev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = UVIO_DEVICE_NAME,
> +	.fops = &uvio_dev_fops,
> +};
> +
> +static void __exit uvio_dev_exit(void)
> +{
> +	misc_deregister(&uvio_dev_miscdev);
> +}
> +
> +static int __init uvio_dev_init(void)
> +{
> +	if (!test_facility(158))
> +		return -ENXIO;
> +	return misc_register(&uvio_dev_miscdev);
> +}
> +
> +module_init(uvio_dev_init);
> +module_exit(uvio_dev_exit);
> +
> +MODULE_AUTHOR("IBM Corporation");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Ultravisor UAPI driver");

