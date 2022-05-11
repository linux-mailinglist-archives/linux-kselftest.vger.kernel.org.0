Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80105234FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbiEKOGi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiEKOGh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 10:06:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB968FBF;
        Wed, 11 May 2022 07:06:36 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BD35Hs022786;
        Wed, 11 May 2022 14:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=o9dXxNqK/WmPjahNRmPvF3+EMTkge9YjP83v6rWQAik=;
 b=dMYnQqbNp4IXMVlENIcBjbjA9JvFHbUNTZTUM9PSiA2+dBulCXgjplI2zPxtook9XSGG
 X1fUngMccSGMiuji7sBwB4C0xoIX0WvKpenBD5XuIo/f6NnDMTmB7XaDsTvoCwKHmQKE
 zHrGU7IcXV/bp16OXd8BCbpDGidp5jXGeyR3IU2DJGDPIeP0Z0r48t3H3GNLcYEwY0Mk
 p/FIwtP0sEzA5iskyMzMIbqvV+o1wzjX7KRbq/eFS/pABtuECs8lOjSSONN4TfNRJP09
 LBm8oDealCyVUU1Fa6fK0ZIROP9WhQn6kqrUxdg9JqIrsI9iBQmIGGRvSGvBiwTtz2r1 fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0av74tby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:06:22 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24BDrXlX010462;
        Wed, 11 May 2022 14:06:22 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0av74taa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:06:21 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24BDvd7u006974;
        Wed, 11 May 2022 14:06:19 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3fwgd8vbd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 14:06:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24BE6GEd45351200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 May 2022 14:06:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF47042049;
        Wed, 11 May 2022 14:06:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65CC142041;
        Wed, 11 May 2022 14:06:15 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 May 2022 14:06:15 +0000 (GMT)
Date:   Wed, 11 May 2022 16:06:14 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE FOR ARM64 (KVM/arm64)),
        kvmarm@lists.cs.columbia.edu (moderated list:KERNEL VIRTUAL MACHINE FOR
        ARM64 (KVM/arm64)),
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] selftests: kvm: replace ternary operator with min()
Message-ID: <20220511160614.6bd82c26@p-imbrenda>
In-Reply-To: <20220511120621.36956-1-guozhengkui@vivo.com>
References: <20220511120621.36956-1-guozhengkui@vivo.com>
Organization: IBM
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ElqxWVDUfcV4CChAtDMwui_tsn0ZjaUE
X-Proofpoint-ORIG-GUID: yOcvldO4MAxjwKJY0UG89VapQRKdHvJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_05,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 11 May 2022 20:05:55 +0800
Guo Zhengkui <guozhengkui@vivo.com> wrote:

> Fix the following coccicheck warnings:
> 
> tools/testing/selftests/kvm/lib/s390x/ucall.c:25:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/x86_64/ucall.c:27:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/riscv/ucall.c:56:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/aarch64/ucall.c:82:15-17: WARNING
> opportunity for min()
> tools/testing/selftests/kvm/lib/aarch64/ucall.c:55:20-21: WARNING
> opportunity for min()
> 
> min() is defined in tools/include/linux/kernel.h.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/lib/aarch64/ucall.c | 4 ++--
>  tools/testing/selftests/kvm/lib/riscv/ucall.c   | 2 +-
>  tools/testing/selftests/kvm/lib/s390x/ucall.c   | 2 +-
>  tools/testing/selftests/kvm/lib/x86_64/ucall.c  | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> index e0b0164e9af8..00be3ef195ca 100644
> --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> @@ -52,7 +52,7 @@ void ucall_init(struct kvm_vm *vm, void *arg)
>  	 * lower and won't match physical addresses.
>  	 */
>  	bits = vm->va_bits - 1;
> -	bits = vm->pa_bits < bits ? vm->pa_bits : bits;
> +	bits = min(vm->pa_bits, bits);
>  	end = 1ul << bits;
>  	start = end * 5 / 8;
>  	step = end / 16;
> @@ -79,7 +79,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>  	va_list va;
>  	int i;
>  
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>  
>  	va_start(va, nargs);
>  	for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> index 9e42d8248fa6..34f16fe70ce8 100644
> --- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
> @@ -53,7 +53,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>  	va_list va;
>  	int i;
>  
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>  
>  	va_start(va, nargs);
>  	for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> index 9d3b0f15249a..665267c1135d 100644
> --- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
> @@ -22,7 +22,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>  	va_list va;
>  	int i;
>  
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>  
>  	va_start(va, nargs);
>  	for (i = 0; i < nargs; ++i)
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> index a3489973e290..2ea31a0ebe30 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
> @@ -24,7 +24,7 @@ void ucall(uint64_t cmd, int nargs, ...)
>  	va_list va;
>  	int i;
>  
> -	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
> +	nargs = min(nargs, UCALL_MAX_ARGS);
>  
>  	va_start(va, nargs);
>  	for (i = 0; i < nargs; ++i)

