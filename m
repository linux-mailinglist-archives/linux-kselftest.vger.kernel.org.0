Return-Path: <linux-kselftest+bounces-45338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD7AC4F41C
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC8694EA1CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E54936B07B;
	Tue, 11 Nov 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="jhB/8hoI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E483AA1BB;
	Tue, 11 Nov 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882542; cv=none; b=SU/vpBEi/NaI/CIyCHdsjdv8O5ZaMs1IhA6WHc/IyY3Be239byhWPqkTd+NCHx1FcTVzRZY/fVsWpGL0OpKUgmAUbbfsGeA06jb3p7sGGBzNbg0W6s080xQDn01cPO/zAkp1DgiCcuucJDpMu4L11tWCNDP/CL43XEFf2VfYDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882542; c=relaxed/simple;
	bh=bZYITAb//HGZ/PK53HRhVxiYBDhYkagJ10l0AcE+do4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxEGgivqtZzDPQH0mBDNBu6PmqPbdgNeRB6lLsIHJcnIPkHcq/E1q05ThW6MTb2v/Cc6BlTPKO7pmRHChmhMKrVRL1llWFlOX4KeMU8+fcekjq2m20iTrZC1ImLRjAsIeR9tqclVEQYd1+ODaIkoGueexXXy9Tlk6lHlRd3t170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=jhB/8hoI; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABGKcVR2600415;
	Tue, 11 Nov 2025 09:35:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=1VmrT0oK0iGhp/K108c6
	n2yMdw8L2qW+yW/LKJlR7r8=; b=jhB/8hoIiwGkHDHZuosISLCqsZPcsW7go/1Z
	14WbFu84GWH0PDiEAWGTL3q2M8mmZH9UeKcaCNE5JnWnaspHa8NMZbjy3SJN1/ud
	yNzqPPfWyToCpVYzfYDes4z7f3Pt2k31rTfZxKG0LnTKYCfncNWGEtiQrbRRzxXZ
	WKG+AUUoy47jBNd/nDi8Tu1auI+sYn+VbUNFEW6j6fTZMHX5tqmJGkrzfada850A
	XtvAEza9sF16F3akULp3A3XCSI2gYfHu4A2k4L0bksQbuWdFqjICCm3vIMtr4t3Z
	9aH7xhZtuxYV3akNDPiVH9trvj+GS7Dzd03+sA3odTYWqZGsOw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac8k50qr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 09:35:34 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 17:35:33 +0000
Date: Tue, 11 Nov 2025 09:35:31 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] vfio: selftests: add iova range query helpers
Message-ID: <aRNz4ynek6siv0FZ@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
 <20251111-iova-ranges-v2-1-0fa267ff9b78@fb.com>
 <20251111100948.513f013b.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111100948.513f013b.alex@shazbot.org>
X-Proofpoint-ORIG-GUID: QMCfOnNg60SOxZedip_bSss0IoH7Lnn2
X-Authority-Analysis: v=2.4 cv=X95f6WTe c=1 sm=1 tr=0 ts=691373e6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=gAnhvMwacpa_2wFJLncA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE0MyBTYWx0ZWRfXyIOIECX72vEv
 4WvyxnSGk875oGuNWM2RzDuzoksf5qXBCiwV3ZwiwvnCThAFlOA2/z1mHhoH0a5ped6iH/SBNCW
 nW7ki7nPSzDNUSBzyA0pv4rkzzZ28V0jiORU2XZCchqg8xITasOybsBT3SmouJerWviQR3AJ3y8
 mI+NdFr6EUf5iyykldGJ5sIoTKWl/KTl1TuMzU79Ad7VxzP4LFJVWnNiQNZInTKKBd+ACq9pLoj
 HJPb94XHckCWh+DmQGfwYy1+FdbyW6zGhq2lbJJMqJ2UH9V9pNlOf68I5uJJ27XNTNVF9uRao76
 lfRCrQO8cUB+Z+NaBAbFyyOxR0/aNgA7BL9aokpJ9wbZomGfoxZ8w0PK1wjT5NitXGfn8FtMEtu
 iKlhvVS6SnoCUL68/vNViqGyH0mC3g==
X-Proofpoint-GUID: QMCfOnNg60SOxZedip_bSss0IoH7Lnn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01

On Tue, Nov 11, 2025 at 10:09:48AM -0700, Alex Williamson wrote:
> On Tue, 11 Nov 2025 06:52:02 -0800
> Alex Mastro <amastro@fb.com> wrote:
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > index a381fd253aa7..7a523e3f2dce 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > @@ -29,6 +29,173 @@
> >  	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
> >  } while (0)
> >  
> > +static struct vfio_info_cap_header *next_cap_hdr(void *buf, size_t bufsz,
> > +						 size_t *cap_offset)
> > +{
> > +	struct vfio_info_cap_header *hdr;
> > +
> > +	if (!*cap_offset)
> > +		return NULL;
> > +
> > +	VFIO_ASSERT_LT(*cap_offset, bufsz);
> > +	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
> > +
> > +	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
> > +
> > +	if (hdr->next)
> > +		VFIO_ASSERT_GT(hdr->next, *cap_offset);
> 
> This might be implementation, but I don't think it's a requirement.
> The vfio capability chains are based on PCI capabilities, which have no
> ordering requirement.  Thanks,

My main interest was to enforce that the chain doesn't contain a cycle, and
checking for monotonically increasing cap offset was the simplest way I could
think of to guarantee such.

If there isn't such a check, and kernel vends a malformed cycle-containing
chain, chain traversal would infinite loop.

Given the location of this test code coupled to the kernel tree, do you think
such assumptions about implementation still reach too far? If yes, I can either
remove this check, or try to make cycle detection more relaxed about offsets
potentially going backwards.

> Alex
> 
> > +
> > +	*cap_offset = hdr->next;
> > +
> > +	return hdr;
> > +}

