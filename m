Return-Path: <linux-kselftest+bounces-4566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B78538FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0DA28FC18
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 17:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA74604D0;
	Tue, 13 Feb 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daxJyUTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8BD604C9;
	Tue, 13 Feb 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846735; cv=none; b=Rteaf08U88EiTisEO+7JBhji5gxkhhLXQ+CCTBMp4X+rGMcRcujSBq3MYA6aIoSMkPuCnuCHzUauo2GVGCFMEE81DTC6E8vqT8W4bIsvDXgW8fHG8ySUvFa22w8rQjaIWedJUqkMCb65JYHTNuloyaVggTADEWXHOaQyJV/IaHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846735; c=relaxed/simple;
	bh=L8FC9DVO0Mg3A15dXzRFV/FVQ7qBDm65d4gp1EA3LVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGSWq7y2mzbzznC7Q/YgAR6vBYW+HrFpiaZmYDkiTqlHFqhavwDZI9AWTC9cRzj2147RA4P1ns/Uz0gToFKMoKLPmyTp1HzrYNsKEeXsx06iv2elSoi4c23z9XkkN7bgpH6U1ErZHhtPHvopUE8rw7diyL5THc+LWfdABIM+xzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daxJyUTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE16C433A6;
	Tue, 13 Feb 2024 17:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707846735;
	bh=L8FC9DVO0Mg3A15dXzRFV/FVQ7qBDm65d4gp1EA3LVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=daxJyUTOygGsSs/Ac0C/RS+vBvjT/1OTIQY0OFsLXyg/qVAC9zQVSgdMg5WnyLGM/
	 gdaRq59lek46Ry+Jxj0SH/yjhMw216i1oEawpKa7Xrxx6ZsWt5BJoW8dr6GOuZSSs9
	 SbACEIWrB1LROLgcDZpe37bRsJO/raRjwIx+hNR/XBCn1FKxYfZMJIejONxoulwpiV
	 QCbelNCiNug+7eWsobbzEPtB7X5eZly6u2MGRL4aQgZ+EfG+AdsVFIq1uQiTi8OYTx
	 49n/n7UrCuFgv3YDGT8KLYOpCg1M2yuJ2ZhVvqYVr0Wlx+183OrsBkgSCcGwN20W9F
	 E2O78WbM+JQhQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0e521de4eso40571221fa.2;
        Tue, 13 Feb 2024 09:52:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/jiJY81jZnx1U2dRrAhiG+q1Rr1acY/fO34BDZkS5/A/38NGBT9L2S3/hDLVGEV1vDAM0HZ13RKWsbHU02f9QcFlcUi1izQDaaI9l1eamgjm3u7EtWNrK5eN4dbZ3AxA+t1XWBjr7N20b9u1W5fNCvdyZLTcZfRr7XTKXcKzf3tD3gG54dD14GQ==
X-Gm-Message-State: AOJu0Yw6NhPh2G6DP/w67oOrUPE3HApuQxm5uFsjIfQf5huqQ0jNtLii
	qZ+qJHaxQZuVRfm3s3zdk/q5NOUPNBuneFf1Buei5J7fAeTBSxY6WGAaMd/lai+9YNbSmcK09lO
	8tID7F8LIJdFfCNcb68A5LQ6jtg==
X-Google-Smtp-Source: AGHT+IHuJy9IhWrPjMlCvqKJHMknK0u5AfC6XtdFikCh6p+qjoUnM3Y3a9lEYpei+DOe2y5nhijH2ca4zis+r3nNpfE=
X-Received: by 2002:a2e:9992:0:b0:2d0:fd1e:c588 with SMTP id
 w18-20020a2e9992000000b002d0fd1ec588mr297630lji.9.1707846733488; Tue, 13 Feb
 2024 09:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org>
 <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com>
 <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org> <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com>
 <2185a3cc3152a0b9a94b0c64353bc9a1.sboyd@kernel.org>
In-Reply-To: <2185a3cc3152a0b9a94b0c64353bc9a1.sboyd@kernel.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 13 Feb 2024 17:52:00 +0000
X-Gmail-Original-Message-ID: <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
Message-ID: <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
To: Stephen Boyd <sboyd@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Gow <davidgow@google.com>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 8:59=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wrot=
e:
>
> Quoting Geert Uytterhoeven (2024-02-05 11:55:29)
> > On Mon, Feb 5, 2024 at 8:19=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> =
wrote:
> > > Quoting David Gow (2024-02-02 20:10:17)
> > > > On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > Add a KUnit test that confirms a DTB has been loaded, i.e. there =
is a
> > > > > root node, and that the of_have_populated_dt() API works properly=
.
> > > > >
> > > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > > > Cc: David Gow <davidgow@google.com>
> > > > > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > > > > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > > > > ---
> > > >
> > > > This looks pretty good to me test-wise, though it still fails on m6=
8k.
> > > > (Everything else I tried it on works, though I've definitely not tr=
ied
> > > > _every_ architecture.)
> > > >
> > > > aarch64: PASSED
> > > > i386: PASSED
> > > > x86_64: PASSED
> > > > x86_64 KASAN: PASSED
> > > > powerpc64: PASSED
> > > > UML: PASSED
> > > > UML LLVM: PASSED
> > > > m68k: FAILED
> > > > > $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vm=
linux -append 'kunit.enable=3D1 console=3Dhvc0 kunit_shutdown=3Dreboot' -no=
-reboot -nographic -serial stdio -machine virt
> > > > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D dtb (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at d=
rivers/of/of_test.c:18
> > > > > [11:55:05] Expected np is not null, but is
> > > > > [11:55:05] [FAILED] dtb_root_node_found_by_path
> > > > > [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED =
at drivers/of/of_test.c:28
> > > > > [11:55:05] Expected of_root is not null, but is
> > > > > [11:55:05] [FAILED] dtb_root_node_populates_of_root
> > > > > [11:55:05]     # module: of_test
> > > > > [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> > > > > [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> > > > > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D [FAILED] dtb =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > Ah yeah I forgot to mention that. m68k fails because it doesn't call =
the
> > > unflatten_(and_copy)?_device_tree() function, so we don't populate a
> > > root node on that architecture. One solution would be to make CONFIG_=
OF
> > > unavailable on m68k. Or we have to make sure DT works on any
> > > architecture. Rob, what do you prefer here?
> >
> > I guess the latter?
> > Alpha, hexagon, parisc, s390, and sparc are also lacking calls
> > to unflatten.*device_tree().
> >
>
> sparc does that on purpose. Perhaps it's simplest to call
> unflatten_device_tree() if of_root is still NULL after setup_arch()
> returns.
>
> ---8<---
> diff --git a/init/main.c b/init/main.c
> index e24b0780fdff..02f5cf8be6c1 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -97,6 +97,8 @@
>  #include <linux/jump_label.h>
>  #include <linux/kcsan.h>
>  #include <linux/init_syscalls.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
>  #include <linux/stackdepot.h>
>  #include <linux/randomize_kstack.h>
>  #include <net/net_namespace.h>
> @@ -895,6 +897,8 @@ void start_kernel(void)
>         pr_notice("%s", linux_banner);
>         early_security_init();
>         setup_arch(&command_line);
> +       if (!of_root)

of_root is another thing I'd like to remove direct access to. That
check could be inside unflatten_device_tree().

> +               unflatten_device_tree();

That's back to what Frank had essentially and I wanted to avoid.

I think I'd just disable the tests on the above arches and let them
opt-in. I could be convinced otherwise though.

Rob

