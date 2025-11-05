Return-Path: <linux-kselftest+bounces-44851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B4C3841F
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 23:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7023188C27C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 22:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31BB2D2384;
	Wed,  5 Nov 2025 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC6p5Eyl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664324DCE2
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382763; cv=none; b=Kr5KyL8aERuKjPO/ZsPPBtDrQerNDIjVaXwW/uUo/EKZ6elDwSRPqEc2O97pnkNu+MeALB37GdzuOtG/cUuXE9WU0klvyWAgYsBuyU1S7xNy4DnwhmP3DVjo8zWbLpuff4e/Kjf+dsKd33zmEXp1iaCNk2lBl8z0gN0uUB3GwFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382763; c=relaxed/simple;
	bh=kkDNyCXlipn1onJC4ich9C7JgWc17Nuo8XcxAWXvuiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhlFS2SXIUj5EZ6MG9AAGxqN0NJs9lq6CV4d1psEX+9h6TRcOuTjOgFp265QuOUEtGbGdwALj1mjRnXnqUK4C+Ea+ZDXrRP5VOYv201igjbcdRTJrm9A/9FP7zj7QPdsuLh0GvY/TCFFZifCYsPsjQMKaFX6+fGQ8bdXRC0U9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC6p5Eyl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47755de027eso2512635e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382760; x=1762987560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGoN6Q1FGu70kxgsHRXjo5ei8Lx6D1HeRQOhJHTTWhA=;
        b=eC6p5EylkYy/ZW4tzb0rWhTjt6g2gKWz8xUt6PQklcp5gBQO3jXukHiXs4wIJ5636R
         8swaxwTpj9Puxe0HijMP/L1p/k2w1gqVu/CLAVCuh6wJDJuhIns9meg6t8MwpzNqx6ol
         h6+bwAy+WXgfNVncowHZtUhiU9mVBBTP/uhWG/togNphF5Kv6ZYUwahAPDLIqLio+dji
         4DuyE9Fb6rWW+t8WJQ9Vir+jmE6XWxL/1yIByhMLE4VzLamnQOG3Vg4AxtIRKxo96CO1
         /KNutUp/2QLGZ7FLm+Ff9i+EYkiYl1ZgsZG1Wcr0+JPae7kmidRpPjYJ1dUA3wAnH3YC
         jbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382760; x=1762987560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGoN6Q1FGu70kxgsHRXjo5ei8Lx6D1HeRQOhJHTTWhA=;
        b=HLKGCkBd+B5L2h+0fI0HPK3fTl1mfN4/JyEvFPYDtotUvHUiqETRLYJQfyKPX8W2qi
         Mq3OTTOU1jexL2EbnU4tkH52Vml58mdj+Ef7ononJxp46moU0qi28v2LhbBk0aF1PuHi
         nBxH+ZbWjGd9UY+RIbvLBWMP4+cPs7UN5SEl86WO7NLfGAAeHM4WhNELRvaze0gxhUVe
         etFQBjq5lvtxw0EKe/7g8cDgn1RFxFa4Aqz3A3Ajujt5UDiTVNwTp098FgU0u9wu/cnl
         NDEIkcujCRe616LAU7R+gB01wOS6fEpipb93RE0utkq78xdk48AbRYKqYcgb/FHzgkmh
         nWFA==
X-Forwarded-Encrypted: i=1; AJvYcCVivaz+7WBxW0T2/DmVORRy1nJNey5gq2RZHIjwhlFd/1K+yLfnaBNQ0UpjQTBvM4uKveiPKDGeF3kT/FaKF6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/boCVsuYalANYqZaP+9S/xXt8oG01jNV+5q5bePaPDpQ2giJi
	6AtShXcrz9Ri7GCRZj731P2WHSwyClO3lIrJK2805G2UxN1mWugmtlU+/2UOJUDPkbyNrNlGpoY
	nhIQUFfD8sGOjASGJs9thqzWjQqrmQak=
X-Gm-Gg: ASbGncs+vZntE9a8xEhzWR6mHv8D5geqHn+FkW6KAB8csZ6VwwH3OGSbAtRH6vMnHqK
	IKGdF5Wj/RRgRlVbVkkUtJqfQtAZTpFYCOTMKoRC21ZnBr1GHN+AxgmtGBXOx5m6ot3A+EYqzop
	qzoTusk7+U23Cl0QbzJqa59SFmm4XjfY9Txm1e2w+M02U4f29pV3VFGpK0G8vhH4iV66uTJGErV
	oKE+LTkWtuQvTADo4xKqWXegmaVvnbQJuvNvjj8nAEd7VjNJGnsAEJRjT585xaxXZPuT7haB9Ue
	O+GqhUxTW1N/VkiXbQ==
X-Google-Smtp-Source: AGHT+IGjDwvUOY1Pq7XzI4RZbgF4ynfBtF8HaZiltB+4JMI7wP597W0WnGnQWn4EsO9dJ3ITS0umhzfO5f/LQShhu9Y=
X-Received: by 2002:a05:6000:25c2:b0:429:cc1c:c1f with SMTP id
 ffacd0b85a97d-429e330bb48mr4108376f8f.48.1762382760149; Wed, 05 Nov 2025
 14:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
In-Reply-To: <20251105201415.227144-1-hoyeon.lee@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 14:45:48 -0800
X-Gm-Features: AWmQ_bkCpm1oQayiN7axXx7bpB29hzAn2IfljyRcTIPVqCsMzM4KtipvyswazdA
Message-ID: <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use bpf_strncmp
To: Hoyeon Lee <hoyeon.lee@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> wr=
ote:
>
> The netif_receive_skb BPF program used in snprintf_btf test still uses
> a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> available and provides the same functionality.
>
> This commit refactors the test to use the bpf_strncmp helper, removing
> the redundant custom implementation.
>
> Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> ---
>  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/tool=
s/testing/selftests/bpf/progs/netif_receive_skb.c
> index 9e067dcbf607..186b8c82b9e6 100644
> --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> @@ -31,19 +31,6 @@ struct {
>         __type(value, char[STRSIZE]);
>  } strdata SEC(".maps");
>
> -static int __strncmp(const void *m1, const void *m2, size_t len)
> -{
> -       const unsigned char *s1 =3D m1;
> -       const unsigned char *s2 =3D m2;
> -       int i, delta =3D 0;
> -
> -       for (i =3D 0; i < len; i++) {
> -               delta =3D s1[i] - s2[i];
> -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> -                       break;
> -       }
> -       return delta;
> -}
>
>  #if __has_builtin(__builtin_btf_type_id)
>  #define        TEST_BTF(_str, _type, _flags, _expected, ...)            =
       \
> @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2, si=
ze_t len)
>                                        &_ptr, sizeof(_ptr), _hflags);   \
>                 if (ret)                                                \
>                         break;                                          \
> -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STRSIZE);=
 \
> +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expectedval=
); \

Though it's equivalent, the point of the test is to be heavy
for the verifier with open coded __strncmp().

pw-bot: cr

