Return-Path: <linux-kselftest+bounces-10806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB68D27FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 00:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F301B273BD
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBC13DDBF;
	Tue, 28 May 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKeCzv1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E213DDC5
	for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935079; cv=none; b=WgGn4WJZEUlJgTip2ULnkLj9v84ewG71FVGD/YQa6K2TXSXEfgGE/1sNSVgb0xR1ueHy9ntU+Dg65NZOOLaQjsBo0SUZaEZXraUWmss4ZtZ7yje3wBUks19jOx9aRjOBV4rEYeiwUr2K8ytK89CLQXzdoCVIVZfklJsjGt2rt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935079; c=relaxed/simple;
	bh=GSSEWukZFE2Gu3pijabeLIdOL6GHuqpyPZcN0QTIm28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gewnEy1jBBw8Dcc1jK8+Z6vrPK3x9b9kTt8jKSPtlTYvAg1LqwkiMjSEeEmSdggLD3SwdKZtpEP12eVVmkaXUDzu5lggwY+nsCSrDSKixyrTVtUFmu2+h+5AYFa1YBceLBLUU3N2/NxgUsw9ri+ZjVkhwDx3CjJ8WTwWXKJ56Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKeCzv1/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso6584a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2024 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716935076; x=1717539876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSSEWukZFE2Gu3pijabeLIdOL6GHuqpyPZcN0QTIm28=;
        b=aKeCzv1/jYgKygQAlr+iNSxFuVGfo3POHpZK1q/Y6zm92EoWuzdK8V7Sa3nUJZoUXh
         JqpG1fJeaEiEtLGoS/Qy9S6usn9z4SHt9kv/iqKks91myQWrFi6hkd6MAA6gOScj4QuJ
         nx+I1WvSBeWOxhRXNHYk3QAETrT54I3yY1IN3A72PhGu24WeoEKv6pI1r7RZXjWEl3G1
         C/SJDkLU9gxX7T0RBj/OfQbfRXzGclrJueSlaap7YmzhJxajTRAXGg5G5IELG3JbjJa8
         I9PANMdLbPcABZuV5IdaW2oa7odPZBnQnuRLvMcTcHuf6+cVczvADj4C8YczwpXJLDNZ
         iMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935076; x=1717539876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSSEWukZFE2Gu3pijabeLIdOL6GHuqpyPZcN0QTIm28=;
        b=NHnuZNbVqtJyAZrRGeNzZw3j0gKVs8wZuUL51L7Q7X7dBinxJRLNl4+dxj3ya8bz7M
         bs8phHtLM6flPJVheGQoROlGfeAm7q9OrIGgHgJ2Mc23RJFNHymrqJtY+8w2jOh8vzOm
         ER6j8RT7OjfT9CKVpjoZmvH/ESWwfLb5k3jqCY90rAKD4iG/wJstmKoUXCsKUusc8FgM
         uhwSE5zruc1cj+VvFhLgV4SnrDeydMwoFHLBD1IktvfHRcGN06+R4c6MTR8H9QgwS/Lc
         kpQor88jjNuv4nOfJdCVnBj6FR8ldVDCijkTsjEPO9FTauxukUYOz1te+cv3IXXPm8U4
         l7+w==
X-Forwarded-Encrypted: i=1; AJvYcCV8W8tSTNXW/tHl+0L7XOaO2O5p5vTZ770V3WHE0fuyUf6PicuDxkTWt6mipeDGWA4rAkq0zyt/cvcT1hv981g0HGw9lr9nZ9Mk3ZyX+3Wn
X-Gm-Message-State: AOJu0YwtFHlRU30c6ZeJ9+06txXQqDPLJES8nUPCFKSoMcvChUbmux5z
	8AKVYMFeZIKUxHZDSQE6AfIZn9CeGT+2ThfeSvRyDUMt46uwlLhKCx4DzbmLPNlw1t9aJG8zcRU
	5jLXoiDt7v5+k++DH0PgWXt/5xuT9Ubrv7PVz
X-Google-Smtp-Source: AGHT+IFH3u3WiLbWyZD6sTqsaAWhFG+2x5wPCWYFrNFm4bc5hVfvSyoLJaVBFsdBHGMrup5HuCyUU4cYpTZ6jSKz8xw=
X-Received: by 2002:a05:6402:553:b0:574:ea5c:fa24 with SMTP id
 4fb4d7f45d1cf-57a05d20d22mr6096a12.3.1716935076207; Tue, 28 May 2024 15:24:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503041843.99136-1-jhubbard@nvidia.com> <20240503041843.99136-4-jhubbard@nvidia.com>
 <dbca543e-224b-4fa5-ba23-37f4957ff79d@nvidia.com>
In-Reply-To: <dbca543e-224b-4fa5-ba23-37f4957ff79d@nvidia.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 28 May 2024 15:24:09 -0700
Message-ID: <CAG4es9Vi3Kmvb0Nn2FNGmVL2YB_5qcJHunUaTRuSy=mkiLhb0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests/futex: pass _GNU_SOURCE without a value to
 the compiler
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	"Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 2:05=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/2/24 9:18 PM, John Hubbard wrote:
> > It's slightly better to set _GNU_SOURCE in the source code, but if one
> > must do it via the compiler invocation, then the best way to do so is
> > this:
>
> Hi Shuah, Edward and all,
>
> This patch now seems to be obsolete, due to Edward Liaw's comprehensive
> fix, "[PATCH v2 0/5] Define _GNU_SOURCE for sources using" [1].
>
> [1] https://lore.kernel.org/20240507214254.2787305-1-edliaw@google.com

Since we're dropping that patch, would we be able to merge this one?
This should resolve the futex_requeue_pi compiler warnings with Clang.

Reviewed-by: Edward Liaw <edliaw@google.com>

