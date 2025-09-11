Return-Path: <linux-kselftest+bounces-41266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD9BB53D5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 22:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DAC488354
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC62D948A;
	Thu, 11 Sep 2025 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="cSQfZyXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993DF27A454;
	Thu, 11 Sep 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624262; cv=none; b=qTC8KQlYOcz/J69+d4CQrRIXvdpZMqqFmTZVFk78xGIlNEvpvUi/c9tNBLG853xy+CO9uND3PcAIMhiDe/ncgFeAL9CXQWqNoj59lQV6E/i8jLS6V8hJmvK5kb8OYswbzaxZM6qjvHYnDsj0LrpmMOwdNs1U4wn2Z4oNefIBesk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624262; c=relaxed/simple;
	bh=bSsPa9XEyW8z/su++j6tQWWmZoPbZWL/uldiO/VimDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ld77nKsQP3eIAmXFVSo6G/iAwE7765ERfIFlrABO4kAB/uWn+jV5GMnQhyOse6JFYL8KXl62RSiwheuS35anfJ5yLP0ezlKOsyA1BZndOO+4c01kDgHC3rHCp3a35AIQG66SIvHKLN5fpka0HHFmlVMNVAwN2q7vT/41xen2nd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=cSQfZyXH; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFINgC007212;
	Thu, 11 Sep 2025 20:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=J0ID9F64YdLXnEJhVLSOMHkdqi
	2X6q7O8dZhA/oVjxI=; b=cSQfZyXHw97+qAk5GLrVBgwewFdz885Cteb9qF6kZC
	cl0B/IlTfIYZlYVAQL80a6ViC3RMb7LwXyVxWpyeUQW2ZjFRH89J7JwZPy7swLK8
	bfJdi8MluU5znLPe19N6KRAHsTlRVjl9hc2fwjmchGWfXeicxabPj8CO4JJ95aRV
	D+zFfqrdQw7/J2i1jmRyxhcTzHsKKP8MGvlaz9Bm3J2WYbe576VycumLp3m3y7wL
	cmgGV0a94bE4YbFXaAsE3e48TESw/6B8qRdJ7MM59bacGyVJ3D/ggJqoVo67Ocpm
	Hq8fo4AFsLG/i0MW3vGgTuCEWf3aENH+ykwjbcc2Wq1Q==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 493p9xfpef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 20:56:34 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 206FD132D3;
	Thu, 11 Sep 2025 20:56:32 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 708208118D1;
	Thu, 11 Sep 2025 20:56:28 +0000 (UTC)
Date: Thu, 11 Sep 2025 15:56:26 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        corbet@lwn.net, linmiaohe@huawei.com, shuah@kernel.org,
        Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org,
        jack@suse.cz, jane.chu@oracle.com, jiaqiyan@google.com,
        joel.granados@kernel.org, laoar.shao@gmail.com,
        lorenzo.stoakes@oracle.com, mclapinski@google.com, mhocko@suse.com,
        nao.horiguchi@gmail.com, osalvador@suse.de, rafael.j.wysocki@intel.com,
        rppt@kernel.org, russ.anderson@hpe.com, shawn.fan@intel.com,
        surenb@google.com, vbabka@suse.cz, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB
 pages by default
Message-ID: <aMM3elPmG1MdUNrJ@hpe.com>
References: <aMGkAI3zKlVsO0S2@hpe.com>
 <749511a8-7c57-4f97-9e49-8ebe8befe9aa@redhat.com>
 <aMMNVA9EXXHYvmKH@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMMNVA9EXXHYvmKH@agluck-desk3>
X-Proofpoint-ORIG-GUID: Ethw6hHnLfczx3VAEZBXc-08gscPDyGN
X-Proofpoint-GUID: Ethw6hHnLfczx3VAEZBXc-08gscPDyGN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDAyNiBTYWx0ZWRfXyI2+SdrKv+fr
 J09MeyCR3Ioip+tv+DaUAAlfVfIk22LrAWmlkzH/QV5q4UAWPgfHNFOl4+ub//1Adee37pHPb4b
 764zMHo5pXXt1CcHaobNJvfMfwFmUUV/nH/D82/1aTPO6jutWA9MvX8an2UNfGrfTzL9DSk8XRW
 WdZT5V1erw/xxDMTunGIMHe9T2MS+FKEBZCOwsxI4yn8gC3OcGhueHg0cu+lqePY9/N+YX888Hk
 3sUbWytd+nDRfz/JfHwjdEa8Usy/cqfyazlCUsltcgMUe3O7HboftW1ebSfQdBIJZ49UPQ+CDK2
 gt4/eks53CHvrIBOELJSndItTN1QUeIx7bgqpZ1GHhLx5QsJwOy/K+Q1x9blJwm1hm8x2x3EJNQ
 nmqPYiXa
X-Authority-Analysis: v=2.4 cv=Ke/SsRYD c=1 sm=1 tr=0 ts=68c33782 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=e0XSXhz86abGffj2R7MA:9
 a=CjuIK1q_8ugA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509110026

On Thu, Sep 11, 2025 at 10:56:36AM -0700, Luck, Tony wrote:
> On Thu, Sep 11, 2025 at 10:46:10AM +0200, David Hildenbrand wrote:
> > On 10.09.25 18:15, Kyle Meyer wrote:
> > > Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
> > > Since HugeTLB pages are preallocated, reducing the available HugeTLB
> > > page pool can cause allocation failures.
> > > 
> > > /proc/sys/vm/enable_soft_offline provides a sysctl interface to
> > > disable/enable soft offline:
> > > 
> > > 0 - Soft offline is disabled.
> > > 1 - Soft offline is enabled.
> > > 
> > > The current sysctl interface does not distinguish between HugeTLB pages
> > > and other page types.
> > > 
> > > Disable soft offline for HugeTLB pages by default (1) and extend the
> > > sysctl interface to preserve existing behavior (2):
> > > 
> > > 0 - Soft offline is disabled.
> > > 1 - Soft offline is enabled (excluding HugeTLB pages).
> > > 2 - Soft offline is enabled (including HugeTLB pages).
> > > 
> > > Update documentation for the sysctl interface, reference the sysctl
> > > interface in the sysfs ABI documentation, and update HugeTLB soft
> > > offline selftests.
> > 
> > I'm sure you spotted that the documentation for
> > "/sys/devices/system/memory/soft_offline_pag" resides under "testing".
> 
> But that is only one of several places in the kernel that
> feed into the page offline code.
> 
> This patch was motivated by the GHES path where BIOS indicates
> a corrected error threshold was exceeded. There's also the
> drivers/ras/cec.c path where Linux does it's own threshold
> counting.
> > 
> > If your read about MADV_SOFT_OFFLINE in the man page it clearly says:
> > 
> > "This feature is intended for testing of memory error-handling code; it is
> > available  only if the kernel was configured with CONFIG_MEMORY_FAILURE."
> 
> Agreed that this all depends on CONFIG_MEMORY_FAILURE ... so if any
> part of the flow is compiled in when that is "=n" then some
> changes are needed to fix that.
> 
> > 
> > So I'm sorry to say: I miss why we should add all this complexity to make a
> > feature used for testing soft-offlining work differently for hugetlb folios
> > -- with a testing interface.

I would also like to note that the current sysctl interface already affects
testing interfaces. Please see the following commit:

56374430c5dfc ("mm/memory-failure: userspace controls soft-offlining pages")

The sysctl interface should probably be mentioned in
sysfs-memory-page-offline with or without this patch.

Thanks,
Kyle Meyer

