Return-Path: <linux-kselftest+bounces-45467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A49C54AE6
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 23:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B253A8F40
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454DA2D839E;
	Wed, 12 Nov 2025 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="yn/7LuWP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574C28CF56;
	Wed, 12 Nov 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985255; cv=none; b=nDQyjN9ltmjIgRt9lQ3AmQj3qROCxBCMh0ZqAQzAgtH8hCzxImNCAxzgorGZ68fL5Mq+jYF2tfYlW11dTkOH/Ed5q8WAGmc4douT4h9u+ykqGgKmkCuIOrNFJqrk3a8z0uNoBEnLeaBGCEIIhtJcoWd3HYfGZumLdxCp1M0IP20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985255; c=relaxed/simple;
	bh=vFb162fQrfik4BXt5CZU9D4wyBDl0W+eQVuWkuKKRQE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUAkkIAS7Pc0++SO/i6aUDhiRZha6bWdmcKqY5XBVq7iJZpthojq82OQBv2fwU9M1c+ZL2dL8MGMYFnJEWnqIx8mqrIb9pc7ZYf9+8xknxgUDYfei0sjFDJiA7qGAe0KOTXr93xnLIlyi3EwiRXh15dw+rs/YteURWOXIrinp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=yn/7LuWP; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5ACJUfBW1517738;
	Wed, 12 Nov 2025 14:07:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=dyPzt6jYWQBlgpZrAEGm
	Ly5XUl+8bBVMINlubHmdpe8=; b=yn/7LuWPdJq/zbD+UyTGYFExLs8tgTr1y7wU
	2Zv29CCZ4VQiHQtyLQXIyzjrO9fzfejC12xm3+TkiB/U/q2lw9rBFvF/3W4/DNJy
	5P+1cU6wBM+vQ3deX5bZW4L1oDpPiy0r71E8PNqZ/KOHuUofBBxi/zjFx6YBL852
	ZXyVOoe48thRkpwNBvwqwNdeObw4saxPu0rm9U+qz+pjNeqNwi3LaKXG0jmiSZU4
	DqG74+vDWgoXlzyU4lz812TpM8nyg93ooHGOpyPKyRwn658CPqiZqQbEX4p1YfFy
	3RrkonWK6VX80t+//cARdziEKEbs/rvAIDOnR+0DDvoaT0kRNw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4acuj7cdkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Nov 2025 14:07:26 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 12 Nov 2025 22:07:25 +0000
Date: Wed, 12 Nov 2025 14:07:20 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Alex Williamson
	<alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Josh Hilke
	<jrhilke@google.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        Raghavendra Rao Ananta
	<rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
Message-ID: <aRUFGHPe+EXao10B@devgpu015.cco6.facebook.com>
References: <20251112192232.442761-1-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112192232.442761-1-dmatlack@google.com>
X-Proofpoint-GUID: a6rH3zQb7kVzxe_6ShyBkjTM7yvOQYUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3OSBTYWx0ZWRfX0bCPA514uoLx
 UFqKskTLffagL1adLoObxbJOYTr/g/DXCg270IplUb0WBp3nA+xzwAyrizRtc/4UFmZgfCL9+XP
 Q834SzfrPCTPFoYGazp/90tKnyEail34Kb1gOrzMbQw7/46laste7h7Ydm7l/lqQJA9ZIGsNJtV
 ilaS1miMxZYN6/3pY6MJ7H+rvzt9YnW/ng2V5Y+LMPe2lJFz6ewBxSSqv3xc3WwFGPqtkAz5JeX
 eAB3baQ8FbjkgbqniFioNSBeaFDdkw7ThgcTwE5E2K2ykGgYwFKxZ4/Q2nJl1yUXpZ90QXnLY87
 c0NmJdqefd+VDrHMkjSei5zVzh2fbJN21NbfiDpWWMlBLp4Fu665ALYeODcaLMT1bvduvBcRH/F
 4WTPBo+GKjK1qDHEtT8oDz5jMPbhVQ==
