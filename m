Return-Path: <linux-kselftest+bounces-39050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D705FB27855
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 07:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB897BFF54
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390822144D2;
	Fri, 15 Aug 2025 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+nKScj5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F98232785
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235253; cv=none; b=U+K8cK5zytVHffv1Xj7VaNgLl4ukrvUC7HZYDghll1dkTsRbKOBEt5m45eBftbdpXPtPoQtPHw1U2SjbtMsvu0q+1BzfCooOKG+Vo3s2wIbmX+j9dCqfTGPrd6KWpDQ3a581bbIIzYRwEgMa8heSLiZ0kRPsc3LpuJkHrYIDk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235253; c=relaxed/simple;
	bh=503SEWrEiwk4AHvc6H88byJ1joeM0iL9UAQxQ+98CZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jum6w6OEkJ4fX8c5sQHrPG4GlabxEPUtqorUS/PZSoYoadx4e736CLqA1OPIfffvVqfABV5OXTT1CcG7dwzgT3uk7z6ntXAz/0ur9f6YkRjU6naF5RlozgsZ3e+l6u8t5AfkK+3K/AkbupKPMvF6NN+m+QlRjo/cdpWrpbCayrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+nKScj5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0bf04716aso131381cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755235250; x=1755840050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nN6cY1WnXIWqH8qfrJcmPCahJeWVJ2HfC4QiO+3/8v4=;
        b=s+nKScj5LJZNrEVsvXbbuHos36kQy2ps7WusTDOaXxn92quN7YN6BxcS2nh0Y9Xqiw
         OH8tWGVIDomjG/N+3a3fQPLqYVsY8QRxhtm7sGU2kCa5yus0Fq/v3O4+T9ooCjnlGoTu
         /xivnXirwdsrh86wweNJld2EkkPQ8eYTKg3xtXxz5aJgpewD1fL3JJIJ9seXGEQy6BD4
         M70ndyzTvL35FfDo5BuQaQhO66orfqi3hjSwHbzkHBFRNthxSGOC0KHKRrI2PepT0N6s
         Xj8VSjEe5HUA+CK360xBhE6lZbl2mAABDBqqYrOacFs1121bFiRUq7yqD1b7TbnGVt+1
         s9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235250; x=1755840050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN6cY1WnXIWqH8qfrJcmPCahJeWVJ2HfC4QiO+3/8v4=;
        b=jt5I4lCMDPhygiLu2L641x93n9DnuBQ33D4SJN0AQPpIHPrykC5jRubP1CCI6vHpVU
         RBmpPgeQrBGTjQA3mp2eJ32shTMrBdIDM2wyIEBho1vJb5UQpYj2Gc+CEZQSW3dIW1Vt
         mHCrcImd39dwYw8iBrSRPs43JMuVui8L/L+6YCuq80rcUvw5u0Pt62/IjqOK1uzSlrRX
         +b+4L4q4D8rYUzOLb4EA+afmlLS96Hx/7vB0drgYcErM16PkVo4lNzjnAE8kwOw/CxDr
         jo3zG5uQ13XmqgGSOydfedsdzZ7ph9Cmp/Une+Lb6+E9CQey23aKcOwOWxlWoOZhd+LX
         UeJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbpElN+eCuG29QIZVJzyXVGx0JiuVW4/4fOJwVmi1BkGmx65rG9NRCyPnDbTqsedEt9yfsNk0r4eP7vDkWrx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq8hw0j6WIXba0ehYAVg/8xmAgQ7oaVS1nHCjRvWndvabJhanH
	KHYSHaCYpXPM2l8DlLF3F85hicfMJGbcqATQgRuSits3MluSVt4DQDDZ6UBwXRuSHn4Uzfmh8Tg
	fKCfuCkdCyXDwu51l8AQB5s3N/jSJw7tfJd7X9s21
X-Gm-Gg: ASbGnct3qT12ePlEadzqtou+GUrpxXAKPjq2ZLObbZAk4jLjNro8PRzu+q1RHrYzgP0
	D4sYE5aBx3rodxBLbNujDpYxl58Tr49voskj4oALVyFeq/FD0ryPAO6duD6z4A5DivZuL9VtcEX
	N8KStU7l4dP1O5o2aK8irp40alLGKMLLvzlOJ0xxRY1CEcbPvbt+9pRkklhL5YQlQd0xqyoA80O
	NUBUSCzzYGiLONE7aN9iCul84HQTVy259p0s2wgpa+fVokKx2vZozZm
X-Google-Smtp-Source: AGHT+IE69f8D6srRBPVl9pKN5vZpO5F0/UnsSKswJGEAghVTRDosELHxgLTcfYcE/QjWOYfDfEWsjCzTxskkAyr2rBo=
X-Received: by 2002:a05:622a:353:b0:4af:103d:f71 with SMTP id
 d75a77b69052e-4b119db955bmr3455771cf.2.1755235250003; Thu, 14 Aug 2025
 22:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-7-sagis@google.com>
 <aJpO_zN3buvaQoAW@google.com> <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
