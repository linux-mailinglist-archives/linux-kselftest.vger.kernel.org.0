Return-Path: <linux-kselftest+bounces-17948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4AB97818B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B941F214D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29081D9326;
	Fri, 13 Sep 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rKTJaXZI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0D43144;
	Fri, 13 Sep 2024 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235621; cv=none; b=DRO1i42OZC0ymIebWG2GPi5KDhuwEsnOarWIJvXfbJnPaJTl9rFYuUTosp9fHkVjdxBV4qpoj/voHhBsh5XGPUisV8KNQHX9yAr0kPI6cn5Bb0qcFLw6j2IIX1p/nNhHO383YK+2FLFi5+5VPnCV8Wo+WXYF0HnzIs9k9jHkj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235621; c=relaxed/simple;
	bh=Y5pAQFfmdy8BdUiCwdwPA1lrXfiVP64LN0nnAuc6V9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cm1o94ITRE3LCAng9NNTFZ5Z0LGgoBmxFqOlgI5DyqZlX4rOaYQmi5IW7s5PkltVPw+MFD5mUB8Gp6sMJrsFCjs12tzY2H/lTpVgfl/tiEqfBdiQiBXEenVXQltqWgUg8tRodDaxjh+f0RApMeItCP8bGkY4mtLtmKehk85QtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rKTJaXZI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DBkIcf007357;
	Fri, 13 Sep 2024 13:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=H
	5RrJwevHjL666sc8JIlKpIiyZba3+9zJIInVxqFOyM=; b=rKTJaXZIXBJvrkuIt
	psW8k8Cmu1PO+vx344fHiv1j+TD+C4S2B74+ZGqwn6z8WTp/u3X5noHzxkvFp4x7
	qyMXUH9uSg6rFknC2xglJAVM5IR3ZaLSj3HbnmsQw9c4/VtauyrRMl9YAGxd98Lh
	f4hK4CMPMyBLRwOZEULoZU20MV2qmi27NKlVePKjiHt5WfM7CUj+WY8zo/rvtsEb
	GbDGEQRaidbeLegJejU4D8kwwroWZYLHZ5Da1aU3vbb3bHNfC5GVYznbs2NDXWke
	K7kJccQBsjaVmvwqArPxClollLqBKpJL2htSH6O7Nt5HE2mKb+oTPd37xQbl+YOl
	AH2Lg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxadxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 13:53:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DDrTlI009105;
	Fri, 13 Sep 2024 13:53:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxadxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 13:53:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DD3bTX027303;
	Fri, 13 Sep 2024 13:53:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3p6s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 13:53:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48DDrOsK47776172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 13:53:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DC9B2004B;
	Fri, 13 Sep 2024 13:53:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21D2D20040;
	Fri, 13 Sep 2024 13:53:24 +0000 (GMT)
Received: from [9.171.46.165] (unknown [9.171.46.165])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Sep 2024 13:53:24 +0000 (GMT)
Message-ID: <8767c507-a51e-46bd-83f3-c5e1b2b104ee@linux.ibm.com>
Date: Fri, 13 Sep 2024 15:53:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] selftests: kvm: s390: Add uc_skey VM test case
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240913115248.211071-1-schlameuss@linux.ibm.com>
 <20240913115248.211071-3-schlameuss@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20240913115248.211071-3-schlameuss@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z4Svit_Fogfq0Wszx88J7w42ZdSgMzSW
X-Proofpoint-ORIG-GUID: A1qWBYMZzmHQZ784qUMTdvZyMLCszSyg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_10,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130095

On 9/13/24 1:52 PM, Christoph Schlameuss wrote:
> Add a test case manipulating s390 storage keys from within the ucontrol
> VM.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Except for the two nits:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


I'll think about what to do with the nits next week.

