Return-Path: <linux-kselftest+bounces-15923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FA95A671
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6D81C2096E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909E172BD0;
	Wed, 21 Aug 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b41vSEYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEBC16EBE7
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275334; cv=none; b=FWEZaOmAjGPNo5GwyamgT7OIaXqv/hgy/5NvZmxIkhgyItQcOCZ6wtcZ+3u7NUFz8Qr+i5hRl7GANh/NOXk8KQxGJDYDQV6bHc2A0RhNO2bn7zdoUJB3TPk+8wL9/orS5kZF0cs8aF0Zh7j+2Z96BVk5lGqeoEWeE3xyjrnzDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275334; c=relaxed/simple;
	bh=ntbKdbbBk0i98nyY5K/WmHuG7ItsUWbGHqYEkizX4Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atuf1rT5KtmJAgcLvm5f26oxqeyNhgflo+FhvdW6kiak2T2bMA0JRRclZW2kLplNV1blckWITcoBvyyx7X8XxLLeeQcjwNsCaG7rHSKmpjKn1VxlMKNrxwnWdbIaMcshlYJ/7GPRRhk4T02YipCXXHKwip3FNafqcNvz8ggFmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b41vSEYJ; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-498c4d5a912so30223137.2
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724275321; x=1724880121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HiUh4b59dwG4o3FaldcFPlV7Fp3WZ6J0gNjT5dOiLE=;
        b=b41vSEYJd1Jc02SZZCVMbM9l3tZ0ksfT5nmY0ZL1r0scxJxay6XfZjE8jvzawqhFaF
         EtrbFgxFcC0mCXQIWBCyZ04Un7oCyudMIziUfGB4UTxx3jJf7vOhGGIjAsuE2PuazTRP
         l84ZMoGKKs/p+Qyu35+PYfblupuBKNPb9R6aXfahLqy79nk16u9MuKRj3ZL8qky332we
         tcWRHjRPw2TwgnKxOu1Ofy7FeP3gOCzA30A2OfLetQ9AWrnazI/3dUB0xp35m7PLzxkh
         J0LbMReMjg9Tz6GO+P4yjJR8ixqtuL5M1FFfu8RAY0YntrjNKM36Qtz05eEf9CzVe2n5
         2HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275321; x=1724880121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HiUh4b59dwG4o3FaldcFPlV7Fp3WZ6J0gNjT5dOiLE=;
        b=FMcLTn22MCD4XbR+pcJgsRrOonBBtCRQUwDOe5JOTHUVnPFPWfkwN7sNwnCO3FJp87
         4xvSdRFrL8FQFNpvvgnuZtOEwlTG9j77X+r5J7wy0zi3VtVjosp16k9MtBWm1ryH466V
         HzNAKO1xhiYqC3h3JiksQFgb8Oz0RwYor7A4ofdN8qqx/MIuv5w8HIbOuDg2eEwbcv21
         bLCM/BVTgfflmLojSelJxer4WFxv71q1GUuLayI8ucoh9XuEhe0Az2nqOULyk0WiDHZj
         RXd7Y1/MgTkGz4I4qP9IlP2ePY7cgLz7DYQ4a4QDpP0t0zvtOjIo6KDozAbx5CC/yAlr
         ixiA==
X-Gm-Message-State: AOJu0YyoV+MWYRArJ+0YMRFoALCzbVUuP08KpM6JRiUeQ7FCYX1pQdJ8
	qc7L4Wb8iTB4zdClNbDIIfeLS/ClXyXTctnMLFhNiQjTATKtDWSUdKY/Imff5frFsNhpGHMHLen
	v3zYXYhFkxfQxNyP4gyG8awttiGT3hSao/lMFAsldKrStmoolbw==
X-Google-Smtp-Source: AGHT+IECA16iHqmn7np+PZJGODOZrtXA2/mGVr3LhBZycPj5G6SZvoWcXueqC4dtOfzdw0DvOt1hYTxDu73Lu3Yk5Mo=
X-Received: by 2002:a05:6102:4a07:b0:498:e25c:738f with SMTP id
 ada2fe7eead31-498e25c76f0mr960409137.18.1724275321303; Wed, 21 Aug 2024
 14:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821144305.1958-1-michal.wajdeczko@intel.com> <20240821144305.1958-3-michal.wajdeczko@intel.com>
In-Reply-To: <20240821144305.1958-3-michal.wajdeczko@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Wed, 21 Aug 2024 17:21:49 -0400
Message-ID: <CA+GJov7-Mab1FTHA9mG16_1EZD2UgaUK276rUcJKenrWc+oAow@mail.gmail.com>
Subject: Re: [PATCH 2/4] kunit: Add macro to conditionally expose declarations
 to tests
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:43=E2=80=AFAM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> The DECLARE_IF_KUNIT macro will introduces identifiers only if
> CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
> no identifiers from the param list will be defined.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

Hello!

I like this macro. I think it could definitely be useful in declaring
static functions for KUnit testing in the header files. So I am happy
to add it.

We should also add this to the documentation at some point. I've been
wanting to revamp the visibility.h macros documentation anyways.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!

-Rae

> ---
> Cc: Rae Moar <rmoar@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  include/kunit/visibility.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
> index 0dfe35feeec6..1c23773f826c 100644
> --- a/include/kunit/visibility.h
> +++ b/include/kunit/visibility.h
> @@ -11,6 +11,13 @@
>  #define _KUNIT_VISIBILITY_H
>
>  #if IS_ENABLED(CONFIG_KUNIT)
> +    /**
> +     * DECLARE_IF_KUNIT - A macro that introduces identifiers only if
> +     * CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
> +     * no identifiers will be defined.
> +     * @body: identifiers to be introduced conditionally
> +     */
> +    #define DECLARE_IF_KUNIT(body...)  body
>      /**
>       * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
>       * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
> @@ -26,6 +33,7 @@
>      #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
>             EXPORTED_FOR_KUNIT_TESTING)
>  #else
> +    #define DECLARE_IF_KUNIT(body...)
>      #define VISIBLE_IF_KUNIT static
>      #define EXPORT_SYMBOL_IF_KUNIT(symbol)
>  #endif
> --
> 2.43.0
>

