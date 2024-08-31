Return-Path: <linux-kselftest+bounces-16863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D2966D33
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 02:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1913B1F23B50
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 Aug 2024 00:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D5184F;
	Sat, 31 Aug 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/TSZAtg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2142B3D76;
	Sat, 31 Aug 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063314; cv=none; b=FfY/q8w/UgodSpVInm+1QCVAdRzK3r0L2yMmPr+aw7uWmgNae713vGeLlJRshJfmgEh8H038V7W+zhIjcdRVagCjmMcqtY8JvYpaYXVttaLYovmH1W5GFEQUxbHDv04usdRXpltx9toB59UsAJYjGSnYa8+HEhyHTZCX0dT5ZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063314; c=relaxed/simple;
	bh=yjc76FYIvXTfIbUPJ7xf4o0qbEEiZrXB1gCa+24ER58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9DoTc57G5w31EAYm1E+UgJ92Gw7JgNM+O1qWR4APZbzO8lHy5/FKgMxdjuOB8NbSG5WjR8B0MbmsDJi0HEunJEHaSVezqhQmJvYbxYiiwkRrZbEm0YODrhCYkZXoWeOy/sbsUJt267Uv3103JJED2dJOQ7yelIEv/WJF4hfWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/TSZAtg; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso1644746a12.1;
        Fri, 30 Aug 2024 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725063312; x=1725668112; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FycnpSKAAaXJXhpg2kSzDZ0XpUACAhXtzyMQY8mTp1Y=;
        b=g/TSZAtggX9d2awnx4Z/AmRmbyeRM7l2RGt1aAefR+c1mLKEnNxpd68cXaxFTc1iRv
         XYk46Tmej3OfLXlaDU4fkOgrh8zG/wRbsYNj7qVSpavXoYIrWF6zGE82yLnMjNxESzWJ
         4Nppp4p1Os/XHCKZAb7TkZHOF05f1Rlq+pHc9mFkit3W8X4dewfS9IG3XRiNSF+CC0OI
         EKOerPR5Nu0MiW2/4wCI99yZ5sywtkmi7pwh5jiPR0bZ0hc2NU+wfNTBQWziBLDxShVE
         n7VPtyME0KwRJWxXcsCoiHujlJB0o9gTFSlJkPF2RIorrO1W7x3+efVDof/KxAp6sMg5
         oKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063312; x=1725668112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FycnpSKAAaXJXhpg2kSzDZ0XpUACAhXtzyMQY8mTp1Y=;
        b=g/ULJryqxNIaGQT9T0R34f5LX9NZ2uDDDSIhZW7++btWuMyvAhr8KuRshpw6Idk4Q7
         izLIV4TY27KZA3zFgtedulaP0URBprx8j1RFrrSZ42Y+DEewgAt/SON0VnWbylj8N+ZM
         Ika+plq5BuSqIpCobgcmN+v4UXk1v9aH7woDow1ZtbNkLjVRLQecbxQI7d6aTfi363I1
         RSn2DdrpcyOTDZPYI1S9wsPEuVAJVxMzUhAIzZgl2M5HVKg76oufPvdaZajw+A8HDCcJ
         G4TRPVerY0tukZnTCmkKggk52RwZWhUB1KpU07YbBcT9CwvnUv3ABDRgvF6K2w3L0C87
         yEqA==
X-Forwarded-Encrypted: i=1; AJvYcCWj2GarybTYIQgUj5ffPOe9nqnLgcSgr19cRj080GGqvgW91BvGhR2ThAXytOEXcUsfSEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyME4iu+oKCkwDZj+37aGtM9ZCOdi1gd3Jp03Q97q+25/EP22h1
	KK6VNtPBVWStvm7FyZiyGOXVG6oSglrLIXg1JTw0hoK2QIjzA95g
