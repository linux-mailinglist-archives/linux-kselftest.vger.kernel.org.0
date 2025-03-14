Return-Path: <linux-kselftest+bounces-29046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C80A6129F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CA3B05E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853F7200115;
	Fri, 14 Mar 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAdegEdJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD11FF7B9;
	Fri, 14 Mar 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958897; cv=none; b=qc54hoTIEDybL6opqErFU53IQ93Nxq2Lm+HjiFmzPRB1MctdXdSn57q+Nx/14hl30hCdmM1s2d0CYgEo8RLkxNg87leDXixyKDFkw8/nUshvmeNjZiRTVbRtvhX9KdBmi96gJfJpQ31EvRCC07CqxU0DuGwmyMDkS7/r5cv1Blg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958897; c=relaxed/simple;
	bh=hJkhck9eKlAqu//oCzwubFpPFr//TVf9JxlStCkTKLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/95fOUH2wInB5J7cNCcz+83Yl1lTC91BDzQLIpJMHJSIAMldocJOQq6HSzkQ+tvjRdMp1ZGuHLLn5Mh+MBTzJmz6i5loaZnc5h29Q9feWTXUEvLe359ee1oEhF54z4bjO+FXjDhhsaFKbDtPBFEEf+EYeLX70yNZ+rE+m+Ylt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAdegEdJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bfed67e08so22793691fa.2;
        Fri, 14 Mar 2025 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741958894; x=1742563694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJkhck9eKlAqu//oCzwubFpPFr//TVf9JxlStCkTKLA=;
        b=CAdegEdJ6UqH67x/f/dbIRvWY1m8WlmtO1f94glsQiTN97icbB8w/GXxHwVnOv5npD
         Hd0tmBlDJ0/cqUTExSVjue8tBZMAj4gEVWddXfRV4l5h5/P5AKcW4dhTn3/fIXx6A4a7
         bDtB7lnBhdBhphpYD2Af1M9Qy5CnxnZLbbrxA0DbM0ayefssM126jV959vZdAhy5jjCg
         OM6F2ZAq7BRGMGxEGWW5/AOoXcjBTzyQqDnaEX822728cUERVt9ircFPu9iaHGW4r64v
         i31CSzKBvTDUu16zv63pyP1ykU5a86D+FExmByiwKCZ83mUnZwj0cdrBZhops/gqgEAt
         2Agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741958894; x=1742563694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJkhck9eKlAqu//oCzwubFpPFr//TVf9JxlStCkTKLA=;
        b=X/kb0PC8llCsZTXM0WJuzUxjnMpH5VcYoFuGwJFkWYVYWn/ib9aXiUyL9AWQap6F+p
         2X423lwMws6fy2gtiNyEfcpo/hvNKd06AZ6U3FFsFBTm13W8+D/hkTIKNP6FdKDRVkuz
         dZ6PNHgIGXnor8g0VXAqEaa0RuMTNdPmmXkXrwljcG6Jv68Nre/v8xmftXLytsePNTmo
         L7CwsTPSMOyE7VpKcGaVydyYk8jDfsKoqHp9Ii8ACIpFaO/X41QDGPCvtmhVDDy7wxH6
         VfqJPy/oI+zg0515Ah/EL9Vm3nSD3PLgJ/5I+UkCAbf7UP6zhk/qRRh1cZOmn44sKRh0
         K+zA==
X-Forwarded-Encrypted: i=1; AJvYcCUMNyD6N2rPaK4GhwzcsIPAwWbroetgZmTEGc2vAMngP6u4Aptn1n+wloKXyBo4ugUDsP/a8sSBUPYB8pU=@vger.kernel.org, AJvYcCWAGrMfE9+9Eye/0gSJaYZpD08Wq4PrjNgu7/w9E5I9xa+9KGvE4KOicdEztIvgLrTuvjQvR5Xkw8pUnWQi457s@vger.kernel.org
X-Gm-Message-State: AOJu0YyO15rDzLktCcKUqKXWhR+2r07YF9QhsPYJ+GmOzsO4j4Gm3hPD
	ZOYshPz6ytlEwS7lGg4O2OZ8Vl2RYOoK9MY2ggkKJOl/jvdM1Z8CHWIAqf65cf640edgfiNAE7b
	ulb+ApQXm4HOcMBLAMqMcbh9PxVU=
X-Gm-Gg: ASbGncvytmaH2+NpqY6y+T+v8Ggl5WL7jA/JFgsWKvRpVLur45nM7O/sZGhTLwosdci
	8GrknwQyborRVTXndIfnorYCUinyW/QE8+exhmY0MAX2zggTjtgHTAwie9tOo2ArtDUfofz6xNC
	pJwUWkN5f+2Wu+fSJ/7+FDGVN4EUJ3zqWC1dQu5DPzZki7fM6HHv7hUOcNB6uq
X-Google-Smtp-Source: AGHT+IGltqnNzbbPxyZjh48Kw9hUyFNMEZtHX9cS6jzJwICDTiMlr8xsSK+RT4ckRDikKMa+S7IUHdkAJDHqKy8YI8Y=
X-Received: by 2002:a05:651c:a0b:b0:30b:b132:43e5 with SMTP id
 38308e7fff4ca-30c4a876b4fmr9290251fa.19.1741958893645; Fri, 14 Mar 2025
 06:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-scanf-kunit-convert-v9-0-b98820fa39ff@gmail.com>
 <20250307-scanf-kunit-convert-v9-6-b98820fa39ff@gmail.com> <Z9QtUoFdCoTXnkzE@pathway.suse.cz>
In-Reply-To: <Z9QtUoFdCoTXnkzE@pathway.suse.cz>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 09:27:37 -0400
X-Gm-Features: AQ5f1Jrt6C1V2agp8ifeW-hCbBYKoJwEJUU1PdkbNliBXgvyfjTA2ixJ8FIOf_8
Message-ID: <CAJ-ks9nFV-jh5wiBFzabXaE_nx13s+4R4wVZ+uqP7zm0-KGfAw@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] scanf: further break kunit into test cases
To: Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>
Cc: David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 9:21=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> Thanks for trying this. But I personally do not find this as a big win.
> It causes that the test log is longer than one screen and thus harder
> to review.
>
> It might be fine when running only this test and running it only once.
> But I think that it is quite common to run more tests and then
> it is easy to get lost.
>
> I guess that there are tools for handling the KTAP format which might
> make this easier but...
>
> So, I would prefer to avoid this patch.
>
> Best Regards,
> Petr

Fine with me, and thanks for having a look! I've rebased this on Kees'
for-next/move-kunit-tests, shall I send v10 with this patch dropped?

