Return-Path: <linux-kselftest+bounces-40852-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F29DB45C87
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3FD163F30
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C2225408;
	Fri,  5 Sep 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIsvlS5s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042B31B83D;
	Fri,  5 Sep 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085944; cv=none; b=BN9SqohMnAGEcRdiTUOkKTYpV0X8Gk9+wNGeLQ/smUCV68qquh0Ogc15nuUqRtKzoqPKJmtOpbGEi20xkoHNiDodrSagMbMLvt31SD9Pa8PksV5OgTAIo9NIG4uoTQ4lf750V5fgZ2CaPct4GeG5OSdTc9e1FK9FvbEbA4y4BmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085944; c=relaxed/simple;
	bh=MN6V+Y3hpzY4is2NXs+lXCxQkkhsRZ7URUJHenOu5Nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXmSlqW6uOqx0EQWQ6ZXJrRQJ3+A9MWboQ2XO1Tz0weAKbHU+Jp36JlXcc4K+h2COwjehcNMbwi5Q+HkZ4VaLdsfNS6Md4si9NQWlSM8riW1mbrN0WdSuIEx8nHHq7LLPGI5Q8zrOFKye04PENIzUb5ApKb2eU74dbfxs/rGWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIsvlS5s; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso2546311e87.1;
        Fri, 05 Sep 2025 08:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085940; x=1757690740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3pmyKBsJrKrGNfyGEltelPSlSrpEyGASt0DhsOg+OQ=;
        b=FIsvlS5syNLoCIlQATgniGI09pZa4JIRu3lF+Ba2sLKXvOvDGzrP0OwKxriqjYu0Np
         zM5OjQqKn1q5ej2wYHl0dJVu7WNqE6P0wNYZxp7F9XXCVB0bvN+wbnvxS9c5OUuxEu1w
         jb5idVqHL0bJLTwm47iq0o9aQNHuYDd5Bhy+aj4kOPiX3EUIbleGSxXoZYICdZuBYj0L
         loR14o7tVDicRTUVkUJVUFZhDCpZMeAoYVYB55hOBDV33lhLtg8r4yOq0XMcR862vCc4
         M5St24wHPtYusGsqFqI2wcrsh98QWIIM2CQYIa32ZTgonu0Z18CADNJPuAJocOpNwFPv
         Jk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085940; x=1757690740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3pmyKBsJrKrGNfyGEltelPSlSrpEyGASt0DhsOg+OQ=;
        b=N0CVAo3OV7HN27fwS38l9Jwk+Kp6/LIYD1IxkBtw6R/rwqr6pPRZgcnCBFCLP0jP5X
         sf5uWvmymBNf+ZKYxo9mtgzZ4CJjHnUQoh8sDxIWvQvW843bSGcvWGQZYdrOrP8KjgIW
         nJ3yT97uL/xwmSQP4hXC56ZT2Drl68O+PVTf33VZxMPxS/xZZG9Yn+aRoFaseWKG/B0Z
         bSPiZSsZ9HGkjrvf+iw+nzSpswbMmnDniZOBAqTMXa5ALSPHNc/Sru2PixEN5kU0ub6T
         pXiKRNHogWvK6BkHrrcgDuzZCNkt58Zni3uJLXQLg9QSDDcILCZnAxDy3hIKkR/oaiPg
         rqIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQfhUTlhgZO7xuGYD9VkK89Sjadi5YmbOqwfUlafJ9oNtr51f/bxydPJwgSk6JYUtvnotSD5lXtcFIS8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpKoDl64bKMe8x+66ahngQvmnyvH0FDy9AW6jK+uDGaKhXiwb
	5c4i1ukWEIwJ87BuTv7KDqvJ5Gvc9bBurYBcTyQ01jK06w4N3KwSDkXxNcN/i3LKhPnf3hlzDci
	7i/WPNvTX8Pme7B4LYKmt9lERvpAKPCcTlLfQ4A4=
X-Gm-Gg: ASbGncusZ+j2JXFz8moVcP/spHH/hNYqDUyoriXA+otpuGLWKYei7OGzM6aF9nYf9vJ
	qNII4DsJBmeADVWu7s5qVlZ4fjL7xqCK1O76N3fe+Ulqe6ESd5+EmrsKk5jQNNIu5gOTfnGhqqu
	FCHrsjo0FE21oybSaTjc6cwMhef5Z9/Rex9WZgee7FE2SR4ErS+3tBLbGukk1Xv8xweawcsh3lI
	NaPtbXHgz/x0JyICZwcas5UQTip
X-Google-Smtp-Source: AGHT+IGpruc9CIHPhhinpZZKBqMZPliWHUdQL2QQWrv01xxkWXWTYECsm3BN2S+2OZs+my24BVqyWdMvAYcNO73hAw8=
X-Received: by 2002:a05:6512:15a6:b0:55f:4495:51a with SMTP id
 2adb3069b0e04-55f709dd602mr6287322e87.52.1757085940075; Fri, 05 Sep 2025
 08:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905151734.12729-1-hsukrut3@gmail.com> <55a80c17-6fab-4a5e-82e7-25274c5d9579@igalia.com>
In-Reply-To: <55a80c17-6fab-4a5e-82e7-25274c5d9579@igalia.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Fri, 5 Sep 2025 17:25:27 +0200
X-Gm-Features: Ac12FXzfiFIdZCKxpLn6spu_fWYMyorNOEeTr7ej5xneE57RJPONwCO4fXqD2mg
Message-ID: <CAHCkknpK5Be=dj2=cFs6GEofH=0h_sL0uwJi+cJnEo7hXVukDQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/futex: Fix -Wformat-security warnings in futex_priv_hash
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Colin Ian King <colin.i.king@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Fri, Sep 5, 2025 at 5:21=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@igal=
ia.com> wrote:
>
> Hi Sukrut,
>
> Em 05/09/2025 12:17, Sukrut Heroorkar escreveu:
> > Fix several -Wformat-security warnings in futex_priv_hash by passing
> > the test message strings as arguments to %s format specifiers in
> > ksft_*() logging functions.
> >
> > This silences the warnings without changing the functional behavior
> > of the test.
> >
> >
> This is already fixed upstream:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dl=
ocking/futex&id=3Df8ef9c24029c85cd0328a9c668283017d8c292ad
>
> https://lore.kernel.org/all/20250827130011.677600-4-bigeasy@linutronix.de=
/
>
> Thanks,
>          Andr=C3=A9


Thanks for pointing this out.

