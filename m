Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4B04D2D4E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 11:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiCIKoc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 05:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiCIKob (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 05:44:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6279E6928D;
        Wed,  9 Mar 2022 02:43:32 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2298gv7b028548;
        Wed, 9 Mar 2022 10:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZgDGVBrrAfsjgCI/Vfni/1ReZgf2yue8xtodUcqZE8k=;
 b=c7aYjhV8cPLktBSE83E67mKHSHl2q600QP/kvGb3LEehVtI2Ln/c9oDfWJx53nRE37s1
 z13uOeNZK3/EPiNPnU2FLbXdI4F76bpcVbzEgSPBgbeowuuswp5e6segi9wRogZk+jCl
 yieEhEEe5dWEQQLEZBw3yBdxYbv06XaUfxJ/fRBSIRUTAnl4zL98TXF1qvNzWXiIBkaw
 W5pG4/whvDfZT25wWK8Wu/d+hMShJIkTvuANH/mjJnNz0Vvzdh0knGg0iaPBfw3KhrgC
 GpG43BEsTfOH+bIVqaZTAGK+B5MzLHRb0PhUAjLrCRdczokVqeP2EQmkcn2eS7FXW96R wA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eny1918x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 10:43:30 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 229AhUsX003383;
        Wed, 9 Mar 2022 10:43:30 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eny1918wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 10:43:30 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 229AfrbF019448;
        Wed, 9 Mar 2022 10:43:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3enqgnmeay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Mar 2022 10:43:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 229AhOj132047448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Mar 2022 10:43:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B9AD11C064;
        Wed,  9 Mar 2022 10:43:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC3AB11C05C;
        Wed,  9 Mar 2022 10:43:23 +0000 (GMT)
Received: from [9.171.31.6] (unknown [9.171.31.6])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Mar 2022 10:43:23 +0000 (GMT)
Message-ID: <5fce5827-c022-c285-0786-9e0c68bd145c@linux.ibm.com>
Date:   Wed, 9 Mar 2022 11:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RESEND v2 0/5] memop selftest for storage key checking
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308125841.3271721-1-scgl@linux.ibm.com>
 <eab904c4-608f-d3e2-9aae-51a9b56994bb@linux.ibm.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <eab904c4-608f-d3e2-9aae-51a9b56994bb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l0S34nDkJyXDp-57BP0hUOIL8JgFw_NP
X-Proofpoint-ORIG-GUID: T2FaDBhqLA_cfvtB9S1hKYBgqqqXtCoB
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-09_04,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=757 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/9/22 10:05, Christian Borntraeger wrote:
> Am 08.03.22 um 13:58 schrieb Janis Schoetterl-Glausch:
>> Refactor memop selftest and add tests.
>> Add storage key tests, both for success as well as failure cases.
>> Similarly, test both vcpu and vm ioctls.
>>
>> v1 -> v2
>>   * restructure commits
>>   * get rid of test_* wrapper functions that hid vm.vm
>>   * minor changes
>>
>> v0 -> v2
>>   * complete rewrite
>>
>> v1: https://lore.kernel.org/kvm/20220217145336.1794778-1-scgl@linux.ibm.com/
>> v0: https://lore.kernel.org/kvm/20220211182215.2730017-11-scgl@linux.ibm.com/
>>
>> Janis Schoetterl-Glausch (5):
>>    KVM: s390: selftests: Split memop tests
>>    KVM: s390: selftests: Add macro as abstraction for MEM_OP
>>    KVM: s390: selftests: Add named stages for memop test
>>    KVM: s390: selftests: Add more copy memop tests
>>    KVM: s390: selftests: Add error memop tests
>>
>>   tools/testing/selftests/kvm/s390x/memop.c | 735 ++++++++++++++++++----
>>   1 file changed, 617 insertions(+), 118 deletions(-)
>>
>>
>> base-commit: ee6a569d3bf64c9676eee3eecb861fb01cc11311
> 
> applied (with minor whitespace fixes). Will queue for kvms390/next.

Not sure if it's a good idea, but I broke style rules here intentionally:

+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, PAGE_SIZE + 2048,
+			GADDR_V(guest_last_page), KEY(2));

in order to emphasize that the arguments are ultimately arguments to MOP.
I did the same in the DEFAULT(_WRITE)?_READ macros, which checkpatch might
not warn about because of the line break escapes.
