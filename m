Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF814BA049
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 13:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbiBQMlH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 07:41:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbiBQMlG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 07:41:06 -0500
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 04:40:52 PST
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A326A2C1;
        Thu, 17 Feb 2022 04:40:52 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 9B9912B00220;
        Thu, 17 Feb 2022 07:33:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 17 Feb 2022 07:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=jJAvTOP7DGVsKlnoRNy0hAex2AFIzRV/iOCzuW
        6+yeY=; b=hgaPpn4DeJWqY6HlpXxhuFMDj2Nd8g1/jrrnDKbfgGuiIzw3m5k8O+
        LkR4s9fE9o9Ze7knvpTs5AajB9rHPjLWfNmfox1DE463gupahqmIblOacIDCI6Ez
        Vl2qpwuLMMeXsbb/AJU3zwx9mRIJfbymTuAyDLm5xawr+JpyzDLQ9HoVkpFXKJgj
        OzqauBFiOz2FdKsRfe/gB6YMILcCe4seIGxL4Q00xFGHeFYrRxevqYBixjoSlqFT
        B5tyaXvgCPC630gwtDSWKPwuzE4KK6YkX8QBD4Dv15cWekBMTycKfGzsEWEq8RBI
        QR2H1PZpnOK/hPxGkEtHQ6ur48UeRpIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jJAvTOP7DGVsKlnoR
        Ny0hAex2AFIzRV/iOCzuW6+yeY=; b=f6jMRqyFzz1WLJjPGriGZQPPXj4bRGKiY
        TzBBBmYGL5kt8IOI/nS7SxgqzywCWptKfYihaw5wjnsAWsN0cOiDd8YXzS5OFw3o
        nBtoBWjMDORAQ8Yw1j9A0qM3opr7uHF6zrKj/WScu2wEM9eBF7mIQcluWBTuDB3r
        Wjj66ls1hCO39Y7plvkxbHxiavZV7W14Zvgb01iBjL5J9TvZ8g4GaF+Uxryy2B/m
        /oR2x/9Djl/Q8EoKnmr6/RUXle8+xlqnt/29i7lxVGNgKlX16216XLH3hIbPtFZd
        DrgUXc1UJFJQpsXSdM7nYurBsghzmZnwC5madTPCGf1Ic26bK3KJg==
X-ME-Sender: <xms:jEAOYo6Vya71ZKCLmeiiBYcMnf_muIwMaGSUOD4x8a-Dsm90ZqJxgA>
    <xme:jEAOYp5dENM6cjoePMMURjr1H9NRh-zeCjkERkGZn7ln4Ro63eGBRt6XY5Rq7zfas
    naQZO_VuoLUuA>
X-ME-Received: <xmr:jEAOYncoHNvMZz1vKw_Xdjkifnr8MOu43OIsyuxMHI91YKnEOqD94jPlacK7G9IR52BgSCumb-cviU7-FKXAR1tZ9UcMkXtV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:jEAOYtKQ71utQDsogGpqlTGTEd5lXDkxD4CscBzVNQQSgHPRGGXudA>
    <xmx:jEAOYsIZ-TrBIFEjUxI1h6QCIVuj8MK1pQZqowb11mJQCxqIbf048Q>
    <xmx:jEAOYuzf8mS6sk99w97iPeGngR0ISZpvWaQamwKd0_iEPfiqzRh6UA>
    <xmx:jUAOYh6Sa0BKWJ8ey7y7FlNipdSG6WxfOSp5WvxLYZApikSXjEFBTD-soAI>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 07:33:15 -0500 (EST)
Date:   Thu, 17 Feb 2022 13:33:13 +0100
From:   Greg KH <greg@kroah.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers/s390/char: Add Ultravisor io device
Message-ID: <Yg5AiTWYl8y842Nt@kroah.com>
References: <20220217113717.46624-1-seiden@linux.ibm.com>
 <20220217113717.46624-2-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217113717.46624-2-seiden@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 17, 2022 at 06:37:15AM -0500, Steffen Eiden wrote:
