Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C993529CAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbiEQIiy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 May 2022 04:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiEQIiv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 May 2022 04:38:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102C43AE3;
        Tue, 17 May 2022 01:38:50 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24H8DOhR028628;
        Tue, 17 May 2022 08:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=D+GhBB0E/wAZK8YXdh6KmBxD6w1txXvNGrzF9TuYaik=;
 b=Z/5JS5xRoSL0aq/ar4f/bGGm8bt6Lir2Ygge1c4Zr78+JldRpqVIQzovqFYfjGPvKaqg
 4NQq8hm958Bh2pIFYdLMB9AuFJ4gLJnpy7zuxnNr/lVevLoqXKTfRSHiJWMxvSiVMPZ9
 WZMxyR7Xr6q3y75RBH2z6wegsFZmwFa2JLykhxKv5F/RGvJqoyrVgcSrFI6qbO8EtbIQ
 uLyvEOrYnl7eN+EZs7ebXOwP4hykd8mfEB2tnAUWrVSMGek9WC31kS0aqtzIgUJ7nQBa
 zNwtsdvFi62UNtsRdop2qcOoFGjs6TEh2jPyjEk7vWlq86vOZtVKsQXpevwfNspYerHC Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g480fghsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:38:45 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24H8DqER029695;
        Tue, 17 May 2022 08:38:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g480fghrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:38:44 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24H8bvXa027381;
        Tue, 17 May 2022 08:38:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3g23pjbvu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 08:38:42 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24H8cdM118809302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 May 2022 08:38:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71769A404D;
        Tue, 17 May 2022 08:38:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0475A4053;
        Tue, 17 May 2022 08:38:38 +0000 (GMT)
Received: from [9.145.157.61] (unknown [9.145.157.61])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 May 2022 08:38:38 +0000 (GMT)
Message-ID: <bae6b9f0-dd4d-f109-b220-f6b118c889ad@linux.ibm.com>
Date:   Tue, 17 May 2022 10:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
To:     Steffen Eiden <seiden@linux.ibm.com>, Greg KH <greg@kroah.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
 <20220510144724.3321985-2-seiden@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220510144724.3321985-2-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IvePSA45A9JdpwUE2QI7mL7_ws8NBJoo
X-Proofpoint-GUID: eMf4ulNRCT_R6hvh_c7skZQMk-Knyiwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_01,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205170051
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 16:47, Steffen Eiden wrote:
> This patch adds a new miscdevice to expose some Ultravisor functions
> to userspace. Userspace can send IOCTLs to the uvdevice that will then
> emit a corresponding Ultravisor Call and hands the result over to
> userspace. The uvdevice is available if the Ultravisor Call facility is
> present.
> Userspace can call the Retrieve Attestation Measurement
> Ultravisor Call using IOCTLs on the uvdevice.
> 
> The uvdevice will do some sanity checks first.
> Then, copy the request data to kernel space, build the UVCB,
> perform the UV call, and copy the result back to userspace.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

I'd like to pick this if I'm allowed to fix the two white space problems 
below.

> ---
>   MAINTAINERS                           |   2 +
>   arch/s390/include/asm/uv.h            |  23 ++-
>   arch/s390/include/uapi/asm/uvdevice.h |  51 +++++
>   drivers/s390/char/Kconfig             |  10 +
>   drivers/s390/char/Makefile            |   1 +
>   drivers/s390/char/uvdevice.c          | 264 ++++++++++++++++++++++++++
>   6 files changed, 350 insertions(+), 1 deletion(-)
>   create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
>   create mode 100644 drivers/s390/char/uvdevice.c
> 

> +#endif  /* __S390_ASM_UVDEVICE_H */

There are two spaces between the "endif" and the "/"

> diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
> index 6cc4b19acf85..e9b9902abbaf 100644
> --- a/drivers/s390/char/Kconfig
> +++ b/drivers/s390/char/Kconfig
> @@ -100,6 +100,16 @@ config SCLP_OFB
>   	  This option enables the Open-for-Business interface to the s390
>   	  Service Element.
>   
[...]
> + * uvio_attestation() does a  Retrieve Attestation Measurement Ultravisor Call.

Double space

> + * It verifies that the given userspace addresses are valid and request sizes
> + * are sane. Every other check is made by the Ultravisor (UV) and won't result
> + * in a negative return value. It copies the input to kernelspace, builds the
> + * request, sends the UV-call, and copies the result to userspace.
> + *

