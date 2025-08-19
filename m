Return-Path: <linux-kselftest+bounces-39330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A7DB2CC7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 20:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951085C0A33
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2110F32A3D6;
	Tue, 19 Aug 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRhAKDe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14B30C345;
	Tue, 19 Aug 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629554; cv=none; b=RRHXd9RwBe0PDizNeeZ4VDMqgfb2DDkGKFuP3nLidN3gfWoTPOaBGtQpASLkHbMl+i0xUEcZzXlJXf0HClpBZThgGGdjUdAj/ysEGCP8SbyOSMsdtpvb/Ee9X6ThzAyno1xaJoJKDr4nEpJb0I+WWbeTeuU4AJD9atb1XOThOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629554; c=relaxed/simple;
	bh=Rc4iMvJDf73+qtSHlzp1IZqc6F/OIdBDvKE5ldovWvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uK3IrjxhMGEU7iKfI5Z1FHx9cGjqYmEo81keSD0SrKE8zytu1IYuRGLnGu63ZSbLMuWpDLNTubqecSKoU3hXZh8vg1wk61WgO6ObwS23Zzvsm+qEoGOB5dQs2LpkZyJeRIRg3Ov9QE05AW0tKUE/fOD7V4AJhXLSJrChNyJnWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRhAKDe6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755629553; x=1787165553;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Rc4iMvJDf73+qtSHlzp1IZqc6F/OIdBDvKE5ldovWvk=;
  b=ZRhAKDe6euuQaipuF1MDVqr3nQxrpTEUXNdYkPnKYvhaXHiNPoL4Jccj
   Jv0XRGrVTEehZZn8oM5ZdgTVaHJydUkpoa9m5UsSgoHUKgxuRjWiYxrt7
   p0pg8jtBaibjpaX32POzUwqhHv+uIrlY89lJDe2dlvmqe6Rh8gEjOmDPR
   Vfv6s9Iyroo4leiB4SIWtjGXDpafLLlCGzy7RzSi7jAVqjydVhTR64oz8
   UDXp510nKW3PKQcLfhAni+UOij0ySBIWfXbvJTthjwBwnbdCypUxkM73L
   J10/ZKMEumodS4/W+IAgilDf7WPU0zzzkzZ3gDHHI3S3BA9xkJ2bst5PK
   g==;
X-CSE-ConnectionGUID: UyAo12npTDeXbciPiRlYNw==
X-CSE-MsgGUID: DjTcespIQEGrU5N/53y3Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57747177"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57747177"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:52:32 -0700
X-CSE-ConnectionGUID: NxmXx4u3THynXbPaF2BGrA==
X-CSE-MsgGUID: A4mYhuW4SZem3KS6hFBqtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172168891"
Received: from unknown (HELO vcostago-mobl3) ([10.98.24.145])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 11:52:30 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis
 <aaronlewis@google.com>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Adithya Jayachandran
 <ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, Ard
 Biesheuvel <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, dmaengine@vger.kernel.org, Huacai Chen
 <chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, Josh
 Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, "Pratik R. Sampat"
 <prsampat@amd.com>, Saeed Mahameed <saeedm@nvidia.com>, Sean
 Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Vipin
 Sharma <vipinsh@google.com>, Wei Yang <richard.weiyang@gmail.com>, "Yury
 Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: Re: [PATCH 22/33] vfio: selftests: Add driver for Intel DSA
In-Reply-To: <CALzav=dPRfPxNAaVvbxSNz=Ss0DAGjxJQO2JnXLbZgwZmO0NBQ@mail.gmail.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <20250620232031.2705638-23-dmatlack@google.com> <87a53w2o65.fsf@intel.com>
 <CALzav=dPRfPxNAaVvbxSNz=Ss0DAGjxJQO2JnXLbZgwZmO0NBQ@mail.gmail.com>
Date: Tue, 19 Aug 2025 11:52:30 -0700
Message-ID: <87v7mj16vl.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

David Matlack <dmatlack@google.com> writes:

> On Mon, Aug 18, 2025 at 4:41=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>> David Matlack <dmatlack@google.com> writes:
>> > +
>> > +static int dsa_probe(struct vfio_pci_device *device)
>> > +{
>> > +     if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL,
>> > +                                PCI_DEVICE_ID_INTEL_DSA_SPR0))
>>
>> What are you thinking about adding support for multiple device ids?
>
> I haven't given it much thought yet. But we could definitely support
> fancier device matching (e.g. multiple acceptable device ids) if/when
> a use-case for that arises.
>

Fair enough. I just wanted to bring this up (hoping that's more a matter
of "when" than "if" :-))

>> > +static int dsa_completion_wait(struct vfio_pci_device *device,
>> > +                            struct dsa_completion_record *completion)
>> > +{
>> > +     u8 status;
>> > +
>> > +     for (;;) {
>> > +             dsa_check_sw_err(device);
>> > +
>> > +             status =3D READ_ONCE(completion->status);
>> > +             if (status)
>> > +                     break;
>> > +
>> > +             usleep(1000);
>>
>> Another minor/thing to think about: using umonitor/umwait.
>
> Thanks for the tip, I hadn't considered that. But I think for this
> driver, keeping things as simple as possible is best. This code is
> only used for testing so I don't think we care enough about efficiency
> to justify using unmonitor/umwait here.

Yeah, agreed.


Cheers,
--=20
Vinicius

