Return-Path: <linux-kselftest+bounces-29187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C407AA646E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA15D3A5ABC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6D21D3EA;
	Mon, 17 Mar 2025 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV3auc4d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA11758B;
	Mon, 17 Mar 2025 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203155; cv=none; b=hIHrzXGOC8nOXtKxDLhiedxfOJZTkww/CTibRwKzZLrBhA9zkUpPUrTErlbmYVSpQzWztnZpkWeoTzsdO+4xr+ZMrVCmcCWrpV6kn4SVVZRSgjBzin5U3qDa1XpS+GrrCbM9ji6Vxlg0+9lAVFMHCyqWvCQNvTmis083PGSZ4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203155; c=relaxed/simple;
	bh=abhSV4oZla2hmjMZqJOBpvk7JGaPgKUD5B3Yerg3BxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBluz4T4Vxq98H9/8kEh7EfzMHKg/4T/OPi1ZJcpOxR5AIuijemwqJ6ANTDkOPly4dMmtJfyaSQq6XpXji83QraT8ZcipDfn9NI5YnTH8vChIjrivwr1hW6U1o78TrB44mFw/klKiWfx6epbSd/E0CM9QgWommE+KkxABuOFOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV3auc4d; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225d66a4839so47741955ad.1;
        Mon, 17 Mar 2025 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742203154; x=1742807954; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lMORBukfDNOzWrCEQijjWj2H6MggMJxZRFJuSPvnV3s=;
        b=WV3auc4dFxTsQQZJB6rEgKLXicouF6/JAn0MLYsSwns0BPRWhZJQf9vvu7IbbMJJ5b
         iCCLxdeH0b79Bmdx+8F27Vm56GH0pmrH7Y5FaSMK+3YSF1Fxr6I/BACNoVwrqwqKZiXU
         SmGR8yDFnUJA2tGDRS9P/v0jUdpEM/mS2QXCP7ZgcJ2SvWXcTxRFeJGAhs+yT2nSW9Iz
         lOil0sPnD63hYj15VtWAASsm6ngqGxZ210y/Pvk/lMiK4OGU6nvPm9vgvAjNH22oxRIe
         qy170sDBIyo25mqEdABXBO2QeVdMqe/G33gBw5qJiAr83RUm1BiyVk59lu6HX/rN9h6w
         dsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203154; x=1742807954;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMORBukfDNOzWrCEQijjWj2H6MggMJxZRFJuSPvnV3s=;
        b=sqzq7J6FfSaAZIWlusLKzlSH6c84iPKdQysqgitCzEH21sM3MiYydBXwgWiIfUx7II
         fceJKgHgACvb8TBiA+ciSrWW4juXMLUNdcgDlgORsX+OdoY7nueah54UIpnxbf5g41PD
         IsskWgqrV8qIDKEoL5ypnatb0Iop/HUijU6UWY7+11wh5lLoBanm+H6t//b2BGh4O/6F
         I8nJJFvlQLT/XB5S2PKM++WItPUhitIGeOVerRFp6NV+5vrMUCE1lu1c3v8Q0wIvXCp3
         W95tUpgnZtVLE2zhCCNUZXokEhcdpavNUBZxoojjGmYa38QugKaBSa3moQ6X7y2UDvsR
         bmGw==
X-Forwarded-Encrypted: i=1; AJvYcCUZngtGIIwMgr5ecttfXAAfy0k38/OCKkoVloQ3SDIOHqVN1NF1cPcbhIbqQ1u3xZ+/mQc=@vger.kernel.org, AJvYcCUnSBUZ5DgPz8kqrugmrYXwmiLjtHesY2S9xrEcGY0oCYwQCuyx35pehk937JXKBwq6ovNJOyCyyiyfFE3G@vger.kernel.org, AJvYcCVHqbZAmIgeU1km7bdhrM5DBvXz+fQyHFZqWepWDpJdqaFWKuA+7Y4zLfN3PNZnBtDLRh1dE1XXi5CM90LmO70m@vger.kernel.org
X-Gm-Message-State: AOJu0YxaiPRbgqUX7yV9Vy91/DjaF1qFgXax9vHI/SZirwwBowH87G3P
	sJATlF0DIPy8bZEU/tkf2zO/n1jEI2tmUwDgAPLnx1MLbJ9QsqVe
