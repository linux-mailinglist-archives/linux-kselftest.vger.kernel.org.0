Return-Path: <linux-kselftest+bounces-35813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3CCAE9537
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 07:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3DC1C249AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 05:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B726218858;
	Thu, 26 Jun 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cxzwIqop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A117BA5;
	Thu, 26 Jun 2025 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750916575; cv=none; b=r27UQyj17RgWoZyVfNBRqUGzYeoZFLrNSpHC3KIpxW03CVYkCOBaoEg+fRR7qrl9tb1ROiXOyNauDSRwC7bAu79Cnie1u4Scjo1VBnXn/hq5QNLXHuIbvpgxvMhY0+ytD9+rU1ABi5HgbA/F+oo8YZZEszDejaiWVYmrKQO1Urc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750916575; c=relaxed/simple;
	bh=dEKsfV9Xjghe3pw+J5xc/xhtM5agAB0M+kVsLcjCGFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTD1U/QGrhg4FlnfAkJQ2iwT6H31RanxVf9R7OzjF57+KLlRMUmNRNMh6R4Hb5iOE+VIJ29Y3xsNVl5FTEUEga1D0cEPIqIL8QkSur+ywlDZgf5MLZNTEfoEAez2McQUs+wmFEbi0dA9+TwUAtO+AhexFhPjuZzXN5bYHeJw66g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cxzwIqop; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AQfv010450;
	Thu, 26 Jun 2025 05:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sOrJ8G
	Aphij0HJ5Xs6m3kzHos33PQQPf5EHpYU1eO30=; b=cxzwIqop3UxYafb03IIB2h
	RMDliaLLJM8gBSrgXLCCj9U0nSGa+a1Ur20Tgdrp7W2MIuGGgTCnkXIFKi0CYzkz
	hEmGl8uGctU9Uop+W84bX4VU7BMfGIi204g/4JjfWwtHcyssBd6ZmlSqyfIUONS2
	UC5FxtP6GVk78Df9WZzwKYkc8zISXYpdtWUoQ1c5xVTjOfByyhB38nlNGiQN72eI
	n5rOuqITXZi6eUZiy4PdVg6hOKDIGPJMg0H6ZVGQCi6pAOEsREMnV0Dh9qQM1lHi
	eoeQXSQJ6JaqarBYtKaaDI2HR404bZ7uYOFXhZfKAGPikR9vOVbonvsB+20L26Ug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphj4jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:42:29 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55Q5XQKH008487;
	Thu, 26 Jun 2025 05:42:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphj4jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:42:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4Huk4030476;
	Thu, 26 Jun 2025 05:42:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7f05f29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 05:42:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55Q5gQ8x34669216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 05:42:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02B2A20043;
	Thu, 26 Jun 2025 05:42:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE4B220040;
	Thu, 26 Jun 2025 05:42:21 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com (unknown [9.39.20.202])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Jun 2025 05:42:21 +0000 (GMT)
Date: Thu, 26 Jun 2025 11:12:19 +0530
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
Message-ID: <aFzdu8YGN_jDxV1u@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
References: <8e23c5d3-6ce3-4fe8-b6fe-69658d5d0727@lucifer.local>
 <fc5c8193-2642-49f7-9f2a-00ad33353773@arm.com>
 <c93110a4-19e4-4a1d-b044-6b7f521eaa0d@lucifer.local>
 <815793f1-6800-4b9a-852e-f13d6308f50f@arm.com>
 <2756fa2b-e8bf-4c66-bf9b-c85dc63dfc33@lucifer.local>
 <41d9a70d-9791-4212-af23-5b13d8e4a47d@arm.com>
 <aFPI_blZGhvKSbNJ@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <16fff6e9-98f5-4004-9906-feac49f0bbb4@arm.com>
 <aFwvPj5AlCgTZsh2@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
 <3bc08930-06f3-443e-a267-ff02c2c053f6@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bc08930-06f3-443e-a267-ff02c2c053f6@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lVHs_38I1Ldak3jslNFFC7WXzoYprt6R
