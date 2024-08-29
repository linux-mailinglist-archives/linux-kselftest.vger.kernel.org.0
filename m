Return-Path: <linux-kselftest+bounces-16720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F77964F32
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F9FB22862
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 19:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4B1BA29C;
	Thu, 29 Aug 2024 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dTM9ZmZw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8691BA27C
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 19:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960458; cv=none; b=fUrL+idwVhBJJZqtmS8IrR2wDCLRwAKxV6F7rZ9/iwPib0+hnUYdRgsTBiK4DA39jF8vNH+2kxOV8XI/HReJUTsuufwCl5zmmvCeAuVG0VI5cA1Ne8U2/awG/XU3hKMftEHy7lwdFS3h1tpLwyPBOH+y5O0Xi1x+7PsOlNBXPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960458; c=relaxed/simple;
	bh=qeP7+7zu3T/79b4rxXTTPMEgHAIHkf2ZJ7OCPpbIZfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hljw9zorl0pfx2wdZoAIjLsYu+RKrDwAzjP/ZEPJLiItFRFa6QCuimSmtbvBIW5yxmsslXzw4AxoIKRjUQeEm+S5aNmDOdwWhtLoDzJdv7W/tZnlaI8oGayL1nZp++y4ZfJbUdx2mmcRZTQVEydXOa+MomoMmSm2vfJXCvcmdGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dTM9ZmZw; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2702920904bso130215fac.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724960456; x=1725565256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeP7+7zu3T/79b4rxXTTPMEgHAIHkf2ZJ7OCPpbIZfY=;
        b=dTM9ZmZwmcy63o+MDio8c2X3BNgWQ1wll/BOSL4XDXXAzSpOLpAzXGcO+skb0Vzy0K
         aV8N7iuFUHgVGxxxZdOAhxcRz3ONy9Dks3Xy+YvN2q1EyNEvg652QMjOV9T4fU1v4iAh
         +Sn1XgFgJFA6u7U7wY85sXwnVOrLY+kGmNCb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960456; x=1725565256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeP7+7zu3T/79b4rxXTTPMEgHAIHkf2ZJ7OCPpbIZfY=;
        b=CwubfJ8MFkOA8WttIDz5/F6eDVVRXDYJrTnlM8XzaE9Hs/iC/phkzPq/N+gT8gZJy8
         YtmWZX1oaWFxalTpyIV4xj1uQ1Esy4Ic+NjWnsmOWVRwe/FvTWYnDQ4IjB2nUfA0jOvI
         OK7Nd0gBkHmB+vc9FyDX9YUPLQDFUCs9tiTHKX1FKAd0JKL40yh6Do4VEE56qOu9fG02
         owl/Xf6yPXOWKQdEJ+u1FXBSSUkmTPlC+Ona14QtSWBXgoLeFhdEkYk3kLafgy8Lg+vT
         90ePnd+avYuQZD7thKA0dVv45dkS2jUHGYDvmd1TPSwUiz7gOTmVS+ygZF8gmbBsSN3F
         qVng==
X-Forwarded-Encrypted: i=1; AJvYcCXClqXKU11RkFEuacFzOep8+NxnMQM219VoozOv1l5gTm8AiS3b71mi6zIZJV1z9m2PR3i5npxaZyHNgHbLigI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8JW5Oo2Lr10yL9D9dn+eqRNhr7deTXM1a5NaZL3MoeQm7qEX
	vdZb6Eyrm3Zd1o4tSa+DAGHjhGKn02nBokh7HK1QxfNI6/grSH7X2mCbZNMNMhw6AfEazNr1vdY
	uXLcWWq8dKLUQ4Nn4nAZSEXpxayTFq8HRufic
X-Google-Smtp-Source: AGHT+IHrhliVtgaPcNwC1VORZquYe127iapzTLMkWCuU1MGSlwiVFEIhF+6O72+5oERawbaaGrKqSENthMbSR8WELjA=
X-Received: by 2002:a05:6870:8a26:b0:26f:de62:7d8a with SMTP id
 586e51a60fabf-277903bdf4cmr2113653fac.10.1724960455702; Thu, 29 Aug 2024
 12:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
 <293ce8ff-10c3-46b8-a56b-a1bddc7aa37c@sirena.org.uk>
In-Reply-To: <293ce8ff-10c3-46b8-a56b-a1bddc7aa37c@sirena.org.uk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 12:40:44 -0700
Message-ID: <CABi2SkXHqbOJM_A=m2n2AzH-1DY2NQPOVn66A9QYyhYCxLeQZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: Mark Brown <broonie@kernel.org>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Thu, Aug 29, 2024 at 9:16=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Aug 28, 2024 at 10:55:22PM +0000, jeffxu@chromium.org wrote:
>
> > Add more testcases and increase test coverage, e.g. add
> > get_vma_size to check VMA size and prot bits.
>
> I think this needs to be split into multiple patches, for example the
> new test cases done separately to the additions to the existing ones,
> possibly as multiple patches (eg, should the size changes be split from
> the prot ones?).
The size check should go with prot., because it is part of verifying
the sealed VMAs.
I will split the patch into updating existing tests and adding new tests.

Thanks
-Jeff

