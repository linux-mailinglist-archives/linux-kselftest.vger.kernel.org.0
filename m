Return-Path: <linux-kselftest+bounces-35884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43AAEA571
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 20:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF4A4E0ADE
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104301FDA9E;
	Thu, 26 Jun 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqhUMM8I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714DB1FFC49;
	Thu, 26 Jun 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962636; cv=none; b=nNjQF8Ov8UXRa/1a9sJd9EwcPbi5FHao5xhU9vmlNhnbXgfeb88G1HNhMIw7Zj+gLSWYKwDLQUZ4uHOrAFFjAjHsbF+6ef3nwm6r0TYm3fAoiYZNApyrckYxHoAcO73hDWRxxPBAoMGLtxSqPF/R1D5BXx+G8rKmqIJEq7WdMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962636; c=relaxed/simple;
	bh=FCUG9zjOkigdBABYb9d8usbeYPE7bC+MAcocZNF4Ge8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLMMH2aMYJRgTlERT9Ny0Ob1wGuNNmEfg+semBvznuH2tCfsKGts7Xsuaaawr6SEdq5W5ja2njBLp2/zXf2PKk5/Ozsp1th6btEAciosrquZKyUFjm7IgNbhdTdA2jysfXd8gF6EUMputOXPibw+mWs/5PlkSd43moCvLnRNodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqhUMM8I; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e82278e3889so858562276.2;
        Thu, 26 Jun 2025 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750962634; x=1751567434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rd4xp5ck/mMW/6UhTNDLZDgYLTJ/5t8DPE8i/DpKm9E=;
        b=FqhUMM8IBlevV88G1zuQrg1boLDv5n/Rn9I5xMVRhNwI0V7RmDxVc6fthHRxxepzaE
         8S4uUGRB5XokP/4gFW3Zztvqo5YKRPL0RBX7vRsrjuWUZVWpyhU6KUbH/M8ou3pYnrjk
         xUx2VTdepbx2b3/MxNesnSgCiyCcSPENeNufA52l88MDQyWr5V2JVmzUzFTbFt7db5Vy
         8ID+YOd9MxjVsZ6nVA7BmGx/wx7P3KnxfGJzHw4nuGQ1gb8r3J3v7rrcc/wTGHGdHHPq
         Wf/I8aGQx03kT1Cb4fKvdaBZQbwCYP0hzpPXXCqzjMqn5EFIqHZr21//kS8ispZyLXY+
         sutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750962634; x=1751567434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd4xp5ck/mMW/6UhTNDLZDgYLTJ/5t8DPE8i/DpKm9E=;
        b=T8+P62YxAkkJyWUfWnN4KwsfKvX5Zv6TzX91D4WiHhfmogVccy31eCu3OniIXmYAKX
         ZOb4FGIv9rAJU9P3fgUEdbmYbx8KK7kCdhP04UJal4Hq96gUsH+scMRCe+DAtKjOCqHv
         3eD3icHr2WIvRUtzDTXJ5FcRHl47qMvh/p6JsXjFpLOBl1nH2YzVqYXj7x7qu8qPTxm0
         U5EhjH5mF/jFNCDWILDeUwgtePMYUSKYqORoSCGS0BnbF+N9YGNXH47/ggFjr5NtMluL
         0EPgSiE6S9dnJA8JgHrGl/vPlxBvX6b51WUvqCSs3p5quY0Nl43NDPhfXpe5vtzF8nSo
         /8SA==
X-Forwarded-Encrypted: i=1; AJvYcCUTs91j1gJTItMVVXgNJBkg1fU+ad0iB+gAC6mn7HTxSRXC3pa9RHlMNVNSCFNMIJz33S6RqtTb9K1IM08=@vger.kernel.org, AJvYcCWabsAPrrCSqbhu+P9AxWPHpFAEk8+uyxkxMTH8zrodHcbZdJ7UaArxcDNv/lrCOWMztTR6R2OXWR3ZoLWLYJs1@vger.kernel.org
X-Gm-Message-State: AOJu0YxMYpLDksQWbdrg35Lls1zYaVRfhfY8oQGYG3hArU0hB4l+t4bf
	aGWc5LFgDKs87p7b6VljZfBfI0B7CowqQpV8W5VpIU33ru5LunurscoXoHfR0Wn1R75YCPzdEze
	lguF+TF1dE3nOMSBF7A89aRgCLMaPr0A=
