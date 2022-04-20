Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614A50872A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378191AbiDTLlL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378187AbiDTLlK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 07:41:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B8841601;
        Wed, 20 Apr 2022 04:38:22 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K9fpvb016943;
        Wed, 20 Apr 2022 11:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qW5PecKCR2tBmyDaM5vvr89rqdnR7mI/glXx37Nqk3E=;
 b=Fx5cBy2iS/YwJLPQItGsD37B7uPQjdRwnQ6cu3QE8IWLnGecvjugi9sYczV8AGjPoXmG
 z0rGYn4ZbpBqxObdh78A1ydko8PZZ6b/OBZ2mgCCtQtD3N48wwfFH/iubrPubFRZulIE
 1JNYpopcEDX3bRA9hGZKkTvREbjZzueeU0GhXLQMiqZsXputiB/VCzWZA9r6EvwIhYBC
 9yxhhnZfTLWa/+3hqZ8FSLGFbii5pFWn9hbh+w6P8YbguTx2PM5BGPLrAKAcY2g04l2q
 R4Fw8souKADD23NK6yM98PbbBZb9BxfoZfu9X6E4TeE/GuqCzmXcLsNri36VY+20OaA1 SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7kb875n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 11:38:19 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KBTfOj012326;
        Wed, 20 Apr 2022 11:38:18 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fg7kb8752-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 11:38:18 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KBX9n2002101;
        Wed, 20 Apr 2022 11:38:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3ffne94wey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 11:38:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KBPPdD50004228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 11:25:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E17F6A4055;
        Wed, 20 Apr 2022 11:38:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62195A4053;
        Wed, 20 Apr 2022 11:38:12 +0000 (GMT)
Received: from [9.171.21.171] (unknown [9.171.21.171])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 11:38:12 +0000 (GMT)
Message-ID: <267dc999-edc6-c8fc-b177-e06fb2d259b4@linux.ibm.com>
Date:   Wed, 20 Apr 2022 13:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] KVM: s390: selftests: Use TAP interface in the
 tprot test
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-s390@vger.kernel.org
References: <20220419185857.128351-1-thuth@redhat.com>
 <20220419185857.128351-4-thuth@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <20220419185857.128351-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p89HV7KgfAQk8Y6Hwv8ARzJOXZ-OqQp3
X-Proofpoint-GUID: HBzKgVZMWF8vKrjIJh7QOe26mds_c_Y4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_02,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200071
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/19/22 20:58, Thomas Huth wrote:
> The tprot test currently does not have any output (unless one of
> the TEST_ASSERT statement fails), so it's hard to say for a user
> whether a certain new sub-test has been included in the binary or
> not. Let's make this a little bit more user-friendly and include
> some TAP output via the kselftests.h interface.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/s390x/tprot.c | 28 +++++++++++++++++++----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
> index c097b9db495e..baba883d7a6d 100644
> --- a/tools/testing/selftests/kvm/s390x/tprot.c
> +++ b/tools/testing/selftests/kvm/s390x/tprot.c

We're not committing ourselves to any particular test output, are we?
Your patch considers the stages used for test setup tests themselves,
which I'm fine with, but would not want to commit to keeping that way forever.

[...]

> +#define HOST_SYNC(vmp, stage)			\
> +{						\
> +	HOST_SYNC_NO_TAP(vmp, stage);		\
> +	ksft_test_result_pass("" #stage "\n");	\
> +}
> +

It should not be a problem, but is there any reason you're not using
do { ... } while(0) or ({ ... }) instead of just braces?

[...]