X-Authority-Analysis: v=2.4 cv=H8LWAuYi c=1 sm=1 tr=0 ts=6915051e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=BPcALthgWs1Ll9ulZ4YA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: a6rH3zQb7kVzxe_6ShyBkjTM7yvOQYUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01

On Wed, Nov 12, 2025 at 07:22:14PM +0000, David Matlack wrote:
> This series adds support for tests that use multiple devices, and adds
> one new test, vfio_pci_device_init_perf_test, which measures parallel
> device initialization time to demonstrate the improvement from commit
> e908f58b6beb ("vfio/pci: Separate SR-IOV VF dev_set").

The new test runs and passes for me.

Tested-by: Alex Mastro <amastro@fb.com>

$ vfio_pci_device_init_perf_test $(readlink -f /sys/class/vfio-dev/*/../.. | xargs -n1 basename)
Testing parallel initialization of 24 devices:
    0000:05:00.0
    0000:06:00.0
    0000:27:00.0
    0000:28:00.0
    0000:e5:00.0
    0000:e6:00.0
    0000:e7:00.0
    0000:e8:00.0
    0000:e9:00.0
    0000:ea:00.0
    0000:c5:00.0
    0000:c6:00.0
    0000:07:00.0
    0000:c7:00.0
    0000:c8:00.0
    0000:c9:00.0
    0000:ca:00.0
    0000:08:00.0
    0000:09:00.0
    0000:0a:00.0
    0000:23:00.0
    0000:24:00.0
    0000:25:00.0
    0000:26:00.0
TAP version 13
1..5
# Starting 5 tests from 5 test cases.
#  RUN           vfio_pci_device_init_perf_test.vfio_type1_iommu.init ...
Wall time: 1.440004083s
Min init time (per device): 1.236283226s
Max init time (per device): 1.440002010s
Avg init time (per device): 1.258762246s
#            OK  vfio_pci_device_init_perf_test.vfio_type1_iommu.init
ok 1 vfio_pci_device_init_perf_test.vfio_type1_iommu.init
#  RUN           vfio_pci_device_init_perf_test.vfio_type1v2_iommu.init ...
Wall time: 1.448952696s
Min init time (per device): 1.242623358s
Max init time (per device): 1.448951915s
Avg init time (per device): 1.264836317s
#            OK  vfio_pci_device_init_perf_test.vfio_type1v2_iommu.init
ok 2 vfio_pci_device_init_perf_test.vfio_type1v2_iommu.init
#  RUN           vfio_pci_device_init_perf_test.iommufd_compat_type1.init ...
Wall time: 1.446931666s
Min init time (per device): 1.242316634s
Max init time (per device): 1.446927360s
Avg init time (per device): 1.264904097s
#            OK  vfio_pci_device_init_perf_test.iommufd_compat_type1.init
ok 3 vfio_pci_device_init_perf_test.iommufd_compat_type1.init
#  RUN           vfio_pci_device_init_perf_test.iommufd_compat_type1v2.init ...
Wall time: 1.449211729s
Min init time (per device): 1.243377853s
Max init time (per device): 1.449211729s
Avg init time (per device): 1.264266785s
#            OK  vfio_pci_device_init_perf_test.iommufd_compat_type1v2.init
ok 4 vfio_pci_device_init_perf_test.iommufd_compat_type1v2.init
#  RUN           vfio_pci_device_init_perf_test.iommufd.init ...
Wall time: 1.447583702s
Min init time (per device): 1.241216318s
Max init time (per device): 1.447582350s
Avg init time (per device): 1.264159293s
#            OK  vfio_pci_device_init_perf_test.iommufd.init
ok 5 vfio_pci_device_init_perf_test.iommufd.init
# PASSED: 5 / 5 tests passed.
# Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

 

