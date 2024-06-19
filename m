Return-Path: <linux-kselftest+bounces-12186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D797D90E068
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550151F23239
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E7BA53;
	Wed, 19 Jun 2024 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rq2gAR6M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E1368;
	Wed, 19 Jun 2024 00:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755537; cv=none; b=Ju97eOMweiBuNar/b9F8FyQ+vaCsJDTfzbjUm9XIKTOXQuwDyqykPNFwStW1eNeAUOIqiiCNlkGyL9AcmJTtjQNEsE4JlOtl/hfLi1WyLtzUJbY4aDyd6EO+4kOPvjxnCLxUfM7EtOsD22qsxMNKBKXXOmEJKjqBFWbYdOIeJis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755537; c=relaxed/simple;
	bh=NMCaz7sUYawxUueQXQKrqBTtfZhkcs2oGamWrEr2gSM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=D3AcyjN7GHOwejCL5pYgZGOKV94V/VeGtn6mcbdTulk4GXH7XluVEwqf7OaxZ9eOkilNwgRKMUsKFuRrfhFeOfNyD9gudajRScJRmhXWEu76OPZ7GoYt02SXMw5+6zTbX59VxUyEiJIrdsK6It4GHFLzshfeiOdCHlLUa398PIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rq2gAR6M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILZtP4014346;
	Wed, 19 Jun 2024 00:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=99dxeZteqvg7p6OK+iLSX+
	t95KV+cPhMZG+8mrLXaF0=; b=Rq2gAR6MGC5ASfUIiUgOEBf6rgrvpIIQ04lNg+
	z8+1/YZst/Fi3Uh80pivG949nkNPAZYi74wnq4iQGxN+ExSME9Wrl0cNIhA24JrL
	OW5X3xcst+hWwJRbd60we0x9Lh7qoYbh+Z2KyGy6pmQbIPyE88Wfm3l4ZFJgi7F5
	R9SjVJpDLvlkqVVbP5Cs4EWsV0Tlw8VfkeEPxvwV/GND9+Kdd65uKKcyPnl1CUPb
	z41Vg1eyqXp2Zj/S7RlY8eov6jwmyyyTJ3UpJMv85DdsjK6htVqG/HvHIwEA9MO5
	0lFmKWXkxlFeE/451QvIygwlIoA/bKWYfGDNOe1vLrBgL1dw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9x07a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J05Gn5011372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:16 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 17:05:15 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Subject: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
Date: Tue, 18 Jun 2024 17:05:06 -0700
Message-ID: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALIgcmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNL3dSK5JzS4syyVN300gJdMzMjU0tDY4ukpLQ0JaCegqLUtMwKsHn
 RSkFuzkqxtbUARQcl3mQAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, <maz@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>,
        Fuad Tabba <tabba@google.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZLQQIfutOgsOTLordQhA7a2Ch1vdnYp4
X-Proofpoint-GUID: ZLQQIfutOgsOTLordQhA7a2Ch1vdnYp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180176

In arm64 pKVM and QuIC's Gunyah protected VM model, we want to support
grabbing shmem user pages instead of using KVM's guestmemfd. These
hypervisors provide a different isolation model than the CoCo
implementations from x86. KVM's guest_memfd is focused on providing
memory that is more isolated than AVF requires. Some specific examples
include ability to pre-load data onto guest-private pages, dynamically
sharing/isolating guest pages without copy, and (future) migrating
guest-private pages.  In sum of those differences after a discussion in
[1] and at PUCK, we want to try to stick with existing shmem and extend
GUP to support the isolation needs for arm64 pKVM and Gunyah. To that
end, we introduce the concept of "exclusive GUP pinning", which enforces
that only one pin of any kind is allowed when using the FOLL_EXCLUSIVE
flag is set. This behavior doesn't affect FOLL_GET or any other folio
refcount operations that don't go through the FOLL_PIN path.

[1]: https://lore.kernel.org/all/20240319143119.GA2736@willie-the-truck/

Tree with patches at:
https://git.codelinaro.org/clo/linux-kernel/gunyah-linux/-/tree/sent/exclusive-gup-v1

	 anup@brainfault.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com,  aou@eecs.berkeley.edu, seanjc@google.com,
	viro@zeniv.linux.org.uk,  brauner@kernel.org,
	willy@infradead.org, akpm@linux-foundation.org,
	 xiaoyao.li@intel.com, yilun.xu@intel.com,
	chao.p.peng@linux.intel.com,  jarkko@kernel.org,
	amoorthy@google.com, dmatlack@google.com,
	 yu.c.zhang@linux.intel.com, isaku.yamahata@intel.com,
	mic@digikod.net,  vbabka@suse.cz, vannapurve@google.com,
	ackerleytng@google.com,  mail@maciej.szmigiero.name,
	david@redhat.com, michael.roth@amd.com,  wei.w.wang@intel.com,
	liam.merwick@oracle.com, isaku.yamahata@gmail.com,
	 kirill.shutemov@linux.intel.com, suzuki.poulose@arm.com,
	steven.price@arm.com,  quic_eberman@quicinc.com,
	quic_mnalajal@quicinc.com, quic_tsoni@quicinc.com,
	 quic_svaddagi@quicinc.com, quic_cvanscha@quicinc.com,
	 quic_pderrin@quicinc.com, quic_pheragu@quicinc.com,
	catalin.marinas@arm.com,  james.morse@arm.com,
	yuzenghui@huawei.com, oliver.upton@linux.dev,  maz@kernel.org,
	will@kernel.org, qperret@google.com, keirf@google.com,
	 tabba@google.com

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
Elliot Berman (2):
      mm/gup-test: Verify exclusive pinned
      mm/gup_test: Verify GUP grabs same pages twice

Fuad Tabba (3):
      mm/gup: Move GUP_PIN_COUNTING_BIAS to page_ref.h
      mm/gup: Add an option for obtaining an exclusive pin
      mm/gup: Add support for re-pinning a normal pinned page as exclusive

 include/linux/mm.h                    |  57 ++++----
 include/linux/mm_types.h              |   2 +
 include/linux/page_ref.h              |  74 ++++++++++
 mm/Kconfig                            |   5 +
 mm/gup.c                              | 265 ++++++++++++++++++++++++++++++----
 mm/gup_test.c                         | 108 ++++++++++++++
 mm/gup_test.h                         |   1 +
 tools/testing/selftests/mm/gup_test.c |   5 +-
 8 files changed, 457 insertions(+), 60 deletions(-)
---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240509-exclusive-gup-66259138bbff

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


