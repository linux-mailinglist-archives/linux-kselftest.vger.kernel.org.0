Return-Path: <linux-kselftest+bounces-11256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF118FD740
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 22:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2663F283797
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AAA15E5B4;
	Wed,  5 Jun 2024 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SF/wRUlx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65715D5D8
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Jun 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618234; cv=none; b=YH717xjpQzWg1dOOwKSE1K9RwlZyFOCgRSxl56dWW29Em0m3Yq6gFEcpr1IgMw9xRRz+wBGkl7S67swzWuplAug9XxMamuKQhOj917jGbx2N84kBAFOEM043JBcb84snRBTiqJrzoFlbXfLDI65Z3Ldu5fUkCPry/WBn1mBBL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618234; c=relaxed/simple;
	bh=P/ULyAJHmdP8+weQdNuK68L1c0m3M09m6gLP50TY3jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trE0Br810JTHzztODRmTNv+QznHwNMlYTnbkVQ6bD8msegiCih6283SyuvbOXsTW/eeiLsw18metaToICOMn/K4Z7iJSBiGDqeDsidh7qpHsrEalGB60Y4NKKqvnjh8eRTezOaaYdVuAe0OUAOarZtKZ9itRhjckImUEPBHUM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SF/wRUlx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ea8fff1486so1504711fa.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jun 2024 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717618230; x=1718223030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBwUpUZb8gh3eQHfueITt2ZJwiwMmdwZoHaq8+wmWqI=;
        b=SF/wRUlxdwAsSXab2VlochVUdc4kXfmrJBgQpZK99mS3KDlbusff5hEH18qtDK2/Iz
         Tv7K/8P/MNo/V0Jtcp9k301mAvOPeEiPnVFPffgxt+4E1CtqcCPAeBfPe7lJM493ZP6q
         gonqLgti3C0m7vO0MdxSe5SaDnZGOm8ZFFsk+5hEqODsT6sRhzLgXyqioLraS1WJYW/c
         qgrF8YKjoHaEmevd7Sfux8at6kNEzF8bPkOUG3ErSPlCO4vAdyAnK100knLvcC6RW0NY
         Q6eW9Td74LwvdHISX3ZDSU4hMNOEqtzjHrUH3O3pAS0ozBfthZOSzXi9es0l2YQK5fXF
         iBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717618230; x=1718223030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBwUpUZb8gh3eQHfueITt2ZJwiwMmdwZoHaq8+wmWqI=;
        b=PqhaIL0q5gunahtZfBSdnsEVuo9mG64VQB/GbVotgyEknX1DPadiBODK0e2pFsR2iO
         Prn6blSn+KJENMOrt/5LRhEcnkU3dYu2Zku5vpO37Y0e+sJuAT2iZO7s6hXCHtaovQRb
         g5XYd9iXRskfmNxgEQ2G7PgPgknDoCUN8Xmdy/jbDtkBDTFvNEeWv1B+UAoLlWTqkSuw
         x2uhNKMrttYurRZdNhHm5/0LYugxBOBPBNnGpcGMx3mfGR0mFgRUkCUutZKrr7OlDsmp
         a0N8NJzjs7+208z/ULUv8okkKUv6nsXD8fPTn4c4x9rnp1A6tP8tXIwCju1PgbGRf1q1
         HHjg==
X-Forwarded-Encrypted: i=1; AJvYcCUqkJDPXfPDFNt48S28Pp3waetEOeT1ghmczvCF/M7n03+TPaxfU5Untg0PH9EgaMZXPuqZuNf2408udEl2Jp2HywvJXBJH9Nq40VIf6yG+
X-Gm-Message-State: AOJu0Yy7IJVZWd3KoQrkhhwgKQV9vP46AgotryFt3h4Eolvx/45msrXx
	66k3FvtJTq7Vc3OTms41wgEjDiC2pPQZiQeC+U0/p/HpyqvPpkUHRQ8ViFVXLPf+cMdCPZSNoY4
	W15Gk+X4uuD9d+P6AtnLNfJwDvjyj2qhIT7PD
X-Google-Smtp-Source: AGHT+IGksIwyimMNtUjcaJJe0ywzHDsW40IeRamyOlbcwZdT+OnlzNT/xV8FemA/U28w4/kuuedLzSZsJnzH6N1zXBo=
X-Received: by 2002:a2e:908e:0:b0:2e2:59c7:a922 with SMTP id
 38308e7fff4ca-2ead00b9e81mr1751531fa.15.1717618230256; Wed, 05 Jun 2024
 13:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
