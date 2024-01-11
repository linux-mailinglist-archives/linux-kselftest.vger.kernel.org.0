Return-Path: <linux-kselftest+bounces-2817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195A882A5CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 03:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC221282449
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 02:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A9F7ED;
	Thu, 11 Jan 2024 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IH1ZeZrj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B810E1
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Jan 2024 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704938917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmEEcsA0fyriEKAX8TlwhNLaVQANlK3RwRydup4EB8s=;
	b=IH1ZeZrj6G+es7br9lTnFYyTgS8/NZ0PXntEb9/Z50vjKtlOktUF47bs/H13CEyBNEL2G4
	Rtdm1BiJg+oE9KqACaizjUPUDDtYR5OwEN4CIDMNootAWjFqNFtLBWJ976MsR1q1AcffSr
	nHPjaiVp52YhioD9c5kbusjZypUg/44=
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] selftests: mm: hugepage-vmemmap fails on 64K page
 size systems.
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240110075351.f4b6f43e31629ddcb96503cc@linux-foundation.org>
Date: Thu, 11 Jan 2024 10:07:58 +0800
Cc: linux-kselftest@vger.kernel.org,
 Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
 Linux-MM <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>,
 Geetika Moolchandani <geetika@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C3CE35A3-7663-4B8E-9E85-8F0C3CD7D9EC@linux.dev>
References: <3b3a3ae37ba21218481c482a872bbf7526031600.1704865754.git.donettom@linux.vnet.ibm.com>
 <20240110075351.f4b6f43e31629ddcb96503cc@linux-foundation.org>
To: Donet Tom <donettom@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Jan 10, 2024, at 23:53, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> (cc Muchun)
> On Wed, 10 Jan 2024 14:03:35 +0530 Donet Tom =
<donettom@linux.vnet.ibm.com> wrote:
>=20
>> The kernel sefltest mm/hugepage-vmemmap fails on architectures
>> which has different page size other than 4K. In hugepage-vmemmap
>> page size used is 4k so the pfn calculation will go wrong on systems
>> which has different page size .The length of MAP_HUGETLB memory must
>> be hugepage aligned but in hugepage-vmemmap map length is 2M so this
>> will not get aligned if the system has differnet hugepage size.
>>=20
>> Added  psize() to get the page size and default_huge_page_size() to
>> get the default hugepage size at run time, hugepage-vmemmap test pass
>> on powerpc with 64K page size and x86 with 4K page size.
>>=20
>> Result on powerpc without patch (page size 64K)
>> *# ./hugepage-vmemmap
>> Returned address is 0x7effff000000 whose pfn is 0
>> Head page flags (100000000) is invalid
>> check_page_flags: Invalid argument
>> *#
>>=20
>> Result on powerpc with patch (page size 64K)
>> *# ./hugepage-vmemmap
>> Returned address is 0x7effff000000 whose pfn is 600
>> *#
>>=20
>> Result on x86 with patch (page size 4K)
>> *# ./hugepage-vmemmap
>> Returned address is 0x7fc7c2c00000 whose pfn is 1dac00
>> *#
>>=20
>> Signed-off-by: Donet Tom <donettom@linux.vnet.ibm.com>
>> Reported-by : Geetika Moolchandani (geetika@linux.ibm.com)
>> Tested-by : Geetika Moolchandani (geetika@linux.ibm.com)

Acked-by: Muchun Song <muchun.song@linux.dev>

>=20
> I'll add=20
>=20
> Fixes: b147c89cd429 ("selftests: vm: add a hugetlb test case")
> Cc: <stable@vger.kernel.org>

Yes. It should be a real bug fix.

Thanks.


