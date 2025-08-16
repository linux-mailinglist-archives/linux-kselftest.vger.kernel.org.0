Return-Path: <linux-kselftest+bounces-39128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71EB28931
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 02:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE141CC217A
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 00:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2510957;
	Sat, 16 Aug 2025 00:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Ti40O1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF12904
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Aug 2025 00:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303749; cv=none; b=qv/0Bxw7sqmtOvoNmRaQidJfUpGZhgOCMnCDe8QsdbUnLxMSdyOfYk6GJu9BfPchgOTlMiXCdBM7azh6tAvg+kmTFY5qDsExFJ29mWFpzqP43h8OiIScjPL139569+yYI1HEdM1sWJmr5R794WO/qrxlQQM+USVowyfcPKwQXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303749; c=relaxed/simple;
	bh=Wh3z6S19D84SL8OrP7UhmAFviWo7tPijNFSdv3grLXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J8/SbSQV5t1L7TfompoX2wwKH6W+RifOCAo2bZaCy4NcRA3uNSOBnHLNUwXBG8H3vTifhzGYMS9vgeMcGMny6AeDwsTF+fSr7RGRQRU7O9O8/07epM2XiWgR1x3SCPVdIwNp2wF3VCiqNhnZAFGI2q4ghoCFE63EwEOEiHx3qeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Ti40O1a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323267c0292so2303715a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 17:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755303747; x=1755908547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3wBdk9H1Vt6sme48JNCL8OLAP+nfd/lh3+nxpJ1X4s=;
        b=4Ti40O1aJGjorYjUrTXZsG8MBccSVbphUkt4/ie8WE8Pd0BHQDuprSfFKlN/z7QRIf
         +eFERrI44UuUyIccNxFGIGR6y2JeBm3wmXDUDkdo8mhKQmYmvYM5ax8Ciy/FshikSrj5
         4ytmDw2nAuK3CQxWElIw+WhQRYqjjevVd65ZWsa3bd/rnwVPshAM2hLz8RFujKzIM/O9
         UEW6MZA0k/PQt5SkjvbaCAQadlvFJKa3FGglNY/MoyEkyWRGnGDvVP0+j476xLUH+Ak7
         dQ4J9f56jmTVn427PTO2HynxMs54qtlf7js+sAAM/z9srkxDS68eYWeUyVUN2Oro6Tts
         wrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755303747; x=1755908547;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X3wBdk9H1Vt6sme48JNCL8OLAP+nfd/lh3+nxpJ1X4s=;
        b=MqrPMOBZ/vASAdOY0+FsyePo2KBoGWbBpDB51pOBBrroV/YbCDH3YSzAUZmefOeih2
         rKRlp9m0iduBsbSIHLLAc74C6AQ5KwY23x5jfnQeQighT38pzRY6j7vUqkO28H4h3re2
         3QPSw9Z2XHiwnYbt4i+TgDOWqKs6MB3t60EIFEikwA6tfnRyQnoVDx+ORHpJPumD1yqh
         cjvvAXnRcVZLYZrVUZiKeHR5QiyuSr1p39lmBQp+KMz/A+AxICzVhClIyNwDCdFczYCd
         WC+B0lugF4r4gkUksogdtplyCiv1ve6r08O9tef5NKCiQP/+nk+lqZfvrqbqVXFVAQKh
         CpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsVuf4gob3Gc5eIfI0nGImKVuS0PgYopGt/pBjhcPipyQN2bpIcsqgZOKVJj0cJtWkKuxX2orqBDCZkz+6lWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwneD4UQ/UlKwY+RrgU3ctBfXCZKYoZJ9lYCPYLHeo5FmHbSfex
	ODmL9v70Ocek6CuZNOMCJOOKE+ziPgNu5vyegxqb4R9d6BJ6GSGiHTaT0dwAZvMR3lyqo7PnpwS
	qb/287g==
