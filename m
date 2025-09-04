Return-Path: <linux-kselftest+bounces-40726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92435B430B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 05:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22237A58BB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 03:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD72264C9;
	Thu,  4 Sep 2025 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2SFw0jV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497B225A3B
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Sep 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756958253; cv=none; b=FvJ2RmNnoRHGqBJvwOkYKIsst3OPNTu88sX/351a7bE75T82NGorJIwAwxHBvzYjNa1bhSvOSdUdPUy8ZVr7FwdVEeBv9GOTyTyZOBbjJx0hXdRS6AJCtL0E1XZsHVNNhQp70e3SE4S3UgO2draiG2dzGYWEPo41qn+3iCSnDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756958253; c=relaxed/simple;
	bh=xEMhVLidfWLK5GfLI3r1fuX8bsDGHXjmX0LNLTjKG/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyn3QeyjhdragdUJgSXy+fj8xYIdPoEU0Oh12qgkU3SdhWxOJVAWJvewCWoQ531EZgk0O98ytKD90WuKhoKnELSeOk2OVGVya1QuyyCaQc0PtsFt3f3RRudWne8PAg3JasQAaxaKZWGpXFyh/uEGKtovvvDMUtiFdJrCZFya628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2SFw0jV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5d6ce4ed7so153401cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Sep 2025 20:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756958251; x=1757563051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBTqFKoXnKiOcm50nqRS6Yy8I8KtvrzJ2PezTalB3Tk=;
        b=D2SFw0jVmMTzHtfxHEZeSbYbI55HcwaViZ9wIPXodxvaY/ZL+IrsJHh1gFj/PM8gJQ
         JzkPh0eaNyKUnMKxAVzaZtb73saeE9oteGo+CDtSfyKVO/pXGW2++RW1CCZ/mPEd3ExB
         pnLuDCki+E/WYpCYZSMwlfc03oSGHRYo/bBDz2W7aJYGZxCgajMcOpbmyMzAR9SjLZ1q
         zb2JNF+tysaFANvFToC/DTx6m7B6JlcpKdgjMmZXZqc3WiXKOXhjRmJJgJF1lVmnCxVR
         9n76T2ZSalguYnUiIgiHMJNUBCLp3C81qtR97S+w8TGPH8MEeJCCPpyIzq5UtNWxcMTW
         EaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756958251; x=1757563051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBTqFKoXnKiOcm50nqRS6Yy8I8KtvrzJ2PezTalB3Tk=;
        b=hZcgDXSpiW3T6QGilfc8aqnes7ezTZYzYVMZ+pPns7vy1hVGmxFi8uMyxKK5kbYPA7
         GGeCSJazbKhSrBCjbtcunXq3AqX+JWAklaGfESApwAnFeHmm4X+X1Uahn74r82zzFwk0
         kfC//tu7FxyD7pZQAgXl74MVMvneeFPRCS6SY7o9ybzjAi071ETyNFtZq0XWzJhchFk4
         B5fA3rdFgoZf5QNOr/00W2YWEi9Ab1YK01AoiAxznRgKXSpI3yKTLEgFlWtPjl1wctp8
         J+SlHW1pzUiA8vYX0mGTs0MNPC7VfRbOMgrsl7VIJ+e8ABK9LkeIRCU0nPYmQcTIYIG4
         2K2w==
X-Gm-Message-State: AOJu0YzkpiYQmei6eOLMKn3Mf0BXOosi93tWJjZU7FOGEmDcpJPl10jy
	r66XD7KwsAqsmSkw8N0Le4p/EjARfvICG/UjNBmteiZ9uHHxPQlthPwQznjz6a7Gf75wEKCT9B7
	3Baj4POdczlArTBODLUbh/Xh+Z6WTRhH9wfCjcA7C
X-Gm-Gg: ASbGncuqtG1c6WiL8Y69S5ARvu34wy1qT5z6udptQPX1zffz/TSUxY5I3eW2lFpmySK
	2HL+Za+/NDp5KlRoi+CIE1NA7sIRDd8eMnCLcjMyIQRyMCrfNy4NqzsJ2MdtoEOlMojH+FbnTvS
	OJ5zu3KFowcjTF+QlZWzJ1b//mQ130ozveEnIO5MW8Zj3dRf3BVaSsSTz6+xCqfhTwE3LlDBeEl
	3BU16utS9wI8X4FDAIcFjJe6JsVuYhjx0TabLy/oTUaFi87CR4XzBpE9w==