X-Proofpoint-ORIG-GUID: 3aj7SS2AqkrYnn52LRx4FsQjL-0gmZqi
X-Authority-Analysis: v=2.4 cv=Hul2G1TS c=1 sm=1 tr=0 ts=685cddc6 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=xq4N7M5HqdgJiB6KovIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0MCBTYWx0ZWRfXzIYjsrVhhAtf hRi7XEg2daWdHeYBYDWmA+nGX6Jzyn6FTA8UVWI5EY8/K4EzX/dK/dAr7pc9yrPoBE5QAxc7M1F t53Kap0wuUz3sTy6DgJw3Qw41zM5aSPnQY1cZZw/7Y4W2LahDssHRbmjMKyrqHBG0NyFIwSsuvg
 UHisxg5EpM0uJT3HqG0h9R3NUEkkNJmCbQFuQrRQzozHb5o33NhlD7tjOgidQ3/M6xvGrCbH1LY hm2BYFAF04178Pw3JyOB+/TLNfyek4FEtj2PV4sOjtjeRMXJhs1Igf4J/aesb8QvTjgUmJ2Qy7W TARwXZ/nb41HGrOdyKGTLRR7rUT98hOngeg7pG/UZe/Fynk3rndi6nKvhnKM3C109Z5WVlNbCgC
 xY8mQmkWgOiI7ivPfzTPYDCQUv5E8a4T6rtub3Rl81Hv3fSVMlI0WA6ivtMN07PS4gdqJrl8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260040

