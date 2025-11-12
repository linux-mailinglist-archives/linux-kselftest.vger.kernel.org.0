Return-Path: <linux-kselftest+bounces-45437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C235AC53DD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 19:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EFCD4FC605
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB905348862;
	Wed, 12 Nov 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="5rZUyUzr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB8233468A;
	Wed, 12 Nov 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762970698; cv=none; b=S3r5/ZhVVw8/LLqlUj9wkiZThhG+bYvDMRlpgMPARBim++a/qXqOU96VxVAhKP1KDjBh2f90tQUadbqoEUFA0ASW8zYP6tZ7zFY+znb6BXZ9wjFdHPQ2gflZRWk0INm3UKWpcdOdgQRaDRyl4EkDTOjLKrwtgN6OfUfnBoPDzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762970698; c=relaxed/simple;
	bh=thaPD+WJ3wmrVp9/rylWOTphTDjNy0S2OUsOypRmUJ4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj0H0QxL4eNCH6uQuApT6U65NY+PZYM29BG3Zk1NTJeQ+xFrEqLxNEGeJf2q92NnofkSrLgsnunbpMERzXntY222/gjpkTLMEyl3f75e0Bka9l2lPZWCjiIIivAkd5HIleffvoByaend2bNiDAZGTAO15AHX5KbYioQF6hJdr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=5rZUyUzr; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACCrah91140123;
	Wed, 12 Nov 2025 10:04:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=5f9Du9Vto8AzV6Fmh5aBZhgsQoxQEjzcPQeDRAHFNWg=; b=5rZUyUzrqiz8
	1QiVHBAd/AWjgKNsb4bzEYDSIuwG2uMS6u4vtXXLNscWmORGIVTB94yJ7bFMgER9
	bZ4Eh6ajR0QAuEhNp+ENjKcVs4YGgNO3JeCxrv5fCXGt0q8IA+dJ7JP2MjSKRPQ4
	XNe7+VFHE2jmzAEDhc6jRue+sWG2tlh5qUWZd4E7nZBJx90m0mHSY6g/6sTOmVFK
	yXcYp0BRhNY3yfu5USSmL6rV9+Ujq3/WDj7FUoXJQ7EtxDzSs085XeRjxdyc8Iee
	LqVFwK//7mKbqz/H69J7RJSmgjm06XqDhKzNpwPtqtnjsquNwRs698K7xbbqk61s
	H7iotA1lIQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4actn3jh3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Nov 2025 10:04:51 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 12 Nov 2025 18:04:49 +0000
Date: Wed, 12 Nov 2025 10:04:43 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Message-ID: <aRTMO7GtBTcxaPj5@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
 <CALzav=cmkiFUjENpYk3TT7czAeoh8jzp4WX_+diERu7JhyGCpA@mail.gmail.com>
 <aRTGbXB6gtkKVnLo@devgpu015.cco6.facebook.com>
 <CALzav=fwE2kPqJUiB2J20pK5bH_-1XvONQXz1DpsMSOCKa=X+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=fwE2kPqJUiB2J20pK5bH_-1XvONQXz1DpsMSOCKa=X+g@mail.gmail.com>
X-Proofpoint-ORIG-GUID: gmGOXJurSDtruhadA44ZGG4uiqxlKzIW
X-Authority-Analysis: v=2.4 cv=PeDyRyhd c=1 sm=1 tr=0 ts=6914cc43 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FOH2dFAWAAAA:8 a=jP91L4faPYvz1sexuHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: gmGOXJurSDtruhadA44ZGG4uiqxlKzIW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0NSBTYWx0ZWRfX7rN/ubatQyMR
 cAS+m6+9TjvTgRrg5unP29hU1K5axqvnlTEqZlFJNGXLUGhHeRBWSk0o9mk6MFTeM2nPAVgmBiy
 zgYeNR/DJOkMefiZ0InE+0P3BlmpoDKk8RsYi2SheBVePZg3X0mK9ftc9nbwhjJ/36MBrH0LOks
 ya3sPoWGACTK+1IOiFf0RqfdvuwYNmUI/vp4IQdZ6tk+JVcotMadppvue3MLCSef6Jxni2IMUxA
 1bNH0aP+3txcurtOUGg0BS4MaLHxwu339WbKE239MMDe74nwHtn7J0NZTa8KT1ypOtHyBXbm6mZ
 pSpT/NwRQCxN6r35pAW2JEBNtlsuTEAAZniPotKfJxDW7pWFtvMAXwgE1ZllKHHJE277wxKEIsF
 bOV3qL5nnEslcF37DIcpilTYOtVTCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-11_03,2025-10-01_01

On Wed, Nov 12, 2025 at 09:51:35AM -0800, David Matlack wrote:
> On Wed, Nov 12, 2025 at 9:40 AM Alex Mastro <amastro@fb.com> wrote:
> >
> > Hey David, is vfio_pci_driver_test known to be in good shape? Both on the base
> > commit and after my series, I am seeing below, which results in a KSFT_SKIP.
> > Invoking other tests in a similar way actually runs things with expected
> > results (my devices are already bound to vfio-pci before running anything).
> >
> > base commit: 0ed3a30fd996cb0cac872432cf25185fda7e5316
> >
> > $ vfio_pci_driver_test -f 0000:05:00.0
> > No driver found for device 0000:05:00.0
> >
> > Same thing using the run.sh wrapper
> >
> > $ sudo ./run.sh -d 0000:05:00.0 ./vfio_pci_driver_test
> > + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
> > + echo "vfio-pci" > /sys/bus/pci/devices/0000:05:00.0/driver_override
> > + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/bind
> >
> > No driver found for device 0000:05:00.0
> > + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
> > + echo "" > /sys/bus/pci/devices/0000:05:00.0/driver_override
> > + echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/bind
> >
> > device = vfio_pci_device_init(device_bdf, default_iommu_mode);
> > if (!device->driver.ops) {
> >         fprintf(stderr, "No driver found for device %s\n", device_bdf);
> >         return KSFT_SKIP;
> > }
> >
> > Is this meant to be a placeholder for some future testing, or am I holding
> > things wrong?
> 
> What kind of device are you using?
> 
> This test uses the selftests driver framework, so it requires a driver
> in tools/testing/selftests/vfio/lib/drivers to function. The driver
> framework allows tests to trigger real DMA and MSIs from the device in
> a controlled, generic, way.

Ah, TIL about that concept. This is with one of our internal compute
accelerators, so not surprising that I'm seeing a skip then.

> We currently only have drivers for Intel DSA and Intel CBDMA
> devices.So if you're not using one of those devices,
> vfio_pci_driver_test exiting with KSFT_SKIP is entirely expected.
> 
> I would love to add support for more devices. Jason Gunthrope
> suggested supporting a driver for mlx5 class hardware, since it's
> broadly available. I've also had some discussions about adding a
> simple emulated PCIe device to QEMU for running VFIO selftests within
> VMs.

I do have access to mlx5 hardware FWIW, so that would be cool.

Thanks for the explanation!

Alex

