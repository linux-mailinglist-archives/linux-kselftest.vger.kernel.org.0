Return-Path: <linux-kselftest+bounces-20899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B6E9B43BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33902B215BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A53202F65;
	Tue, 29 Oct 2024 08:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWGjIyIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A01854;
	Tue, 29 Oct 2024 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189196; cv=none; b=m8uuge8rBfJTesV8bicqYmjmm0EFSyAG023ZVTAng/LN7KwE9M2pc9AV1jNAG6qgSGmIPXnZeJLHGyvvubuguQFYFawtciZxAmXWa6+hQFdygDyv+G2S8z7Zm9mteqVed69aireCPX2LFsr8dBzAigzHJtvhd3Q77a2+SrD3eHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189196; c=relaxed/simple;
	bh=b6ORu50y88S7RMLQz6KA5JfYQ3oIvh0lix92w+9Q6jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSVE2ydSa0Gz5aKYdsNw3N7GUbY57+qB2alxGLkkCTWDbJpWW6b89r4ln6jk/DXrdtYKhSYd5W/riMVMwK+aaOHHLNGMD7p31uM71Mcxsr9XJEU1o402Q/WK5oNuYY0VyGwOkzecKVPKUs4+wI0d1Y+b5IZU5rfRgdUFkhJmeFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWGjIyIB; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7180bd5b79dso2023667a34.2;
        Tue, 29 Oct 2024 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730189193; x=1730793993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erYrvbuM+zOt800Pswb5/FeIgISJC9qqJWCYratTQZU=;
        b=eWGjIyIByFs4qG2sjNx/YnsJ4WoyVaFajWEmkS3r386ctJ5awv+lmME2z7X9uucefW
         dmo+5D8xlPBQPnWJSrjukF9t1gTVA4wK1fA1/Bp40VdkahjzO1S0vGCm6vMdtd780+yx
         fdgV8XEuAJ9R8I/2OBC47LMDiBO5GSKaY6anzAEG2hDuuDrnlEiNf4ROLE4Ve4IHJUDr
         lsuI1/PJ4VA3JDlPj5N72pcX1BTSlU5oIYIl16AwMxukI8yHder0qQz2k2r3pZkt9VCb
         tUlBaP9sn4Vxy2I+B2D4/yqBM6qOWmz8/7U9VIN3UZ+mFB9CFJyno3lvpuUkWLbxcumn
         7tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189193; x=1730793993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erYrvbuM+zOt800Pswb5/FeIgISJC9qqJWCYratTQZU=;
        b=buUV9GTXFzA/EJJaqq4OeN5zf9tNurPWYdGhZZK2U/MXj/Gn7fOZCWWoil0ZuE8UZy
         7VA4/8v+fcsgG4tM871pvzfEYJa5NKYYV97z9tlc6Z4/qcqMlPUgOtwNdNyerMt0KWcA
         SAOeBoTYwsdU9z9ysZzMzFH0fX4AIJWchSOL8LDuPcVpQyROaiUj5St0E/PQZIcCC7Yi
         JXRZ1y6PhtMmk0YW2oBs+wcLTPQAbkdSMWfZL8KlHsskd16dJg6uXgPmBJ3QavZZ9Ew9
         zS0b078bdlHNeXf4r0TZaJX9KGogZfLUseXhlwfd5FFnbLrTfYcshQz/uKePZw98FJUi
         /z9A==
X-Forwarded-Encrypted: i=1; AJvYcCWwe3PdXuJ02eajS35l3D+9HvxkUteXaco4bwWyUJvX9MrFGTiX2ky3Ohev/YkCHRgXd7+LrtfnQ8EQisE=@vger.kernel.org, AJvYcCXh7mee5Z3fHJQmlBmkNtCdydeTXucqdsiQGq9SSLZ0UYAkaZtLFBaA3LemC4h/F5mFFxFogrzxKvD4FxQiYcKU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4WmI6lgi5XQZ8abx4rImus6RShrFLBguboMqUYNXjLyEkA3uZ
	OKexMgbPAMtLZqSSXNcRfvOhbbWUDZwaNVVguUGFTeqCUl19pJrum7wnUGM3mSiKnVwLPin1Vs5
	KfT4v7UhqIkZ6MzQLjRjJT07M/9Y=
