Return-Path: <linux-kselftest+bounces-39714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9424AB321DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E61B64E18
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730529A30D;
	Fri, 22 Aug 2025 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NTWdP+X4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAFE29993D
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885507; cv=none; b=mqRr0uWzcW9L0GX4s9vkL1mL+WnUOo90XqJe5k7oKl70y8CR3drRnp5QL2aZndOn41iygwaYxO0Wndw4RJtcFj+5tPiVuex2DIyEVOVMAin2VwtTV9bxtRGSn0ON9xiIwxXGhfGwNwsGL0IkH5GxUS1Tu/KwfpvY3MvpprYdAvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885507; c=relaxed/simple;
	bh=nF6YlaAh7XuRGcAeSUxzKN7syva3tGK7AQ9piMFQqbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWdLa3vZZNeCSHV9NVhvSCl58wqCHYGDP2RiNEiA2OeHYJrtYtiR/2+lzSSUrPUn2dz0VzMkMoRzVxNz0w5wG/kO4GK6tWAX5eeTwuYppN5Bvaw7ldZpsC0eta1pL3e1nzG4z7dx43zBjOgow7snj9aB+p9JlDEP60ejQBdOiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NTWdP+X4; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-50f8af3517eso788287137.2
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755885503; x=1756490303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QctlWqJYLmIg/E5LPhpjhg17ib5pNjMH7p/Hx4zus4I=;
        b=NTWdP+X4Xxg5tI/7NKVqN1Ci7k2Air8QvJc564jyZr4rzbB3TvlktHSN9INkmEzU5Y
         TbSGmMiGkWC/ChQaf7pQqRIU5BaqW3cQTALyS2C9cLftquNgKDCtqd44P9RPDLHpL8Uu
         lsrXYkAbY/7WE8/EDWxkaj1gDDZVDY1j0F/HlKY6e847+KXbBqc0WYyJgqY5NGq58ZCK
         vdC5L1B4NMw0uBU0YeTmuLAgd2W4ZGqk3ImZNztNDN2iLZ8V+d5H6vE/IdbeWRNIZyyB
         oPv5rgNxsau7nLVUK0leUdLzznqfEM3cCJ0tUMIT9K+nuGg9qeQhDVjqD6BCLyU0ai5u
         Uycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885503; x=1756490303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QctlWqJYLmIg/E5LPhpjhg17ib5pNjMH7p/Hx4zus4I=;
        b=TunVf7SJ7yC67UGRruBSxAedrKC0KmKJmLgh53mpqiFgAVkqLDqc+Q/LznV2UVHLQh
         YfnGRa5/sC81VmMw0FBevoS6lWNppNonApvCDqVLrUUDbBPKPMovO0FUb4B7KxvVR4Ey
         NFKTNe8lLx+sFQB6mhxKGViOuSVz7LmpE3uZaC2b31Cg0KQ79oJH3WhS/GiRA70RQ7XY
         C6VVg6aJ2MDre8ngmmZQWmdGXhEHnq05Be/V/iirxrHgspuqVR60EueyWDOeERDgNh5+
         Da519+0oG2rK/i8oZiWQ5mcBza5DWt4DQKUdVfRYu/iWrkvJUwnnrv+Yies7+ETeD5mf
         hyYg==
X-Forwarded-Encrypted: i=1; AJvYcCW3i95d+l6vXzjGtlr9dPhI2yebLR6W79KW6SjqL5unz/sIuz/qT1TY+NonK4d3ldnVkpcxaQ+kj47ABfjJY38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5l6Fr7Ji3dGPf70xL2bBaxoFxywBeQC9Y9e2Q1EUqfzj4nb05
	7TuK9AEkI6NgpBBRDgddqV+qt9U7R+6iBreKZatarNbjV97p0pSd/uLFk+BxLgPWbPSmwQtkBQW
	tlqhUcifnn41tb2Msyg8tDE84CIv/NlX1kdIf0M5VVQ==
X-Gm-Gg: ASbGncvvoFO6mydE+HjbV/h5IvnasB9eLmQ4UlXX0kKU47FwgFrhwH9Rzt1veTMYkoW
	ru8cwhz9uh/UPNd7prkKOqT8RBd7T8mGecKJYcQeKyndb3jsshj3PVKPT6hloPD1msDnFJbpOa+
	ryiHcWwxbn4XLA/BRfJWSSiXizypEfGR33MdEkrRqsNIhANnNkrfTIGXTR7XC7zQWK37xey5fJY
	QeomoJq
