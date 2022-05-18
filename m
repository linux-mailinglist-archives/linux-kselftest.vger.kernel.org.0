Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F352BD1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 16:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiERNuL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbiERNuL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 09:50:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3941A6AFE;
        Wed, 18 May 2022 06:50:09 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IDPqYx030026;
        Wed, 18 May 2022 13:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dWMpcf1fFhGeG5K+GHkTA+8dPHcZ8xFCl+mlQGZSnSc=;
 b=KopzyziubJGRRHKGUQaUgJ7L4nuVh6heou5PGcXgCKj5tDd7phRfaxaZVKU/L0feY1LK
 QVrPi0KN4W0EJ53nPiY7WIH0fBOxp+ndYEhA6jOPBuJJRL+/YKgJGySLNPZqrvDuaZBB
 uISQ+Hb8Mshu4aKhgpp/m/1SjNEIDcp+p4gwSodAcrDCewVGA2Y0T8xHQjGAXFI0Ouwn
 V3G7zMq2TwP/hjoafT3kgBTPFLVNqA1xSZo8iW6nyvcjb/k64HLkX0mTuAe6OoSD45Tw
 1D5PP+9F0VjWagfVrpaciqPTYwm4UEeJAq1XavzsSoAkpJqXUHHR0OnD2hjRYD7IR2Rq mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g51p6gk26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:50:03 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IDbxVh027515;
        Wed, 18 May 2022 13:50:03 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g51p6gk11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:50:03 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IDmA7h008671;
        Wed, 18 May 2022 13:50:01 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3g2428vp8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 13:50:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IDnw3459179384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 13:49:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ED0311C04A;
        Wed, 18 May 2022 13:49:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A01C911C04C;
        Wed, 18 May 2022 13:49:57 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 13:49:57 +0000 (GMT)
Message-ID: <7d87d5c9-2d16-7574-3c08-04dbfb58d943@linux.ibm.com>
Date:   Wed, 18 May 2022 15:49:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 1/2] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Greg KH <greg@kroah.com>,
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
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <48550162-0f8c-4b23-dea4-b9060b24eed9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4PXw9WdJfBOhROzPURaz9QOHPsUWR84b
X-Proofpoint-ORIG-GUID: R9WD7trTZ3m1yyULm_c3UQfDCYvGFXQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_04,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205180079
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/18/22 15:45, Janosch Frank wrote:
> On 5/18/22 13:47, Heiko Carstens wrote:
>> On Tue, May 10, 2022 at 02:47:23PM +0000, Steffen Eiden wrote:
>>> diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
>>> index 6cc4b19acf85..e9b9902abbaf 100644
>>> --- a/drivers/s390/char/Kconfig
>>> +++ b/drivers/s390/char/Kconfig
>>> @@ -100,6 +100,16 @@ config SCLP_OFB
>>>         This option enables the Open-for-Business interface to the s390
>>>         Service Element.
>>> +config S390_UV_UAPI
>>> +    def_tristate y
>>> +    prompt "Ultravisor userspace API"
>>> +    help
>>> +      Selecting exposes parts of the UV interface to userspace
>>> +      by providing a misc character device at /dev/uv.
>>> +      Using IOCTLs one can interact with the UV.
>>> +      The device is only available if the Ultravisor
>>> +      Facility (158) is present.
>>
>> Is there a reason why this is default "y"? If you think this should be
>> compiled into the kernel if used, then why allow to make it a module
>> at all?
>> Instead you could get rid of a couple if lines of code.
> 
> There was a lot of discussion around this already and the "Y" was chosen 
> as auto-loading this is a pain and therefore the SCLP and CHSC-Misc set 
> it to Y and we took that as an example (Steffen spoke to Peter to get 
> guidance).
> 
> I'm sure that we want the possibility to have this as a module. 
> Personally I'd choose "m" over "y" since the module is only useful for a 
> very small amount of users.

I am fine with changing "y" to "m".

Steffen

