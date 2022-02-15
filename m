Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B044B683A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Feb 2022 10:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiBOJzN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 04:55:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiBOJzM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 04:55:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4555A10A7FB;
        Tue, 15 Feb 2022 01:55:03 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F7p9DB012049;
        Tue, 15 Feb 2022 09:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yLXpyIZemp4HaBhnwsA2gdOt8XJPHK0CTjP4FZW3qys=;
 b=K6UUEPadL9L6PQMBpihilw1A1+O+79lawRDAArPtjjHI2kp4QtkvEtWRnbse4EsIXI8L
 wjs1HYloPPEnjAu0iag/YXc3s22v7l7x3GOt1zOUs1jj+O6Ip9Ll+MgA4ozy/z6bNiM0
 qU3A2QOZ7n+YMv7ditpbtePMjvWIQnjrdFgXyO/8aHHt2PEzBoazJI260Y6LLjCsBEBE
 wlIlE5Z0Udl4ldKTdDtatTSvGVGDRXKro3P9MXmQc0jtFfHvqVk0bx+Tf09oW+COENbg
 u0VeI5an3xSkYDu0bBEYaBw34IYUgfSTvFXEsuZffbIooq6c9RvE9QCQPQ5lQNhPR0zb Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8850jh1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 09:55:02 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21F9nRcC028637;
        Tue, 15 Feb 2022 09:55:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8850jh11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 09:55:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21F9cMDH031585;
        Tue, 15 Feb 2022 09:55:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645jn9wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 09:55:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21F9stfw41091396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 09:54:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9E544C044;
        Tue, 15 Feb 2022 09:54:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A59C4C040;
        Tue, 15 Feb 2022 09:54:55 +0000 (GMT)
Received: from [9.171.66.227] (unknown [9.171.66.227])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 09:54:55 +0000 (GMT)
Message-ID: <801aa4ea-ca26-7561-95f3-162b0f680929@linux.ibm.com>
Date:   Tue, 15 Feb 2022 10:54:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] selftests: kvm: Check whether SIDA memop fails for normal
 guests
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220215074824.188440-1-thuth@redhat.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <20220215074824.188440-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: viCYogg6dhuGJ0Dow6CRyD5yxFP8TSm2
X-Proofpoint-ORIG-GUID: 6_EK_d2sRUK_MRmYvKJrBKiS4EtxccOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_03,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 08:48, Thomas Huth wrote:
> Commit 2c212e1baedc ("KVM: s390: Return error on SIDA memop on normal
> guest") fixed the behavior of the SIDA memops for normal guests. It
> would be nice to have a way to test whether the current kernel has
> the fix applied or not. Thus add a check to the KVM selftests for
> these two memops.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index 9f49ead380ab..d19c3ffdea3f 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c
> @@ -160,6 +160,21 @@ int main(int argc, char *argv[])
>  	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
>  	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
> 
> +	/* Check that the SIDA calls are rejected for non-protected guests */
> +	ksmo.gaddr = 0;
> +	ksmo.flags = 0;
> +	ksmo.size = 8;
> +	ksmo.op = KVM_S390_MEMOP_SIDA_READ;
> +	ksmo.buf = (uintptr_t)mem1;
> +	ksmo.sida_offset = 0x1c0;

What is the rational for that constant?
Any would do, as long as size + offset < PAGE_SIZE, correct?

> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL,
> +		    "ioctl does not reject SIDA_READ in non-protected mode");
> +	ksmo.op = KVM_S390_MEMOP_SIDA_WRITE;
> +	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
> +	TEST_ASSERT(rv == -1 && errno == EINVAL,
> +		    "ioctl does not reject SIDA_WRITE in non-protected mode");
> +
>  	kvm_vm_free(vm);
> 
>  	return 0;

