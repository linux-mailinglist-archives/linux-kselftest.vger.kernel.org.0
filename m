Return-Path: <linux-kselftest+bounces-21438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6AD9BC3EF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 04:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A541F21768
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BF2184523;
	Tue,  5 Nov 2024 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUumOkA1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA23D9E;
	Tue,  5 Nov 2024 03:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730777673; cv=none; b=KBgcntkSw6DFRVyd24f3q4Jm6JasRjEseeMdjXHL/m15Zab7TsJVhHdrDg+StvapuTRQlcQrdwd6sP6RU+BXWvggljuYUgdKcJbtKW1nkKXaFy+CopA1oEGpIvsfigIZcXhwgnUbfJROQ7wkuCtzhWdEIfwLozZsUv8IZYr2TUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730777673; c=relaxed/simple;
	bh=/zkq0tofzKwv60XMTrmCP+LAJXE7HfavU3QZkSxWQPY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzcBivT5/GqDkJrMf5i9cxO6VvPySS8FyPiANdZ98v2q921kivrjHHiP6v8S+hLtcPhm/3y/vFas79D2LrEiw/JdRMIW6HW1VX23wLFkvn5JPE/Ip1xHEn4FErJ/BTtb8ZgcaATebdzoQynt7Q+y4uIDXn8UsRia5QRIQUbdS0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUumOkA1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so3511169a12.0;
        Mon, 04 Nov 2024 19:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730777671; x=1731382471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6AIe/dTqMIYfTgiz4qxI4zvtCNJoQcTeXciVnJdiHI=;
        b=QUumOkA1kJleauelbVXK9FTKBhEfLIoq3VHuB1LSQ5hp1Kl3kpwMphtnrftgjpBG/d
         gFI89vUwv60UM6NY3lckfCB/FjUaXArit51aYv4gAA+bnbZ+gGnGmu1DgJDHiw6HqWNI
         iB2Mt7XIU+vF3F96AXynuS8vK2+fpvwRsX35I/LqSrThWjsRhYISqsu55L6+rcMcb1LU
         oGK/jbrj5z8Mlz9M2W0wfwpt1yKTYg06wU/baDs70rJPbqmSehRkAFBjInJcmgzoNFfp
         Lb7C7ndJgwGN365IRHUUpM6h+YM0kMwh6/HgcnZJyMUKyJiG5v6fsA2wtnnQUFthqHzi
         sRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730777671; x=1731382471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6AIe/dTqMIYfTgiz4qxI4zvtCNJoQcTeXciVnJdiHI=;
        b=c7lI6r/49wX/y4gttF5t1j5Js6nIG2D0XKH1lDUsO2Q2c4LK0h152ZJZSyHxN8aVJQ
         kwzkmJTYrGA8t8S2lk2OaMdh17qZPOzAdlmYqIGnqT6rOY7DT1DBtmN3Hata4I/bT9LH
         kgeZ235wA1Uy2EbYfy6VmQMmG6iGhbPTzWQ5GNHp4bZrQ4SHILkm4NAICKyyO2QZ7MEs
         wGmDJf1REAkp/7zKrCmXrgOacZLMQAT3j6cW/aYip5kpjbMam6unSjmAay0goP46O3ij
         9hSASE6YOLHzafE5Vr6ACSRVsSg4Yi8mkXPQjPDMHz7JWi3sXxWQ20wezz8uVKpfnRCF
         usUA==
X-Forwarded-Encrypted: i=1; AJvYcCUJCZ6ddtuJE7kRaerbT+f9td7iiBSKmcW2MvRlsstvEU6z1SfrC8StXDN1fHktHgCytgy/AWu/@vger.kernel.org, AJvYcCViWidbrEXJJlj6mEaVeYO/i7o6Vx38ZugRkdWcPfOhYHYAhm849JOaqfYWcz6hRYyyFk7l6bjJEZqseyCjSuC3@vger.kernel.org, AJvYcCXT9AIFYRipZkfDc86Rf2ZsiFKPD3hHhUsjTc2OeRc81yfdLcxf5zBUoud/mL7lhZAS6RaQTvmsjgv5JEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTQnsa5Yo7dr24PW+nA6vAlLbdjARVAQ5WzIEansx7c8osdB0
	ROb6dBhvUs1ZhUZ57QMYhj9qdSN3GP7P2KLZ5b806AyaqNMlmNs=
