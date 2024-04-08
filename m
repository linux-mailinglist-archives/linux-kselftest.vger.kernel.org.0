Return-Path: <linux-kselftest+bounces-7405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E9389C704
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324381C21651
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DF9126F19;
	Mon,  8 Apr 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxE2bPgR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D26F1CD21;
	Mon,  8 Apr 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586307; cv=none; b=SuwLYuAO7hur2+R5YJSE+JgC/Pk52ZM0CyR+roelZK7Fqj4k3gxc7oJLBo7urScNXm5h98xd0zNH6gUHf/5+QU0W69y6Ap6WrqyewPI9TT0jbLAI1GBRCp/LI3X38pB3rh/MPa0pnCRIQOxAi0V2E1ugPS2lWKsg+YbhN700RIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586307; c=relaxed/simple;
	bh=vs3XBmNffGkP+0cG+4YcsNFdxxYDgMGq8O2+X1Zb9Vo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pFfKgQB1CugkIMPnsN4r9Tn/O2yGENO6K8rC3famannlJMlkNhWmRwqs3eaHKonOZq0LnLoVAW7GNVmiXPHvCOXjgwMRLGIM+LoJid0xPuiSxmTO0InAbBkE7cXCIoyA4gjxVVP0xMaGjYiaUUNOZZJASPmHCdltRxgJmhdVTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxE2bPgR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a47385a4379so1019907566b.0;
        Mon, 08 Apr 2024 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712586304; x=1713191104; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJ+zuBcV+sKNJnkujCJL6uqR40a6L29gK2qouWWtUE0=;
        b=QxE2bPgRFF/0FH43bYbgxuiApsO6WZLg/rgVUHCanLedOtKN4sG1LtdpQbs416ulOa
         5brihBK4Oyz+wo5CfDhXdH1XlOGue4K55kvotAz2aK4Xm2ka/jYNbEv9WWzaRfHhDFcb
         W497Q4yQkXjEXgX2EcIAgfIYfhpkG+Caeq/oUrXu64/hpwOoAA/1mq+VTI9enKVWiwN4
         kQZh//CEGBZoewO/nL/rTYpWm8CzC7TperXoptCSH+F4yT5UPael5JxUxyw6tQ23TbGr
         P55atkVwPgIRO2NFKqasvd6zl5PP0DskkQNz0Ow8xI4mBFYk5vnjOKuUAS2Flfp6mtn3
         H+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586304; x=1713191104;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJ+zuBcV+sKNJnkujCJL6uqR40a6L29gK2qouWWtUE0=;
        b=CRhfYR0ff6ViLiLzxAhFsTWK8O2zd3R90T+UZhoHYvpmq/oA0bRX9jE0w+KT4J+ay4
         72CC0MoCrnltF/CdzxB2Ed+eb0I97yzG38hZVKf8u/v/ytyq2UNJvhZD4Vp7LcsiZT9o
         rPLhqCGaMJGkMw2t0M5L34ko0CiX/Xx5AxnZ5yiYkFQoFfyRye5F9wQufbOJCOJXGqpR
         QnheGICRpAEcoiVVzEq2rlqRnxjbK7gDWBiB+J3CdC+wrlF4p0QQALP2BA+iq8TjAhc5
         WBqhu1f1l0pO8hrcE5+EEjjm4nE/9cgsNBSSZCeWllDMeErcBxmRRTYcJTK6VP2m0Pv3
         X53Q==
X-Forwarded-Encrypted: i=1; AJvYcCW68jXqYq5TTzqyqPGcJFAJwQkybz6VbgLallx9oUmNo+Z6F0yN0tai9zaiZ9hVfpE+jwGbqQNeCUvELyXXYyH8XIGqFduqFRjEtXMnSMbSzogELvhRFuNJ4jzB9hOmFCkdKxfsgH2VgjXKMvJx
X-Gm-Message-State: AOJu0Yx0CW/iX5mwpnQD5s1r5WtQd9cILtRtjABu2V/DvLiWtdDwaBjU
	oN6JhZzQya72bCj1oM23RMDaiNpwbsCYyvduk5kIQ6C5YoskIbVv
X-Google-Smtp-Source: AGHT+IGaq+ZAlXpk9YTgf4/RHBm1Pbf2Q7kE8VkemDhXnN6qOn8H3/zT0wzSorfvRUiTWwzaW7mkBQ==
X-Received: by 2002:a17:906:7949:b0:a51:d48e:52a0 with SMTP id l9-20020a170906794900b00a51d48e52a0mr3012741ejo.27.1712586304338;
        Mon, 08 Apr 2024 07:25:04 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id lx26-20020a170906af1a00b00a4e440989f5sm4487554ejb.159.2024.04.08.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:25:03 -0700 (PDT)
Message-ID: <ed027c1d54cb588914602a84fa12dfb2a9a403bd.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 3/6] bpf/helpers: introduce
 bpf_timer_set_sleepable_cb() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 08 Apr 2024 17:25:02 +0300
In-Reply-To: <20240408-hid-bpf-sleepable-v6-3-0499ddd91b94@kernel.org>
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
	 <20240408-hid-bpf-sleepable-v6-3-0499ddd91b94@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 10:09 +0200, Benjamin Tissoires wrote:
[...]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fd05d4358b31..d6528359b3f4 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[...]

> @@ -2726,6 +2764,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +BTF_ID_FLAGS(func, bpf_timer_set_sleepable_cb_impl)

Note:
this hunk does not apply cleanly on top of current master.
The line 'BTF_ID_FLAGS(func, bpf_modify_return_test_tp)'
was added to the list since last time current patch-set was merged.

>  BTF_KFUNCS_END(common_btf_ids)
> =20
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {

