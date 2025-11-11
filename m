Return-Path: <linux-kselftest+bounces-45342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23333C4F57E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53933A80EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DFC3A1D16;
	Tue, 11 Nov 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="z/Nam/XU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E136B05F;
	Tue, 11 Nov 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883970; cv=none; b=rrc73BEcnWLXJ3/l/N4MtjDa8HMv8fFPvhEwSX8o07tK8idLvEKKrL071KRxO9w5Hz2oxANNtnfVU6+ddpdIusf8xXutfj0XEY5pDSjBM2ICkYQwqug/BdedXLICMRF7uvy0zXgrLh0+U6WHxrP7CEG4rowb3RbpkSVgda/QjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883970; c=relaxed/simple;
	bh=wPj5vVJ1YtKHjf81QWXyvaJqGXJKZIFerpk4kTAdFjI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r53IvnQx0WNLvyHwWsT+JYXmW4iBN8oEX76xFdEkQN4Rdf3Zl1Db09PuhQN/iEPBWAPKH+dUnfdqvemh0GpoYJsJTBz5Wl6SuOy5uNHzJAe+63mZG2ePPdPrDhtCtbbN3INVUSBdsDjOOPgC4zUpgXGXZ0C5kX2R+ohbR3SHNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=z/Nam/XU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABCFLAc1434375;
	Tue, 11 Nov 2025 09:59:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=DvfPjs5kBAETFMTBWW1/
	kBVT3srDOto+/Gf3urRsfIU=; b=z/Nam/XUvMzD5evT9DfklRxO5OwIMVxF20MQ
	p69zSIk7AsFCrZgmlimsnaiFFwZmUXRfnyC70EzkO0EMbH4e8WEUXBfqpxH6syNJ
	JErsOJgbZorBUEpLD45UYTbBhaD6CfTqwnLxHtsp7IC10WYCyzQyZdrmjza0ewep
	QkMpI6h7B26oNYuhATzrEee5O5KywE43LWR7/CgH1X/mPV3Wi+jdXNjpVjFd5rwf
	geUSV/NMhkVxjCe48KxrosI16Dc4HKshnyCpbm+dW4tKBipjvPXvyE6tyIAK+nRV
	TFgl6F2tSBnnlLZV2mFBg1CM5fS+cBaz26FUy9iI6XkMBQTfNw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ac502aqye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 11 Nov 2025 09:59:22 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 11 Nov 2025 17:59:08 +0000
Date: Tue, 11 Nov 2025 09:59:00 -0800
From: Alex Mastro <amastro@fb.com>
To: Alex Williamson <alex@shazbot.org>
CC: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] vfio: selftests: add iova range query helpers
Message-ID: <aRN5ZBWJ16I/TtY5@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
 <20251111-iova-ranges-v2-1-0fa267ff9b78@fb.com>
 <20251111100948.513f013b.alex@shazbot.org>
 <aRNz4ynek6siv0FZ@devgpu015.cco6.facebook.com>
 <20251111105202.3aa734aa.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111105202.3aa734aa.alex@shazbot.org>
X-Proofpoint-GUID: e1yVIs7jH70XmYrKTK7gWc5NuAWppnOt
X-Authority-Analysis: v=2.4 cv=CPInnBrD c=1 sm=1 tr=0 ts=6913797a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=KS96cTW66y6CtfVdv8wA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: e1yVIs7jH70XmYrKTK7gWc5NuAWppnOt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE0NiBTYWx0ZWRfX/8KDQuzfSw9h
 hff7Yx6wXmpSFX5SKyT0wYWEc5WUwyAcpDkoH8utFnmmida4UVNY5rUnkqgLB4lSSqtO4FYhU56
 oqAJ73kNbJwNNJx8io8p81xWF0zNTqwrqtg3gwxxHO5kW8W7HVrwk2tArdVHff9Md47y0vmRFV/
 u9xuHtEb6bC6FPf4tRLd2cpDRRon5ph2MSvY1csNW4khp4HI5o4BN9j5uGoHHu/bATgO04PdK5b
 5e2qW4700iMwhtZPK4yNeZHUJ4xVNIvkdSJmBh0uNlBfwPvHzhU4PhNEiEPYWLSZ8BnY8l0VrGq
 QX0N/3dC9QbbPKRr+Uxic7TquB0pPSwvV4O5L5wupbiTS/gAx4D2SaWRbqbLiAUxFkafVM4W++V
 0ph5Y1v8E3LlpbNlNzLxeGjHyPhlBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01

On Tue, Nov 11, 2025 at 10:52:02AM -0700, Alex Williamson wrote:
> On Tue, 11 Nov 2025 09:35:31 -0800
> Alex Mastro <amastro@fb.com> wrote:
> 
> > On Tue, Nov 11, 2025 at 10:09:48AM -0700, Alex Williamson wrote:
> > > On Tue, 11 Nov 2025 06:52:02 -0800
> > > Alex Mastro <amastro@fb.com> wrote:  
> > > > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > > index a381fd253aa7..7a523e3f2dce 100644
> > > > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > > > @@ -29,6 +29,173 @@
> > > >  	VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
> > > >  } while (0)
> > > >  
> > > > +static struct vfio_info_cap_header *next_cap_hdr(void *buf, size_t bufsz,
> > > > +						 size_t *cap_offset)
> > > > +{
> > > > +	struct vfio_info_cap_header *hdr;
> > > > +
> > > > +	if (!*cap_offset)
> > > > +		return NULL;
> > > > +
> > > > +	VFIO_ASSERT_LT(*cap_offset, bufsz);
> > > > +	VFIO_ASSERT_GE(bufsz - *cap_offset, sizeof(*hdr));
> > > > +
> > > > +	hdr = (struct vfio_info_cap_header *)((u8 *)buf + *cap_offset);
> > > > +
> > > > +	if (hdr->next)
> > > > +		VFIO_ASSERT_GT(hdr->next, *cap_offset);  
> > > 
> > > This might be implementation, but I don't think it's a requirement.
> > > The vfio capability chains are based on PCI capabilities, which have no
> > > ordering requirement.  Thanks,  
> > 
> > My main interest was to enforce that the chain doesn't contain a cycle, and
> > checking for monotonically increasing cap offset was the simplest way I could
> > think of to guarantee such.
> > 
> > If there isn't such a check, and kernel vends a malformed cycle-containing
> > chain, chain traversal would infinite loop.
> > 
> > Given the location of this test code coupled to the kernel tree, do you think
> > such assumptions about implementation still reach too far? If yes, I can either
> > remove this check, or try to make cycle detection more relaxed about offsets
> > potentially going backwards.
> 
> I've seen cycle detection in PCI config space implemented as just a
> depth/ttl counter.  Max cycles is roughly (buffer-size/header-size).  I
> think that would be sufficient if we want to include that sanity
> testing.  Thanks,

Thanks, that's a good suggestion -- will take this in v3.

> 
> Alex