X-Google-Smtp-Source: AGHT+IG99VSv7YooZkG+TpE0SxkBFCnr8DMr16i90UPeDqyOBVlUtW5FCSgaEccRwWlwfwR68xj+yQ==
X-Received: by 2002:a17:90b:2243:b0:2e2:c421:894b with SMTP id 98e67ed59e1d1-2e93c14fd5dmr23051033a91.14.1730777671021;
        Mon, 04 Nov 2024 19:34:31 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057bffffsm68835685ad.188.2024.11.04.19.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:34:30 -0800 (PST)
Date: Mon, 4 Nov 2024 19:34:30 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 12/12] selftests: ncdevmem: Add automated test
Message-ID: <ZymSRij76y6bvRi9@mini-arch>
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-13-sdf@fomichev.me>
 <ZyljjgxP94IBWnI6@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyljjgxP94IBWnI6@LQ3V64L9R2>

On 11/04, Joe Damato wrote:
> On Mon, Nov 04, 2024 at 10:14:30AM -0800, Stanislav Fomichev wrote:
> > Only RX side for now and small message to test the setup.
> > In the future, we can extend it to TX side and to testing
> > both sides with a couple of megs of data.
> > 
> >   make \
> >   	-C tools/testing/selftests \
> >   	TARGETS="drivers/hw/net" \
> >   	install INSTALL_PATH=~/tmp/ksft
> > 
> >   scp ~/tmp/ksft ${HOST}:
> >   scp ~/tmp/ksft ${PEER}:
> > 
> >   cfg+="NETIF=${DEV}\n"
> >   cfg+="LOCAL_V6=${HOST_IP}\n"
> >   cfg+="REMOTE_V6=${PEER_IP}\n"
> >   cfg+="REMOTE_TYPE=ssh\n"
> >   cfg+="REMOTE_ARGS=root@${PEER}\n"
> > 
> >   echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
> >   ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.py"
> > 
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  .../testing/selftests/drivers/net/hw/Makefile |  1 +
> >  .../selftests/drivers/net/hw/devmem.py        | 45 +++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >  create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index 182348f4bd40..1c6a77480923 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -3,6 +3,7 @@
> >  TEST_PROGS = \
> >  	csum.py \
> >  	devlink_port_split.py \
> > +	devmem.py \
> >  	ethtool.sh \
> >  	ethtool_extended_state.sh \
> >  	ethtool_mm.sh \
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> > new file mode 100755
> > index 000000000000..1416c31ff81e
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > @@ -0,0 +1,45 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +from lib.py import ksft_run, ksft_exit
> > +from lib.py import ksft_eq, KsftSkipEx
> > +from lib.py import NetDrvEpEnv
> > +from lib.py import bkg, cmd, rand_port, wait_port_listen
> > +from lib.py import ksft_disruptive
> > +
> > +
> > +def require_devmem(cfg):
> > +    if not hasattr(cfg, "_devmem_probed"):
> > +        port = rand_port()
> > +        probe_command = f"./ncdevmem -f {cfg.ifname}"
> > +        cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
> > +        cfg._devmem_probed = True
> > +
> > +    if not cfg._devmem_supported:
> > +        raise KsftSkipEx("Test requires devmem support")
> > +
> > +
> > +@ksft_disruptive
> > +def check_rx(cfg) -> None:
> > +    cfg.require_v6()
> > +    require_devmem(cfg)
> > +
> > +    port = rand_port()
> > +    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> > +
> > +    with bkg(listen_cmd) as nc:
> > +        wait_port_listen(port)
> > +        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=cfg.remote, shell=True)
> 
> FWIW, in the v3 of the series I submit, Jakub asked me to replace nc
> with socat due to issues with nc [1].
> 
> Your usage of nc seems pretty basic though, so maybe it's fine?
> 
> [1]: https://lore.kernel.org/netdev/20241101063426.2e1423a8@kernel.org/

Since I'm doing a respin anyway will try to move to socat as well to keep it
uniform, thanks!

