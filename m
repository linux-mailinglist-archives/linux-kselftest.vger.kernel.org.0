Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57B4DAD2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Mar 2022 10:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiCPJGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Mar 2022 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbiCPJGF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Mar 2022 05:06:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC351E7D;
        Wed, 16 Mar 2022 02:04:51 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22G774WW012244;
        Wed, 16 Mar 2022 09:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=l4atlXBsPk5jC8TrLGKRcWK9QDytu1hrauGyvjMYFyU=;
 b=T0uuoNMihXT8dahO/pp1JbEqE/trRwDWNePmAg7vwXziHtmMCfn2v2Vg58Umk/5pDa3D
 SyGfdn/oCSHaAvS71oy2INBFpM9SPLcmyHGYV0u1ME0eXH7P+6KgFkbtf4cnHcmJ1uVw
 WocUA+vKThuwlcG6lPgbKaw8cgHx5PrFwKDaOpFXD0LUSg+Qj8bqgJCwhub4ARQLmYSx
 vprGJY8JdcuPln22ESbcYvuWbdng6iguudUDX69Hoka5gY21dsw5I7IbJJgvP2FBPImu
 0KZHvk8twLWM2CHBsU1jVr1EwGZW0VrLBPKacIKHFdjZ8c8S9vRBA+JLxsDtgzY18FBS 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3euaysahre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 09:04:49 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22G8uB5q024366;
        Wed, 16 Mar 2022 09:04:49 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3euaysahqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 09:04:49 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22G93PFJ020227;
        Wed, 16 Mar 2022 09:04:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3erk58qa5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 09:04:46 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22G94gmM17433036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Mar 2022 09:04:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4051A4054;
        Wed, 16 Mar 2022 09:04:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 568F3A405C;
        Wed, 16 Mar 2022 09:04:42 +0000 (GMT)
Received: from [9.145.38.138] (unknown [9.145.38.138])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Mar 2022 09:04:42 +0000 (GMT)
Message-ID: <7268565b-bb34-43fa-463e-8b9bf732b721@linux.ibm.com>
Date:   Wed, 16 Mar 2022 10:04:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 0/4] s390: Ultravisor device
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
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220304141141.32767-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NqU6Q_uW8C5XA7LJogYLD2n77H-hTHOc
X-Proofpoint-ORIG-GUID: ZLQSiHcW-dkhd_asy_MjgUUZh1hb0ouw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_02,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160056
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
> This series adds an Ultravisor(UV) device letting the userspace send some
> Ultravisor calls to the UV. Currently two calls are supported.
> Query Ultravisor Information (QUI) and
> Receive Attestation Measurement (Attest[ation]).
> 
> The UV device is implemented as a miscdevice accepting only IOCTLs.
> The IOCTL cmd specifies the UV call and the IOCTL arg the request
> and response data depending on the UV call.
> The device driver writes the UV response in the ioctl argument data.
> 
> The 'uvdevice' does no checks on the request beside faulty userspace
> addresses, if sizes are in a sane range before allocating in kernel space,
> and other tests that prevent the system from corruption.
> Especially, no checks are made, that will be performed by the UV anyway
> (E.g. 'invalid command' in case of attestation on unsupported hardware).
> These errors are reported back to Userspace using the UV return code
> field.
> 
> The first two patches introduce the new device as a module configured to be
> compiled directly into the kernel (y) similar to the s390 SCLP and CHSH
> miscdevice modules. Patch 3&4 introduce Kselftests which verify error
> paths of the ioctl.

Please fixup the commit message in the first patch and then push patches 
#1 and #3 to devel so we get CI coverage.

For now I'd opt to not include the qui patches but please put them on a 
branch. They might prove to be useful at a later time.

> 
> v2->v3:
>     The main change is that QUI is now introduced after Attestation as we
>     might not want pick it. Also the Kselftest patch is splitted into
>     Attestation and QUI so that they can be picked without requiring
>     QUI support of the uvdevice.
> 
>    * dropped the Kconfig dependency
>    * reorganized the series:
>      - Patch 1 now covers the introduction of the uvdevice and Attestation
>      - Patch 2 adds QUI to uvdevice
>      - Patch 3/4 add Kselftests for Attestation and QUI
>    * fixed some nits
>    * added some comments
> 
> v1->v2:
>    * ioctl returns -ENOIOCTLCMD in case of a invalid ioctl command
>    * streamlined reserved field test
>    * default Kconfig is y instead of m
>    * improved selftest documentation
> 
> Steffen Eiden (4):
>    drivers/s390/char: Add Ultravisor io device
>    drivers/s390/char: Add Query Ultravisor Information to uvdevice
>    selftests: drivers/s390x: Add uvdevice tests
>    selftests: drivers/s390x: Add uvdevice  QUI tests
> 
>   MAINTAINERS                                   |   3 +
>   arch/s390/include/asm/uv.h                    |  23 +-
>   arch/s390/include/uapi/asm/uvdevice.h         |  53 +++
>   drivers/s390/char/Kconfig                     |  10 +
>   drivers/s390/char/Makefile                    |   1 +
>   drivers/s390/char/uvdevice.c                  | 320 ++++++++++++++++++
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/drivers/.gitignore    |   1 +
>   .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
>   .../selftests/drivers/s390x/uvdevice/config   |   1 +
>   .../drivers/s390x/uvdevice/test_uvdevice.c    | 281 +++++++++++++++
>   11 files changed, 715 insertions(+), 1 deletion(-)
>   create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
>   create mode 100644 drivers/s390/char/uvdevice.c
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
>   create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c
> 

