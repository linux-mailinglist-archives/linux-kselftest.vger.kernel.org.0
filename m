Return-Path: <linux-kselftest+bounces-15196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098E394FEAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 09:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A1DB24237
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 07:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880726F2F3;
	Tue, 13 Aug 2024 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QpdjkvND"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61C61FCF;
	Tue, 13 Aug 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533692; cv=none; b=O6jTlAc1Zon4gjMkl3H7NYqSH1487HIsf4h8DKHdx5CJFGzXAEzslT8uzsuebN//28vTTDL8vZFpugyLbBHW1KQU8/Tbr16RIWlWPFxYsF57T7coc5rh0s57tBr4s8DZeU2aJOL+afdK18Kizdf2pMfojffBI6cid/HGnRq5LKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533692; c=relaxed/simple;
	bh=LZrUyNYpN8Z7MqaarIVS2vm/ZB5T909QSMe3O+gMQJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9qGgp4MA1p6s7F+7VOSg+MrTRwHav8J8uOsMpy4DLwEymhGrp9fagakKd0d61l13WW3jhITH40R3upmJEX5rvdyhTebs428nv7sYTP/ZUTAqAAIg/g9xRS+oXCHCeX4ZgTXWdPpdWI3iWPpnaOebjXJN/8HouK1G0AmN8iCD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QpdjkvND; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D1IIKT019097;
	Tue, 13 Aug 2024 07:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=V
	D2WAp1/jWxqRo4vBMeyQtJUw3y3FDflx1JgUQ3uvu4=; b=QpdjkvNDVYIt6B8yz
	2n1GKtyj7zO0Zq7noinSgm96sYggfLKC1ODmPR62F4SqgGbGAyIcFJzD9fyN34nT
	jQwj3jrrA7kafZRkvq1Cs0+b7Oz3FijVus468a+1hjHqQAXnPdnOn9KyiTyoo3Zj
	A0IG6Vcv/BDYW7wppvwNcH/7bIxqSHYC2NNDOesPqXb+rrYC81XaBPdGUokyUcTy
	N5xSGjFne6aUi6mAj5GLZZftEYuJ7DqBvB0IXZd8sFyW14CVG69VKwJtVWn7JhrN
	rEryQLV9i7e8OA3MWXlE6CP+ZXjlguOM/YyzN0Ruj6O1AVBgexraBQ8sVcTNxBYz
	3tMMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40xr5dcwhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 07:21:20 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47D7LK4Q030612;
	Tue, 13 Aug 2024 07:21:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40xr5dcwhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 07:21:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D71wdT011537;
	Tue, 13 Aug 2024 07:21:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhu2kad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 07:21:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47D7LDda54853930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 07:21:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8243C2004F;
	Tue, 13 Aug 2024 07:21:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D3982004D;
	Tue, 13 Aug 2024 07:21:13 +0000 (GMT)
