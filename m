Return-Path: <linux-kselftest+bounces-29243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0611AA65998
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C01D19A07C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BA01A0BCD;
	Mon, 17 Mar 2025 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQJ1yd4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AE18787A;
	Mon, 17 Mar 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230506; cv=none; b=bT8Lj09lt9Fs2yzewsGM6dKvodcvEv3InaAqb8Qvfx0Y3/5v85W+ujn2xCz9SazuGWfNmuDCbWP07kZh9WCPS2hFnc8lAFsNwX+EiX/6OHgNFOij0+czYDLhTEo6ZPqncYzDsFtta8RWmWfkOGDRirW2nsR2CxPVcIrTbMhFsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230506; c=relaxed/simple;
	bh=yPx1W23J/P+WYaB0fZ1AaTsK/DO5xoSjvffQi5HyixE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdv8XkpuG1scF6lcm0PYau4l9HSSaDNO/hiS5Art+yoXdleYggmMq8Ezn0bi7ndnoHNtyX0aejVD+y+7cF6WuOQBOwYsNAz+POAmC1zBM9ZiGHXmtAjhZ8AsPrel1pg8FYK/Lodn8kcrjH5Tgy3RgLN0en269IWP/vwAwDRHuuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQJ1yd4B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913cf69784so3983398f8f.1;
        Mon, 17 Mar 2025 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742230502; x=1742835302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYW/myG8S98ZwKXjjtz9d+f0WTJ0Pxhh9RLpDlD6mC4=;
        b=YQJ1yd4BBzBQkAC+wA51lh5f/LBgIZrCWb1KHhFT+2mp8uwsQj+nwlIZa1NqVQ4gmE
         A2O8E+u/v/+b4OCyZhogH5qcUGzX9TjEsC2TAQ4B+XCbG55pzoVfQKWQvUYXEGXhNDhT
         J8CTwKFrH0C8nDcg2ZEeZpFGe13MfqPWOTqJD7SaVnhzDpd/iwe/FDlytV5GgatBQWKH
         CcRIWU77F3FVUqWNEkOQO9DB8c1tuQYsMIRurjyGcf1HVHzsRMVz8UJpRnZZKl1BKfoC
         86keBpqgJHGQYKk5h+Hf1FHuFuyWeltoUf6ZU3VfHBOfKpfy/qLAZvKbKXmE/2zpMGcx
         B2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230502; x=1742835302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYW/myG8S98ZwKXjjtz9d+f0WTJ0Pxhh9RLpDlD6mC4=;
        b=txJVZ5o5CqOWY4kQ7cYDCga2e0j8p9ZCweiDBx+XknWmT/t1O6mSL9dJtKyxRp7TP6
         XmCuBbFiTEkNwuvukyKCkbd7ff/CffQokGnow7ZG33l2+iC2TKQQzNV8oUD6G4InKzQ5
         8qU9JocQ8nL083hqmeUXhmM0qxw86FhliepkrY1pZYF+FrI89j8GaMqeRgKkVSqrAoF5
         xWLgdN7F1dKPupOQr5eu8C06G7U2CHlFYft2BTlryJB+cof0GJqcI0/SvadAIBrCMRLS
         HAXZz8gWi5RJ7JumqODytJvIJH/xvJ3KopTW1Mr1baTncyZdOqKv3yCG2cApSEg2pvOO
         J5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVD0fJXo8BIieXFPh78IGMt9ks0Z/z/asm3GF/Lfut63GPUEG4tW7esJqhlz7gCGnLUxkuShrHaN8Ws3nQb@vger.kernel.org, AJvYcCVPd1IcEvzG42HVHFopJujOKeF0l/fQ92jrzVVXeDA7HGxIj/kwtvWXCeRqMPj9nf2rmFD74YBvLq4Ki9Nlha87@vger.kernel.org, AJvYcCW/5XZgsIwhZnXT2pzfAK4Ith7pRfr5dnYTQ/kLcG7Vuc56k9DqvpDwWoER0gA30ezAbvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGjSuCKIbfSUbQpa1GeyFbkKTXREP0LFZs8vLnO5KfzxFYN3fp
	1LkrDjC+4srx5Luk0u6St5tIExVvZyNdACDG1uEw8W7jq+PeXTaB1vwZc1XMcSSSRRl69ExoCFe
	di5IhfrNMhsXaAcacL+28ti3EMUg=
X-Gm-Gg: ASbGncswgeJf5hQAxUPXxlppxaKhYgGT+mXA8UKrrxl+3Ld4iPbqemfAUUtuQXF8ReG
	GLHIhu6/vLgVVMvPYQQt3o8JRW7JkQBvxfWPGhh6ceAZdcEztApAN6DmdmSdNf4cykSwRIZkdPE
	JZEFmzRGeIG19czE7y6fJOVRfesGY8kFuqNmUM2VmM5z1d8VGOGLlz
X-Google-Smtp-Source: AGHT+IF1wPrOYCHjRqINKRwXtxeBn3BLYXmj9FYifrDgym32y2IrbSokm4OJwOVPh3gpZxYxxX5kk+ywPzIkeBZaVrg=
X-Received: by 2002:a5d:47aa:0:b0:391:2c0c:1247 with SMTP id
 ffacd0b85a97d-3971dce077amr13365769f8f.1.1742230502029; Mon, 17 Mar 2025
 09:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317154706711RvRh_96VDw-u63cPmkeHk@zte.com.cn>
In-Reply-To: <20250317154706711RvRh_96VDw-u63cPmkeHk@zte.com.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Mar 2025 09:54:51 -0700
X-Gm-Features: AQ5f1Jr6SV-PxZAg9lGDwinwyvpNhnElW9xEeeE4utJ577keSk1EQKFPaX2ZkYY
Message-ID: <CAADnVQKTnS-EH=d58JEWEey5LGEeMx==_UHW6e2-kTbgp+ci5A@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Replace deprecated strncpy() with strscpy()
To: feng.wei8@zte.com.cn
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:47=E2=80=AFAM <feng.wei8@zte.com.cn> wrote:
>
> From: FengWei <feng.wei8@zte.com.cn>
>
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy() instead and remove the manual NUL-termination.
>
> Signed-off-by: FengWei <feng.wei8@zte.com.cn>
> ---
>  tools/testing/selftests/bpf/test_verifier.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index 447b68509d76..dfe64c6d4f87 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1320,8 +1320,7 @@ static bool cmp_str_seq(const char *log, const char=
 *exp)
>                         printf("FAIL\nTestcase bug\n");
>                         return false;
>                 }
> -               strncpy(needle, exp, len);
> -               needle[len] =3D 0;
> +               strscpy(needle, exp, len);

Pls do not send patches that were not even build tested.

test_verifier.c:1323:3: error: call to undeclared function 'strscpy';
ISO C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
1323 | strscpy(needle, exp, len);
1 error generated.

pw-bot: cr

