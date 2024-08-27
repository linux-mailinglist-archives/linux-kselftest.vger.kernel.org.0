Return-Path: <linux-kselftest+bounces-16383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2D19604A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C32827D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA345198A11;
	Tue, 27 Aug 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8r9Ic8v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF7198A08;
	Tue, 27 Aug 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748053; cv=none; b=WZAhyMbxDrff1DnIKPF4NIGtfFuCjuEt0LjcQ+CBTLjHX/YuyM2u83aQmP3m9u9AhnWe8/eJod+kfKmfdC1+DrNR2Cm+nghK59ljRcaZ398+5g24wJNf/tp4LNlHRQdi9/BsJNRy85OrXzAa7g9z99I6JCqeuMBkdUzmJ9hAaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748053; c=relaxed/simple;
	bh=pdQhOhKu9biortthiRRT6yMA7SuScYzR8x35bV2jsMQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejer56NnOgYitKSjUqOk8JNIZmvQR6qmiaGffSyglW40XFtf+pHUYzowz2dlNO1fZpmy4uOao5wo/rjSROaEWJN0HWPzXkx3FcxUXQ9UX58/voeagaGy1KBkkbhbMqs0BwxCVlwZjJ64v+8+lFrYTckc+KuXbPEzKG7mt1ulDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8r9Ic8v; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2700d796019so3586966fac.2;
        Tue, 27 Aug 2024 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724748051; x=1725352851; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sNpA/YuC34Bz7hNOIhbeUCpcziLvZTKMo0imXN5r+pA=;
        b=D8r9Ic8vjaUvxYXiuCdrKVq6MjDfUbp6o67TkcJ9fA42e3ATHAPgG2J2OiocnOyWpW
         CP7qqu1I/aUIUyNDe97IDKWcZcpIhKtQkCwBwWPm4BUWdNlZJeNEGjfxaxckjuuWTR2G
         YtGlcurcofDWnOlxe55SQZ3kXcZ/lswsSIptSUJ6IkbHD49eKMO+L7nZN2ySawAG4AEZ
         ajeZbC5W5PAaCiN3JzrQYnV0jxFaqkmK9AbYJk8p9EBHNUdCtvi8C5iqMR2YiZ7wBLt4
         uLTzg3NnGeTVFQmGvrrUIqml6RnsAHJ6uxvEWw1pyXSdY7uEwOUQRMOANxWb2mbE+YD6
         9uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748051; x=1725352851;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNpA/YuC34Bz7hNOIhbeUCpcziLvZTKMo0imXN5r+pA=;
        b=B708L5x0x2YGmPGaL3nyv6yfBWgOKuIkwgPCoBjHOdWgUBXjix2wAdxdXl/05uH+Gs
         wEi6qpccQhJ0DFhJj4bt/huDkBPFZElp8l4c1oyGI97vvl7tNRPEU4S0uYdL0xuP3xWz
         xo2poAkjllPynSQVsaBja1aLY3Cqe/2lM6c3vXYxwhQ52BOuhBBayA+o9Oku5F2xQb9f
         5Oug0uaH+dfb0X80IVSkLm0SYJm0eMAIFziB1MLHVmpplac6SlgEjOcTAwqsjTmz/UKX
         qXWjqUc29lEPBKPM5XbUbkgbmt9j/GehEpj1NC+oCgDG8Pgh8M+S4wsCBGj8vMIJtzEi
         RvCg==
X-Forwarded-Encrypted: i=1; AJvYcCUIpIkwhRZCPBXe4GZJmp8IeXDt/1hiaG6MdGxcnEj54zuHwfLsvuA3vUrAeqnlB6OEEzESajvqa769Y5hC+No=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDgdZDoLXwG/RLV09cM1lBowj7tTpLQCNhrN3fKxURsCI2HBy
	d9pNvHMj7PeP0a3sSUXi5shwhxRPIYfK9r5NObSeZ7fxMRrP0Ck023RPBesH
X-Google-Smtp-Source: AGHT+IFer9l83MJt19op4KEuAyaae5dNLgmOzAhE1j1JfvdYvdOChB4h6aeCyTc57HZjf+IOJU6QEQ==
X-Received: by 2002:a05:6870:818b:b0:261:1aad:2c03 with SMTP id 586e51a60fabf-273e6750a69mr12504887fac.43.1724748050950;
        Tue, 27 Aug 2024 01:40:50 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422eccbsm8157333b3a.2.2024.08.27.01.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:40:50 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 27 Aug 2024 01:40:48 -0700
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
Subject: Re: [PATCH bpf-next v2 5/8] libbpf: Support opening bpf objects of
 either endianness