In-Reply-To: <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 5 Jun 2024 15:10:18 -0500
Message-ID: <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc: "ackerleytng@google.com" <ackerleytng@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"Afranji, Ryan" <afranji@google.com>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"jmattson@google.com" <jmattson@google.com>, "pgonda@google.com" <pgonda@google.com>, 
	"seanjc@google.com" <seanjc@google.com>, "runanwang@google.com" <runanwang@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Annapurve, Vishal" <vannapurve@google.com>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vipinsh@google.com" <vipinsh@google.com>, "Xu, Haibo1" <haibo1.xu@intel.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmatlack@google.com" <dmatlack@google.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:38=E2=80=AFPM Verma, Vishal L <vishal.l.verma@inte=
l.com> wrote:
>
> On Tue, 2023-12-12 at 12:46 -0800, Sagi Shahar wrote:
> > Hello,
> >
> > This is v4 of the patch series for TDX selftests.
> >
> > It has been updated for Intel=E2=80=99s v17 of the TDX host patches whi=
ch was
> > proposed here:
> > https://lore.kernel.org/all/cover.1699368322.git.isaku.yamahata@intel.c=
om/
> >
> > The tree can be found at:
> > https://github.com/googleprodkernel/linux-cc/tree/tdx-selftests-rfc-v5
>
> Hello,
>
> I wanted to check if there were any plans from Google to refresh this
> series for the current TDX patches and the kvm-coco-queue baseline?
>
I'm going to work on it soon and was planning on using Isaku's V19 of
the TDX host patches

> I'm setting up a CI system that the team is using to test updates to
> the different TDX patch series, and it currently runs the KVM Unit
> tests, and kvm selftests, and we'd like to be able to add these three
> new TDX tests to that as well.
>
> I tried to take a quick shot at rebasing it, but ran into several
> conflicts since kvm-coco-queue has in the meantime made changes e.g. in
> tools/testing/selftests/kvm/lib/x86_64/processor.c vcpu_setup().
>
> If you can help rebase this, Rick's MMU prep series might be a good
> baseline to use:
> https://lore.kernel.org/all/20240530210714.364118-1-rick.p.edgecombe@inte=
l.com/

