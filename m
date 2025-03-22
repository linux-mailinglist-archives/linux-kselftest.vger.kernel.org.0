Return-Path: <linux-kselftest+bounces-29616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E02A6CC7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 21:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4484817645D
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 20:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727823371C;
	Sat, 22 Mar 2025 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hizt800X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69118B48B
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742676507; cv=none; b=bu8OlSkEv+J0yHBkecJ2s6KI/UD7e6NQS6lmioRSD15v5titwoKcc4A3WbQp76dIOff01hRddRGoSTOEhipfWHeCBjNDcJgNw8GGiEQ9Rfr8scxJFK+PcvdFYo0ccIZOXrQFk8tL5daprO/ZFYlYnPEhKay0TmjgQET2lZ5EJuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742676507; c=relaxed/simple;
	bh=ay9fevNY0hFn8/QGn3/YRuwGGPrGYObaNbTRDw64xOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfoZab+tAevKiCMt+3+MnTYYwSNbunl3tEQy550eJXzrQ98k3ZOKIzi1TTTSLr7ajaYdzoSwxN99rIzBJjyQazJd3cbHjPb9RTcLVOXHhcw/+k6kZ1YoAKmxLYZx4vxJHhBhugVYztUvQHCKx/nf5yG/UPmPDmyRk8fyq/jy25g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hizt800X; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fda22908d9so21346107b3.1
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Mar 2025 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742676505; x=1743281305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay9fevNY0hFn8/QGn3/YRuwGGPrGYObaNbTRDw64xOA=;
        b=Hizt800XY/+T63lsoBnEiCzXCwN2ZwXOzqk14BmBwg74o/C+kohco3gD81xwG6/i+N
         /Wb48AuLXsldPGHDuy8oERR1k1CvOdjCMrKoP6teHROWLEc7qnI9QihUitcaEUEcO+Z8
         vS+pbclRjOX+s+PgBNVH+N90mksTCC7UwraI3scPSfEc8lxpM/vlK8Qt8fzPFs6fSOsV
         S/d5G2PiD8ozyBh7dSynljv5f+yjjukred2Rl3JJywrpombFDHT7B/4LK29yMka/7UyG
         r8wMLiPdTrpXoVz6Elmq24ExxTeabxUzr4mr/WqoFzcI77mYaArIWDlqa4DgsG0TgerG
         Pc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742676505; x=1743281305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ay9fevNY0hFn8/QGn3/YRuwGGPrGYObaNbTRDw64xOA=;
        b=aXEIya1PPMhCtMkESRrmxoV/u7EuegoZQaHQGpprOp0I9U/PZcFjILerUX2t2DCvCt
         gVmPLhpYzqa8ML3nyHC/6XRmboc2Nl8QlSPloRVk2J5FAbie92RtoXpwzQSWVd+dWwQz
         LsDmlj8yV7aQvi/DZ6x2r74rTUw3y0xkqsCweSWjqWzvvhgE0Yw82GKRokLpnqCjA8Ui
         vhca/jPdwngJr8Z2oi6Lo98sjQkNnmzROvSOlm0GZn5jWUo/JFtTo+3vJV2Ndz/yn+Hf
         97BOVgnid0syiNIOz+dNSaJJjWRQb61qo6+wS7S2Z5Vki4CyD4J4GAYro/neA8QspqZG
         Kjlw==
X-Forwarded-Encrypted: i=1; AJvYcCWvYk8KYal0vnxGT0kKjT9SVGA0udXbmVgj5L2ditfmO/Qbzif0KHsMWxQ7kuY7ZmxQwDekV22Jruw7BX2uB94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw62a4vIZypoJ2CD77Y+bfoOPdstuS57GrE7exWpKd+qX47Us92
	LNY4iE/xRsUznrEY+/h2BI1RfL5wz80Y+iYFCafiaqGYhgfMl3h+Oz7Ig0/BJIoGGEQjXqhfodG
	WsBRSbrlWafqFa8cykaEsj9WDg9tPSE6iOmce
