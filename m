Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C0B50E750
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 19:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbiDYRce (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 13:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244035AbiDYRcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 13:32:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA48C13;
        Mon, 25 Apr 2022 10:29:26 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PEi3wm010252;
        Mon, 25 Apr 2022 17:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=N0FdWIrseGzC8YyI83oVDNXfI2pKptqK1F8lrNfRxC8=;
 b=eVLgFZgy5ODeXwQi/DvL9VEkt9tmujPkq6f8T+itF2W3fuMfg393We6Nz8mYTanWBu4Y
 Z+8qPBNZ8X329UOMSFDAtjwcEsxNyu9IWFgsrxGPnMXB49aE7t9mD9pVifZYaJyLxs4R
 /5wHOCYMtO+0ToYIcxdZTqGBUSRS/62Nf9EbNI69+REEog/X7S37vp+DYQUwzhiDJvkU
 NlgW7Fd7P76oo+CW9wCeaFVOlMTNuOmvP2vENdm0dt8VC7ijQnaYO2AbgEr1nW4Py1i4
 jIJqJOlgY8KgmbzqiPC5BGgLF6o2TMoj8xYbGa35xH0boVKgmGa+19zpWqhWm2zPvyYp xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnwng3yjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 17:29:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PGqWLb019269;
        Mon, 25 Apr 2022 17:29:23 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnwng3yhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 17:29:22 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PHTDqp027136;
        Mon, 25 Apr 2022 17:29:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938tqnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 17:29:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PHTUuk12452370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 17:29:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6A45AE045;
        Mon, 25 Apr 2022 17:29:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ACB4AE04D;
        Mon, 25 Apr 2022 17:29:17 +0000 (GMT)
Received: from [9.171.38.55] (unknown [9.171.38.55])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 17:29:17 +0000 (GMT)
Message-ID: <13d0d706-abc4-3e4d-88c3-6447636fd1fd@linux.ibm.com>
Date:   Mon, 25 Apr 2022 19:29:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] Dirtying, failing memop: don't indicate
 suppression
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
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
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <8095d0de-dd99-0388-b1d4-e59b01dc4be0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZkwzIZly1vuuNPivtdv1igWVwga-Mhr3
X-Proofpoint-ORIG-GUID: 7Fiwm8QBpGHHlEky2A7xZEoSpjPTUcbd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_09,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=962 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250076
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/25/22 18:30, Christian Borntraeger wrote:
> Am 25.04.22 um 12:01 schrieb Janis Schoetterl-Glausch:
>> If a memop fails due to key checked protection, after already having
>> written to the guest, don't indicate suppression to the guest, as that
>> would imply that memory wasn't modified.
>>
>> This could be considered a fix to the code introducing storage key
>> support, however this is a bug in KVM only if we emulate an
>> instructions writing to an operand spanning multiple pages, which I
>> don't believe we do.
>>
> 
> Thanks applied. I think it makes sense for 5.18 nevertheless.

Janosch had some concerns because the protection code being 000 implies
that the effective address in the TEID is unpredictable.
Let's see if he chimes in.

> 
>> v1 -> v2
>>   * Reword commit message of patch 1
>>
>> Janis Schoetterl-Glausch (2):
>>    KVM: s390: Don't indicate suppression on dirtying, failing memop
>>    KVM: s390: selftest: Test suppression indication on key prot exception
>>
>>   arch/s390/kvm/gaccess.c                   | 47 ++++++++++++++---------
>>   tools/testing/selftests/kvm/s390x/memop.c | 43 ++++++++++++++++++++-
>>   2 files changed, 70 insertions(+), 20 deletions(-)
>>
>>
>> base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
> 

