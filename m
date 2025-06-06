Return-Path: <linux-kselftest+bounces-34427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E5FAD0821
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 20:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A787A4472
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jun 2025 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506321E25EF;
	Fri,  6 Jun 2025 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqbNiGAD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCFC84039;
	Fri,  6 Jun 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749234836; cv=none; b=JShGHj+KUbulyJrEauxOX5GGyECCyt8L7vC8sUcwChI8SyCPix0sNtYAer0avlrJYTgjjG0s9vr27duFHdBao5h/GO4XlpVwNv2ss+Ry4JZHZDH5kwlAjKS7oo2KCOPxjINJe8MIyb+cEz2NqGnytbj+1S7d9ZJgyKJv4Q4qDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749234836; c=relaxed/simple;
	bh=WPEmaBIYJ9sU3gGC4h+IrESjpWpOI4f0O/VQoPXsCzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGVfuJlHVB3bZPmw+wSskiYeGNfyRkFXJF3eQrEocKCrApPYqD2rjElPBTPbyxGvAJvUuHgYHYf3FLvK+4HOYPxmMSgL6ZO0MMEDqv4VoIv9g+rD2287E2xWpYBDU7Kmim+9I+OhqD6v04btCCVeyh9nNJVxonf++U97yHWS1d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqbNiGAD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5123c1533so1363745f8f.2;
        Fri, 06 Jun 2025 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749234833; x=1749839633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQv2ssfQSM3/efOHHHs2JPOHP+zl9UYVFNXEqlMK6OA=;
        b=IqbNiGADYnTd8QQDO+owjvG70x+oDlOFLHT0WwIVaQj/ytMUMVY4g0kLj0wO5tMU9/
         kfA1l4yHYGhAarzfyA5ybUF+4gXmryfxyhEUVY4vLSW9hUeNmn8Nr8uWGJGc4QI19ZTL
         g9PuBWZWjWRrPHmv9CzYvqcuwg7hK73Kn9lN+RtvWzwsDm9S/b1bdA8zfkIvGnXxbpTP
         QTEe/oaWfL8wkWLYUIEcYPL/QlQuXLc1R5MDxfKkwETVupXg66m8LU3aAKbHC90Kop7M
         YH8hamjaI6nLu6AA0eSy4typFt+iZEC6rR8MYJzK6IAIRmWoLpbi5NsTbQXCuEff/nKi
         0M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749234833; x=1749839633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQv2ssfQSM3/efOHHHs2JPOHP+zl9UYVFNXEqlMK6OA=;
        b=p+9oq0SIEN05+8V0yYtSTRWiOwNoMuFSM3qgwMrUnRnT62+Ir+GH5ErPhycRFAkVQM
         fr08Xj7EJgurtGtBku4MAtfc0AKKw179Nd5vGmH7MoHciNMh0OaSo6JQjASj93WoRF0S
         NcMotEwneX62c0HofWv5gIhXAeGQ3Se+c4zS9AEp+eXLJwDSl/jFdUAC5BMRAWW6jHCi
         gb3dQrkTPY5iWbl/so/zNhK/xUQfqcQjMzmZcHtISGv526vgyVC3YlkJMOe07UpsYAZj
         iuMj6Lj/p/AzkKY1rq2e9XpR6W+HelSvBEMUNo8bvZ27AOOJB9cvtAVU6nxWz+oJn2Fq
         gANw==
X-Forwarded-Encrypted: i=1; AJvYcCV+SpbqnR5wNySbcjmyIfC+m+GMp4v86ACZH7z7F+MBJ5hliOMHNeFepeCdTrVyzf5gpW0Wy1KYLlbia5oE@vger.kernel.org, AJvYcCW1CeSv07sbhLaHTTxAmpozSLdm9DkyG1Z8CQB+wYiyXkOqOdHcAVPcfN9cz///oxTz6CfSpPddUKFTrdOlspYe@vger.kernel.org, AJvYcCWO7vDVdOPdJFbEI75+6wQX4ZbjcYdQq0vNTK2Xu7QSDCM2gSXKtg6ZnPW+hkTE+9aLrk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHL+8L8d+CYRIELqKHJWss9WuHZWuFT04pNYgWIa9dbPbw+bR
	eD8bdJfa3wcyTA8N6cvFtVaMQDt8S/eTqhPA+KAr+fhmQUcHsopuvOGjRcoEe6ryzeJwkdxfgTc
	jWlxh35L7sxQGNzjHwsneEtxA5aiUfEI=
X-Gm-Gg: ASbGncsRnHu10s6Bc8EIcEiFUalwGAhYj9H99uTXjire+JVeULC7Gb4PI2XseWUMSNd
	6el93s/uGemWyviL5rKy0QaYSZjI4g3ekr2kEbeJmGl/dm8k4Ye3sOuAZFduNyX4ejKII3WULjJ
	V19ULXHrxqNd/19JWbKSyBnI2Hav2tzZhiq5HCr7JMKtcBhU5Z8xpJmtrDjgsvaecJN0e/cj30
X-Google-Smtp-Source: AGHT+IEc6TzG3uaZeGwv5pZfjdsn0kZFQLBTIfMNyGLmpPkgMe/NTjOfs3TsNLE+XHQgBKhukABKooSDlGna1v7f8ek=
X-Received: by 2002:a05:6000:2903:b0:3a4:eac6:e320 with SMTP id
 ffacd0b85a97d-3a5319ba3b2mr3730137f8f.3.1749234832772; Fri, 06 Jun 2025
 11:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603052805.13042-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250603052805.13042-1-suchitkarunakaran@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Jun 2025 11:33:41 -0700
X-Gm-Features: AX0GCFuZvpym6rX1eh0SX_-m8m3yTJemsUsryxSt-5zV4CAcbPkE23D_3fvUodk
Message-ID: <CAADnVQLUpRqP73gJ4+PM57jofFp-jPU_xj4eKwMT6mpeKxMu0Q@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Validate UDP length in cls_redirect test
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 10:28=E2=80=AFPM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> From: Suchit <suchitkarunakaran@gmail.com>
>
> Add validation step to ensure that the UDP payload is
> long enough to contain the expected GUE and UNIGUE encapsulation
> headers
>
> Signed-off-by: Suchit <suchitkarunakaran@gmail.com>
> ---
>
> Changes since v2:
> - Rebase
>
>  tools/testing/selftests/bpf/progs/test_cls_redirect.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_cls_redirect.c b/tool=
s/testing/selftests/bpf/progs/test_cls_redirect.c
> index f344c6835e84..c1d2eaee2e77 100644
> --- a/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> +++ b/tools/testing/selftests/bpf/progs/test_cls_redirect.c
> @@ -978,7 +978,14 @@ int cls_redirect(struct __sk_buff *skb)
>                 return TC_ACT_OK;
>         }
>
> -       /* TODO Check UDP length? */
> +       uint16_t udp_len =3D bpf_ntohs(encap->udp.len);
> +       uint16_t min_encap_len =3D sizeof(encap->udp) + sizeof(encap->gue=
) + sizeof(encap->unigue);
> +
> +       if (udp_len < min_encap_len) {
> +               metrics->errors_total_malformed_encapsulation++;
> +               return TC_ACT_SHOT;
> +       }

I don't quite see the point.
This is a test prog. It's not supposed to be used as production code.