> This patch adds a new miscdevice to expose some Ultravisor functions
> to userspace. Userspace can send IOCTLis to the uvdevice that will then
> emit a corresponding Ultravisor Call and hands the result over to
> userspace. The uvdevice is available if the Ultravisor Call facility is
> present.
> 
> Userspace is now able to call the Query Ultravisor Information
> Ultravisor Command through the uvdevice.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  MAINTAINERS                           |   2 +
>  arch/s390/include/uapi/asm/uvdevice.h |  27 +++++
>  drivers/s390/char/Kconfig             |   9 ++
>  drivers/s390/char/Makefile            |   1 +
>  drivers/s390/char/uvdevice.c          | 162 ++++++++++++++++++++++++++
>  5 files changed, 201 insertions(+)
>  create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
>  create mode 100644 drivers/s390/char/uvdevice.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5250298d2817..c7d8d0fe48cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10457,9 +10457,11 @@ F:	Documentation/virt/kvm/s390*
>  F:	arch/s390/include/asm/gmap.h
>  F:	arch/s390/include/asm/kvm*
>  F:	arch/s390/include/uapi/asm/kvm*
> +F:	arch/s390/include/uapi/asm/uvdevice.h
>  F:	arch/s390/kernel/uv.c
>  F:	arch/s390/kvm/
>  F:	arch/s390/mm/gmap.c
> +F:	drivers/s390/char/uvdevice.c
>  F:	tools/testing/selftests/kvm/*/s390x/
>  F:	tools/testing/selftests/kvm/s390x/
>  
> diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
> new file mode 100644
> index 000000000000..f2e4984a6e2e
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
> +	__u32 flags;			/* Currently no flags defined, must be zero */
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
> index 6cc4b19acf85..933c0d0062d6 100644
> --- a/drivers/s390/char/Kconfig
> +++ b/drivers/s390/char/Kconfig
> @@ -184,3 +184,12 @@ config S390_VMUR
>  	depends on S390
>  	help
>  	  Character device driver for z/VM reader, puncher and printer.
> +
> +config UV_UAPI
> +	def_tristate m
> +	prompt "Ultravisor userspace API"
> +	depends on PROTECTED_VIRTUALIZATION_GUEST
> +	help
> +	  Selecting exposes parts of the UV interface to userspace
> +	  by providing a misc character device. Using IOCTLs one
> +	  can interact with the UV.
> diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
> index c6fdb81a068a..b5c83092210e 100644
> --- a/drivers/s390/char/Makefile
> +++ b/drivers/s390/char/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_MONREADER) += monreader.o
>  obj-$(CONFIG_MONWRITER) += monwriter.o
>  obj-$(CONFIG_S390_VMUR) += vmur.o
>  obj-$(CONFIG_CRASH_DUMP) += sclp_sdias.o zcore.o
> +obj-$(CONFIG_UV_UAPI) += uvdevice.o
>  
>  hmcdrv-objs := hmcdrv_mod.o hmcdrv_dev.o hmcdrv_ftp.o hmcdrv_cache.o diag_ftp.o sclp_ftp.o
>  obj-$(CONFIG_HMC_DRV) += hmcdrv.o
> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> new file mode 100644
> index 000000000000..e8efcbf0e7ab
> --- /dev/null
> +++ b/drivers/s390/char/uvdevice.c
> @@ -0,0 +1,162 @@
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
> +	u64 sum = 0;
> +	u64 i;
> +
> +	if (copy_from_user(ioctl, argp, sizeof(*ioctl)))
> +		return -EFAULT;
> +	if (ioctl->flags != 0)
> +		return -EINVAL;
> +	for (i = 0; i < ARRAY_SIZE(ioctl->reserved14); i++)
> +		sum += ioctl->reserved14[i];
> +	if (sum)
> +		return -EINVAL;

So you can have -1, 1, -1, 1, and so on and cause this to be an
incorrect check.  Just test for 0 and bail out early please.



> +
> +	return 0;
> +}
> +
> +static int uvio_dev_open(struct inode *inode, struct file *filp)
> +{
> +	return 0;
> +}
> +
> +static int uvio_dev_close(struct inode *inodep, struct file *filp)
> +{
> +	return 0;
> +}

If open/close do nothing, no need to provide it at all, just drop them.

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
> +		ret = uvio_qui(uv_ioctl);
> +		break;
> +	default:
> +		ret = -EINVAL;

Wrong error value :(

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
> +	.open = uvio_dev_open,
> +	.release = uvio_dev_close,
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

Nothing to cause this to automatically be loaded when the "hardware" is
present?

thanks,

greg k-h