X-Google-Smtp-Source: AGHT+IFABB+Avc6QHEeuwF0wDDVLti6c3tU1IhZy3ktnq5x4DGEQkfAEm9v882fixgRaXfqJkMAftPwoMHh9OXXEYTo=
X-Received: by 2002:a05:622a:19aa:b0:4b0:82e5:946b with SMTP id
 d75a77b69052e-4b5d8fa35c0mr1558801cf.4.1756958250768; Wed, 03 Sep 2025
 20:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-14-sagis@google.com>
 <4306ca85-1dcd-47c1-bb36-b76a2efe061f@linux.intel.com>
In-Reply-To: <4306ca85-1dcd-47c1-bb36-b76a2efe061f@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Wed, 3 Sep 2025 22:57:19 -0500
X-Gm-Features: Ac12FXzNFOBbPOriwT60z3j6ue-cC6R2KpQybuwxnW3mftmkIHbJGx0TKHh8AQ8
Message-ID: <CAAhR5DFb1063E_zOLf8af_v3tQxx06cHtGL26j5XtojRv2GvLg@mail.gmail.com>
Subject: Re: [PATCH v9 13/19] KVM: selftests: TDX: Use KVM_TDX_CAPABILITIES to
 validate TDs' attribute configuration
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 4:22=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > This also exercises the KVM_TDX_CAPABILITIES ioctl.
>
> That commit message should describe what the patch does instead of relyin=
g on
> the title/short log.
>
> >
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > Co-developed-by: Sagi Shahar <sagis@google.com>
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/lib/x86/tdx/tdx_util.c        | 17 ++++++++++++++++=
+
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools=
/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > index 3869756a5641..d8eab99d9333 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > @@ -232,6 +232,21 @@ static void vm_tdx_filter_cpuid(struct kvm_vm *vm,
> >       free(tdx_cap);
> >   }
> >
> > +static void tdx_check_attributes(struct kvm_vm *vm, uint64_t attribute=
s)
> > +{
> > +     struct kvm_tdx_capabilities *tdx_cap;
> > +
> > +     tdx_cap =3D tdx_read_capabilities(vm);
> > +
> > +     /* TDX spec: any bits 0 in supported_attrs must be 0 in attribute=
s */
> > +     TEST_ASSERT_EQ(attributes & ~tdx_cap->supported_attrs, 0);
> > +
> > +     /* TDX spec: any bits 1 in attributes must be 1 in supported_attr=
s */
>
> The comments are not accurate.
>
> The descriptions in TDX spec are for ATTRIBUTES_ FIXED0 and ATTRIBUTES_ F=
IXED1.
> They are related to tdx_cap->supported_attrs returned by KVM, but they ar=
e not
> the same.
>

I actually think that one of the conditions is redundant. Here's my reasoni=
ng:
If a bit is 0 in attributes then both conditions will be true
regardless of the value of supported_attrs.
If a bit is 1 in attributes then both conditions will be true iff the
corresponding bit in supported_attrs is 1.

I'm going to keep only the second condition which is clearer and
update the comment.

>
> > +     TEST_ASSERT_EQ(attributes & tdx_cap->supported_attrs, attributes)=
;
> > +
> > +     free(tdx_cap);
> > +}
> > +
> >   void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
> >   {
> >       struct kvm_tdx_init_vm *init_vm;
> > @@ -251,6 +266,8 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t att=
ributes)
> >       memcpy(&init_vm->cpuid, cpuid, kvm_cpuid2_size(cpuid->nent));
> >       free(cpuid);
> >
> > +     tdx_check_attributes(vm, attributes);
> > +
> >       init_vm->attributes =3D attributes;
> >
> >       vm_tdx_vm_ioctl(vm, KVM_TDX_INIT_VM, 0, init_vm);
>

