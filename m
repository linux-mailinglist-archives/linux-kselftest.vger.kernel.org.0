Return-Path: <linux-kselftest+bounces-41612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A4CB59FF0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 20:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880FF46736E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6577328505C;
	Tue, 16 Sep 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="FWNkANcf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1ED248883;
	Tue, 16 Sep 2025 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045649; cv=none; b=ZWnzppuyz8O4AeD4tvvcBhEhL4uKC9YXO0i5J3bnf6K+Uy/Apu2WupNK9n/+c0/lOwIONvpb9gfWUpnKJhCt7aIWMbA8i6HAW4bRuCZlq6Rvu82LQuMxwOOBw8H0/T3qD4UPUqzPJf2/adupiK9hIEcJDNub8nnQSRgC8u1eIGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045649; c=relaxed/simple;
	bh=jWw5O/b6xV6e5tWg7ujHYCewERYczS4HhlfSbjCVMRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPfDAx4G0Md0Ru5Ji6yRBOsgqRh+iBKHrXK5qlBUn5ISOGBn8pZrh/m1wplrRr5zZWOHuVfJ+ta8P0DBIlO2gPEbG1Q8RRaf25DaXfb9zi2TkJlQsfmsIreXsxY0OQA8IjEubDlnZ2zidUMBaQ+YOJaHV6X/CzdoYWKmPgGjT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=FWNkANcf; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GGWQ0u021477;
	Tue, 16 Sep 2025 17:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=6xWs40zs4LLj/t8X8LdM1V8hVh
	jivA2n6F7OPpYtRV0=; b=FWNkANcfHlJCaoS2LFWDFRqfMi7MUlRktev1xzCpRu
	Vbpz+2FUKa7b0Xa52j948oIwMLUv77ekaeXbKhTCMEL0G+sK9OIHDgjhfUG/0SrL
	mP+RqLYcWq2ZfvbReJjbRxURQslY1S72vY+icA8kydnwsKGv1QcQiy/21zgsZw6Z
	cnCbg9QjYItmPPLlV5YZSTuxTsjfP8Q++akSoKlpfg7vBKiS8m+Cjdw4kqg7Gu+4
	+R9z7dh9jQTpc2GucXb7WZKSwzFW4LWKMX2E8JSXijf8lEu7SoJYR3rQKV6i7noK
	iGwaEVKKPymCxdAxUWTiISsLgeuRnLJ+9aEDOaWxaCrw==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4972u8n96f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 17:59:45 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 61D5F805E2F;
	Tue, 16 Sep 2025 17:59:44 +0000 (UTC)
Received: from HPE-5CG20646DK.localdomain (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id A42F3800EE4;
	Tue, 16 Sep 2025 17:59:40 +0000 (UTC)
Date: Tue, 16 Sep 2025 12:59:32 -0500
From: Kyle Meyer <kyle.meyer@hpe.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
        "Fan, Shawn" <shawn.fan@intel.com>,
        "surenb@google.com" <surenb@google.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Message-ID: <aMmlhPghbpnlCZ09@hpe.com>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
 <aMkOCmGBhZKhKPrI@hpe.com>
 <SJ1PR11MB60831F028E2FEB6B5A3390D9FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60831F028E2FEB6B5A3390D9FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Proofpoint-GUID: Q7Cf_oIk6h3gAbSjKmPOmUD-fW7GlGMm
X-Proofpoint-ORIG-GUID: Q7Cf_oIk6h3gAbSjKmPOmUD-fW7GlGMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDA2MyBTYWx0ZWRfX2QHb884MSCLw
 Mr0AHfkH2X4MplkHMZzSH28hLGQTwuYPWJqLUHhlqtNwCwZSlrEzOEU6/g2IvlwXwjdnzKvQX4b
 mITesEa2x7XS/A51soK6REZMUCKl642UneGW6ml44Ic6QSSFFVkpjbJYPEMoyeJdrZnCFmtMM2J
 8+lrVcukOZ/2uo9SOABl6+U8MOtcnLlkwY3f9NI8doesg+QnQmp9ge1Ak3FGSENu1JdBl2DUDP4
 IHKwYtzzCAPAC1buR5DiHXq1Qq61+yphJRLwUSE0qkQev9alawSZXi6XUzPvndAgfgckglvKGed
 15PtdtZ+B0J/mEYx1PbVNzmE9MM7o6iUlXeM7wRKqW6Kh4rDq+AOAGagJZkDlcxcsL+LBJKKmp6
 KnOfRC1v
X-Authority-Analysis: v=2.4 cv=T+GMT+KQ c=1 sm=1 tr=0 ts=68c9a591 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=QyXUC8HyAAAA:8 a=vcrsxdLqD5ATI8kw6fUA:9
 a=CjuIK1q_8ugA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160063

On Tue, Sep 16, 2025 at 03:20:49PM +0000, Luck, Tony wrote:
> >> > Reported-by: Shawn Fan <shawn.fan@intel.com>
> >> 
> >> Interesting.  What did Shawn report? (Closes:!).
> >
> > Tony or Shawn, could you please point me to the original report? Thanks!
> 
> Original report is internal to Intel, so no useful link for the community (but
> I still wanted to give credit).
> 
> Recap of original problem is that some BIOS keep track of error threshold
> per-rank and use this GHES mechanism to report threshold exceeded on
> the rank.
> 
> Systems that stay up a long time can accumulate enough soft errors
> to trigger this threshold. But the action of taking a page offline isn't
> going to help. For a 4K page this is merely annoying. For 1G page
> it can mess things up badly.
> 
> My original patch for this just skipped the GHES->offline process
> for huge pages. But I wasn't aware of the sysctl control. That provides
> a better solution.

Tony, does that mean you're OK with using the existing sysctl interface? If
so, I'll just send a separate patch to update the sysfs-memory-page-offline
documentation and drop the rest.

Thanks,
Kyle Meyer

