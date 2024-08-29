Return-Path: <linux-kselftest+bounces-16716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F2964E44
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7008280C87
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF11B653D;
	Thu, 29 Aug 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sqMijjQx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76F1B0120
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957940; cv=none; b=pJu8kg5atx/fxwkycY7wCzz+pBe2XvBGq+bUut4H6pVhgW6h8Ht3WPseN330id+EKod1dy4LN0OXWNOXuZg7D1Wz/eL9/slOJvdSPhXVgfaWUsyGd3APmiqPS5dfq7JpUX0viFNhYfOO0EG5b/lFgX5YGrnlBZoFEn+Zquibl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957940; c=relaxed/simple;
	bh=xsRSgIsQ/tC60sj9NqtRerHdmLXTBvsrxDHWslnhx9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoOkFuhn43C2rWhkcXk9MJodiXdR7yKfofHAA6TXdxcPFoPXVYM/zz4wokZ2RPSvV5oMVE5j2biBt9CGp52Fyxh1ZHweabR5Qn21ftYqjHeOOE0BMb8JU+jKp120UnGlZ7Zo/KIjGLgCGbAxE/gJlzbgFyGLCkgGBnwlu0ZeGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sqMijjQx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2020e83eca1so10800745ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724957938; x=1725562738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89BbrLIf7kQE/AhuaB+9K4RnLfbpD4Si+XduczldDnY=;
        b=sqMijjQxvdbOpUI/kJti0bDTeZ+eGCm2hy1SA25J2w7IvjcTqekgOr539a/pd84DIp
         UCbGRA2XUfxSbACmx2YZqTpmV2BKJHiGeyzoc30mxPWYTiCAl/Sh+N9WLSrxXLooff9D
         5g3yakSPRMBhb6AEE270rpVWJZlQN4/Ci4AMd7nDmVL+oxhroGXjeF7dd7NKgdJeSUw5
         8SqIF7/hKUUvgZZ6jSg0INTHQq2bUpGrzwMArsl/5unCSTyUIqzKn4eLTYBjWmYQkrmx
         uEaFIjQB5C0GFFz+l/ALC0meyhNkin/Vbmkdxgp1m5njT+ZF/Pc/HH134eMz+jFsuWA1
         ZCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724957938; x=1725562738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89BbrLIf7kQE/AhuaB+9K4RnLfbpD4Si+XduczldDnY=;
        b=Vw+2DItFKz9NHmwtjkErqUmsEpWR/8RMsKx6G5iSzGSaEUe0UB9q+9RZSJhzXXCVmf
         mlQ9RDPISJQgaeEG2u0pxsTnOXurECMuS5xZ+OP3d9ZbHDoBQAusxjZ0HQ3G+1fI8BEI
         KeaQYx9EStaBWruQPxCgD8UAdWyfukZ8LGjFjWqw6EPPnHA667CPBjJXDGqNbMK9LA+p
         stNOqgVypbfpPixB+GJI3P0N1l8V/wHGLuS3EvO1twfByO2x2TQsbkDjh1IPHYOUlT1L
         kiNtGgEe23T5AhGqGGWDW+NoO83luEYOUHYy+BTj6CklR7zSEJkR5rocJo/w8gHxFc7f
         OjRQ==
X-Gm-Message-State: AOJu0YxLEzypZVfSGCb+Du7rma/1jo/W/IJgsbi+Vv1GxoAbhPgPberL
	3+OTgRTtpA2Z/dvXlNblPTc3n+StfuLnCjHICtWDkWxxlR/YAOtSO/xGOc15Vaxkh8mspS4JSl9
	2tVLHuhGc6fvySAzIBOpuwMhWPiHoBI+PgRhZ
X-Google-Smtp-Source: AGHT+IHT71qIoDA/ctBJ3kPlWljcUXnHN4xB684kjhkEoqpNUyivsHQFXXahybFZykdB1qZTQXNh+n4BzIdF6H/yPM4=
X-Received: by 2002:a17:903:249:b0:1fb:3e8c:95a6 with SMTP id
 d9443c01a7336-2050c421cd9mr46964765ad.40.1724957937506; Thu, 29 Aug 2024
 11:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829183150.1616-1-michal.wajdeczko@intel.com>
In-Reply-To: <20240829183150.1616-1-michal.wajdeczko@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 29 Aug 2024 11:58:45 -0700
Message-ID: <CA+GJov5POvegznZutxHZuoUhxeHyseECHm4GW5NMR5vqZGWk4g@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix kernel-doc for EXPORT_SYMBOL_IF_KUNIT
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:32=E2=80=AFAM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> While kunit/visibility.h is today not included in any generated
> kernel documentation, also likely due to the fact that none of the
> existing comments are correctly recognized as kernel-doc, but once
> we decide to add this header and fix the tool, there will be:
>
> ../include/kunit/visibility.h:61: warning: Function parameter or
> struct member 'symbol' not described in 'EXPORT_SYMBOL_IF_KUNIT'
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

Hello!

This looks good to me. Thanks for adding this. We will need to do a
patch on making this recognized as a kernel-doc at some point.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> Cc: Rae Moar <rmoar@google.com>
> Cc: David Gow <davidgow@google.com>
> ---
>  include/kunit/visibility.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
> index 0dfe35feeec6..efff77b58dd6 100644
> --- a/include/kunit/visibility.h
> +++ b/include/kunit/visibility.h
> @@ -22,6 +22,7 @@
>       * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
>       * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
>       * in test file in order to use symbols.
> +     * @symbol: the symbol identifier to export
>       */
>      #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
>             EXPORTED_FOR_KUNIT_TESTING)
> --
> 2.43.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240829183150.1616-1-michal.wajdeczko%40intel.com.

