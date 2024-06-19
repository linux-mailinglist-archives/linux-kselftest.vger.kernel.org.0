Return-Path: <linux-kselftest+bounces-12188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAADB90E080
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9081C2118C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715337B;
	Wed, 19 Jun 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aUoeFcz7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC08368;
	Wed, 19 Jun 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755918; cv=none; b=SqAgcU+yjcuzFTiI7DPRyaKc+n44/nFfiNsWZVqlm/AswkNOfLRjM92ycfUyuJlLqB8AjD9QuabzYUkff5tYjx8C0r9IFUs+RF9GYDGMudX3Q2e1R9F9Ot9OgVIdNm2Ju9jvO0Vu48lnbriEi/dUQF5GSyuZUc5PutLuAjK1KeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755918; c=relaxed/simple;
	bh=LWcZ51UxFIRAL/r9A4s2Tdn7a2it7Yp0C+WI7OUTKg8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUU2RtJDAvfOrqKzjrx137PEEX4EcFWSV9HBPVkoBj2Zezh8g2I+2vJqXoTDcMU6yiEoD7iR/BblurSH4fWMWUd2a3i4d0ooVihV1QJSUKgPuKH3DDHBSeOw7ix2SwGGijvGNn2DeI7fsuI85zYdPDaEXHZrYt0bTrQVAYuEYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aUoeFcz7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILZsTY006075;
	Wed, 19 Jun 2024 00:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KZU+R13/Ttt99a5SqVwpops+
	V2v9unmEIBAarn5mQJ4=; b=aUoeFcz7t0nCQEjWostul9clAp42UKksOciHpmfX
	BwK8DQjww10rB09sy64oKigiCAb2GNwdzt52Q9qX7DFBzwfCHcRnkit0mEeOKR0G
	/nXNhJy4o8uyw6SfMesilR4yikPpZ+d+6qWVRxk10UI/2Wxry41K7almnowA1TmC
	1CQ8HLVxkU3nzFJTxyyrg9hFlXUiEyA7UkvElK/VWb6pa5bd9aN4n0HTWBJ58dNL
	m1FAst1BuKTColUSDvYSINCM8xfR0u2B3a2XlnsQAeSTfgp3SLQAEeiD7sFdkVLh
	+0Ht84cwvYmR3Zn1brs/Uyr7A8yO1YHX4rT4xKtWwEO8Lg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9u07pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:11:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J0B1e7014737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:11:01 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 17:11:00 -0700
Date: Tue, 18 Jun 2024 17:11:00 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, <maz@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
        Fuad Tabba
	<tabba@google.com>, <chenhuacai@kernel.org>,
        <mpe@ellerman.id.au>, <anup@brainfault.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <seanjc@google.com>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <willy@infradead.org>,
        <akpm@linux-foundation.org>, <xiaoyao.li@intel.com>,
        <yilun.xu@intel.com>, <chao.p.peng@linux.intel.com>,
        <jarkko@kernel.org>, <amoorthy@google.com>, <dmatlack@google.com>,
        <yu.c.zhang@linux.intel.com>, <isaku.yamahata@intel.com>,
        <mic@digikod.net>, <vbabka@suse.cz>, <vannapurve@google.com>,
        <ackerleytng@google.com>, <mail@maciej.szmigiero.name>,
        <david@redhat.com>, <michael.roth@amd.com>, <wei.w.wang@intel.com>,
        <liam.merwick@oracle.com>, <isaku.yamahata@gmail.com>,
        <kirill.shutemov@linux.intel.com>, <suzuki.poulose@arm.com>,
        <steven.price@arm.com>, <quic_eberman@quicinc.com>,
        <quic_mnalajal@quicinc.com>, <quic_tsoni@quicinc.com>,
        <quic_svaddagi@quicinc.com>, <quic_cvanscha@quicinc.com>,
        <quic_pderrin@quicinc.com>, <quic_pheragu@quicinc.com>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>,
        <yuzenghui@huawei.com>, <oliver.upton@linux.dev>, <maz@kernel.org>,
        <will@kernel.org>, <qperret@google.com>, <keirf@google.com>
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Message-ID: <20240618170853139-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YwAw23Mh7tamv-wTy3-W4oEdnIM4fPV1
X-Proofpoint-ORIG-GUID: YwAw23Mh7tamv-wTy3-W4oEdnIM4fPV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190000

b4 wasn't happy with my copy/paste of the CC list from Fuad's series
[1]. CC'ing them here.

[1]: https://lore.kernel.org/all/20240222161047.402609-1-tabba@google.com/

On Tue, Jun 18, 2024 at 05:05:06PM -0700, Elliot Berman wrote:
> In arm64 pKVM and QuIC's Gunyah protected VM model, we want to support
> grabbing shmem user pages instead of using KVM's guestmemfd. These
> hypervisors provide a different isolation model than the CoCo
> implementations from x86. KVM's guest_memfd is focused on providing
> memory that is more isolated than AVF requires. Some specific examples
> include ability to pre-load data onto guest-private pages, dynamically
> sharing/isolating guest pages without copy, and (future) migrating
> guest-private pages.  In sum of those differences after a discussion in
> [1] and at PUCK, we want to try to stick with existing shmem and extend
> GUP to support the isolation needs for arm64 pKVM and Gunyah. To that
> end, we introduce the concept of "exclusive GUP pinning", which enforces
> that only one pin of any kind is allowed when using the FOLL_EXCLUSIVE
> flag is set. This behavior doesn't affect FOLL_GET or any other folio
> refcount operations that don't go through the FOLL_PIN path.
> 
> [1]: https://lore.kernel.org/all/20240319143119.GA2736@willie-the-truck/
> 
> Tree with patches at:
> https://git.codelinaro.org/clo/linux-kernel/gunyah-linux/-/tree/sent/exclusive-gup-v1
> 
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
> Elliot Berman (2):
>       mm/gup-test: Verify exclusive pinned
>       mm/gup_test: Verify GUP grabs same pages twice
> 
> Fuad Tabba (3):
>       mm/gup: Move GUP_PIN_COUNTING_BIAS to page_ref.h
>       mm/gup: Add an option for obtaining an exclusive pin
>       mm/gup: Add support for re-pinning a normal pinned page as exclusive
> 
>  include/linux/mm.h                    |  57 ++++----
>  include/linux/mm_types.h              |   2 +
>  include/linux/page_ref.h              |  74 ++++++++++
>  mm/Kconfig                            |   5 +
>  mm/gup.c                              | 265 ++++++++++++++++++++++++++++++----
>  mm/gup_test.c                         | 108 ++++++++++++++
>  mm/gup_test.h                         |   1 +
>  tools/testing/selftests/mm/gup_test.c |   5 +-
>  8 files changed, 457 insertions(+), 60 deletions(-)
> ---
> base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
> change-id: 20240509-exclusive-gup-66259138bbff
> 
> Best regards,
> -- 
> Elliot Berman <quic_eberman@quicinc.com>
> 

