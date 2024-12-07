Return-Path: <linux-kselftest+bounces-22962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8449E81AB
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 19:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1C718845BC
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2024 18:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A6145B0F;
	Sat,  7 Dec 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaHRsPcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ACF17E0;
	Sat,  7 Dec 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733597603; cv=none; b=mU14frqTvIBlsPwCYVxb6GfKFeopwUYPdC7oUQ5jJCrgtHzg9sZg1uyazJ5AgBhgFoHoIqh2UwoBeSr1nYqfXUFdO5Fhc2Zy98dPxaKhmrDV4PABFrwXBS1Dd+RscsE0xozrvBHr99dFhHoCEaU7KtVGy9QDlZODYQ7mucYwPUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733597603; c=relaxed/simple;
	bh=pacVLOX0CI9AZAnXQfY60wytZYDiBYX+6woD4pseV4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OmiH1stVHgKXAoJ+ZdIKsNF4g/j9drC9EeHuFltESMXcLME2tcFUcqnHml4hZqs3zwpy0bKBcovOVM/+XuFL9oNr7axXcpgPjpa5bSjG1I3zFayJr37cwJpsqpY0KuZ+M5AYpGePrIFgQxcncuwuyn2KpK6bZnFeNuUDYQZv9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaHRsPcF; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3001e7d41c5so26287751fa.2;
        Sat, 07 Dec 2024 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733597600; x=1734202400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pacVLOX0CI9AZAnXQfY60wytZYDiBYX+6woD4pseV4M=;
        b=kaHRsPcF6KknAt/FYkezC8p/Nc77C0DoPA4VxA02TrsfKZqiRI1C+sdfnieT5HUt6u
         VsxfW+QmunPo1e+HFbbQ9Kk2jHL90+xSYatC1i+vBnOiyVy3tk4ioi4vKaHlTj+SrBi/
         hzmd/M3EbnZfw8drJZ1m3RR18dQo/J7QfkR/2Ihgj6qe9FkQhEeOE9G+ftBcyLzNCI1L
         TfALUViX0sT4uizWaHk1FRX9c6n10Nl+kdiw9XMJ15MBUrV5IQXqt6ERquKNTN/sVRQy
         tuOMac4g6Z4dKvzxio8GyAZGjIiejLfUHxVkR60VXQa6S6DS65y3oOrz3aOfQNIagFMQ
         lAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733597600; x=1734202400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pacVLOX0CI9AZAnXQfY60wytZYDiBYX+6woD4pseV4M=;
        b=mfwjfEqrDGn9xyr/EvP8RCMrtSGNG8sTN5WwVDFqtfJ3wpqPW5wb+SMPJovFm6zeaZ
         XLFj06gkLHtEhrLpDdaoQzXhuTidpL/PE3aMrTVisqEtEXStyGIU9++S1CUqOa1cj4LE
         Ou33dGUiPBiF1IJinizxcEzQU6LCETGue6mM77OPOrjhBnRl/8xHHPKA8PD8D1SYqDGg
         WHlZvihOC0GOvaMGkXUMCrsNQ5fxUcg4YL/sf5SW4sYQtyjIcAVp7JDfbzYjyy+55gv4
         8bpClLjBnS6pEeeHEwQ+2zYt434c9BuLOuGMdwo3AfhsoyLCKsaRvM547ZKySxR+RSrO
         11pA==
X-Forwarded-Encrypted: i=1; AJvYcCUpbPd0D2bOWs7l5mN8giGs/auEJ6zQBrKpgq4BvnzzInzVkgKiTuyOb8AugpiLW/4wm3eu+gMza+2LVYk=@vger.kernel.org, AJvYcCXyR2L8gpIOuZEydAfKn7QwOoHh/2mYHivrGQCJl++iSiM8v6l2prU5ZUcuZUKANYPTm5pp5jz35T0csw3GPa0/@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq2BfMfF+6g1vZumU25Nf1/0KsiaqkD4JYHldJAlY2lxm7MVI
	4zR/PpXUzttgYwl38N/SaFIcxkunt+jxhl11KhNKKqBqGvKYegubqWfZBbfMvO+JDO9kAtm4VRE
	ML/gi9pLByMj4Od+Fo3djpgLKOBc=
X-Gm-Gg: ASbGncs19rQdbiI8Jgt5D7BOvfYGzBhnxrafvNjforXR0XmKHe8mukf1v8VauBDuogo
	1yg3cGmgK2A547TgH95NzvBXEIrH+7ohJogk5L9bKJfAOAxvN/YS18Ur8U4wIQwpu
X-Google-Smtp-Source: AGHT+IEur8XuRACsFxkMLW1ZU1E3oERTlgKeBVuXShfUEvfaIaCFlEfvVM2PCIMXGFNEpIrV6JG8Itne61qzz+URqCc=
X-Received: by 2002:a2e:a5cb:0:b0:300:24f9:5a25 with SMTP id
 38308e7fff4ca-3002f933d0bmr22676361fa.19.1733597599186; Sat, 07 Dec 2024
 10:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102-kunit-qemu-accel-macos-v2-0-9d4579fddd20@gmail.com>
 <20241102-kunit-qemu-accel-macos-v2-1-9d4579fddd20@gmail.com> <CABVgOS==_+DDRYzto6Wn21kCBQCDhAHwhORU8f+AUQ2GDArXHg@mail.gmail.com>
In-Reply-To: <CABVgOS==_+DDRYzto6Wn21kCBQCDhAHwhORU8f+AUQ2GDArXHg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 7 Dec 2024 13:52:43 -0500
Message-ID: <CAJ-ks9kFEp=B9eq5JWkZNDGo4awPwu=rqGASOn9RL8EMtqBAZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: add fallback for os.sched_getaffinity
To: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:36=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Sat, 2 Nov 2024 at 20:10, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Python 3.13 added os.process_cpu_count as a cross-platform alternative
> > for the Linux-only os.sched_getaffinity. Use it when it's available and
> > provide a fallback when it's not.
> >
> > This allows kunit to run on macOS.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
>
> Looks plausible enough to me. Thanks very much!
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David

Thanks David! While the next patch is still plausibly undergoing
discussion, would it be possible to pick this one up? Without it
kunit.py is not usable on macOS.

