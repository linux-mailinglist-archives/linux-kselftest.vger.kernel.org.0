Return-Path: <linux-kselftest+bounces-8463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3548AB360
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F42867C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92DB8562C;
	Fri, 19 Apr 2024 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="inJBvyKe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3377019F;
	Fri, 19 Apr 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544273; cv=none; b=j0tEFF2Bf8EuvGNTZllU5cI9prohTcV9hVlhmkiN5clgXZpQCDAk4ROg/cy/2d9fQaGzN9XxLBKRR7FDeyy0zoCgtsAF9gEM8I07cRLbQZrj7vgapUUk+h6og0lqR+Q4c8LHVg6z5c3kbbHCFT1KiHvJW5wk8wV5G0FYHyzSsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544273; c=relaxed/simple;
	bh=e+sKh/riBgM9gqEPNz95H+RMDL31hHi0as3niQKIC2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZ5NLhfEfkUqSHnpPJRlAgo5urv4LwIjp52LdOo18yO13AckH74oerz5esZaBcgWEa8fs4W+024eQjWh4PVAWQet1+OrnKYTI708yXE054bDTtQFrQTB0fwofEx2oUcPgxDCCPjPDL8lYe+QGGMhSiL4CWUhq4Hh0mSXj8WvHFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=inJBvyKe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JGDMri014023;
	Fri, 19 Apr 2024 16:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=0QDOhTWbuUFwBwep9Nu8IuqSeqIbHmzx424IXR2aSi4=;
 b=inJBvyKevVbI1FG8o8cIkohN3GsELo86yV4vdcaFQa5nHxwiVtpmpPUWXmfQZIoR2LQq
 A64fgWBiExv82BcqVyL6WA4xIKeFWnk0XJtkoV5AVDKyOUf6WndU2FWzmP+pOoHzlPle
 2RbCzcPkTIAPPMHW0jLoCGYSKgYl9hCuxMrqeCuX9bqC72vUtufLOjdAW3kWiiaqsbev
 7W1IVrQWTBtvXZBPQy0IPLppULuhycu4oqLkuiq/E51dSqEeDAdckSvXhFOkgUz+jjj/
 +N1ae8CKrkz/O4RiftrqU/hUzWeOgoeRfGpyq7y3SR1exXDzsIgoc7x3VYx6rw2uV487 pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkuxhg1k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 16:30:52 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43JGUq3l009001;
	Fri, 19 Apr 2024 16:30:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xkuxhg1jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 16:30:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43JFEbKX007847;
	Fri, 19 Apr 2024 16:30:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xkbmcvr58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 16:30:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43JGUlBp27394568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 16:30:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A34D82004D;
	Fri, 19 Apr 2024 16:30:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 115D32004E;
	Fri, 19 Apr 2024 16:30:46 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.32.113])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 19 Apr 2024 16:30:45 +0000 (GMT)
Date: Fri, 19 Apr 2024 19:30:44 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivansh Vij <shivanshvij@outlook.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v1 0/5] arm64/mm: uffd write-protect and soft-dirty
 tracking
Message-ID: <ZiKcNJ0Qw2awRwaa@linux.ibm.com>
References: <20240419074344.2643212-1-ryan.roberts@arm.com>
 <24999e38-e4f7-4616-8eae-dfdeba327558@arm.com>
 <MW4PR12MB6875618342F088BE6F4ECBB2B90D2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c936083b-68b7-4d8f-a8fc-d188e646f390@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ushm6xy8zROreUAp0pyD6uOja9Euat08
X-Proofpoint-GUID: 1P6pz-AyBt7CYRR6NKabWy3Sw0WAvmLF
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=603 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190125

