Return-Path: <linux-kselftest+bounces-35264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB831ADE82D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE3163B05
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A5F284B27;
	Wed, 18 Jun 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GQwTeFzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE627EFF3;
	Wed, 18 Jun 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241225; cv=none; b=SrDRGtkuo0aARuaoDeIJUwdDq6+Dm1d8EkEeINllfc/stZCgC39jB25Mq+RFueJGLjbeWyqMI2VeKTEUpgWb9Ef7EGR1DFav3P7YD5KR/AHX6RKZSYBBzMQuU8bmh+6MC0Br6W0/OdnvHl7EaEJcvTkcO2XwuygZN7gfPf66UQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241225; c=relaxed/simple;
	bh=rwTZAlZrOCLSXn0KrNJuf6Su0xxM+KA2OW+7t9UVHA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsMiqPSTb1FAjLrje6iRuzuYvGFO31aIKhHu5lyUNne7DJWwxmTNWPv3yrWg4FAEI8EPfvSO46BqKuPvKp+Gd76y7msaA4GJ/n2H9RXxyLwtyiQMcaLIgbpOg77wZpCNJ5Ptp3HE70SVn8JpznYv0+I5O9moSQTNC2w/Hy68Z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GQwTeFzw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IA6hoK012683;
	Wed, 18 Jun 2025 10:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qYMhSF
	SIcurRQ5/kwmGEyzUvu1YebB8hyIiHimGszrY=; b=GQwTeFzwPJt9BIQDIwZbIQ
	8pPs4pQKw+y71tOAxAsd2bFGHeVdRdXnmiXJXfI4Ry33VYdLe3KskI/D3Kk2qcqN
	3SrCJ/kMxFGvYd6HL+eJ8VVyaXxCwcePpVlDy2/c3CueWvWf4f4gweQuYcei4B2s
	3nbXozSEPQqIE+mW4NxvKF6x1Wd50eBx7ck9I/zS77Hh8BxTZ55PBz2MMGsE8ji8
	wIubS7PHqtBTqHTnrzVDDpm0n4hLWdIK8WPNMkIdnw4QesgW+w0ica8lCHI0ZGBP
	JH0AUUcnnqDuBUh4XThlj+hSoJdE7vjAEB0l+LmyzGGWH0PnrbDgM1XneVn1n3nw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qpcwdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 10:06:49 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55IA6mDd019616;
	Wed, 18 Jun 2025 10:06:48 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qpcwdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 10:06:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8Uqm4005492;
	Wed, 18 Jun 2025 10:06:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwm89he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Jun 2025 10:06:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55IA6jOC57016598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 10:06:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F8D82004E;
	Wed, 18 Jun 2025 10:06:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE9CD2005A;
	Wed, 18 Jun 2025 10:06:41 +0000 (GMT)
Received: from li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com (unknown [9.109.245.113])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 18 Jun 2025 10:06:41 +0000 (GMT)
Date: Wed, 18 Jun 2025 15:36:36 +0530
From: Donet Tom <donettom@linux.ibm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
        baohua@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Message-ID: <aFKPrN4w_ynPA038@li-06431bcc-2712-11b2-a85c-a6fe68df28f9.ibm.com>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
 <20250616160632.35250-2-aboorvad@linux.ibm.com>
 <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0665a8d3-7094-4732-9518-01ac313959e1@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UYGbt7kKFqt3P0dA_zb5zO92gbHO7IEN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA4NCBTYWx0ZWRfX7OlJlVTK2lAZ Brz2fuNKtHVh/z27HCxfPebcHXyes8GCEChlB0vvnINbyrNLH6TzoaUvHE9Y/i+iku4Dm0hFiqC MLGG5jMf5YSF4IzAhFHaD1qE2xU1JPIbHALBj7fZezoPOOq9u1i+LhysYzlFwrAj+m8sRWZRRE5
 LTxAnFk2jde4DRT+rV/R6+pU0X+A/7Uqi1aWSBiVYauQ8CinnZT3ZLYbDlnQ8Uxf+58Nn4xkME1 QCywziv+qrF1N4UrVeRYxheK/hsSZVkfTnNgq6fg9TBPIFi76ksxmxaUlbnOI7hHb39ZidBkkez MwBUINmIvYqvCog/ApP2TEma1pXiyMkKjwxljOGXePKnu9eATnJv9d8DXSwTQXyJV+6LABSr+uu
 On58b7lE+eVXE6YNGt3cX1uFri+79ftK8JquhfIWbQhbQVkkfZJhDHajeqjPyNo+NgKbjKZH
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=68528fb9 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=0sDYKrj5Twn3_edcOV8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: SjqPB70G2LfhDLKvXppKo6gZSJg96_S8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180084

