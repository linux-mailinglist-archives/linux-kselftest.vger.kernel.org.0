Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689224CA24B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 11:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiCBKfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiCBKfh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 05:35:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41FBECC7;
        Wed,  2 Mar 2022 02:34:53 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222AMV6E003135;
        Wed, 2 Mar 2022 10:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3tdGN9ibb/Hh0+2fPrC6qmejxe39cirDchhlXhkVOCs=;
 b=XNkqLGy5CRV8D9k9Qb+O1wcRwroe06AXLqj2es+MGR5s4g3aQjpyMUwCltPuU7h0Zbu6
 ZO/9BW236r7ckhfZjNO/KieN0dTRXYuyBN9CjysR5712lkCLX7Jk3REFnZB5IpDK6H0r
 If+5YnLnmhmMiBPuVToVLozQbaVOUq5iLPLhc4ONBWpGMFkH5Jq9R94JwxzgY+zVocwp
 Haioc0l1qjBdwByQwk2qD247mGrwULCw4zTRTAqsy3fwUNOnOEKozhY8thZhkdRhBxN+
 YRbayH/Bmo3jXrHg7RIcl+IJAhQbZlTyDNK47s6u/ZBT2bait0MwnVJSafoH8ieftUf7 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej6s907mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:34:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222AQDBo016810;
        Wed, 2 Mar 2022 10:34:50 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ej6s907mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:34:50 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222AWjRY032327;
        Wed, 2 Mar 2022 10:34:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3efbu9cy6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:34:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222AYjDU52363632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 10:34:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39FCF52057;
        Wed,  2 Mar 2022 10:34:45 +0000 (GMT)
Received: from [9.145.51.38] (unknown [9.145.51.38])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AB29C52054;
        Wed,  2 Mar 2022 10:34:44 +0000 (GMT)
Message-ID: <7058948f-5514-4f8f-c974-f1ac624d67c3@linux.ibm.com>
Date:   Wed, 2 Mar 2022 11:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] drivers/s390/char: Add Ultravisor io device
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
In-Reply-To: <20220223144830.44039-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KgYrLJ160RhNK_XViEKh3uQnFuun4WQU
X-Proofpoint-ORIG-GUID: uYt3sAmlrOKlifOJjYkJdII1dCxSg15C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020043
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

Please drop the dependency.
We want this to be available to both guest and host as QUI is available 
in both environments and more calls like this could follow.

We could put an option around the attestation but the savings are not 
worth the effort.
