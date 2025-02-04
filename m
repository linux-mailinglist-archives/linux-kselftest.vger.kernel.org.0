Return-Path: <linux-kselftest+bounces-25654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E4A26F4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C73188708A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27736208992;
	Tue,  4 Feb 2025 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrLz3rM9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325F209668;
	Tue,  4 Feb 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664883; cv=none; b=Z72MS3S6B5D8/Hk+9HAZFNZhRu41mvAzEy+WKgPp+5s0DxMt9iNolQK2I9FN90SrquBxReiz2asZWOWTp/Nt/M+JngkQmuhtiFStZzuWBivzDAlzfKbiROcZ7t3GMS5BhTmI8+JG3HB2YGIFYr/ZVe+/Vb5As2zg8OvNLdN8XnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664883; c=relaxed/simple;
	bh=GDNJ1opNuOF8/5BeQvbQ2T7pyojBtKcNZzF3uVADj2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ/dskSJAelwSDfhSGVmqU61LN85w6TShT1pCHSwCsm+m+l4ExlPhlONECnwayj/7YKnFXaI37eHowXmMxp03Dprg8CLnja969RaiaPxVY2ZepfaBGjT+24xnZmr/oARMq88+3rLH6TmPc6mdKlmyXMLJtnBgoUorOXBsPrOr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrLz3rM9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-303548a933aso46125931fa.3;
        Tue, 04 Feb 2025 02:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738664879; x=1739269679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDNJ1opNuOF8/5BeQvbQ2T7pyojBtKcNZzF3uVADj2s=;
        b=YrLz3rM9tP72BJYKE97RdcJoIKKxqvXe1R4JCXGLTtWmsIKWobE56rEjpaH+mFapdt
         ePm3ofF3QNfIXQ40joOi0I510Vc0nYDuSDlhD7Gghac1BU8aWAzInjpwAQiMP4mEpvf6
         PNDNsA8zLL+KdYim+3iWhN0K8gQmIyFGfmAkYiYKG6hhdBTay8YqZRANUZZ/cTrWrwJC
         Fbe1TWmPIg6a6Pi7w0biGuEIcwqHfSulwteLXmQ9YjkxNZYlVzUyagUygBiVzDxIZyn3
         uUQl+IVcX5S3c+KF3+C0nGSrNdRYPiWr4Hby5PCXmyRqoanu1duara/dOKk9BkChnTSE
         jOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738664879; x=1739269679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDNJ1opNuOF8/5BeQvbQ2T7pyojBtKcNZzF3uVADj2s=;
        b=tXbBcj9Vg9oEfotzOgA+PBrvxtKcaYGo44K/XWRm762JwZNIOiE1JPyZ7S97nyZUlo
         l1g7njIAy78wYDjYpagwITRAg71EB5upzXmcffAywCIkbb8UJWKI8vLCC/ubV94AULFU
         agqaRXi4uBaL5PeUQpi5drPKGk8daUCzQ4eNqnQJUSKFBGubUDVOlWPgTtggQuhqGFkl
         sf8HWCqXKMN+FkdDNKiJhIsHy+gvX4xEw1H2+uevi6gzKewkFi/7/xlXOcXS6WTII6LA
         HG1JcPjVTgkIwMkXn0K62Oo+YAWKE93F6JlwaHnyg846l/5xFTxxVp3cM1wEOKB575t9
         KPiw==
X-Forwarded-Encrypted: i=1; AJvYcCWZiZWbyrqmiTGOYRZ4kVqonyQnE5zOv8QkGRjFSLaFT57C6xEVt0wCnNtOKVBoFIjCLLNyEbTChpB4vC4=@vger.kernel.org, AJvYcCXeDJR7JjQjc3iszD4gA4vo+1U1/pTqFCDy1Rch5BCh/XKFTvSRE59PRsUq6Ba3txcVznr/E5HXoEJp8uVm8CPP@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFabNxQLxASvKmpTHIIOS80PQ4BEIdhaWodvrHQ24xbA3ctV5
	29/iGVNyzKkYpZCCS530T23k6WVy2+zpjot7d1G5+3DdLWf4siOzvehG8zD5eiHxLvEeUHmX/Ww
	PCsId2dp9VbamlrAN6jTuT7831aU=
X-Gm-Gg: ASbGncv67t+WXcTpQnsks3TehcdUFSUb1YwXhkF0UoCcWE87+ddKbGJupnMbAo54+Af
	uDTE3SiUX0dzgZFQWFZhz7t++NF+SNvUolAyQfq5z7Wtxc7tDIfXJCntzDxFixddBXMa5iLitgn
	o3RJTbL9GY8o6tk9VRNf6JEP851KA/7iM=
X-Google-Smtp-Source: AGHT+IF3y+pQToRsuKmXjgdJJwSNNFZ/slj7amq2JiOinNvuwZAZ5tItYwjL00wD3TYbhu0I2c6sf7W1tOo5I+/7t6Q=
X-Received: by 2002:a2e:b889:0:b0:300:3307:389d with SMTP id
 38308e7fff4ca-30796856d8bmr86432751fa.19.1738664879156; Tue, 04 Feb 2025
 02:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-scanf-kunit-convert-v2-1-277a618d804e@gmail.com> <Z6HSFvvgxFVGDQeI@pathway.suse.cz>
In-Reply-To: <Z6HSFvvgxFVGDQeI@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 4 Feb 2025 05:27:23 -0500
X-Gm-Features: AWEUYZn3u7sGMarORTNVHRVQrUotRQwagiBBrkddQ1Yn4s_Xa6EU08cWyPe5tSA
Message-ID: <CAJ-ks9mfmM-SzkEiJsKL56jSuyXzLrKd4XHgRnp63C9AYcDoAA@mail.gmail.com>
Subject: Re: [PATCH v2] scanf: convert self-test to KUnit
To: Petr Mladek <pmladek@suse.com>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops, meant to address this in the last reply.

On Tue, Feb 4, 2025 at 3:39=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Should this go via the printk tree, please?
> Or is David going to take it via the kunit tree?

Going via printk would be my preference.

