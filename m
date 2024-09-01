Return-Path: <linux-kselftest+bounces-16902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44FF967530
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 08:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86EF1F21624
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 06:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE73EA86;
	Sun,  1 Sep 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwy3OSuW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86262F28;
	Sun,  1 Sep 2024 06:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170634; cv=none; b=hdFwCNXJme5oWwIU0VsLIDQjgy25+xTCDIOyGLV4XHS/HOSdrecU9nPI8N8X2pqIUBdlbzXXWiMIY+8wVRlFkKsl7Hf6HMjXFSTdgeDTpXMZRW4pKU13LFuXA8WiC9q2Gxs0mnx89rk3AX4zrtvcC5xnB4Kobjv25zq+y3Elfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170634; c=relaxed/simple;
	bh=BE1uNmaEHpghxge9qsGxe/ZTsgs1/VX4qYFYoy1wips=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZC/0tVsjxwyHpnVitahJXIuCvLP+LeRJBWt6oOpLDxiJtJbifszHShgz3cUYXMEutjlbI1H6CjL4OjwfLXANjRrWDxuSzhki8X8/MJyIGtAcULcUSOfn+1DYf7jlnmTf8AUhsB/It7Wgmw/cmxo60whNC+LJ3dcsJyD2T9B5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwy3OSuW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d892cb9af8so691559a91.1;
        Sat, 31 Aug 2024 23:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170632; x=1725775432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUvg2ogZatFc7s06qNJPEReIY2yAlJYwNIS9fMUI4m0=;
        b=hwy3OSuWuC1LM6sof8IVJ/2neq9iLQ7CU45fkkkQe4gZVl+aM4HDpGTYIVmAjTR6U3
         NENWKtpJt/Ry/LnP7EEZPH/lUelMK6tYtVh33VmypjPVm+wDAABHBQXAj449X2YExXz+
         WMParePyQxjTzlDggkRgcy7Nyq4VwqjzvSlwR6RN4JYRxBNb3e0Th+r13k4zjeKAmgcq
         Q4OYmvgCCPUDWnpwlGfVE6wnBFqWUa/PnPseHIJsPu3Au/QuU9tqu33GjfDYdy6bq8Z9
         4tJE6s4R4UxdE1tQ4j5oW8YpkBmwBagvg56hG0ENyjHkR/tWMUvZ7ueFUJnhY/a15+3z
         Depw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170632; x=1725775432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUvg2ogZatFc7s06qNJPEReIY2yAlJYwNIS9fMUI4m0=;
        b=UTW33CBQ7DLbGh+i7KreQsTai0h34Tjat+II6sKx+YjFl0kjqLe/cFSo9Mb3Y9r5tg
         nepIP/rQt6N/awzD9aJa1mSIglgjR7rN27yB75agPwyirF0JplSp7rwi//pa62ky6ON9
         srcD6uzcs78kc2uyOlGBvMvZ1Y+1r5IOZ1XuFrvPQW2gx8uV9l7Qfp6oBdYNJl0GGKII
         jQpjZn8+z3WQrVY6LCfCOontNuB0EHza/ni1peBNLnyknltxj78+80HmYrbpSZdPD4Zb
         tTruJ8ZEgFq5yxJfzK9DzHGZhibqwYap9c9aDD6ieKhbe7cxOw5QnrBmGn4/j5eo53fm
         M2+g==
X-Forwarded-Encrypted: i=1; AJvYcCWf7eE/ioJlvp871smb7U2gtoEOSqR2rdx82ZsaieQO738TpyGBFHn28QElH5ckYOKjSBlKZIfTeBOjpctIyF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10SBL894BbovsclzG3sIRNMib4JIE8i3EU6ULlv7Sw2PvPgYH
	pi3AeVn4QcXPyLugWbDJC+dPdSP4HmMUoOaiN18P/fsfY7Ym52Ty
X-Google-Smtp-Source: AGHT+IFqGsh6AyuMpKg05TirGZda2sWyfSh7p9K8+zJUmdae9GtzsJBwYb9/VL5wed8mjOMumnYqFw==
X-Received: by 2002:a17:90b:1c88:b0:2d3:c088:9c54 with SMTP id 98e67ed59e1d1-2d85616ec49mr11494379a91.6.1725170631995;
        Sat, 31 Aug 2024 23:03:51 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b95e8sm6674629a91.54.2024.08.31.23.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 23:03:51 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 31 Aug 2024 23:03:49 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Support opening bpf objects of
 either endianness
Message-ID: <ZtQDxYhhN9166i2+@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
 <CAEf4BzbXD0M0Zfgih-7Rght_zSkTsZY3AmOpYxX5iaYimROaRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbXD0M0Zfgih-7Rght_zSkTsZY3AmOpYxX5iaYimROaRg@mail.gmail.com>

On Fri, Aug 30, 2024 at 02:25:54PM -0700, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 12:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Allow bpf_object__open() to access files of either endianness, and convert
> > included BPF programs to native byte-order in-memory for introspection.
> > Loading BPF objects of non-native byte-order is still disallowed however.
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c          | 49 +++++++++++++++++++++++++++------
> >  tools/lib/bpf/libbpf_internal.h | 11 ++++++++
> >  2 files changed, 52 insertions(+), 8 deletions(-)
> >
> 
> [...]
> 
> >
> > +       /* Validate ELF object endianness... */
> > +       if (ehdr->e_ident[EI_DATA] != ELFDATA2LSB &&
> > +           ehdr->e_ident[EI_DATA] != ELFDATA2MSB) {
> > +               err = -LIBBPF_ERRNO__ENDIAN;
> > +               pr_warn("elf: '%s' has unknown byte order\n", obj->path);
> > +               goto errout;
> > +       }
> > +       /* and preserve outside lifetime of bpf_object_open() */
> 
> what does it mean "preserve outside lifetime" ?

bpf_object_open() freed ELF data on exit but didn't zero obj->efile.ehdr,
leading to unpredictable use-after-free problems in is_native_endianness().
This is part of the fix but should be clearer e.g. "save after ELF data
freed...". Will update.

> 
> > +       obj->byteorder = ehdr->e_ident[EI_DATA];
> > +
> > +
> > +
> 
> why so many empty lines?..

I'm blind? Fixed, thanks.

> 
> >         if (elf_getshdrstrndx(elf, &obj->efile.shstrndx)) {
> >                 pr_warn("elf: failed to get section names section index for %s: %s\n",
> >                         obj->path, elf_errmsg(-1));
> 
> [...]
> 
> >         err = bpf_object__elf_init(obj);
> > -       err = err ? : bpf_object__check_endianness(obj);
> >         err = err ? : bpf_object__elf_collect(obj);
> >         err = err ? : bpf_object__collect_externs(obj);
> >         err = err ? : bpf_object_fixup_btf(obj);
> > @@ -8500,6 +8529,10 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
> >
> >         if (obj->gen_loader)
> >                 bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
> 
> nit: add {} around if, both sides should either have or not have {}
> 

OK, done.

> > +       else if (!is_native_endianness(obj)) {
> > +               pr_warn("object '%s' is not native endianness\n", obj->name);
> 
> "object '%s': load is not supported in non-native endianness\n"

Clearer, will update.

> 
> 
> > +               return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
> > +       }
> >
> >         err = bpf_object_prepare_token(obj);
> >         err = err ? : bpf_object__probe_loading(obj);
> 
> [...]

