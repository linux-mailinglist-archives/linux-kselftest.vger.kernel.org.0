Return-Path: <linux-kselftest+bounces-28438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB7CA55993
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EAA1891C42
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 22:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73EF2702B8;
	Thu,  6 Mar 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j0kgmuw1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D733981
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299656; cv=none; b=ppOKxhSrIiLfLH31TpwnMaJ97RTCRirhce7G1+gC0mAQ04CCOapcO2WczPEkBmotPA0OOmerEqU3wjqHgv2xHj2fMSIVVRNHINW5gfOCHxHcbUGbpnatj95weZEi1JvGxFGrrxwJ6F86rsh5DC8/d+cLxt1zBXd6a7/Fnl5ZQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299656; c=relaxed/simple;
	bh=jijdJY1WNEMtaADEADccQQLCKIQ1VEpcBe0JlrxiChM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PC0LFx8jx7mOSFhPk8Y8YvlxQwu3FfendFOpQadIukppyzSlVgfhO+2iPvPxBo783QqY7/WyTkReZcKWDiWyPhCA82dxt5jjtnCfLBfPha6eMGuFoZrbBivtblroryv4AO/NBGRKyixageAlcW1ePtH+4aps8Mo3mFS19I/Qie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j0kgmuw1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so1476787e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 14:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741299653; x=1741904453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxnxNhRkl2oL5lhMxI8nazAurkutLlKeiLI6Pg9V1N0=;
        b=j0kgmuw1crX55YfX8ceofq/+A3IoPu+Ne87z/kzb6D1GPHx3wDptI+e3waS/0oq69v
         Rzw9JDTUwYp1LPDKb2vII2+PkbVGKgy1k89xpnGggsjR/GkM6JzBV8+udg8K74uYKr6V
         ihmBlVgBvpJn56iYO3/K0Q5odU5fUT2/dl71n5VZaYw7r5YJKVelhmyEIhhkyiAI68rQ
         yr4Di8jDjmjp8EVoIqLHQ/fsXVGZ83oUr/NkWGQRoB4kQyXFOmZF9Rs2NbO1wuC2DrJC
         jGJUv9Udzm1V+22GZMHi3iXg5ub0J3avot6lb735u65UuQPcbbKnyMcyA/543HyZcAu9
         +RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741299653; x=1741904453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxnxNhRkl2oL5lhMxI8nazAurkutLlKeiLI6Pg9V1N0=;
        b=ScaExPKIv8hTzuYyuCRyOzA++xsDENsfMSaBuxrPVmRAndDdlq6qw6exa5XQ8Cmi3O
         DIV+AANYbrTY/H94lYCGewnp9161epuCFD2dP1bV9gHtSsuVjGn1N3mtPKBq83W8NxFK
         gFGpy75zXPW/dZ1TC4DvkCig8ksg1ngI94o550ktKAmkcbiVVuHlwuko6Td7kIFWwbNL
         hIC15+nyTlkOJna0mBMzO8bc23Yg7aloX/fDvUNcjue86Th/ky0vB0KjAU46QtpJbCHD
         KppcubPyTkuk2E9ygfUfx2VO6to6fTTVKactRsCSd02Novvg4sWCbF9n6CF1cXr/n9hb
         Uc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVX9JDusNL4fu+/YjuZ5xZ7WIsc3lH+ZP6de5WL3h59CGmySeRa7/crcoClK/c/w5LWdB2R0lNVzbs0WsasChQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSD6QvOgXNIYfgx0d69KE68oUOsRbvdG/UyHDwMo0SgZlf/Ql
	l+0yeiBOYqJvZKWb/HtUlM3t6jFTtd9eIGW8W6nSCLN6YenVrUA2Rb+0AgUzyClUOeRZT1Mwz9i
	i4/oXkPQpN3DpJIVsqNnvh4s39T9Sa2U5Bc2Y
X-Gm-Gg: ASbGncuUQWP+gSZBcmuJaiukG9lMFKZWxGIMLqCOc25RqAAhgH5419dTsKFcePNF6p6
	zrY7VeyRDP9QuxfbKO1sB+3yZftlNItwt28H/NUuUQoypf2vTaEjK5jLP5PJu1liNwyyR841o5L
	RdA+raNlGG7+OLlklkCGi6LtQNN1qhga0m8F59q5h2tWb3QfoCUbTUMBTd+kt8
X-Google-Smtp-Source: AGHT+IFQgIlBAILKlFeBj7k9VDE4fActFzDL06Lw+FnjKfZU+rvuCrTsR7pDVJjk4w6BeOMqBwDPg7MqdYOkyAUoeYQ=
X-Received: by 2002:a05:6512:ba6:b0:545:291:7ee0 with SMTP id
 2adb3069b0e04-549910b5b79mr293613e87.34.1741299652869; Thu, 06 Mar 2025
 14:20:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306171158.1836674-1-kuba@kernel.org> <20250306171158.1836674-2-kuba@kernel.org>
 <67c9f8ed24f9c_1580029416@willemb.c.googlers.com.notmuch> <20250306125601.522b285a@kernel.org>
In-Reply-To: <20250306125601.522b285a@kernel.org>
From: Willem de Bruijn <willemb@google.com>
Date: Thu, 6 Mar 2025 17:20:15 -0500
X-Gm-Features: AQ5f1JrhQnewTLzm97XmL5Ku02o7-1hgYN3SI2rppHUO_6A3ax5AY4i0rPHDXRM
Message-ID: <CA+FuTScAQD9eMc6==2en7wko9WR4YjX9LO_jd1rngVbECQK1Nw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: use the dummy bpf from net/lib
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, petrm@nvidia.com, 
	sdf@fomichev.me, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 3:56=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 06 Mar 2025 14:35:09 -0500 Willem de Bruijn wrote:
> > How does tools/testing/selftests/net/lib get compiled?
> > The other subdirs of net are separate explicit targets in
> > tools/testing/selftests/Makefile
>
> There is some magic / hack at top level:
>
> # Networking tests want the net/lib target, include it automatically
> ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
> ifeq ($(filter net/lib,$(TARGETS)),)
>         INSTALL_DEP_TARGETS :=3D net/lib
> endif
> endif

Oh right.
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/t=
ree/tools/testing/selftests/Makefile#n129
>
> > And what is the magic that avoids the need for adding bpf objects to
> > .gitignore?
>
> All BPF files are suffixed with .bpf.c and we turn that into .bpf.o
> So they have an .o at the end, I think the global gitignore ignores
> those?

Also makes sense. Thanks!

Reviewed-by: Willem de Bruijn <willemb@google.com>

