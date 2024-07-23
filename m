Return-Path: <linux-kselftest+bounces-14035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A678B9398C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F8281F30
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 03:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C81513B5B4;
	Tue, 23 Jul 2024 03:54:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8F13957B;
	Tue, 23 Jul 2024 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721706865; cv=none; b=jsVcChl+8vNn22lKH5U/kMn8l815I2QUurB6PC0MrvFeBxsVYBinmsI8u1H01+d81j0RB8Rxbryd+SJm9a7ru3zY32xtjh/TZ1l5aZWEIAJZnxV8zKQE4EbfQtIIC93/KHSRc8wH1+O7XvXYkRQOdcJvKctNTUbILE3llmBsJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721706865; c=relaxed/simple;
	bh=2mfBfGvPkaBeH2hLbWeN6l9L0QxXvLWhmVsi1nmC0QY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dD0dLIrl7V1OkKpJ957A9Wvn+A51N9OgM0bFr4xj3x7vrdn6ee2b4QeCCipz3cD0utFDmf4Ms/y2UlDWzld0ZcQPgP09eXulPaSuQnL2uV0sx8LIfgX4uUdsbl5PAeKFvoD3KpNgH7k+te/eg2t7WJ7SlIlf8shNOZVR2CW0U0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efaae7edfso2171577e87.2;
        Mon, 22 Jul 2024 20:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721706856; x=1722311656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mfBfGvPkaBeH2hLbWeN6l9L0QxXvLWhmVsi1nmC0QY=;
        b=I9ec7bsv8GJodDYi/xnA5k8lutOWWfo60qhaJIMygZhlhb/cOJ1aBMm1hcbEfIYs7Q
         XPCI686hCVMRa6KTxWE5DUpVg3ME//+7T9iwAuhzowMaMJr70pIkN9aSO9sY+8XJp91I
         izqj40e4eM8WVrxxpXaXnGxpKO/vHs5WtSDk9GGFPFvIb3zOhGdMHK73MhEoO1gszfAK
         uytuoKPhgGh+1KVBKAgNBr8kFoOeJ7qyY5rVASe98FOB20tOzYNyhkPKNNPaSADSKVvM
         Jyvuvs2ZPTCrZGHZbzY3jPvXFT8QPW4LR9/2C0YLGyV0UDe6UZz6N7WKgdLNw+hWZ5mK
         0HCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcspiBE8qYKPGN9IB1bYx8bBgaekfU41RR6rwk7vsB55Q/s9LM4swN6ivMODS+zWGHiqHznGy8G6CuwOzNrlAY/8mbbrdJNvc9NBEs2KSAeY9yVsUofmNPHwXe4Pm+AGpvrVid+FU35PbAoPfbMD/HZV5NMt6ZzUkydrydeJBdu0IWhniZ3u+BTHpYuaVnaDfQom/Dkh6fxiI0aWP6rvNyZ4AR9g==
X-Gm-Message-State: AOJu0YzqUEiQWs8Q+JVy3sTrJHScTvVk7Fc5aA22XT3BjvxTQyInyxc1
	GQ6L2y42i0L3/pl0WGys5sHSZNwj4HNVBpReO/WjnOWJAccOzhl8iJS2u2wb
X-Google-Smtp-Source: AGHT+IEpgY52sXyXBs8UOnw2po47yLDH62/bZnwlCFB+BOMDHfONK9VEvqyQgBnkQQI53anO6BTnKg==
X-Received: by 2002:a05:6512:a86:b0:52e:bf53:1c13 with SMTP id 2adb3069b0e04-52efb76d12fmr5606959e87.7.1721706855999;
        Mon, 22 Jul 2024 20:54:15 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556afb5sm1432670e87.180.2024.07.22.20.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 20:54:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso19767731fa.1;
        Mon, 22 Jul 2024 20:54:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdRKgACqVlwShqgiV/z5YcnRpzNLMAMSOZ8ip4+KWncfkuIrtD0V5mlBKHGsjcBupiboSIvWbU6rW/EUJiEDLNpchR0hf5fqwwlcCQMQUpKt0PCitLCXU3dsneRHbQtwweygA/G/bZi5mN9W8RehRazuqmwl/sPAS0gP5Un1llTiAkyMuSMO+K1y1QQYgWF4qc7ntue448C1KeO/Ftkc1mkJNt6Q==
X-Received: by 2002:a2e:bc0f:0:b0:2ef:296d:1dda with SMTP id
 38308e7fff4ca-2ef296d21bbmr48058911fa.1.1721706855131; Mon, 22 Jul 2024
 20:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com> <20240722-xtheadvector-v6-3-c9af0130fa00@rivosinc.com>
In-Reply-To: <20240722-xtheadvector-v6-3-c9af0130fa00@rivosinc.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 23 Jul 2024 11:54:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v65WLShdZLBcKBUviHMWFOM4oZmwVHWzVqCfz2rKdnoWyA@mail.gmail.com>
Message-ID: <CAGb2v65WLShdZLBcKBUviHMWFOM4oZmwVHWzVqCfz2rKdnoWyA@mail.gmail.com>
Subject: Re: [PATCH v6 03/13] riscv: dts: allwinner: Add xtheadvector to the
 D1/D1s devicetree
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 5:58=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> The D1/D1s SoCs support xtheadvector so it can be included in the
> devicetree. Also include vlenb for the cpu.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Please take this with all the other patches.

