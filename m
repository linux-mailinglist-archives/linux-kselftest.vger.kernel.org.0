Return-Path: <linux-kselftest+bounces-27977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5542A4B2B1
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7943A962A
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Mar 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819C31E00B4;
	Sun,  2 Mar 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="H2w7pm/x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213AAD5A;
	Sun,  2 Mar 2025 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740930459; cv=none; b=lNTRafMObCtnu/ujuKEXK0zqn+JljOUnp1zYuy/Sr0p1YqD9Ugu0jLgXDkTNNIEzwjNCl+iDJ6xbJo1NOfinkw8yBU4EDaWEB9u5Zz+/QtZ16VgSH89qtuqi0a9psZjHjl+B7lXEUpGqkFujrTwZVkKpSKnnwPyB7XclV23JB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740930459; c=relaxed/simple;
	bh=n4tNp56tq6z5EW0Qy91aYPbEKWEtOFMdSPmch9pmErE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5nAbGdYzINHyN9kcBPuH9av8VSgrMMJRGZ9yoEJc4IJXzHJboBFPN2ViSWXdP+Ed6YzVZ6J94an/MSNqg8Lm3HezdOiedYNZpuoHqupaerpaf+SDhxYHAKequMwNXsBuraspBANO5rtvSXvT+vLn3omOyHnM7EFis7B2pslfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=H2w7pm/x; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6fd64eea9c1so7382587b3.2;
        Sun, 02 Mar 2025 07:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740930457; x=1741535257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL+Pb6+3LP0e5E6K/WXHBL7Tetw+ktOPyQjrugSsppc=;
        b=H2w7pm/x9XezxJONaS75/tZamde1+TI8b225uYfCTsXBQ4heOv3MiO2/XiVjkYbMY+
         S2a53nsHGm8XXohXvDqQtjOiIEv5rGD/sOfifqOQPEYvr8Sz3KwIE2O1IlbLmiBDIm+F
         2HAkI5/MTwiE86DpZUCbrYfDNzpB9aB4AO5nrP8kRQjpn5wDPjVtm8ztIxE6YVHP6ZNS
         h6fyp+sfgNxe/So73bnSZgPXe6rO15PBJHwtKJaezTXOvtNUh2hpYBifHKa3XI0tAZBa
         ILnuGoCXNE+H6lsEl162yfEXQyMUWfa4H71zBzdtTMNRmcpoKAAySf6No5ezvVwoz5JY
         SbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740930457; x=1741535257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL+Pb6+3LP0e5E6K/WXHBL7Tetw+ktOPyQjrugSsppc=;
        b=pCMdlsRqoRgMBU0I16d7B6qvnaPmrN9nO1euknXakutARd6dyAsO+XV0OyZiDKYRvC
         BwDg9u6xaAbENRdkmSzmtXPZ+2zuoRGfSe8jD5aI8AS0e21i4VBsq8Ghdokh+GmPMkt9
         IaZqUPn7r/9sQ6BphwmxOSWaruCnaMMkLxTrTyxLupks9mZKnBhi57o83VYii6YIp7wZ
         RUtrdZkMDHVazTtcoxvknVNxy9bouatQKKOkv72Gvsuw/i9foPNUtYhRlVqPOPOllCJx
         StAtRHnXga8ej5tCX9np28D1lJ+CnOmM+tZzUQUKRb+8AOqJy2y15G8A0+UoRa4ZtZgB
         /uNg==
X-Forwarded-Encrypted: i=1; AJvYcCVKjJMM3UJSP0Z0RiD8AVUST1OHktmnaTYDS31ij6LaaMYPE9wFUPNgjJgL8ayG9gkzY2ZQazKyik8SmUk=@vger.kernel.org, AJvYcCWiiM2zMtow4qc6v9fwRVJ+P4aUbu/c5d8diu7wpm1Yobd3gshcExqymfnWKnK4SDkLxnRT/eF7eaGxAgOxJCfx@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgI3vzOqs8mMN7aSOAo3wlh4B46BdRMFmbTRysq+lTav7LAhN
	0Ydr8YoRxdJ3cYNwmvY1vaJpEjxYGh0uma4CZvzlNu55mMwgo95//Rcwo7eF3ATVHqYf4vkwii6
	QF0PWSvYw0Y1LGGPTc0d6MCC8yyU=
X-Gm-Gg: ASbGncvN9ofwM7gDF+NNlewLMdqenHFFu4sZ4CTleeo0uwTU1RrpTAdTulDJ6in5Pyy
	RGlDR/VM6LYK2vF8kF/U8txOe/ZLfBu/hIiV8rvGwmmqsyJ2B4YqimEHHCZRgAmzwdAlxqYZT7U
	aBhoyvdLNVF1fPdoDSeB+mfEgt
X-Google-Smtp-Source: AGHT+IECfeIaLvATjf7x+fKIEl9KKhtoIMwfOdbC/luMAZVqtF6DjvXHnsacHL30hRniywMWTxjOHNruJyO4D9foBM4=
X-Received: by 2002:a05:690c:360d:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-6fd4a15e96amr135680557b3.32.1740930456795; Sun, 02 Mar 2025
 07:47:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125105240.44219-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241125105240.44219-1-cgoettsche@seltendoof.de>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Sun, 2 Mar 2025 16:47:26 +0100
X-Gm-Features: AQ5f1Jo4-nZ2PKhNgmOMUX9U6MF0Mz3tvRHEWQV-RQnSBNgDnFm30mQewFKZxuU
Message-ID: <CAJ2a_Dc1-KSsV9aS8P0x4SePRrjO228wRF=4=5f18wAk0G+AAQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: constify return of string literals
To: cgzones@googlemail.com
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Nov 2024 at 12:36, Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The function kunit_status_to_ok_not_ok() returns string literals, thus
> declare the return value as such.
>
> Reported by clang:
>
>     ./include/kunit/test.h:143:10: warning: returning 'const char[3]' fro=
m a function with result type 'char *' discards qualifiers [-Wincompatible-=
pointer-types-discards-qualifiers]
>       143 |                 return "ok";
>           |                        ^~~~
>     ./include/kunit/test.h:145:10: warning: returning 'const char[7]' fro=
m a function with result type 'char *' discards qualifiers [-Wincompatible-=
pointer-types-discards-qualifiers]
>       145 |                 return "not ok";
>           |                        ^~~~~~~~
>     ./include/kunit/test.h:147:9: warning: returning 'const char[8]' from=
 a function with result type 'char *' discards qualifiers [-Wincompatible-p=
ointer-types-discards-qualifiers]
>       147 |         return "invalid";
>           |                ^~~~~~~~~
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Kindly ping.

> ---
>  include/kunit/test.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 34b71e42fb10..ae1b57578476 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -135,7 +135,7 @@ struct kunit_case {
>         struct string_stream *log;
>  };
>
> -static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
> +static inline const char *kunit_status_to_ok_not_ok(enum kunit_status st=
atus)
>  {
>         switch (status) {
>         case KUNIT_SKIPPED:
> --
> 2.45.2
>

