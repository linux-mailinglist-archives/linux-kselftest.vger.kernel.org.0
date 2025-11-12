Return-Path: <linux-kselftest+bounces-45434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B7C53C3D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 18:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 081CC346633
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A4C34888D;
	Wed, 12 Nov 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="D2uVw/Ei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56534888C;
	Wed, 12 Nov 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969220; cv=none; b=MQpiLT59F+P5h2MDCJi/4FaL+WjPW/2GSAi78cICr5E9Glnf18kwXpfJQB4aZi4U4Xbh4xfb1janmGvKVJvv1b6JQQ/7ODDmDZqo5qegxsmm77LRJcNM40Ah04WFiYkspCWmsdyMfMc/HpbJoZszta0MWr3MfZGX6ibPHd3eoAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969220; c=relaxed/simple;
	bh=S+7kJwuBOZQuTwc7QjfzS7ddhaiF9jd6M89dnbZDg9I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGezZhl7MghQf8JhY80YBtKxZ3Oc+Uvi0Ldj2uz9MhUn6QPN19WnlGixnBU4KRiCdK2cCq1JTRKn/NaCbT7sSVVLZEE21fNXFI51qw/fubJYfe0WlXvvPTHZYlVHG+naa0qIV65b9mKJ0D3myNx219ZIYsbiut7ZUyz50Y60JKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=D2uVw/Ei; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5ACGPrdU1073060;
	Wed, 12 Nov 2025 09:40:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MKuiyQ+QMoTCFNXm4BR16/Id9xwJPZ2yzJmBuItdgUw=; b=D2uVw/Eicyxt
	33P6xD1DJbJSi4kT9UJAs6kw7ArC0d0q4K2nU4tHAcaSPrmZ6sMsm+f0lhn2Tvxn
	KpGQsjRVonkhHnMmd70TBj+JRh5M59ypyzfFTt07OKPMW47d7BoqCxUVusR61mPl
	3xn1hd/frlTYgFGF6O24AV10bMB0MHj4S+mbwTryfJU+gYZEt6nvSH0CpEi1FKod
	Eif7Pfs5RbnCIgeRqbeqMOKedmHhGtx5bqReb/kXKFi5+DL4Yq2YCaPDzgYRvvlq
	oM1tE+CzS1ejqIau7/dwOkcDvzaayTUA0hlDz+mQCljiii93gHbRaedMX6LV/KRu
	Tsm6fWHbvA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4acwrkrpbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Nov 2025 09:40:03 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 12 Nov 2025 17:40:02 +0000
Date: Wed, 12 Nov 2025 09:39:57 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
        Jason
 Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Message-ID: <aRTGbXB6gtkKVnLo@devgpu015.cco6.facebook.com>
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
 <CALzav=cmkiFUjENpYk3TT7czAeoh8jzp4WX_+diERu7JhyGCpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=cmkiFUjENpYk3TT7czAeoh8jzp4WX_+diERu7JhyGCpA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: UANdwL5ZBTr6y-FzZu2uDSyUqQHF8P7Z
X-Authority-Analysis: v=2.4 cv=bv9BxUai c=1 sm=1 tr=0 ts=6914c673 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=p3pSxSEZkdnILfP6oFgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: UANdwL5ZBTr6y-FzZu2uDSyUqQHF8P7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0MiBTYWx0ZWRfXwOMIyqtrmu4p
 1ER2s0vguchtwjvi0hbvldWvPvWFIRNMChG7aIvOCQGmzRQX1GV7tcdQ6qY+9b+9Qpu/dtNUO9r
 YuOAMnAH3u1JMRuQBivRpw9JwWiD86oSLpdxQoN9verze02ERgR7YQktUP/fO4a6JbtxDJ02UYR
 Fjb1JO4BCE/kWXH3ibYrVy7y4236ta8gfAqhYTA8lYJX7CnzO3lO+0YHzWIfqBhZEp7/tVOX5Jq
 VD8+z4BCpXFZuF3vbE60hCIuQPHo4GGGpFuC91qrAnKreZ2NSWL0PSLcLbe5xzEigcWcDVpiAKX
 bwW1+L282rlGnhgmycji9M/1kMEOszMzEiPf3EHDJ7c/JzT8P0Y98bCquuj+4m/wSWoTZ4ABUxv
 Xadi3nu1dSmd2ir0CVnmsQKOV8AtLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-11_03,2025-10-01_01

On Tue, Nov 11, 2025 at 11:26:43AM -0800, David Matlack wrote:
> On Tue, Nov 11, 2025 at 10:48 AM Alex Mastro <amastro@fb.com> wrote:
> >
> > Changes in v3:
> > - Update capability chain cycle detection
> > - Clarify the iova=vaddr commit message
> > - Link to v2: https://lore.kernel.org/r/20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com
> 
> All tests are still passing on v3 for me.

Hey David, is vfio_pci_driver_test known to be in good shape? Both on the base
commit and after my series, I am seeing below, which results in a KSFT_SKIP.
Invoking other tests in a similar way actually runs things with expected
results (my devices are already bound to vfio-pci before running anything).

base commit: 0ed3a30fd996cb0cac872432cf25185fda7e5316

$ vfio_pci_driver_test -f 0000:05:00.0
No driver found for device 0000:05:00.0

Same thing using the run.sh wrapper

$ sudo ./run.sh -d 0000:05:00.0 ./vfio_pci_driver_test
+ echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
+ echo "vfio-pci" > /sys/bus/pci/devices/0000:05:00.0/driver_override
+ echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/bind

No driver found for device 0000:05:00.0
+ echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
+ echo "" > /sys/bus/pci/devices/0000:05:00.0/driver_override
+ echo "0000:05:00.0" > /sys/bus/pci/drivers/vfio-pci/bind

device = vfio_pci_device_init(device_bdf, default_iommu_mode);
if (!device->driver.ops) {
        fprintf(stderr, "No driver found for device %s\n", device_bdf);
        return KSFT_SKIP;
}

Is this meant to be a placeholder for some future testing, or am I holding
things wrong?