X-Google-Smtp-Source: AGHT+IE/x8l+IwNZ3Owxqu+oRGM35gIi/2y5zovy6E25qA4AEQWyEFk/gxtzR51nhpfEcZGzA+9uX2edFJw=
X-Received: from pjbqn6.prod.google.com ([2002:a17:90b:3d46:b0:31f:1a3e:fe3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2588:b0:321:96da:79f9
 with SMTP id 98e67ed59e1d1-3234224e0bamr5280234a91.34.1755303746879; Fri, 15
 Aug 2025 17:22:26 -0700 (PDT)
Date: Fri, 15 Aug 2025 17:22:24 -0700
In-Reply-To: <CAAhR5DG+EMVbrdGaPoUiX3MtnVktFtdiY+dDjRhA9tugAoRTJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <20250807201628.1185915-7-sagis@google.com>
 <aJpO_zN3buvaQoAW@google.com> <0c8d6d1c-d9e1-4ffd-bb26-a03fb87cde1f@linux.intel.com>
 <CAAhR5DG+EMVbrdGaPoUiX3MtnVktFtdiY+dDjRhA9tugAoRTJQ@mail.gmail.com>
Message-ID: <aJ_PQPkD3qrlW8jZ@google.com>
Subject: Re: [PATCH v8 06/30] KVM: selftests: Add helper functions to create
 TDX VMs
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025, Sagi Shahar wrote:
> On Tue, Aug 12, 2025 at 11:22=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel=
.com> wrote:
> >
> >
> >
> > On 8/12/2025 4:13 AM, Sean Christopherson wrote:
> > > On Thu, Aug 07, 2025, Sagi Shahar wrote:
> > [...]
> > >> +
> > >> +/*
> > >> + * Boot parameters for the TD.
> > >> + *
> > >> + * Unlike a regular VM, KVM cannot set registers such as esp, eip, =
etc
> > >> + * before boot, so to run selftests, these registers' values have t=
o be
> > >> + * initialized by the TD.
> > >> + *
> > >> + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS=
_GPA.
> > >> + *
> > >> + * The TD boot code will read off parameters from this struct and s=
et up the
> > >> + * vCPU for executing selftests.
> > >> + */
> > >> +struct __packed td_boot_parameters {
> > > None of these comments explain why these structures are __packed, and=
 I suspect
> > > _that_ is the most interesting/relevant information for unfamiliar re=
aders.
> > I guess because the fields defined in this structure are accessed by ha=
rd-coded
> > offsets in boot code.
> > But as you suggested below, replicating the functionality of the kernel=
's
> > OFFSET() could get rid of "__packed".
> >
>=20
> I agree, I think the reason for using __packed is because of the hard
> coded offsets. I tried using OFFSET() as Sean suggested but couldn't
> make it work.
>=20
> I can't get the Kbuild scripts to work inside the kvm selftests
> Makefile. I tried adding the following rules based on a reference I
> found:
>=20
> +include/x86/tdx/td_boot_offsets.h: lib/x86/tdx/td_boot_offsets.s
> +       $(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
> +
> +lib/x86/tdx/td_boot_offsets.s: lib/x86/tdx/td_boot_offsets.c
> +       $(call if_changed_dep,cc_s_c)
>=20
> But I'm getting the following error when trying to generate the header:
>=20
> /bin/sh: -c: line 1: syntax error near unexpected token `;'
> /bin/sh: -c: line 1: `set -e;  ;  printf '# cannot find fixdep (%s)\n'
>  > lib/x86/tdx/.td_boot_offsets.s.cmd; printf '# using basic dep
> data\n\n' >> lib/x86/tdx/.td_boot_offsets.s.cmd; cat
> lib/x86/tdx/.td_boot_offsets.s.d >>
> lib/x86/tdx/.td_boot_offsets.s.cmd; printf '\n%s\n'
> 'cmd_lib/x86/tdx/td_boot_offsets.s :=3D ' >>
> lib/x86/tdx/.td_boot_offsets.s.cmd'
> make: *** [Makefile.kvm:44: lib/x86/tdx/td_boot_offsets.s] Error 2
>=20
> For now I can add a comment on the __packed and add a TODO to replace
> it with OFFSET. I think that making OFFSET work inside the kvm
> selftests will require more expertise in the Kbuild system which I
> don't have.

No, I don't want to punt on this.  I don't care about __packed, I care abou=
t the
maintenance and review costs associated with hand coding struct offsets in =
.S
files.

The problem is this line:

	$(call if_changed_dep,cc_s_c)

IIUC, the kernel's "generic" command for generating a .s file from a .c fil=
e
assumes various paths and flags, which doesn't play nice with KVM selftests=
'
unusual setup.

We could fudge around that by defining a custom command, e.g.

	cmd_kvm_cc_s_c =3D $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@

but that just runs into more problems with the build system (variables not
defined, more assumptions about the environment, etc).

AFAICT, there's no need to use if_changed_dep, i.e. fixdep.  KVM selftests
generate dependencies using standard mechanisms, and they appear to work as
expected for this case, so just omit the if_change_dep and let the existing
dependency stuff do its magic.

This could be tidied up, e.g. add kbuild.h to tool/s, and is obviously inco=
mplete,
but it works.

---
 tools/testing/selftests/kvm/Makefile.kvm      | 13 ++++++++++
 .../kvm/lib/x86/tdx/td_boot_offsets.c         | 25 +++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets=
.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 438502e02a0f..1fec90da15a1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -237,6 +237,9 @@ OVERRIDE_TARGETS =3D 1
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
=20
+include $(top_srcdir)/scripts/Kbuild.include
+include $(top_srcdir)/scripts/Makefile.lib
+
 INSTALL_HDR_PATH =3D $(top_srcdir)/usr
 LINUX_HDR_PATH =3D $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE =3D $(top_srcdir)/tools/include
@@ -326,18 +329,28 @@ $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
 $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
=20
+$(OUTPUT)/lib/x86/tdx/td_boot.o: $(OUTPUT)/include/x86/tdx/td_boot_offsets=
.h
+
 # Compile the string overrides as freestanding to prevent the compiler fro=
m
 # generating self-referential code, e.g. without "freestanding" the compil=
er may
 # "optimize" memcmp() by invoking memcmp(), thus causing infinite recursio=
n.
 $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
=20
+$(OUTPUT)/lib/x86/tdx/td_boot_offsets.s: lib/x86/tdx/td_boot_offsets.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
+
+$(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot=
_offsets.s FORCE
+	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
+
 $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
 $(TEST_GEN_OBJ): $(GEN_HDRS)
=20
+FORCE:
+
 cscope: include_paths =3D $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include =
lib ..
 cscope:
 	$(RM) cscope.*
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c b/to=
ols/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
new file mode 100644
index 000000000000..622f9a19ca30
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+
+#include <linux/kernel.h>
+
+#include "tdx/td_boot.h"
+
+#define DEFINE(sym, val) \
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
+
+#define BLANK() asm volatile("\n.ascii \"->\"" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem))
+
+#define COMMENT(x) \
+	asm volatile("\n.ascii \"->#" x "\"")
+
+static void __attribute__((used)) common(void)
+{
+	BLANK();
+	OFFSET(TD_BOOT_cr0, td_boot_parameters, cr0);
+	OFFSET(TD_BOOT_cr3, td_boot_parameters, cr3);
+	OFFSET(TD_BOOT_cr4, td_boot_parameters, cr4);
+}

base-commit: 04b916993b06d35ec96a5324e0ed93d1eb115dbd
--=20


