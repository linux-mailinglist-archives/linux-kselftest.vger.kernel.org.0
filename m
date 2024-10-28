Return-Path: <linux-kselftest+bounces-20817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C67B9B33B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 15:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9BF283479
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705A1DDC36;
	Mon, 28 Oct 2024 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQnVhn/N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C591DDC0C
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126274; cv=none; b=a2QoX2ink6OrufnPhw9Gtob1C9WD+4GRDeRIhUBURSnkh5x1ThzVDGmkVbu5grg93a4dzddQTraLTIcXXdnF9FaLUdvn3lkD6g6anhj4vxOr5JtmFA4wju5XiNvV5Q47OSZ6GHJC+zf3hxqzbrl8RKfzg9URo8wN6NxwxRuK1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126274; c=relaxed/simple;
	bh=PJVoaxehblCKmdHBph6FbwKv7y3g2I/GW3hKFWio3YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLVBHgnC1dLAW1/X4xlUuPp06fT9Z3/j0bB0d3JHoPDJV7FU0zQw8L5LnrZrGE/KyEqtWjFD+H2Kel8f4unS+IKxRvzEiAjdpoICFmKIGdcvaOFs9tnDeclIgflmi21i0nz/+U9rj24pdKIhOgN0iYaPONxcof3WrLtGc647Chw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQnVhn/N; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539983beb19so5215055e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730126270; x=1730731070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJVoaxehblCKmdHBph6FbwKv7y3g2I/GW3hKFWio3YI=;
        b=OQnVhn/N8/D6c/oj56VpWqg3JUssn7bHqdinu1yQ3JmkevE56tscPfhTlJn0REzNfo
         TSeMrV3WGkBY/fkTmKIgeGaLR2F53JXtAFv+QDbARLsU8ehJPWukvtSKl/zOKbvPXwys
         w1nklOmHodvj56yKaQA6Po9ZHM6ufz7rFK9aP+uJIMssLUzhxtoZz72sFZYSZRAjr1Js
         tvO41conZHi4LX0E8Dlq0f/DqrsL1JNk76B8oRyqG9e99sjF1ZhZbYG4lz0IDuP7FNl7
         geKWLAj6i1W78vxKUWJIcQx/v8LtwqnlBKpkwXM+/0uBxGYJ6iWI3V0lc3xfNOTd//Fc
         vRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730126270; x=1730731070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJVoaxehblCKmdHBph6FbwKv7y3g2I/GW3hKFWio3YI=;
        b=gPCAYGAaJVpmJ1k2nx9dRZ3vuTJCbiVwkMx0niyJQXe7Yd8tQ/GE/F2Uda1w4MLPnA
         Ote9gvuTqtJfaauiXBumWPBwUXUVLhhXFuIUpDgQYDvw1Tq85mSmSwV1drQs/6XHNWsI
         OTnSEqR24uhtydeA9b/O7cocXwfiP4OVkUt1wz6BJ+lhbjPFNoeQR/InVJbDFi+bBV/Z
         4eH7jMKDJfxabwbBD4mmcCsO9EXvqtSbA+uIWqkaf1dYLMQ7SW2uvrWxAabe7J9B05iN
         KqyEyoNmhgXr6c195ZiUyhLLU1d6c0Rc2+RhY4gjSrnFkp3iM1owtTjtfhTuCpMSKd5u
         C3lw==
X-Forwarded-Encrypted: i=1; AJvYcCV4x2gVfZKWwBI+wIBtnhP5IMd9L506aXqaSibVTaf2Re92lw6cXb55F2D5LTXuIoYBO6mXEHKQNE0Mpoix3LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeIWg8/n9EKrhTUeAaQ1jk4lj7KYKpBVcWOY64LYSCEtToPYZA
	JvSEzbTsr2rw24sraapcYOZNfRh1Rp2mXUHGR7kgWQEmA3a0KMBsVJh7ypZQyBlcKjMcyneBAoH
	CxWnnMMNaE9+10GDi3ZoTQe0HnpoAHbDKg1QUXw==
X-Google-Smtp-Source: AGHT+IFM0/yV2rcX60bAr1jwz7/ljMj4gRvX4g1B3bqoWSs6hvQQ1s7ThycVBCr4zTDLzqa054swjVaA1m5A272EI3Y=
X-Received: by 2002:a05:6512:3f03:b0:535:6992:f2cb with SMTP id
 2adb3069b0e04-53b3490efc1mr3742461e87.42.1730126270080; Mon, 28 Oct 2024
 07:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
 <20241025-kselftest-gpio-set-get-config-v2-5-040d748840bb@collabora.com>
In-Reply-To: <20241025-kselftest-gpio-set-get-config-v2-5-040d748840bb@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 15:37:39 +0100
Message-ID: <CACRpkdZONPzUOzYiN0+kd_wFdiF-2Vk+wKC1psmR8P9zF2c=AA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/5] selftest: gpio: Add a new set-get config test
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>, kernel@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:46=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:

> Add a new kselftest that sets a configuration to a GPIO line and then
> gets it back to verify that it was correctly carried out by the driver.
>
> Setting a configuration is done through the GPIO uAPI, but retrieving it
> is done through the debugfs interface since that is the only place where
> it can be retrieved from userspace.
>
> The test reads the test plan from a YAML file, which includes the chips
> and pin settings to set and validate.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Bartosz needs to review this too.

It also looks good though, thanks for expanding the tests!

Yours,
Linus Walleij

