Return-Path: <linux-kselftest+bounces-7674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9658A07CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 787E2B21B49
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 05:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5189513C9C7;
	Thu, 11 Apr 2024 05:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UVEA5coY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB1EEADD
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813793; cv=none; b=thz4IkhKnjHM7x4Dulre4Bj2tNAfuOvVGqG1NjYD/kHVLXrYci/kMnk2d82qFggYDn24x3O99yWrV0Ar9MSoTLp70W+tszzQR1CKy2MSXaOVyICaFEKX2NrieTTIbzcTsKHvh0cNtXq6+8gTTSDJc6uRpLaCvdLi66kQ2MsyH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813793; c=relaxed/simple;
	bh=9Pa5OXbNJf9HL7UJhH3JcFa5n8z2BXnqXldXUMG2phA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHlcrs5atHAZPSnZ6jZ9+nZ1EVNBgTSQL5TbqOVbZx9YJ8dt+VTVQfl049BPg9UuE7ZYkn3QkkoAojmP1p/yDUoIQy4z0+ZiXKNoqcBAvo9TblX0r38WLGzh6W9OV4xNJwlZVbcYABBvtozyblxLpijHyrI9xHm8goEvT2wC9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UVEA5coY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78d6bc947aeso195913085a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712813790; x=1713418590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O5BYI4OdHldRtjTHclfiNrTCLX6On9bTqWbaBCK7vA=;
        b=UVEA5coYYeRS8uJ/hQdFaOIXudpCoLobLBTccakXm0Jyi/CMcxJbV87hXhB+g288IO
         nO1t0+AtE6NoMd7ULm8mDKJPUBZXvqwSqAoQhKL49YJ9qNJ4iS8UYX90YNH8RmLsGeG9
         uiduuU9TNk/JEWgebJZFhmsYyXGobYyK7TynOxqkYXy0GmkTSIAzf4twCCQMTp7ewm1O
         bGTSinl2jts3Rpw1r3D+9y29/a/mqzNqcj3eq+vdswTpfffeJc109bJRVnY2QqD+F99H
         DGRDReEpKwQCihIaGfXHOjVN90Z7epVBaScEyer1BXHuG5fEAoTgpxjsASGC565C+eNb
         EVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712813790; x=1713418590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O5BYI4OdHldRtjTHclfiNrTCLX6On9bTqWbaBCK7vA=;
        b=RM7pco3nJWf13iBrKxqXKR2pHa8FWrHll2RkZyYYzxKbJxMpDt2zVPM75qSMZwWiJl
         nSDVOwQ35xsBnDY2PgNLz9fK5GuqXtb1o6CwpJTxjEuD7LyVQXRC8d0bmrV3jWmJbwX4
         xyPHmroJOmMjz/Tcdokp7cVvAYPAVX+Yu2FbIWoH/8226BkJ7Pvi7Cl7Wqj5j+Omx9mx
         K/67PO0cz13vTY4cQ+Qmk1VYTiNOLm7/HyDlSn51fVZwutDq2sTUa8/s1dFpK8jKnrfV
         YPxybg8Ja1C2dcn10G4cZGhJkEfWRNZLoeYYbaOzplv/vvY2nZpZDnEmZdUDs+HdQ1E/
         bS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtYSTqumWmeI7EjNp2ZVGvu2G9fjP7neejyluhuChVplrPaFdewkC6ZT3GeCTIFUHetBKXCEzi6V4dbSi1gALBE+UkucldV/ndLyOXZ8k+
X-Gm-Message-State: AOJu0YyYektr+LDlSiUBrkQib4ADp6nHyYQXJ9TeK1pBMtBRWivLWrlz
	EjvT9hgwKDWM4V2GOS1GoayDj44FZ0Gi4PClc/LhXFQntPrMuGfDnWcBGQRQWyAwRDLq8skV6YL
	FeGbAH0IEBRBgzZRgBKxdF836S0cw2kFmxlAqqw==
X-Google-Smtp-Source: AGHT+IHXub++9CumsI9Ywnl2w4/5t7+EuZITPbvJVWOGFVEzJbCVmljtvqkv2l8ii4JKL3C+bb02heSSmwmSGs85R3Q=
X-Received: by 2002:a05:622a:130f:b0:436:5951:6005 with SMTP id
 v15-20020a05622a130f00b0043659516005mr1527116qtk.22.1712813790711; Wed, 10
 Apr 2024 22:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411051124.386817-1-yuri.benditovich@daynix.com> <20240411051124.386817-2-yuri.benditovich@daynix.com>
In-Reply-To: <20240411051124.386817-2-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 11 Apr 2024 08:36:19 +0300
Message-ID: <CAOEp5OdiSW9ddv53JQHY57fCTwGc3eq-uWstSGcYFsMaW-FtOw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: change maximum number of UDP segments to 128
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, yan@daynix.com, andrew@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've just fixed the 'Fixed:' line and extended the commit message.
We can continue the discussion in the previous email thread or move it here=
.

On Thu, Apr 11, 2024 at 8:11=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> The commit fc8b2a619469
> ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> adds check of potential number of UDP segments vs
> UDP_MAX_SEGMENTS in linux/virtio_net.h.
> After this change certification test of USO guest-to-guest
> transmit on Windows driver for virtio-net device fails,
> for example with packet size of ~64K and mss of 536 bytes.
> In general the USO should not be more restrictive than TSO.
> Indeed, in case of unreasonably small mss a lot of segments
> can cause queue overflow and packet loss on the destination.
> Limit of 128 segments is good for any practical purpose,
> with minimal meaningful mss of 536 the maximal UDP packet will
> be divided to ~120 segments.
> The number of segments for UDP packets is validated vs
> UDP_MAX_SEGMENTS also in udp.c (v4,v6), this does not affect
> quest-to-guest path but does affect packets sent to host, for
> example.
> It is important to mention that UDP_MAX_SEGMENTS is kernel-only
> define and not available to user mode socket applications.
> In order to request MSS smaller than MTU the applications
> just uses setsockopt with SOL_UDP and UDP_SEGMENT and there is
> no limitations on socket API level.
>
> Fixes: fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validati=
on")
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/linux/udp.h                  | 2 +-
>  tools/testing/selftests/net/udpgso.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 3748e82b627b..7e75ccdf25fe 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -108,7 +108,7 @@ struct udp_sock {
>  #define udp_assign_bit(nr, sk, val)            \
>         assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
>
> -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> +#define UDP_MAX_SEGMENTS       (1 << 7UL)
>
>  #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
>
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftes=
ts/net/udpgso.c
> index 1d975bf52af3..85b3baa3f7f3 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -34,7 +34,7 @@
>  #endif
>
>  #ifndef UDP_MAX_SEGMENTS
> -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> +#define UDP_MAX_SEGMENTS       (1 << 7UL)
>  #endif
>
>  #define CONST_MTU_TEST 1500
> --
> 2.40.1
>

