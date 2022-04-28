Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A51E513A4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Apr 2022 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349931AbiD1QwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Apr 2022 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiD1QwX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Apr 2022 12:52:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5CAB3DF6;
        Thu, 28 Apr 2022 09:49:08 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SFUiZV022860;
        Thu, 28 Apr 2022 16:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vw3jVl9sakAXhTI6X73MPQh3wYMAWsH4Ay6MIfyWyok=;
 b=Hz5KsGBGPbVP2T+Bntqb8AWWxgztNS0uEuJ5QxtSr9sTDuJuBovGBQeziVXBx+pRXtrP
 QWOuOBe7yhXF7HL3l5e7udw3gNtjMQfxPMB/H4zHu2+lGM5VIhARFYMkB8nbG8h2AATX
 3U7tMB7TYvn7XpGMx6wQGyuKCxTXFY1A5+dgoHkwB3z6Ny+CWj8pOULb7HXu14QZAk2q
 C8m6iu4qPhl17oG9BblcxajKU95uxPBozTpVwgQfTHBtUjBjPzSnXuujCZ5IRGFAjofG
 5FVQgmWxlG8tD230NA1dWIHDw+CSrwXi4Eh241yS87OOMYy67M+xbKtzvuR+S3IKJwjo yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnkde0fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 16:49:06 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23SG7B2b017215;
        Thu, 28 Apr 2022 16:49:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqnkde0f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 16:49:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23SGglMr010651;
        Thu, 28 Apr 2022 16:49:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj7ua4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 16:49:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23SGnBeh26542418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 16:49:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0F9DA404D;
        Thu, 28 Apr 2022 16:49:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50A55A4040;
        Thu, 28 Apr 2022 16:48:57 +0000 (GMT)
Received: from [9.171.92.46] (unknown [9.171.92.46])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 16:48:57 +0000 (GMT)
Message-ID: <aa19672b-3da6-032b-e940-6fd6c3199d5b@linux.ibm.com>
Date:   Thu, 28 Apr 2022 18:48:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] KVM: s390: selftest: Test suppression indication
 on key prot exception
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
 <20220425100147.1755340-3-scgl@linux.ibm.com>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <20220425100147.1755340-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mMWAOfeigfsXYJR7iMql67xsNmxoAB07
X-Proofpoint-GUID: MjjEA3sKilhqhWKHVtTqePLh3_gfYXri
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/25/22 12:01, Janis Schoetterl-Glausch wrote:
> Check that suppression is not indicated on injection of a key checked
> protection exception caused by a memop after it already modified guest
> memory, as that violates the definition of suppression.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/s390x/memop.c | 43 ++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
> index b04c2c1b3c30..ce176ad9f216 100644
> --- a/tools/testing/selftests/kvm/s390x/memop.c
> +++ b/tools/testing/selftests/kvm/s390x/memop.c

[...]

> +static void test_termination(void)
> +{
> +	struct test_default t = test_default_init(guest_error_key);
> +	uint64_t prefix;
> +	uint64_t teid;
> +	uint64_t psw[2];
> +
> +	HOST_SYNC(t.vcpu, STAGE_INITED);
> +	HOST_SYNC(t.vcpu, STAGE_SKEYS_SET);
> +
> +	/* vcpu, mismatching keys after first page */
> +	ERR_PROT_MOP(t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), KEY(1), INJECT);
> +	/*
> +	 * The memop injected a program exception and the test needs to check the
> +	 * Translation-Exception Identification (TEID). It is necessary to run
> +	 * the guest in order to be able to read the TEID from guest memory.
> +	 * Set the guest program new PSW, so the guest state is not clobbered.
> +	 */
> +	prefix = t.run->s.regs.prefix;
> +	psw[0] = t.run->psw_mask;
> +	psw[1] = t.run->psw_addr;
> +	MOP(t.vm, ABSOLUTE, WRITE, psw, sizeof(psw), GADDR(prefix + 464));
> +	HOST_SYNC(t.vcpu, STAGE_IDLED);
> +	MOP(t.vm, ABSOLUTE, READ, &teid, sizeof(teid), GADDR(prefix + 168));
> +	/* Bits 56, 60, 61 form a code, 0 being the only one allowing for termination */
> +	ASSERT_EQ(teid & 0x4c, 0);

The constant is wrong, should be 0x8c instead, or better, a more straight forward
expression that evaluates to it.

[...]
