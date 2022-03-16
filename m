Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429774DACFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 09:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354730AbiCPI6M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 04:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354808AbiCPI6L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 04:58:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289B44739A;
        Wed, 16 Mar 2022 01:56:58 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G8Bmqa025811;
        Wed, 16 Mar 2022 08:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p+mOR6ca9NJR3oIyyKmPv0Pg7oEI7rt9N+6UdwFdsO0=;
 b=ZQYGzKiVbWeK8m4oQ9aarLvOagHj3KyrnXhg9vm4hsiTOEiG4anqiSCp6rVzYuhbsdZY
 AEbi7867t6eLmmeW0HWHBHR+434vJMKYpDqVuKTaM032liSaNrGVHGLbI04ogFXQk7/T
 W20GS5G9zoNEuzSLHageTPOm/xzt76GG+G9nQ0ujbDzQ3VCXgtwtsFbDQUBDSNolGMN2
 47ClzunLwgodeNfvQOVRw8x5i20+8ly7bNgJ4q7DRlsNBPhYKRHOyF2gQT0l2EJDH2Rb
 sCltJAR+Q1V/lHEkjycJu02ZsGx9VurJm+KjTAPu6y0YZ1N9cQi78DL1K8AeHQrN2nF/ Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3euc5u0uuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 08:56:56 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22G8J4g5019351;
        Wed, 16 Mar 2022 08:56:55 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3euc5u0utm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 08:56:55 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22G8lIcg016582;
        Wed, 16 Mar 2022 08:56:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3erk58q956-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 08:56:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22G8uqLQ46072200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 08:56:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15FEAA405B;
        Wed, 16 Mar 2022 08:56:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CE20A4054;
        Wed, 16 Mar 2022 08:56:49 +0000 (GMT)
Received: from [9.145.38.138] (unknown [9.145.38.138])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Mar 2022 08:56:49 +0000 (GMT)
Message-ID: <772ea26a-7133-8401-3e0d-0fef17b75638@linux.ibm.com>
Date:   Wed, 16 Mar 2022 09:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 2/4] drivers/s390/char: Add Query Ultravisor
 Information to uvdevice
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20220304141141.32767-1-seiden@linux.ibm.com>
 <20220304141141.32767-3-seiden@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220304141141.32767-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NEvx_hY3lQuHo0eKO4DHfHV_xkQcL3Nh
X-Proofpoint-GUID: I8lxpRXp_GncQffvYJkrd6r5SFdF9b3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_02,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 mlxlogscore=850 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/4/22 15:11, Steffen Eiden wrote:
> This patch enables userspace to call the Query Ultravisor Information
> Ultravisor Call using IOCTLs on the uvdevice.
> 
> The uvdevice will do some sanity checks first, build the UVCB,
> perform the UV call, and copy the result to userspace.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>


Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   arch/s390/include/uapi/asm/uvdevice.h |  2 +
>   drivers/s390/char/uvdevice.c          | 56 +++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
> index d40f69345c75..7520bdde3102 100644
> --- a/arch/s390/include/uapi/asm/uvdevice.h
> +++ b/arch/s390/include/uapi/asm/uvdevice.h
> @@ -42,10 +42,12 @@ struct uvio_attest {
>   #define UVIO_ATT_ARCB_MAX_LEN		0x100000
>   #define UVIO_ATT_MEASUREMENT_MAX_LEN	0x8000
>   #define UVIO_ATT_ADDITIONAL_MAX_LEN	0x8000
> +#define UVIO_QUI_MAX_LEN		0x8000
>   
>   #define UVIO_DEVICE_NAME "uv"
>   #define UVIO_TYPE_UVC 'u'
>   
>   #define UVIO_IOCTL_ATT _IOWR(UVIO_TYPE_UVC, 0x01, struct uvio_ioctl_cb)
> +#define UVIO_IOCTL_QUI _IOWR(UVIO_TYPE_UVC, 0x02, struct uvio_ioctl_cb)
>   
>   #endif  /* __S390X_ASM_UVDEVICE_H */
> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> index b720dc8d0bd9..cfce8c5999e6 100644
> --- a/drivers/s390/char/uvdevice.c
> +++ b/drivers/s390/char/uvdevice.c
> @@ -31,6 +31,55 @@
>   #include <asm/uvdevice.h>
>   #include <asm/uv.h>
>   
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
>   static int uvio_build_uvcb_attest(struct uv_cb_attest *uvcb_attest, u8 *arcb,
>   				  u8 *meas, u8 *add_data, struct uvio_attest *uvio_attest)
>   {
> @@ -217,6 +266,13 @@ static long uvio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   			goto out;
>   		ret = uvio_attestation(uv_ioctl);
>   		break;
> +	case UVIO_IOCTL_QUI:
> +		ret = uvio_copy_and_check_ioctl(uv_ioctl, argp);
> +		if (ret)
> +			goto out;
> +		ret = uvio_qui(uv_ioctl);
> +		break;
> +
>   	default:
>   		ret = -ENOIOCTLCMD;
>   		break;