In-Reply-To: <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 15 Aug 2025 00:20:39 -0500
X-Gm-Features: Ac12FXzFZpZpXFtVKoFfvJsHTFWvzrLQdnlQzpXmS7z6xkcHqsTDLUOB3CL7Lc8
Message-ID: <CAAhR5DG+EMVbrdGaPoUiX3MtnVktFtdiY+dDjRhA9tugAoRTJQ@mail.gmail.com>
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:22=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.c=
om> wrote:
>
>
>
> On 8/12/2025 4:13 AM, Sean Christopherson wrote:
> > On Thu, Aug 07, 2025, Sagi Shahar wrote:
> [...]
> >> +
> >> +/*
> >> + * Boot parameters for the TD.
> >> + *
> >> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, et=
c
> >> + * before boot, so to run selftests, these registers' values have to =
be
> >> + * initialized by the TD.
> >> + *
> >> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_G=
PA.
> >> + *
> >> + * The TD boot code will read off parameters from this struct and set=
 up the
> >> + * vCPU for executing selftests.
> >> + */
> >> +struct __packed td_boot_parameters {
> > None of these comments explain why these structures are __packed, and I=
 suspect
> > _that_ is the most interesting/relevant information for unfamiliar read=
ers.
> I guess because the fields defined in this structure are accessed by hard=
-coded
> offsets in boot code.
> But as you suggested below, replicating the functionality of the kernel's
> OFFSET() could get rid of "__packed".
>

I agree, I think the reason for using __packed is because of the hard
coded offsets. I tried using OFFSET() as Sean suggested but couldn't
make it work.

I can't get the Kbuild scripts to work inside the kvm selftests
Makefile. I tried adding the following rules based on a reference I
found:

+include/x86/tdx/td_boot_offsets.h: lib/x86/tdx/td_boot_offsets.s
+       $(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
+
+lib/x86/tdx/td_boot_offsets.s: lib/x86/tdx/td_boot_offsets.c
+       $(call if_changed_dep,cc_s_c)

But I'm getting the following error when trying to generate the header:

/bin/sh: -c: line 1: syntax error near unexpected token `;'
/bin/sh: -c: line 1: `set -e;  ;  printf '# cannot find fixdep (%s)\n'
 > lib/x86/tdx/.td_boot_offsets.s.cmd; printf '# using basic dep
data\n\n' >> lib/x86/tdx/.td_boot_offsets.s.cmd; cat
lib/x86/tdx/.td_boot_offsets.s.d >>
lib/x86/tdx/.td_boot_offsets.s.cmd; printf '\n%s\n'
'cmd_lib/x86/tdx/td_boot_offsets.s :=3D ' >>
lib/x86/tdx/.td_boot_offsets.s.cmd'
make: *** [Makefile.kvm:44: lib/x86/tdx/td_boot_offsets.s] Error 2

For now I can add a comment on the __packed and add a TODO to replace
it with OFFSET. I think that making OFFSET work inside the kvm
selftests will require more expertise in the Kbuild system which I
don't have.

> A side topic is when developers should provide comments for the uses of
> "__packed". Is it always preferred a comment for it or a developer can sa=
ve
> the comment for obvious cases, e.g, the structure is defined according to
> some hardware layout?
>
> >
> >> +    uint32_t cr0;
> >> +    uint32_t cr3;
> >> +    uint32_t cr4;
> >> +    struct td_boot_parameters_dtr gdtr;
> >> +    struct td_boot_parameters_dtr idtr;
> >> +    struct td_per_vcpu_parameters per_vcpu[];
> >> +};
> >> +
> ...
>
> >> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools=
/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> >> new file mode 100644
> >> index 000000000000..c8cbe214bba9
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> >> @@ -0,0 +1,100 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +
> >> +#include "tdx/td_boot_asm.h"
> >> +
> >> +/* Offsets for reading struct td_boot_parameters. */
> >> +#define TD_BOOT_PARAMETERS_CR0         0
> >> +#define TD_BOOT_PARAMETERS_CR3         4
> >> +#define TD_BOOT_PARAMETERS_CR4         8
> >> +#define TD_BOOT_PARAMETERS_GDT         12
> >> +#define TD_BOOT_PARAMETERS_IDT         18
> >> +#define TD_BOOT_PARAMETERS_PER_VCPU    24
> >> +
> >> +/* Offsets for reading struct td_per_vcpu_parameters. */
> >> +#define TD_PER_VCPU_PARAMETERS_ESP_GVA     0
> >> +#define TD_PER_VCPU_PARAMETERS_LJMP_TARGET 4
> >> +
> >> +#define SIZEOF_TD_PER_VCPU_PARAMETERS      10
> > Please figure out how to replicate the functionality of the kernel's OF=
FSET()
> > macro from  include/linux/kbuild.h, I have zero desire to maintain open=
 coded
> > offset values.
> >

