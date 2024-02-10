Return-Path: <linux-kselftest+bounces-4486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F372850245
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 03:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3CF284095
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Feb 2024 02:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB5B5238;
	Sat, 10 Feb 2024 02:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syYrFvDR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AF5226;
	Sat, 10 Feb 2024 02:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707533976; cv=none; b=stoYyxEAhke4ebkMQp3jHJn7LdGcxnYjFTV8FRDyT3xYjOe9iG3fp04FpefoEV9BZ7khQtAaBnF4Kv94m8hp0vr50hAal0Y09uuYNh4krqgiZ70TtD90Mn5vP33ZbPqIiJgGgj8eRsSIaZ42Rhsar+p+uYV7PDFOJ8NDdVB+zhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707533976; c=relaxed/simple;
	bh=2lP+NSQhJ4c3moxHDlaunCfBTdIXLlNuFrDcFX1+1pE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=nJHgTKX9g7+PGXh4dzsinlMNJFiIXhlEpbSuFScK8IB94q8nT5anSFwrCjPoXqCBAEWOjsbdKPfcmD8Ek0TSaNx65gmJvlrNVQR79sBsC29jhMD7La0jntORTD3Rl4uOlJdps2kUU/gEgOaPNO5WcAf9ONZzh445EBFwYu2L43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syYrFvDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A872DC433F1;
	Sat, 10 Feb 2024 02:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707533975;
	bh=2lP+NSQhJ4c3moxHDlaunCfBTdIXLlNuFrDcFX1+1pE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=syYrFvDRzT653oWWDp8sFGcDJPCsnBbiq/Rh5N533i/1ZAPuPKKfb2urx8dmIPuxN
	 HvhWAo0LRLHoZLAfmr+r8pi/UTRSALYpQUk6iRbffi526uRWZXB8K7peKdASwUJiCx
	 hueU0WPHflJ4Jouf6M2u3HuOlk+5SUEDEV+3OWMvW/UszAAS1QroWA/xKpM3O9AuuS
	 MHyjv9m76ReLhXjfE20Nb2pXg4I4YocmFKiCYiGBtNOGuT4eKGTg8pwTJ8apJK9PHF
	 KCTKL9oq6/oGGyP2PYqxSgpDqQeEr5ETzpglwUB0YrFKfLt9CvbFjX1mK5MJqw6Nor
	 0EeXid8XjhdDg==
Message-ID: <2185a3cc3152a0b9a94b0c64353bc9a1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org> <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com> <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org> <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
From: Stephen Boyd <sboyd@kernel.org>
Cc: David Gow <davidgow@google.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Feb 2024 18:59:33 -0800
User-Agent: alot/0.10

Quoting Geert Uytterhoeven (2024-02-05 11:55:29)
> On Mon, Feb 5, 2024 at 8:19=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
> > Quoting David Gow (2024-02-02 20:10:17)
> > > On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > Add a KUnit test that confirms a DTB has been loaded, i.e. there is=
 a
> > > > root node, and that the of_have_populated_dt() API works properly.
> > > >
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > Cc: David Gow <davidgow@google.com>
> > > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > ---
> > >
> > > This looks pretty good to me test-wise, though it still fails on m68k.
> > > (Everything else I tried it on works, though I've definitely not tried
> > > _every_ architecture.)
> > >
> > > aarch64: PASSED
> > > i386: PASSED
> > > x86_64: PASSED
> > > x86_64 KASAN: PASSED
> > > powerpc64: PASSED
> > > UML: PASSED
> > > UML LLVM: PASSED
> > > m68k: FAILED
> > > > $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vmli=
nux -append 'kunit.enable=3D1 console=3Dhvc0 kunit_shutdown=3Dreboot' -no-r=
eboot -nographic -serial stdio -machine virt
> > > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D dtb (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at dri=
vers/of/of_test.c:18
> > > > [11:55:05] Expected np is not null, but is
> > > > [11:55:05] [FAILED] dtb_root_node_found_by_path
> > > > [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED at=
 drivers/of/of_test.c:28
> > > > [11:55:05] Expected of_root is not null, but is
> > > > [11:55:05] [FAILED] dtb_root_node_populates_of_root
> > > > [11:55:05]     # module: of_test
> > > > [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> > > > [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> > > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D [FAILED] dtb =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Ah yeah I forgot to mention that. m68k fails because it doesn't call the
> > unflatten_(and_copy)?_device_tree() function, so we don't populate a
> > root node on that architecture. One solution would be to make CONFIG_OF
> > unavailable on m68k. Or we have to make sure DT works on any
> > architecture. Rob, what do you prefer here?
>=20
> I guess the latter?
> Alpha, hexagon, parisc, s390, and sparc are also lacking calls
> to unflatten.*device_tree().
>=20

sparc does that on purpose. Perhaps it's simplest to call
unflatten_device_tree() if of_root is still NULL after setup_arch()
returns.

---8<---
diff --git a/init/main.c b/init/main.c
index e24b0780fdff..02f5cf8be6c1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -97,6 +97,8 @@
 #include <linux/jump_label.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
 #include <net/net_namespace.h>
@@ -895,6 +897,8 @@ void start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	if (!of_root)
+		unflatten_device_tree();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();