X-Gm-Gg: ASbGncto3709iKm7WC61UkjL7+hATn9j34H9uvQO6oaJ8wTJppX0jikJ1tQH/TR0Gke
	wkKWKttjA0hBe46kdgsN1CVhDrPtc6rxtnXv6m+6Kj/wtmSEbVszMkad4zsDSMHrVWuAW4CHbMF
	4AXKIMV1rFJXy7/DrwNoGsptR7wlNXH/iqcp5JuwT9Zbbj5xQWqMjd77JWdeGX+Nj6uzPTabBuV
	0IrBtgfNxEcpl+8338KpSd+AT8p3WCT1rf7NJnm/eBsZ1+ZA1VBUUBhbMVYsec5l3W12XK27+MB
	zCMVh0LvxPCI2BIByVd0xRB7KJwhzWqPaVRgw5DWbbKhCAI7Mzk=
X-Google-Smtp-Source: AGHT+IFQrLJwhlX7+RiGH3CxZ9FfxID5MIfJ1arkUBWGEnsa5Y9RjhdscgDV1ztpHSFUF5oJv7iB3A==
X-Received: by 2002:a05:6a00:8306:b0:736:5813:8c46 with SMTP id d2e1a72fcca58-737107f9d11mr17429679b3a.8.1742203153453;
        Mon, 17 Mar 2025 02:19:13 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115293f6sm7340451b3a.14.2025.03.17.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:19:12 -0700 (PDT)
Message-ID: <9083b52fd4a2d7a5a0473e858042c277c883f8b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next 09/11] bpf: Return PTR_ERR from push_stack()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Mykola
 Lysenko	 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Henriette Herzog	
 <henriette.herzog@rub.de>, Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Matan Shachnai <m.shachnai@gmail.com>,
 Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, George Guo	
 <guodongtai@kylinos.cn>, WANG Xuerui <git@xen0n.name>, Tiezhu Yang	
 <yangtiezhu@loongson.cn>
Cc: Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
Date: Mon, 17 Mar 2025 02:19:08 -0700
In-Reply-To: <20250313174149.1113165-4-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
	 <20250313174149.1113165-1-luis.gerhorst@fau.de>
	 <20250313174149.1113165-4-luis.gerhorst@fau.de>
Content-Type: multipart/mixed; boundary="=-pU3IArgK79wjJvjdvEwt"
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-pU3IArgK79wjJvjdvEwt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-03-13 at 18:41 +0100, Luis Gerhorst wrote:

[...]