Message-ID: <Zs2REL4FcvPmDWr3@kodidev-ubuntu>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
 <3b65982b50a9ca77a13d7a5a07b8b5d37abc477f.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4Bzbr79SQxfsmhB=5cbNdLRvsLXJT7+s0HvmvHghmyFC0MQ@mail.gmail.com>
 <ZsxencOVB7USkAWg@kodidev-ubuntu>
 <CAEf4Bzb90MrFsnc3Q+xkhR-xGtY-2y9iz2O4SStrOzyCipMp4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb90MrFsnc3Q+xkhR-xGtY-2y9iz2O4SStrOzyCipMp4Q@mail.gmail.com>

On Mon, Aug 26, 2024 at 02:28:17PM -0700, Andrii Nakryiko wrote:
> On Mon, Aug 26, 2024 at 3:53 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 12:47:47PM -0700, Andrii Nakryiko wrote:
> > > On Thu, Aug 22, 2024 at 2:25 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > >
> > > > From: Tony Ambardar <tony.ambardar@gmail.com>
> > > >
> > > > Allow bpf_object__open() to access files of either endianness, and convert
> > > > included BPF programs to native byte-order in-memory for introspection.
> > > >
> > > > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > > > ---
> > > >  tools/lib/bpf/libbpf.c          | 21 +++++++++++++++++++--
> > > >  tools/lib/bpf/libbpf_internal.h | 11 +++++++++++
> > > >  2 files changed, 30 insertions(+), 2 deletions(-)
> > > >
> > >
> > > Instructions are not the only data that would need swapping. We have
> > > user's data sections and stuff like that, which, generally speaking,
> > > isn't that safe to just byteswap.
> > >
> > > I do understand the appeal of being endianness-agnostic, but doesn't
> > > extend all the way to actually loading BPF programs. At least I
> > > wouldn't start there.
> >
> > Yes, absolutely. I first planned to move the endianness check from "open"
> > to "load" functions but got waylaid tracing skeleton code into the latter
> > and left it to continue progress. Let me figure out the best place to put
> > a check without breaking things.
> >
> 
> checking early during load should work just fine, I don't expect any problems

Right, I believe I have this working now without impacting skeleton.

> 
> > >
> > > We need to make open phase endianness agnostic, load should just fail
> > > for swapped endianness case. So let's record the fact that we are not
> > > in native endianness, and fail early in load step.
> > >
> > > This will still allow us to generate skeletons and stuff like that, right?
> > >
> 
> [...]
> 
> > > >
> > > > +       /* change BPF program insns to native endianness for introspection */
> > > > +       if (bpf_object__check_endianness(obj))
> > >
> > > let's rename this to "is_native_endianness()" and return true/false.
> > > "check" makes sense as something that errors out, but now it's purely
> > > a query, so "check" naming is confusing.
> > >
> >
> > Right, I mistook this as exported before and left it.
> 
> yeah, that double underscore is very misleading and I'd like to get
> rid of it, but my last attempt failed, so we are stuck with that for
> now
> 
> >
> > >
> > > BTW, so libelf will transparently byte-swap relocations and stuff like
> > > that to native endianness, is that right?
> >
> > Correct. Sections with types like ELF_T_REL (.rel) and ELF_T_SYM (.symtab)
> > get translated automagically. See patch #3 for example.
> >
> 
> ok, thanks for confirming
> 
> [...]
> 
> > > >
> > > > +static inline void bpf_insn_bswap(struct bpf_insn *insn)
> > > > +{
> > > > +       /* dst_reg & src_reg nibbles */
> > > > +       __u8 *regs = (__u8 *)insn + offsetofend(struct bpf_insn, code);
> > > > +
> > > > +       *regs = (*regs >> 4) | (*regs << 4);
> > >
> > > hm... we have fields, just do a brain-dead swap instead of all this
> > > mucking with offsetofend(
> > >
> > > __u8 tmp_reg = insn->dst_reg;
> > >
> > > insn->dst_reg = insn->src_reg;
> > > insn->src_reg = tmp_reg;
> > >
> > > ?
> >
> > Main reason for this is most compilers recognize the shift/or statement
> > pattern and emit a rotate op as I recall. And the offsetofend() seemed
> > clearest at documenting "the byte after opcode" while not obscuring these
> > are nibble fields. So would prefer to leave it unless you have strong
> > objections or I'm off the mark somehow. Let me know either way? Thanks!
> >
> 
> I do strongly prefer not having to use offsetofend() and pointer
> manipulations. Whatever tiny performance difference is completely
> irrelevant here. Let's go with a cleaner approach, please.

OK, will do for next revision.

> 
> 
> > >
> > >
> > > > +       insn->off = bswap_16(insn->off);
> > > > +       insn->imm = bswap_32(insn->imm);
> > > > +}
> > > > +
> > > >  /* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
> > > >   * Original FD is not closed or altered in any other way.
> > > >   * Preserves original FD value, if it's invalid (negative).
> > > > --
> > > > 2.34.1
> > > >

