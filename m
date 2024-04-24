Return-Path: <linux-kselftest+bounces-8759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7198B0624
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6009C1C23E2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2F158DA8;
	Wed, 24 Apr 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DIpPQKgs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF9C158D9B;
	Wed, 24 Apr 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951404; cv=none; b=pXMzpMHBZD/a49SaS/St6L1cKhDnuhQjLok+80s/rb7jYK09D4AQ4e6Uq6ilx7J8sNHHzP3bI6fhmmHBQ6hGK2KCLZxVUljI/rY/Nj47mSXyhn8RLE40NiPilPzhTKQy9LTFjcuL66jqAwdpAAAsRmylpm/+zfEPBnsWgUPNBoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951404; c=relaxed/simple;
	bh=EOuuqx5APoTiCyWYFD72wurnUoAW5aLlNM0SZgsEr6A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NXQbPyi4VzRZ0yoO5iwIKmzob3uQETrAvR2Ds6NbK7SeGTfjoDDCC+WeDewS8LyaR9sJA2MwVWc59S7AiYwM6aRIqT1F2GdtwlhDXlDT3xq8a6ffqaTVDtp/G/f4eVKyF9IF4i019bptVfUDxlBmE2LoXffeV/57Hn8bhVeFPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DIpPQKgs; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713951359; x=1714556159; i=markus.elfring@web.de;
	bh=31rAgjHngaD889kCV5k32USNySx0AzHBj1I6Gm8civo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DIpPQKgsyIZhVxeWiDtvEbF+q1G+89r4b3gYIO391LDU7h4fhzTMJIPzrIjlE/KF
	 hakYC/MQYeuIICHjfJfKo19YlwAI5okz2J1OXEEi9iHmXtBzqNCpb5nqM1YL4QUV2
	 jBI2o+fn7ZIqXGwJzGy1VVP/uRv3MSNml/2J+yVbd6GFi9LsmB+LI80qqA9vS4uI6
	 jX7bMUTLlGI98KDKS9hIgYaFnq0B3Ho96282higKowzbkyJdZWDEnO0CNNxcl5CII
	 cZVGKpsjxxw502/Dgh9tpb/5Qqd6KGj/MURcRtuM7HnQdj1/t+HwxDamdIdfdbzds
	 QbZnNsf1fgnNxEZ2bg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1sKwAj08DO-00OKSe; Wed, 24
 Apr 2024 11:35:59 +0200
Message-ID: <33aab745-19fa-47f1-9d0b-863e88b6548c@web.de>
Date: Wed, 24 Apr 2024 11:35:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20240424020444.2375773-2-chentao@kylinos.cn>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Add some null pointer checks
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240424020444.2375773-2-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oai8gOQxsIF/hOcUCafWVOxUgUMxjYuqXLEmnSKhJbY2Lnw7Xu+
 A9q59P39sHV3YJST4bLIGeDUNYwXqRX4OahVFxyelkpmTLP4utPSlLHf3M6xzKttwUOkLhe
 dVNr560NXkEGUiYOpdoUEdCBJxe3G0UL3LZn35jzGGQcY9XGylmrKk/4flhhiWoNVkCLzm8
 PzBnnG8tXhXesslMvLIig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bg05E1BxaFg=;KhLN/NpZF68ZfUOe1TSvGUFsRz9
 yKhOgZM2TwHifoj2Z+3g/xP3fZlMyHlTcz4zQLf8rhvX/f2of+epc9fix2CC1mEhTzV39tKiT
 /ihKYN17FQc9UmZ1yU9DkSHZWl1oNDCR5Btxyy2w+5yyGYPuz2kuL5fHJ6PvltPzFYpsNyFZg
 iMMrji3Jxe0/nPkR8exa1xuw/fyw383L7MXfwdGG/C8VWvCGj6qJO28Srkac4af6cbOefH2BY
 pY4VaNkMIWaaPedWvN8GQt9/wcSUMd+StHfoVbsQtzrMAtH0kCGVV5f0CJVcJkPWEQXs5P9i8
 Qypu0b6T14MNoJJyiV4MdDpHRDjMwig8vallNUoWkzQh/yOm+jpXE/ljlzrw8EqDzvAanD+cW
 x4sK2WVT6F1rqwTgVEkMlTi2Pxac0f9nqsHwW2ioKib5i1HEmmWo2x0xjHIOCp8csmUCAV3mb
 L4ojJ/oZkgMb4JP/5QibdodgjKxRs5kAhWkZvKbM93sI55Fb99OfXju0APopkS+m1KNwvqFqB
 RbS2InGI3RV2Rbj/DWmdiQCZ8gnurb+58TO3BmzC1znlRt0d3OdRrjxq05p+0zLA3Nfs5RrOD
 vgFBxUqZ0oWfS34ZI6ICGFhcKWjd/QUf0b/HvEFsZd79yB5OgfYi0JeYbE/f/2a6dWvx8u2sl
 GX3jLt2K0k7M9Ye5vz27lbCyjNDoKdtg9QoA32ffSw+32oFQRioBQZSBz90cnKd1uo3T3uK/j
 blrmTur4FtfH5PP2CdUcXeVHqB4Oeo+JBEg6oQ4GyXuqDBuNCFtOZxBhE8VfnBHQ1zYKM6wdt
 +gSMlG1sFsKEydUj6dnG2aYflI4ZXmBLV3cQcfaAjTZNs=

=E2=80=A6
> This patch will add the malloc failure checking
=E2=80=A6

* Please use a corresponding imperative wording for the change description=
.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


=E2=80=A6
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -582,6 +582,11 @@ int compare_stack_ips(int smap_fd, int amap_fd, int=
 stack_trace_len)
>
>  	val_buf1 =3D malloc(stack_trace_len);
>  	val_buf2 =3D malloc(stack_trace_len);
> +	if (!val_buf1 || !val_buf2) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
=E2=80=A6

How do you think about to reuse =E2=80=9Cerrno=E2=80=9D in such error case=
s?

Regards,
Markus

