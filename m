Return-Path: <linux-kselftest+bounces-21774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF549C3C1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07DD1F2200F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F691581EE;
	Mon, 11 Nov 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWhUQCDW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320A82B9A9
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321368; cv=none; b=oWr8rPtuRryOt2uMb4nAZQQTWQXk7/0dsyydD2YS9DGxpv5nbM/5X+NaG8c3TXqFu/6oazzOgDnQ/orVXwmIW8nC2sgVu1IENKi/CXyMXU67AEuHkK5FE+VKYXz8yP27YViD6rFk17cKSCAqBuYBZ0OhYSM2IMtvV1FKcXUdw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321368; c=relaxed/simple;
	bh=2+k76rem1o8apsP0I3iH+WY7HF+aRCuLH/DzqmTPxj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0OpAfY408EeDcf/KIIZHuFymtKnG73wokTNQ73tMj2/4xfrYsrHEyBSXiQxzydWM/Wr9SunzuzrUe/4cHbI8mRk5wQ4spot4j30G+NgqSvRg+4+WA+x8Xom4pszuoluHuYwY4XRoFEqWoSAIhRDA3gtkFL7rhKGIWrfTiWjEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWhUQCDW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4608dddaa35so339221cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Nov 2024 02:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731321366; x=1731926166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K4qc9o0lUmJXTVDN2TFWgPpZJb/fi5KklNFqtZPGPxg=;
        b=gWhUQCDWX4i2wKZhkoDZXc4+xIrI4YSlhas6x9CLoUSYKvyQfJnB2Vexccr1GbchFs
         WJ/pFexqjW9DgPiyJtrsZMo9itKir01w/lMDYLi0SV7fGW1q23oxdezNYJisB3IULdzE
         xB9jEL+G1y4YhlUMci/pHItd/sYQw7XoE8ESScJkYMX2DGyBgutcll8hsGT5mr84gDym
         nN+sPiSvhbbnW/m+GCufN5bMe0SrOVwaJqQtywo+Z2JroblB8lqU/sM2zr8EG/uDg0Zc
         pZn7lM00X02D+R5Cj7PtIuNUpDYo+EC3efY9UmVsnXwKOnoMMjyhMob7b6t8cK6NhgaR
         z8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321366; x=1731926166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4qc9o0lUmJXTVDN2TFWgPpZJb/fi5KklNFqtZPGPxg=;
        b=jlwwBCVJBMAfztclQRZlAszZYuhr8M6xtJP6MOirv73wxUtaUzJ2TOjUvDQnxGuJki
         cUeXJgdTpnUtNGAeDbx+v/6B1tT2F8QCvABmWWXqZtSOY/AV0dhO6sThvQfhH246b7YL
         cCloAHWbaZ5WRR5gbX/hRy65Qqr5K/xiyROYF3M2+oWawgAXVFelNXXn8m5gmWgGzJr8
         o2g9QjLwWqEI1XqNaytN/Qll4KX2PIFXCXPZl83zBWs4e6k0nEcUFlqTZb7CnNvZ2PSi
         TyK+Zwem8A3bMoVHEuu4rkCsf+zU2PwGTdYsUKYy7jlAekt0fTLocW89Did9OVtOHJqa
         Yhug==
X-Forwarded-Encrypted: i=1; AJvYcCU2f0rFtUwi072mYBpoD/+3ppANubX8bZ2/AHQk9Klbh2sDL8H+QdHLS1/v6WtVPuKvbzjoiqrYi2uKPAjD78w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSvXka19CdMFraJU0pA1plHOn226eAZU4rIblSA3jHMgtImNN
	KY3rOXrY/q2GV6gGqZcngl5X+P1+ZjoDY2nQJ8e2aIGF7aIZsanz1JEA8iDrhhzmK5q18EpEeoF
	r3xwpI1Ijhr+marFiPma+u6TnbfzWaXZbcvFQDn4BT2lRgaj7bwRB
X-Gm-Gg: ASbGncv9zzTndxeMs+GMTwTkwVODcCT9zp0TGhY73FfGTVmPPNEeQTlLyOf3FQYUe01
	F92q//oe6GeivVPYH3xdGiS4QuCoKpqotXdI3pS9PpfBDQPQt4ANeLpY1fNYTpA==
X-Google-Smtp-Source: AGHT+IHOw1DbOFc3N5JAR29FJRhok1zU9UzK5d72u2qWhSB9q8YuQIdfBz8N7GdygprgSzUk3RZEwA2ZrBkl92J6L3M=
X-Received: by 2002:a05:622a:355:b0:460:77ac:8773 with SMTP id
 d75a77b69052e-46316a1e1d0mr3863181cf.26.1731321365923; Mon, 11 Nov 2024
 02:36:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+i-1C2-PGPcfSJB4oLqHN3jAE9CDY+iNaW9WCiRB6zF0fgQ3Q@mail.gmail.com>
 <CABVgOS=hxOxiX361Bz0==YNBCgqedJyHdWUm+-Szq8Bqqx1MxQ@mail.gmail.com>
In-Reply-To: <CABVgOS=hxOxiX361Bz0==YNBCgqedJyHdWUm+-Szq8Bqqx1MxQ@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 11 Nov 2024 11:35:55 +0100
Message-ID: <CA+i-1C1mU5yfvfMrueGyunTGQkSUENPrNcd8kbpV6B3hVKyG1Q@mail.gmail.com>
Subject: Re: "stty sane" in kunit.py
To: David Gow <davidgow@google.com>
Cc: Daniel Latypov <dlatypov@google.com>, Brendan Higgins <brendanhiggins@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Nov 2024 at 08:18, David Gow <davidgow@google.com> wrote:
> On Fri, 8 Nov 2024 at 18:49, Brendan Jackman <jackmanb@google.com> wrote:
> If I remember correctly, this was due to UML sometimes messing up the
> terminal (not QEMU, though QEMU definitely does the same thing
> sometimes), possibly just when it terminated uncleanly. It may also
> have been, as Daniel notes, something to do with the --alltests
> option, which used allyesconfig, so could enable some strange
> settings.

Oh yes I totally forgot about the UML support! UML could definitely be
doing terminal ioctls.

In a funny coincidence, a totally separate codebase that I'm working
on on weekends recently started doing freaky terminal stuff, and now
that hangs  when run as the child of something like watchexec.

So, I guess I'll get back to this kunit.py question once I've debugged
that other thing, I bet I'll learn something useful.

I guess it's also not worth trying to fix this if we can't be sure the
replacement still fixes the problem that `stty sane` was intended to
fix, unless the hang turns out to be a problem for CI tooling.

