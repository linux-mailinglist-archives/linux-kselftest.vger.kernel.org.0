Return-Path: <linux-kselftest+bounces-9379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805C8BB0F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A7A1C214A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD3155394;
	Fri,  3 May 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FSr2ZLmH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBC1DDF8
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753834; cv=none; b=FHGpQ6UybmY+Dx0X5Nd9Jj1wEiTFbl5qZ0/OjuD7hAmjlaxZgHLf0n8ToF+ngcxGBviDzXseAa2239FZBjBTC8VzfbNCxzi5htgLB4mEGNbarfkaK6UfK7EzJ/dQxClu3rvr684x1qHPxFS9SWF0cklgu8MvWi2gFJReqE0lyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753834; c=relaxed/simple;
	bh=WPVcs1TOpK/zIamQ+wtUWsaV9d+WzS0scr8FdFX/12Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eLXq66kQS1xzpEcxo+B2EfjnTZ6YXq/3dianBIPyvtBYZyDH663xHZRymIhyIPDhYt0OnJKpmtkSZJWdYi0hqK2CFVP4x9YGW7VeVkR/fXbu46RTFWFwWFBK+5dltyIYfR1Vmf96L9AZHS1CMWJn/s20DDE3BckhYK9+X6hcA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FSr2ZLmH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e10b6e2bacso39790391fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714753831; x=1715358631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPVcs1TOpK/zIamQ+wtUWsaV9d+WzS0scr8FdFX/12Q=;
        b=FSr2ZLmH5u81pj8YyV/fFO6Yk3pWm8h06ua+SE9TTcWl2Nr9xrcYgGPf3GDrcURo5q
         zet2haQI/ccg/TGlbBo52xghSTT2l5+d8fc1D04teiQLgQ71RpmmuXAFrgRl9GVDZ3+/
         6VEssdQW/sYW1G0OeEqFJPyNi+QXpOuwd3NjR8cCIGpwfTWpxOeLBdMGs7Ya4+B6RbyN
         qIjVU5LcG7n2eC4YR2/c/9mfmq1+n6ltIS5D0iMKqqhZfNEcmQRKwg5Uwy0KIyDDJwqX
         cxqg2fMNm6QQy8qOpwjMrvTF39zBBpxbwvWKlS6Dqyj/86CJmhZb5B0HtmLGRamowh+P
         P+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753831; x=1715358631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPVcs1TOpK/zIamQ+wtUWsaV9d+WzS0scr8FdFX/12Q=;
        b=DqbHDyvjnzmwDbcBTtfVmg/yB2rpbnGkfg7LaChZmqtWwrW1XK4mGgJ8JFTPG7bfk0
         dsu1QEIcLVQmtZK6+qQpjS8FoQrCdOpBtqxll7QJu+8OGB5Su+X120CS2EqvB2JiyZpl
         OQuK/M956eYNB/3Ouq/XfyAiLAeXsxZBr/P6GbouLtejfnsaKRqYuerPnCobjfU8oxdU
         SE6k7hzbIZqNTXpBVm6qf9bT5vJSeA9BxlAB3qiQUGx/49usOMdeBe4QhhyFWd1MbxVI
         RKWOKy48DdHuCyrQboafZhtsI2LqaNcalybJhqMSW60zpHDYO5Sg2Tf0HNB7OIj4fvN2
         y9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCULOIxo+LJMTPgYBhk6UVpkDj7LUwawLRumGfVRTPMbEE4jFt5xLuL+aMSCW3PFQubgFKaOB20p0xwg3hLXLiKkUfuydx6nP37XO4nxSqvt
X-Gm-Message-State: AOJu0Yzkrc+8Z8QAQtNUM4M1xdJUC0k0lPcrWTHRQvTwHexuopXYMcf5
	jH9K0Lv5RVTdmnkB+F5VFfeiwQfwvDeQ7URv0K5ogfGs1mIklBqf0X9lCvpEsZalu8Z5TaFNlf3
	5G9bPPsaoqiy1w7K21Z2xQ7BBwV9qS/h9sQzXxQ==
X-Google-Smtp-Source: AGHT+IGE7xxu21b/33CNpShSktw1p7c14hONSdRe5GLkslIarmkQXZLYgc3VeAksgpSpBEPHVsKNhmZwLeEcUDNOhGw=
X-Received: by 2002:a2e:9310:0:b0:2e2:72a7:843c with SMTP id
 e16-20020a2e9310000000b002e272a7843cmr1041621ljh.36.1714753831332; Fri, 03
 May 2024 09:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
 <20240502-dev-charlie-support_thead_vector_6_9-v5-15-d1b5c013a966@rivosinc.com>
In-Reply-To: <20240502-dev-charlie-support_thead_vector_6_9-v5-15-d1b5c013a966@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 3 May 2024 09:29:55 -0700
Message-ID: <CALs-HssJRSZjuDQjeDiSRYCyEnUDBKQRNCsEVPmLrCKfz_H4Ug@mail.gmail.com>
Subject: Re: [PATCH v5 15/17] riscv: hwprobe: Document thead vendor extensions
 and xtheadvector extension
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 9:47=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> Document support for thead vendor extensions using the key
> RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0 and xtheadvector extension using
> the key RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

