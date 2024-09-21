Return-Path: <linux-kselftest+bounces-18192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB7597DC6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 11:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676E61C20C59
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D61552E3;
	Sat, 21 Sep 2024 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjbpTE2y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99314E2E8;
	Sat, 21 Sep 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911522; cv=none; b=hX4MuyUl5Hhol4zI+HlBvxZexNoOr5sggCPDAJ0a8efjbHdPoKdriX2S6sfle8BmYFy8cqIjOQ/7rXwZrTL8yZnaXZ54RmaUO+e0LS9AOgBIAMWt15RpyrJ+TU8zAVk/BPIreueLE4CydIA7Im3P+UWs75wlz5VguKpMoW/1440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911522; c=relaxed/simple;
	bh=JkjNhDr55OLb+jeI35K4Z3OpsFm8x+i1zsWk6ssHI2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLCAmkpEjdJeoEsN2aaZoY2QsXOuOuhrhq/efde5flrqW3m33l1I0B1Np4DBc1ByaY8GqPhqM1cEdzMZ/uoe54uHUBDB4rfTzwKTUTuVOPePIgmw87qsCQDCYfhqE4Rkf/DCHPfSGN7dD2KiIwnwN0nJ6fW8gdPyv6UZuDBT6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjbpTE2y; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db238d07b3so2303317a12.2;
        Sat, 21 Sep 2024 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726911520; x=1727516320; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JkjNhDr55OLb+jeI35K4Z3OpsFm8x+i1zsWk6ssHI2U=;
        b=UjbpTE2yZ+9nCVE90XckxNC7Uow3ulFMX+nnOBYENoGqecQ+1hFSW+Plt6wmTsO/eO
         qh4rfKx8bZC+5SAQJoa2MiWWZxTTThORScDTAP8yRxIaCWM8AUPP7E9b4PRq6r0llNfb
         d30dY+zfkF7QULvCdCmHmcibLTQOCcAPZafi95vjz48f9+ct8+k7/ZM4qqpQEFtUKQzk
         9l2G6AIBdP+MOLuDgZNKdAZ+0ZMqC4OpIpRn6PIEJ5oq6674EFd1q1wqveGqHW8deo3v
         pC21fdsaK61pXI5x64K0aNEURaUumRU/Vvb2mES8PQ9T4F9bZzoOlJUZ/CRmakvnehLq
         gCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726911520; x=1727516320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkjNhDr55OLb+jeI35K4Z3OpsFm8x+i1zsWk6ssHI2U=;
        b=GDwLIyXtOTi32V/Ihg+qqxuhWjlMnQ8lPy8CHxUuT+so2SDetNYNa5gTw+lv167tSF
         +zX4PWL4ATQu+3rM0Ikjx0a7FCwwN3nPsGHixjnta9zk5Vla0ABUFeUeq8biw2qjfCN5
         y0HHMap7Moa5DvsmkMXOPGTWSayU9aBmZhgfoD6Z0oCYtnvZmV7Xwl2nM0ui81G4hcRQ
         bHnjrIsfTLyo4Fnllt8S/m5uC5sdn/EDjMM59ECchbYArF75XhR9Y3XQKPM/yeW4z2q5
         /1E9RjmV0I7J6m3ynxeAtH01tHmtAKW58P0I2OBq/13nnSkOGdegAMWwBiJTx13yH88z
         5z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY9Bf3O4kucWVyz6OdS589EmJMdIQtyi1QJ7vKoqHFQ/MS4olmGVU12dFIhTNGBCv+T1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx45uKypmdR73MAJC6FOAVsNUcgWAKNpH29j8bNNDDiS0p8ZhD
	bm88JO2c7LXEvyfdA+ab0yGaCgREttpru/E/kNqN6kqsta8Y+Ltu
X-Google-Smtp-Source: AGHT+IHmB78/avhL0iTmCJkqv7Y4j9+6SSTH6TtBx3MmoG7zrihdHRri+ChzxmCZXBzFdm1W5n8rjQ==
X-Received: by 2002:a05:6a21:170f:b0:1d3:ba1:18f4 with SMTP id adf61e73a8af0-1d30ca3daf9mr8060316637.26.1726911519837;
        Sat, 21 Sep 2024 02:38:39 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab54ffsm10951754b3a.59.2024.09.21.02.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 02:38:39 -0700 (PDT)
Message-ID: <046bd3a7c0764fa8165af7416bb955256292ed91.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/3] tools/resolve_btfids: Simplify handling
 cross-endian compilation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,  Shuah Khan
 <shuah@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Viktor Malik <vmalik@redhat.com>
Date: Sat, 21 Sep 2024 02:38:34 -0700
In-Reply-To: <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
	 <609abfededc3664da891514fcd687990547b8be4.1726806756.git.tony.ambardar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 00:49 -0700, Tony Ambardar wrote:
> Initially, the .BTF_ids section was created zero-filled and then patched
> with BTF IDs by resolve_btfids on the build host. Patching was done in
> native endianness and thus failed to work for cross-endian compile target=
s.
> This was fixed in [1] by using libelf-based translation to output patched
> data in target byte order.
>=20
> The addition of 8-byte BTF sets in [2] lead to .BTF_ids creation with bot=
h
> target-endian values and zero-filled data to be later patched. This again
> broke cross-endian compilation as the already-correct target-endian value=
s
> were translated on output by libelf [1]. The problem was worked around [3=
]
> by manually converting BTF SET8 values to native endianness, so that fina=
l
> libelf output translation yields data in target byte order.
>=20
> Simplify and make the code more robust against future changes like [2] by
> employing libelf-based endian translation on both input and output, which
> is typical of libelf usage.
>=20
> [1]: 61e8aeda9398 ("bpf: Fix libelf endian handling in resolv_btfids")
> [2]: ef2c6f370a63 ("tools/resolve_btfids: Add support for 8-byte BTF sets=
")
> [3]: 903fad439466 ("tools/resolve_btfids: Fix cross-compilation to non-ho=
st endianness")
>=20
> CC: Viktor Malik <vmalik@redhat.com>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


