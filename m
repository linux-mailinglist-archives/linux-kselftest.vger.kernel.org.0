Return-Path: <linux-kselftest+bounces-42129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21126B947F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D38418A659C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 06:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458430EF76;
	Tue, 23 Sep 2025 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Dk+a+gvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB830EF63;
	Tue, 23 Sep 2025 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758607509; cv=none; b=U4eeePs9s6ywRPyX/TUljcP0r92/L4aAIyjclLWLtPvOXeE9GljIA+AXvqvhrD5+ye3upHen+BgJT+AjMUmv9bI8WevIsGU/LZVp/A03FC5/E+dMlKR5/8YonsinpkH4EFFkE3+xtLQXvd79fI9aM+Xl57VDrZu7IA2kNirJN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758607509; c=relaxed/simple;
	bh=/1aLw+Dq5VzlXZZVaqPTIVHF296yMXfsCOzTYBTv6ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7R+7QMCYj+2PNBHk7qOliBCOGNHUTpGh/zxtwOB/WwKe8xdXHb9EhmOqfujXyL6EmnJY4HA/L29fFgpXJS3K40ACoNYzZ82rrJeQ4mFDBy+oizND+HtTn1Np5RognmReqvPLGughYrLdZa03+PqRFZ0t2FNHQHu6g1+aOENXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Dk+a+gvO; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N52mPd002159;
	Tue, 23 Sep 2025 06:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=Ysy44PRCh+/6wV2z+Ca/XezLJJ
	6mu2BnXGwORvH9Dd4=; b=Dk+a+gvOqKbwRKGH3FWybXgsxrqXr1BZ1JKFr0W974
	/CSXr1RqrpMiOlbigY36ncNFyRVAuz8eFYNzCDN6uh+vhVujq21rkPbXPmRyRUtd
	CjXJyX5Dj+8PNpKae+cGn9xYhD9KWYmV7a2JLVCY7DgRnBBesNvWlz/vVRJnYXWr
	mzLrpCxuhGfHDU6Gc8sqEphT+DujFMSEeVrkuMLfiPVr4/hbEaduEcu0YaO9ltGD
	nY/6xX01dTUYb8VODhtkXXTezQ9rRBW2swIQBO8i3jBv3xCwJ22WDd8K+97H1zll
	r0OI0Fg+9X4DSI79leSDIIl1c03U7LzcDNHGfR7mGXwQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 499njsvuu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 06:03:57 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id EF4A212E97;
	Tue, 23 Sep 2025 06:03:54 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 1E7D4800464;
	Tue, 23 Sep 2025 06:03:50 +0000 (UTC)
Date: Tue, 23 Sep 2025 01:03:46 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Jiaqi Yan <jiaqiyan@google.com>,
        David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        corbet@lwn.net, linmiaohe@huawei.com, shuah@kernel.org,
        jane.chu@oracle.com, Liam.Howlett@oracle.com, bp@alien8.de,
        hannes@cmpxchg.org, jack@suse.cz, joel.granados@kernel.org,
        laoar.shao@gmail.com, lorenzo.stoakes@oracle.com,
        mclapinski@google.com, mhocko@suse.com, nao.horiguchi@gmail.com,
        osalvador@suse.de, rafael.j.wysocki@intel.com, rppt@kernel.org,
        russ.anderson@hpe.com, shawn.fan@intel.com, surenb@google.com,
        vbabka@suse.cz, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Message-ID: <aNI4QgvyoSrP9-K4@hpe.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com>
 <aMsDJ3EU1zVJ00cX@hpe.com>
 <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
 <CACw3F52p45t3iSZPjx_Lq9kBn1ZGTDZsxk+iQ-xFA1zdvdqqrw@mail.gmail.com>
 <aMsR4Tr9ov1pfucC@agluck-desk3>
 <4d2e8686-8810-4901-8483-9b5eb040d489@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d2e8686-8810-4901-8483-9b5eb040d489@arm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfXzcE78KgCk5qI
 +8m7uiJiXKq3Bjdp0HM5+DG3CMW1LZlOucsOc7oyEMwy9uExNSuJEm2t+SnHJWgGFL4+kFni3IY
 m/IKGCleRms7RDbsa0JfH/5/3M2HOXc0VT7mfhDUxdHpS67UZ58s9fkz3Qo0OVjTn0BShG6FEFB
 sraZTw8JtCUO1SOJPj90ij26Abws8eWBhWElzWWmtdQlfOul03NcxKtESHxsXUOHG3bY728UYDx
 /v0lsrN2sS/UldafeoxcuNA7dOhXJm4AmlBRVCqwDSfbJBnRXnDwEdMucZym2sEzDwi5d8PRtS1
 aYkdvN11k7xcHo9XFQco7Z7co2gA0AcV8hl380giL/mxCSIBlmdTXf+1GMbNri9gFzC6xwtAni5
 Y3Pd1c61
X-Proofpoint-GUID: aW_AMqUIMxBuviqCOxNsJj0xPx3M-AnV
X-Proofpoint-ORIG-GUID: aW_AMqUIMxBuviqCOxNsJj0xPx3M-AnV
X-Authority-Analysis: v=2.4 cv=A6FsP7WG c=1 sm=1 tr=0 ts=68d2384d cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=QQnSzdILfhi0SjpbxKgA:9
 a=CjuIK1q_8ugA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043

On Sun, Sep 21, 2025 at 05:06:31PM +0530, Anshuman Khandual wrote:
> 
> 
> On 18/09/25 1:24 AM, Luck, Tony wrote:
> > On Wed, Sep 17, 2025 at 12:32:47PM -0700, Jiaqi Yan wrote:
> >> +1. Given /proc/sys/vm/enable_soft_offline is extensible, I would
> >> prefer a compact userspace API.
> >>
> >>> would create a new file, and the file has weird semantics such that it
> >>> has no meaning when enable_soft_offline=0.
> > 
> > So the expand the bitmask idea from earlier in this thread?
> > 
> > Bit0	0 = soft offline disabled. 1 = Enabled (but see other bits)
> > Bit1	0 = allow offline of 4K pages, 1 = suppress 4K offline
> > Bit2	0 = allow offline of hugetlb, 1 = suppress hugetlb offline
> > Bit3	0 = allow breakup of transparent huge pages to just offline 4K, 1 = suppress transparent breakup
> > Bit4+	Reserved for suppressing other page types we invent in the future
> > 
> > Values 0 and 1 keep their original meaning.
> > 
> > Value 5 means: offline 4K, keep hugetlb, breakup transparent huge pages.
> 
> This disable bitmask (but when generally enabled via bit[0] = 1) method
> seems much better. But I am not sure about page size being a valid page
> type classification though. Just to start with, defining first two bits
> in this bitmask should be good enough, which will atleast help document
> and validate this new interface properly.
> 
> Bit1	0 = allow offline of hugetlb, 1 = suppress hugetlb offline
> Bit2	0 = allow breakup of transparent huge pages to just offline base pages, 1 = suppress transparent breakup
> Bit3+	Reserved for suppressing other page types we invent in the future

The current patch is already applied to mm-git and supports the following bits:

    0 - Enable soft offline
    1 - Disable soft offline for HugeTLB pages

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-new&id=9ae6eefa4b6bd3c3e7ef417a6507dce4b55101b4

Are any immediate changes needed?

Support for additional page types, such as transparent huge pages, can be added
later as needed.

Thanks,
Kyle Meyer

