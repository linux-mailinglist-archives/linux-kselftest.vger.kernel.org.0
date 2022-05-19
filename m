Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D67752CF1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 May 2022 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiESJOH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 May 2022 05:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiESJOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 May 2022 05:14:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211FE66C88;
        Thu, 19 May 2022 02:14:05 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24J8iBC2020689;
        Thu, 19 May 2022 09:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vsmhm2iQHAeBFjQNOZ4SFi//Q3iMdcSt0ZyyzhrEM9g=;
 b=o8tq4/kuQFP4HltuuwdGNDciYYQuDr/zpTnqyurT1HizhX6MRRgZ3Ldec6c9tsYRSRpe
 gOl/EaBybc/15mBprso+uoBuwkRQGddfzI7xWB3gLiFqQiwAZhSX3quZPul87fG3O5pW
 PtZQ+KkFZLOmi1XcQ05YuC58ZwtmuCNwSc6U0rOTv9+pxzoXGaxFcQ/8Lu8TF3NJ5lwH
 ivTY+BNT22Iu7kL/UDrOfKfCANp4q2kmz3dJ88BT9CGT/eqZPjTonpNuGGcgOybuPwBn
 dotCwal3hDS18MQmMmjlA+dwjhiyRTjA7o1MJlk3QYeSLbAIJwQgoPY3D+miSUDmhmac yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5ja216d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:14:00 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24J8TDis022436;
        Thu, 19 May 2022 09:14:00 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5ja216ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:14:00 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24J9DYJH026733;
        Thu, 19 May 2022 09:13:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3g2428wp0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 09:13:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24J9009r46399830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 May 2022 09:00:00 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C77A55204E;
        Thu, 19 May 2022 09:13:54 +0000 (GMT)
Received: from [9.152.224.243] (unknown [9.152.224.243])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6605D52059;
        Thu, 19 May 2022 09:13:54 +0000 (GMT)
Message-ID: <9666c15f-a824-0c8e-508d-57d1da147fff@linux.ibm.com>
Date:   Thu, 19 May 2022 11:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Steffen Eiden <seiden@linux.ibm.com>, Greg KH <greg@kroah.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
References: <20220510144724.3321985-1-seiden@linux.ibm.com>
 <20220510144724.3321985-2-seiden@linux.ibm.com> <YoTcxhulemnqiUbC@osiris>
 <48550162-0f8c-4b23-dea4-b9060b24eed9@linux.ibm.com>
 <YoXXjC49xKY/TJ+2@osiris>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <YoXXjC49xKY/TJ+2@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V7QkVM9P7-igVUwVQ4chEEwn1CMV0EG0
X-Proofpoint-GUID: mJriKk9jQArH-1P7CpW_LE3zk6ejvPRs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_01,2022-05-19_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=967 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205190053
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/19/22 07:37, Heiko Carstens wrote:
> On Wed, May 18, 2022 at 03:45:27PM +0200, Janosch Frank wrote:
>>>> +	  The device is only available if the Ultravisor
>>>> +	  Facility (158) is present.
>>>
>>> Is there a reason why this is default "y"? If you think this should be
>>> compiled into the kernel if used, then why allow to make it a module
>>> at all?
>>> Instead you could get rid of a couple if lines of code.
>>
>> There was a lot of discussion around this already and the "Y" was chosen as
>> auto-loading this is a pain and therefore the SCLP and CHSC-Misc set it to Y
>> and we took that as an example (Steffen spoke to Peter to get guidance).
>>
>> I'm sure that we want the possibility to have this as a module. Personally
>> I'd choose "m" over "y" since the module is only useful for a very small
>> amount of users.
> 
> Why not simply use module_cpu_feature_match() to implement auto module
> loading like we do it for the crypto modules? That would require that
> either the uv facility is represented within elf hwcaps, or
> alternatively the s390 implementation of cpu_feature() needs to be
> changed to work with cpu facilities instead of hwcap bits.
> (see arch/s390/include/asm/cpufeature.h)
> 
> This doesn't look too difficult. Or was there a reason not to go this route?

I'd guess we looked into the wrong direction for auto-load.

We'll look into that for 5.20 but we'll take this patch with the "m" 
tristate for 5.19.

Thanks for the pointer and review.
