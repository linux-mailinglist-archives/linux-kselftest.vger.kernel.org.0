Return-Path: <linux-kselftest+bounces-41753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B657B81685
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 20:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479F74825DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD3E3009CD;
	Wed, 17 Sep 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OToBLxFj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA37082D;
	Wed, 17 Sep 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135589; cv=none; b=WjIJBAxMgsavLFQCQNm+JyrWDnMOAlMEJTUwfWaAGBbWAbNwt7xOGOjzh9cIaxPZhdihTojoa4IWEV05vQzhajvo3faVd/FIJUo6Wu5QiW8RK4VI5MA7L3kLqWub4Ka/ijsTzwH7Eezxh1HZDJItRhRmLynjBlF3KY+dPSsLu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135589; c=relaxed/simple;
	bh=EVfMpQXLWxhWdq9oWKPcfrMOFpRMUqf/ebC5LppxvUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+LvaxxsKxqs0xE8vjDxM6NTAvs4ouMD3uMMsc1JPa7yNIS8GqoGHr2wImoIzz7x6baMYCqu50DeUGYvOPE39tAk7WfrLovfQCiatH+E6CRo1U6LIQBI6nFEMq7oEEhuUasGfSUYrqTxLrCYAECcdeMIzh4q/Y6Apz6TUjnbM/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OToBLxFj; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HAXTk4006258;
	Wed, 17 Sep 2025 18:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=HssRRRBcK1dSQW061f4MB6eTx2
	lTTiHMP1LCQG7zdSo=; b=OToBLxFjEcd5kH8Uyo7U+CadNhycCE4W8Bkk4OK9LN
	IePdhI56cNYa6kVFxo17gtsdUigMdlu+z5R8Ji+e7FIuOtWIPjFOi5VrrzphVzaU
	H92whtryST6hkoeLuh+kgGALowjUZlWDtLktYp1ySurbp2hBCl5uK1YT3ThAVLxA
	UcT+VKn4rk8jacbl24LAose/ac1kutcJfX4uTL3Y5vaKNjJr7T0mnQ3YeYVaaAXg
	80Wi+hr3OtXVxSLDWXoyeD3cLB7O9zieqlqN3+oBmCTE4J6M9C/KB2ZxN9JXzmim
	gqF3RHZe2ye08v5BGvE6aZKsSBR7k3GPAv1bOc+YGAeQ==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 497kq6qhb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 18:59:11 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 12B3F800373;
	Wed, 17 Sep 2025 18:59:09 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 019948123C5;
	Wed, 17 Sep 2025 18:59:06 +0000 (UTC)
Date: Wed, 17 Sep 2025 13:59:01 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Fan, Shawn" <shawn.fan@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "joel.granados@kernel.org" <joel.granados@kernel.org>,
        "laoar.shao@gmail.com" <laoar.shao@gmail.com>,
        "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
        "mclapinski@google.com" <mclapinski@google.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "surenb@google.com" <surenb@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Message-ID: <aMsE9XjWKEYTIQyV@hpe.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
 <aMkOCmGBhZKhKPrI@hpe.com>
 <SJ1PR11MB60831F028E2FEB6B5A3390D9FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aMmlhPghbpnlCZ09@hpe.com>
 <SJ1PR11MB60833884799B6AA2BC18ECE7FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <LV4PR11MB9513A6EFA88B082E554CB8D6EB17A@LV4PR11MB9513.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV4PR11MB9513A6EFA88B082E554CB8D6EB17A@LV4PR11MB9513.namprd11.prod.outlook.com>
X-Authority-Analysis: v=2.4 cv=YogPR5YX c=1 sm=1 tr=0 ts=68cb04ff cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=RcxEoRTqGeSLHFrOZFgA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: cayg6L7CXNT87CvmSwj5bA13oK1OZF1P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDAxNyBTYWx0ZWRfX4HHF3Wa86bUJ
 qXs0LRZQoHnueXV2tvopiwEMlBCKn2g8H5SMzoQWnS7r/deZ3PZ8Cc/dz5G8Pv5vL7Z/uKGKi6C
 O+RnbJtFmwHUb6e6vcWIUsscmh5HeBMmpKGJSUK2Nt7A33CN8x+MymIAYLVJtkC8hPz3VladTlR
 YD7fORBKIFjCjIGEs/Fr8pPxd7cxtm753o1z/+ce9PFmT3YWeU7xGiQdGszI/zU8Ba/hs6cLdjz
 r/xglELMqZor3DK19MVyrr5LEbvDpEAs9shlePnIEaWXMWQAfszmTZ71/FUmiQChIUVExl7Rriz
 ANa+cXATBkcFWv+LectqWF68+8TgHKXDdfwvpg64yZ1xhSTqN1MPpLRWwnZr/CZPkezDtOd6Fa0
 Nd+FDhBx
X-Proofpoint-GUID: cayg6L7CXNT87CvmSwj5bA13oK1OZF1P
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170017

On Wed, Sep 17, 2025 at 06:35:14AM +0000, Fan, Shawn wrote:
> >> My original patch for this just skipped the GHES->offline process
> >> for huge pages. But I wasn't aware of the sysctl control. That provides
> >> a better solution.
> >
> > Tony, does that mean you're OK with using the existing sysctl interface? If
> > so, I'll just send a separate patch to update the sysfs-memory-page-offline
> > documentation and drop the rest.
> 
> Kyle,
> 
> It depends on which camp the external customer that reported this
> falls into:
> 
> 1) "I'm OK disabling all soft offline requests".
> 
> or the:
> 
> 2) "I'd like 4K pages to still go offline if the BIOS asks, just not any huge pages".
> 
> Shawn: Can you please find out?
> 
> 
> -> Prefer the 2nd option,  "4K pages still go offline if the BIOS asks, just not any huge pages."

OK, thank you.

Does that mean they want to avoid offlining transparent huge pages as well?

Thanks,
Kyle Meyer

