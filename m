Return-Path: <linux-kselftest+bounces-33406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D0ABDFEA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 18:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA0A4A8157
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196CE268691;
	Tue, 20 May 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG+uhMcA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64697267F5C
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747757108; cv=none; b=nO4XxNtRaVXzAiclTvlb73nwJLoip3ARzVXVRbr21YD0EKJnKES4/6Lp6OId+BrOoWmRJMzKSHmzgygIhrMySc7EktmswXVlMAyBXEc44A7ku4DH0Gx0hT7b4J4WjOlRCl7VtwxeA6JWsqNwheg5b/RnMY9rYzaCdsCAIlqv92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747757108; c=relaxed/simple;
	bh=cg5t4eGdtgZu3cXZP54MB4IR+ZBOuN5oWKa4yPo3uQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSoUQlfmu5tavX0EM11E5c4zx8oCUFbtxSEB4evF8INApi+Ur+pVzPYYdxQ0QxemS4sxkjPRlfsQz//nI75ey+6FRoKriGyE6YA2syQqpUrNSX5XVDcowq4SaYogMcBqd21ytfpu5Llxs/0rCWujchy7U9LxwPnlVua5EJejjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TG+uhMcA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c922169051so347582285a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747757105; x=1748361905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO/nLRYCjfKcpLfeuNbV08YkbzqqQcf229Ms7HqssNo=;
        b=TG+uhMcAWKjMq/CYX37WIMDeEcvgzGMcUnseZP+rihgSIDyS+AktyygGOrjCH/OplT
         GY1TRRFXhuuEeeANzEQmzFlgxJJXlzCN704hehv9uCzZKSPvfOKSCW12OnDLH1bWAMBs
         HeCR8Hn90jgQDONG5Dqe4+oWI/k6/YD3KUE2nu05i++0AtHdLDrTEv/h7rBk4LohT5Zt
         QIl7N2h+e0ULOBAGUAfwyAEa2RQEhZDDJITYTXOm+iDx66xqd9k0h726l4Pa+PeD/NNk
         lStWQgWyIYs3Z/IhSb+/ec1DxbSSgKX1uQQSCDKIAkWB3TZZIRYnTHcp0PY7qh1yFGM7
         UDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747757105; x=1748361905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO/nLRYCjfKcpLfeuNbV08YkbzqqQcf229Ms7HqssNo=;
        b=QVBJhGRSmv78tGuxfCDi9rROvfLTmqfcExSecrMMpN1xDx1zuHBDMgSw9W9/LVTERV
         uTeGBxoMM2XV13OXvttsDrrvRcmOxaRuIpAPjDVrVh8gStCtQqFEcj5InQzpsKHGAbun
         MWFn3JNOr6ODCwZukMOXHOpAGunU4xXqAZqavB84ewxUsmlHzl0eeNmFaq7CqgDtN6v+
         zV/r9dbVGag/H51T4DnJcGq3vnUL3e/OzBIanS5G6+2kmF2r05XOV49dJiuyZk2u37yt
         cSExZidguGpu6xcTrxEGaU1nH9PfVKBAvHcj2ZfO9H3/GM0zwmfEoz76MXjCjSJrEacH
         6rRg==
X-Forwarded-Encrypted: i=1; AJvYcCWPMKaCGkuL+8+v5CF8Sl/mOoTrjzYngRcPvl7NmXTgbKEVpw7F4Jrcbjr0gYCaA0h5gSvD4j5vdfwKPHnW6iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVc6oY/RZJCW1RReIs20AWLF5CBf0u/BQGY3jtpGZuwHkcDJX9
	SxqRPIq4VGXPdjkZJfRunNoBc3EidK/pRSa8LXEsMhLESmHwUrXz1kDT9NFLrRCsQs4z6pXANQd
	9JIdx4fpf4NcHjl21lP5BdBCcBlkA7IE5DHnH4zFQ
X-Gm-Gg: ASbGncv0XGpMKplVT/uGGVA9ZHpZd6nQACDrz2lKozKdz6OQHFmCUsoiKY8c45gDWPh
	U6rwGLJDrqKRiRjb5hiFhLaJ7u1jvAg6XE2dBgnHKECiqYY63t+tX6RbNa4rL6TwFD5Hz/iwbKU
	+KpfOwipGVNrYzw0PjaR6PSFM8f9OIo/FJWfdbWFZFHK7DS0twwqtogkXYFPMuwuBwExpDdEkf/
	8s=
