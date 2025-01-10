Return-Path: <linux-kselftest+bounces-24233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE81A09B91
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 20:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81693ABB1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11EF22488B;
	Fri, 10 Jan 2025 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBj6+/cO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057B2139CB;
	Fri, 10 Jan 2025 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535662; cv=none; b=JGAbdwDbZ5GV46ivhPFcvQ02R6P3FcZuZrF8tg3ktFFvHdPlUkwgh8JxQ77uOL+bpUEK5KJp2K59ChqMj+8TJPfx9DnZnIC4kw8m1gGkRmbvyQRuPksdTqpHsJUHy85sK3YYc3afRhG+1eL0ardpc4wUcwYhSVLHqZG13uvdzBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535662; c=relaxed/simple;
	bh=eb6NgulhDzrZkbA71d6HYlQt+zV/kGdNXlXc5cyMR8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouvOJhkGlLSsWEy7TLgq7S1ZsdiwNacA7sSS3dJ8NrOQ1J3nJTg77KCRjYybAo5Z7Wrs9roZu2EuwlZ69F+/92x2lTiPD5/EKjQneU4FNiZTu4v983UJynvxcU3ZKF+j328ItgkwBc0g7rqstSQX/ZDfz/mcI+fvM9hazNT9pbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBj6+/cO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso15531365e9.1;
        Fri, 10 Jan 2025 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736535659; x=1737140459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jl28WGFBUnyXFL1l4Ve02m6xRTatJU9EP+pENMko8OE=;
        b=OBj6+/cOMjPWCUmRaZHH4elYk2S3rfHL2SqiM16q4JMH3Sj2PxMwkdO31heaD1v1ut
         tVTTkc/eKPYGINdnszb2vqXr3eyFH0x7JwaiuoJ6pPJcbFlm5k7zEq7lPlLLIBWjMn+6
         dFzh+WddfSQhxJU6L2H7aIVLCXZYWpC0hUfTNugXWVmmbmHwepgwkShFGEjQVETlmDRj
         nMoJSCbkTyUlY44LU5ZnkcLGvALFXmQZzlhw7aDYg3KNDK916GfCxYUYnhQRIYQI5gS0
         Y77KM4Zi1QsDJRM70Yfvs0prZ7pYBXLy+kQwOEWE5dlKn1jIefG8Oya2oC3OHZKZd3mD
         tBSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736535659; x=1737140459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jl28WGFBUnyXFL1l4Ve02m6xRTatJU9EP+pENMko8OE=;
        b=YYmugT0lvcq9egEJUEdSIkEsyzD2htK2lQqPVTyHDe3h3murOAy4nxRsdQkGwv5TGF
         mKX3ksweum7Uv2btHsOzNK9Un6qc14g9nrxsoULkk58fVfO++Dvo9nPI97OMPgzkFAy7
         b+tNjX2o7/jVEa2+h3Txjfp+elVgN03acVJbxYNl2nOcPOWnAsosiLwCofKZlzF/0skf
         qNAIluibRVDcAeQ498CTLSaCkBWE+TNhtlktZiY68ZkQuzQPZ5b324XCaUz7aIbljpaz
         VgoZGHXVKkVYMlg9LnimTmMMxa9rlrWkl8f+nOv2OHRT9ApoCZfW+FZ1RQSSM1Q7WxR+
         Tr7A==
X-Forwarded-Encrypted: i=1; AJvYcCUxWAqCQdJEcz2o5RzoQZ2nqhIZA5hem3IeqSgf25HdNkT4Bj5UXvB6YLXbEn3dhh+uXyymlRnmWFx4utGTkjQL@vger.kernel.org, AJvYcCWo5Wj6qDfLbOwsdPmeDm5yaGRbeQ++Xj8mg4o8IeoGbzf6OEwRrrHdOeZ8AYK680FqmuQLkADHZynkLDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kxJt0Bi6EWNLAVCl59nGa9O8jxIF01ost5+NxZ/D3iHET9PN
	Vwy0GsPf3x9fXUrMl9jdvAhvuroglA2irZKI4o2rk9ivxgdSevsB
X-Gm-Gg: ASbGnctvqK4g1BsWo2pOrmBTn+X4C4jqREFxBiAHT7m6OKuhRojBvTLLopVNk94fByM
	wJWFNYDZKj4enBRBWe21GI5j2CraVj7wN+LCjghM2cTfjmaq9i2v9zFjYkZx1OnBX/tvaAhwtM5
	5DJA9mrWL4dHqa34G6qpxm/A+hbKkzme7UzDAhvyLrfhwMmjF4oIO9pvtrFW2ph5MPSBv10E5Vg
	LbFN8m5CKM+SzfCPtceyFNO9a640bID5rUSa9hae4YrLxBKSYmzzx9f2uGjxW/Fpg3qPFd06ATJ
	y3HvNkwKxWpfQUgVsLg=
X-Google-Smtp-Source: AGHT+IFqfQ9D/+Ru2s28NeOwpa6tmi6l/3Fy+siG6IN7TXQbcoEEAlkBeBjEy92hU2amqqBnx5IKrQ==
X-Received: by 2002:a05:600c:1827:b0:436:199e:8458 with SMTP id 5b1f17b1804b1-436e8849de0mr73803245e9.14.1736535659163;
        Fri, 10 Jan 2025 11:00:59 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddd013sm96255465e9.24.2025.01.10.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 11:00:58 -0800 (PST)
Date: Fri, 10 Jan 2025 19:00:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, =?UTF-8?B?SsOpcsO0bWU=?= Glisse
 <jglisse@redhat.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel@collabora.com
Subject: Re: [PATCH 01/16] selftests/mm: remove argc and argv unused
 parameters
Message-ID: <20250110190057.2294fd5a@pumpkin>
In-Reply-To: <20250109173842.1142376-2-usama.anjum@collabora.com>
References: <20250109173842.1142376-1-usama.anjum@collabora.com>
	<20250109173842.1142376-2-usama.anjum@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  9 Jan 2025 22:38:27 +0500
Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> Remove the following warnings by removing unused argc and argv
> parameters:
> In function =E2=80=98main=E2=80=99:
>   warning: unused parameter =E2=80=98argc=E2=80=99 [-Wunused-parameter]
>     158 | int main(int argc, char *argv[])
>         |          ~~~~^~~~
>   warning: unused parameter =E2=80=98argv=E2=80=99 [-Wunused-parameter]
>     158 | int main(int argc, char *argv[])
...
> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing=
/selftests/mm/compaction_test.c
> index 2c3a0eb6b22d3..8d23b698ce9db 100644
> --- a/tools/testing/selftests/mm/compaction_test.c
> +++ b/tools/testing/selftests/mm/compaction_test.c
> @@ -194,7 +194,7 @@ int set_zero_hugepages(unsigned long *initial_nr_huge=
pages)
>  	return ret;
>  }
> =20
> -int main(int argc, char **argv)
> +int main(void)

Doesn't that generate a different warning because main() is a special funct=
ion
and gcc knows the arguments it should have.

Just disable -Wunused-parameter - there are far too many places where it pr=
oduces
unwanted warnings.

	David

