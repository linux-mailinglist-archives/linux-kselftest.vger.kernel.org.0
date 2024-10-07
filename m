Return-Path: <linux-kselftest+bounces-19137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A279922BB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 04:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006B61F2189F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 02:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A60410A1C;
	Mon,  7 Oct 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVIWLrYE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC4107A0;
	Mon,  7 Oct 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728267030; cv=none; b=swjtZWUHU+t6N8KjHCbrB1zfTALeDkZpXMsg0op3qZBYN/iPferHlMgTPigMRQyOTrDrP5PwzmkyKowapjwE+U+k2CfoOXH82MwTRFO2B8jVYIMNV4RACtz7OiSaQoVquHbRj914IOuyTkg3aYecKQLoaESq6l0mMNzv2mfrJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728267030; c=relaxed/simple;
	bh=yZ1zBFogNIKvyg9xjP8Td6/A3furt6LhWj8WEmDAHr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTQWt3m3Vu7gotxkZpSmjSZdMepP3/Zl9WDTpn17eNahOe25RxMzoCU7Lpum0fNRlDs+JafOuy3feiI0XUu52OMVvpXjP3H+uLUN6JME0LLBBWXwNiy6/3avp0ZXHE6jLJAb2cUUzTAvO6mHN9Igf7AGuo71Eu2AU1rMmBeRyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVIWLrYE; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb2e136da3so28005546d6.1;
        Sun, 06 Oct 2024 19:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728267028; x=1728871828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/aKxXnYNm6A5cCDMgdNRGS8OlNNh/qS57hy2iF5bl0=;
        b=jVIWLrYEmPMnnb9VbaoxQMCaDBGmRuxFzthgmFXMUADLPqeoftQeWcWRoWTSzZlQNl
         tlrCFGkQVWnNo0E/vxil1p3WLNMx+P9SlOeWiAST5yGZTAw5wxUlsfjuASiHu4MD4sTv
         oTctbGcLrgVmpSm8VCFhcFouZHJtjs8jIRY00hg2M7ERfvy4ZydDKrGu6dxT0A5ubrGR
         Cze+muYIJjJux9SAxd24qZ267knQxvNpRww5WYEY875YNqMMzSGqljX97waUKZXZl4in
         zFM3a9DNHufQXHgGbG9qPr+V9r2RiCuCbu3rzFr2tquys6JYf708sng7TbkTQZjnGBCF
         yWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728267028; x=1728871828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/aKxXnYNm6A5cCDMgdNRGS8OlNNh/qS57hy2iF5bl0=;
        b=pBDVim48kVeBWisyATKmyP5Akfb2jcZhotbgWSIciWb2SJeOyWo+LaJ+qiSEIAKuWY
         qjA3wgIRO45LZ8noIX3t9iwjNlH6Xi9XNhSWIsvY5KEiQ+eBxP3CIRIP3aI5//90KgVQ
         Yavo+ewuDAKsaVnVDVfPrK3WfsN/IcmKrhuJdWQzsKrzsZffWvyR2E3135Yx0ROWKNha
         Aq3F/ldjIrI2YexgRlPnbELif8xEy1CwRHuaIOAIV/CqbriSXhAFZjxBnQgPn4ZeA0XW
         nk1njP+e/K/zufnqLjc6Xe5bf/mcIBz5m9qWCDnJl6kI7NKhGL91KKF98nWymQDhwlZt
         99oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1SOemnn2OIojA80NH7kCry69UQF96TbyyI6NQoN0kpXHkW26Z9aptKpXv8NrrrQKamVg=@vger.kernel.org, AJvYcCXdslVRx5kBz1uT8cyNkEPKfDVshCjItQc+wMpQrhHY8gE+u4VMYiMyXRSN8Gsemo3vxyJKiViUgPnikDsXvOQu@vger.kernel.org, AJvYcCXfY/U03oQERBHIpU75Ht8x2Yvn3t/qOvZ42MkbM7Vss9eYLH6tmR/n9JFBMkrTWhOW/oB+UK9W6maUCDhX@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPRvAh3AEwaVfVRaM5BTwMPJ6avvSF514XGM0JpjEu8ttYQF4
	VyWCZLoR5QFSC1m7BwMmGLFgHbgv1qwUFjEQRqEV0/ctl0FllcBBmH9BJIuqXgEWSWiKIkNUbNs
	q8c2vUC8TPGxNf7Z0aL3c3Gy2kDw=
