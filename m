Return-Path: <linux-kselftest+bounces-467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6E87F568E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 03:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B218C1C20C3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFBB187E;
	Thu, 23 Nov 2023 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEgSz4bM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEC101;
	Wed, 22 Nov 2023 18:50:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so511449e87.3;
        Wed, 22 Nov 2023 18:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700707819; x=1701312619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D08p5YAHoEvBUZt7xMX5L9P22HbicVdwPxBXjnz6Npw=;
        b=OEgSz4bMFRfas0c6CWJPm9GTZlMeWGgtqYRfijgTcSYSehXIpoP5OOHVUGlvpNAOJW
         IFsNHKJx5zJWATQP64aqh/3SbwsLUEYeSKl550vjP3fcpEWDBiK88ms/tpHY6SUr0Tkg
         1HVIb8Ruce6Sa/qcnK0/kn1DYPvy4eia8TDLKl5v2QnEXfVxeEqxxF0wamcRjTS+N6Eg
         wDiNgaDuxawpTiaWyIjttTBKcO+aJsMMq0BX3KrE6D0CHG6AUOjxTHx6UH1hgbQ38o4A
         72xSDKaM5TTlOT0dkUCaL998L5acBL4HFreEOo909l40e6dPfVeU9PIcjZaAU7fPBBIJ
         dECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700707819; x=1701312619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D08p5YAHoEvBUZt7xMX5L9P22HbicVdwPxBXjnz6Npw=;
        b=IIrdNTi6XwzwDizv6IWa6ov/5eloIANdKsYZYlmgvFCYyUyn8K05t2GoUBEp16DuAj
         bxAGmXkSnrdAizV3LLDJ/GUCzncDX/dhrB2EZVxLARm4hjCgVYk4YelPxL2Vq8RB7DK9
         bpPslT099Ah33Z8rmCrnSQ3x/1S2TDkNx3bwA/zlf/+QiF2XvWdbVUpVf1z3C4RRnmxB
         AehIMpeSx5ZST3b2TsGu7ftahfXRy66ABpjxOcqd1EmkOwiO4mpDippPo2cY1L6JVs1A
         fpwqF77kefkaEx+BohiL6Tfdy38GTY7zr176tATiEdcnFkBABoEyqbQiFpiWW96FG0Me
         pPkQ==
X-Gm-Message-State: AOJu0YzRaX1T4kRie7xWxRyxzFyw1LjHGyGfJYWJea82ix3EmGfUu1dx
	D5YaipouN01XPlPxB34tWJQPcFjMdbBXYWvrdE0=
X-Google-Smtp-Source: AGHT+IHYfupwzu0CW6znUvnxSIcpycCfMCyG5yvT7i4wgCWs3TEwSE0e3Jej9CVUNIj28w27da85FVVMqHACxKhDkTk=
X-Received: by 2002:a05:6512:158e:b0:507:a766:ad27 with SMTP id
 bp14-20020a056512158e00b00507a766ad27mr4204558lfb.16.1700707818800; Wed, 22
 Nov 2023 18:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1694421911.git.haibo1.xu@intel.com> <cda6cc71c9bdde87fe87f6c2dec4f03ca249dd62.1694421911.git.haibo1.xu@intel.com>
 <20231003-d44206f71d0b22e539833697@orel> <CAJve8o=Q74U0Z3PayrzY7heNc0qeTw5VYS+tdkpm=aJdefQEbQ@mail.gmail.com>
 <20231122-b471122622059496906801c1@orel>
In-Reply-To: <20231122-b471122622059496906801c1@orel>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Thu, 23 Nov 2023 10:50:07 +0800
Message-ID: <CAJve8o=gsY=qQUce-Z25p6C2BO5eLnH9N=MxjcdX0v0hFKN8kw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] KVM: selftests: Unify the makefile rule for split targets
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Sean Christopherson <seanjc@google.com>, Ricardo Koller <ricarkol@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Colton Lewis <coltonlewis@google.com>, Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:13=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sun, Oct 08, 2023 at 10:58:57AM +0800, Haibo Xu wrote:
> > On Tue, Oct 3, 2023 at 6:28=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > >
> > > On Thu, Sep 14, 2023 at 09:36:56AM +0800, Haibo Xu wrote:
> > > > A separate makefile rule was used for split targets which was added
> > > > in patch(KVM: arm64: selftests: Split get-reg-list test code). This
> > > > could be avoided by minor changes to the recipes of current rule.
> > > >
> > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > ---
> > > >  tools/testing/selftests/kvm/Makefile | 6 ++----
> > > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/s=
elftests/kvm/Makefile
> > > > index a3bb36fb3cfc..7972269e8c5f 100644
> > > > --- a/tools/testing/selftests/kvm/Makefile
> > > > +++ b/tools/testing/selftests/kvm/Makefile
> > > > @@ -249,13 +249,10 @@ TEST_DEP_FILES +=3D $(patsubst %.o, %.d, $(SP=
LIT_TESTS_OBJS))
> > > >  -include $(TEST_DEP_FILES)
> > > >
> > > >  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
> > > > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LI=
BKVM_OBJS) $(LDLIBS) -o $@
> > > > +     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LD=
LIBS) -o $@
> > > >  $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
> > > >       $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> > > >
> > > > -$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
> > > > -     $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LD=
LIBS) -o $@
> > > > -
> > > >  EXTRA_CLEAN +=3D $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) =
$(SPLIT_TESTS_OBJS) cscope.*
> > > >
> > > >  x :=3D $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OB=
J))))
> > > > @@ -274,6 +271,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
> > > >  x :=3D $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> > > >  $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
> > > >  $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
> > > > +$(SPLIT_TESTS_TARGETS): $(OUTPUT)/%: $(ARCH_DIR)/%.o
> > > >
> > > >  cscope: include_paths =3D $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) =
include lib ..
> > > >  cscope:
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > I just noticed that with and without this patch we're building the
> > > arch-specific part in tools/testing/selftests/kvm/riscv even when we =
have
> > > an $(OUTPUT) directory (e.g. O=3Dbuild). Those build artifacts should=
 be in
> > > build/kselftest/kvm/riscv instead.
> > >
> >
> > Thanks for pointing it out. I will have a look in next week!
> >
>
> Hi Haibo,
>
> Paolo just fixed this
>
> https://lore.kernel.org/all/20231121165631.1170797-1-pbonzini@redhat.com/
>

Thanks for the info! I will rebase the patch set in next version.

Thanks,
Haibo

> Thanks,
> drew

