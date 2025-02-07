Return-Path: <linux-kselftest+bounces-25991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37FA2C1BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09833188AB08
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E35E1A9B4C;
	Fri,  7 Feb 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRza2sMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7C2417ED;
	Fri,  7 Feb 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928322; cv=none; b=fAmbgghF8PauWohUBlT0QSjhy7mA+8u+9KdLtoXp20OAX0xFvwIw4paQSOf84llakBDFlzT+zRlrG35QYcj2Rkmf0VzNO3y174iQ3bfAQ934cGXqm69UZxV3VGhcKoJLbZjYvAdDXNxiF4AJRrjp2F+KACU0SYJdRJCGzS59KWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928322; c=relaxed/simple;
	bh=uK+Wrw7Kt+Edw+QNCibD61gviMhefqSZIojqb+0kTgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdiIwxL7wPCJJzZSAhVHlFy10nwnV9g1t14TJ0Asw9tZQdUjKVktmppaPkemkRI/VlxmZkDl1sFm6n5EY9QwSc6GNo61lkyzndrDjHPKgMAgr55ldz1NdAJmLGgI7n8tY8ct0AqmrsfwU7HZ2oSrHs1sfcGVY0ZO9+FYqVog6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRza2sMl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so18243911fa.3;
        Fri, 07 Feb 2025 03:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738928318; x=1739533118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uK+Wrw7Kt+Edw+QNCibD61gviMhefqSZIojqb+0kTgU=;
        b=dRza2sMlJGvXkkEMRWX4K0hdj3Apc12X3K3zTiivG8yCz9cKdMgfOjVasjAxcH4jZr
         fhXX+AQFTDfRrGEaeu86A/scT4yc8t9LnogMdBnM1v+4HDPmXSIXdEeXpAA22tLzLE0Z
         ULc6PMfNstgHDfi2eUYXK1/FwPiL61PiJfdeP4MInx4pSAwsTF7dp9nSZ+MhQ+iVeWSc
         QLc9N7Kyv+gIKDzIYc3TkMo+ai8xaWX4zuuDw5Oe8FRzR2DuXc4z81RM01/c6tQYVXkP
         HZSAB90KFfgp7xn1IjYYlHT+M9HXGuNLKZNKc7z70kYyRemlXIvNT2NKTm+4Ql9FacTK
         4RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738928318; x=1739533118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK+Wrw7Kt+Edw+QNCibD61gviMhefqSZIojqb+0kTgU=;
        b=JpKUJHwOgj06qpIgfuzeElbyqpjHxqZP4yIo+7eTuyU/nQyFsdCDTYzAyLDDKqpAEX
         JmVkTkyAPGEAoYX1/f2h67U/Emteq44mzdWviqyuKssbDG0JmPwFQV8eq4rX2cKOJFrm
         RZQ80BnZ9DNMqA0flFGUy3J5jl7SlM3ZDkzjNJjCslR1qdyJVA+PC8ngHENTBiHM2dI3
         V5a6MKsf5MzvyCtvXfdlR8F0nEGTfpKT+KeE/0tM+0G9rmgGyv70vk6lRbyLFt6HZt2O
         kbtDj7awlGE/OAL9InUI2BcoezWhkRGPnM8vTVSXXZccZv29WaxxLrusX6oypyfV0gHQ
         YnWA==
X-Forwarded-Encrypted: i=1; AJvYcCV+rkIOoV9h92dKBd+tzzrhdvsDr+UDNHNIkpLjShawMVAiXfawXaPBhKr/PQV2g5Skp0agMLxgZiUjrf8=@vger.kernel.org, AJvYcCWZ3AuAkjEOGGZqurFA4Ce//YM4ZOO+QnteeupvmwaSNg+29l+B+RHuw4LosRKMGm5ui2/YkmlDlUO4MuNl12x/@vger.kernel.org
X-Gm-Message-State: AOJu0YzfV4aKEuk+ll00KjBQXplk3aq/lgusuwJcUo/yvV8itymp0mHK
	6ewzPSQLR36AK1zAMeYO6184qICs9ZxPWL9veJR7cqb85Nl3qbBCgyKEmcRzlgsfjx/6Z4w6OQm
	jYJznCaBlkJVe8SVlz/hWsaEB4Jk=
X-Gm-Gg: ASbGncvBVZKBbd2FiwivDXilh9H/VYZliyxb7MmReDEBTfSa7obUN7kzyxR1nXlU/bX
	5jI1fgOzjDgqOl/mWLdm5uVJZFx3Mh5OzzNMyrCiW7NYGn5iiQdUmmCai+8wqbvsh+Q7eQsBYXT
	gQVx6+hOI1QAfAli0FRGPrZ5X2DLkB
X-Google-Smtp-Source: AGHT+IH6Afm+9ysOOQCB3cBJnqE+ToWAhtF6R57UHO0C8PSY8eX0HV8s7qo9jlZmNIFtQdiD2KyUgvhNU8pMPZxe6vM=
X-Received: by 2002:a05:651c:893:b0:300:7f87:a4f with SMTP id
 38308e7fff4ca-307e57ff0fcmr10591031fa.19.1738928318142; Fri, 07 Feb 2025
 03:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-scanf-kunit-convert-v3-0-386d7c3ee714@gmail.com> <CABVgOSkZRage0UhVV97j=4XEV=Rg0rAAwkt_Qa=ie_K3_E6KhA@mail.gmail.com>
In-Reply-To: <CABVgOSkZRage0UhVV97j=4XEV=Rg0rAAwkt_Qa=ie_K3_E6KhA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Feb 2025 06:38:02 -0500
X-Gm-Features: AWEUYZlSA2fXU3EBIiGZs9nLflx77-YLJctvSKmc572LaktTdm7JWSX8dKJtFBQ
Message-ID: <CAJ-ks9mNTyK9Ry_ko7EJvjiXYAzMMc_RoYoYPYROnZ4YFofHsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] scanf: convert self-test to KUnit
To: David Gow <davidgow@google.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 2:33=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> Thanks very much for doing this. I'm happy with these changes from a KUni=
t POV.
>
> Two things I think we need to be careful about:
> - This and the printf test are both changing the m68k configs. This is
> fine, but could lead to a (harmless) merge conflict, so we should make
> that clear and try to avoid having them go up in separate trees. (And,
> if one gets merged first, rebase the other.)
> - There has been some pushback on some kselftest->kunit conversions in
> the past, especially if the test is being used to debug live systems
> (which typically don't have CONFIG_KUNIT enabled). I can't personally
> imagine that as an issue with scanf (though my imagination isn't
> perfect), so I'd doubt it's a problem.
>
> I'm assuming that, as mentioned in v2, these will go in via printk,
> not ksefltest/kunit. Either would work for me (but, as mentioned
> above, I think this and the printf tests should go in via the same
> tree).
>
> This series is:
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David

Thanks for the review David. Given the discussion on the printf series
I applied the same scrutiny to this series; I reduced the churn, and
kept the original control flow and failure messages.

I'll pick up your Reviewed-by and send v4 shortly.

Cheers.
Tamir