X-Google-Smtp-Source: AGHT+IFN//tAIOu8+R+uuhM96f7zV3pePtaUS87r3F/6litKfGF0/DndAdWIWiwCZ7w8YwN9/a0uzZqZes7ebIu5qsc=
X-Received: by 2002:a05:6102:579b:b0:4fc:f151:a644 with SMTP id
 ada2fe7eead31-51d0f1e3aebmr1186332137.27.1755885503401; Fri, 22 Aug 2025
 10:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805193955.798277-1-jesse@rivosinc.com> <20250805193955.798277-9-jesse@rivosinc.com>
 <CACPK8Xd2QfL460LY2T0ia7Akb79fEXKF2+=B27M8q5j7jUoouQ@mail.gmail.com>
In-Reply-To: <CACPK8Xd2QfL460LY2T0ia7Akb79fEXKF2+=B27M8q5j7jUoouQ@mail.gmail.com>
From: Jesse Taube <jesse@rivosinc.com>
Date: Fri, 22 Aug 2025 10:58:12 -0700
X-Gm-Features: Ac12FXyOxEp8jMlrarfb8y3cqhZyCnGwLGrfNnesQRaBf_dB1MguAeHwG0yw4Oc
Message-ID: <CALSpo=bM8S2cKHRQ1Zn1ViDh9QfoKkWGVVeW50D1UQkXP_6rug@mail.gmail.com>
Subject: Re: [PATCH 8/8] selftests: riscv: Add test for hardware breakpoints
To: Joel Stanley <joel@jms.id.au>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:42=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> Hi Jesse,
>
> We had a pretty huge cc list on the thread, I've trimmed it right
> back. Feel free to add some people back but keep it focused.
>
> On Wed, 6 Aug 2025 at 05:42, Jesse Taube <jesse@rivosinc.com> wrote:
> >
> > Add riscv specific selftest for hardhardware breakpoints.
>
> nit: double hardware
>
> > These tests are based on:
> > tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
>
> The sefltest didn't build for me. There's a few suggested fixes below.
>
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> > ---
> > The selftest fails as register_user_hw_breakpoint seemingly does not
> > call arch_install_hw_breakpoint. The test also seems to fail on arm64
> > in the same way when I tested it.
>
> Is this still a problem with your patchset?

Yes

>
> Do you test in qemu? Can you share your version, command line, etc?

Yes. I used buildroot's `qemu_aarch64_virt_defconfig` config and set
`BR2_PACKAGE_LINUX_TOOLS_SELFTESTS` and tested with the example
command from the boards readme.

>
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/breakpoints/Makefile
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2021 ARM Limited
> > +# Originally tools/testing/arm64/abi/Makefile
>
> CFLAGS +=3D $(KHDR_INCLUDES)
>
> This adds -isystem to include local headers for the up to date
> ptrace.h and elf.h definitions.
>
>  $ make headers

oh that's why it wasn't building!

Thanks,
Jesse Taube
>  $ make -C tools/testing/selftests CROSS_COMPILE=3Driscv64-linux-gnu-
> ARCH=3Driscv TARGETS=3Driscv/breakpoints
>      make: Entering directory 'tools/testing/selftests'
>      riscv64-linux-gnu-gcc -static
> -otools/testing/selftests/riscv/breakpoints/breakpoint_test
>      -isystem usr/include -Itools/testing/selftests/../../../tools/includ=
e
>      -D_GNU_SOURCE=3D   breakpoint_test.c
>
> > +
> > +CFLAGS +=3D -I$(top_srcdir)/tools/include
> > +
> > +TEST_GEN_PROGS :=3D breakpoint_test
> > +
> > +include ../../lib.mk
> > +
> > +$(OUTPUT)/breakpoint_test: breakpoint_test.c
> > +       $(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > diff --git a/tools/testing/selftests/riscv/breakpoints/breakpoint_test.=
c b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
> > new file mode 100644
> > index 000000000000..faeecc72da12
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
> > @@ -0,0 +1,246 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2016 Google, Inc.
> > + *
> > + * Original Code by Pavel Labath <labath@google.com>
> > + *
> > + * Code modified by Pratyush Anand <panand@redhat.com>
> > + * for testing different byte select for each access size.
> > + * Originally tools/testing/selftests/breakpoints/breakpoint_test_arm6=
4.c
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <asm/ptrace.h>
> > +#include <sys/types.h>
> > +#include <sys/wait.h>
> > +#include <sys/ptrace.h>
> > +#include <sys/param.h>
> > +#include <sys/uio.h>
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +#include <stddef.h>
> > +#include <string.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <elf.h>
>
> This is the wrong elf.h, we want the one with NT_RISCV_HW_BREAK.
>
> -#include <elf.h>
> +#include <linux/elf.h>
>
>
> > +#include <errno.h>
> > +#include <signal.h>
> > +
> > +#include "../../kselftest.h"
> > +
> > +#define MAX_BP_SIZE 8
> > +

