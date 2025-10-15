Return-Path: <linux-kselftest+bounces-43208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD8BDF281
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4086C4F20D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABF62C3274;
	Wed, 15 Oct 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc33ijTD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333DE2C21E1
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539777; cv=none; b=uD1iqma48tihX83R1Fe+jyS9n02WdpDYockhMAH5Bs2nfr0aPaUzGshK9HTr/y319nLjKsym898sHLIyX20mumgl/EoXYHgf2ob45kkEquxbIoCyENkysrgL2I9nksg3wbiafmLNi/C+9NwsRr51ZKqr2Bac91Q3JD+vGrX9004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539777; c=relaxed/simple;
	bh=Ugr7IgQEch7CkBgCAdZs0bbGqpAGoYyvZ+rvrv51b08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9WeX3geRxJt3L8xWbWEUGOqkhvJXYpgHoEJBTUssK8CHPNkQgHBd8SsAs5f7Bxd1YlQNu+xaehAIjlczPV/W8VKoVx+SiZCo5WNzuwYE2r17pcB76eebq518VTstDdaWmWNTL9gtU+B5KR2Oy1oZNgE6CO+bOqGjPXVse0p86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc33ijTD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so6480484a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539775; x=1761144575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugr7IgQEch7CkBgCAdZs0bbGqpAGoYyvZ+rvrv51b08=;
        b=Mc33ijTDJCf1lpTtTmF6jo7G1rBVsnlJSZqfxRzDX4fURVShHBGqv8KbywDvb1wxYY
         hfHgPv4G1pakBzFqjEgHIMs0DuzC07X5jfeL1zHrBpsiHm9FZVsxNGLrSD/OMvzPUmBF
         VAhvvZx+QXyIiu5yAAksCPXGv1v/Q8O/KjhSYHq+zj+aTLr56EMJPrME6i3fOxOdRokS
         zgkcwdwcxSsEEj5HuL1wtYM1V/EnjDyd+BWuH7Sr60VQRSEHJK1SzcmynPOsFpKZ1bg6
         tnvRFHhfu8eF3HPDvHRsW0KB4X8uRdHW4q75onqb5ozBvJNQomt5IPR25NPtun74ODlU
         EkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539775; x=1761144575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugr7IgQEch7CkBgCAdZs0bbGqpAGoYyvZ+rvrv51b08=;
        b=ggFjmFLekwXsohdCFiGQznnYowgrNkbnPTGYdhfd4T+s2Da28UfUpUun25H0IDmaJ0
         k7UQruYCRZ1JMtgCd1tRBEJQUWyLidUjzezVuzLR8JPacbfLnMf17D//iCV0SU4z9JOT
         v7awbcgz1x0DIZ4mHjAX/nUdEv33ZxT+6BL7v3nvEk9ZSEA6pGG5Cjq7i7vyJSuIsdf4
         E68+LLhMvXpXFgIvZo0ro0EDpn204ghZtajYnrwuzY8x2JEqNBIqui3gm/1Bh/j8sCvh
         9N6sR4EqJj46QyoURKykzfDWzBl1kmv8nyIzojSwIKMI8B1nL9WvST9oeoBBrUGU81fU
         /s1A==
X-Forwarded-Encrypted: i=1; AJvYcCV2PdlTi/5yT010zEr3UzfzPEb4pVDG2l1u2EmA8Tq2g92IzscVKKS9zx5EvgMSd2IvtPJJ7+NmVMRTnlHlXEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfh7kTe9Me+qn5kDI1owQtcW54M05b+R3HWQ/o6x/PlTBiQVAJ
	UXCVWXZB8xnOcKm69GBjkEhc+dD8YlhOpoKb+diFkJpNEY0x2e74JBkB1BYhaozvAHgWH73/yFr
	Bg5wepaDA1Cxz59yIfgMmr3ZctOu6inI=
X-Gm-Gg: ASbGncu7rVB2VyR9iVV3ML155h4VoyxC3WtzJc6kWO3X7mvOCmp1bqYt5lzNMTvjkyW
	A6y2ycNHdZXkTVLy25iKDtJP6MrGMYMn/tV/nN831HxrNp7U5jc4DFiTB2jAqkn1EwIMIM6svG9
	aRx6LWYFJJdy/+Wjq3yVYDvtZ3+7O+NkvtgKcD7ne0+LGGHzXpGk830eQhMERNo32TgJgXd1iZM
	ku8DYNr+QZv711z9Crg7qxArMSo8eP4TPkH/A==
X-Google-Smtp-Source: AGHT+IE69LKH/NE6WW9KYSfgI5K8eXDRrZSpNwn7Zg+fzj0drMI9U+jkzmrowvG1UrutOgnm3kdrLWQIhWCejBy9GBI=
X-Received: by 2002:a17:90b:3ec5:b0:334:29f0:a7e4 with SMTP id
 98e67ed59e1d1-33b5138e32cmr36496555a91.21.1760539775424; Wed, 15 Oct 2025
 07:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912195339.20635-1-yana2bsh@gmail.com> <20250912131722.74658ec0@kernel.org>
In-Reply-To: <20250912131722.74658ec0@kernel.org>
From: =?UTF-8?B?0K/QvdCwINCR0LDRiNC70YvQutC+0LLQsA==?= <yana2bsh@gmail.com>
Date: Wed, 15 Oct 2025 17:49:22 +0300
X-Gm-Features: AS18NWC8jphTpk8XmfrNi0U2OyQEvZMStTycvFUqIt8mxiSBHWFeGjYnyBqSIBA
Message-ID: <CAEP49o+-=HeW4NgB5a0H6gM9tPJg=oNeUA1iCbXq_1qZPPaGnA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] genetlink: Test Netlink subsystem of Linux v6.1
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The motivation for this work is to improve the test coverage and
reliability of the Netlink subsystem, specifically for the core
af_netlink.c and genetlink.c components. While the subsystem is
critical for kernel-userspace communication, its coverage by the
existing selftests is quite limited.

To quantify the improvement, these new selftests achieve the following
line coverage (as measured by gcov):
- net/netlink/af_netlink.c: 84.0%
- net/netlink/genetlink.c: 88.8%

Integrating these tests into the upstream suite will provide long-term
stability and make it safer to refactor or add new features to the
Netlink core in the future.

=D0=BF=D1=82, 12 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 23:1=
7, Jakub Kicinski <kuba@kernel.org>:


=D0=BF=D1=82, 12 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 23:1=
7, Jakub Kicinski <kuba@kernel.org>:
>
> On Fri, 12 Sep 2025 22:53:23 +0300 Yana Bashlykova wrote:
> > This series adds comprehensive testing infrastructure for Netlink
> > and Generic Netlink
> >
> > The implementation includes both kernel module and userspace tests to
> > verify correct Generic Netlink and Netlink behaviors under
> > various conditions.
>
> What is the motivation for this work?

