Return-Path: <linux-kselftest+bounces-7865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE98A3662
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 21:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F91B22A5A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2B614F9F9;
	Fri, 12 Apr 2024 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxV6at5G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AD148313
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950246; cv=none; b=kZBkl3BZnFMOCKvgdN+VAOV5FOmfTRqDuV/9t7U9TPBjecs/3YKpHkl2Mn3wUV1VqjqdTXOTbfiEcx8iz+XQrKDfedg+ZR7YcZyynzrP5a7JibBZMAI01gPlap1jlWZBX6gkZ80jNZX7LP5teVJyAPA0rGe8ul1vMyj6UQYtlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950246; c=relaxed/simple;
	bh=xXqpfdKuwNL9Kig307Qx7iHEKaVdnd+3al7mxs/lJ/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrSoyi7FUrS34NpYAE0bO0033kQ9l/fWbGnzNEpI6tFyhBDYrESJnXU4OTx9O3KLRxVNzoICz9rw+Y8guBO9QTZ87n6IEBSeLU+Qm444ag4YQ9lK2hDPciIhUB4lECv0UAjMedmSz7ZGOW3RU4/gswgBoaEzNt3356LbTiz6FfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxV6at5G; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-417e326fceaso1715e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712950243; x=1713555043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXqpfdKuwNL9Kig307Qx7iHEKaVdnd+3al7mxs/lJ/E=;
        b=TxV6at5GrVJfg/jpU1wiM1z7wgjF4aOhwqlIQ1cd1FVf0P+s4VlfoZ+Cct0YlqbjCG
         CIxKCNcaXrN8QLMs7nFb+OyTGFJu3QVwpVOjQGd/1kHiJsx/0lj7P+mLaPX40vSwL0+M
         z5rFfEzu8gnJ97Zpl3v0QJAiPTBryXPZxDykUHJ/KZfNfK9K8d2y9Qb9LuRKJ5XxtA6Z
         pGDDAyNkltdy3kA6qeMYw02yxNjjuUeYefbpspDnh20HklcP65znu7ALciDbOqSEHD6D
         v9kBVP9hlZ6FX8VME/lorqcQzEi0l7i2hYbajTu4XDOl957uG7jQ0tOXOi9/9eTFFzYp
         NVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712950243; x=1713555043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXqpfdKuwNL9Kig307Qx7iHEKaVdnd+3al7mxs/lJ/E=;
        b=mWEPH/ApEMiddBOQ+fwd+Kr2geXFnihg3RoJaqHvhrs/K1GbV7j4yrdgUkaSufPImY
         /rQcMD+3brl9tEQHMJnWgwoy+xee041ErWu0trznyn0zQlUJCep/olsGXqeiDE1FTs9O
         S79HEVhe7uxYeeuovYUyOXocjbR1o248PCXkGVpv7XPRmqVDKqIdZOTr8LYBqxpnJtEw
         aFbG8Yh5wKxzK42uQTZmyUdx6K4Px5joK/XzmfinrHTrHH8dAMjiY0ePI+vih8JgrCXd
         A7zpJKgElMrxqZLDZAAoAmQrVcd2zKiFF/D+7KlyNmGEq77OHXqE4VfzagC+25jdytNB
         aWlw==
X-Forwarded-Encrypted: i=1; AJvYcCWQF0Ln6ZZbjTFUB6w5aupdFDQc+0WKEj+iQnC0UotPcToE5lqEJTwPAHhmXUO64T6DF7gRolnUgj3+u+1G0IyCpl/cBwsdUnhERWCsPnwz
X-Gm-Message-State: AOJu0YxjAMvGKUA8EhEe0jqqNPnCih0Tq0RwfcslR9rQaJrHDj1JDp0h
	yNI0rWBYbVV9LKmTDTv0Sj+bHPDmDBb93PxaqYq8jMFcUyyxoM6/S48RcwIxp5maBYjq6v8yOTp
	hCfWz3X1Eo0P1P3AXgQZof3UGU44gaHHcmIAI
X-Google-Smtp-Source: AGHT+IGevUffXrsP0zpzECV2A0lqZ+/gOkOlJB5YDYGLcWSxoooRreou4WiRPDCja5l0bWkxTJK40nL5YsmoSdm/uiA=
X-Received: by 2002:a05:600c:35c7:b0:416:b76e:b9ad with SMTP id
 r7-20020a05600c35c700b00416b76eb9admr23167wmq.7.1712950243298; Fri, 12 Apr
 2024 12:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411231954.62156-1-edliaw@google.com> <20240411163409.4f8969fa8a46b63d04a28f77@linux-foundation.org>
In-Reply-To: <20240411163409.4f8969fa8a46b63d04a28f77@linux-foundation.org>
From: Edward Liaw <edliaw@google.com>
Date: Fri, 12 Apr 2024 12:30:15 -0700
Message-ID: <CAG4es9Wti4JACt9KzvEW4oSX0wZyBWC9NCLDW11NXYeeOzLM1w@mail.gmail.com>
Subject: Re: [PATCH] selftests/harness: remove use of LINE_MAX
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 4:34=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> Thanks, I'll grab and shall send it Linuswards for 6.9-rcX.
>
> I added
>
> Fixes: 38c957f07038 ("selftests: kselftest_harness: generate test name on=
ce")
>

Thanks, I just realized I forgot to remove the <limits.h> includes.
Should I send another patch for that or send a v2 of this one?