X-Gm-Gg: ASbGnctlcMbjh2xsEzjBwprbKFiNxsWM8RJXnScbpTVvwNp8jYqUaU9wlP1A9cMJxB/
	40JjeXnOoA4z+1PMcEsL/rX2VSR8C/rAyaa1nQKcSHai3ACAFaoVCobF5z3Dh0tyhkr69UFdwXp
	SIMqEfmJN8N2EM8cc8bMi/pECqZBh37JUntu5o+MTpv/I=
X-Google-Smtp-Source: AGHT+IEoL/7a9ToHVejkfgZ4pk2rxazxc4nJ0u+6Rz1GbncTCYcGX5V0GwROxFy1YqTb2Z+e6Bu8XuNUhAa93RBIJUg=
X-Received: by 2002:a05:6902:450d:b0:e85:fa4c:7759 with SMTP id
 3f1490d57ef6-e87a7c02aa1mr416330276.44.1750962634215; Thu, 26 Jun 2025
 11:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626155257.81256-1-dyudaken@gmail.com> <20250626155257.81256-2-dyudaken@gmail.com>
 <4db5be54-7c27-4aed-b70f-3722a890904a@efficios.com>
In-Reply-To: <4db5be54-7c27-4aed-b70f-3722a890904a@efficios.com>
From: Dylan <dyudaken@gmail.com>
Date: Thu, 26 Jun 2025 19:30:23 +0100
X-Gm-Features: Ac12FXwklyRv0zhsHmUM7JkmQPBrfauC7cdN3bzxxt5GsmMQwl0mOpYoKcVKfM4
Message-ID: <CAO_YeogikhpZjg4Nhcdd0AKjRFCtZ4ohvVN5Y9DZgqmNiP8FRg@mail.gmail.com>
Subject: Re: [PATCH 1/2] membarrier: allow cpu_id to be set on more commands
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paulmck@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 5:07=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2025-06-26 11:52, Dylan Yudaken wrote:
> > No reason to not allow MEMBARRIER_CMD_FLAG_CPU on
> > MEMBARRIER_CMD_PRIVATE_EXPEDITED or
> > MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE.
> >
> > If it is known specifically what cpu you want to interrupt then there
> > is a decent efficiency saving in not interrupting all the other ones.
> >
> > Also - the code already works as is for them.
>
> Can you elaborate on a concrete use-case justifying adding this ?
>
> Thanks,
>
> Mathieu
>

So my use case is for core-local data such as performance counters.

I have a library that allows a fast thread to  "lock" a core -> do
some work (probably incrementing some performance counters) -> unlock.
The "lock" uses restartable sequences (ie no serializing
instructions), and the unlock just writes a 0 to memory (again, no
serializing instructions).

A slow thread will occasionally (say every few minutes) try and read
data computed in the work section.
It does this by disabling locking and firing off a membarrier(RSEQ) on
that core to be sure that the core is either "locked" or "unlocked".
It then spins waiting for it to be unlocked.
At this point my understanding is a bit fuzzy - but I believe you need
that core to have a memory barrier since there is no serializing
instruction and the processor would happily reorder some "work" after
the "unlock" instruction.

That serializing instruction is what I want from this. But since I
know the cpu_id that I am working with I don't need to do a barrier on
_all_ the cores.

To be clear: (1) I don't have a current real world use case, and (2)
my library/design/understanding might be buggy.
(3) I don't have a use case for the SYNC_CORE part, but again it
seemed easy enough to add and I presume others might have a use case.

