Return-Path: <linux-kselftest+bounces-24788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F97A16B66
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170EE3A643A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAC1DEFD4;
	Mon, 20 Jan 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XummadlH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11221DEFFE
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372027; cv=none; b=JIZsUdBNhmFeZx/vsUW/xicC77RAVaWvHw0ulAzJlJB2CEBtsSJONaUvELlGVyLwZatYDgZrHajn6l0X1Da2eJ1UVPW510yegyuT29NGhzkSzUehzXLYimUVDfEUjqgs8XaC65TJSReOoy2RJr6lYbk18pHzuneMFg2EbQ+aCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372027; c=relaxed/simple;
	bh=HukkzVgJWy6wIfrwhhW16Kaa45VNmNtSiyTH/3KseCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd+omkp76vgROaNrqNAcDOz8cS1UmFyAAdt3EwxDBatBsHuTr7hRdPnfj54BeZhTeMUQR2ZGdJHdeZCvqvtd4N3asxQG3CnL5qO5y1iuMKvA3GbIjGDh0upbxrQvCFaK+GyCEh/lvBOJxfZgUtfiqJciKZi+OrNMkQ0M6zzRQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XummadlH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54024aa9febso4386038e87.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737372024; x=1737976824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=508sHaRatzNmV2AC5YDUok9kXq8AxMjNJqX2AsrhRz0=;
        b=XummadlHa0e8irAytWugKv9AtJjYftloGGts94HPaK2057kE7o/kpCX8Tu9kxv569Y
         O1y9hga8FgZf14NSUBtQzI/MJVJJZlvoM6bCp8KfMBlrSIsqknsTAkFe15TeVpSCMSUG
         WWLzhGco5yqv1IlYMTc1A4epT90MkQ7ga2WY//0IMM7pATJvK1Yl6gWGCJdnDn1sd4p2
         72HznhIOE82O9k801gncYGX9GbyT7hgs9w8bEjMgs7SAGarB7WcouQiN8YOfNdPhyzsn
         GuxZ4qXrINRKu/bbKad7E4O1cr3Fd3aTb7OHuMJ79Rk3Q1g3IJ9M5WCgGXegouQhuBCp
         UxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737372024; x=1737976824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=508sHaRatzNmV2AC5YDUok9kXq8AxMjNJqX2AsrhRz0=;
        b=BpeCGztU+nI2IHFaVLIyBy8/K71zFDPuVQf/N0qtnLm0wel5py+dSnoj/o6r8Zb1sg
         yCdd5xvw4NpJAt4gYL0APXsnWYdK24lfoccwmifeGKeZ+rpQhriDz07yD9mfB3kKZLvH
         4ZN5hTgybwtB4mmNTy/EXTT9Q5VAHRkSufic6Hfbx/2SG1VyGvLtivsbBqbD92t1s/xt
         jMUN6FvYDxNiRkHIVsSPlDAonZQL3aUweX7kvBtS5TVe6aDHJwJCbhZ/VCrE2fTExdQp
         n/CxjQYZm5N/DYYln/uLd1owtl46EPbNxfAi63cFa7O76DhGnyLDkDNIasbiXDv0WB3I
         HRwg==
X-Forwarded-Encrypted: i=1; AJvYcCXRCC38YAH/MEImNvHnyPJE9efaiuIKQKsrOu70OTo4iNbGKfQDxEthNZLJDF01vLHZ7aKs+P8YM3BQePHGRis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDaxwYxcR2hjsVn5lqqAfxrQHM07Xu9kcbDD+46/3sgCgIztx
	Vn4x25PJOKqpkqanth2aqPR/oUFwYwfYTGkiZRcuZrBxDXsGTLXxmlDfCOjHaXWGmJv0c+GALaa
	deWkqJ/87B5bcS2dDSBFJk7ugnRWiXZ5tOZsY
X-Gm-Gg: ASbGncvezkCEaL3B1P8v3l+RgFo4jPAV8pAyh2g6hqtcIZh2UXCeSxEY4axcySx9gS4
	PFO2SlmjfbcY/tbwC+cN7eVWDdZVFNnSg6bvCbbDZWF/nz1rFtvQ=
