Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE34D2B5E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiCIJGu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 04:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiCIJGu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 04:06:50 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F1716AA6C;
        Wed,  9 Mar 2022 01:05:51 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2298qWbu002023;
        Wed, 9 Mar 2022 09:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=GQbuPmzwqFnOz9KKZhOipe3YMFQ//f3hjp/Mvlz4XPE=;
 b=NIXYfwBWtfadWrvvDSvGt9p/7J98t2q/5+S46L14MXjvWLic+yQaG5ke+ZLs64yQUBwo
 lIm01xLWpGFh6K2nJpH536ME6vSGFzr3ZgJ1+g3a5BlTklf0GQwYSid9LZJAUDSB58V/
 KmMAzaXE4YNZYXxOFVb52wodXkX5gbFZ67sHepexgAhYx2HFrmovkGBSTL0qLR3urbRK
 4AtVoOK+YWdqPpfZARCRQF/KYouzDM76uBFSO4CYhpOmZNjkCuviVK/pcyhdTjfOiK2o
 ilO+X5WogYcMBtVwW4mZJLu4QEGmZTuHI83jIWVnQZQoODnpB6y+LN6HMp4yu9klDzF1 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep0bdnvjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 09:05:42 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2298usJ3017660;
        Wed, 9 Mar 2022 09:05:42 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ep0bdnvj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 09:05:41 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22993aFK027470;
        Wed, 9 Mar 2022 09:05:40 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3ekyg9088v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 09:05:40 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22995a0M10027380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 09:05:36 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABE1A5205A;
        Wed,  9 Mar 2022 09:05:36 +0000 (GMT)
Received: from [9.171.87.105] (unknown [9.171.87.105])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3D92752050;
        Wed,  9 Mar 2022 09:05:36 +0000 (GMT)
Message-ID: <eab904c4-608f-d3e2-9aae-51a9b56994bb@linux.ibm.com>
Date:   Wed, 9 Mar 2022 10:05:35 +0100
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
X-Proofpoint-GUID: ceGAY2aMWb4ygWPGLEQNDZDS-Y20EoqU
X-Proofpoint-ORIG-GUID: IddzAA4Fi7KZGqKO1XD6ywxclvE71a49
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=929 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

applied (with minor whitespace fixes). Will queue for kvms390/next.