This patch series only includes the basic TDX MMU changes and is
missing a lot of the TDX support. Not sure how this can be used as a
baseline without the rest of the TDX patches. Are there other patch
series that were posted based on this series which provides the rest
of the TDX support?
>
> This is also available in a tree at:
> https://github.com/intel/tdx/tree/tdx_kvm_dev-2024-05-30
>
> Thank you,
> Vishal
>
> >
> > Changes from RFC v4:
> >
> > Added patch to propagate KVM_EXIT_MEMORY_FAULT to userspace.
> >
> > Minor tweaks to align the tests to the new TDX 1.5 spec such as changes
> > in the expected values in TDG.VP.INFO.
> >
> > In RFCv5, TDX selftest code is organized into:
> >
> > + headers in tools/testing/selftests/kvm/include/x86_64/tdx/
> > + common code in tools/testing/selftests/kvm/lib/x86_64/tdx/
> > + selftests in tools/testing/selftests/kvm/x86_64/tdx_*
> >
> > Dependencies
> >
> > + Peter=E2=80=99s patches, which provide functions for the host to allo=
cate
> >   and track protected memory in the guest.
> >   https://lore.kernel.org/all/20230110175057.715453-1-pgonda@google.com=
/
> >
> > Further work for this patch series/TODOs
> >
> > + Sean=E2=80=99s comments for the non-confidential UPM selftests patch =
series
> >   at https://lore.kernel.org/lkml/Y8dC8WDwEmYixJqt@google.com/T/#u appl=
y
> >   here as well
> > + Add ucall support for TDX selftests
> >
> > I would also like to acknowledge the following people, who helped
> > review or test patches in previous versions:
> >
> > + Sean Christopherson <seanjc@google.com>
> > + Zhenzhong Duan <zhenzhong.duan@intel.com>
> > + Peter Gonda <pgonda@google.com>
> > + Andrew Jones <drjones@redhat.com>
> > + Maxim Levitsky <mlevitsk@redhat.com>
> > + Xiaoyao Li <xiaoyao.li@intel.com>
> > + David Matlack <dmatlack@google.com>
> > + Marc Orr <marcorr@google.com>
> > + Isaku Yamahata <isaku.yamahata@gmail.com>
> > + Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> >
> > Links to earlier patch series
> >
> > + RFC v1: https://lore.kernel.org/lkml/20210726183816.1343022-1-erdemak=
tas@google.com/T/#u
> > + RFC v2: https://lore.kernel.org/lkml/20220830222000.709028-1-sagis@go=
ogle.com/T/#u
> > + RFC v3: https://lore.kernel.org/lkml/20230121001542.2472357-1-ackerle=
ytng@google.com/T/#u
> > + RFC v4: https://lore.kernel.org/lkml/20230725220132.2310657-1-afranji=
@google.com/
> >
> > *** BLURB HERE ***
> >
> > Ackerley Tng (12):
> >   KVM: selftests: Add function to allow one-to-one GVA to GPA mappings
> >   KVM: selftests: Expose function that sets up sregs based on VM's mode
> >   KVM: selftests: Store initial stack address in struct kvm_vcpu
> >   KVM: selftests: Refactor steps in vCPU descriptor table initializatio=
n
> >   KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to validate TDs'
> >     attribute configuration
> >   KVM: selftests: TDX: Update load_td_memory_region for VM memory backe=
d
> >     by guest memfd
> >   KVM: selftests: Add functions to allow mapping as shared
> >   KVM: selftests: Expose _vm_vaddr_alloc
> >   KVM: selftests: TDX: Add support for TDG.MEM.PAGE.ACCEPT
> >   KVM: selftests: TDX: Add support for TDG.VP.VEINFO.GET
> >   KVM: selftests: TDX: Add TDX UPM selftest
> >   KVM: selftests: TDX: Add TDX UPM selftests for implicit conversion
> >
> > Erdem Aktas (3):
> >   KVM: selftests: Add helper functions to create TDX VMs
> >   KVM: selftests: TDX: Add TDX lifecycle test
> >   KVM: selftests: TDX: Adding test case for TDX port IO
> >
> > Roger Wang (1):
> >   KVM: selftests: TDX: Add TDG.VP.INFO test
> >
> > Ryan Afranji (2):
> >   KVM: selftests: TDX: Verify the behavior when host consumes a TD
> >     private memory
> >   KVM: selftests: TDX: Add shared memory test
> >
> > Sagi Shahar (11):
> >   KVM: selftests: TDX: Add report_fatal_error test
> >   KVM: selftests: TDX: Add basic TDX CPUID test
> >   KVM: selftests: TDX: Add basic get_td_vmcall_info test
> >   KVM: selftests: TDX: Add TDX IO writes test
> >   KVM: selftests: TDX: Add TDX IO reads test
> >   KVM: selftests: TDX: Add TDX MSR read/write tests
> >   KVM: selftests: TDX: Add TDX HLT exit test
> >   KVM: selftests: TDX: Add TDX MMIO reads test
> >   KVM: selftests: TDX: Add TDX MMIO writes test
> >   KVM: selftests: TDX: Add TDX CPUID TDVMCALL test
> >   KVM: selftests: Propagate KVM_EXIT_MEMORY_FAULT to userspace
> >
> >  tools/testing/selftests/kvm/Makefile          |    8 +
> >  .../selftests/kvm/include/kvm_util_base.h     |   30 +
> >  .../selftests/kvm/include/x86_64/processor.h  |    4 +
> >  .../kvm/include/x86_64/tdx/td_boot.h          |   82 +
> >  .../kvm/include/x86_64/tdx/td_boot_asm.h      |   16 +
> >  .../selftests/kvm/include/x86_64/tdx/tdcall.h |   59 +
> >  .../selftests/kvm/include/x86_64/tdx/tdx.h    |   65 +
> >  .../kvm/include/x86_64/tdx/tdx_util.h         |   19 +
> >  .../kvm/include/x86_64/tdx/test_util.h        |  164 ++
> >  tools/testing/selftests/kvm/lib/kvm_util.c    |  101 +-
> >  .../selftests/kvm/lib/x86_64/processor.c      |   77 +-
> >  .../selftests/kvm/lib/x86_64/tdx/td_boot.S    |  101 ++
> >  .../selftests/kvm/lib/x86_64/tdx/tdcall.S     |  158 ++
> >  .../selftests/kvm/lib/x86_64/tdx/tdx.c        |  262 ++++
> >  .../selftests/kvm/lib/x86_64/tdx/tdx_util.c   |  558 +++++++
> >  .../selftests/kvm/lib/x86_64/tdx/test_util.c  |  101 ++
> >  .../kvm/x86_64/tdx_shared_mem_test.c          |  135 ++
> >  .../selftests/kvm/x86_64/tdx_upm_test.c       |  469 ++++++
> >  .../selftests/kvm/x86_64/tdx_vm_tests.c       | 1319 +++++++++++++++++
> >  19 files changed, 3693 insertions(+), 35 deletions(-)
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_b=
oot.h
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/td_b=
oot_asm.h
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdca=
ll.h
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx.=
h
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/tdx_=
util.h
> >  create mode 100644 tools/testing/selftests/kvm/include/x86_64/tdx/test=
_util.h
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/td_boot.=
S
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdcall.S
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/tdx_util=
.c
> >  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/tdx/test_uti=
l.c
> >  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_shared_mem_t=
est.c
> >  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_upm_test.c
> >  create mode 100644 tools/testing/selftests/kvm/x86_64/tdx_vm_tests.c
> >
>

