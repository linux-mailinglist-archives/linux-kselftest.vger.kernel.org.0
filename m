Return-Path: <linux-kselftest+bounces-12572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4319157C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 22:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE061F21309
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 20:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC11A01D9;
	Mon, 24 Jun 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bh4tqL67"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586219D88F
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260335; cv=none; b=lAXjNlOUe55x190GL0mZ60rwFuHrPUcPzoqOzK3vqb/Z+tbbX0z79Zz76KC9nvHUrW2xtuEe1+y2a1NboHOEjsyva0Ygh0vXODWgEhaZq0/MtOSddgZL/XCvIDDZ6nvYWJ9QTRA1wE1geuQ//kwwa7t/F5Y5zkQAaOQTsU5JKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260335; c=relaxed/simple;
	bh=CYPMKzKXzPtEKhl5KLn1rsXOXuPsd77VL4h50H+aCL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYO7GrYAPrEtU3JcLD47YSWaJRrKby0LNkeeSAKuJniztojAjYweuk6Bulho8HqHt3zOb7rGwKcZhvw9Jg+lD87oaEvSjtTeFnMwFR4kdHTI6KBrIspDEspIiEbNMCcHj7tspYUaUUK+WkKbzbv3ID73JaulEm3kpjc93uo11CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bh4tqL67; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7245453319so306913166b.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719260332; x=1719865132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYPMKzKXzPtEKhl5KLn1rsXOXuPsd77VL4h50H+aCL0=;
        b=bh4tqL67qwrLSvvomB0GYyaZRmfZ8C7/jtMJQbLXq+rTsGgIZuiWYFNpH++Al2dWQe
         hbXXTwtmc/nJTyFciBIUyb/nFVP2i0yZv+cRV/AdaaBu5l+jIqgrzOhqtdqss228H7/9
         i8h6A8Ur0MSfXq7LyHaH1OyNoZINRlrNnrD1blCrAB47CY7g8CVSdW+lyEBneNDoMjXe
         W5zbLbwk2DQZz+HxdsIKlagFzxlicQN+NmlsCNiyY+6v5KtMiBtt3Enem/giGaJqHjpw
         C+m8Ls3NamUo4rAwDvC3+9fqEAkj692/nhnSK8M6U0ZFwGzggR/PeALd2V1pYOe2ovRV
         +0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260332; x=1719865132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYPMKzKXzPtEKhl5KLn1rsXOXuPsd77VL4h50H+aCL0=;
        b=vffKLSr3yRcGBygYjR253nBZQGs4lXvpTnp3rW3d6NUMqHTpN9TF8hLlQWnYL+nC9v
         K3tO/RLsahnMIanqNPoU2yHpRmzi9MNAiZ9DkUm0ZvJp5NRBWGPyjyGMAtff0XA/STkq
         +mMcUh+5IUMimpjHHFfrG5ffyex9SSFz2mwHqdgf0Dr+ihGAvMGhGgfsKCHqOFe7NrkL
         q3hfR4m+y9gXV25RNxJVvBBd8o8BOg4X5+7AhUhEEoT7owvJ2NbzTaaouL6Fo0sgRUpE
         iDcYb4TEE/jRuiVG2+/qq3qOq7OKSV3B90onHwl0bqnQVL3I1yUlqke0hi1CiKjYuUhQ
         vGRw==
X-Forwarded-Encrypted: i=1; AJvYcCW26yAh615gyJKEXYxf7m1GmP/cGdJD3qMxykEkwU8qQS9QsCM5bs6wW0mI6BUJQPrZirk/PITFn1JgFzlbzewMvzAAI1UB+rynAvEHVHkZ
X-Gm-Message-State: AOJu0Yzfn6175MySTCdCfyeELo73i4XoMQzkOU5y6yHVQK0PdEU9j/c3
	RIZu149EEVPQyQWAu3easFMaZJactLVyR8aQAhfOQ2cGtUhH4jmTL9CT2ASRhLYzzkOUuLan31D
	TCgEEcyuQCm0jv8xrtLtZm/0qiOK8R5hoN3kciQ==
X-Google-Smtp-Source: AGHT+IHYKa/ycS20058DIxTuE4TPZj+Ne6GJbbNiJ5FbYcQC6EiSPJWgGfnJ/EyOzoXs+/hcdQEshUVAiI2Wx8GhYRs=
X-Received: by 2002:a17:907:8b91:b0:a6f:6df5:a264 with SMTP id
 a640c23a62f3a-a70275ea47emr586904366b.1.1719260332160; Mon, 24 Jun 2024
 13:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619113529.676940-1-cleger@rivosinc.com> <20240619113529.676940-15-cleger@rivosinc.com>
In-Reply-To: <20240619113529.676940-15-cleger@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Mon, 24 Jun 2024 13:18:16 -0700
Message-ID: <CALs-HssLx_AZ_pBDECfVH7REoSkyz-=bECPYDeNZkfe59DdBGQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/16] riscv: hwprobe: export Zcmop ISA extension
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Anup Patel <anup@brainfault.org>, 
	Shuah Khan <shuah@kernel.org>, Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:41=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> Export Zcmop ISA extension through hwprobe.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