Received: from [9.179.17.163] (unknown [9.179.17.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 07:21:13 +0000 (GMT)
Message-ID: <c1af035e-2bc3-4d61-a318-11f2490cb0d5@linux.ibm.com>
Date: Tue, 13 Aug 2024 09:21:12 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] selftests: kvm: s390: Add uc_map_unmap VM test
 case
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240807154512.316936-1-schlameuss@linux.ibm.com>
 <20240807154512.316936-8-schlameuss@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 xsFNBFubpD4BEADX0uhkRhkj2AVn7kI4IuPY3A8xKat0ihuPDXbynUC77mNox7yvK3X5QBO6
 qLqYr+qrG3buymJJRD9xkp4mqgasHdB5WR9MhXWKH08EvtvAMkEJLnqxgbqf8td3pCQ2cEpv
 15mH49iKSmlTcJ+PvJpGZcq/jE42u9/0YFHhozm8GfQdb9SOI/wBSsOqcXcLTUeAvbdqSBZe
 zuMRBivJQQI1esD9HuADmxdE7c4AeMlap9MvxvUtWk4ZJ/1Z3swMVCGzZb2Xg/9jZpLsyQzb
 lDbbTlEeyBACeED7DYLZI3d0SFKeJZ1SUyMmSOcr9zeSh4S4h4w8xgDDGmeDVygBQZa1HaoL
 Esb8Y4avOYIgYDhgkCh0nol7XQ5i/yKLtnNThubAcxNyryw1xSstnKlxPRoxtqTsxMAiSekk
 0m3WJwvwd1s878HrQNK0orWd8BzzlSswzjNfQYLF466JOjHPWFOok9pzRs+ucrs6MUwDJj0S
 cITWU9Rxb04XyigY4XmZ8dywaxwi2ZVTEg+MD+sPmRrTw+5F+sU83cUstuymF3w1GmyofgsU
 Z+/ldjToHnq21MNa1wx0lCEipCCyE/8K9B9bg9pUwy5lfx7yORP3JuAUfCYb8DVSHWBPHKNj
 HTOLb2g2UT65AjZEQE95U2AY9iYm5usMqaWD39pAHfhC09/7NQARAQABzSVKYW5vc2NoIEZy
 YW5rIDxmcmFua2phQGxpbnV4LmlibS5jb20+wsF3BBMBCAAhBQJbm6Q+AhsjBQsJCAcCBhUI
 CQoLAgQWAgMBAh4BAheAAAoJEONU5rjiOLn4p9gQALjkdj5euJVI2nNT3/IAxAhQSmRhPEt0
 AmnCYnuTcHRWPujNr5kqgtyER9+EMQ0ZkX44JU2q7OWxTdSNSAN/5Z7qmOR9JySvDOf4d3mS
 bMB5zxL9d8SbnSs1uW96H9ZBTlTQnmLfsiM9TetAjSrR8nUmjGhe2YUhJLR1v1LguME+YseT
 eXnLzIzqqpu311/eYiiIGcmaOjPCE+vFjcXL5oLnGUE73qSYiujwhfPCCUK0850o1fUAYq5p
 CNBCoKT4OddZR+0itKc/cT6NwEDwdokeg0+rAhxb4Rv5oFO70lziBplEjOxu3dqgIKbHbjza
 EXTb+mr7VI9O4tTdqrwJo2q9zLqqOfDBi7NDvZFLzaCewhbdEpDYVu6/WxprAY94hY3F4trT
 rQMHJKQENtF6ZTQc9fcT5I3gAmP+OEvDE5hcTALpWm6Z6SzxO7gEYCnF+qGXqp8sJVrweMub
 UscyLqHoqdZC2UG4LQ1OJ97nzDpIRe0g6oJ9ZIYHKmfw5jjwH6rASTld5MFWajWdNsqK15k/
 RZnHAGICKVIBOBsq26m4EsBlfCdt3b/6emuBjUXR1pyjHMz2awWzCq6/6OWs5eANZ0sdosNq
 dq2v0ULYTazJz2rlCXV89qRa7ukkNwdBSZNEwsD4eEMicj1LSrqWDZMAALw50L4jxaMD7lPL
 jJbazsFNBFubpD4BEADAcUTRqXF/aY53OSH7IwIK9lFKxIm0IoFkOEh7LMfp7FGzaP7ANrZd
 cIzhZi38xyOkcaFY+npGEWvko7rlIAn0JpBO4x3hfhmhBD/WSY8LQIFQNNjEm3vzrMo7b9Jb
 JAqQxfbURY3Dql3GUzeWTG9uaJ00u+EEPlY8zcVShDltIl5PLih20e8xgTnNzx5c110lQSu0
 iZv2lAE6DM+2bJQTsMSYiwKlwTuv9LI9Chnoo6+tsN55NqyMxYqJgElk3VzlTXSr3+rtSCwf
 tq2cinETbzxc1XuhIX6pu/aCGnNfuEkM34b7G1D6CPzDMqokNFbyoO6DQ1+fW6c5gctXg/lZ
 602iEl4C4rgcr3+EpfoPUWzKeM8JXv5Kpq4YDxhvbitr8Dm8gr38+UKFZKlWLlwhQ56r/zAU
 v6LIsm11GmFs2/cmgD1bqBTNHHcTWwWtRTLgmnqJbVisMJuYJt4KNPqphTWsPY8SEtbufIlY
 HXOJ2lqUzOReTrie2u0qcSvGAbSfec9apTFl2Xko/ddqPcZMpKhBiXmY8tJzSPk3+G4tqur4
 6TYAm5ouitJsgAR61Cu7s+PNuq/pTLDhK+6/Njmc94NGBcRA4qTuysEGE79vYWP2oIAU4Fv6
 gqaWHZ4MEI2XTqH8wiwzPdCQPYsSE0fXWiYu7ObeErT6iLSTZGx4rQARAQABwsFfBBgBCAAJ
 BQJbm6Q+AhsMAAoJEONU5rjiOLn4DDEP/RuyckW65SZcPG4cMfNgWxZF8rVjeVl/9PBfy01K
 8R0hajU40bWtXSMiby7j0/dMjz99jN6L+AJHJvrLz4qYRzn2Ys843W+RfXj62Zde4YNBE5SL
 jJweRCbMWKaJLj6499fctxTyeb9+AMLQS4yRSwHuAZLmAb5AyCW1gBcTWZb8ON5BmWnRqeGm
 IgC1EvCnHy++aBnHTn0m+zV89BhTLTUal35tcjUFwluBY39R2ux/HNlBO1GY3Z+WYXhBvq7q
 katThLjaQSmnOrMhzqYmdShP1leFTVbzXUUIYv/GbynO/YrL2gaQpaP1bEUEi8lUAfXJbEWG
 dnHFkciryi092E8/9j89DJg4mmZqOau7TtUxjRMlBcIliXkzSLUk+QvD4LK1kWievJse4mte
 FBdkWHfP4BH/+8DxapRcG1UAheSnSRQ5LiO50annOB7oXF+vgKIaie2TBfZxQNGAs3RQ+bga
 DchCqFm5adiSP5+OT4NjkKUeGpBe/aRyQSle/RropTgCi85pje/juYEn2P9UAgkfBJrOHvQ9
 Z+2Sva8FRd61NJLkCJ4LFumRn9wQlX2icFbi8UDV3do0hXJRRYTWCxrHscMhkrFWLhYiPF4i
 phX7UNdOWBQ90qpHyAxHmDazdo27gEjfvsgYMdveKknEOTEb5phwxWgg7BcIDoJf9UMC
In-Reply-To: <20240807154512.316936-8-schlameuss@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m963C_txvMvqbby2fbvqsbdsNeiWRUxq
X-Proofpoint-GUID: Ge-3ixXiXES4VmodX6_dfG595P2LhrQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130049

On 8/7/24 5:45 PM, Christoph Schlameuss wrote:
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
>   .../selftests/kvm/s390x/ucontrol_test.c       | 167 +++++++++++++++++-
>   1 file changed, 166 insertions(+), 1 deletion(-)
> 

[...]

> +static void init_st_pt(FIXTURE_DATA(uc_kvm) * self)
> +{
> +	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
> +	u64 first_pt_addr, ste, s_addr, pte;
> +	struct kvm_run *run = self->run;
> +	void *se_addr;
> +	int si, pi;
> +	u64 *phd;
> +
> +	/* set PASCE addr */
> +	self->pgd = self->base_gpa + SZ_1M;
> +	phd = gpa2hva(self, self->pgd);
> +	memset(phd, 0xff, VM_MEM_TABLE_SIZE);
> +
> +	first_pt_addr = self->pgd + (VM_MEM_TABLE_SIZE * VM_MEM_MAX_M);
> +	/* for each segment in the VM */
> +	for (si = 0; si < VM_MEM_MAX_M; si++) {
> +		/* build segment table entry (ste) */
> +		ste = (first_pt_addr + (VM_MEM_TABLE_SIZE * si)) & ~0x7fful;
> +		/* store ste in st */
> +		phd[si] = ste;
> +
> +		se_addr = gpa2hva(self, phd[si]);
> +		s_addr = self->base_gpa + (si * SZ_1M);
> +		memset(se_addr, 0xff, VM_MEM_TABLE_SIZE);
> +		/* for each page in the segment (VM) */
> +		for (pi = 0; pi < (SZ_1M / PAGE_SIZE); pi++) {
> +			/* build page table entry (pte) */
> +			pte = (s_addr + (pi * PAGE_SIZE)) & ~0xffful;
> +			/* store pte in pt */
> +			((u64 *)se_addr)[pi] = pte;
> +		}
> +	}
> +	pr_debug("segment table entry %p (0x%lx) --> %p\n",
> +		 phd, phd[0], gpa2hva(self, (phd[0] & ~0x7fful)));
> +	print_hex_bytes("st", (u64)phd, 64);
> +	print_hex_bytes("pt", (u64)gpa2hva(self, phd[0]), 128);
> +
> +	/* PASCE TT=00 for segment table */
> +	sync_regs->crs[1] = self->pgd | 0x3;
> +	run->kvm_dirty_regs |= KVM_SYNC_CRS;
> +}

Having a closer look at this I don't understand why we need to setup DAT 
in the guest. Also, the guest's memory easily fits in a couple of 
segment entries so you could set the table length TL in the ASCE to one 
page instead of 4.


