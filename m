Return-Path: <linux-kselftest+bounces-44730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6BCC32787
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 18:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4383BF6EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3F733BBA8;
	Tue,  4 Nov 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q13PLcyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8033B96E
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278905; cv=none; b=fcgmJ1vB/nD1wS76nJu7MXE38aZzSzsTAZ+9LB6Xu4hyXWofZhlji9Tf+pfpw2935TrfJO3wYqmQxlY6qvu/KipTQZRrts61kLlk1oe2NXi5HRovp9jQ/udSYrN5y28Ja5fS9KDdrQvKbhmQpHdvR4lhhUGystkAdR1g+SNvPMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278905; c=relaxed/simple;
	bh=Gga7dXHfeLZzklbXPavpEZ6reid9hn2IxaGkYVec1c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKqYDDHlEtfP1MfCM2Y07o24r8y+bLGBtqghunmXkFGJ7aq6dAHzNYaa43xUHY73XT84/LvK8WFanfJEo7DjgEgLkaDueHxfdOoFgLyjXSaVvz9ma8sc9DKvwGCZ3K71wfN6FnZHvUA7aBVWytGuLamEIPIVnLXHF7Kh5rPlHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q13PLcyz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso4249980f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 09:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762278902; x=1762883702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50v8erXAUCAdx13yfjVbwgmCtzNJs2FIBxB/mDOxFDY=;
        b=Q13PLcyzU2m1i6h2vXE0m3pFQt4Vluus3MVSbQfcu6UKjfPInLoFGtQPsUB0G6Ct1A
         BF5iw2IBtlDSe605vxYA3n0nxP/vsYU3j1kDXvUEYkbgN5jBpE4TJoGf8/3jdbWOTbJg
         mmfRUTtOnCQkMeqQ2II8+jo6sBzgISQW1qkUyrsChK6UcxYrA3sLMEKWJoPSn2KvWtYc
         EeIE0p0p0dSPrwomwoF+lWClg8AiFuR8zLPxhUSMXuPPKbSma3hdYSsBk+v31mqTbNvs
         ojXzPf8m+Yelh/KS2b5KPSIjhYB95oPSsGcqd4JURpXNg13Q1OewWRKUhCgZTIeqnkWc
         t8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278902; x=1762883702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50v8erXAUCAdx13yfjVbwgmCtzNJs2FIBxB/mDOxFDY=;
        b=qv9SxDorUguVPbPO+TtqQ3S2XrJ4gfelfstTHufqZxilWPKjdyq+eMpb/+0XCdMfgg
         ATqdkj/PFKipuCdtneBgbxWxUB9SJtmHI2LakD1PbKHjb8Rp7MB1jRrU2P24HmynIsHQ
         ZYbpm5Si5FH6SpPTx+CqNDDysFFD0DaFm5/JpNEpA7Nrap/4GxRxyid/wyGUiT4qxtZ7
         A/TeR8V1c0Kvw8jp1/aR+U8o09V1qScizUtZU9MKAtwrWEHjrdyQbvSL1sFLInZXn0WV
         ML71gNyVrVJckLtYbXaN54XvB8oOniDuyevFxkuMZ6yJXj+OoQvynCgYInRsRrnxO2oW
         gBmg==
X-Forwarded-Encrypted: i=1; AJvYcCVRfVW/pXXzbhfjSFgrN33BD/5DfZA8QAX50L/xvciO3phpNCTe+TjSx66+hXfkICNUXBp3u/AqxtnpisgTWsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbEtduA221GfvX3sQOJ3Mt/HvRLPuNYkCjZh+9W3Pf12L+WlWH
	DcdQtXb+G8dBCpO3EPPwd9m9KAhwXD2tmgsiOks0LoYcSWtGeDPBxQpkI6BbcIodFHF9o7kTbnf
	ETY8BmZEJpzjC0uxG9Vn+6fH9RHQ1QL0=