> ---
>   .../selftests/kvm/s390x/ucontrol_test.c       | 89 ++++++++++++++++++-
>   1 file changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 084cea02c2fa..f6e3a68f89a9 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -79,6 +79,33 @@ asm("test_mem_asm:\n"
>   	"	j	0b\n"
>   );
>   
> +/* Test program manipulating storage keys */
> +extern char test_skey_asm[];
> +asm("test_skey_asm:\n"
> +	"xgr	%r0, %r0\n"
> +
> +	"0:\n"
> +	"	ahi	%r0,1\n"
> +	"	st	%r1,0(%r5,%r6)\n"
> +
> +	"	iske	%r1,%r6\n"
> +	"	ahi	%r0,1\n"
> +	"	diag	0,0,0x44\n"
> +
> +	"	sske	%r1,%r6\n"
> +	"	xgr	%r1,%r1\n"
> +	"	iske	%r1,%r6\n"
> +	"	ahi	%r0,1\n"
> +	"	diag	0,0,0x44\n"
> +
> +	"	rrbe	%r1,%r6\n"
> +	"	iske	%r1,%r6\n"
> +	"	ahi	%r0,1\n"
> +	"	diag	0,0,0x44\n"
> +
> +	"	j	0b\n"
> +);
> +
>   FIXTURE(uc_kvm)
>   {
>   	struct kvm_s390_sie_block *sie_block;
> @@ -299,8 +326,9 @@ static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
>   }
>   
>   /* verify SIEIC exit
> - * * reset stop requests

Argh, that made it in the patches that I've picked up.

> + * * handle expected interception codes
>    * * fail on codes not expected in the test cases
> + * Returns if interception is handled / execution can be continued
>    */
>   static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
>   {
> @@ -317,6 +345,10 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
>   		/* end execution in caller on intercepted instruction */
>   		pr_info("sie instruction interception\n");
>   		return false;
> +	case ICPT_KSS:
> +		/* disable KSS and continue; KVM would init the skeys here */
> +		sie_block->cpuflags &= ~CPUSTAT_KSS;
> +		return true;
>   	case ICPT_OPEREXC:
>   		/* operation exception */
>   		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
> @@ -473,4 +505,59 @@ TEST_F(uc_kvm, uc_gprs)
>   	ASSERT_EQ(1, sync_regs->gprs[0]);
>   }
>   
> +TEST_F(uc_kvm, uc_skey)
> +{
> +	u64 test_vaddr = VM_MEM_SIZE - (SZ_1M / 2);
> +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> +	struct kvm_run *run = self->run;
> +	u8 skeyvalue = 0x34;
> +
> +	/* copy test_skey_asm to code_hva / code_gpa */
> +	TH_LOG("copy code %p to vm mapped memory %p / %p",
> +	       &test_skey_asm, (void *)self->code_hva, (void *)self->code_gpa);
> +	memcpy((void *)self->code_hva, &test_skey_asm, PAGE_SIZE);
> +
> +	/* set register content for test_skey_asm to access not mapped memory */
> +	sync_regs->gprs[1] = skeyvalue;
> +	sync_regs->gprs[5] = self->base_gpa;
> +	sync_regs->gprs[6] = test_vaddr;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +
> +	/* DAT disabled + 64 bit mode */
> +	run->psw_mask = 0x0000000180000000ULL;
> +	run->psw_addr = self->code_gpa;
> +
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(true, uc_handle_exit(self));
> +	ASSERT_EQ(1, sync_regs->gprs[0]);
> +
> +	/* ISKE */
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(2, sync_regs->gprs[0]);
> +	/* assert initial skey (ACC = 0, R & C = 1) */
> +	ASSERT_EQ(0x06, sync_regs->gprs[1]);
> +	uc_assert_diag44(self);
> +
> +	/* SSKE */
> +	sync_regs->gprs[1] = skeyvalue;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(3, sync_regs->gprs[0]);
> +	ASSERT_EQ(skeyvalue, sync_regs->gprs[1]);
> +	uc_assert_diag44(self);
> +
> +	/* RRBE */
> +	sync_regs->gprs[1] = skeyvalue;
> +	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
> +	ASSERT_EQ(0, uc_run_once(self));
> +	ASSERT_EQ(false, uc_handle_exit(self));
> +	ASSERT_EQ(4, sync_regs->gprs[0]);
> +	/* assert R reset but rest of skey unchanged*/

Missing space before "*"

> +	ASSERT_EQ(skeyvalue & 0xfa, sync_regs->gprs[1]);
> +	ASSERT_EQ(0x00, sync_regs->gprs[1] & 0x04);
> +	uc_assert_diag44(self);
> +}
> +
>   TEST_HARNESS_MAIN