X-Google-Smtp-Source: AGHT+IH7Xb5zoaHYjgmL8oHqbYwDDzlasvVqvaFeu/JzMtBqll0+kUeek2OpxOncdhxOJ1lhv/4OxLaAL+0Mb3P09es=
X-Received: by 2002:a05:6214:4302:b0:6cb:20f4:30eb with SMTP id
 6a1803df08f44-6cb9a45fcfdmr175865666d6.36.1728267027917; Sun, 06 Oct 2024
 19:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbC5xm7Cbfhau3z5X2PqUhiHECNWAPtJCWiOVqTKmdZp-Q@mail.gmail.com>
 <20241006195131.563006-1-wudevelops@gmail.com> <20241006195131.563006-2-wudevelops@gmail.com>
In-Reply-To: <20241006195131.563006-2-wudevelops@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 7 Oct 2024 10:09:52 +0800
Message-ID: <CALOAHbB4Uce_3Vm78DNonPv6Bx8kx8M6WUp2bJY8fdLesHmLEQ@mail.gmail.com>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: fix perf_event link info
 name_len assertion
To: tyrone-wu <wudevelops@gmail.com>
Cc: andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kernel-patches-bot@fb.com, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com, 
	olsajiri@gmail.com, sdf@fomichev.me, shuah@kernel.org, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:51=E2=80=AFAM tyrone-wu <wudevelops@gmail.com> wro=
te:
>
> Fix `name_len` field assertions in `bpf_link_info.perf_event` for
> kprobe/uprobe/tracepoint to validate correct name size instead of 0.
>
> Link: https://lore.kernel.org/bpf/CABVU1kXwQXhqQGe0RTrr7eegtM6SVW_KayZBy1=
6-yb0Snztmtg@mail.gmail.com/
> Fixes: 23cf7aa539dc ("selftests/bpf: Add selftest for fill_link_info")
> Signed-off-by: tyrone-wu <wudevelops@gmail.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
> V4 -> V5: no change
>
> V3 -> V4:
> Link: https://lore.kernel.org/bpf/Zv_PP6Gs5cq3W2Ey@krava/
> - Split patch into separate kernel and selftest change
>
>  tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/to=
ols/testing/selftests/bpf/prog_tests/fill_link_info.c
> index f3932941bbaa..59077f260404 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -67,8 +67,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_=
event_type type, long add
>
>                 ASSERT_EQ(info.perf_event.kprobe.cookie, PERF_EVENT_COOKI=
E, "kprobe_cookie");
>
> +               ASSERT_EQ(info.perf_event.kprobe.name_len, strlen(KPROBE_=
FUNC) + 1, "name_len");
>                 if (!info.perf_event.kprobe.func_name) {
> -                       ASSERT_EQ(info.perf_event.kprobe.name_len, 0, "na=
me_len");
>                         info.perf_event.kprobe.func_name =3D ptr_to_u64(&=
buf);
>                         info.perf_event.kprobe.name_len =3D sizeof(buf);
>                         goto again;
> @@ -79,8 +79,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_=
event_type type, long add
>                 ASSERT_EQ(err, 0, "cmp_kprobe_func_name");
>                 break;
>         case BPF_PERF_EVENT_TRACEPOINT:
> +               ASSERT_EQ(info.perf_event.tracepoint.name_len, strlen(TP_=
NAME) + 1, "name_len");
>                 if (!info.perf_event.tracepoint.tp_name) {
> -                       ASSERT_EQ(info.perf_event.tracepoint.name_len, 0,=
 "name_len");
>                         info.perf_event.tracepoint.tp_name =3D ptr_to_u64=
(&buf);
>                         info.perf_event.tracepoint.name_len =3D sizeof(bu=
f);
>                         goto again;
> @@ -96,8 +96,8 @@ static int verify_perf_link_info(int fd, enum bpf_perf_=
event_type type, long add
>         case BPF_PERF_EVENT_URETPROBE:
>                 ASSERT_EQ(info.perf_event.uprobe.offset, offset, "uprobe_=
offset");
>
> +               ASSERT_EQ(info.perf_event.uprobe.name_len, strlen(UPROBE_=
FILE) + 1, "name_len");
>                 if (!info.perf_event.uprobe.file_name) {
> -                       ASSERT_EQ(info.perf_event.uprobe.name_len, 0, "na=
me_len");
>                         info.perf_event.uprobe.file_name =3D ptr_to_u64(&=
buf);
>                         info.perf_event.uprobe.name_len =3D sizeof(buf);
>                         goto again;
> --
> 2.43.0
>


--=20
Regards
Yafang

