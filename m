Return-Path: <linux-kselftest+bounces-17062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B66596A7EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 21:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0801F24D01
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5E1DC75F;
	Tue,  3 Sep 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zv7xUlln"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF431DC72A;
	Tue,  3 Sep 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393485; cv=none; b=R6KD/FhXEelryO6W/kGpiSesvu/3IVq1mcc3oqRdf+SYRjDTVe4JfTVfhiVWEtIFFBREDbbE9TlQqEold1ytMb+8lqXhusbeSl8PQHtkFNb4fINahk0/nQwznnIxItTVd4HhqoMBw/EhzqPyz3eGASVBcdiZcZreXZ02+GFyQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393485; c=relaxed/simple;
	bh=wtjGqHHvd2/j2Wu75kdp0kbxGh4FOqObZiQjzpieIqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hp7fohZdO3EycITVFDIMGNBEeBAe/C/V/Hua0J987cgIRi9vNb/X+tb1F2HQvXiQ6+oAtxxgs48RH/W4qqCdvLbZ4KEGquus5HQOBdokyfP9vv1+5YTgHbTnEE9pzEtafqtSqql/VVJbDN6GrgEvphlvJ1bY+ySVWuG/fG8q5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zv7xUlln; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso47119265e9.1;
        Tue, 03 Sep 2024 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725393482; x=1725998282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z59Yuc2r3YSv/otl+hkiYhoQvmmvIek9teuW7R59/6M=;
        b=Zv7xUllnmev+wCatSK0FaYi3Nf2Mt2vdN5mAUjlldlmj8ITDUxS/XHHHTPElHq+Y8L
         aKs+dc22fDU/dRfFqtgAMD0LuzTJoFYK7FaDoioa1rRAVrmJu4+A6htAdLGUo5uvI7wI
         AAbDV2hv3rjTop9DO1jHTubX+jWcByseucqQBsHvTNeEyd8XggtSZKbxnmodmJhDT2sv
         70D/LoWrBFNtanq+5vJrDCDZNHBrr8M2Q6Xw3EmFUCUU9JSjXQpqvB2ecKokfUiCmrq2
         j+fTGcsrllv2OZJV2GdDnlrtmG4Q10H2wdqhzPAHSY3NOBocYr4XRcXcoUIEM4CevUGP
         dMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725393482; x=1725998282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z59Yuc2r3YSv/otl+hkiYhoQvmmvIek9teuW7R59/6M=;
        b=t8vtXWh491oroLr1zoPZ4xxgO9ISh2ayqD3a+yvRtl7VZ4RPUfhvK2uYI02rOo6AFD
         Lb5WqDkTpTvb5jV+Qn4/vIs6v9Yf/eLLK4XAXTvPMjInRWsvTRagbIe/6aWM0FkTNxkO
         oyHbRzrvEDaFr+0TEtsL0nCicqVx9oFpAav1qnRiCbPqexQSrO4mjC+RfbCJjAKyfws+
         IKW5fvbdx2BUysMmKzPu6v7Ml4z1fIt2q+CHNgi2oqxhsWqAvfyG5lMeLPQsCE1mR+sP
         CzKU5H+1nwN6tndnx3clKXlmbnIkVdqqtyhrEtExWGU00wXB8shurKWxACu/8Mxqiw9E
         5YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxZXRMls3rMzCp/Dgxd9E9DLGMa+0nT17xvR1eq6S4GAPaqTJqYstnJ0w1ApLXdp6tW+ZaFn9VskD8Z8hVEAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4NFXnxYUoO+mTle+lxUa5JrXTTg4iNzAVaJPx/p6UA+MU4jX
	9IkSsSjofsdPSzHA2Dj857psyq/Hbpd7pDoJ4p3662Hn/BZTDFxfqEvSnT2jMtfVdmhXvOj0AOZ
	s/a9JQ7MIIO29yiuNx0QLJ617B8a7X8qS
X-Google-Smtp-Source: AGHT+IHFBw9Lfqy2UcC7N7zmPFPf7bSAq/mhTgyaOu3oowAh7cxrhi6k90/p92zhRV8KsTrYpp+xdgucCMclh4xtJe4=
X-Received: by 2002:adf:e604:0:b0:374:ca43:abff with SMTP id
 ffacd0b85a97d-374ca43ada7mr5069631f8f.26.1725393482116; Tue, 03 Sep 2024
 12:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725347944.git.tony.ambardar@gmail.com> <2b2895eaf3c6ce53397c9d4c8f53d94dd817b398.1725347944.git.tony.ambardar@gmail.com>
In-Reply-To: <2b2895eaf3c6ce53397c9d4c8f53d94dd817b398.1725347944.git.tony.ambardar@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Sep 2024 12:57:51 -0700
Message-ID: <CAADnVQJeQvKJeJpJVh1BkrkHeY6WOaNFTh4sru-H3=ecO=qd5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 7/8] libbpf: Support creating light skeleton
 of either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:34=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> @@ -1040,10 +1121,11 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen=
, int map_idx, void *pvalue,
>         int zero =3D 0;
>
>         memset(&attr, 0, attr_size);
> -       pr_debug("gen: map_update_elem: idx %d\n", map_idx);
>
>         value =3D add_data(gen, pvalue, value_size);
>         key =3D add_data(gen, &zero, sizeof(zero));
> +       pr_debug("gen: map_update_elem: idx %d, value: off %d size %d\n",
> +                map_idx, value, value_size);
>
>         /* if (map_desc[map_idx].initial_value) {
>          *    if (ctx->flags & BPF_SKEL_KERNEL)
> @@ -1068,6 +1150,8 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen, =
int map_idx, void *pvalue,
>         emit(gen, BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel));
>
>         map_update_attr =3D add_data(gen, &attr, attr_size);
> +       pr_debug("gen: map_update_elem: attr: off %d size %d\n",
> +                map_update_attr, attr_size);
>         move_blob2blob(gen, attr_field(map_update_attr, map_fd), 4,
>                        blob_fd_array_off(gen, map_idx));
>         emit_rel_store(gen, attr_field(map_update_attr, key), key);

I don't see the point of two pr_debug("gen: map_update_elem...
just a few lines from each other.

Other than that:
Acked-by: Alexei Starovoitov <ast@kernel.org>

