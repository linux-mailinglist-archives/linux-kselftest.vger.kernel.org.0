Return-Path: <linux-kselftest+bounces-16880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA21966E61
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 03:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C941F2193C
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 01:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF02D6AB8;
	Sat, 31 Aug 2024 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuBTYWVV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA5F8468;
	Sat, 31 Aug 2024 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725066993; cv=none; b=JnG8RP/lUliRs2izasXzFX0fNdvCzWxPFyWt9VnlkkTNozR4EV/FnyaYsPz1K3yeOebiaRflhLa8wVTr7TuYkuBCgSNhHUYG7XuLEjasoALQ7fCwZeqXfuTWQMR3b657phr2LUoq4reWHZ8NWOziLi8GbHPCUhrE6TmTjCBGkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725066993; c=relaxed/simple;
	bh=3QnpIB6FQ9dkiQhdvmP+BQRJiIKZ3dPOpuAAQrUkDDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AaMMLuogOfWHPTBq5Mgdxw9942OBLBZAmvZGtAL5htj2vohGL4TX8MfiWfu4lLaXEnbe5yiUkxhCmuWsqioOJSSCOcicHWSQo1xAWeoe8gt3PE/Uv95ahzq7KvqzmO84GXWftsLdS/XbQd5ai64qj4P+1izHuXXyeGQtfu8ZKns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuBTYWVV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71423273c62so1992164b3a.0;
        Fri, 30 Aug 2024 18:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725066991; x=1725671791; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FcDnrow6WtB1KbkiZmkX453afSXj+QRtLmHENO5iXR8=;
        b=QuBTYWVV3lasBTaMnQR7+FNO9OJkbtgMG3hI3qRXSBwM3hrGV8ER5ek8pxl4Y3W0H5
         k/JSQULyAvtW4HbuIB3mAw5AZzNUzRpvUyBXFKwAslIsiYQTSO/3MriINhwrCfTj2lIn
         iszcjmIeFM7fDghnJJphFEjwYJW7k2jrwYRhFVyC0WFn95SIneshhKB3xb5Y5K9C0ZrC
         EMWaI6F01GeCe9Onsix4DDUMwkRyPSk5fVct4EUsL/2P6qKkXYWncnBdmVuzPndRO3xF
         eXcF9sCt/SoYzwfnkZwrjHsLGarPvQeZj2Y2ICb8ygnqK2rA9LScrOwuhjam34vfYtD7
         QeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725066991; x=1725671791;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcDnrow6WtB1KbkiZmkX453afSXj+QRtLmHENO5iXR8=;
        b=CfPv1Y2zQ2JgwZgEaULHaF+kfOL1A5w6zhzkbpv2j+E2trq5KG0jETXRjXBE5culaG
         5ACMkTYH5xiEwIMuKIVztC0C/tTOxLyDWheoc2Mr3c3nMmexzeUvc9yka/W16+KIA+5y
         1QKYtoW2wCCXxPSQCV7yUZu4ThycOn0dv02YiKZEpH/kQ3f5xx662JskAiobdy1N7IS+
         YLiPFUWPuIDbN/4i64WmIPUOp7lpG8MJ55cbkRzYmyWpt5DEmcf4+b1aMVn8cAwbXlMN
         g/SwtdngkLCJPgBDb0VoRtV8gTFjvyGqnzxs1zJViR9qSGICP37RP6GO0jRbrhSyr8P7
         ic5w==
X-Forwarded-Encrypted: i=1; AJvYcCU6AFF3eDtaDJC7wwPG6+oJfDF1Yb2uFAP1pq8zkhGzwv+n6dmddA32WcKLuSxsZKom0XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHoI/yP8TEUN1HLEY3LsW+vVRSxSFYVkg5cjhTfhj3F5Z/UsqR
	UGEqflK9PwYYfOzwMVX3NjF7WA6CYGOjQsXd++h1tGwg2VUC3o7w
X-Google-Smtp-Source: AGHT+IFx47JajocYARpYviHtPMcOfzi+x+tT2hRRr3oFvC7RCS70iMj1nXGkmQJfg1/HV7smMCKzzg==
X-Received: by 2002:a05:6a21:9688:b0:1cc:e7a2:2bef with SMTP id adf61e73a8af0-1cece520dc3mr1818021637.30.1725066991500;
        Fri, 30 Aug 2024 18:16:31 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155424dbsm32305055ad.207.2024.08.30.18.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 18:16:31 -0700 (PDT)
Message-ID: <a0f0d8c8d15a9f1b59802037fdcfb39777b05f27.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Support opening bpf objects of
 either endianness
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
Date: Fri, 30 Aug 2024 18:16:25 -0700
In-Reply-To: <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
	 <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
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

[...]

> @@ -940,6 +942,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf=
_Data *sec_data,
>  	return 0;
>  }
> =20
> +static void bpf_object_bswap_progs(struct bpf_object *obj)
> +{
> +	struct bpf_program *prog =3D obj->programs;
> +	struct bpf_insn *insn;
> +	int p, i;
> +
> +	for (p =3D 0; p < obj->nr_programs; p++, prog++) {
> +		insn =3D prog->insns;
> +		for (i =3D 0; i < prog->insns_cnt; i++, insn++)
> +			bpf_insn_bswap(insn);
> +		pr_debug("prog '%s': converted %zu insns to native byte order\n",
> +			 prog->name, prog->insns_cnt);

Nit: pr_debug already printed available programs at this point,
     maybe move this call outside of both loops?

> +	}
> +}
> +
>  static const struct btf_member *
>  find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
>  {

[...]


