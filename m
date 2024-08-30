Return-Path: <linux-kselftest+bounces-16861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96038966C20
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 00:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDF7284850
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 22:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BF1BB6BF;
	Fri, 30 Aug 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4ccN1Kg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F717107F;
	Fri, 30 Aug 2024 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056119; cv=none; b=Rk/BNaXR0wrT+ZSx8wBZZpglKo8cRBohsVfsuWBkOzyUIsd/HYEZrZisyoGsG7p5D91sPaOmduR/NHtxPlxM/AcGmzKSLZc7Pjyr4+xImn1Xa6yWRqQhXZ+SG8PgOHCJftlfzLZjhbppH+TlLV9lMhLLz5N6kpmqfJDb/aFwNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056119; c=relaxed/simple;
	bh=YcGRMbYBd1Xs7ckijngRmmsSctVCQ/vPcQxfdvtv28c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=klmWXhlHMru+ySuHIAuHD3tgk0FR3bXCjf8ROReqPmf40q/sJdnrRO2NaPoomC/V7JRBOwpE+nOmAezoeYPEZVrJAHnPbvuIpc9yK01yqAehKP0JrzVnBqyGt3u3jxXv3RbFoyEA7WXXEuOVxEys0oWRu9CMbNLiqcNcA0gLYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4ccN1Kg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20219a0fe4dso20797065ad.2;
        Fri, 30 Aug 2024 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725056117; x=1725660917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3YKGLZqwt69aHpGeEAPUZNIeuk11rIfVuN1lDQPoX0=;
        b=d4ccN1KgeYEoEmk/JhAkdiCoPU9Qrf267PPOeingkUe6KTNFkFd5jrjn7n3ERA9Qja
         KggwGzI0DPTAnTRgN+d/8zuqq5PFCuNLOPAZ+i612zcgpSdp/bqbws4owWlEh26e+k6c
         IKxcPM4cOS+7iVASqBvzIHaNciMBe+clqFb+bZKpsGOa1I4OosqkfmGlwD9VQmCrFwSN
         ieRlAxSuIOyzu5iPSkySGAqkCT7V+evUIqe3kVhRhUG1RTFwtKlzpas50d3yaD9AnBSF
         IWKk1U3P/HJ6uOcTiZIVkY8V8J4dgNhMd/tAmId6Kt3MhammRcMwK7I2MKPRAHlf8/Jh
         TvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725056117; x=1725660917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3YKGLZqwt69aHpGeEAPUZNIeuk11rIfVuN1lDQPoX0=;
        b=nz+a2vqYVzkXw7Brv4yf9K7UItc/sMhm+OUr1/v/R/jRUKUckJoqky8SWjRBj7ECiD
         94k9N4j6OLbPrzFdL9U+KSbb+ijibWs8sjf2gxL20+9aBrHQPogSz0N4VfPM7y+dywPk
         AqDuaxApV073Ie0Yr/7P7LfQLRmfGyFlnOp41V3sDEjdzoykXEw53ILwla2PzQQXpxd7
         oMqZbDNAOucV6jKUbP5sIizyIaSdry6YzJhbCapOGISrPVZC2LhX3bvAS6vqe7XnG9Rx
         8uDHbVuI4BmBYIaNV3J4mpyZ78mfaPYxosp5W2GpaWJyB0oNAN4YAR1YSfq/6RmyqnLg
         1EqA==
X-Forwarded-Encrypted: i=1; AJvYcCWBJxOVgGj0Tt/wEIc6K2lpWIGlXAoF6oZOjzZR6nfs58Z0m5rT2IFXgqtHagAEcqfbPns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt46HS2ZI/4LiWPT37pqaScxWExw02FrOc/282i6HdyC6aCM5p
	yy+mv93T8PTDsUdNMc91iRWDSHvX+Bk/eDGSntmUSmZElTgm0HWa
X-Google-Smtp-Source: AGHT+IHx3OHIf3S7TbCeOpY7cUvoDCo8s1inxyJkfn+V97zwgXSFxIQXbopUJVm+SrRKKfcufwdvvw==
X-Received: by 2002:a17:902:da8f:b0:201:e52c:9e53 with SMTP id d9443c01a7336-2050c4c9740mr78821935ad.62.1725056117319;
        Fri, 30 Aug 2024 15:15:17 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515550badsm31169315ad.241.2024.08.30.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 15:15:16 -0700 (PDT)
Message-ID: <1ed968ab238b156c38550cfc3c585ded7d13529f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] libbpf: Fix output .symtab byte-order
 during linking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,  Shuah Khan
 <shuah@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet
 <qmo@kernel.org>
Date: Fri, 30 Aug 2024 15:15:10 -0700
In-Reply-To: <5672557ebf511ff2231853fa306a36d280313165.1724976539.git.tony.ambardar@gmail.com>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
	 <5672557ebf511ff2231853fa306a36d280313165.1724976539.git.tony.ambardar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 00:29 -0700, Tony Ambardar wrote:
> Object linking output data uses the default ELF_T_BYTE type for '.symtab'
> section data, which disables any libelf-based translation. Explicitly set
> the ELF_T_SYM type for output to restore libelf's byte-order conversion,
> noting that input '.symtab' data is already correctly translated.
>=20
> Fixes: faf6ed321cf6 ("libbpf: Add BPF static linker APIs")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 9cd3d4109788..7489306cd6f7 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -396,6 +396,8 @@ static int init_output_elf(struct bpf_linker *linker,=
 const char *file)
>  		pr_warn_elf("failed to create SYMTAB data");
>  		return -EINVAL;
>  	}
> +	/* Ensure libelf translates byte-order of symbol records */
> +	sec->data->d_type =3D ELF_T_SYM;

I tried grepping through libelf to find out how this affects things,
and identified that it is primarily used by elfutils/libelf/gelf_xlatetof.c=
:gelf_xlatetof(),
which is an interface function and we don't seem to use it.
It is also used by dwfl_* functions while applying relocations,
but we don't use that either.

Could you please elaborate a bit on effects of this change?

> =20
>  	str_off =3D strset__add_str(linker->strtab_strs, sec->sec_name);
>  	if (str_off < 0)


