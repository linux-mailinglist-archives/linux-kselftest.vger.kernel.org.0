Return-Path: <linux-kselftest+bounces-46998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F01CA33A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 11:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE95F302771D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF7E2DAFBE;
	Thu,  4 Dec 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="pEWGGucE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72F2EDD6B;
	Thu,  4 Dec 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844237; cv=none; b=If0r2ujWlhan71/JW3LvTDVi2j8PalhMIRc+doTfyHrAmtXHoecVnEZsrdWDbbpDWNMSNXPSbqQbt+aavsDa2ZWdZbX0NXajfDBHtToGXTm8M5WZUycLBqNWV/D4fCkR8vmE+IkYtRXqBTpYD5nD0JWIgqs4H/yX/AwNgDV4V0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844237; c=relaxed/simple;
	bh=ysf94GMNybiLAZWcFcB1EF1Url6FvxYvZ/M/8JdfLsA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMLujLDQAYhD19wB5hDA87KAQfDomtz13XDS9OAmu9spBuv25O5wQ4nRGpmGOBncjyBbv9TzpKf1qoyEAGQAs0WvV5k6avWKuLxE4fmfW69+o+gMsNbBUXV9Xm6tdSG1rYFdUuX+DlZcZXfSxW8S2NVSHzJVaq/GYLohxW90EpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=pEWGGucE; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B40FYer3422550;
	Thu, 4 Dec 2025 02:30:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Z0FeDaJvPNNP9cJoyQRzGhFjjDU/oP6BWMa5kNfSnOU=; b=pEWGGucEUU/u
	UgEn4Iuu39OVbxPlPS81jIwk1zXu0nGmT5QW/ejw4fhVcfHZgnzz63x/o/lHsfPa
	U/DIw/EWOEfhUpwJb8jukEBX2qdDHtPYcEN0fTQYkj4vvcHf1FuJA1DLAjeVgKVL
	n+6M89pR0w9kCl4/ViGqHpZeucAGrBPfsTSLU7GKPDmt4tVQ81aCSy778tmCAgLk
	NcLrD7NtUU63+cyqeovzbvPW4gk1gtbnQHqcX5806Bd6Lgdv/Oly9PChPU+ada8N
	a3W3gPXvQfRPYhDF3SrjfJkaLjvJJ1HdpXXjtjc0BUPzpO3VxKpp7Du5fxksy2ru
	IS0/HVhWRQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4atykrtw3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 04 Dec 2025 02:30:13 -0800 (PST)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 4 Dec 2025 10:30:10 +0000
Date: Thu, 4 Dec 2025 02:30:05 -0800
From: Alex Mastro <amastro@fb.com>
To: David Matlack <dmatlack@google.com>
CC: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Alex Williamson
	<alex@shazbot.org>,
        Adithya Jayachandran <ajayachandra@nvidia.com>,
        Alistair
 Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
        David Rientjes
	<rientjes@google.com>,
        Jacob Pan <jacob.pan@linux.microsoft.com>,
        Jason
 Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Josh Hilke
	<jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
        <kvm@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mike Rapoport
	<rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
        Philipp Stanner
	<pstanner@redhat.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Saeed Mahameed
	<saeedm@nvidia.com>,
        Samiullah Khawaja <skhawaja@google.com>,
        Shuah Khan
	<shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
        Vipin Sharma
	<vipinsh@google.com>, William Tu <witu@nvidia.com>,
        Yi Liu
	<yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
        Zhu Yanjun
	<yanjun.zhu@linux.dev>
Subject: Re: [PATCH 06/21] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <aTFirYPI5vlIhvCK@devgpu015.cco6.facebook.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-7-dmatlack@google.com>
 <aTAzMUa7Gcm+7j9D@devgpu015.cco6.facebook.com>
 <CA+CK2bDbOQ=aGPZVP4L-eYobUyR0bQA0Ro6Q7pwQ_84UxVHnEw@mail.gmail.com>
 <CALzav=ciz4kV+u3B5bMzZzVY+cMs-G=q9c5O-jKPz+E4LUdx7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=ciz4kV+u3B5bMzZzVY+cMs-G=q9c5O-jKPz+E4LUdx7g@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=SNxPlevH c=1 sm=1 tr=0 ts=693162b5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7ipKWUHlAAAA:8 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8 a=ixZimci8kvJ5QYfzRTQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gpc5p9EgBqZVLdJeV_V1:22
