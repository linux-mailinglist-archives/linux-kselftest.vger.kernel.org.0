Return-Path: <linux-kselftest+bounces-38383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43854B1C8A9
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2C85646F3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CEA291894;
	Wed,  6 Aug 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/pKhilf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC678290BAB;
	Wed,  6 Aug 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493947; cv=none; b=fngdYKyL2ujs2nm0LKO6e9XXeYMrtnO/0gGunXvdx7PIMmga0PeWfZCO3kExliFgF7RFrvs+ONz8Wrg/HpF2E7E1Com+QcsWhw0SdOPxU6BIpgzAvMyEfbqUiwGkWlpzRIapuGBLy4f9374B9QgHktzqOoVo03QvUOOLOhk6Ka0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493947; c=relaxed/simple;
	bh=mKodv+sKlayKFfKvzNuhrQzdX3PKR6NGBRJMnFiQnVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQyeGqyX10KX8NlF7HTpSV+GLH33Ql0UNvman0keh+9hDZPtN8iY2anjOQsyiYHZJM7YGxPeyY5lyvesmrrPjQ2lVEmz442x6MOVYH8A3uCHB9VPbZGsePlowGmUd5BQe1EcnxQMiSNinxXwUrwKyuT+JH8pA+3psbvtL6uv+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/pKhilf; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55b79ea50f8so2953e87.0;
        Wed, 06 Aug 2025 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754493944; x=1755098744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ak6kkG0Gr5ILhCz9qlDe4Tz2QPMgdqhFKKAgptHzkg=;
        b=L/pKhilf9irSpygotaDCsaM/tcGbqCXD60babCIKq/vtquCAqJNckxjtqEwGt+aHy9
         1YV9Lq4g3zGiE0AeQ5g3SQUNoqCn9Xv9YQUBB7heYnuAdSjk0k3cM6bXXBys6t3IL3HK
         xmr/qyeTSe8Q7fFHm8iiN9f8SaVVcqaWSNCLyxmti4YNGX/BMT/zBpxzdXopRcy89wf0
         Nwd/b1hJnBRgziogttQxPLtXOaEcXEkS2i357SDzF7usMD4sV7JzqqA584A1JJEJzIbL
         Lvfz0RpIILxua1TCvR2n8OY1VD5yo9q123CZMWGBVITEtFCj3h/ueTopTgQ6NkIoWyxO
         JTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493944; x=1755098744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ak6kkG0Gr5ILhCz9qlDe4Tz2QPMgdqhFKKAgptHzkg=;
        b=HAZUPS0GzryJRJ0usX7mW6zzyyJL7B1WoyCnl0FuziHyzyC+UmBHkxQVCXC6W4HoHa
         vRaaaK8wsdyuAe2GXCYVf4YYpK+QsA33Fm9HY5buc7gL2HmrYPlaqc/wfiFPXB3B/6xX
         RCL4cLh98Bfb/pyfax652jd5xW/ONpMUquFnz9QFQOLPEzuyxm6gr01HPpTwuq6fdmKP
         67/2Xv3RAEgb34x/4LMo57XkpIOohHJc3739l7gWTPjQj37u8A7NBl3R1LRqRklJqaKS
         JZHadEvo93mLVEuimIHKpHFGAtMZHBs4ZnJLw6ZCUptQt3fJAAKxbO7Z4AAzwjHK1q2s
         6K/A==
X-Forwarded-Encrypted: i=1; AJvYcCVrB2+OESANrEUplQhDIzMIMGXw/yFw+vCG43gHlklHXPPN2nAHPeZO7FK0OYaTP9TUAr+Stz2Z@vger.kernel.org, AJvYcCX6hKlW0XX4+DnIIemF4bkv7pDtw1fxQ5BzVZh6rlT6LJJ6I1/xsl8quT/GM4suHtk4+j8=@vger.kernel.org, AJvYcCXCk/5Fo8hXdkCOwDqmcsfkX03W5PPOex26SInLUEFAhxxZ2N5aF2+6OjZM/LqQMtzKdLoEloKm4sM8bt2y@vger.kernel.org, AJvYcCXGg3rolZlhXZX6HSGKf0HKsPEotFVyT9fmx2+jTypK7qKNelewoliSOiHDOebxppJB9IoRPS9Cp1xnVT7TN1mY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9kn5B2jKAFs5jDLkdFRohWi4QOa3pM5lFbm3dL1lH786IBAN+
	GleUcbCWCcF7EZX6xalL5tY7jGVxgcdjOA4G0ednyr4KDGW0EEY0MvGaYpNPx71bwNxnE0pawWc
	cetCz1lx7/znaPTRunXgRVhuVwTDpy80=
X-Gm-Gg: ASbGncvNsNv6Zkw3pBiF8QAjRxHwbCrNKb6+HQILW3Ov58+JJCrx5ZwBvzORMUPeHP3
	+3KwnpHpJyjE8GVVwFsXvwB4qslN03WGIuRMV6gUaF/+2uGHpWzIjBbMJDK8UmxOuAjzjJz2DqF
	NPe4rwkveu8NUy1V7Vr9g2AHGEzLJuti+BOnp6d9QRcdMQuka9wP10cx5L7wwyVyQTx+uQbZxxn
	pDOxGAlA8uZSP4TR6LADzw+Pqy0PMOfDc+R2Xit2w==
X-Google-Smtp-Source: AGHT+IFuXucBMEFtpCtDsz4YxIbE8W+P3+as9anTHGHj6dyv4YdatbL3BW3rJ6ST71SpMX9C+9AlGI3nNgbMQZCuM6E=
X-Received: by 2002:a05:6512:1589:b0:55b:920c:33eb with SMTP id
 2adb3069b0e04-55caf35898amr981949e87.42.1754493943616; Wed, 06 Aug 2025
 08:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806110230.23949-1-pranav.tyagi03@gmail.com> <CAADnVQJQV5Z_LsrBCa2=UwQ9NhPbkpNvZ9N7nf1sv-QunEj1FQ@mail.gmail.com>
In-Reply-To: <CAADnVQJQV5Z_LsrBCa2=UwQ9NhPbkpNvZ9N7nf1sv-QunEj1FQ@mail.gmail.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 6 Aug 2025 20:55:31 +0530
X-Gm-Features: Ac12FXz2S0kDjSFEJFEpV8_XL9LeoNM4mZxNsuwnlSJbqILHu0d2FLO1xgfQ7Tw
Message-ID: <CAH4c4jKvMBfaRaAoHbBn45vKzCHMBRjJ7UCOqa8FDXXQ7c_L2w@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf/progs: use __auto_type in swap() macro
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 8:33=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 6, 2025 at 4:02=E2=80=AFAM Pranav Tyagi <pranav.tyagi03@gmail=
.com> wrote:
> >
> > Replace typeof() with __auto_type in xdp_synproxy_kern.c.
> > __auto_type was introduced in GCC 4.9 and reduces the compile time for
> > all compilers. No functional changes intended.
> >
> > Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> > ---
> >  tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/to=
ols/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> > index 62b8e29ced9f..b08738f9a0e6 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> > @@ -58,7 +58,7 @@
> >  #define MAX_PACKET_OFF 0xffff
> >
> >  #define swap(a, b) \
> > -       do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } whi=
le (0)
> > +       do { __auto_type __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } w=
hile (0)
>
> Sorry, not doing this churn. The code is fine as-is.
>
> --
> pw-bot: cr

I understand. Thanks

