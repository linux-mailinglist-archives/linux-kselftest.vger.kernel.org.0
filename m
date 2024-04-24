Return-Path: <linux-kselftest+bounces-8763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 941AD8B078D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 12:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F751C230EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 10:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0A1598E2;
	Wed, 24 Apr 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bOecWuZf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD38158D79;
	Wed, 24 Apr 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955286; cv=none; b=FCJWHOKTUpULE5MdbazFoMtlYpIyuUeyv3kCYCPm9+qMt09n6OTfvzTTAiwyWFrgfYUuZWqb0dgn3QT01cpWoc0vWv73aTDd7zrMYpsgp6OJOlAdKUGJirZs5Zm8ErSNHWJCJA+EBxMLPBgwXGjf/Prx0Ej9y+wB46e18EeHIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955286; c=relaxed/simple;
	bh=gsav1q+OWEOJtX/pSWXDQyWAdTBjh5T232CUi+Qjpqg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KqjH/fDb7h73dkM+caU2jFp3mbt9ZZF5SZAjqde4dTiHg8VqwNSnUf2W5W4K4pNZ2wnMtMpRmTzpflqvidIGd818CQ8Ch6KVVp+mTNfhFvc9xvsiAGackmmvY2DjIvick6o4Zf82wQ+fbku4cyxwy5LZj7Qw6NbceoqpZzm1d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bOecWuZf; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713955247; x=1714560047; i=markus.elfring@web.de;
	bh=rZct520GkxHWSg4fBJJGCvQQErp8qMa+Y2cRVIRPDzw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bOecWuZf3P3HntuFAd6jzLSgMN4NiW2pdxshFrw601Co4ORc86riKP8aU0Q6KkPT
	 kbkYasTJjW8k2rrN0+NqX68pwexygZsVWR6D+fzjzl2rrBG0Bz8xcVnFVvHMKA6GJ
	 i7I6vxyv97eBC4gy8+15lr6bEPm1d3/y4TdsK0d20VMBeqndSC7YA68mKKoDLbf2G
	 TKwEGLwCTFiTaFg9P4312qIMJJrnEDTURuV1gLBmkwjZ5wtySBdXeivsgL3NgMKCF
	 bSLsvyjS1fQJyaOIu/rcPK0k8m1h5hzfd2FAHu3kWxY/BhgKw1hqhrL4SsfDVUOA2
	 A9zpvIq0s4MLXeOT6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR0J-1srY5K2o4L-00sA6C; Wed, 24
 Apr 2024 12:40:47 +0200
Message-ID: <94b34c96-da3b-44ee-9d7e-8daadba52aa6@web.de>
Date: Wed, 24 Apr 2024 12:40:42 +0200
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
References: <20240424020444.2375773-4-chentao@kylinos.cn>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Add a null pointer check for
 the load_btf_spec
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240424020444.2375773-4-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xxCxRGV5wfBGsiC7m2RkEkH+vBPfmQhlEtFngofT2wXCyKxvoOo
 ldhyXJ1+fr1rh1HBJ3RCfeLhoaWPkng8IVsJ00riwBiPfx5TQ0Ng3836wBHoBx+Zl1KPH7d
 ogCIM/rDvpYOOqcsHTDY6q8/Sxj7Hqi+mhfGY1Uu7UEiXxvSo33HhET3ZSb5//POb/9iV1d
 B2lQw8OtThP87oCtyfD+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iKQsKfhqij0=;BCBZmIUY3JHFGpTp6Fp5sVT606A
 SmjWFzy5tu6Ka3klf9Tnlpo1B/hJi5x3dFuRkJSZSS4jzEy0WqkIX+HIlXf/g2OzqIZM9oQ54
 NscOy5igVn5e3GXPXL4zDGgcUboLGGTrl35A7c1UwbcS9pJybw+Mx55Te0+wGnXjsQntNpe3b
 dHruKg38SPOAVJ+U9ORFIqb6jlmgLA0ug3cAjIE28TG1GWi4xWFN263csmTsyZesg/7tLVmAF
 dmu9M2ZVIfxqeQWkc1Wzns7QZhC90+FdN9ePYQQOM0ZUbGGbYLWPbv2GEfb02c8WnohG2WfmP
 LNBfMAtCM9gOkIO51FW1IfZpzww1cl/GwcOjc74BWhTJ2BeCcc0T93bz6tFvJlfKNfgOMHD6N
 vjTvJoUKm+gPfvZp00uzF8r2zi4g4pQoVhAA7zsiERUWeC4eKwHZuHANe2EZk56YI5BnA/vwC
 mMfoRi3svAcjxYt/FyfA87lU18us9yY2c15DiZXd2tzosb3ByMuRv8cb6H2klkUos2pju07Y+
 l9UPluL2GFe/NLia/MokMOUGapBVqAxy//9v0pKWVGt9zCu94hwqdLOW5H16owHWRfSSFPomo
 nGYC6CyHoe3Xb6xti3kLwqZDLIaxnWW51Yvh1rI9EzbGwCObrvj36bUyp0LJWNug6o6/hoVKC
 rVD5dapFoTx/ym8fi0qQXodUX8amP1fK4M8cZVXQ05r07ID459NegPRevOpkEQvX85My7AvnV
 zKcH+kqQla/bXMxYkihsoSmWeL+DAfFpHAHemEP/VfaWVOIc9PqJln3oShg9krYAQEbk0kXqE
 fyMVERCMuOqHkLcEP14wmhtN5YHIVfftz1dnuEyziQye4=

=E2=80=A6
> Add the malloc failure checking to avoid possible null
> dereference.
=E2=80=A6

How do you think about the following wording variant?

   Add a return value check so that a null pointer dereference will be avo=
ided
   after a memory allocation failure.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


=E2=80=A6
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -762,6 +762,8 @@ static int load_btf_spec(__u32 *types, int types_len=
,
>  	);
>
>  	raw_btf =3D malloc(sizeof(hdr) + types_len + strings_len);
> +	if (!raw_btf)
> +		return -ENOMEM;
=E2=80=A6

How do you think about to reuse the variable =E2=80=9Cerrno=E2=80=9D in su=
ch an error case?

Regards,
Markus