On Mon, Jun 16, 2025 at 09:57:10PM +0530, Dev Jain wrote:
> 

Hi Dev

> On 16/06/25 9:36 pm, Aboorva Devarajan wrote:
> > From: Donet Tom <donettom@linux.ibm.com>
> > 
> > In this patch, we are fixing three issues in the virtual_address_range
> > test.
> > 
> > 1. validate_addr() checks if the allocated address is within the range.
> > In the current implementation, if addr is greater than HIGH_ADDR_MARK,
> > the test fails. However, addr will be greater than HIGH_ADDR_MARK if
> > high_addr is set. Therefore, if high_addr is set, we should not check
> > the (addr > HIGH_ADDR_MARK) condition.
> > 
> > 2.In main(), the high address is stored in hptr, but for mark_range(),
> > the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
> > hptr[i] in mark_range() function call.
> > 
> > 3./proc/self/maps may not always have gaps smaller than MAP_CHUNK_SIZE.
> > The gap between the first high address mapping and the previous mapping
> > is not smaller than MAP_CHUNK_SIZE.
> 
> For this, can't we just elide the check when we cross the high boundary?
> As I see it you are essentially nullifying the purpose of validate_complete_va_space;
> I had written that function so as to have an alternate way of checking VA exhaustion
> without relying on mmap correctness in a circular way.
>

In this test, we first allocate 128TB of low memory and verify that
the allocated area falls within the expected range.

Next, we allocate memory at high addresses and check whether the
returned addresses are within the specified limits. To allocate
memory at a high address, we pass a hint address. This hint address
is derived using HIGH_ADDR_SHIFT, which is set to 48 — corresponding
to 256TB. So, we are requesting allocation at the 256TB address, and
the memory is successfully allocated there. Since the low address
region is allocated up to 128TB, there is a gap between the low address
VMA and the high address VMA .

Additionally, we use a random number to generate the hint address, so
the actual allocated address will vary but will always be above 256TB.


10000000-10010000 r-xp 00000000 fd:05 134255559                       
10010000-10020000 r--p 00000000 fd:05 134255559                         
10020000-10030000 rw-p 00010000 fd:05 134255559                       
10022b80000-10022bb0000 rw-p 00000000 00:00 0                            
7fff5c000000-7fff9c000000 r--p 00000000 00:00 0                          
7fff9cb30000-7fff9ce40000 rw-p 00000000 00:00 0 
7fff9ce40000-7fff9d070000 r-xp 00000000 fd:00 792355                   
7fff9d070000-7fff9d080000 r--p 00230000 fd:00 792355                  
7fff9d080000-7fff9d090000 rw-p 00240000 fd:00 792355                    
7fff9d090000-7fff9d170000 r-xp 00000000 fd:00 792358                    
7fff9d170000-7fff9d180000 r--p 000d0000 fd:00 792358                     
7fff9d180000-7fff9d190000 rw-p 000e0000 fd:00 792358                    
7fff9d1a0000-7fff9d1e0000 r--p 00000000 00:00 0                          
7fff9d1e0000-7fff9d1f0000 r-xp 00000000 00:00 0                      
7fff9d1f0000-7fff9d240000 r-xp 00000000 fd:00 792351                   
7fff9d240000-7fff9d250000 r--p 00040000 fd:00 792351                     
7fff9d250000-7fff9d260000 rw-p 00050000 fd:00 792351                    
7fffecfa0000-7fffecfd0000 rw-p 00000000 00:00 0                         
1000000000000-1000040000000 r--p 00000000 00:00 0           -> High address           
2000000000000-2000040000000 r--p 00000000 00:00 0                       
4000000000000-4000040000000 r--p 00000000 00:00 0                        
8000000000000-8000040000000 r--p 00000000 00:00 0                        
e80009d260000-fffff9d260000 r--p 00000000 00:00 0                       
                    

The high address we are getting is at 256TB because we are explicitly
requesting it. The gap between the high address VMA and the previous VMA
is large because the low memory allocation goes up to 128TB.

If I understand correctly, this test is verifying whether the allocated
address falls within the expected range, and validate_complete_va_space()
is validating the allocated virtual address space.

Why do we need to check whether the gap between two VMAs is within
MAP_CHUNK_SIZE? Should it validate only the allocated VMAs?

Thanks
Donet
 
