Return-Path: <linux-kselftest+bounces-35787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DC5AE8B61
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7A418854D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E0F269B01;
	Wed, 25 Jun 2025 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hu8R2TwE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF43074AC;
	Wed, 25 Jun 2025 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871899; cv=none; b=gbVgDq59h59o4ghxd3AEGyWEN5pJ9itQRAFCaDEsoEmUe8FMOoukozMD76h0/lsEyhgriO1S7WNDQI8+ADW8VBpL9atoBe6KtruGUR5t4wHdZ6Sh9UhBSLGYiAMYesiRhWFk7MUgG//n2dx9LOH4CGCjuDTz4OrJ+MfKwZ8STnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871899; c=relaxed/simple;
	bh=WH+67ETG60FO49tyVub/emz9wTANfE4oZLyJ99hWlVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9MM3s3BxcSKdj5D6eR7pozRq4+6B0h/uWpBGLz1J5rpR6Y1VY724K94BrcrTWD4hcce2WZhN9oGH30JVYVQe04k6RvhNwJDWiYtDhgoNcRhQWD+CV1Mefvffk7d8AsHxaZW875d1cJzAOtDqC5S77K8zBHKg0RsnW3B/VA7aZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hu8R2TwE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PFUIrI003394;
	Wed, 25 Jun 2025 17:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hJmiqI
	GVi9jYz2XV2RDTUFNp29tnqRL83h4+ynhToF0=; b=Hu8R2TwE+A8WyFG1N5BlSK
	wMQo3nhEMe5EbAwT4IiewOzMG+gtt+l/D8epBEZVektbDqDWNH6N0KoZ00258HhP
	yNiVyX7+WZkeWt6RBefwfhFibmbNG4ET6neyu6N9IdPwL8dZyIGwfUAub3gFtJa+
	5ZTr/+T39bsaFTpWrymI2IiSk8s6CE96c3/w7m5s5lrXSSeSB8m1nybYlpme08eY
	qNE48LFW0n4PZO+dUP+FYf3o4tG2RzOu9fz2C02aU7ks6PFQIA2mULaS3hZp+NAG
	KFNj3KOv+TXx33hZcWbhCxjJUXeq/sMlcCLqlBgWhb0AlnDenV4zd8ypTSvnv88A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u0w7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 17:18:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55PHI00j030154;
	Wed, 25 Jun 2025 17:18:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u0w7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 17:18:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PF1Uub004643;
	Wed, 25 Jun 2025 17:17:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kt8nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 17:17:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PHHvkH44827114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 17:17:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A56820043;
	Wed, 25 Jun 2025 17:17:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE6F220040;
	Wed, 25 Jun 2025 17:17:53 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com (unknown [9.124.208.75])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Jun 2025 17:17:53 +0000 (GMT)
Date: Wed, 25 Jun 2025 22:47:50 +0530
From: Donet Tom <donettom@linux.ibm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Message-ID: <aFwvPj5AlCgTZsh2@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
References: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <16fff6e9-98f5-4004-9906-feac49f0bbb4@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16fff6e9-98f5-4004-9906-feac49f0bbb4@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GwdDxKWbBi4q9Rqmr219TkpxO9foB5-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEyOCBTYWx0ZWRfX+cC+8RLbZJWH wEP3loW+cj4DbnfX/wab4EtH45pdwH1Szs+gPGN7IFRsblju3yLjvMky1sFDpzHRbD1ZvKXjChc EkGDIS4/ygaDFkPxq8yFu3X4cSWUcgs3zke4ronSLVNmR1YnD+CiDCobzAP1PNt/Sp+6wjyJ+44
 YN2JwUE9qDkqar9MC3N3k1NQQjKqAl5oDt3GcvUARZCaz0SaOx5JYYSUN4AmrF2l8T2MqFDv46x pDwXvEjERfnGHcmvIZwx3BkU2gL0HDz8xATGsuY6C5nXZNVBHjVok71/5DqO2eifX79G5Nwkw+D c2NRN2bOQ2NytKK4jxpkN4oVGa2QIKURLzEA4iQfPWyTQm0o5Qpw5ghyVc5C2pCsk2+5k2Josqp
 slm8qUidDYRz/clr7OHjf5pJqOTSPEnaOiGnKPJ6vgF7CTK3UkCSs1Ou9mX2tzVAPBf+0D0H
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685c2f49 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=BaPsrneplRJP-Z4xSb0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ai7n1ObA81d7M5cF_SeK_zdL-urTLJWf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250128

