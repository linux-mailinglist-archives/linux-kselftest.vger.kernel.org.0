Return-Path: <linux-kselftest+bounces-18193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F5397DC72
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 11:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1DD32819E1
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E21547DB;
	Sat, 21 Sep 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt5zMXhI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421DF27466;
	Sat, 21 Sep 2024 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726911984; cv=none; b=N5ZSpcY07JpUziZTk+wXlEdRbEqQzoPtEys4x5Fx1XvYm+Jhfoe6HmYTSJGGG5TpTZE1J9Fsef03JyK03l5KuJmtT3hmvZbOH+pycN09nS16F1acnfW6Xcd6u+nytI8P8+Ktv1dWY0ys5bFC+Z/20poll0bnT4nXBPBHgILDxyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726911984; c=relaxed/simple;
	bh=xsmrxnEre+MO6f0vdl60EMeX8LxAXNCCPU4qmncvAiw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WFwInCUKykuM/A98rTpkLTUyeI+21MpPmTly2Arxsb4+4H8aQDp1GLeKo42en5u4aoYRBreWuQBxWgictXEvhHK0JkbpOc9c9w2SRPDFokjXkkEX9aZc+5yzaXFeKsux4JRyQpsEm+1rKvghTHUoVfgM8UMBtQbfanT+oMh0TnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vt5zMXhI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068acc8b98so27811105ad.3;
        Sat, 21 Sep 2024 02:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726911982; x=1727516782; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4sp1aw4XFn+SXwrfveH4irHgkvxn748h6tzzmOhLtBI=;
        b=Vt5zMXhI808QlKHNaI8l6nCxl0JdqBO83aDThiKdKyhHujS8Ds2UuhLwywMmu0AjYD
         3eQT6Vc20C4ZdzZeJvvAqUhfsrkB3lMQnW0YdPVIKY/QXCOCMeZAIWYb8SgH7gJrT/gQ
         HLpskUDezUc8PzI9sSFFx8PRBj8c44FKs+ltY0qVIO6Pnzo20EVEwfYRFjck3ysNoqbL
         /IiwYA3SSI5VUVPCo6YfpWonUvDhK4emWFuekw//zP5qQ6Gfe87RfLr+2gmfh9MiV9Ad
         p8YX/7Q8BGlUXXy5uVszCSfTHFxf5lAKA5yDdIyDug/fv6Kdq24dfuxEw+0AZKidfAsv
         G8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726911982; x=1727516782;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4sp1aw4XFn+SXwrfveH4irHgkvxn748h6tzzmOhLtBI=;
        b=gDyoczLMeKnvPeak2+CZz1b0xL+vsVtgIqbHHNKZq+SGvsExTNJ4ju0+0QksAAKTPe
         HyIzgaWJ3pPum7hlFLaXReG6R1GS6PTQZKVt5l6/+H4aa//Jr7y5ejkWwlEbwKaidKJH
         mrPre2soSIv/Z58y+a/TEg0XdD4iGkJnVVeGlbmgCPQ1lY0AAFIMkjKvbbQvRvit4n4r
         eaYer8V3ljlftBhAKwcSXQbQQpm31IdjbGIzlLpd3MaQLJf1ZFF0GexWH3F5qtatnCs/
         aCtfSWS+eYuEaq7DhiuAkl2tMYUbUeZahud1Nn6Rd9dKFxT+64UMeMo/6RwQimxKvXwT
         rb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3JkMixMjAaK33+zemuUsaLlZr7GzCpyEqz73gvtUgOKJsJDi1MQT39OHUiJRo+TnCacg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUJAPF9FpSrafEz62XFlYqRoTah4mNfPMWYk1X1/3gSY6qYPO
	x0D5kcgu54BDmEb5ULTOXCc7uWdPcBrKsX+JWJwf1WZ98+gTkOyP
X-Google-Smtp-Source: AGHT+IEympPNcdMw4jqvHuWixRDtlbR944ebyeXZZw3IyTUjJegt/IT9+cLmRMloe3/Cbgg/j/ghyw==
X-Received: by 2002:a17:902:f707:b0:205:83a3:b08 with SMTP id d9443c01a7336-208d83da086mr74867115ad.32.1726911982410;
        Sat, 21 Sep 2024 02:46:22 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d293esm106462445ad.167.2024.09.21.02.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 02:46:22 -0700 (PDT)
Message-ID: <46d8d74883926245829f8aac3d1ab6dc5b5e4b98.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: btf: Ensure natural alignment of
 .BTF_ids section
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
Date: Sat, 21 Sep 2024 02:46:17 -0700
In-Reply-To: <714d7ab8a48172c67ddc027c85b2a0dad0312a74.1726806756.git.tony.ambardar@gmail.com>
References: <cover.1726806756.git.tony.ambardar@gmail.com>
	 <714d7ab8a48172c67ddc027c85b2a0dad0312a74.1726806756.git.tony.ambardar@gmail.com>
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
> While building of vmlinux employs a linker script to align the .BTF_ids
> section to 4 bytes, other usage leaves .BTF_ids unaligned and may lead to
> problems (e.g. [1]). Post-processing and libelf-based endian translation =
by
> resolve_btfids may also potentially suffer from misalignment.
>=20
> Update encoding macros in btf_ids.h to always align BTF ID data to 4 byte=
s.
>=20
> [1]: 3effc06a4dde ("selftests/bpf: Fix alignment of .BTF_ids")
>=20
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  include/linux/btf_ids.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index c0e3e1426a82..c10b163dc340 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -89,6 +89,7 @@ word							\
>  #define __BTF_ID_LIST(name, scope)			\
>  asm(							\
>  ".pushsection " BTF_IDS_SECTION ",\"a\";       \n"	\
> +".balign 4, 0;                                 \n"	\
>  "." #scope " " #name ";                        \n"	\
>  #name ":;                                      \n"	\
>  ".popsection;                                  \n");

This forces all id list symbols to be aligned on 4 bytes.
Should the same be done for __BTF_SET_START?

Also, is it guaranteed that all btf ids are organized in lists and sets?
Grepping through the code it seems they are, but it looks like resolve_btfi=
ds
does not really enforce this, simply looking for symbols matching a special=
 name
__BTF_ID__<type>__<symbol>[__<id>] .

