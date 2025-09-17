Return-Path: <linux-kselftest+bounces-41781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31933B82006
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9414A5986
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53030DEB6;
	Wed, 17 Sep 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="TS+ImPEM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6B0224B04;
	Wed, 17 Sep 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145201; cv=none; b=OFtQsdEG2NU71VeMdXKF/OMS1SFEzcQrWO2DqxZVpoIN/Ou096f6voGvRiQN9ba0b0VLafkQGrEtZfd3RKncuSybf50ah3aWa1j9z2nFXOeYjDK/hFFSRlJNNbo/WQgv5uFARoqsyjKEhXUfdUvoSIsB3sJLgiuf1YdOyZqPUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145201; c=relaxed/simple;
	bh=j0oSCi9JCNB/n2boWWo+usbN9ISUZr1EE+q7YBlMKUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMbDstpClRf44YsJGe16wTzhqmUyqm6ukRznoJOEELNNhDPvnlIOk7ZGHgSmnmaxLCoU2ejapegpF239H5WgAqn35kinHNh5zxd4wAom0XEf/+zyaLqiu1HbUv3braK8suq+BjYKIgKpsTuWH4lLbaX26LltznKL9813KYTgISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=TS+ImPEM; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HLbTx2031830;
	Wed, 17 Sep 2025 21:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=e7aywbVgoWACndDeOW0D7B3YoI
	kDJpnENYBe2GyDpVE=; b=TS+ImPEM9BnHP3pjsIAzoxU99Ze3vLHdShH8ASvMm8
	FwykYSUvQfUo4b69MoVprjuxbc5xtMnnAggTGlywAy1mRBGpw1hiiy7Pdr+GrtDh
	mVYloPY8I5cBTrKCxWuGN+hgiJNRayFGiJhC6DOIrhD9QzHvcAz8UjP2qOgKlZpN
	SQIXDNidMKF9KrtOobcTEPKv8CJ666Eftw+csaSfkhgIOAa4ufr1Oh0YrHveLsvH
	8RGhGG/OZlOd/qUqz7jZA4r0pLWR3Z1j6G/VprUKBmshuhN32+XIhIu6dVqt/kHB
	EFsgAN9OvseDuBWr5X/BdwI48sHnuTfa9mXjPp7wosEw==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 497y4f2xjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 21:39:12 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 0A89D130D6;
	Wed, 17 Sep 2025 21:39:11 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 1A621804CDB;
	Wed, 17 Sep 2025 21:39:08 +0000 (UTC)
Date: Wed, 17 Sep 2025 16:39:01 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Jiaqi Yan <jiaqiyan@google.com>, David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        akpm@linux-foundation.org, corbet@lwn.net, linmiaohe@huawei.com,
        shuah@kernel.org, jane.chu@oracle.com, Liam.Howlett@oracle.com,
        bp@alien8.de, hannes@cmpxchg.org, jack@suse.cz,
        joel.granados@kernel.org, laoar.shao@gmail.com,
        lorenzo.stoakes@oracle.com, mclapinski@google.com, mhocko@suse.com,
        nao.horiguchi@gmail.com, osalvador@suse.de, rafael.j.wysocki@intel.com,
        rppt@kernel.org, russ.anderson@hpe.com, shawn.fan@intel.com,
        surenb@google.com, vbabka@suse.cz, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Message-ID: <aMsqdesM1ImJp1yt@hpe.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com>
 <aMsDJ3EU1zVJ00cX@hpe.com>
 <cd71fac2-bb9d-4e84-a074-2b695654e655@redhat.com>
 <CACw3F52p45t3iSZPjx_Lq9kBn1ZGTDZsxk+iQ-xFA1zdvdqqrw@mail.gmail.com>
 <aMsR4Tr9ov1pfucC@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMsR4Tr9ov1pfucC@agluck-desk3>
X-Authority-Analysis: v=2.4 cv=FoUF/3rq c=1 sm=1 tr=0 ts=68cb2a80 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=-yUDYzNKurD68FfYE3YA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -t5EYyscZvkXoKgU1Fr4v8bU1oBCB3c2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE0NCBTYWx0ZWRfX3tXC0LyiZmGA
 EQSbxobfpqBJ2/TPQVKW8un6ill+kJamYAOG2TNuIPQIDu6vQ4oz/swV8qQUbtXFdefRyu3kzD0
 0/RqovEVpnKbXv7WT+CSeihWkbOyM3Q26jnL2O0SNy9YpUBnXaDgXQP3fN1ANJRH6/e143PFK+T
 GnGm++4JBCUndCS1f4ekeoy7NuWS7nDFC+12d3b1Poz5lIJYQcxeEnzQtQGg9MTISmoyl3T+5ak
 2uf60DEbMDNIuFuFx7GIuUHLszdqS7NMXf0Xd/ndH6KyLRmnmoqXKGPbmep0T4d23Pt9VhCo7Xp
 4/orMAto6QC504pcbM8XW0vX4ybFk+kvdP1UNm7YC3ZKDuFlT8pguL5yvNbe34N6rR5o8EArpd9
 0RfUBX9b
X-Proofpoint-ORIG-GUID: -t5EYyscZvkXoKgU1Fr4v8bU1oBCB3c2
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170144

On Wed, Sep 17, 2025 at 12:54:09PM -0700, Luck, Tony wrote:
> On Wed, Sep 17, 2025 at 12:32:47PM -0700, Jiaqi Yan wrote:
> > +1. Given /proc/sys/vm/enable_soft_offline is extensible, I would
> > prefer a compact userspace API.
> > 
> > > would create a new file, and the file has weird semantics such that it
> > > has no meaning when enable_soft_offline=0.
> 
> So the expand the bitmask idea from earlier in this thread?
> 
> Bit0	0 = soft offline disabled. 1 = Enabled (but see other bits)
> Bit1	0 = allow offline of 4K pages, 1 = suppress 4K offline
> Bit2	0 = allow offline of hugetlb, 1 = suppress hugetlb offline
> Bit3	0 = allow breakup of transparent huge pages to just offline 4K, 1 = suppress transparent breakup
> Bit4+	Reserved for suppressing other page types we invent in the future
> 
> Values 0 and 1 keep their original meaning.
> 
> Value 5 means: offline 4K, keep hugetlb, breakup transparent huge pages.

Do you happen to have any use cases or reasoning for why someone might want
to disable soft offline for 4K pages or transparent huge pages? I'd like to
understand the motivation for adding the extra bits.

Thanks,
Kyle Meyer