X-Gm-Gg: ASbGnctjjLD0gpvKjghH8+6bWTC6vm97crG/y2YYXUzG8kdqCjkskP+ujLULZVRO3G5
	ZIv02Kwl1rCJk11htextmK/deO91p4SXa44OUNU1lRfZw51eqCwrVK4stR8kKltIXcSRdVrRSwA
	kzCxCYcqIqDui5awIGkouGPqWufQ==
X-Google-Smtp-Source: AGHT+IGCHUgYHj8FnbhbXd2f6u0nMs1qNJ4El5oL87Cb1hpfEP0T9cT3d8s0LxRDBkc/UszGgdVndU3eZ48ic7LA2Uc=
X-Received: by 2002:a05:690c:2501:b0:6fe:c040:8eda with SMTP id
 00721157ae682-700babfd59bmr94340957b3.4.1742676504841; Sat, 22 Mar 2025
 13:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <Z97xvUul1ObkmulE@kernel.org> <CAHC9VhQ4a4Dinq+WLxM88KqJF8ruQ_rOdQx7UNrKcJqTpGGG+w@mail.gmail.com>
In-Reply-To: <CAHC9VhQ4a4Dinq+WLxM88KqJF8ruQ_rOdQx7UNrKcJqTpGGG+w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 22 Mar 2025 16:48:14 -0400
X-Gm-Features: AQ5f1JqDeHoEYBZnZnhU14MZ_ha_8yis_y2VRPgUfTr12KfbQKKoHE7FmctARms
Message-ID: <CAHC9VhSfPz4fYU-YxxQ++3OP_hqtiD=J9fJXyUHmcj8NHd1pZQ@mail.gmail.com>
Subject: Re: [RFC PATCH security-next 0/4] Introducing Hornet LSM
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
	David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jan Stancek <jstancek@redhat.com>, 
	Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	nkapron@google.com, teknoraver@meta.com, roberto.sassu@huawei.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 4:44=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sat, Mar 22, 2025 at 1:22=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> > On Fri, Mar 21, 2025 at 09:45:02AM -0700, Blaise Boscaccy wrote:
> > > This patch series introduces the Hornet LSM.
> > >
> > > Hornet takes a simple approach to light-skeleton-based eBPF signature
> >
> > Can you define "light-skeleton-based" before using the term.
> >
> > This is the first time in my life when I hear about it.
>
> I was in the same situation a few months ago when I first heard about it =
:)
>
> Blaise can surely provide a much better answer that what I'm about to
> write, but since Blaise is going to be at LSFMMBPF this coming week I
> suspect he might not have a lot of time to respond to email in the
> next few days so I thought I would do my best to try and answer :)
>
> An eBPF "light skeleton" is basically a BPF loader program and while
> I'm sure there are several uses for a light skeleton, or lskel for
> brevity, the single use case that we are interested in here, and the
> one that Hornet deals with, is the idea of using a lskel to enable
> signature verification of BPF programs as it seems to be the one way
> that has been deemed acceptable by the BPF maintainers.
>
> Once again, skipping over a lot of details, the basic idea is that you
> take your original BPF program (A), feed it into a BPF userspace tool
> to encapsulate the original program A into a BPF map and generate a
> corresponding light skeleton BPF program (B), and then finally sign
> the resulting binary containing the lskel program (B) and map
> corresponding to the original program A.

Forgive me, I mixed up my "A" and "B" above :/

> At runtime, the lskel binary
> is loaded into the kernel, and if Hornet is enabled, the signature of
> both the lskel program A and original program B is verified.

... and I did again here

> If the
> signature verification passes, lskel program A performs the necessary
> BPF CO-RE transforms on BPF program A stored in the BPF map and then
> attempts to load the original BPF program B, all from within the
> kernel, and with the map frozen to prevent tampering from userspace.

... and once more here because why not? :)

> Hopefully that helps fill in some gaps until someone more
> knowledgeable can provide a better answer and/or correct any mistakes
> in my explanation above ;)

--=20
paul-moore.com

