Return-Path: <linux-kselftest+bounces-45337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD9DC4F3C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C48A4EA1C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85643393DDB;
	Tue, 11 Nov 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="aKBLdjZT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0805377EB0;
	Tue, 11 Nov 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881716; cv=none; b=SPRqoY1b0MwD/jerWS6SRiCFAXDwdcS6/3HAXeRxMWaFiXopFLur28JzBPIYnC2xgdhjU4+8HyEi+1JKI4s7JQA/xEhgRHyE7khEwGZ3Vj+Lmk/HtDcurBJmfVDwLzQOSKcfxYRarNjZm1nQEFG8uFE4nog68FjfgRs9AEDh8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881716; c=relaxed/simple;
	bh=fuqENK+IXsMOYm83prHO8wvPQcKnRV9scZ0BlypezfU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWh9sSKipxBdL7Rfg4tPsUwbR4QJLpEUo/PzyDOiwmar06N+ekk3yoaJSop6yXokCT17MNwIftHVr3qG8khcfXsdMqVEvOU3wCbBeQi8KZ1QYdfVM4NUuaLExnwuoSaLkgY455J+jTdr0MYj3OKsIeyqlm2Mrcmi1CfllQOxwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=aKBLdjZT; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5ABCZX751720737;
	Tue, 11 Nov 2025 09:21:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=JVrHfy2+FTEN5LTtMVbk
	x4/WKDmipBlTHNjmCOZzIzY=; b=aKBLdjZTa/VQWAOM/pOXw5cWCPMpobLN19mv
	X7Uy3ljl/R8nMsDY3hrvg+TgQI7lWhlc6hb9zBnJlywqrJ+LrFxDXj9+7XuvtrIf
	h+O5TM7iqdGN6KbnigeWqYjXkYewYuKlK4lcEmShDOgzVVDsYDGCCd4DijRohlrs
	smyG29T3I2Jd70BaXzbvQbQA1/0Z4S9qUx6P2UTp01GN5Q/nXJ95QWnRWaxcx4ui
	Nv1HKp+vhITaNXu70di3ZILPG6Vb2jc2V55+H4WKfcoKFjlIPM/LIO1f9dNspHsn
	fMXywnqyHzQL09WwPcmDhWQAvajGVaQuaQp62n48lFhcXK3zLQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ac59jt9uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 09:21:49 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 17:21:47 +0000
Date: Tue, 11 Nov 2025 09:21:43 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] vfio: selftests: replace iova=vaddr with
 allocated iovas
Message-ID: <aRNwp5v1kOdr+Of9@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
 <20251111-iova-ranges-v2-4-0fa267ff9b78@fb.com>
 <20251111100937.4706a54e.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111100937.4706a54e.alex@shazbot.org>
X-Proofpoint-ORIG-GUID: _-7hVw3qR9FkpqOzwsQ4OiHICEp6vEfv
X-Authority-Analysis: v=2.4 cv=XYGEDY55 c=1 sm=1 tr=0 ts=691370ad cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=ALVvBWExjUHIriTDfbUA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE0MSBTYWx0ZWRfXy0VMhL/kUFdD
 O3VP25MSOVNy6ZG1NbX7xH3nuuMpo9mREZ+8Zypzz4bnXQ/gvq6FvDxjZotTvB0zju1ntSTdAfq
 dIiDsC/r0BSiZNnyuDw2raSIcjeZkjs12jtioU1NLdAzRgf0P+/M5yScnBthBuxkqi09qh1K980
 Ieh6hK6pwnxzD/eY/3Nd4k+zSTXK4q/zPLfDslLnrRAvXgFZEFK4Rn79kE/D/g9bDPgQgLk+Cjj
 oDPtWmSQc36JDHqc+HLv0tYo6leikmKdOBU2KozjtX2uBR/2KCuKklT0pecud3/2yJawtkl4OVZ
 jFiTUUI+ivUQIlebtF4AaF2Jb2u54XWx+SY8hi5jd6OGAmU8oiw9LAM4ZFg54O526rPYZA5hwDl
 lyu3sPIPkYEYacrEMUCExoUupPW7Gg==
X-Proofpoint-GUID: _-7hVw3qR9FkpqOzwsQ4OiHICEp6vEfv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01

On Tue, Nov 11, 2025 at 10:09:37AM -0700, Alex Williamson wrote:
> On Tue, 11 Nov 2025 06:52:05 -0800
> Alex Mastro <amastro@fb.com> wrote:
> 
> > vfio_dma_mapping_test and vfio_pci_driver_test currently use iova=vaddr
> > as part of DMA mapping operations. The assumption that these IOVAs
> > are legal has held up on all the hardware we've tested so far, but is
> > not guaranteed. Make the tests more robust by using iova_allocator to
> > vend IOVAs, which queries legally accessible IOVAs from the underlying
> > IOMMUFD or VFIO container.
> 
> I've reported hardware that it doesn't work on, QEMU emulates such
> hardware.  The commit message suggests this is more of a theoretical
> problem.  Thanks,

Agree that it's misleading. I'll update the commit message to describe the
things you described earlier.