On Fri, Apr 19, 2024 at 11:45:14AM +0200, David Hildenbrand wrote:
> On 19.04.24 10:33, Shivansh Vij wrote:
> > > On 19/04/2024 08:43, Ryan Roberts wrote:
> > > > Hi All,
> > > > 
> > > > This series adds uffd write-protect and soft-dirty tracking support for arm64. I
> > > > consider the soft-dirty support (patches 3 and 4) as RFC - see rationale below.
> > > > 
> > > > That said, these are the last 2 SW bits and we may want to keep 1 bit in reserve
> > > > for future use. soft-dirty is only used for CRIU to my knowledge, and it is
> > > > thought that their use case could be solved with the more generic uffd-wp. So
> > > > unless somebody makes a clear case for the inclusion of soft-dirty support, we
> > > > are probably better off dropping patches 3 and 4 and keeping bit 63 for future
> > > > use. Although note that the most recent attempt to add soft-dirty for arm64 was
> > > > last month [1] so I'd like to give Shivansh Vij the opportunity to make the
> > > > case.
> > 
> > Appreciate the opportunity to provide input here.
> > 
> > I picked option one (dirty tracking in arm) because it seems to be the
> > simplest way to move forward, whereas it would be a relatively heavy
> > effort to add uffd-wp support to CRIU.
> > 
> > From a performance perspective I am also a little worried that uffd
> > will be slower than just tracking the dirty bits asynchronously with
> > sw dirty, but maybe that's not as much of a concern with the addition
> > of uffd-wp async.
> > 
> > With all this being said, I'll defer to the wisdom of the crowd about
> > which approach makes more sense - after all, with this patch we should
> > get uffd-wp support on arm so at least there will be _a_ way forward
> > for CRIU (albeit one requiring slightly more work).
> 
> Ccing Mike and Peter. In 2017, Mike gave a presentation "Memory tracking for
> iterative container migration"[1] at LPC
> 
> Some key points are still true I think:
> (1) More flexible and robust than soft-dirty
> (2) May obsolete soft-dirty
> 
> We further recently added a new UFFD_FEATURE_WP_ASYNC feature as part of
> [2], because getting soft-dirty return reliable results in some cases turned
> out rather hard to fix.
> 
> We might still have to optimize that approach for some very sparse large
> VMAs, but that should be solvable.
> 
>  "The major defect of this approach of dirty tracking is we need to
>  populate the pgtables when tracking starts. Soft-dirty doesn't do it
>  like that. It's unwanted in the case where the range of memory to track
>  is huge and unpopulated (e.g., tracking updates on a 10G file with
>  mmap() on top, without having any page cache installed yet). One way to
>  improve this is to allow pte markers exist for larger than PTE level
>  for PMD+. That will not change the interface if to implemented, so we
>  can leave that for later.")[3]
> 
> 
> If we can avoid adding soft-dirty on arm64 that would be great. This will
> require work on the CRIU side. One downside of uffd-wp is that it is
> currently not as avilable on architectures as soft-dirty.

Using uffd-wp instead of soft-dirty in CRIU will require quite some work on
CRIU side and probably on the kernel side too.

And as of now we'll anyway have to maintain soft-dirty because powerpc and
s390 don't have uffd-wp.

With UFFD_FEATURE_WP_ASYNC the concern that uffd-wp will be slower than
soft-dirty probably doesn't exist, but we won't know for sure until
somebody will try.

But there were other limitations, the most prominent was checkpointing an
application that uses uffd. If CRIU is to use uffd-wp for tracking of the
dirty pages, there should be some support for multiple uffd contexts for a
VMA and that's surely a lot of work.

> But I'll throw in another idea: do we really need soft-dirty and uffd-wp to
> exist at the same time in the same process (or the VMA?). In theory, we

For instance to have dirty memory tracking in CRIU for an application that
uses uffd-wp :) 

> could have a VMA flag that defines the semantics of the bit and simply have
> arch code use a single, abstracted PTE bit. Requires a bit more work,
> though, but the benfit would be that architecturs that do support soft-dirty
> could support uffd-wp.
> 
> [1] https://blog.linuxplumbersconf.org/2017/ocw//system/presentations/4724/original/Memory%20tracking%20for%20iterative%20container%20migration.pdf
> [2] https://lore.kernel.org/all/20230821141518.870589-1-usama.anjum@collabora.com/
> [3] https://lore.kernel.org/all/20230821141518.870589-2-usama.anjum@collabora.com/
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

