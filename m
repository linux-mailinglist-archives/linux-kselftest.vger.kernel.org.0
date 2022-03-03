Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE75A4CC03A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Mar 2022 15:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiCCOpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Mar 2022 09:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCCOpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Mar 2022 09:45:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E4818A793;
        Thu,  3 Mar 2022 06:45:05 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EYTi8025418;
        Thu, 3 Mar 2022 14:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pQYBsApat6w5t4juKjeOyNc/w3r4DzuAaqqsLki6rl8=;
 b=pFgyeZrwUImNThsvoFWu9HgSih3gf209DLosB2GGlH9gdefVJhwH0tfWMKMkM4M9etDp
 CZ/4fjDA2d5HVmpVUWpD2xXDVK8kEbFUHj+IUsxx9Pj9ISQlsFDjT4J4d8aKa+tCt6sL
 ufoONsyvIwecdWCT11ezL7aifxaTSgxIsKPRf49H4S9Q0er1KOgi791gt49rCW544yVV
 /dmJD4Bht6pQgq01elWYYjp5mQedFTHSsyaREvNCBKBYF4ZLSY/A3h2D0nurs6NJfpw2
 hn2Bso/5p1xePLAtVAmY0jFEug+bDCw5vTb8oyM74PI0TDsIkCRo1Lf1Q+zhdcod5yE9 rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejnp24kbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:45:02 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 223EYZwK026058;
        Thu, 3 Mar 2022 14:45:02 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejnp24kay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:45:01 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 223EcsqD028221;
        Thu, 3 Mar 2022 14:45:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3efbfj8ff2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:45:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 223EitvG48365870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 14:44:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EB135204F;
        Thu,  3 Mar 2022 14:44:55 +0000 (GMT)
Received: from [9.145.163.13] (unknown [9.145.163.13])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1B9E352052;
        Thu,  3 Mar 2022 14:44:55 +0000 (GMT)
Message-ID: <a79c2de5-8617-7c19-8a40-38ba9fc848ca@linux.ibm.com>
Date:   Thu, 3 Mar 2022 15:44:54 +0100
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
 <20220223144830.44039-3-seiden@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] drivers/s390/char: Add Ultravisor attestation to
 uvdevice
