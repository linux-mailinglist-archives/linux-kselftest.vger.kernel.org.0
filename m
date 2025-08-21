Return-Path: <linux-kselftest+bounces-39612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA4B30935
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 00:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957376001BA
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187AB2E0410;
	Thu, 21 Aug 2025 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w9Yx9iYq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF0283C9E
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 22:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815456; cv=none; b=JWxyiP+JE9yuBKUlsuKWwz5R//pXnoDCrqfvAuOG3TVpY7W4pEdOSdknMsaK7+ybQqDvt3DLmdy9XFkPsN3taJs0+P1tplC7NE2vcdCG70JBzioYF8bCDyklcGz83Mgb2XHmnPDTYFe9P6OdHEkvK5/O+V2NnWnuPNz7SgTTxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815456; c=relaxed/simple;
	bh=qrwTnPicyp9tNZ7V+qU5Qj6zOAnVLlyHrsqGuz2C1tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irOKwkJjshwZU/vIfcRPDax8hJ72+bnMas7zY4mVWWJ/Y9BrKTQjcoLq1+hv9Gy3RS8r3dKAGDMGun6DwFgeN8dR/qg8UCU5rb5XsZKdOvHtrIw0kRWg8MuR5S/eCkWjKOgUrrRZX0NsdLOikedwMqU/vypCQoicroESQcOc06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w9Yx9iYq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b12b123e48so115741cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755815453; x=1756420253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8MDguIpfB1tiwDQTj5aE/No4Z7doxG64RXtusp1FLM=;
        b=w9Yx9iYqWBuSxOxsfFF8k8P/YvFLmMjH9VYE1To1EKuzjCehrtfnhYR4pH/ZTQU+8i
         aS6Leayi2A8rqF2PKKNC16tQDJQWekVg0WT3myNJ44D5xb6WltMUJGK/UVlm+46sagQS
         HskVeDEvN2LcgZzg7XDJ2vv/DrdKAIvh1ZvZVf/W14lu+49O7IIE1sN0WouAJeuT1fKm
         VkrANHHl8rB9PosTYXqvfUJvQ+PtKndvcLpiHh9uxYZpSVVdv8tZQbAMQhKuxefXT3CR
         rReJInk76peqEellH39kHWgias42ULdQKpZBPU/75sjH5aADVUYoP41S2JT1nF4JljVX
         xgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755815453; x=1756420253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8MDguIpfB1tiwDQTj5aE/No4Z7doxG64RXtusp1FLM=;
        b=IiVUt7p2PoEyiwrxW/jHXIf7lDHpEFhhznrKalMYuMYxZjY/sD4ghAjJUWiU5eVlNh
         OIn0lXVbXx0DPwdPFg9cL6veHUAFAby4c4TBxMJyfFiJCnJikHvGeJ3SJDh0iGUFQTon
         GyeftLGalvr5+yhzYuRg5fCN35NC5+tabCfVPmJagZWzfUNz5fnWf4smnMQ7qdZGQjyC
         oMOgNYKQEazLhUfSkwcL2N4e/fd8N1XwLnVaCmh5mPXfq5sNASHKmb6NrYBNCZatl7r+
         HrjNWxL95kDL1i8Av30H3PujMJxWO7cTOdtmmSUcS5os06GJtnVy0aV2n6EEh+vDy14W
         kh7A==
X-Gm-Message-State: AOJu0Yw66cn68Izg73+CL7hCpTNna4Ol7O7T5xsp4Qvnrz/Tu60tUdIF
	jyhR8zdRTdAeRolcNNX4My+h25zGClL4BIQeGzax4Y1NGga/26WmBRIh8JmQPv3X3Yci2gEijsx
	kCDDV/sUHGz3q3CHrd35IqF8gu2H76G+ye9sv9+Aa
X-Gm-Gg: ASbGnctlSc49lLP3VD3gWjqU+iJsg+Z9a5E62NxxICm9ZXYF9bk81bnblZMbXME+my7
	yq+yu605t8yiesD4cbXVxf7o6jsY95FlBH42Wd50/SSVATPCqZ2f64z4/+KnMDp5XQTgXvMNmMM
	HRuBKa9jc+jwDg/zteWClqzhKW6dHfMRULrTwXjcsUy+obAuClk5UhxV236KtfXENFeg7Oj5Ky5
	x23RFVKwPUKhjy5GlMqGgNfVfjXfVYXRMJrHlO541f5OdrANvZaC7RJXw==
X-Google-Smtp-Source: AGHT+IH2EHxRIc2XvOSnuoiOX6o9qCXNTtLKbVBQdBlpUCSlcPy+O7Gq5C+KP9ymQxWBlUK9RRR1skGgBYxWmAR+Khc=
X-Received: by 2002:a05:622a:118c:b0:4b0:82e5:946b with SMTP id
 d75a77b69052e-4b2aacd5a4emr2026071cf.4.1755815452896; Thu, 21 Aug 2025
 15:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-6-sagis@google.com>
 <68a7981019500_2be23a294ba@iweiny-mobl.notmuch>
In-Reply-To: <68a7981019500_2be23a294ba@iweiny-mobl.notmuch>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 21 Aug 2025 17:30:42 -0500
X-Gm-Features: Ac12FXz2B1VmOXVRyb0Ok0u4rwStMH2RK2jNtJZ5p7yUkaK07yoWYHQtSWixBO4
Message-ID: <CAAhR5DGEUqHGvYztLZJKfY+Re-aq5ACC4++m_7+yeMsL+1E11g@mail.gmail.com>
Subject: Re: [PATCH v9 05/19] KVM: selftests: Update kvm_init_vm_address_properties()
 for TDX
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 5:03=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Sagi Shahar wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_ma=
sk}
> > similar to SEV.
> >
> > TDX sets the shared bit based on the guest physical address width and
> > currently supports 48 and 52 widths.
> >
> > Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Co-developed-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  .../selftests/kvm/include/x86/tdx/tdx_util.h       | 14 ++++++++++++++
> >  tools/testing/selftests/kvm/lib/x86/processor.c    | 12 ++++++++++--
> >  2 files changed, 24 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdx_uti=
l.h
> >
> > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/t=
ools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > new file mode 100644
> > index 000000000000..286d5e3c24b1
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +#ifndef SELFTESTS_TDX_TDX_UTIL_H
> > +#define SELFTESTS_TDX_TDX_UTIL_H
> > +
> > +#include <stdbool.h>
> > +
> > +#include "kvm_util.h"
> > +
> > +static inline bool is_tdx_vm(struct kvm_vm *vm)
> > +{
> > +     return vm->type =3D=3D KVM_X86_TDX_VM;
> > +}
>
> NIT: Might have been better to define this in 4/19 and use it there.  But
> looks like that logic is changed later on somewhere.  So...  meh.

We can skip the check for KVM_X86_TDX_VM entirely in 4/19 since like
you said, it's replaced with something different later on.

>
> Ira
>
> [snip]

