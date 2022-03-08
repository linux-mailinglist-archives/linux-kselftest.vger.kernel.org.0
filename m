Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A94D1488
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 11:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbiCHKRc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 05:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345730AbiCHKR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 05:17:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403742EC8;
        Tue,  8 Mar 2022 02:16:33 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2289Ac9E002406;
        Tue, 8 Mar 2022 10:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xfmUHCm+vt3QL75YbpuxMaa7UKUaJfuD5kqmP5rxiMg=;
 b=ntIzA8W4WZ0cHSmfEbemMmaEkGT1S1SlWTLm6ya0T2lvNJq6K9Trxf7+B5iuSavytl/7
 soOMPwPYBJV9DrtQNYMT7YVBvZuoyXYdwppOZIAmeOeQdidkyub9VZCbilgzYkZyUxkK
 ktg5fe4KjOaC9JQUan74rIsxmFJMcqXpqRcJw2VAXupTBShJUbcPStGxXiYYHTW4b0zt
 KFbI0nNCRA0Ls2DFrWt8xjw7BG3kpNNehetQ4a91baBLINCxhjERhd4EhKZB+42MN2TW
 e1i6fz6r0Z77r9hKwOs+eg8Zwq5dQv+t7ZzKJu2OCEuo0I8YNxzJ0p6JGS6VB66Hgi2V EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep0bcwuaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:16:30 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228A4KMQ029550;
        Tue, 8 Mar 2022 10:16:30 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep0bcwua5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:16:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228ACxAf026035;
        Tue, 8 Mar 2022 10:16:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3ekyg8x340-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:16:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228AGNs154788410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 10:16:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF9E411C04C;
        Tue,  8 Mar 2022 10:16:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D73C11C050;
        Tue,  8 Mar 2022 10:16:23 +0000 (GMT)
Received: from [9.171.93.186] (unknown [9.171.93.186])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 10:16:23 +0000 (GMT)
Message-ID: <821e840f-c167-611a-e954-38173a90c0a5@linux.ibm.com>
Date:   Tue, 8 Mar 2022 11:16:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/5] memop selftest for storage key checking
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220225155311.3540514-1-scgl@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220225155311.3540514-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZN8cRf2sJdkGeWheZ3l1_EGtbdtV705P
X-Proofpoint-ORIG-GUID: NNo5KLSAcui5w3yZnbrzApIwjBCXS5nh
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Can you send this as a separate thread (not inside the original thread). Otherwise things like b4 get confused and people might also overlook this.


Am 25.02.22 um 16:53 schrieb Janis Schoetterl-Glausch:
> Refactor memop selftest and add tests.
> Add storage key tests, both for success as well as failure cases.
> Similarly test both vcpu and vm ioctls.
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
>   tools/testing/selftests/kvm/s390x/memop.c | 734 ++++++++++++++++++----
>   1 file changed, 616 insertions(+), 118 deletions(-)
> 
> 
> base-commit: ee6a569d3bf64c9676eee3eecb861fb01cc11311