In-Reply-To: <20220223144830.44039-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0XQIzBrH7kILXznSKAV4FAD2JCVceaUS
X-Proofpoint-GUID: z29sDAARJQGXqPsz-N9q6LeiXZWFJC_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203030069
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
> This patch enables userspace to call the Retrieve Attestation Measurement
> Ultravisor Call using IOCTLs on the uvdevice.
> 
> The uvdevice will do some sanity checks first.
> Then, copy the request data to kernel space, build the uvcb,
> perform the UV call, and copy the result back to userspace.
> 
> Userspace is now able to call the Retrieve Attestation Measurement
> Ultravisor Call through the uvdevice.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/uv.h            |  23 +++-
>   arch/s390/include/uapi/asm/uvdevice.h |  19 +++
>   drivers/s390/char/uvdevice.c          | 163 ++++++++++++++++++++++++++
>   3 files changed, 204 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
> index 86218382d29c..760dda4024b9 100644
> --- a/arch/s390/include/asm/uv.h
> +++ b/arch/s390/include/asm/uv.h
> @@ -2,7 +2,7 @@
>   /*
>    * Ultravisor Interfaces
>    *
> - * Copyright IBM Corp. 2019
> + * Copyright IBM Corp. 2019, 2022
>    *
>    * Author(s):
>    *	Vasily Gorbik <gor@linux.ibm.com>
> @@ -52,6 +52,7 @@
>   #define UVC_CMD_UNPIN_PAGE_SHARED	0x0342
>   #define UVC_CMD_SET_SHARED_ACCESS	0x1000
>   #define UVC_CMD_REMOVE_SHARED_ACCESS	0x1001
> +#define UVC_CMD_RETR_ATTEST		0x1020
>   
>   /* Bits in installed uv calls */
>   enum uv_cmds_inst {
> @@ -76,6 +77,7 @@ enum uv_cmds_inst {
>   	BIT_UVC_CMD_UNSHARE_ALL = 20,
>   	BIT_UVC_CMD_PIN_PAGE_SHARED = 21,
>   	BIT_UVC_CMD_UNPIN_PAGE_SHARED = 22,
> +	BIT_UVC_CMD_RETR_ATTEST = 28,
>   };
>   
>   enum uv_feat_ind {
> @@ -218,6 +220,25 @@ struct uv_cb_share {
>   	u64 reserved28;
>   } __packed __aligned(8);
>   
> +/* Retrieve Attestation Measurement */
> +struct uv_cb_attest {
> +	struct uv_cb_header header;	/* 0x0000 */
> +	u64 reserved08[2];		/* 0x0008 */
> +	u64 arcb_addr;			/* 0x0018 */
> +	u64 cont_token;			/* 0x0020 */
> +	u8  reserved28[6];		/* 0x0028 */
> +	u16 user_data_len;		/* 0x002e */
> +	u8  user_data[256];		/* 0x0030 */
> +	u32 reserved130[3];		/* 0x0130 */
> +	u32 meas_len;			/* 0x013c */
> +	u64 meas_addr;			/* 0x0140 */
> +	u8  config_uid[16];		/* 0x0148 */
> +	u32 reserved158;		/* 0x0158 */
> +	u32 add_data_len;		/* 0x015c */
> +	u64 add_data_addr;		/* 0x0160 */
> +	u64 reserved168[4];		/* 0x0168 */
> +} __packed __aligned(8);
> +
>   static inline int __uv_call(unsigned long r1, unsigned long r2)
>   {
>   	int cc;
> diff --git a/arch/s390/include/uapi/asm/uvdevice.h b/arch/s390/include/uapi/asm/uvdevice.h
> index 60956f8d2dc0..2bab1063a82e 100644
> --- a/arch/s390/include/uapi/asm/uvdevice.h
> +++ b/arch/s390/include/uapi/asm/uvdevice.h
> @@ -17,11 +17,30 @@ struct uvio_ioctl_cb {
>   	__u8  reserved14[0x40 - 0x14];	/* must be zero */
>   };
>   
> +#define UVIO_ATT_USER_DATA_LEN		0x100
> +#define UVIO_ATT_UID_LEN		0x10
> +struct uvio_attest {
> +	__u64 arcb_addr;				/* 0x0000 */
> +	__u64 meas_addr;				/* 0x0008 */
> +	__u64 add_data_addr;				/* 0x0010 */
> +	__u8  user_data[UVIO_ATT_USER_DATA_LEN];	/* 0x0018 */
> +	__u8  config_uid[UVIO_ATT_UID_LEN];		/* 0x0118 */
> +	__u32 arcb_len;					/* 0x0128 */
> +	__u32 meas_len;					/* 0x012c */
> +	__u32 add_data_len;				/* 0x0130 */
> +	__u16 user_data_len;				/* 0x0134 */
> +	__u16 reserved136;				/* 0x0136 */
> +};
> +
>   #define UVIO_QUI_MAX_LEN		0x8000
> +#define UVIO_ATT_ARCB_MAX_LEN		0x100000
> +#define UVIO_ATT_MEASUREMENT_MAX_LEN	0x8000
> +#define UVIO_ATT_ADDITIONAL_MAX_LEN	0x8000
>   
>   #define UVIO_DEVICE_NAME "uv"
>   #define UVIO_TYPE_UVC 'u'
>   
>   #define UVIO_IOCTL_QUI _IOWR(UVIO_TYPE_UVC, 0x01, struct uvio_ioctl_cb)
> +#define UVIO_IOCTL_ATT _IOWR(UVIO_TYPE_UVC, 0x02, struct uvio_ioctl_cb)
>   
>   #endif  /* __S390X_ASM_UVDEVICE_H */
> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> index 1d90e129b570..5a9830d2d299 100644
> --- a/drivers/s390/char/uvdevice.c
> +++ b/drivers/s390/char/uvdevice.c
> @@ -65,6 +65,163 @@ static int uvio_qui(struct uvio_ioctl_cb *uv_ioctl)
>   	return ret;
>   }
>   
> +/* Create Attestation Measurement functions */
> +
> +static int uvio_build_uvcb_attest(struct uv_cb_attest *uvcb_attest, u8 *arcb,
> +				  u8 *meas, u8 *add_data, struct uvio_attest *uvio_attest)
> +{
> +	void __user *user_buf_arcb = (void __user *)uvio_attest->arcb_addr;
> +
> +	if (copy_from_user(arcb, user_buf_arcb, uvio_attest->arcb_len))
> +		return -EFAULT;
> +
> +	uvcb_attest->header.len = sizeof(struct uv_cb_attest);

sizeof(*uvcb_attest)

> +	uvcb_attest->header.cmd = UVC_CMD_RETR_ATTEST;
> +	uvcb_attest->arcb_addr = (u64)arcb;
> +	uvcb_attest->cont_token = 0;
> +	uvcb_attest->user_data_len = uvio_attest->user_data_len;
> +	memcpy(uvcb_attest->user_data, uvio_attest->user_data, sizeof(uvcb_attest->user_data));
> +	uvcb_attest->meas_len = uvio_attest->meas_len;
> +	uvcb_attest->meas_addr = (u64)meas;
> +	uvcb_attest->add_data_len = uvio_attest->add_data_len;
> +	uvcb_attest->add_data_addr = (u64)add_data;
> +
> +	return 0;
> +}
> +
> +static int uvio_copy_attest_result_to_user(struct uv_cb_attest *uvcb_attest,
> +					   struct uvio_ioctl_cb *uv_ioctl,
> +					   u8 *measurement, u8 *add_data,
> +					   struct uvio_attest *uvio_attest)
> +{
> +	struct uvio_attest __user *user_uvio_attest = (void __user *)uv_ioctl->argument_addr;
> +	void __user *user_buf_add = (void __user *)uvio_attest->add_data_addr;
> +	void __user *user_buf_meas = (void __user *)uvio_attest->meas_addr;
> +	void __user *user_buf_uid = &user_uvio_attest->config_uid;
> +
> +	if (copy_to_user(user_buf_meas, measurement, uvio_attest->meas_len))
> +		return -EFAULT;
> +	if (add_data && copy_to_user(user_buf_add, add_data, uvio_attest->add_data_len))
> +		return -EFAULT;
> +	if (copy_to_user(user_buf_uid, uvcb_attest->config_uid, sizeof(uvcb_attest->config_uid)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static int get_uvio_attest(struct uvio_ioctl_cb *uv_ioctl, struct uvio_attest *uvio_attest)
> +{
> +	u8 __user *user_arg_buf = (u8 __user *)uv_ioctl->argument_addr;
> +
> +	if (copy_from_user(uvio_attest, user_arg_buf, sizeof(*uvio_attest)))
> +		return -EFAULT;
> +
> +	if (uvio_attest->arcb_len > UVIO_ATT_ARCB_MAX_LEN)
> +		return -EINVAL;
> +	if (uvio_attest->arcb_len == 0)
> +		return -EINVAL;
> +	if (uvio_attest->meas_len > UVIO_ATT_MEASUREMENT_MAX_LEN)
> +		return -EINVAL;
> +	if (uvio_attest->meas_len == 0)
> +		return -EINVAL;
> +	if (uvio_attest->add_data_len > UVIO_ATT_ADDITIONAL_MAX_LEN)
> +		return -EINVAL;
> +	if (uvio_attest->reserved136)
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +/**
> + * uvio_attestation() - Perform a Retrieve Attestation Measurement UVC.
> + *
> + * uv_ioctl: ioctl control block
> + *
> + * uvio_attestation() does a  Retrieve Attestation Measurement Ultravisor Call.
> + * It verifies that the given userspace addresses are valid and request sizes
> + * are sane. Every other check is made by the Ultravisor (UV) and won't result
> + * in a negative return value. It copies the input to kernelspace, builds the
> + * request, sends the UV-call, and copies the result to userspace.
> + *
> + * The Attestation Request has two input and two outputs.
> + * ARCB and User Data are inputs for the UV generated by userspace.
> + * Measurement and Additional Data are outputs for userspace generated by UV.
> + *
> + * The Attestation Request Control Block (ARCB) is a cryptographically verified
> + * and secured request to UV and User Data is some plaintext data which is
> + * going to be included in the Attestation Measurement calculation.
> + *
> + * Measurement is a cryptographic measurement of the callers properties,
> + * optional data configured by the ARCB and the user data. If specified by the
> + * ARCB, UV will add some Additional Data to the measurement calculation.
> + * This Additional Data is then returned as well.
> + *
> + * If the Retrieve Attestation Measurement UV facility is not present,
> + * UV will return invalid command rc. This won't be fenced in the driver
> + * and does not result in a negative return value.
> + *
> + * Context: might sleep
> + *
> + * Return: 0 on success or a negative error code on error.
> + */
> +static int uvio_attestation(struct uvio_ioctl_cb *uv_ioctl)
> +{
> +	struct uv_cb_attest *uvcb_attest = NULL;
> +	struct uvio_attest *uvio_attest = NULL;
> +	u8 *measurement = NULL;
> +	u8 *add_data = NULL;
> +	u8 *arcb = NULL;
> +	int ret;
> +
> +	ret = -EINVAL;
> +	if (uv_ioctl->argument_len != sizeof(*uvio_attest))
> +		goto out;
> +
> +	ret = -ENOMEM;
> +	uvio_attest = kzalloc(sizeof(*uvio_attest), GFP_KERNEL);
> +	if (!uvio_attest)
> +		goto out;
> +
> +	ret = get_uvio_attest(uv_ioctl, uvio_attest);
> +	if (ret)
> +		goto out;
> +
> +	ret = -ENOMEM;
> +	arcb = kvzalloc(uvio_attest->arcb_len, GFP_KERNEL);
> +	measurement = kvzalloc(uvio_attest->meas_len, GFP_KERNEL);
> +	if (!arcb || !measurement)
> +		goto out;
> +
> +	if (uvio_attest->add_data_len) {
> +		ret = -ENOMEM;

The lines above didn't change ret

> +		add_data = kvzalloc(uvio_attest->add_data_len, GFP_KERNEL);
> +		if (!add_data)
> +			goto out;
> +	}
> +
> +	ret = -ENOMEM;

The lines above didn't change ret


With the nits fixed:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