> Btw @Lorenzo, validate_complete_va_space was written by me as my first patch ever for
> the Linux kernel : ) from the limited knowledge I have of VMA stuff, I guess the
> only requirement for VMA alignment is PAGE_SIZE in this test, therefore, the only
> check required is that the gap between two VMAs should be at least MAP_CHUNK_SIZE?
> Or can such a gap still exist even when the VA has been exhausted?
> 
> > 
> > $cat /proc/3713/maps
> > 10000000-10010000 r-xp 00000000 fd:00 36140094
> > 10010000-10020000 r--p 00000000 fd:00 36140094
> > 10020000-10030000 rw-p 00010000 fd:00 36140094
> > 4ee80000-4eeb0000 rw-p 00000000 00:00 0
> > 578f0000-57c00000 rw-p 00000000 00:00 0
> > 57c00000-7fff97c00000 r--p 00000000 00:00 0
> > 7fff97c00000-7fff97e20000 r-xp 00000000 fd:00 33558923
> > 7fff97e20000-7fff97e30000 r--p 00220000 fd:00 33558923
> > 7fff97e30000-7fff97e40000 rw-p 00230000 fd:00 33558923
> > 7fff97f40000-7fff98020000 r-xp 00000000 fd:00 33558924
> > 7fff98020000-7fff98030000 r--p 000d0000 fd:00 33558924
> > 7fff98030000-7fff98040000 rw-p 000e0000 fd:00 33558924
> > 7fff98050000-7fff98090000 r--p 00000000 00:00 0
> > 7fff98090000-7fff980a0000 r-xp 00000000 00:00 0
> > 7fff980a0000-7fff980f0000 r-xp 00000000 fd:00 2634
> > 7fff980f0000-7fff98100000 r--p 00040000 fd:00 2634
> > 7fff98100000-7fff98110000 rw-p 00050000 fd:00 2634
> > 7fffcf8a0000-7fffcf9b0000 rw-p 00000000 00:00 0
> > 1000000000000-1000040000000 r--p 00000000 00:00 0   --> High Addr
> > 2000000000000-2000040000000 r--p 00000000 00:00 0
> > 4000000000000-4000040000000 r--p 00000000 00:00 0
> > 8000000000000-8000040000000 r--p 00000000 00:00 0
> > e800098110000-fffff98110000 r--p 00000000 00:00 0
> > $
> > 
> > In this patch, the condition that checks for gaps smaller than MAP_CHUNK_SIZE has been removed.
> > 
> > Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
> > Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
> > Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> >   tools/testing/selftests/mm/virtual_address_range.c | 14 +++-----------
> >   1 file changed, 3 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> > index b380e102b22f..606e601a8984 100644
> > --- a/tools/testing/selftests/mm/virtual_address_range.c
> > +++ b/tools/testing/selftests/mm/virtual_address_range.c
> > @@ -80,7 +80,7 @@ static void validate_addr(char *ptr, int high_addr)
> >   	if (high_addr && addr < HIGH_ADDR_MARK)
> >   		ksft_exit_fail_msg("Bad address %lx\n", addr);
> > -	if (addr > HIGH_ADDR_MARK)
> > +	if (!high_addr && addr > HIGH_ADDR_MARK)
> >   		ksft_exit_fail_msg("Bad address %lx\n", addr);
> >   }
> > @@ -117,7 +117,7 @@ static int validate_lower_address_hint(void)
> >   static int validate_complete_va_space(void)
> >   {
> > -	unsigned long start_addr, end_addr, prev_end_addr;
> > +	unsigned long start_addr, end_addr;
> >   	char line[400];
> >   	char prot[6];
> >   	FILE *file;
> > @@ -134,7 +134,6 @@ static int validate_complete_va_space(void)
> >   	if (file == NULL)
> >   		ksft_exit_fail_msg("cannot open /proc/self/maps\n");
> > -	prev_end_addr = 0;
> >   	while (fgets(line, sizeof(line), file)) {
> >   		const char *vma_name = NULL;
> >   		int vma_name_start = 0;
> > @@ -151,12 +150,6 @@ static int validate_complete_va_space(void)
> >   		if (start_addr & (1UL << 63))
> >   			return 0;
> > -		/* /proc/self/maps must have gaps less than MAP_CHUNK_SIZE */
> > -		if (start_addr - prev_end_addr >= MAP_CHUNK_SIZE)
> > -			return 1;
> > -
> > -		prev_end_addr = end_addr;
> > -
> >   		if (prot[0] != 'r')
> >   			continue;
> > @@ -223,8 +216,7 @@ int main(int argc, char *argv[])
> >   		if (hptr[i] == MAP_FAILED)
> >   			break;
> > -
> > -		mark_range(ptr[i], MAP_CHUNK_SIZE);
> > +		mark_range(hptr[i], MAP_CHUNK_SIZE);
> >   		validate_addr(hptr[i], 1);
> >   	}
> >   	hchunks = i;