On Wed, Jun 25, 2025 at 06:22:53PM +0530, Dev Jain wrote:
> 
> On 19/06/25 1:53 pm, Donet Tom wrote:
> > On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
> > > On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
> > > > On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
> > > > > On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
> > > > > > On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
> > > > > > > On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
> > > > > > > > On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
> > > > > > > > Are you accounting for sys.max_map_count? If not, then you'll be hitting that
> > > > > > > > first.
> > > > > > > run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
> > > > > > Umm, what? You mean overcommit all mode, and that has no bearing on the max
> > > > > > mapping count check.
> > > > > > 
> > > > > > In do_mmap():
> > > > > > 
> > > > > > 	/* Too many mappings? */
> > > > > > 	if (mm->map_count > sysctl_max_map_count)
> > > > > > 		return -ENOMEM;
> > > > > > 
> > > > > > 
> > > > > > As well as numerous other checks in mm/vma.c.
> > > > > Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
> > > > > this.
> > > > No problem! It's hard to be aware of everything in mm :)
> > > > 
> > > > > > I'm not sure why an overcommit toggle is even necessary when you could use
> > > > > > MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
> > > > > > 
> > > > > > I'm pretty confused as to what this test is really achieving honestly. This
> > > > > > isn't a useful way of asserting mmap() behaviour as far as I can tell.
> > > > > Well, seems like a useful way to me at least : ) Not sure if you are in the mood
> > > > > to discuss that but if you'd like me to explain from start to end what the test
> > > > > is doing, I can do that : )
> > > > > 
> > > > I just don't have time right now, I guess I'll have to come back to it
> > > > later... it's not the end of the world for it to be iffy in my view as long as
> > > > it passes, but it might just not be of great value.
> > > > 
> > > > Philosophically I'd rather we didn't assert internal implementation details like
> > > > where we place mappings in userland memory. At no point do we promise to not
> > > > leave larger gaps if we feel like it :)
> > > You have a fair point. Anyhow a debate for another day.
> > > 
> > > > I'm guessing, reading more, the _real_ test here is some mathematical assertion
> > > > about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
> > > > 
> > > > But again I'm not sure that achieves much and again also is asserting internal
> > > > implementation details.
> > > > 
> > > > Correct behaviour of this kind of thing probably better belongs to tests in the
> > > > userland VMA testing I'd say.
> > > > 
> > > > Sorry I don't mean to do down work you've done before, just giving an honest
> > > > technical appraisal!
> > > Nah, it will be rather hilarious to see it all go down the drain xD
> > > 
> > > > Anyway don't let this block work to fix the test if it's failing. We can revisit
> > > > this later.
> > > Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
> > > the gap check at the crossing boundary. What do you think?
> > > 
> > One problem I am seeing with this approach is that, since the hint address
> > is generated randomly, the VMAs are also being created at randomly based on
> > the hint address.So, for the VMAs created at high addresses, we cannot guarantee
> > that the gaps between them will be aligned to MAP_CHUNK_SIZE.
> > 
> > High address VMAs
> > -----------------
> > 1000000000000-1000040000000 r--p 00000000 00:00 0
> > 2000000000000-2000040000000 r--p 00000000 00:00 0
> > 4000000000000-4000040000000 r--p 00000000 00:00 0
> > 8000000000000-8000040000000 r--p 00000000 00:00 0
> > e80009d260000-fffff9d260000 r--p 00000000 00:00 0
> > 
> > I have a different approach to solve this issue.
> > 
> >  From 0 to 128TB, we map memory directly without using any hint. For the range above
> > 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
> > we use random hint addresses, but I have modified it to generate hint addresses linearly
> > starting from 128TB.
> > 
> > With this change:
> > 
> > The 0–128TB range is mapped without hints and verified accordingly.
> > 
> > The 128TB–512TB range is mapped using linear hint addresses and then verified.
> > 
> > Below are the VMAs obtained with this approach:
> > 
> > 10000000-10010000 r-xp 00000000 fd:05 135019531
> > 10010000-10020000 r--p 00000000 fd:05 135019531
> > 10020000-10030000 rw-p 00010000 fd:05 135019531
> > 20000000-10020000000 r--p 00000000 00:00 0
> > 10020800000-10020830000 rw-p 00000000 00:00 0
> > 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
> > 1004c000000-7fff8c000000 r--p 00000000 00:00 0
> > 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
> > 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
> > 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
> > 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
> > 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
> > 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
> > 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
> > 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
> > 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
> > 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
> > 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
> > 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
> > 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
> > 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
> > 
> > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > index 4c4c35eac15e..0be008cba4b0 100644
> > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > @@ -56,21 +56,21 @@
> >   #ifdef __aarch64__
> >   #define HIGH_ADDR_MARK  ADDR_MARK_256TB
> > -#define HIGH_ADDR_SHIFT 49
> > +#define HIGH_ADDR_SHIFT 48
> >   #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
> >   #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
> >   #else
> >   #define HIGH_ADDR_MARK  ADDR_MARK_128TB
> > -#define HIGH_ADDR_SHIFT 48
> > +#define HIGH_ADDR_SHIFT 47
> >   #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
> >   #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
> >   #endif
> > -static char *hint_addr(void)
> > +static char *hint_addr(int hint)
> >   {
> > -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> > +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
> > -       return (char *) (1UL << bits);
> > +       return (char *) (addr);
> >   }
> >   static void validate_addr(char *ptr, int high_addr)
> > @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
> >          }
> >          for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> > -               hint = hint_addr();
> > +               hint = hint_addr(i);
> >                  hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
> >                                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
> Ah you sent it here, thanks. This is fine really, but the mystery is
> something else.
>

Thanks Dev

I can send out v2 with this patch included, right?

 
> 
> > 
> > 
> > Can we fix it this way?
> 