X-Proofpoint-GUID: n8n5PTxlXRsZxiZfi3xHEEXHsmaBKvmP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDA4NSBTYWx0ZWRfX5SzhQcWn8aro
 2JPwHDOspOxJcOs9K7vSq+5jKWdbKxbqhtR3PVxczlXamIH1/EQFRaZRhc2LhtLXgtb98zMKKHV
 4+BT4+dRGSK+hpEOf5G5mQHQOIIUEZVTu4apA3OX0+zM3v5lXU14yG+EH5bt28CaOc3wu0mDqp3
 7X0UamN+ToNLaLqfBIhlCg9c7QYB9s52wJYyNhEo8+mReQLvrcdFS7LKjZ24YrosV9i6xluloiU
 EhR8GCEiFjvYHVhuYrJ/YC9xLlyO4CX78b7ELLkS4t2uPp/nmJhGx0LxIWXPHUddpx6odf7Io1a
 ktCdVZHmD7Lek0GKjNg0iiq4PA/TuMrRqIKGveVB5ByEt1ybzDvuRTXWO/atckU1W5oHkxaQQ83
 ZV4I/Go6ATIT5C+EpsxogAG5jU7q/g==
X-Proofpoint-ORIG-GUID: n8n5PTxlXRsZxiZfi3xHEEXHsmaBKvmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_02,2025-12-03_02,2025-10-01_01

On Wed, Dec 03, 2025 at 09:29:27AM -0800, David Matlack wrote:
> On Wed, Dec 3, 2025 at 7:46 AM Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > On Wed, Dec 3, 2025 at 7:55 AM Alex Mastro <amastro@fb.com> wrote:
> > >
> > > On Wed, Nov 26, 2025 at 07:35:53PM +0000, David Matlack wrote:
> > > > From: Vipin Sharma <vipinsh@google.com>
> > > >  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
> > > >  {
> > > > -     return -EOPNOTSUPP;
> > > > +     struct vfio_pci_core_device_ser *ser;
> > > > +     struct vfio_device *device;
> > > > +     struct folio *folio;
> > > > +     struct file *file;
> > > > +     int ret;
> > > > +
> > > > +     folio = kho_restore_folio(args->serialized_data);
> > > > +     if (!folio)
> > > > +             return -ENOENT;
> > >
> > > Should this be consistent with the behavior of pci_flb_retrieve() which panics
> > > on failure? The short circuit failure paths which follow leak the folio,
> 
> Thanks for catching the leaked folio. I'll fix that in the next version.
> 
> > > which seems like a hygiene issue, but the practical significance is moot if
> > > vfio_pci_liveupdate_retrieve() failure is catastrophic anyways?
> >
> > pci_flb_retrieve() is used during boot. If it fails, we risk DMA
> > corrupting any memory region, so a panic makes sense. In contrast,
> > this retrieval happens once we are already in userspace, allowing the
> > user to decide how to handle the failure to recover the preserved
> > cdev.
> 
> This is what I was thinking as well. vfio_pci_liveupdate_retrieve()
> runs in the context of the ioctl LIVEUPDATE_SESSION_RETRIEVE_FD, so we
> can just return an error up to userspace if anything goes wrong and
> let userspace initiate the reboot to recover the device if/when it's
> ready.
> 
> OTOH, pci_flb_retrieve() gets called by the kernel during early boot
> to determine what devices the previous kernel preserved. If the kernel
> can't determine which devices were preserved by the previous kernel
> and once the kernel starts preserving I/O page tables, that could lead
> to corruption, so panicking is warranted.

Make sense, thanks for elaborating David and Pasha. 

