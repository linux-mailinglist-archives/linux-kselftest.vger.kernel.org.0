Return-Path: <linux-kselftest+bounces-35543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFFAE2AE2
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608403BAB08
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 17:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EAD22F767;
	Sat, 21 Jun 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N7DFUikO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DCB21480C;
	Sat, 21 Jun 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528572; cv=none; b=I5QNTWZcoDi38IEL0vZJV96v4hjvkn2a9VeizbRxESuN8BzajBn0tn1OU39xGXwrjfIun2bRqFFKg5itQnEhs3mGEKf+ndRQsdYQ/3Zrk0zrBhP3SPwXxGXT0ufz6ZjviniaKxi1yIwpkSmngAqBb5fskXrGHE+EhWhGlEtUaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528572; c=relaxed/simple;
	bh=eyI5u6J2o4/7qDOz4rlLDDSIwLXzDfWGrbyHoZzHNFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5AdRqkt/DkQzceKgXvac2sDjMvUu2uoBrRpis7sjAZm0rDPiOgPKf6Dzu6ToT5c2GtLHQwZ/wTE5yq5QUE+bQ1PMcUYg/PKuvRAJB6mcyFbDArqzskikarsVDbuCsspr0RBKzDnKeAdEhHT0Vdd0cnPsjniHaJG65VCW1ppFKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N7DFUikO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55L31B97012718;
	Sat, 21 Jun 2025 17:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=S6vqhG
	5G1JSydGNxvG1OfuFimsaHOrEmy285Hilc3vE=; b=N7DFUikO0PIG5Il7MpCZI7
	LRQDDRpdBkHF1vnKOswGPzMd+WY0nVXCsboBL+trG0Ed5Bi3HL/lKID/Gbu+mf4V
	IsjN0DKMw1T2jwLYDDqdeh8saYSRIJ52jVp22Qc4kafNok0Tlg5BfKnn1A40VRxd
	Nj52T2PtaHauFjhhrxPRA6ZV6mhjKIHauc4IonAaBusSYDLTfV2C7a1Kn+DqpwWz
	hESxpGyDGPFGqSFP25kMIofPGONC+OF/3eubhYBijwCZD7Yby3m5TNOis4vTh53k
	JiMVwIaCWycAoAsyrufjmuOt5QXna/h15/9gtBdEGOLEECxAsDqAoPGUFH7YD3hg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2j5j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 17:55:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55LHtjvb030450;
	Sat, 21 Jun 2025 17:55:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2j5hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 17:55:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55LEWBd9016454;
	Sat, 21 Jun 2025 17:55:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47dnmttafq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Jun 2025 17:55:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55LHtgBs43450712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Jun 2025 17:55:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A268020043;
	Sat, 21 Jun 2025 17:55:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C951520040;
	Sat, 21 Jun 2025 17:55:38 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com (unknown [9.39.19.74])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 21 Jun 2025 17:55:38 +0000 (GMT)
Date: Sat, 21 Jun 2025 23:25:32 +0530
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
Message-ID: <aFbyFMjVs9F3KMex@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
References: <79bdd993-0e9c-4d7d-b42c-4b5750eff140@lucifer.local>
 <aaddfd0b-216e-48fe-b48f-35c78eabcf9a@arm.com>
 <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <546d7aa5-9ea3-4fce-a604-b1676a61d6cd@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <546d7aa5-9ea3-4fce-a604-b1676a61d6cd@arm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=6856f222 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=JtdZ57Qmit2b2QAxn08A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIxMDExMiBTYWx0ZWRfX+8ATTUM9wAQU 7JfMu5h7goBSlcxsH2BMea9GFzetD9sK3IV7WtPMcVfMIZ20fMYVdEtS94/kE0Pi/aOifL1WqQb WUrpXlOZ//Pqw3J/k2GYqmy44XNcIaU4+rIY/SNtj5d+JqydIM83XmIQkbnYmTqRBLRKuBcg++L
 IeCXC+dO3qgbd02LZ3qSbZaeZ+yQZQ91s9i9W4pbTA2mNgr5FWgR36vK2qjcyzeehfIhXfsWxil fGVydNvuUjTeQI+aQwt3U1TdvSAwXkWfgfJQSZcyZAWYdYqvRAct9hvXIFHhQstYMbxGmIns2Ur EOhwxAqL1DUhrUBsPM8tznoRJD2FXYhidjunmF7hCY5eFssxedCdbu04690Y/2uTdaqZfBcLJ+P
 6wo4qE7tclZy6IFE9FsJXXNB9fNV4cfU/3SsOY/v0T4ePy5sjKJg7/qfVBF3kUbTXB38zEKR
X-Proofpoint-GUID: ukINjQB-lGGfj2CMS7OoxHew3IYA_m3N
X-Proofpoint-ORIG-GUID: cfcNXgqtgTRHpqFGbFJ3eZFKoCGPw0yb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-21_05,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506210112

