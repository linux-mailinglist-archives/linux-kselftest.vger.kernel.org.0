Return-Path: <linux-kselftest+bounces-8467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBED8AB387
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2985E284EBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6108131BD9;
	Fri, 19 Apr 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bejfxx9E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272D81216
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544988; cv=none; b=lk94CILGpL4ofWhyg/htTOQLcqWkIcuo2wdOV6NeJlFEXen2YUKr1njo7XRdmWxtJtDtd4BhJwJnt4NoeQ8f6fnhJn3g1rYlCX3neQprDCsjuNjguA5VWDgnTcdG//JpZZ2YC8jjrl//0GzXJvvNq++GIz+jtEHKVa6gNA9MkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544988; c=relaxed/simple;
	bh=IhnTT0l2ak8PX3XUQ0gqqGMLbDIb6Q42SrSOC/x3AwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8uvwaB0PlCFe8G4sVwtzjVqqDiWc3smLh/HXfuAHxyyxk/sNvsQk8bywFDrQW1tgnh3uVBlHERa2+IyxGUGh7Hk7odk88kPaL38AHnr3aj8UHcqnUOb83AnUiDs0Q3rP80bZRV4G2yrVG8aWZJ98lNAWRtkULtX1BTct+vGLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bejfxx9E; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4daa5d0afb5so622262e0c.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713544986; x=1714149786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtE/0r9aKWX1tYUSYTffs1EcYK5K2eKAPlL1XcyB0S0=;
        b=bejfxx9ELVm8mvA93qn7KrkuHKKX+B+b7bjygdauLDyFa9xXpTwotVWK2VbVl2tS5E
         EJfEFZSIyToFFNkyAHZeRl9gAQVYgv6HgMUoGYX0EyETbqGw/CjK+bYNTrwixV0x5Dn9
         SXRjiSTRzbDPFf4WAc1V2ASJWvlUt7j5mo/gf1jtNjGJ0f9D+3X0nrY8kaObNuD3UiHI
         PgSIP/Yrl/q5PDGWiH4SdZE5D6SnXIDukBJt2pdlfriCZbn4XyusQCp5mkefiBxia190
         34/cEKI1D4QqVCSGrgww1TEHi9NHtqSVgc3QvYV7v1sHBd6AK29ubiqaLo3p+InoZ0Ui
         dlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544986; x=1714149786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtE/0r9aKWX1tYUSYTffs1EcYK5K2eKAPlL1XcyB0S0=;
        b=sHgLAAz+4JPl5mSHGaaHyIZO3LQh72iU3jzUiKKso11Hcz9tnOqCgA3CdRZq+/Rqjk
         kO+ypsI6GMmNJdrvzTw9PZt53tko6hwBKq9JAH2ieIzjx/icFfwnzMVUeNY1KAk6a/CJ
         /SXi7TCTev4xLeVEavz97UH6dCfGc/XTF4wtlQS08TgqCcth8MlFyjV0yYPnhLSjMVYs
         lOLa96rxuoQyeYuO9rdvRPNIJfnGaeUC422E0FHf5GHW3FKyfOIXSnTWk2WcZ94r06YA
         gs/fxDY/RTZj5R1yw1ElPC9EYLPBSxpZ+nY/2Hc3XFuRWmJqhj7l3BaUAzOzUZf1SehY
         Gmog==
X-Forwarded-Encrypted: i=1; AJvYcCWGLNWgQ19pCoySJVrRwhyF64lRVysVHZw0feIYMqyut39qK9tWOqvWW/qzIxw4UZukztVKy5/zzSxRQe2KvZrKR3ZRV7o8zRpwJ+iwjsOi
X-Gm-Message-State: AOJu0YwUrg1EU4g1LyfqZvJ/JJW7C53KM9TTFm4hQ1rAw706Yd/XxEoD
	U65kQ/CEbCds+MYbQEsub81W5xOpXKEh6mebZZ7h3z2xIQf6j7Mb+vKD/TFrCEBWEEK4NJgiC4G
	Ft5phxUFgS37fb/oj51QQ+GG+GPQ=
X-Google-Smtp-Source: AGHT+IF0+YHtgfgnR35Av/Ix9olJe5O/Kxm0PRINiGwCyk5Cu7U+oM1okZJ3LcXSHF8deT1raRZs6VHavlZLvbrcVTE=
X-Received: by 2002:a05:6122:1696:b0:4d4:2fc1:b252 with SMTP id
 22-20020a056122169600b004d42fc1b252mr3035441vkl.6.1713544985991; Fri, 19 Apr
 2024 09:43:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419034350.127838-1-jeffxu@chromium.org> <20240419034350.127838-2-jeffxu@chromium.org>
In-Reply-To: <20240419034350.127838-2-jeffxu@chromium.org>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 19 Apr 2024 17:42:54 +0100
Message-ID: <CAKbZUD04B8zK4+eNJ6CYvcrXu1a47aq-q8yPsFLS3Ln515vGMA@mail.gmail.com>
Subject: Re: [PATCH 1/1] selftest mm/mseal: fix compile warning
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, jeffxu@google.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:44=E2=80=AFAM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@chromium.org>
>
> fix compile warning reported by test robot
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202404190226.OfJOewV8-lkp@intel.com/
> ---
>  tools/testing/selftests/mm/mseal_test.c | 3 +--
>  tools/testing/selftests/mm/seal_elf.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index 4a326334726d..35cdae93e580 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -79,7 +79,7 @@ static unsigned long get_vma_size(void *addr, int *prot=
)
>                 return 0;
>
>         while (fgets(line, sizeof(line), maps)) {
> -               if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, &=
protstr) =3D=3D 3) {
> +               if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, (=
char *) &protstr) =3D=3D 3) {

This fix is wrong. You can simply do:

+               if (sscanf(line, "%lx-%lx %4s", &addr_start,
&addr_end, protstr) =3D=3D 3) {

and it'll just work (arrays decay to pointers when required).

>                         if (addr_start =3D=3D (uintptr_t) addr) {
>                                 size =3D addr_end - addr_start;
>                                 if (protstr[0] =3D=3D 'r')
> @@ -208,7 +208,6 @@ static u64 set_pkey_bits(u64 reg, int pkey, u64 flags=
)
>
>  static void set_pkey(int pkey, unsigned long pkey_value)
>  {
> -       unsigned long mask =3D (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)=
;
>         u64 new_pkey_reg;
>
>         new_pkey_reg =3D set_pkey_bits(__read_pkey_reg(), pkey, pkey_valu=
e);
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selfte=
sts/mm/seal_elf.c
> index 7143dc4f1b10..b7e72f9804f8 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -105,7 +105,6 @@ static void test_seal_elf(void)
>         int ret;
>         FILE *maps;
>         char line[512];
> -       int size =3D 0;
>         uintptr_t  addr_start, addr_end;
>         char prot[5];
>         char filename[256];
> @@ -136,7 +135,7 @@ static void test_seal_elf(void)
>          */
>         while (fgets(line, sizeof(line), maps)) {
>                 if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u %255[^\n]",
> -                       &addr_start, &addr_end, &prot, &filename) =3D=3D =
4) {
> +                       &addr_start, &addr_end, (char *)&prot, (char *)&f=
ilename) =3D=3D 4) {

aaand same here.

--=20
Pedro

