Return-Path: <linux-kselftest+bounces-41400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0ACB5530B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EAB16CE26
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9481DF25C;
	Fri, 12 Sep 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="eSkfoqJc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D0220F5E;
	Fri, 12 Sep 2025 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690358; cv=none; b=ER9fr+eENQhTaNPoC3Bx8TXj68D371w8Z0sM9gSCYTog8cRaihVdBCLoYDz7TvbgqbiIwzM22uLhNl9kG0BAQ1s3gxKmgGyN+HJRUBV4WxKWJHqMfG7bXOU8qDgoHEzcnz7aCKQ+NJd40qCuv40P6VktpOV7eOloj+uEc4Dz8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690358; c=relaxed/simple;
	bh=8weoE2e9TGNpgGqPe0iPfG7GHtyTXmM53y3PRp3py0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ed0ztVb4mLd3UwynQu+cTcw3sjUfH1HLBr2FBcmRTdaX14mCbHo0Z7FGDIhMvo/nHuw+/Oj5pCCVd547eY7/TKG/2GPFu3++VgYb+hWCT0bXtnb2pnNS4RayF+qrFhaDhF64XDSwAWrL4nIzNNfiUcx/0o9nWu1B2eIrD9l8RdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=eSkfoqJc; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCWuk7008490;
	Fri, 12 Sep 2025 15:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=Bf7wacAaZoEod1mICLvinIYs6o
	n3YRo44Ct0fNN+0Xk=; b=eSkfoqJc+fqmAI7ovP6DAx4ZRLkkSZDFx/Vz4+RcRS
	ECLRXC9GMur4qpBZYifSenYYN7PzBORm+/PBkZ6nXKKTpWasNGhux2E67qfCritm
	s3/U5/vkw1FNASw7+m2etIpN0MlQzlmaVO/ygB+vKAio9Y3RGHCOVoPpmw57Cpk5
	UDeiQK8fdnnxmqb4AvzUlHfQ5nwsBQhGlSXe4pRA7+XRg7gZZnJpXEFWURC7FBbW
	vcZdAOJzdzerXVNO51MjDuODW6mWBB45JEUCcnqzAlZcDL9g4LrjbahN72YMH01s
	emfrQaY+IGsDk//woBdmW/YczAIY8w7LR85ELZpHF6RQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 494k06skrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 15:17:47 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id BB26A8059C2;
	Fri, 12 Sep 2025 15:17:46 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 404B180283A;
	Fri, 12 Sep 2025 15:17:41 +0000 (UTC)
Date: Fri, 12 Sep 2025 10:17:39 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, akpm@linux-foundation.org,
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
Message-ID: <aMQ5kyWElcW4Z8QE@hpe.com>
References: <aMGkAI3zKlVsO0S2@hpe.com>
 <749511a8-7c57-4f97-9e49-8ebe8befe9aa@redhat.com>
 <aMMNVA9EXXHYvmKH@agluck-desk3>
 <a0e586dc-dce6-41a2-9607-f2f64b752df1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e586dc-dce6-41a2-9607-f2f64b752df1@redhat.com>
X-Authority-Analysis: v=2.4 cv=MPtgmNZl c=1 sm=1 tr=0 ts=68c4399c cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=vR9gMrYkm2ll-U9WneIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: RMya5ZodnjKxPHftQ2_7JMNhhPHvlRcf
X-Proofpoint-GUID: RMya5ZodnjKxPHftQ2_7JMNhhPHvlRcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDExMSBTYWx0ZWRfX/Kzh1rXW0xhq
 cDC/osAW4/J8rDGBsPPey+VIQyHYDtHHdgTNjk8chR5f6jh3wIdVPp5Ox9yVRDijIZNoEwXueL0
 DwOhZAfwyUVtp21mTqwLJSpzRJpIWk+G4aLEfYdreuSriQLCK1XcWE8ZXRyfnSdj//eRBMeZjq4
 KraDDSKgM00igYROZR5kAUSwCREMoLqzsS/sZfbbKtEKEaHGfj1LTqlj6gfstQSmfD5Nd+pH5h5
 dg3X3um5shw8NykygQAWqbe7EDLafa06s3xLAk5NihaIvWld8JLUuNPUZ98sef5L/e2G4VDwY/S
 TrkWOEHZ/A2m5NqdG0WFJ6wfAlXJNXInjrhHViALugnknKK9od+KfzF5F7W0J/wrlWuSaF+CEcM
 wVCvCvAr
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509120111

On Fri, Sep 12, 2025 at 09:53:02AM +0200, David Hildenbrand wrote:
> On 11.09.25 19:56, Luck, Tony wrote:
> > On Thu, Sep 11, 2025 at 10:46:10AM +0200, David Hildenbrand wrote:
> > > On 10.09.25 18:15, Kyle Meyer wrote:
> > > > Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
> > > > Since HugeTLB pages are preallocated, reducing the available HugeTLB
> > > > page pool can cause allocation failures.
> > > > 
> > > > /proc/sys/vm/enable_soft_offline provides a sysctl interface to
> > > > disable/enable soft offline:
> > > > 
> > > > 0 - Soft offline is disabled.
> > > > 1 - Soft offline is enabled.
> > > > 
> > > > The current sysctl interface does not distinguish between HugeTLB pages
> > > > and other page types.
> > > > 
> > > > Disable soft offline for HugeTLB pages by default (1) and extend the
> > > > sysctl interface to preserve existing behavior (2):
> > > > 
> > > > 0 - Soft offline is disabled.
> > > > 1 - Soft offline is enabled (excluding HugeTLB pages).
> > > > 2 - Soft offline is enabled (including HugeTLB pages).
> > > > 
> > > > Update documentation for the sysctl interface, reference the sysctl
> > > > interface in the sysfs ABI documentation, and update HugeTLB soft
> > > > offline selftests.
> > > 
> > > I'm sure you spotted that the documentation for
> > > "/sys/devices/system/memory/soft_offline_pag" resides under "testing".
> > 
> > But that is only one of several places in the kernel that
> > feed into the page offline code.
> 
> Right, I can see one more call to soft_offline_page() from
> arch/parisc/kernel/pdt.c.
> 
> And there is memory_failure_work_func() that I missed.
> 
> So agreed that this goes beyond testing.
> 
> It caught my attention because you ended up modifying documentation residing
> in Documentation/ABI/testing/sysfs-memory-page-offline.
> 
> Reading 56374430c5dfc that Kyle pointed out is gets clearer.
> 
> So the patch motivation/idea makes sense to me.
> 
> 
> I'll note two things:
> 
> (1) The interface design is not really extensible. Imagine if we want to
> exclude yet another page type.
> 
> Can we maybe add a second interface that defines a filter for types?
> 
> Alternatively, you could use all the remaining flags as such a filter.
> 
> 0 - Soft offline is completely disabled.
> 1 - Soft offline is enabled except for manually disabled types.
> 
> Filter
> 
> 2 - disable hugetlb.
> 
> So value 3 would give you "enable all except hugetlb" etc.
> 
> We could add in the future
> 
> 4 - disable guest_memfd (just some random example)
> 
> 
> Then you
> 
> 2) Changing the semantics of the value "1"
> 
> IIUC, you are changing the semantics of value "1". It used to mean
> "SOFT_OFFLINE_ENABLED" now it is "SOFT_OFFLINE_ENABLED_SKIP_HUGETLB", which
> is a change in behavior.
> 
> If that is the case, I don't think that's okay.
> 
> 
> 2) I am not sure about changing the default. That should be an admin/
>    distro decision.

Thank you, that sounds good to me. I'll put something together.

Thanks,
Kyle Meyer