X-Gm-Gg: ASbGncscVq56hiBDu7dlOj2DAm48ulB04KvRR7KO1XRFdV5+rGfZ/kPMrrm1rQP89Sn
	OkvMRbI5PVYhI5WCv1WwwX5o1Ktd5EdQ1Nnmg0a45GNra3A2EcBxMo2GMREcwvUInM+Kew0bwH6
	+6CZDjpf6frzg7BnBgERBlT+6sLVOx4HgeME2WK4+r9vDArhbv9ouItSyjKPc3e02f4e4ZlLYDk
	K3LsjEW0lNs0kCfheQQVDZKdIV54/mdUmsV0HZn+TxaO/KnenmLRYXA7hYvHPyTBAbHPiGXeWvy
X-Google-Smtp-Source: AGHT+IHe2cvX79ByF/XHXoC1AinxfdR+R2HeAxrfHYrpUAc4i7jUKc7LNBvEX5vIHDigGXEpVUk/JIQwCndvI8NbwXw=
X-Received: by 2002:a05:6000:258a:b0:427:928:7888 with SMTP id
 ffacd0b85a97d-429e3311aeamr109738f8f.55.1762278901733; Tue, 04 Nov 2025
 09:55:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101193357.111186-1-harshit.m.mogalapalli@oracle.com> <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20251101193357.111186-2-harshit.m.mogalapalli@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 09:54:48 -0800
X-Gm-Features: AWmQ_bl7Wg5Ky0fAkADoe6a4uQMdjWgFSAOgbvmIWoV-HRcw0uHzFSIXFgIJbpE
Message-ID: <CAADnVQLe6a8Kae892sVaND-2p1DQDXGD5gqxHWHHUC85ntLCqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] bpftool: Print map ID upon creation and support
 JSON output
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Quentin Monnet <qmo@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 12:34=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> It is useful to print map ID on successful creation.
>
> JSON case:
> $ ./bpftool -j map create /sys/fs/bpf/test_map4 type hash key 4 value 8 e=
ntries 128 name map4
> {"id":12}
>
> Generic case:
> $ ./bpftool  map create /sys/fs/bpf/test_map5 type hash key 4 value 8 ent=
ries 128 name map5
> Map successfully created with ID: 15
>
> Bpftool Issue: https://github.com/libbpf/bpftool/issues/121
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Reviewed-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> v2->v3: remove a line break("\n" ) in p_err statement. [Thanks Quentin]
> ---
>  tools/bpf/bpftool/map.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index c9de44a45778..f32ae5476d76 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1251,6 +1251,8 @@ static int do_create(int argc, char **argv)
>         LIBBPF_OPTS(bpf_map_create_opts, attr);
>         enum bpf_map_type map_type =3D BPF_MAP_TYPE_UNSPEC;
>         __u32 key_size =3D 0, value_size =3D 0, max_entries =3D 0;
> +       struct bpf_map_info map_info =3D {};
> +       __u32 map_info_len =3D sizeof(map_info);
>         const char *map_name =3D NULL;
>         const char *pinfile;
>         int err =3D -1, fd;
> @@ -1353,13 +1355,24 @@ static int do_create(int argc, char **argv)
>         }
>
>         err =3D do_pin_fd(fd, pinfile);
> -       close(fd);
>         if (err)
> -               goto exit;
> +               goto close_fd;
>
> -       if (json_output)
> -               jsonw_null(json_wtr);
> +       err =3D bpf_obj_get_info_by_fd(fd, &map_info, &map_info_len);
> +       if (err) {
> +               p_err("Failed to fetch map info: %s", strerror(errno));
> +               goto close_fd;
> +       }
>
> +       if (json_output) {
> +               jsonw_start_object(json_wtr);
> +               jsonw_int_field(json_wtr, "id", map_info.id);
> +               jsonw_end_object(json_wtr);
> +       } else {
> +               printf("Map successfully created with ID: %u\n", map_info=
.id);
> +       }

bpftool doesn't print it today and some scripts may depend on that.
Let's drop this 'printf'. Json can do it unconditionally, since
json parsing scripts should filter things they care about.

pw-bot: cr