X-Google-Smtp-Source: AGHT+IFDFWL4mUjTprma/osZp1KJIoCHwGw0y8thgiAfWKZzlyBnrv8BrxgAMiSJRJIJRIEpMo2FiY9XYcdbCsPmb4I=
X-Received: by 2002:a05:6830:4189:b0:718:678:56e3 with SMTP id
 46e09a7af769-71867f1012cmr11989419a34.5.1730189192952; Tue, 29 Oct 2024
 01:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008094141.549248-5-zhangchunyan@iscas.ac.cn> <mhng-d7045132-a4e1-409a-9646-d8ecd3d6a48f@palmer-ri-x1c9a>
In-Reply-To: <mhng-d7045132-a4e1-409a-9646-d8ecd3d6a48f@palmer-ri-x1c9a>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Tue, 29 Oct 2024 16:05:56 +0800
Message-ID: <CAAfSe-t7iAomibbCJQJv6d6cig8eESgHCfWCuZkRUr9Jz+aY5Q@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] selftests/mm: skip virtual_address_range tests on riscv
To: Andrew Morton <akpm@linux-foundation.org>
Cc: zhangchunyan@iscas.ac.cn, shuah@kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, alex@ghiti.fr, 
	Charlie Jenkins <charlie@rivosinc.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew=EF=BC=8C

On Fri, 25 Oct 2024 at 02:00, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 08 Oct 2024 02:41:41 PDT (-0700), zhangchunyan@iscas.ac.cn wrote:
> > RISC-V doesn't currently have the behavior of restricting the virtual
> > address space which virtual_address_range tests check, this will
> > cause the tests fail. So lets disable the whole test suite for riscv64
> > for now, not build it and run_vmtests.sh will skip it if it is not pres=
ent.
> >
> > Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> > V1: https://lore.kernel.org/linux-mm/ZuOuedBpS7i3T%2Fo0@ghost/T/
> > ---
> >  tools/testing/selftests/mm/Makefile       |  2 ++
> >  tools/testing/selftests/mm/run_vmtests.sh | 10 ++++++----
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index 02e1204971b0..76a378c5c141 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -115,7 +115,9 @@ endif
> >
> >  ifneq (,$(filter $(ARCH),arm64 mips64 parisc64 powerpc riscv64 s390x s=
parc64 x86_64 s390))
> >  TEST_GEN_FILES +=3D va_high_addr_switch
> > +ifneq ($(ARCH),riscv64)
> >  TEST_GEN_FILES +=3D virtual_address_range
> > +endif
> >  TEST_GEN_FILES +=3D write_to_hugetlbfs
> >  endif
> >
> > diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/=
selftests/mm/run_vmtests.sh
> > index c5797ad1d37b..4493bfd1911c 100755
> > --- a/tools/testing/selftests/mm/run_vmtests.sh
> > +++ b/tools/testing/selftests/mm/run_vmtests.sh
> > @@ -347,10 +347,12 @@ if [ $VADDR64 -ne 0 ]; then
> >       # allows high virtual address allocation requests independent
> >       # of platform's physical memory.
> >
> > -     prev_policy=3D$(cat /proc/sys/vm/overcommit_memory)
> > -     echo 1 > /proc/sys/vm/overcommit_memory
> > -     CATEGORY=3D"hugevm" run_test ./virtual_address_range
> > -     echo $prev_policy > /proc/sys/vm/overcommit_memory
> > +     if [ -x ./virtual_address_range ]; then
> > +             prev_policy=3D$(cat /proc/sys/vm/overcommit_memory)
> > +             echo 1 > /proc/sys/vm/overcommit_memory
> > +             CATEGORY=3D"hugevm" run_test ./virtual_address_range
> > +             echo $prev_policy > /proc/sys/vm/overcommit_memory
> > +     fi
> >
> >       # va high address boundary switch test
> >       ARCH_ARM64=3D"arm64"
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> (I'm taking the first two as they're RISC-V bits)

Could you please pick up the last two through your tree?

Thanks,
Chunyan

