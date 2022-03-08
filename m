Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516134D2050
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 19:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348631AbiCHShF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 13:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiCHShE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 13:37:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A1852B03;
        Tue,  8 Mar 2022 10:36:04 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228GEa2j002220;
        Tue, 8 Mar 2022 18:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rBw7fx6XJaHkGHGfHk4SKERRNkT2Vl5PYR6AQBXP4Uw=;
 b=bfdi4EWxZUgTlWPYAc1tFNsOCIgiUdgFaSvovMnSNS6d9pRRbAHUHEcvHhZhsWCFjYj/
 zfnDLuQ4WpbJ58I8DSWDjrYJxY0rBE4x4dbki6BPB4UC+pNBFzikn6IzAKjm159BiwL/
 J3ImKFDttBokAdGj8NSaUQPEi/gltZWYfEqZjtRJ/aEeRJJYXcWzfFzuG84NV0YlAyA9
 qY3KpihE08tbWKxPkOyT93hjcnnaPhkeX1uFikkuxhVCiL014v3eyJnN6PONm9963Tw2
 nsfAOzD85Vq6PqOMzMhJfMIKlTb+d2+7+aY/TKE4+3jxSSKYbDEePXbeZL44DRb9wMlu pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enx3mare4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 18:36:02 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228HPjTc010774;
        Tue, 8 Mar 2022 18:36:01 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enx3mardp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 18:36:01 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228IS3kL019157;
        Tue, 8 Mar 2022 18:35:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3enpk2tgbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 18:35:59 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228IZtSA50528648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 18:35:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB7354C040;
        Tue,  8 Mar 2022 18:35:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 555B24C044;
        Tue,  8 Mar 2022 18:35:55 +0000 (GMT)
Received: from [9.171.51.11] (unknown [9.171.51.11])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 18:35:55 +0000 (GMT)
Message-ID: <897de29d-227d-5111-f176-41dce7071bbb@linux.ibm.com>
Date:   Tue, 8 Mar 2022 19:35:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2 0/5] memop selftest for storage key checking
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308125841.3271721-1-scgl@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220308125841.3271721-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lzVI5DLj6UCJTSlgZBNlRI0sA0Pi-Nko
X-Proofpoint-GUID: NM42rIFnmvxZvGP_PWpJ1Ounq2L2SHZj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_07,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=839 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

I am planning to queue this for the kvm tree. Any concerns?

Am 08.03.22 um 13:58 schrieb Janis Schoetterl-Glausch:
> Refactor memop selftest and add tests.
> Add storage key tests, both for success as well as failure cases.
> Similarly, test both vcpu and vm ioctls.
> 
> v1 -> v2
>   * restructure commits
>   * get rid of test_* wrapper functions that hid vm.vm
>   * minor changes
> 
> v0 -> v2
>   * complete rewrite
> 
> v1: https://lore.kernel.org/kvm/20220217145336.1794778-1-scgl@linux.ibm.com/
> v0: https://lore.kernel.org/kvm/20220211182215.2730017-11-scgl@linux.ibm.com/
> 
> Janis Schoetterl-Glausch (5):
>    KVM: s390: selftests: Split memop tests
>    KVM: s390: selftests: Add macro as abstraction for MEM_OP
>    KVM: s390: selftests: Add named stages for memop test
>    KVM: s390: selftests: Add more copy memop tests
>    KVM: s390: selftests: Add error memop tests
> 
>   tools/testing/selftests/kvm/s390x/memop.c | 735 ++++++++++++++++++----
>   1 file changed, 617 insertions(+), 118 deletions(-)
> 
> 
> base-commit: ee6a569d3bf64c9676eee3eecb861fb01cc11311