X-Google-Smtp-Source: AGHT+IEctazZU95TAdOM2Py70rzLbXXswnML189iWNcKKej+1E4sE5RLKNbUjCL/eh0PGvC9pd8HdYPKfxppky5e+CI=
X-Received: by 2002:a05:620a:394e:b0:7c5:4088:e48c with SMTP id
 af79cd13be357-7cd46731a86mr2518057385a.29.1747757104799; Tue, 20 May 2025
 09:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520082435.2255639-1-tzungbi@kernel.org>
In-Reply-To: <20250520082435.2255639-1-tzungbi@kernel.org>
From: Daniel Latypov <dlatypov@google.com>
Date: Tue, 20 May 2025 09:04:53 -0700
X-Gm-Features: AX0GCFs4NJkMHkJZuPMpivpKDaXRV49LM_WCCI_dDOeQOPacWqE-V5WduNyzJJk
Message-ID: <CAGS_qxrcH0+mJTO4nJqXnk2Bh7oO_PEur=ytcxL8wxJNCu20Tw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] platform/chrome: Add Kunit tests for protocol
 device drivers
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, brendan.higgins@linux.dev, davidgow@google.com, 
	rmoar@google.com, rostedt@goodmis.org, mhiramat@kernel.org, naveen@kernel.org, 
	anil.s.keshavamurthy@intel.com, davem@davemloft.net, 
	chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 1:25=E2=80=AFAM 'Tzung-Bi Shih' via KUnit Developme=
nt
<kunit-dev@googlegroups.com> wrote:
>
> The protocol device drivers under drivers/platform/chrome/ are responsibl=
e
> to communicate to the ChromeOS EC (Embedded Controller).  They need to pa=
ck
> the data in a pre-defined format and check if the EC responds accordingly=
.
>
> The series adds some fundamental unit tests for the protocol.  It calls t=
he
> .cmd_xfer() and .pkt_xfer() callbacks (which are the most crucial parts f=
or
> the protocol), mocks the rest of the system, and checks if the interactio=
ns
> are all correct.
>
> The series isn't ready for landing.  It's more like a PoC for the
> binary-level function redirection and its use cases.
>
> The 1st patch adds ftrace stub which is originally from [1][2].  There is=
 no
> follow-up discussion about the ftrace stub.  As a result, the patch is st=
ill
> on the mailing list.
>
> The 2nd patch adds Kunit tests for cros_ec_i2c.  It relies on the ftrace =
stub
> for redirecting cros_ec_{un,}register().
>
> The 3rd patch uses static stub instead (if ftrace stub isn't really an op=
tion).
> However, I'm not a big fan to change the production code (i.e. adding the
> prologue in cros_ec_{un,}register()) for testing.
>
> The 4th patch adds Kunit tests for cros_ec_spi.  It relies on the ftrace =
stub
> for redirecting cros_ec_{un,}register() again.
>
> The 5th patch calls .probe() directly instead of forcing the driver probe
> needs to be synchronous.  In comparison with the 4th patch, I don't think
> this is simpler.  I'd prefer to the way in the 4th patch.
>
> After talked to Masami about the work, he suggested to use Kprobes for
> function redirection.  The 6th patch adds kprobes stub.
>
> The 7th patch uses kprobes stub instead for cros_ec_spi.
>
> Questions:
> - Are we going to support ftrace stub so that tests can use it?
>
> - If ftrace stub isn't on the plate (e.g. due to too many dependencies), =
how
>   about the kprobes stub?  Is it something we could pursue?

Quick comment,
If I recall, the thought process was that we could consider it in the
future if there was enough demand for it.

We have these drawbacks with the current ftrace stubs:
* doesn't compile on all arches
* silently doesn't work on inlined functions <=3D=3D scariest one to me
* is more complicated and has more dependencies

So it felt like the better move to go with static stubs which has none
of those drawbacks (works on all arches, all functions, and is dead
simple) as opposed to simultaneously introducing two ways to do the
same thing.

You mention you don't like how static stubs requires modifying the
code-under-test.
Since it gets eliminated by the preprocessor unless you're compiling
for KUnit, is the concern more so about how it conceptually feels
wrong to do so?
For the Android GKI kernel, they have (or had) KUnit enabled so there
is potentially concern about real runtime cost there, not sure if you
have something similar in mind.

But stepping back, ftrace_stubs technically require modifying the code
to make sure funcs are marked as `noinline`, which this patch series
does not do.
I've not looked at cros_ec_{un,}register() to check if they're at risk
of inlining, but wanted to call that out, that ftrace stubs
technically don't handle your usage pattern 100% properly.

>
> - (minor) I'm unsure if people would prefer 'kprobes stub' vs. 'kprobe st=
ub'.
>

I'd personally vote for kprobe_stub.

Daniel

