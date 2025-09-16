Return-Path: <linux-kselftest+bounces-41571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF467B58EE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 09:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3D094E1A76
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 07:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C972528002B;
	Tue, 16 Sep 2025 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="gzCEr1zr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AC26AD9;
	Tue, 16 Sep 2025 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758006946; cv=none; b=nZusybGN31zZ7+agmpYPOb5f46arEyLj3WEiJNwIkaH3zLFpOUp06guHY+HKC6W2eZJnIxZy+ot0NMXJla58XbQXb169RhSQ06667UhgSw+qsL/yssc36cApwvNt+CoBkJTeILsPgkGB0TedS+XNo15/xl9/tLd6yYReEB8t7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758006946; c=relaxed/simple;
	bh=9TGFGRFrsZuPEdOczwxH9h20pygBGQx5NQAOCly1tfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXa7sQR7q0oYN+smAxwqkEcGfsVbt7h3EyT44iOZ1Z/CqpVkc6fajwVRScT4TkTzwkczcNps4YPtU0CBdtjhmlQFNO77/0TBfP99f6D1R3kno9U7OunGAj8EeDNwBWEhfW7Ck/1Hhr21JjTnU3cEAQYfyfDOw2SV2hJeiyD9Bgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=gzCEr1zr; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G6r2OR028366;
	Tue, 16 Sep 2025 07:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=bXxgqdEdSOzYOwQL2w5UISvG0T
	Gek76RcB1QClzkCaE=; b=gzCEr1zrEMw5QI4COvPhj9vnEAdw8clFMy0uUvpy+T
	LDc8ZLjsAVUmtceIeVN+zJo/fqj4P8qMCObtEcq9YhowTfiSiziEGx2oonZEDsEO
	gp/TqzMa/Q4Z3eqG1Vrm3zfKL7cb1vAQ0hL+AYUTnpwZ0Q6SSdvR/t8CrE2n84yo
	1wFUKjP4OcHjs5RBXHKZSd7vTk8xIbFfM/BAgvR9SBs2u6rywcKllWP0rNSbKAm0
	ELnhL6N6mDA/1fRZ4Q/8sgcQYCzDj3sLIvQ9QHZtYRmq0Wvg0tqNpoK7bRJIsCl1
	uzFc6PajWs9xu5ZGsgUO7VdFWbCCMuQNs+cnP1vkIPLQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 49730x84ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 07:14:28 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 0FD0B130D0;
	Tue, 16 Sep 2025 07:14:27 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 9B2B980898D;
	Tue, 16 Sep 2025 07:14:21 +0000 (UTC)
Date: Tue, 16 Sep 2025 02:14:17 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: corbet@lwn.net, david@redhat.com, linmiaohe@huawei.com, shuah@kernel.org,
        tony.luck@intel.com, jane.chu@oracle.com, jiaqiyan@google.com,
        Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org,
        jack@suse.cz, joel.granados@kernel.org, laoar.shao@gmail.com,
        lorenzo.stoakes@oracle.com, mclapinski@google.com, mhocko@suse.com,
        nao.horiguchi@gmail.com, osalvador@suse.de, rafael.j.wysocki@intel.com,
        rppt@kernel.org, russ.anderson@hpe.com, shawn.fan@intel.com,
        surenb@google.com, vbabka@suse.cz, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Message-ID: <aMkOCmGBhZKhKPrI@hpe.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