On Thu, Jun 26, 2025 at 09:27:30AM +0530, Dev Jain wrote:
> 
> On 25/06/25 10:47 pm, Donet Tom wrote:
> > On Wed, Jun 25, 2025 at 06:22:53PM +0530, Dev Jain wrote:
> > > On 19/06/25 1:53 pm, Donet Tom wrote:
> > > > On Wed, Jun 18, 2025 at 08:13:54PM +0530, Dev Jain wrote:
> > > > > On 18/06/25 8:05 pm, Lorenzo Stoakes wrote:
> > > > > > On Wed, Jun 18, 2025 at 07:47:18PM +0530, Dev Jain wrote:
> > > > > > > On 18/06/25 7:37 pm, Lorenzo Stoakes wrote:
> > > > > > > > On Wed, Jun 18, 2025 at 07:28:16PM +0530, Dev Jain wrote:
> > > > > > > > > On 18/06/25 5:27 pm, Lorenzo Stoakes wrote:
> > > > > > > > > > On Wed, Jun 18, 2025 at 05:15:50PM +0530, Dev Jain wrote:
> > > > > > > > > > Are you accounting for sys.max_map_count? If not, then you'll be hitting that
> > > > > > > > > > first.
> > > > > > > > > run_vmtests.sh will run the test in overcommit mode so that won't be an issue.
> > > > > > > > Umm, what? You mean overcommit all mode, and that has no bearing on the max
> > > > > > > > mapping count check.
> > > > > > > > 
> > > > > > > > In do_mmap():
> > > > > > > > 
> > > > > > > > 	/* Too many mappings? */
> > > > > > > > 	if (mm->map_count > sysctl_max_map_count)
> > > > > > > > 		return -ENOMEM;
> > > > > > > > 
> > > > > > > > 
> > > > > > > > As well as numerous other checks in mm/vma.c.
> > > > > > > Ah sorry, didn't look at the code properly just assumed that overcommit_always meant overriding
> > > > > > > this.
> > > > > > No problem! It's hard to be aware of everything in mm :)
> > > > > > 
> > > > > > > > I'm not sure why an overcommit toggle is even necessary when you could use
> > > > > > > > MAP_NORESERVE or simply map PROT_NONE to avoid the OVERCOMMIT_GUESS limits?
> > > > > > > > 
> > > > > > > > I'm pretty confused as to what this test is really achieving honestly. This
> > > > > > > > isn't a useful way of asserting mmap() behaviour as far as I can tell.
> > > > > > > Well, seems like a useful way to me at least : ) Not sure if you are in the mood
> > > > > > > to discuss that but if you'd like me to explain from start to end what the test
> > > > > > > is doing, I can do that : )
> > > > > > > 
> > > > > > I just don't have time right now, I guess I'll have to come back to it
> > > > > > later... it's not the end of the world for it to be iffy in my view as long as
> > > > > > it passes, but it might just not be of great value.
> > > > > > 
> > > > > > Philosophically I'd rather we didn't assert internal implementation details like
> > > > > > where we place mappings in userland memory. At no point do we promise to not
> > > > > > leave larger gaps if we feel like it :)
> > > > > You have a fair point. Anyhow a debate for another day.
> > > > > 
> > > > > > I'm guessing, reading more, the _real_ test here is some mathematical assertion
> > > > > > about layout from HIGH_ADDR_SHIFT -> end of address space when using hints.
> > > > > > 
> > > > > > But again I'm not sure that achieves much and again also is asserting internal
> > > > > > implementation details.
> > > > > > 
> > > > > > Correct behaviour of this kind of thing probably better belongs to tests in the
> > > > > > userland VMA testing I'd say.
> > > > > > 
> > > > > > Sorry I don't mean to do down work you've done before, just giving an honest
> > > > > > technical appraisal!
> > > > > Nah, it will be rather hilarious to see it all go down the drain xD
> > > > > 
> > > > > > Anyway don't let this block work to fix the test if it's failing. We can revisit
> > > > > > this later.
> > > > > Sure. @Aboorva and Donet, I still believe that the correct approach is to elide
> > > > > the gap check at the crossing boundary. What do you think?
> > > > > 
> > > > One problem I am seeing with this approach is that, since the hint address
> > > > is generated randomly, the VMAs are also being created at randomly based on
> > > > the hint address.So, for the VMAs created at high addresses, we cannot guarantee
> > > > that the gaps between them will be aligned to MAP_CHUNK_SIZE.
> > > > 
> > > > High address VMAs
> > > > -----------------
> > > > 1000000000000-1000040000000 r--p 00000000 00:00 0
> > > > 2000000000000-2000040000000 r--p 00000000 00:00 0
> > > > 4000000000000-4000040000000 r--p 00000000 00:00 0
> > > > 8000000000000-8000040000000 r--p 00000000 00:00 0
> > > > e80009d260000-fffff9d260000 r--p 00000000 00:00 0
> > > > 
> > > > I have a different approach to solve this issue.
> > > > 
> > > >   From 0 to 128TB, we map memory directly without using any hint. For the range above
> > > > 256TB up to 512TB, we perform the mapping using hint addresses. In the current test,
> > > > we use random hint addresses, but I have modified it to generate hint addresses linearly
> > > > starting from 128TB.
> > > > 
> > > > With this change:
> > > > 
> > > > The 0–128TB range is mapped without hints and verified accordingly.
> > > > 
> > > > The 128TB–512TB range is mapped using linear hint addresses and then verified.
> > > > 
> > > > Below are the VMAs obtained with this approach:
> > > > 
> > > > 10000000-10010000 r-xp 00000000 fd:05 135019531
> > > > 10010000-10020000 r--p 00000000 fd:05 135019531
> > > > 10020000-10030000 rw-p 00010000 fd:05 135019531
> > > > 20000000-10020000000 r--p 00000000 00:00 0
> > > > 10020800000-10020830000 rw-p 00000000 00:00 0
> > > > 1004bcf0000-1004c000000 rw-p 00000000 00:00 0
> > > > 1004c000000-7fff8c000000 r--p 00000000 00:00 0
> > > > 7fff8c130000-7fff8c360000 r-xp 00000000 fd:00 792355
> > > > 7fff8c360000-7fff8c370000 r--p 00230000 fd:00 792355
> > > > 7fff8c370000-7fff8c380000 rw-p 00240000 fd:00 792355
> > > > 7fff8c380000-7fff8c460000 r-xp 00000000 fd:00 792358
> > > > 7fff8c460000-7fff8c470000 r--p 000d0000 fd:00 792358
> > > > 7fff8c470000-7fff8c480000 rw-p 000e0000 fd:00 792358
> > > > 7fff8c490000-7fff8c4d0000 r--p 00000000 00:00 0
> > > > 7fff8c4d0000-7fff8c4e0000 r-xp 00000000 00:00 0
> > > > 7fff8c4e0000-7fff8c530000 r-xp 00000000 fd:00 792351
> > > > 7fff8c530000-7fff8c540000 r--p 00040000 fd:00 792351
> > > > 7fff8c540000-7fff8c550000 rw-p 00050000 fd:00 792351
> > > > 7fff8d000000-7fffcd000000 r--p 00000000 00:00 0
> > > > 7fffe9c80000-7fffe9d90000 rw-p 00000000 00:00 0
> > > > 800000000000-2000000000000 r--p 00000000 00:00 0    -> High Address (128TB to 512TB)
> > > > 
> > > > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > > > index 4c4c35eac15e..0be008cba4b0 100644
> > > > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > > > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > > > @@ -56,21 +56,21 @@
> > > >    #ifdef __aarch64__
> > > >    #define HIGH_ADDR_MARK  ADDR_MARK_256TB
> > > > -#define HIGH_ADDR_SHIFT 49
> > > > +#define HIGH_ADDR_SHIFT 48
> > > >    #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
> > > >    #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
> > > >    #else
> > > >    #define HIGH_ADDR_MARK  ADDR_MARK_128TB
> > > > -#define HIGH_ADDR_SHIFT 48
> > > > +#define HIGH_ADDR_SHIFT 47
> > > >    #define NR_CHUNKS_LOW   NR_CHUNKS_128TB
> > > >    #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
> > > >    #endif
> > > > -static char *hint_addr(void)
> > > > +static char *hint_addr(int hint)
> > > >    {
> > > > -       int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> > > > +       unsigned long addr = ((1UL << HIGH_ADDR_SHIFT) + (hint * MAP_CHUNK_SIZE));
> > > > -       return (char *) (1UL << bits);
> > > > +       return (char *) (addr);
> > > >    }
> > > >    static void validate_addr(char *ptr, int high_addr)
> > > > @@ -217,7 +217,7 @@ int main(int argc, char *argv[])
> > > >           }
> > > >           for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> > > > -               hint = hint_addr();
> > > > +               hint = hint_addr(i);
> > > >                   hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
> > > >                                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > Ah you sent it here, thanks. This is fine really, but the mystery is
> > > something else.
> > > 
> > Thanks Dev
> > 
> > I can send out v2 with this patch included, right?
> 
> Sorry not yet :) this patch will just hide the real problem, which
> is, after the hint addresses get exhausted, why on ppc the kernel
> cannot find a VMA to install despite having such large gaps between
> VMAs.


