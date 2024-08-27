Return-Path: <linux-kselftest+bounces-16458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FB49617A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9521C23367
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED791D1730;
	Tue, 27 Aug 2024 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XyVvOM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFD132132
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785488; cv=none; b=FBPp15P7QP5Kgkqup5YbDG/HrhBBt5N6zt38MeHfFJL9DcuSHHxxToqRG0V8+9nTQXEOdKVbRNFxwfcwGzJUXvM5NlHBbcpQGZiIQIo+effqPMNNRbM61GtsOk+EKVYD8hzC8UzOqBSQCVRo5BH0kdATfpfxEZ92GQ/+twapj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785488; c=relaxed/simple;
	bh=RG3ZxtDlE3uWd5ZqmvdklkSX8pTaiPAySK1DX+KTRbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcedFvkmNytl45z+u3kOGoPnP43tD7KHdyKTM3GLPYwS0GLRR+oD+MBOuv3P97/5x4I1to53N3GFQ35Av/+vGWxWxMosoXx9mivVu86UUbeLxg9BsKVY2GXo2gWRcqM+Qxfy9Z2BiB1Arq0oolMRPndV0LiK/hgmcPTIhecrJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XyVvOM5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202146e93f6so60080955ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 12:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724785486; x=1725390286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTejj9+1ObS0lEjCmOy95/zqthLaCVlILAz3efTdjGA=;
        b=3XyVvOM5zKgmbTxdM6fk/yiGnCGcgIXINxKzbROPGxn7RElagFLpVbVaeggiMOP6aD
         6Ns246NMIcK3B8V5fpIbOSm4sBP557ppQjXWFLCV4mZXroGU60T47qkzUhTiayBCadTg
         FF4Fthca/VDsTDBywhHoN+TrmNCbrenEi5i5pdFCtT0K3lRFLheLXwlG++rCabkF3Hv6
         LaL9TnTj0v164h8ZaA7ZT37DrIeRkZ9ykFrBx8APHj+6KanGByqX+h/04DSeUm78qCIO
         gMtc7t/lrTokpa5uuBNlFED7j94tck2P/nlbr4I01H/SdpWmG6SnTxMUq03XdcFLoNjl
         Z2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785486; x=1725390286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTejj9+1ObS0lEjCmOy95/zqthLaCVlILAz3efTdjGA=;
        b=FyAfbLHj4z2GAlj4F61aBN3IWL6sk8JcTjPab5innpzJeEhhPDUU9Hl2d/venWnEkv
         uElQxWH3OJRVHQBaeSiPi0+NmDf/4XzKRe4cvgPHn4vCLdakzRf2z272RqAnTf+gQ+26
         bdyQO+eWUamakPtSdthNMbdSi5KBCXekcA6BgIW2VaQQ2NN75kfA0mkRFQAyzjVHjJp5
         nEzHc3PjdSrBVy213CL89kV/wviz5K+lds7XmoRiGrrS1c75guLvItrjOqNDAnYHoGLr
         zIYFAseOZos6zLF00WD0GUsC3lxX5l82arRzCyrcJQsPC2tK2mV2V0XR2GftHV7kpuLG
         NBgw==
X-Gm-Message-State: AOJu0YzpsVZsK1EBdfAHukGiKr3YlOHTK9bUCc0s+jj+5nGJHER+GjBe
	3UoZ5+lDiNv4G2HgULQdKOIncC0LbitxwwympwaP3zcuKUV2xVgtVDV5fSixdV5Ay4/xUZwKecw
	b6kjZ4ykKupMIxtMYtnQlLAXLAa8U5ii0fv9i
X-Google-Smtp-Source: AGHT+IGVHZsjk9p8HwDLfcGxFu//tM7i+IWZuyv2l1z8f46p4bWKM8I/qJEUXQXpXlM4OrllN062TVLPbC3JUNWzB+Y=
X-Received: by 2002:a17:903:11c5:b0:1fd:a0b9:2be7 with SMTP id
 d9443c01a7336-2039e44f83dmr168107805ad.13.1724785485658; Tue, 27 Aug 2024
 12:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826222015.1484-1-michal.wajdeczko@intel.com> <20240826222015.1484-4-michal.wajdeczko@intel.com>
In-Reply-To: <20240826222015.1484-4-michal.wajdeczko@intel.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 27 Aug 2024 12:04:33 -0700
Message-ID: <CA+GJov4dfR=Cv7uRhPqw3P3XP==rntYWzgCKJ_7O4AcfwD--qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] kunit: Add macro to conditionally expose
 expressions to tests
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	David Gow <davidgow@google.com>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 3:20=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> The ONLY_IF_KUNIT macro will add expression statement only if the
> CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
> it will evaluate always to 0.
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>

Hello!

Thanks for the second version of this patch series!

I definitely could see this new macro as being useful but I currently
don't see an example of its use in the rest of the patch series. How
do you see this macro as being used or do you have a current use case
for this macro?

I would be fine adding this macro without being used as long as
examples on how and why to use it are clearly documented.

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
> index 1c23773f826c..69c71eacf368 100644
> --- a/include/kunit/visibility.h
> +++ b/include/kunit/visibility.h
> @@ -18,6 +18,13 @@
>       * @body: identifiers to be introduced conditionally
>       */
>      #define DECLARE_IF_KUNIT(body...)  body
> +    /**
> +     * ONLY_IF_KUNIT - A macro that adds expression statement only if
> +     * CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
> +     * it will evaluate always to 0.
> +     * @expr: expression to be introduced conditionally
> +     */
> +    #define ONLY_IF_KUNIT(expr...)     expr
>      /**
>       * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
>       * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
> @@ -34,6 +41,7 @@
>             EXPORTED_FOR_KUNIT_TESTING)
>  #else
>      #define DECLARE_IF_KUNIT(body...)
> +    #define ONLY_IF_KUNIT(expr...) 0
>      #define VISIBLE_IF_KUNIT static
>      #define EXPORT_SYMBOL_IF_KUNIT(symbol)
>  #endif
> --
> 2.43.0
>

