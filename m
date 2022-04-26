Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8350F255
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiDZH2g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 03:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiDZH2e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 03:28:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF41209C;
        Tue, 26 Apr 2022 00:25:27 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q5xrA7007366;
        Tue, 26 Apr 2022 07:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XmQl9LAmbm1c8pOJVYVX6hnXhI3LhfRUVeI1Xchrqgc=;
 b=INHcratW77FCNB+Iz+PMGV5RgSUAgjdvhvX95NW7u40oRKvJ8nSyoz876CcC5XBtP35c
 +sNZH3pY/bu/dK+7gddRe2SiJQ6vsjzYO3YG3CS7R/+b1BY/4EkpfznXv3/byb0+6hvY
 kqbrrjRJik86Yesbxx74d1zIIPEx1gQuGGOkKQiY8qA/0aGIT4ehoI4yaG5mW5XP0ljM
 QSu+zOpTIkpAUXbhYESKRLmudBbYfu3OFG+dcjv4ZqtUL1zfm2LEKiCbioecW0nZV6qK
 Xo82UJRkViD0Ke1ZZ34ADFbDQc9TZj5rsWhJ3VjkXgtR35j5irPUP8kCjWKUF4hwuGHr 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpb351g4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 07:25:24 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q7KCLH015567;
        Tue, 26 Apr 2022 07:25:23 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fpb351g45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 07:25:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q78ZA7032705;
        Tue, 26 Apr 2022 07:25:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm938utw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 07:25:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q7CHxx25428278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 07:12:17 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B430DAE051;
        Tue, 26 Apr 2022 07:25:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B72AE04D;
        Tue, 26 Apr 2022 07:25:18 +0000 (GMT)
Received: from [9.145.2.160] (unknown [9.145.2.160])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 07:25:18 +0000 (GMT)
Message-ID: <40038a9a-5647-c355-bad2-297b0a2baf4f@linux.ibm.com>
Date:   Tue, 26 Apr 2022 09:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20220425100147.1755340-1-scgl@linux.ibm.com>
 <8095d0de-dd99-0388-b1d4-e59b01dc4be0@linux.ibm.com>
 <13d0d706-abc4-3e4d-88c3-6447636fd1fd@linux.ibm.com>
 <1ccb1333-2233-8832-4102-a6c082b29108@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] Dirtying, failing memop: don't indicate
 suppression
In-Reply-To: <1ccb1333-2233-8832-4102-a6c082b29108@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CxWQHKIXYWFPA3IM7DfOIk0BHZXLyyxe
X-Proofpoint-ORIG-GUID: IqAI3TjxOm6QkxCIlzkR9-WGMzR_N-46
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 mlxlogscore=569 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260046
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/26/22 08:19, Christian Borntraeger wrote:
> 
> 
> Am 25.04.22 um 19:29 schrieb Janis Schoetterl-Glausch:
>> On 4/25/22 18:30, Christian Borntraeger wrote:
>>> Am 25.04.22 um 12:01 schrieb Janis Schoetterl-Glausch:
>>>> If a memop fails due to key checked protection, after already having
>>>> written to the guest, don't indicate suppression to the guest, as that
>>>> would imply that memory wasn't modified.
>>>>
>>>> This could be considered a fix to the code introducing storage key
>>>> support, however this is a bug in KVM only if we emulate an
>>>> instructions writing to an operand spanning multiple pages, which I
>>>> don't believe we do.
>>>>
>>>
>>> Thanks applied. I think it makes sense for 5.18 nevertheless.
>>
>> Janosch had some concerns because the protection code being 000 implies
>> that the effective address in the TEID is unpredictable.
>> Let's see if he chimes in.
> 
> z/VM does exactly the same on key protection crossing a page boundary. The
> architecture was written in a way to allow all zeros exactly for this case.
> (hypervisor emulation of key protection crossing pages).
> This is even true for ESOP-2. See Figure 3-5 or figure 3-8 (the first line)
> which allows to NOT have a valid address in the TEID for key controlled
> protection.
> 
> The only question is, do we need to change the suppression parameter in
> access_guest_with_key
> 
>    (mode != GACC_STORE) || (idx == 0)
> 
> to also check for prot != PROT_TYPE_KEYC
> ? I think we do not need this as we have checked other reasons before.

To me this measure looks like a last resort option and the POP doesn't 
state a 100% what is to be done. Some instructions can mandate 
suppression instead of termination according to the architects.

My intuition tells me that if we are in a situation where this would 
happen then we would be much better off just doing it by hand (i.e. in 
the instruction emulation code) and not letting this function decide.

So I'm not entirely sure if we're replacing something that is not 
correct with something that also won't be correct for all cases.

But to summarize this: I'm not entirely sure even after reading the POP 
for more than an hour and consulting an architect