I think there is some confusion here, so let me clarify.

On PowerPC, mmap is able to find VMAs both with and without a hint.
There is no issue there. If you look at the test, from 0 to 128TB we
are mapping without any hint, and the VMAs are getting created as
expected.

Above 256TB, we are mapping with random hint addresses, and with
those hints, all VMAs are being created above 258TB. No mmap call
is failing in this case.

The problem is with the test itself: since we are providing random
hint addresses, the VMAs are also being created at random locations.

Below is the VMAs created with hint addreess

1. 256TB hint address

1000000000000-1000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]

2. 512TB hint address
2000000000000-2000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]

3. 1024TB Hint address
4000000000000-4000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]

4. 2048TB hint Address
8000000000000-8000040000000 r--p 00000000 00:00 0                        [anon:virtual_address_range]

5. above 3096 Hint address
eb95410220000-fffff90220000 r--p 00000000 00:00 0                        [anon:virtual_address_range].


We support up to 4PB, and since the hint addresses are random,
the VMAs are created at random locations.

With sequential hint addresses from 128TB to 512TB, we provide the
hint addresses in order, and the VMAs are created at the hinted
addresses.

Within 512TB, we were able to test both high and low addresses, so
I thought sequential hinting would be a good approach. Since there
has been a lot of confusion, I’m considering adding a complete 4PB
allocation test — from 0 to 128TB we allocate without any hint, and
from 128TB onward we use sequential hint addresses.

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index e24c36a39f22..f2009d23f8b2 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -50,6 +50,7 @@
 #define NR_CHUNKS_256TB   (NR_CHUNKS_128TB * 2UL)
 #define NR_CHUNKS_384TB   (NR_CHUNKS_128TB * 3UL)
 #define NR_CHUNKS_3840TB  (NR_CHUNKS_128TB * 30UL)
+#define NR_CHUNKS_3968TB  (NR_CHUNKS_128TB * 31UL)
 
 #define ADDR_MARK_128TB  (1UL << 47) /* First address beyond 128TB */
 #define ADDR_MARK_256TB  (1UL << 48) /* First address beyond 256TB */
@@ -59,6 +60,11 @@
 #define HIGH_ADDR_SHIFT 49
 #define NR_CHUNKS_LOW   NR_CHUNKS_256TB
 #define NR_CHUNKS_HIGH  NR_CHUNKS_3840TB
+#elif defined(__PPC64__)
+#define HIGH_ADDR_MARK  ADDR_MARK_128TB
+#define HIGH_ADDR_SHIFT 47
+#define NR_CHUNKS_LOW   NR_CHUNKS_128TB
+#define NR_CHUNKS_HIGH  NR_CHUNKS_3968TB
 #else
 #define HIGH_ADDR_MARK  ADDR_MARK_128TB
 #define HIGH_ADDR_SHIFT 48


With this the test is passing. 



> 
> It should be quite easy to trace which function is failing. Can you
> please do some debugging for me? Otherwise I will have to go ahead
> with setting up a PPC VM and testing myself :)
> 
> > 
> > > > 
> > > > Can we fix it this way?