On Fri, Jun 20, 2025 at 08:15:25PM +0530, Dev Jain wrote:
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
> 
> It is really weird that such a large amount of VA space
> is left between the two VMAs yet mmap is failing.
> 
> 
> 
> Can you please do the following:
> set /proc/sys/vm/max_map_count to the highest value possible.
> If running without run_vmtests.sh, set /proc/sys/vm/overcommit_memory to 1.
> In validate_complete_va_space:
> 
> if (start_addr >= HIGH_ADDR_MARK && found == false) {
> 	found = true;
> 	continue;
> }


Thanks Dev for the suggestion. I set max_map_count and set overcommit
memory to 1, added this code change as well, and then tried. Still, the
test is failing

> 
> where found is initialized to false. This will skip the check
> for the boundary.
> 
> After this can you tell whether the test is still failing.
> 
> Also can you give me the complete output of proc/pid/maps
> after putting a sleep at the end of the test.
> 


on powerpc support DEFAULT_MAP_WINDOW is 128TB and with
total address space size is 4PB With hint it can map upto
4PB. Since the hint addres is random in this test random hing VMAs
are getting created. IIUC this is expected only.


10000000-10010000 r-xp 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
10010000-10020000 r--p 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
10020000-10030000 rw-p 00010000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
30000000-10030000000 r--p 00000000 00:00 0                               [anon:virtual_address_range]
10030770000-100307a0000 rw-p 00000000 00:00 0                            [heap]
1004f000000-7fff8f000000 r--p 00000000 00:00 0                           [anon:virtual_address_range]
7fff8faf0000-7fff8fe00000 rw-p 00000000 00:00 0
7fff8fe00000-7fff90030000 r-xp 00000000 fd:00 792355                     /usr/lib64/libc.so.6
7fff90030000-7fff90040000 r--p 00230000 fd:00 792355                     /usr/lib64/libc.so.6
7fff90040000-7fff90050000 rw-p 00240000 fd:00 792355                     /usr/lib64/libc.so.6
7fff90050000-7fff90130000 r-xp 00000000 fd:00 792358                     /usr/lib64/libm.so.6
7fff90130000-7fff90140000 r--p 000d0000 fd:00 792358                     /usr/lib64/libm.so.6
7fff90140000-7fff90150000 rw-p 000e0000 fd:00 792358                     /usr/lib64/libm.so.6
7fff90160000-7fff901a0000 r--p 00000000 00:00 0                          [vvar]
7fff901a0000-7fff901b0000 r-xp 00000000 00:00 0                          [vdso]
7fff901b0000-7fff90200000 r-xp 00000000 fd:00 792351                     /usr/lib64/ld64.so.2
7fff90200000-7fff90210000 r--p 00040000 fd:00 792351                     /usr/lib64/ld64.so.2
7fff90210000-7fff90220000 rw-p 00050000 fd:00 792351                     /usr/lib64/ld64.so.2
7fffc9770000-7fffc9880000 rw-p 00000000 00:00 0                          [stack]
1000000000000-1000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
2000000000000-2000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
4000000000000-4000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
8000000000000-8000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]
eb95410220000-fffff90220000 r--p 00000000 00:00 0                        [anon:virtual_address_range]




If I give the hint address serially from 128TB then the address 
space is contigous and gap is also MAP_SIZE, the test is passing.

10000000-10010000 r-xp 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
10010000-10020000 r--p 00000000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
10020000-10030000 rw-p 00010000 fd:05 134226638                          /home/donet/linux/tools/testing/selftests/mm/virtual_address_range
33000000-10033000000 r--p 00000000 00:00 0                               [anon:virtual_address_range]
10033380000-100333b0000 rw-p 00000000 00:00 0                            [heap]
1006f0f0000-10071000000 rw-p 00000000 00:00 0
10071000000-7fffb1000000 r--p 00000000 00:00 0                           [anon:virtual_address_range]
7fffb15d0000-7fffb1800000 r-xp 00000000 fd:00 792355                     /usr/lib64/libc.so.6
7fffb1800000-7fffb1810000 r--p 00230000 fd:00 792355                     /usr/lib64/libc.so.6
7fffb1810000-7fffb1820000 rw-p 00240000 fd:00 792355                     /usr/lib64/libc.so.6
7fffb1820000-7fffb1900000 r-xp 00000000 fd:00 792358                     /usr/lib64/libm.so.6
7fffb1900000-7fffb1910000 r--p 000d0000 fd:00 792358                     /usr/lib64/libm.so.6
7fffb1910000-7fffb1920000 rw-p 000e0000 fd:00 792358                     /usr/lib64/libm.so.6
7fffb1930000-7fffb1970000 r--p 00000000 00:00 0                          [vvar]
7fffb1970000-7fffb1980000 r-xp 00000000 00:00 0                          [vdso]
7fffb1980000-7fffb19d0000 r-xp 00000000 fd:00 792351                     /usr/lib64/ld64.so.2
7fffb19d0000-7fffb19e0000 r--p 00040000 fd:00 792351                     /usr/lib64/ld64.so.2
7fffb19e0000-7fffb19f0000 rw-p 00050000 fd:00 792351                     /usr/lib64/ld64.so.2
7fffc5470000-7fffc5580000 rw-p 00000000 00:00 0                          [stack]
800000000000-2aab000000000 r--p 00000000 00:00 0                         [anon:virtual_address_range]




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
> > 
> > 
> > 
> > Can we fix it this way?

