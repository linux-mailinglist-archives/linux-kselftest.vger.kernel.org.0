Return-Path: <linux-kselftest+bounces-14857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEBB9490AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83053280B96
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 13:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819BA1D6DB3;
	Tue,  6 Aug 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kd7XRCvB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3961D6DA9;
	Tue,  6 Aug 2024 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950029; cv=none; b=WQrE0f2gIoMp+A5FT2o2h5hYEb+Oez/v/cCh2M3M7XBplDwVjbqD+1djgTFRl6slKTQwSbRRQBMD3gihQo1HL8pjDVbDH7R2MOmXelQFiV83KKLskfu4MscPL0oYW8HMhvTVMWbPo7F1ib72L9FVBScCxvH2J6kelqUUe44QMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950029; c=relaxed/simple;
	bh=svcblnV0SYwvzIIAV9mk85PEOlNU3WwWPPoIZlHzTF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEaE4kmioGNBJBZw0/8TmHvDRU2NdTXxDeS1m9nW2LGlod0Dei6H1uSGFeEkjLGapmQKzMe8P2qkIuNHL0By2gA7V4+xefxUASxL5ZYw8Y4umsu5BzUMtNoKchgC4VI0iOL7Dxb0NrrixlPIhZXt9d4M2ajp7BwOKKGHHaDZEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kd7XRCvB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476CqlNF004379;
	Tue, 6 Aug 2024 13:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=d
	du1uxRNM1RCETrQCvkgDb+WwQnUpTVk1gGnT1FTJT4=; b=Kd7XRCvBVB2CdgFUm
	6Xx2yLm7h9q8B7wPtuCjXxT2OcHrlx+/cgGDnN32xBMK8y29wLnuGXXcQWpT32ly
	j/v/rLbOc5njllERWW+x2MYcwI0nuYFhHJSEzYFtGzYvIBSf9hdBKZOXGzYnRjKQ
	mLWUmykLxDii+DKBrgjoQ9c6+rV+dpQMnFjh0MZkHmNwD1QUaRxcZ4gqo37EDA04
	H+pUanvHnAfVdgIiWLhZ8O/p+DQo3O2cl53sNSzuH0cZdgbdX/MYRyGJe97LmUIp
	9PUQir3pHkTKH6JaVZcfKwEPWD4AGrgyIkgNu9LST4k7Jx+gDX7AjxnBX2+2InDm
	se4HQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk0287f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:13:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 476DDfa0007983;
	Tue, 6 Aug 2024 13:13:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40uk0287f0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:13:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 476CZlMZ018027;
	Tue, 6 Aug 2024 13:13:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40t0cmkmrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 13:13:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 476DDZGM53019096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Aug 2024 13:13:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1059C2004D;
	Tue,  6 Aug 2024 13:13:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BFD020040;
	Tue,  6 Aug 2024 13:13:34 +0000 (GMT)
Received: from [9.171.47.164] (unknown [9.171.47.164])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Aug 2024 13:13:34 +0000 (GMT)
Message-ID: <dc515da5-6b22-4e15-acfe-d7d0849d16a6@linux.ibm.com>
Date: Tue, 6 Aug 2024 15:13:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] selftests: kvm: s390: Add uc_map_unmap VM test
 case
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240802155913.261891-1-schlameuss@linux.ibm.com>
 <20240802155913.261891-8-schlameuss@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20240802155913.261891-8-schlameuss@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W7V-m4jz-_AHXQe_mVY39Hoaxuqw2yUK
X-Proofpoint-GUID: JcuK0_vcWRimLFr5g_TYatI_7eAOXXxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_10,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408060090

On 8/2/24 5:59 PM, Christoph Schlameuss wrote:
> Add a test case verifying basic running and interaction of ucontrol VMs.
> Fill the segment and page tables for allocated memory and map memory on
> first access.
> 
> * uc_map_unmap
>    Store and load data to mapped and unmapped memory and use pic segment
>    translation handling to map memory on access.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   .../selftests/kvm/s390x/ucontrol_test.c       | 165 +++++++++++++++++-
>   1 file changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 030c59010fe1..72ad30fbe4ac 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -16,7 +16,13 @@
>   #include <linux/capability.h>
>   #include <linux/sizes.h>

[...]

> +#define VM_MEM_MAX (VM_MEM_SIZE + VM_MEM_EXT_SIZE)

You defined this but never use it.
Instead you're still adding up VM_MEM_SIZE and VM_MEM_EXT_SIZE.

> +
> +#define PAGES_PER_SEGMENT 4

You mean pages per segment table?

[...]

> +/* initialize segment and page tables for uc_kvm tests */
> +static void init_st_pt(FIXTURE_DATA(uc_kvm) * self)
> +{
> +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> +	struct kvm_run *run = self->run;
> +	void *se_addr;
> +	int si, pi;
> +	u64 *phd;
> +
> +	/* set PASCE addr */
> +	self->pgd = self->base_gpa + SZ_1M;
> +	phd = gpa2hva(self, self->pgd);
> +	memset(phd, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
> +
> +	for (si = 0; si < ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M); si++) {
> +		/* create ste */
> +		phd[si] = (self->pgd
> +			+ (PAGES_PER_SEGMENT * PAGE_SIZE
> +				* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M))
> +			+ (PAGES_PER_SEGMENT * PAGE_SIZE * si)) & ~0x7fful;
> +		se_addr = gpa2hva(self, phd[si]);
> +		memset(se_addr, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
> +		for (pi = 0; pi < (SZ_1M / PAGE_SIZE); pi++) {
> +			/* create pte */
> +			((u64 *)se_addr)[pi] = (self->base_gpa
> +				+ (si * SZ_1M) + (pi * PAGE_SIZE)) & ~0xffful;
> +		}

That's barely readable, can you split that into functions or make it 
more readable in some other way?

> +	}
> +	pr_debug("segment table entry %p (0x%lx) --> %p\n",
> +		 phd, phd[0], gpa2hva(self, (phd[0] & ~0x7fful)));
> +	print_hex_bytes("st", (u64)phd, 64);
> +	print_hex_bytes("pt", (u64)gpa2hva(self, phd[0]), 128);
> +	print_hex_bytes("pt+", (u64)
> +			gpa2hva(self, phd[0] + (PAGES_PER_SEGMENT * PAGE_SIZE
> +			* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M)) - 0x64), 128);
> +
> +	/* PASCE TT=00 for segment table */
> +	sync_regs->crs[1] = self->pgd | 0x3;
> +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> +}
> +


