Return-Path: <linux-kselftest+bounces-16201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E897895D9E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 01:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6873DB24CAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 23:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFF19342B;
	Fri, 23 Aug 2024 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlVnhqFC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60718595D;
	Fri, 23 Aug 2024 23:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457103; cv=none; b=YHyFGIODYfXCf1Yqzbs679SQpk5e+IZ+8aNO06euNN2gOrQ4GWzTgRd4fpwypX/Uh2YkHAOzyxN8cGh9zIP2ECKNjAgqccIHNrH1YR1Hqh1DXjVLtCitD/Sd4OVV+FfMTSQ1Q8HBmGjZNfTG42+EGECbfryjpKxX6aSisi+qwFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457103; c=relaxed/simple;
	bh=t5HUwo6cdVCM2XIrnsKrCMxJG7bNZEl/+y37rKj1YDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUCQIezrpxCM4RoJ9T9+X2Gel2UGIJDY1pP23EvPemQ9/huMx9AH/z099jwgOUchyfIDIemetkzdkspaJlTdWxCkHxKpp8jRBFKg/qKEUhHVkr4zh35XbAbZhmeLzhdM0DSmUttioqTzPGJ8gjBJuHUKpwuEaI8whtz4Is0bsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlVnhqFC; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81f85130660so117046739f.1;
        Fri, 23 Aug 2024 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724457101; x=1725061901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5HUwo6cdVCM2XIrnsKrCMxJG7bNZEl/+y37rKj1YDw=;
        b=jlVnhqFC1A0ohsMdaRmM4aDBDNKzPtv1wIuS4gbBfnGfMhAZlCuMfLuI5sBflH6IqA
         P0NJ41QmdMalP5xiAIjXKrXSgJtOL1C08j3hABypZRQNLSmXsU2miX23N1cYbFIHplxc
         zoE66wkIU8DA/uVZuilbwRUdF7kkVpIhCYYnfq0TQ8CEo8gwjc+Y4atJUtkqAjNKQGuq
         scId1lfb0glfAGK90FjdTadQy8wQngEjlg75Ta30A9yunKybXoIRa5k49jXnVL32j/u2
         0ChWGrLd6f83GEaulAPZ6yygfDE9fsl85bYsZMCcVCv3zo5r72Yej7yVfYuj7VTKAAE4
         X/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724457101; x=1725061901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5HUwo6cdVCM2XIrnsKrCMxJG7bNZEl/+y37rKj1YDw=;
        b=V8scETzOT4MsYJtyFBXvVibNriPT14jqwnHhVdrRa3LrYWJYcLSpZfdF6nFwGMUtzk
         ToiTuol56O+q36NhxBXzOWYQjEVLbDhnITVhD/82EYCfNApMTDecF1SIKIXKddEJfEQO
         u5D8EEg1VTlaYzN401Bfxs1nEZHS8Dkx5E0Dmk+EoitLuC/xR1bnuT/zanFn2kW7hqAn
         eG1Fz3NqlFfporkbUk+tkX5e+vPynUUpfZTRhTdRaxHSEGNvhHL8osdUWyIfA2UIKY0b
         /4WejrY6dYD2YPn9VQwUwbUgw6xxlnEmYtfHGV05iXfqFoPjFXfGkNDovKeCJsZH3iGl
         /YBg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7n+gWfQTxn6exzHBp/00CxDQDE/AMCgUjIY+OWCR5sEExBXWGJg4VsvKoplBKaNfIu2ccVG927VjUL3Iqr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnYFvwjnWequ+EmRWPWoluHIjBKZeSwIfY+zcqHb6vACSimu0
	LMPgRTCr7MUT7BXDQP4IDMGYGZryhvDXoci7RKYdGa6HSSi1OxrS+q8jGtzR4Pw6T70L++B1fDv
	cltiUb1iylOrz1sw4RZXCmLlCLibGcb016uQ=
X-Google-Smtp-Source: AGHT+IEOp0Aze6/p+aJG8xuawPHV4qNnF8TwSxUbO1nxw7/XjufAV+sUiSwOhvlkvDUlLkk4nl3yRB7B3Wx+neeKxkw=
X-Received: by 2002:a05:6e02:1d1b:b0:37a:76af:3fca with SMTP id
 e9e14a558f8ab-39e3bdee4edmr45457335ab.3.1724457101113; Fri, 23 Aug 2024
 16:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823211902.143210-1-jmaloy@redhat.com> <20240823211902.143210-2-jmaloy@redhat.com>
In-Reply-To: <20240823211902.143210-2-jmaloy@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 24 Aug 2024 07:51:05 +0800
Message-ID: <CAL+tcoDgq+MmNz6Eo_61eBJ2fduyxL1j+kbo_9AYtB4o3tJO5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
To: jmaloy@redhat.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 5:19=E2=80=AFAM <jmaloy@redhat.com> wrote:
>
> From: Jon Maloy <jmaloy@redhat.com>
>
> When we added the SO_PEEK_OFF socket option to TCP we forgot
> to add it even for TCP on IPv6.

Even though you said "we forgot", I'm not sure if this patch series
belongs to net-next material...

>
> We do that here.
>
> Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> Signed-off-by: Jon Maloy <jmaloy@redhat.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

You seem to forget to carry Eric's Reviewed-by tag, please see the link :)
https://lore.kernel.org/all/CANn89iJmdGdAN1OZEfoM2LNVOewkYDuPXObRoNWhGyn93P=
=3D8OQ@mail.gmail.com/

Thanks,
Jason

