Return-Path: <linux-kselftest+bounces-28440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5479A5599B
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D353B1732
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB0E27C17D;
	Thu,  6 Mar 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YGM4j/M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73727815A
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 22:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299807; cv=none; b=l4kPKnJRkqO0RIt6xoE6UVIJMsTQkIFmvFRM+FF8AOqPUb6HKG4TBq11sfaIs1jW6jCGd2OLdPanAiiKgoaJcFaQrQ4R/dwI/Ob4QgCYt93AJXY3c5htOTpkrqDSvA6m6/OL/rqZBNHr1JQdSdJn5eJ0dNDWrw0zGW/r0an3c8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299807; c=relaxed/simple;
	bh=AEmzCchJ1DRyZWxKA/ZhZ5o79Y5STH9WWwM7vqwuxXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPgzftpn6Vq/6rD+DQEienO7rPuKlpoplDmvJPvFvu7PaoMLieQnnVvWLxYkQjsnRxtZXkj9ztPvBOQHsHyHN6JleYo0RJ5Hnh+jDJh6EDGxr3N+pi9nQtGUmb/ue8Mc0Et3JT7URgEAO7Qupko+HQ27EL+d2RZ531GzV7msVQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YGM4j/M; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30b9f7c4165so10328411fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 14:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741299804; x=1741904604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xQvs3PYqzuUxFH1k0ZgLbrdHIOglHHb7p+NSV0/fAE=;
        b=2YGM4j/M3KXYo9Y25sWjg2g0+HBOvLrPkDr0UdaO+zjRD5ftw6djz9USxo0KnbLhri
         ZUZ06Kij4sV2lf3mFKHStbP+8fJOc4fyFL672AU1U0HGMARIx0jX2nH/ki3YFyUUIxX+
         2qyJ6tFUaOsEh7w1N3cCAx7/DNBatOm7LwzdzBv9DIRuz+RCpegexVV/n1Tv1T9id7IR
         nIjEF8WHZf2KrcD1QAdlDfrYMI1b8L1YgmpWpWrVho5voai5byQmYe/5YsOKPEZosuQQ
         QcZ3Y/aFmbA3FjznAodLbdsF2kT2ZUvtYLJ7iL8k3Vf2ordwMmXPNed6TpLW3NVQxR+s
         rAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299804; x=1741904604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xQvs3PYqzuUxFH1k0ZgLbrdHIOglHHb7p+NSV0/fAE=;
        b=NJVNC0dRJzmlFRzpYndJTslr6HUV1DVGPSSEnI45zOcw+EpRFEQLYF+AtDzrsw6/Qy
         VHeCaZmZhZPVY4kTfPOde670Dz35tlJ40ZMpj9ANjebEadsuuR1Tr/N1GriEEJGNb7ui
         Wd/BaHyQZoBV8hBS/jFvkoigG9DGKwYWURb9TRWFbeSCB+xQLH9zEP/6/PCEGU0ULgLw
         UwRn7GErQVacEZPtwm3TxHuK5Wuyg3dgoPGN4WAHkKvXBZl8TVE7AqBoiQ6BzNiRakJ3
         ISY0KKXBuXZiJj5DNpXoNVSe0ZqdfPLSQceFcXxQGj9QX9kFlES8eDoHsSek6n7YMdsd
         f1BA==
X-Forwarded-Encrypted: i=1; AJvYcCVpkEhQyc9z4u7FVzSaBYOrlUFYGPwSc1oe9EYVY2mpC0BXT4sPeX4qSCu1VS9IoYgEFGf3yxCS7N2AjfjVHjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pU/5FwjDCfZxn9e0DcukFhUfIzW9BbJ4WXyxWlmZv6pN2jAk
	3txTvpk1NQYEVIMbhuCHa1QhlKt8tBzPxQIb71765VTU4lsTV67YzVZ+GHiBOjMVTZJgjczVEJa
	1DYWgUTI32g0BajoFNNOuxSG5wOhgOsQ1bmIf
X-Gm-Gg: ASbGncvqhEXG4xQdJpetCyMRmb/dw18Mv4raZ/EGrhAXZAAl0uUeu5fxywFLbJn8OQC
	17buo0L52a3V2B9gUnJliAWHPMfUMNmPjE0BnBX2fj6+YMYbWRR/sJvCDfVxGiDD2/xJ76NLBxn
	g1PMPPg/TyNkbH4cJX30ONxdvAzdb3YyhDq9VNf8vpENEhwpf1m9XcVIdG88s9
X-Google-Smtp-Source: AGHT+IGHtsEQHMxiMAebDSsZufzsNN8c2ajNDWSBZRqthclOH/P1cMAaTSDIrG7A+0o0UBPRR6TD20BBkGkjJKdJP9c=
X-Received: by 2002:a05:6512:2342:b0:549:55df:8af6 with SMTP id
 2adb3069b0e04-54990ec735amr283164e87.53.1741299803974; Thu, 06 Mar 2025
 14:23:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306171158.1836674-1-kuba@kernel.org>
In-Reply-To: <20250306171158.1836674-1-kuba@kernel.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 6 Mar 2025 17:22:47 -0500
X-Gm-Features: AQ5f1JrgAgKDWKhZ421x_AiYkN0k4T8b0AWao1AEfLMfdCe2Zy07Uuw0ZYlPoMY
Message-ID: <CA+FuTSemTNVZ5MxXkq8T9P=DYm=nSXcJnL7CJBPZNAT_9UFisQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: add path helper for net/lib
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	petrm@nvidia.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Looks like a lot of users of recently added env.rpath() actually
> want to access stuff under net/lib. Add another helper.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/te=
sting/selftests/drivers/net/lib/py/env.py
> index fd4d674e6c72..2a1f8bd0ec19 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -30,6 +30,13 @@ from .remote import Remote
>          src_dir =3D Path(self.src_path).parent.resolve()
>          return (src_dir / path).as_posix()
>
> +    def lpath(self, path):
> +        """
> +        Similar to rpath, but for files in net/lib TARGET.
> +        """
> +        lib_dir =3D (Path(__file__).parent / "../../../../net/lib").reso=
lve()
> +        return (lib_dir / path).as_posix()
> +

small nit that one letter acronyms are not the most self describing ;)
I would initially read this as local path

