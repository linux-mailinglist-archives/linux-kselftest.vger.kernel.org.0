Return-Path: <linux-kselftest+bounces-16898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E74967525
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 07:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2445E1F21DB6
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 05:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3638DEE;
	Sun,  1 Sep 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVu53+wP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89962837D;
	Sun,  1 Sep 2024 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170386; cv=none; b=blU9mAQ+Fu7QM5dk9XWmLTc+2cVJ1AmPMalA13ay22oO0zWc04p2mmG0n2BKUF8zlgdoG9vAB84XPSA9uDwIJo4yfeSdJBb4PjgCDioTR8Q8vLShHPDRAShJB1kv5Ol81wTyR6oqpIbvImmdQbOF1YEykrcW1XGlaUC7Uq8eeFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170386; c=relaxed/simple;
	bh=1HL8oq9/Iv5TIhRROJZvzHICsENqiTBFvvJeZ5eZQDY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbl0JJ+eRNpb5y5oqew35ju0b4IbRD3MRoqf/nKV3ou0N/5S4lkUsbHZarY/YrOPOy52XZRTH8GKk1AtboBLVQV7rl+9jtxvpjL1JEEmRSKba7jI9A1hQt+J+LxnE2HgKDu6EmLHIGwUn4h7mcIhDJxz8dV4Bk5QeEWFc04zhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVu53+wP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20573eb852aso28455ad.1;
        Sat, 31 Aug 2024 22:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170384; x=1725775184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4k9TEKhO0b0IIIfuNVoqKfthLBS0ZnXhcZUSJp7yI4=;
        b=MVu53+wPad+YP0pU3TeLfeJGVdIux1ubA3+++Lx6LGkZzLNSZM4jn9RpQOcHLNJ0F8
         3EPOq64jvMYEP72xDv66e6ZuTFLpawqJ2H3UpqB3y+dvkpaSiE55PlHuSuoZ/WRruPDD
         hIqBvmhrmfszvzEmOfeMAwcRxsk2MJoMi5osCiyzweYv5V1K5IAMBdjCfV7m0yczGz0d
         Q+hTbUziiQRlhlQU3UEqvglzbvDdU/S2uMiLOy3ppejLujJt27TQjumFKcdC+EjjeRI3
         /JLha7+QkKAJq8fwoT/ak6IXx0mCECid+dnVT5WRLPXmEIgRzuoVPfkoYlkm6rqX8WkJ
         bBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170384; x=1725775184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4k9TEKhO0b0IIIfuNVoqKfthLBS0ZnXhcZUSJp7yI4=;
        b=RgH1kHp9YcSSHpuVrXIe37NW9OahQHGVLkogZzSuxoZkbFFbsMpNhjWQ6LnhCxteKI
         uiru5fFWHW6ZcvnhzaG2fvJnIVZwi5st0gmK0jVrwNGgqphd/QADBgo6H5NwswcjDrC9
         Xuijn5tPIPmtv1Yym+5dvIbNG1ipa5RLIfGdSwFWHGoGolx+iYQZWgeoZ3FWRx8IFZP0
         nprq2H4MmOZG3yfEuzAu8BZGStO52I7cqdFG3AjX0dBBm9bU8neXsZTGVWHZ1oI/UE6t
         25WAckiFYE03uyqNny8rbzDzTI1inx+TfmY1uGHcATB+gCfAUnHZsd9vPX+Vog3vKBEp
         gpGw==
X-Forwarded-Encrypted: i=1; AJvYcCUOeR3ngArLr42ODnY7/3QSLXHpCySTQaQWMBRSBv68xD2L0Hd/fGsXeFDz+qCtc0pN8GqOQCs5vGcx9WRTf4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3toMw4V6X1eKwZzASJT08P1SNcMItj+3Xp/5LDITRQ8U7DxGO
	z50dZ4P24HACXh6kOVsJwdsSWLqm2U5e66G8wxOkBFqTTsg88s+1
X-Google-Smtp-Source: AGHT+IFNf+UIFU0iQIREYO5k3Ntnw8h7O0YeiUkF+QnIMAxsk37QqO61im5BYMln5xx4vzWfPC47sw==
X-Received: by 2002:a17:902:ce83:b0:205:4d27:616e with SMTP id d9443c01a7336-2054d2764a0mr51553845ad.22.1725170383797;
        Sat, 31 Aug 2024 22:59:43 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2055553958fsm12066305ad.99.2024.08.31.22.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 22:59:43 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 31 Aug 2024 22:59:41 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
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
Subject: Re: [PATCH bpf-next v4 3/8] libbpf: Fix output .symtab byte-order
 during linking
Message-ID: <ZtQCzdw9CkU1h5Uf@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <5672557ebf511ff2231853fa306a36d280313165.1724976539.git.tony.ambardar@gmail.com>
 <1ed968ab238b156c38550cfc3c585ded7d13529f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ed968ab238b156c38550cfc3c585ded7d13529f.camel@gmail.com>

On Fri, Aug 30, 2024 at 03:15:10PM -0700, Eduard Zingerman wrote:
> On Fri, 2024-08-30 at 00:29 -0700, Tony Ambardar wrote:
> > Object linking output data uses the default ELF_T_BYTE type for '.symtab'
> > section data, which disables any libelf-based translation. Explicitly set
> > the ELF_T_SYM type for output to restore libelf's byte-order conversion,
> > noting that input '.symtab' data is already correctly translated.
> > 
> > Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/linker.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> > index 9cd3d4109788..7489306cd6f7 100644
> > --- a/tools/lib/bpf/linker.c
> > +++ b/tools/lib/bpf/linker.c
> > @@ -396,6 +396,8 @@ static int init_output_elf(struct bpf_linker *linker, const char *file)
> >  		pr_warn_elf("failed to create SYMTAB data");
> >  		return -EINVAL;
> >  	}
> > +	/* Ensure libelf translates byte-order of symbol records */
> > +	sec->data->d_type = ELF_T_SYM;
> 
> I tried grepping through libelf to find out how this affects things,
> and identified that it is primarily used by elfutils/libelf/gelf_xlatetof.c:gelf_xlatetof(),
> which is an interface function and we don't seem to use it.
> It is also used by dwfl_* functions while applying relocations,
> but we don't use that either.
> 

Right, gelf_xlatetof() is exposed for _explicit_ user conversions, but
libelf still does translations implicitly for known section record types,
based on the ELF file's byte-order metadata. The idea is that ELF data
loaded in memory will be native-endianness for accessibility, but output
in the original endianness at rest/in a file, all transparently.

We try to follow the same idea in libbpf when opening and writing .BTF
and .BTF.ext data (e.g. see the *_raw_data() funcs).

> Could you please elaborate a bit on effects of this change?
> 

When linking objects of either endianness, libelf can translate the input
files based on ELF headers (endianness and type ELF_T_SYM) and allows us to
process .symtab data. When writing out the linked file however, we create a
new .symtab section in init_output_elf() but leave it as default ELT_T_BYTE
type, which undergoes no translation and leaves .symtab always in native
byte-order regardless of target endianness.

See also 61e8aeda9398 ("bpf: Fix libelf endian handling in resolv_btfids")
and related links for a similar example and explanations. Hope that helps.

Cheers,
Tony

> >  
> >  	str_off = strset__add_str(linker->strtab_strs, sec->sec_name);
> >  	if (str_off < 0)
> 

