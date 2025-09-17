Return-Path: <linux-kselftest+bounces-41752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87851B81644
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A23717EF33
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ECA3002B6;
	Wed, 17 Sep 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="jWFOpMYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AF61E1C22;
	Wed, 17 Sep 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135174; cv=none; b=X6FsjheJbwrZIrkS6PMdCG0maP6ZqgVRbj0x/MMwmibzSNFX57mjkp3lfUsw/t3wJsace99RJFQmqBOE0oyV1oawV3bN3U/F9MuFK8Gk7tYk3yQgsTldR6YaXgLCSiRueeq5PqigIkCuONdsNM/vIMEpX3n7Exa9Ua5QN1N/U+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135174; c=relaxed/simple;
	bh=DXr83c8H68AmyRHJYwElnxjbw+hVHN4OMw8EgrecAh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM3zl2eDeCkNFJ/sF2RbqalvlTGa8QsdaJwgZC1BFPGQBiwGFtMkGxxSO9zAGVNgRwvaObJSsyIUZPmpp84gn6iY35aQEIaYGqFI6mUI52QqncaiDXhlyzTFOQpG0xTpEqDYaZYUf2VSVxp06llpe9h+0r2EXoX3OqBj0sE2qEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=jWFOpMYJ; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEqJIo000856;
	Wed, 17 Sep 2025 18:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=7LK4ZWeL13dQx21QB7xV/bkzeQ
	Zco1h+3vZiyoJhjtY=; b=jWFOpMYJRJhXejKedoiFYdR2KftHonRBNBFdijPrKN
	Fm6jZCWSlpA0hrAKcIwQmZnEJQzA8SyrO8nzcsWr/W3MtBBR9XFjohkWD37IFii3
	JOBP27v4iTL3ylCoEl6DMsY8SGw18ikcfEEUjJaZ49Z3Po/5VtlstD0H81GgOkUH
	Mc8ozVMyq51PmpKxinbS145Q9c/ynFbkBSK56swemZER5/2ROeg7+uYO8syOIJbk
	+gHkNTK6mJMj8o6MLk8WZ/fmXoAFzq2cgp6P/vlRspwK/KuenQd5UKFhbvTMxmOA
	KxlwQbdFAEqnQTFtZkkOcXrNdJIwNv7DgI85CSuqZBWA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 497y4fstv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 18:51:41 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 800CA805E3B;
	Wed, 17 Sep 2025 18:51:28 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id D65EB801FF9;
	Wed, 17 Sep 2025 18:51:24 +0000 (UTC)
Date: Wed, 17 Sep 2025 13:51:19 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: David Hildenbrand <david@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, akpm@linux-foundation.org,
        corbet@lwn.net, linmiaohe@huawei.com, shuah@kernel.org,
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
Message-ID: <aMsDJ3EU1zVJ00cX@hpe.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <a99eb11f-a7ac-48a3-a671-c5f0f6b5b491@arm.com>
 <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c3188da-7078-4099-973a-1d0d74db2720@redhat.com>
X-Authority-Analysis: v=2.4 cv=I8JlRMgg c=1 sm=1 tr=0 ts=68cb033d cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=43ExOtPKq08pkoLMMGwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gURhVSCbrA3Jh1Kv2mx01oxTFQRbHNwi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE0NCBTYWx0ZWRfXxREiFP4uvNdQ
 luYfTSm6FT7NARVcxFXF5eDPm6eWrw/vSSRhnFbUJTExtryAN8OyHivFKXVp2DXjrrEYU81oEkk
 5q7sNERRo1G3rslZr4Hvu4wDXgMksi6DVcUcVEn1Jm9XGgnxUFqk4p3CoD+bPhwsqZxS1xcAYQ4
 Dp/MxMo4WwcXxCillnvMoPyyXCZGxG2pYV2uLdQA80IN1g6J0xJv+4+vtUBA7j1ETAufUhRib/2
 8R96kyTjXUhkY4eVynbRMr6M6ioQUcTk6f1tu73K5enqoM9wo/kkJYCNXloyiZa6gVd09xfpiQj
 uw8dvRGHNHlVTTSTUbjgc81C5t05O2spqBZr0hBznEYUw99l5wMGpVhU7QIqJqSMM3aXF7Mq7U8
 dd9rufKu
X-Proofpoint-ORIG-GUID: gURhVSCbrA3Jh1Kv2mx01oxTFQRbHNwi
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170144

On Wed, Sep 17, 2025 at 09:02:55AM +0200, David Hildenbrand wrote:
> 
> > > +
> > > +	0 - Enable soft offline
> > > +	1 - Disable soft offline for HugeTLB pages
> > > +
> > > +Supported values::
> > > +
> > > +	0 - Soft offline is disabled
> > > +	1 - Soft offline is enabled
> > > +	3 - Soft offline is enabled (disabled for HugeTLB pages)
> > 
> > This looks very adhoc even though existing behavior is preserved.
> > 
> > - Are HugeTLB pages the only page types to be considered ?
> > - How the remaining bits here are going to be used later ?
> > 
> 
> What I proposed (that could be better documented here) is that all other
> bits except the first one will be a disable mask when bit 0 is set.
> 
> 2 - ... but yet disabled for hugetlb
> 4 - ... but yet disabled for $WHATEVER
> 8 - ... but yet disabled for $WHATEVERELSE
> 
> > Also without a bit-wise usage roadmap, is not changing a procfs
> > interface (ABI) bit problematic ?
> 
> For now we failed setting it to values that are neither 0 or 1, IIUC
> set_enable_soft_offline() correctly?

Yes, -EINVAL will be returned.

> So there should not be any problem, or which scenario do you have in mind?

Here's an alternative approach.

Do not modify the existing sysctl parameter:

/proc/sys/vm/enable_soft_offline

0 - Soft offline is disabled
1 - Soft offline is enabled

Instead, introduce a new sysctl parameter:

/proc/sys/vm/enable_soft_offline_hugetlb

0 - Soft offline is disabled for HugeTLB pages
1 - Soft offline is enabled for HugeTLB pages

and note in documentation that this setting only takes effect if
enable_soft_offline is enabled.

Anshuman (and David), would you prefer this?

Thanks,
Kyle Meyer

