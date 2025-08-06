Return-Path: <linux-kselftest+bounces-38386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F6B1C937
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 17:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331953AF62C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C745B293C51;
	Wed,  6 Aug 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ/B+cFJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB327292B54;
	Wed,  6 Aug 2025 15:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495166; cv=none; b=aNM8n3RYpAZBF7zNSjAXphxXdXQymTvch/pCPnbEoWnhZyj196zaP5KIR7qjFEhqur+gNqLk0bYa01I0U/0PanWzYH2MVknyXviciLNw9mj7PoHCrBRgW2L3DF/5qwZ2eDYB6eS6GdWZoZuRCw8ubnJ5atKtUdxOzP+8SjH78+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495166; c=relaxed/simple;
	bh=jmUH1JzYQAfaDnXZLVWzBEI4r9jrLU/kenC5OLCdEOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Isl3PdDc4I2AnYOpa8tetScqIAAkh8UJN/FdAv/KVJeGlRj3+29VhTvUJllVAci0GOuJv81sa6b+koX+1Fh/b3ujq6xgRAXBkowscZfUw4tUbe0bwtOZN3C350YELWqvpNNxBhx4vDT7Eq69Nhv8aB3DbryV1sFuafsJ0xRPkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ/B+cFJ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b978c61acso3640e87.2;
        Wed, 06 Aug 2025 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754495163; x=1755099963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zmrMmlSKNc8Wry1y8dWX27pKFPjQrw0O9VLnGzkRYw=;
        b=KJ/B+cFJa6X4I6XVunDC3I+vUqtBiYanfLfLoeYuUnVv5awQl6k8GR22Yd0qwTTw6/
         ZgdN6iN0Z/cQJT7EFDZLMq0SMeLJpj+RV+9JpYy/8njUXZDTByJV539bmCCi2v5EBS0E
         Pq/7vwmra+CuNCBjPcWO34L6Uy9diZRL3U1Kc5Tso/Um8QjIEU1JNmHtiOY8vPFM/p4o
         6iZ7lp2K7rHT4LFY5ImVmJQtn9VFCXGbhSEOS9f1Uk4F2gN9LoKh3w4ceNcYa3Zu4Ni5
         TlbPOLPkkf7+TynvxFkzFSLcX1+6WhUMJgMPMSb+iDkzX+Wy99yju35zlwoEqot6lZkh
         jFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495163; x=1755099963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zmrMmlSKNc8Wry1y8dWX27pKFPjQrw0O9VLnGzkRYw=;
        b=ksZ4FkD3PSY3kb3oC5p/8rIyQSbj/qmQLjXQHqKbq/l/xno5wlDi30ixbqdADUJp86
         p2xpg16hW1St7k/2njP6sRt4k0obNC5C3Fv6a7dyAnzuY/I6cZDMI59Kroae/FQ8BDQN
         B3Y29hgcM4Z+sQRWN3ExHnIywu0yrjHkgg6OnbVb9BHytvpe+T2co7Ry5u8gpRuIfYnC
         3KTtLSNylMwpgLUsCZ3iQ3D5rHdVp7xg+UTlPNbbD0m92IjCrJWoLdLpGPcCuEqutY++
         sckIhPIFoZU1qjPYExzGHiXvV+ZmEvCssILMc/vUWH4KI81zsBleK8QClbtrXCJbGeZq
         Ehgg==
X-Forwarded-Encrypted: i=1; AJvYcCVkaTu+fBnydsnolsTn+MxZpNmybJ9ClbUhnIFJUwpuSftx73jN97joXjSqDnXckyrwqhjAdojhUsScZ2g=@vger.kernel.org, AJvYcCXaB7HmM2c4xWT4mgh9u5+7+Yt4H8g+YYXutD1/n5lJ/64DfUoI+VDql7EMNynxU6myekehGhzrFp1y0Gg7srG7@vger.kernel.org
X-Gm-Message-State: AOJu0YzIEFXw5//Q5bQqDGa1O6yxr2IVohZyRyaG6Lb0jCmH7AZv6MhZ
	PbOAc65jZuDIPqeVP6ceNSqPBwiFunNuYUlfOUGttzF9a1UIfeixM+qYah5q2xkwCKv1nx33Y5L
	MfFSqmNcYctaACLQh9AyzrYVDxs2IeC8=
X-Gm-Gg: ASbGncuew/JxnN1B2gzC1+h0yjFyswRPaLdoOhX9hHUpmalwISLHoKdCZqYvLoyTR0l
	he7Uim7OUs28QUAxd/TKi4EstUyrvyLIbY4zH423p5UnWVOqpbu1xPKwmVnYpE7llBkhQywkqII
	ckuQHx//ItoHorhkaaNC8YeyJhZq+ZIKPY4py6y77Jxck2b/tJPLl1QYtiKTmxdshhCbTFCGQSm
	i63FfABog0nldx7Cjpzw+xvmNOOzvVlNaiKdLFikw==
X-Google-Smtp-Source: AGHT+IGXosmjvzExQ3C4RK78Mcex7Mn1Uk/h0JUj5QUxdn/C6gvDfKT6OI5wS9vLx2H97RSvkUJIJkgfNFNXTPXKb0g=
X-Received: by 2002:a05:6512:118a:b0:55b:82b8:c2f3 with SMTP id
 2adb3069b0e04-55caf5f82b4mr1212425e87.43.1754495162686; Wed, 06 Aug 2025
 08:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730142301.6754-1-pranav.tyagi03@gmail.com>
In-Reply-To: <20250730142301.6754-1-pranav.tyagi03@gmail.com>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Wed, 6 Aug 2025 21:15:50 +0530
X-Gm-Features: Ac12FXyNkNIXJt8LjQHrVLUgBnSRkW0iOHvQddA77ExTJZswxw6Wx4O4SJ98_zE
Message-ID: <CAH4c4jJ8VywRUfn2z8HnA73vNxviZ53DZttcR3JaPULF3JFkQA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: use __auto_type in swap() macro
To: akpm@linux-foundation.org, peterx@redhat.com, shuah@kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 7:53=E2=80=AFPM Pranav Tyagi <pranav.tyagi03@gmail.=
com> wrote:
>
> Replace typeof() with __auto_type in the swap() macro in uffd-stress.c.
> __auto_type was introduced in GCC 4.9 and reduces the compile time for
> all compilers. No functional changes intended.
>
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  tools/testing/selftests/mm/uffd-stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/sel=
ftests/mm/uffd-stress.c
> index 40af7f67c407..c0f64df5085c 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -51,7 +51,7 @@ static char *zeropage;
>  pthread_attr_t attr;
>
>  #define swap(a, b) \
> -       do { typeof(a) __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } while=
 (0)
> +       do { __auto_type __tmp =3D (a); (a) =3D (b); (b) =3D __tmp; } whi=
le (0)
>
>  const char *examples =3D
>         "# Run anonymous memory test on 100MiB region with 99999 bounces:=
\n"
> --
> 2.49.0
>

Hi,

Just a gentle follow-up on this cleanup patch. From what I could find,
this is the only use of
typeof() left in the mm selftests, so this should be the only instance
needing this change.

Thanks for considering!

Regards
Pranav Tyagi

