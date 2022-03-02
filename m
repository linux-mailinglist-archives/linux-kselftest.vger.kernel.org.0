Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449734CA26D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Mar 2022 11:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiCBKrd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Mar 2022 05:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiCBKrc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Mar 2022 05:47:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9CBECD9;
        Wed,  2 Mar 2022 02:46:49 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2229rrsd007841;
        Wed, 2 Mar 2022 10:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R/c1L+XnDZeU+pqemOA1d/0xhmMdRl79pBFJwINA7Ug=;
 b=hp8phhNnrxPiX6zTkoOec+aEfuIurokLmT02O2qMiPl8Ziu70z6GyFKJNmZlJmV3v3X6
 WAQOssFql09Ou9V5BTsxzq6AsmqvXVgoqCKmSyNAzisWlYoK3vhWCOkRM6TxRFbraywm
 HibgvDw66vO8hsnf0p22TeXVyuai3nn1AIm8lDOnoasCAUs7N4Bx7X8T89MccLsV9TRG
 d6/phmHO0J5KkSGClzIHyCjn/HG3K91BJeJnPx/bEN8rg9Y3Kx3Wj58FTur1LTpYjYR5
 5yACrPGG/BMqkhchcIJGYT3RH4ryFOyJrY05sMgVKn21UyimNOAXr7D2G2iPEyK1OTlz UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej6bt0yf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:46:47 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222AQI9M035647;
        Wed, 2 Mar 2022 10:46:46 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej6bt0yeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:46:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222AgdBD001503;
        Wed, 2 Mar 2022 10:46:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3efbu9edbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 10:46:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222Akc7M52429234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 10:46:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB2C9A404D;
        Wed,  2 Mar 2022 10:46:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56A92A4040;
        Wed,  2 Mar 2022 10:46:38 +0000 (GMT)
Received: from [9.145.41.193] (unknown [9.145.41.193])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 10:46:38 +0000 (GMT)
Message-ID: <3bf9c7c4-4475-ad12-d146-a97b33d1e4ba@linux.ibm.com>
Date:   Wed, 2 Mar 2022 11:46:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/3] drivers/s390/char: Add Ultravisor io device
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org
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
 <7058948f-5514-4f8f-c974-f1ac624d67c3@linux.ibm.com>
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <7058948f-5514-4f8f-c974-f1ac624d67c3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R4lSi8PuL08S3V5pOrTWqVLz_RM67ugJ
X-Proofpoint-ORIG-GUID: W8UryUt5yXhPz5sBjhTtd8XoOKiTBPNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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



On 3/2/22 11:34, Janosch Frank wrote:
> On 2/23/22 15:48, Steffen Eiden wrote:
>> This patch adds a new miscdevice to expose some Ultravisor functions
>> to userspace. Userspace can send IOCTLs to the uvdevice that will then
>> emit a corresponding Ultravisor Call and hands the result over to
>> userspace. The uvdevice is available if the Ultravisor Call facility is
>> present.
>>
>> Userspace is now able to call the Query Ultravisor Information
>> Ultravisor Command through the uvdevice.
>>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> ---
[...]
>> +
>> +config S390_UV_UAPI
>> +    def_tristate y
>> +    prompt "Ultravisor userspace API"
>> +    depends on PROTECTED_VIRTUALIZATION_GUEST
> 
> Please drop the dependency.
> We want this to be available to both guest and host as QUI is available 
> in both environments and more calls like this could follow.
> 
> We could put an option around the attestation but the savings are not 
> worth the effort.

Makes sense. I will drop the dependency in v3.

Steffen