X-Google-Smtp-Source: AGHT+IFPiPOQaY1KHgWPlPh1sGzisOLGf9AAfVfpCEI5qluGsJmS5K6tzpQ/GW13OvscLBEx5MyQkw==
X-Received: by 2002:a17:90a:8591:b0:2d3:cc31:5fdc with SMTP id 98e67ed59e1d1-2d85617b9d7mr8324144a91.5.1725063312216;
        Fri, 30 Aug 2024 17:15:12 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b39cff8sm4449790a91.37.2024.08.30.17.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 17:15:11 -0700 (PDT)
Message-ID: <d407fa343213b4bc5990de24e0f322add91a874e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 4/8] libbpf: Support BTF.ext loading and
 output in either endianness
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
Date: Fri, 30 Aug 2024 17:15:06 -0700
In-Reply-To: <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
	 <8eaba4b675cba9035121121bba6618c9f8f65610.1724976539.git.tony.ambardar@gmail.com>
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

> @@ -3050,11 +3127,42 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 da=
ta_size)
>  		return -ENOTSUP;
>  	}
> =20
> -	if (data_size =3D=3D hdr->hdr_len) {
> +	if (data_size < hdr_len) {
> +		pr_debug("BTF.ext header not found\n");
> +		return -EINVAL;
> +	} else if (data_size =3D=3D hdr_len) {
>  		pr_debug("BTF.ext has no data\n");
>  		return -EINVAL;
>  	}
> =20
> +	/* Verify mandatory hdr info details present */
> +	if (hdr_len < offsetofend(struct btf_ext_header, line_info_len)) {
> +		pr_warn("BTF.ext header missing func_info, line_info\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Keep hdr native byte-order in memory for introspection */
> +	if (btf_ext->swapped_endian)
> +		btf_ext_bswap_hdr(btf_ext, hdr_len);
> +
> +	/* Basic info section consistency checks*/
> +	info_size =3D btf_ext->data_size - hdr_len;
> +	if (info_size & 0x03) {
> +		pr_warn("BTF.ext info size not 4-byte multiple\n");
> +		return -EINVAL;
> +	}
> +	info_size -=3D hdr->func_info_len + hdr->line_info_len;
> +	if (hdr_len >=3D offsetofend(struct btf_ext_header, core_relo_len))
> +		info_size -=3D hdr->core_relo_len;

nit: Since we are checking this, maybe also check that sections do not over=
lap?
     Also, why disallowing gaps between sections?

> +	if (info_size) {
> +		pr_warn("BTF.ext info size mismatch with header data\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Keep infos native byte-order in memory for introspection */
> +	if (btf_ext->swapped_endian)
> +		btf_ext_bswap_info(btf_ext, !btf_ext->swapped_endian);
> +
>  	return 0;
>  }

[...]

> @@ -3119,15 +3223,71 @@ struct btf_ext *btf_ext__new(const __u8 *data, __=
u32 size)
>  	return btf_ext;
>  }
> =20
> +static void *btf_ext_raw_data(const struct btf_ext *btf_ext_ro, __u32 *s=
ize,
> +			      bool swap_endian)
> +{
> +	struct btf_ext *btf_ext =3D (struct btf_ext *)btf_ext_ro;
> +	const __u32 data_sz =3D btf_ext->data_size;
> +	void *data;
> +
> +	data =3D swap_endian ? btf_ext->data_swapped : btf_ext->data;
> +	if (data) {
> +		*size =3D data_sz;
> +		return data;
> +	}
> +
> +	data =3D calloc(1, data_sz);
> +	if (!data)
> +		return NULL;
> +	memcpy(data, btf_ext->data, data_sz);
> +
> +	if (swap_endian) {
> +		btf_ext_bswap_info(btf_ext, true);
> +		btf_ext_bswap_hdr(btf_ext, btf_ext->hdr->hdr_len);
> +		btf_ext->data_swapped =3D data;
> +	}

Nit: I don't like how this function is organized:
     - if btf_ext->data can't be NULL swap_endian =3D=3D true at this point=
;
     - if btf_ext->data can be NULL and swap_endian =3D=3D false
       pointer to `data` would be lost.

     I assume that btf_ext->data can't be null, basing on the
     btf_ext__new(), but function body is a bit confusing.

> +
> +	*size =3D data_sz;
> +	return data;
> +}
> +

[...]


