Return-Path: <linux-kselftest+bounces-3154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E86E830A18
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 16:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC54128796B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 15:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C251822304;
	Wed, 17 Jan 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvk8/f8/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F3321A16;
	Wed, 17 Jan 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506904; cv=none; b=ci2eReWfEnlpfOxRwYCqtU9OvOB4vc6PE4IX4CaelxH3hPLQe1WVwIQ3J/whNY14G0sVmeL+pfl3A9NKHcq6iZ8Q0rjp9grWDA6Wvn1i/sQheoXkGC0emu1wjE4vv4IfdTCb1cpUzcao2eqbbg7JkZiVx7gYG/bRQt5G9CayfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506904; c=relaxed/simple;
	bh=ttGJe8J4pcxRkey779Yd+cZv874UqM4wsN7cskxubio=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Message-ID:In-Reply-To:References:Subject:Mime-Version:
	 Content-Type:Content-Transfer-Encoding; b=ajkBXDmtS7H1Aeo9qSlleNT4HpF/k3t2gUJEsoSuXfZvSWyDb1ws88+Jzn5U3hyAg3RrA0RxYOOqSLb6YGatWOziav9SP444p1Y8oRNfz7VRhpZufQaCkHdlv0SsznfrWdOWmtGaAi9uQSSaFVCHc7SMQhGpqernvnDtiDy6OqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvk8/f8/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-680b1335af6so93855216d6.1;
        Wed, 17 Jan 2024 07:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705506902; x=1706111702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttGJe8J4pcxRkey779Yd+cZv874UqM4wsN7cskxubio=;
        b=dvk8/f8/2jB5aZe7zNFkQZ/ejUppjaKbdR/8nxkSG79U+tturBRm51To2SWPC9sHGe
         aLpDeRpPDva5Q0oYTZnGS54EcmdZDVfhAUXyYfrs8vhfOoQbNKX4q5c+9GonWpsJjcM2
         +CWJicwLzn7dYvNLztnqu3Njwrf4isYiAvnReX0FvhvZDV16bUDb4CtKS3zTEKC9Lbvb
         rSrZmPAZLxwDqrGU1TZZiT7geGb3b2DSTtO1NTPXSyzigj7uq7MNmv1P6OM8RhsCPbsk
         qkwTdM0ojsgQ/dTXVn2p2AG+F7UCvQqAOP4TVkyFyMZB7LvuW1eTkKTVGAK5vF85Vrqh
         0T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506902; x=1706111702;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ttGJe8J4pcxRkey779Yd+cZv874UqM4wsN7cskxubio=;
        b=jFebSC/WUErS27Edax5RA+EhrAF0vwHYVek/+QFQAKaIZaWCF3H8XBPWdsbQoo3rvy
         +ZM0c1RxlXtSL/83PqDXRER20WQ7hYPlhtcrxGR48p46HRlO3fvNaknK2gaghfqhCWdj
         J/DBwc6ZAH85hlfYtnUPpUjkQnT1efgzNSof26kdtXBm+g1azd+FfSsjwd7BO6rG7mS2
         BOOg0KOMrTwjVktGwvP9woVzb+kMWeng4I5R+1Cpr2SnFcwW9/RtOp58lThKC3tJVeh8
         +JlTu9yM+NuQtg/GBkhG8Rn0YoBYiISNxkJJabPJ1v8CCMuLbwp8Yex+RJUD2Gns2R+Y
         7Q4A==
X-Gm-Message-State: AOJu0YxKCxIrLyS4IzAwpKXJXaIo3n3gnLAf7ZgNUZowLjG/ngnGAYBz
	xVsIcbAWrVDihVWYWgjlEiA=
X-Google-Smtp-Source: AGHT+IFUKgLAXPaJ1GM7ZGPSYyL9MUqnyevX9UQH1PtY6537DD4fa9EPrz350Q+gOCYQG6L2WQwC/w==
X-Received: by 2002:a0c:dd11:0:b0:681:698e:17d8 with SMTP id u17-20020a0cdd11000000b00681698e17d8mr1348439qvk.52.1705506902051;
        Wed, 17 Jan 2024 07:55:02 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id v20-20020ad448d4000000b006817069492bsm1407241qvx.70.2024.01.17.07.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:55:01 -0800 (PST)
Date: Wed, 17 Jan 2024 10:55:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <j-t.hinz@alumni.tu-berlin.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Deepa Dinamani <deepa.kernel@gmail.com>, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Message-ID: <65a7f855821cc_6d500294d0@willemb.c.googlers.com.notmuch>
In-Reply-To: <51fd5249-140a-4f1b-b20e-703f159e88a3@linux.dev>
References: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
 <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
 <51fd5249-140a-4f1b-b20e-703f159e88a3@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with
 bpf_setsockopt()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau wrote:
> On 1/16/24 7:17 AM, Willem de Bruijn wrote:
> > J=C3=B6rn-Thorben Hinz wrote:
> >> A BPF application, e.g., a TCP congestion control, might benefit fro=
m or
> >> even require precise (=3Dhardware) packet timestamps. These timestam=
ps are
> >> already available through __sk_buff.hwtstamp and
> >> bpf_sock_ops.skb_hwtstamp, but could not be requested: BPF programs =
were
> >> not allowed to set SO_TIMESTAMPING* on sockets.
> =

> This patch only uses the SOF_TIMESTAMPING_RX_HARDWARE in the selftest. =
How about =

> others? e.g. the SOF_TIMESTAMPING_TX_* that will affect the sk->sk_erro=
r_queue =

> which seems not good. If rx tstamp is useful, tx tstamp should be usefu=
l also?

Good point. Or should not be allowed to be set from BPF.

That significantly changes process behavior, e.g., by returning POLLERR.
 =

> >>
> >> Enable BPF programs to actively request the generation of timestamps=

> >> from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the
> >> network device must still be done separately, in user space.
> =

> hmm... so both ioctl(SIOCSHWTSTAMP) of the netdevice and the =

> SOF_TIMESTAMPING_RX_HARDWARE of the sk must be done?
> =

> I likely miss something. When skb is created in the driver rx path, the=
 sk is =

> not known yet though. How the SOF_TIMESTAMPING_RX_HARDWARE of the sk af=
fects the =

> skb_shinfo(skb)->hwtstamps?

Indeed it does not seem to do anything in the datapath.

Requesting SOF_TIMESTAMPING_RX_SOFTWARE will call net_enable_timestamp
to start timestamping packets.

But SOF_TIMESTAMPING_RX_HARDWARE does not so thing.

Drivers do use it in ethtool get_ts_info to signal hardware
capabilities. But those must be configured using the ioctl.

It is there more for consistency with the other timestamp recording
options, I suppose.


