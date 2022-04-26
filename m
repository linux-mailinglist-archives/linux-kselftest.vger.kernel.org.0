Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8980550F0DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Apr 2022 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245088AbiDZGXL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Apr 2022 02:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiDZGXK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Apr 2022 02:23:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37F055BF;
        Mon, 25 Apr 2022 23:20:03 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q5HWFs029832;
        Tue, 26 Apr 2022 06:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UqRGLC6DMwrnIxvnxBlIJqoItPrKRPj+Q1itnANNIzw=;
 b=nr8was6CRZvFAPtJ/GetW3yIy3MkOnPtVYYlkxUa79w9yCnUmjI76aNW1I696CS5ov4n
 vKMjVfloL94CMptfTPsk0gTl1OzQwEMZ9JHZjTEpCOFaHk0UhGImRprXg0ATZ0DeTa6W
 CXKuR3TpNYGTe8g9ufkigMV4moBm34h+diwOIYzH9uG6UL2qyysCdk/FE7ytGsrfACp0
 NE+vr98K3SccUjD0SjzsfV4O4vp+n3FfVzEnQZ2UD+89y8kGNyG/W5cawjs3vBzk7kou
 zYJdo+OLeoBzJDMyqTPoBdlWDeqKd7rsIz0Zuv+sEw5mDNM3l3jUydveVYHp/rRjRFQl VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp6k9cpka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:20:00 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23Q6JxWi009914;
        Tue, 26 Apr 2022 06:19:59 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp6k9cpjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:19:59 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q6COhU029626;
        Tue, 26 Apr 2022 06:19:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3fm938unk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 06:19:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23Q6JssG58524144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 06:19:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9D694C046;
        Tue, 26 Apr 2022 06:19:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AC404C040;
        Tue, 26 Apr 2022 06:19:54 +0000 (GMT)
Received: from [9.171.16.5] (unknown [9.171.16.5])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Apr 2022 06:19:54 +0000 (GMT)
Message-ID: <1ccb1333-2233-8832-4102-a6c082b29108@linux.ibm.com>
Date:   Tue, 26 Apr 2022 08:19:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/2] Dirtying, failing memop: don't indicate
 suppression
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
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
 <13d0d706-abc4-3e4d-88c3-6447636fd1fd@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <13d0d706-abc4-3e4d-88c3-6447636fd1fd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZvCISHOvZJpvSVKFUxy2vXGmM8YgKKS6
X-Proofpoint-ORIG-GUID: tpFYGwXvD6iQMF3LChEb-_hroWSPeo4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=724 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260040
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Am 25.04.22 um 19:29 schrieb Janis Schoetterl-Glausch:
> On 4/25/22 18:30, Christian Borntraeger wrote:
>> Am 25.04.22 um 12:01 schrieb Janis Schoetterl-Glausch:
>>> If a memop fails due to key checked protection, after already having
>>> written to the guest, don't indicate suppression to the guest, as that
>>> would imply that memory wasn't modified.
>>>
>>> This could be considered a fix to the code introducing storage key
>>> support, however this is a bug in KVM only if we emulate an
>>> instructions writing to an operand spanning multiple pages, which I
>>> don't believe we do.
>>>
>>
>> Thanks applied. I think it makes sense for 5.18 nevertheless.
> 
> Janosch had some concerns because the protection code being 000 implies
> that the effective address in the TEID is unpredictable.
> Let's see if he chimes in.

z/VM does exactly the same on key protection crossing a page boundary. The
architecture was written in a way to allow all zeros exactly for this case.
(hypervisor emulation of key protection crossing pages).
This is even true for ESOP-2. See Figure 3-5 or figure 3-8 (the first line)
which allows to NOT have a valid address in the TEID for key controlled
protection.

The only question is, do we need to change the suppression parameter in
access_guest_with_key

  (mode != GACC_STORE) || (idx == 0)

to also check for prot != PROT_TYPE_KEYC
? I think we do not need this as we have checked other reasons before.