> @@ -2011,8 +2011,10 @@ static struct bpf_verifier_state *push_stack(struc=
t bpf_verifier_env *env,
>  	int err;
> =20
>  	elem =3D kzalloc(sizeof(struct bpf_verifier_stack_elem), GFP_KERNEL);
> -	if (!elem)
> -		goto err;
> +	if (!elem) {
> +		err =3D -ENOMEM;
> +		goto unrecoverable_err;
> +	}

Could you please point me to a location, where exact error code
returned by updated push_stack() matters?
I checked push_stack() callgraph (in the attachment), but can't find
anything.

> =20
>  	elem->insn_idx =3D insn_idx;
>  	elem->prev_insn_idx =3D prev_insn_idx;
> @@ -2022,12 +2024,19 @@ static struct bpf_verifier_state *push_stack(stru=
ct bpf_verifier_env *env,

[...]


--=-pU3IArgK79wjJvjdvEwt
Content-Disposition: attachment; filename="push_stack.dot"
Content-Transfer-Encoding: base64
Content-Type: text/vnd.graphviz; name="push_stack.dot"; charset="UTF-8"

ZGlncmFwaCBHIHsKTm9kZTB4NTVkZDRhOGQ0YjUwIFtsYWJlbD0ie2NoZWNrX2NvbmRfam1wX29w
fSIsIHNoYXBlPXJlY29yZF07Ck5vZGUweDU1ZGQ0YWEwNjc5MCBbbGFiZWw9IntzYW5pdGl6ZV9z
cGVjdWxhdGl2ZV9wYXRofSIsIHNoYXBlPXJlY29yZF07Ck5vZGUweDU1ZGQ0YThjYTU4MCBbbGFi
ZWw9IntjaGVja19oZWxwZXJfY2FsbH0iLCBzaGFwZT1yZWNvcmRdOwpOb2RlMHg1NWRkNGE4Y2Yy
NjAgW2xhYmVsPSJ7Y2hlY2tfa2Z1bmNfY2FsbH0iLCBzaGFwZT1yZWNvcmRdOwpOb2RlMHg1NWRk
NGE4OGQ3ZDAgW2xhYmVsPSJ7ZG9fY2hlY2t9Iiwgc2hhcGU9cmVjb3JkXTsKTm9kZTB4NTVkZDRh
YTNhMzYwIFtsYWJlbD0ie2FkanVzdF9wdHJfbWluX21heF92YWxzfSIsIHNoYXBlPXJlY29yZF07
Ck5vZGUweDU1ZGQ0YTc2YzYyMCBbbGFiZWw9Intkb19jaGVja19jb21tb259Iiwgc2hhcGU9cmVj
b3JkXTsKTm9kZTB4NTVkZDRhOGJhODUwIFtsYWJlbD0ie2FkanVzdF9yZWdfbWluX21heF92YWxz
fSIsIHNoYXBlPXJlY29yZF07Ck5vZGUweDU1ZGQ0OTU5ZmU0MCBbbGFiZWw9Intwcm9jZXNzX2l0
ZXJfbmV4dF9jYWxsfSIsIHNoYXBlPXJlY29yZF07Ck5vZGUweDU1ZGQ0YWE1YzFlMCBbbGFiZWw9
IntzYW5pdGl6ZV9wdHJfYWx1fSIsIHNoYXBlPXJlY29yZF07Ck5vZGUweDU1ZGQ0YTlhM2FjMCBb
bGFiZWw9IntwdXNoX2NhbGxiYWNrX2NhbGx9Iiwgc2hhcGU9cmVjb3JkXTsKTm9kZTB4NTVkZDRh
OWZiOWQwIFtsYWJlbD0ie3B1c2hfc3RhY2t9Iiwgc2hhcGU9cmVjb3JkXTsKTm9kZTB4NTVkZDRh
Nzc4ZGIwIFtsYWJlbD0ie2RvX2NoZWNrX3N1YnByb2dzfSIsIHNoYXBlPXJlY29yZF07Ck5vZGUw
eDU1ZGQ0YTc0MTk5MCBbbGFiZWw9InticGZfY2hlY2t9Iiwgc2hhcGU9cmVjb3JkXTsKTm9kZTB4
NTVkZDRhNzQxOTkwIC0+IE5vZGUweDU1ZGQ0YTc3OGRiMDsKTm9kZTB4NTVkZDRhNzQxOTkwIC0+
IE5vZGUweDU1ZGQ0YTc2YzYyMDsKTm9kZTB4NTVkZDRhNzc4ZGIwIC0+IE5vZGUweDU1ZGQ0YTc2
YzYyMDsKTm9kZTB4NTVkZDRhNzZjNjIwIC0+IE5vZGUweDU1ZGQ0YTg4ZDdkMDsKTm9kZTB4NTVk
ZDRhODhkN2QwIC0+IE5vZGUweDU1ZGQ0YThkNGI1MDsKTm9kZTB4NTVkZDRhODhkN2QwIC0+IE5v
ZGUweDU1ZGQ0YThjYTU4MDsKTm9kZTB4NTVkZDRhODhkN2QwIC0+IE5vZGUweDU1ZGQ0YThjZjI2
MDsKTm9kZTB4NTVkZDRhODhkN2QwIC0+IE5vZGUweDU1ZGQ0YThiYTg1MDsKTm9kZTB4NTVkZDRh
OGNmMjYwIC0+IE5vZGUweDU1ZGQ0OTU5ZmU0MDsKTm9kZTB4NTVkZDRhOGNmMjYwIC0+IE5vZGUw
eDU1ZGQ0YTlhM2FjMDsKTm9kZTB4NTVkZDRhOGNhNTgwIC0+IE5vZGUweDU1ZGQ0YTlhM2FjMDsK
Tm9kZTB4NTVkZDRhOGQ0YjUwIC0+IE5vZGUweDU1ZGQ0YTlmYjlkMDsKTm9kZTB4NTVkZDRhOGQ0
YjUwIC0+IE5vZGUweDU1ZGQ0YWEwNjc5MDsKTm9kZTB4NTVkZDRhOGJhODUwIC0+IE5vZGUweDU1
ZGQ0YWEzYTM2MDsKTm9kZTB4NTVkZDRhYTNhMzYwIC0+IE5vZGUweDU1ZGQ0YWE1YzFlMDsKTm9k
ZTB4NTVkZDRhYTVjMWUwIC0+IE5vZGUweDU1ZGQ0YTlmYjlkMDsKTm9kZTB4NTVkZDRhYTA2Nzkw
IC0+IE5vZGUweDU1ZGQ0YTlmYjlkMDsKTm9kZTB4NTVkZDRhOWEzYWMwIC0+IE5vZGUweDU1ZGQ0
YTlmYjlkMDsKTm9kZTB4NTVkZDQ5NTlmZTQwIC0+IE5vZGUweDU1ZGQ0YTlmYjlkMDsKfQo=


--=-pU3IArgK79wjJvjdvEwt--