X-Google-Smtp-Source: AGHT+IG5bUWJMn934aJFLLbqBw2AOkIQsKQjJQf+FW5w2joFGVMUSmQehttNlWkcrmhhT9aHd4c5YEvXBK36xXQTVQg=
X-Received: by 2002:a05:6512:33cf:b0:542:2a0b:cdd4 with SMTP id
 2adb3069b0e04-5439c287e81mr4094208e87.47.1737372023561; Mon, 20 Jan 2025
 03:20:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com> <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
 <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
 <51f0c6ba-21bc-4fef-a906-5d83ab29b7ff@daynix.com> <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
In-Reply-To: <CACGkMEuPXDWHErCCdEUB7+Q0NxsAjpSH9uTvOxzuBvNeyw7_Hg@mail.gmail.com>
From: Willem de Bruijn <willemb@google.com>
Date: Mon, 20 Jan 2025 12:19:46 +0100
X-Gm-Features: AbW1kvafrr-kRH1qQ-nNk15dryD6rNi5eAueO9Om8WJCSgPSnlELq-Vuki0tXiI
Message-ID: <CA+FuTSec1z7-8nNNc1ZXkzekDrFHPnvYKFf8PNZg89VuwhoWSw@mail.gmail.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
To: Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 1:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jan 17, 2025 at 6:35=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayn=
ix.com> wrote:
> >
> > On 2025/01/17 18:23, Willem de Bruijn wrote:
> > > Akihiko Odaki wrote:
> > >> tun and tap implements the same vnet-related features so reuse the c=
ode.
> > >>
> > >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > >> ---
> > >>   drivers/net/Kconfig    |   1 +
> > >>   drivers/net/Makefile   |   6 +-
> > >>   drivers/net/tap.c      | 152 +++++--------------------------------=
------------
> > >>   drivers/net/tun_vnet.c |   5 ++
> > >>   4 files changed, 24 insertions(+), 140 deletions(-)
> > >>
> > >> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > >> index 1fd5acdc73c6..c420418473fc 100644
> > >> --- a/drivers/net/Kconfig
> > >> +++ b/drivers/net/Kconfig
> > >> @@ -395,6 +395,7 @@ config TUN
> > >>      tristate "Universal TUN/TAP device driver support"
> > >>      depends on INET
> > >>      select CRC32
> > >> +    select TAP
> > >>      help
> > >>        TUN/TAP provides packet reception and transmission for user s=
pace
> > >>        programs.  It can be viewed as a simple Point-to-Point or Eth=
ernet
> > >> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > >> index bb8eb3053772..2275309a97ee 100644
> > >> --- a/drivers/net/Makefile
> > >> +++ b/drivers/net/Makefile
> > >> @@ -29,9 +29,9 @@ obj-y +=3D mdio/
> > >>   obj-y +=3D pcs/
> > >>   obj-$(CONFIG_RIONET) +=3D rionet.o
> > >>   obj-$(CONFIG_NET_TEAM) +=3D team/
> > >> -obj-$(CONFIG_TUN) +=3D tun-drv.o
> > >> -tun-drv-y :=3D tun.o tun_vnet.o
> > >> -obj-$(CONFIG_TAP) +=3D tap.o
> > >> +obj-$(CONFIG_TUN) +=3D tun.o
> > >
> > > Is reversing the previous changes to tun.ko intentional?
> > >
> > > Perhaps the previous approach with a new CONFIG_TUN_VNET is preferabl=
e
> > > over this. In particular over making TUN select TAP, a new dependency=
.
> >
> > Jason, you also commented about CONFIG_TUN_VNET for the previous
> > version. Do you prefer the old approach, or the new one? (Or if you hav=
e
> > another idea, please tell me.)
>
> Ideally, if we can make TUN select TAP that would be better. But there
> are some subtle differences in the multi queue implementation. We will
> end up with some useless code for TUN unless we can unify the multi
> queue logic. It might not be worth it to change the TUN's multi queue
> logic so having a new file seems to be better.

+1 on deduplicating further. But this series is complex enough. Let's not
expand that.

The latest approach with a separate .o file may have some performance
cost by converting likely inlined code into real function calls.
Another option is to move it all into tun_vnet.h. That also resolves
the Makefile issues.

