Return-Path: <linux-kselftest+bounces-11464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E990900F57
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 05:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 632591C21261
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 03:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901CAD520;
	Sat,  8 Jun 2024 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J1UyVIOS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBF86AB8
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Jun 2024 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717817750; cv=none; b=A84vYQRL+tI4MD2ISSYegjg0wSaXVusHn4pl/jxV/DTa5pkp4B913pM4Bxd26MQip4elTOICIBuZMw04qZvXFMPzTxTZqT5zLe29fwgrQhDqqcxMEyvY9arsznM/odTTaHK1T3NvVyazY4Y/rNO2JShJxxg4fNvLi8Foz2qM4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717817750; c=relaxed/simple;
	bh=j4kcRsRoaYXagcVlc4aj3RqjZAlFJGNpamEnNXIfhXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8yPimK7w7v/RUwcAxJ5/grNqu9tf+UpxHQrYhTjtFZiSmznGvWPjGQZO7/XnEkfHIg6yUcR+oG/h1M/5YzoHjPnlSgHNe8E3UG/F8VvvtRTaHIywYZUk4n6Au+Uc42YmhQf2Jm6h5u3nKkXN6gbEn3R3zSNcdotmosJjup6tFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J1UyVIOS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25071c66178so1328302fac.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 20:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717817748; x=1718422548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KltA1s7VUNRTd1PbGmK6izLRZPTrGICXXbndgUz/sSI=;
        b=J1UyVIOSSWwXKghk0pgTpLd2QNJdK/H3TjoaxbhFwWqedjm48Kk4JZ0XICvGsYuJJC
         Lu9J0rgq577Gow367bMbHnOHWfJhLEi6D2zSBe8CJfIuNiAkrQBAYMYvAhow0Vjvs3Nb
         4E7dnfMFkSW6rg35gKhJmF/hE1fh8BTgYEDwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717817748; x=1718422548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KltA1s7VUNRTd1PbGmK6izLRZPTrGICXXbndgUz/sSI=;
        b=M+X8NJ4Ry0nbaWEKO4woJO6GQDymYfKpdI4mC52XBVOa8sSzIC4mQKEp4Oe5H5TrVW
         86yaY1/sSUNdSul1ANWcFjQoHtwGbUok72VItwSWPunvID+B9804Fthqk5ZgjYB7czxx
         WVpOlcHkNXcopjd+KBMLwSQoh4ie5dDAp3BFlUB3ctbUu9kCju3A93lDi1/JQ/owFf1V
         hT9/MrhsNdOptfeKgxYWNqAdTY/hKi/l9vOdeolZl4f/SYi/ybLYcXjLLeTNJWe8hsbW
         jcbEPz48W1ggjMQ1Hed17FrJUQ56924MGXFSfUEi0oR748KbzsQtuDB3kmem66dHmBFW
         kv6w==
X-Forwarded-Encrypted: i=1; AJvYcCVfJmfLYSKZjfVjBUxp3Wd99fT+wWmh/EvSA6y1NiyJLYKiLETuKDzKhTbURJ7ji1tJQYR7o30cmvYJRlwtTnyp2TGM5zQmM8sOMypgGfyr
X-Gm-Message-State: AOJu0Yxzhw6ivbxc6RSBNiparsdXqvhsbomhX+um5YXl/QPcrN3TM9sl
	Hr19xrOJsmxH/KnP9vgDH7j+F1HVxVUEIqeNkt0FLI5DKNCbJVttdQh6sgh2GHN/xMl9WTxM7MM
	egdkFeMrymJpNB0g4myyhucFlsnMmwhaMRCSj
X-Google-Smtp-Source: AGHT+IHe7gxzs1S7pNTTl7STORIz+GRGHc0QiiXOdUo7yjJfr589hzZyCwwwlTqDVLMo3BR50OLM0QbpBVL2TtpA0Kc=
X-Received: by 2002:a05:6870:b507:b0:254:8c7b:889e with SMTP id
 586e51a60fabf-2548c7b8d0cmr1716996fac.16.1717817747891; Fri, 07 Jun 2024
 20:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607203543.2151433-1-jeffxu@google.com> <ERhTlU0qgh7_BDdbPy2XWV0pYgJkVYImFQZVPIfvx9F9uyhfaopo8FMZa8WZ9Txx1bzq8qEez4QQ8sOQIwKeQEdn1rym1JgDmvG3zOKdpeQ=@protonmail.com>
In-Reply-To: <ERhTlU0qgh7_BDdbPy2XWV0pYgJkVYImFQZVPIfvx9F9uyhfaopo8FMZa8WZ9Txx1bzq8qEez4QQ8sOQIwKeQEdn1rym1JgDmvG3zOKdpeQ=@protonmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 7 Jun 2024 20:35:36 -0700
Message-ID: <CABi2SkV9fnVjscLzKwa6FxNzfYU64ibGQxi7VWVEaGr-3gXfOg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL
To: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc: akpm@linux-foundation.org, cyphar@cyphar.com, david@readahead.eu, 
	dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, 
	jeffxu@google.com, jorgelo@chromium.org, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, skhan@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resent, (previous email is not plain text)

Hi

On Fri, Jun 7, 2024 at 2:41=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobrn@prot=
onmail.com> wrote:
>
> Hi
>
>
> 2024. j=C3=BAnius 7., p=C3=A9ntek 22:35 keltez=C3=A9ssel, jeffxu@chromium=
.org <jeffxu@chromium.org> =C3=ADrta:
>
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > When MFD_NOEXEC_SEAL was introduced, there was one big mistake: it
> > didn't have proper documentation. This led to a lot of confusion,
> > especially about whether or not memfd created with the MFD_NOEXEC_SEAL
> > flag is sealable. Before MFD_NOEXEC_SEAL, memfd had to explicitly set
> > MFD_ALLOW_SEALING to be sealable, so it's a fair question.
> >
> > As one might have noticed, unlike other flags in memfd_create,
> > MFD_NOEXEC_SEAL is actually a combination of multiple flags. The idea
> > is to make it easier to use memfd in the most common way, which is
> > NOEXEC + F_SEAL_EXEC + MFD_ALLOW_SEALING. This works with sysctl
> > vm.noexec to help existing applications move to a more secure way of
> > using memfd.
> >
> > Proposals have been made to put MFD_NOEXEC_SEAL non-sealable, unless
> > MFD_ALLOW_SEALING is set, to be consistent with other flags [1] [2],
> > Those are based on the viewpoint that each flag is an atomic unit,
> > which is a reasonable assumption. However, MFD_NOEXEC_SEAL was
> > designed with the intent of promoting the most secure method of using
> > memfd, therefore a combination of multiple functionalities into one
> > bit.
> >
> > Furthermore, the MFD_NOEXEC_SEAL has been added for more than one
> > year, and multiple applications and distributions have backported and
> > utilized it. Altering ABI now presents a degree of risk and may lead
> > to disruption.
>
> I feel compelled to mention again that based on my investigation the risk=
 is
> minimal. Not to mention that it can easily be reverted if need be.
>
The risk is not zero. If we changed the ABI it would be propagated to
early kernel stable versions. Various Linux distributions also
backported the patch to earlier kernels such as 5.4. If it needs a
revert, then everyone has to do it again.

> In my view, it is better to fix the inconsistency than to document it. I =
would
> argue that "`MFD_ALLOW_SEALING` is needed to enable sealing except that X=
YZ"
> is unintuitive and confusing for a non-significant amount of people.
>
I understand,  documentation helps resolve the confusion, the next
step  is to  update the man page for memfd.

Thanks
-Jeff