X-Authority-Analysis: v=2.4 cv=KaTSsRYD c=1 sm=1 tr=0 ts=68c90e54 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=MvuuwTCpAAAA:8 a=QyXUC8HyAAAA:8
 a=_fVqCaFjEFPFEyr0NywA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aDOt515-H__Hl3R9V07wPh5jXDwBK7cM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDA2NSBTYWx0ZWRfXxAY3BPV9SJA6
 yOok/WQpFEjJYGXprFhNvjR/MSlEPJF8gQD+4iCExdPx/MUr0x833mkvOuHKlTeKIBoAjRLyExx
 T1D3ZDzlDFNSXfVciL1ZS43a5lWeWLSl+Qm5BBGhojcd3MR3tK4dnjyM1r+8nfdur5U22Z1nWnp
 BOqPtmAezj/CPAQTwQOht+sjD82CQtE5HH8kUuszEVLtcQuoNZwYgjGbEZRSx7ud5T+cs9Ajrlo
 Zdr3sFE7xNwfT0kvHltnSQk86vhd+J9mFAIfo4GXZKolTeRqPTORud7OzdD9Ryn2qLB7uc5993r
 egpIJ+gjBaKykyay/cEipeEu8sl4ZXGHcWsvQBz4WPsQmGWyLsNUcS7ntdTgf3z+JbhL/mpeyzc
 Et4+cJQw
X-Proofpoint-ORIG-GUID: aDOt515-H__Hl3R9V07wPh5jXDwBK7cM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160065

On Mon, Sep 15, 2025 at 08:16:18PM -0700, Andrew Morton wrote:
> On Mon, 15 Sep 2025 19:27:41 -0500 Kyle Meyer <kyle.meyer@hpe.com> wrote:
> 
> > Soft offlining a HugeTLB page reduces the HugeTLB page pool.
> > 
> > Commit 56374430c5dfc ("mm/memory-failure: userspace controls soft-offlining pages")
> > introduced the following sysctl interface to control soft offline:
> > 
> > /proc/sys/vm/enable_soft_offline
> > 
> > The interface does not distinguish between page types:
> > 
> >     0 - Soft offline is disabled
> >     1 - Soft offline is enabled
> > 
> > Convert enable_soft_offline to a bitmask and support disabling soft
> > offline for HugeTLB pages:
> > 
> > Bits:
> > 
> >     0 - Enable soft offline
> >     1 - Disable soft offline for HugeTLB pages
> > 
> > Supported values:
> > 
> >     0 - Soft offline is disabled
> >     1 - Soft offline is enabled
> >     3 - Soft offline is enabled (disabled for HugeTLB pages)
> > 
> > Existing behavior is preserved.
> 
> um, why?  What benefit does this patch provide to our users? 
> Use-cases, before-and-after scenarios, etc?

Thank you for the feedback.

Some BIOS suppress ("cloak") corrected memory errors until a threshold
is reached. Once that threshold is reached, BIOS reports a CPER with the
"error threshold exceeded" bit set via GHES and the corresponding page is
soft offlined.

BIOS does not know the page type of the corresponding page. If the
corresponding page happens to be a HugeTLB page, it will be dissolved,
permanently reducing the HugeTLB page pool. This can be problematic for
workloads that depend on a fixed number of HugeTLB pages.

Currently, soft offline must be disabled to prevent HugeTLB pages from
being soft offlined.

This patch provides a middle ground. Soft offline can be disabled for
HugeTLB pages while remaining enabled for non-HugeTLB pages, preserving
the benefits of soft offline without the risk of BIOS soft offlining
HugeTLB pages.

> > Update documentation and HugeTLB soft offline self tests.
> > 
> > Reported-by: Shawn Fan <shawn.fan@intel.com>
> 
> Interesting.  What did Shawn report? (Closes:!).

Tony or Shawn, could you please point me to the original report? Thanks!

> > Suggested-by: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
> >
> > ...
> >
> >  .../ABI/testing/sysfs-memory-page-offline     |  3 ++
> >  Documentation/admin-guide/sysctl/vm.rst       | 28 ++++++++++++++++---
> >  mm/memory-failure.c                           | 17 +++++++++--
> >  .../selftests/mm/hugetlb-soft-offline.c       | 19 ++++++++++---
> >  4 files changed, 56 insertions(+), 11 deletions(-)
> 
> I'll add it because testing, but please do explain why I added it?

Thanks,
Kyle Meyer

