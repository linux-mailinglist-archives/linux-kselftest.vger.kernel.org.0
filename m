Return-Path: <linux-kselftest+bounces-18101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4936097B9B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 10:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1015B286E3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2024 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABAB179658;
	Wed, 18 Sep 2024 08:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ErFjy9Ko"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FBB179652
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649902; cv=none; b=l9XrrjbxdYEHN6I8RJHLmI5Ccw5jbTdVWy19nkMJ1Sruf404xyf9vpX7hs4y7XIpBOihJn74xGpDaS3MakjBVT4oRwHnvII4VsCPRB/sdozEkABx0gje9jb4o+6UxBbq//12ml4f9LoTtOkup2Yn4sbeJ32xFoop7v09RshRkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649902; c=relaxed/simple;
	bh=qtH3/wRO42WZlwzG78CwPznLRjlZksx4pNlmPHLr4to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hag5FNqECtZYb19eKZK/cJv5WN8K6fKbTbH9K8td52Y2vzRu6cASH4wdsDal+82thdG9ljtqKIu/R9C0jPGZqiSYNnbLa9WQ5oyOCZDWwOMiQFlqnWDqR6xUKRINSAaHjGeJS1qjW1b0pRrjJGQduJ6a49dBPfLy3enbezEV6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ErFjy9Ko; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d60e23b33so853946766b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2024 01:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726649899; x=1727254699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtH3/wRO42WZlwzG78CwPznLRjlZksx4pNlmPHLr4to=;
        b=ErFjy9KoNhewV523p0oaX4q7tRs6ZlGtQJyrfh708dN2qNpeN3z9IGrCwMmAu9bwZn
         3XigY3uSNwKQrVy9m+En7sqrHq4SSm5OlWP7QIwD1CihNZQ0SJBUZPDOikZ6AkjIWPfC
         YAHtKZHGk835W93Yo3cksrVGQcwJd6TXO9xbsEu82Br2QpszGAZYr1Kzpj9xB2bVQbzr
         Fgc5W096LQefhpDWBxBWf5mX9or/5i35QZ2bXuJIXzeuXQgPdi91dOmJ9c9FcuBhlzHH
         SfaPekR4eikjZA1wc54CV1Nul9fg/No67t6GZQsmvJS3tqCaC2zBoX5l0uKXKMSsMAiO
         a87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726649899; x=1727254699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtH3/wRO42WZlwzG78CwPznLRjlZksx4pNlmPHLr4to=;
        b=VXrbplr1hYbavbXxhsTJClEYvyEoaBi5xgMTnVURGn8i2PKM58gLyfGL/mKefMqsVg
         F+DBgl65Omv+UPjyL3kPFUbi0Q8cSnoNlGb+fbdjHNhY8Ey1l+P0mcRqMbcJ51MxXGyR
         pY7uhH9hTuDLn4hguATRNHzP1KGFCpD3nSX1dX/RKKyZKftdRQ9XrcbREYy30vYkX5ry
         kDIvl8xSkE7sjmQSBY6TAEvDDWQYAwU8ikA8dTMe64I8L0T3AoP0+PDBmyp9xQ2ti07/
         aX0iFBlqT/7QRKSxZhsffAlRaHy9S4h8esRl8rt0SzLKu2nuDfTqYTX8cohBTQaXZwMh
         JDZA==
X-Gm-Message-State: AOJu0YxexQi39838INEKrPEY9zaS8nlr6RcW5FMHzwmw/3lThqc6Ut5Y
	SkosDW1h3PxebLmqmQ4D9y9qCIIMoZ/c4HpL01TZZ5qTLp91aFE5rg2yIEF2hs7CdbJkQZv9Zgp
	KRXpv/qDkWDfGmis1A8FKUfKmY9bO18Wy8EE=
X-Google-Smtp-Source: AGHT+IHZtZ+EWV6sEkX2nmzdE5IPmMuvOj+z695+Supdu5Ewh1h8i6G7EafPdm49+Hj78uMq7ZULqQ1nNah/LncH5sg=
X-Received: by 2002:a17:906:6a1f:b0:a8a:7062:23ef with SMTP id
 a640c23a62f3a-a90294d5249mr2127433766b.32.1726649898715; Wed, 18 Sep 2024
 01:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918004731.3295870-1-raj.khem@gmail.com>
In-Reply-To: <20240918004731.3295870-1-raj.khem@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 18 Sep 2024 10:58:07 +0200
Message-ID: <CANDhNCoY=tvhWFmY_dZGqPdCiTZSDX3cet7qQ00zvSUBFHXLNQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: Fix clock_adjtime for newer 32-bit arches
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 2:47=E2=80=AFAM Khem Raj <raj.khem@gmail.com> wrote=
:
>
> Newer 32-bit architectures e.g. riscv32 are using 64-bit time_t
> from get go, they have not wired __NR_clock_adjtime at all
> valid-adjtimex testcase fails to compile on such architectures.
> if this condition is found then use 64-bit adjtime syscall
>

No major objections here. Though I'm feeling a little forgetful as to
why the test is calling the syscall directly instead of going through
libc.
I suspect it's likely due to the test being written prior to the libc
implementation being common?

So I wonder if a better fix would be just to drop the local
clock_adjtime implementation here, as I'm sure the libc has similar
logic to what's being added here?

thanks
-john

