Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBA50E5DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 18:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiDYQdl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiDYQdk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 12:33:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092051FA58;
        Mon, 25 Apr 2022 09:30:35 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PFg1b3004817;
        Mon, 25 Apr 2022 16:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OK6ExQBuUuS94Nk7iOz+d7Y/2oyL+hly7Zu/AJFdhUk=;
 b=AhKi63fqXYMJ+1F3Dpo9FcnexxMMV7aOLeQX8wOIpgN+ZGLvT1MW/Rj1nAdtPYBStSzO
 5616BWjKi0zdoNyxjg5ODebHcPkdvWInGLeuF9+9JND0cWhuuAq1h1GtkyOmavwiOO7O
 qIZF503p+L3bT9lkmXEdyrdnFE/AaSc82mM6UZNOQBW49UCt9bsfVsiXFNtV7N0IqYwF
 gM33pU32bvmM9ODMlxmh0DzVtdmpGtoqzY0TUa2OqX/iGCCeNg8poxj16qrpd+GttTMR
 JmdIb3HWvbNYzOESR/qoMNCJeYPysY9h3fWp4tou4xM1BoIZNG3kOIuxb8QhnpHKrcLY Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnxgy953c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 16:30:34 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PGSGno028811;
        Mon, 25 Apr 2022 16:30:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnxgy952h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 16:30:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PGIbLQ014453;
        Mon, 25 Apr 2022 16:30:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj2pph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 16:30:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PGURtv48824670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 16:30:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D9BAE051;
        Mon, 25 Apr 2022 16:30:27 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 200C0AE045;
        Mon, 25 Apr 2022 16:30:27 +0000 (GMT)
Received: from [9.171.39.215] (unknown [9.171.39.215])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Apr 2022 16:30:27 +0000 (GMT)
Message-ID: <8095d0de-dd99-0388-b1d4-e59b01dc4be0@linux.ibm.com>
Date:   Mon, 25 Apr 2022 18:30:26 +0200
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
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220425100147.1755340-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j2-ToqVXNkjWhQQpXyEU8Wpr-6Y7rgmL
X-Proofpoint-ORIG-GUID: 7TJi_9jCaUf-v_0adHwGjz37J-a1uNtl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_08,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=959
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250071
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Am 25.04.22 um 12:01 schrieb Janis Schoetterl-Glausch:
> If a memop fails due to key checked protection, after already having
> written to the guest, don't indicate suppression to the guest, as that
> would imply that memory wasn't modified.
> 
> This could be considered a fix to the code introducing storage key
> support, however this is a bug in KVM only if we emulate an
> instructions writing to an operand spanning multiple pages, which I
> don't believe we do.
> 

Thanks applied. I think it makes sense for 5.18 nevertheless.

> v1 -> v2
>   * Reword commit message of patch 1
> 
> Janis Schoetterl-Glausch (2):
>    KVM: s390: Don't indicate suppression on dirtying, failing memop
>    KVM: s390: selftest: Test suppression indication on key prot exception
> 
>   arch/s390/kvm/gaccess.c                   | 47 ++++++++++++++---------
>   tools/testing/selftests/kvm/s390x/memop.c | 43 ++++++++++++++++++++-
>   2 files changed, 70 insertions(+), 20 deletions(-)
> 
> 
> base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b

