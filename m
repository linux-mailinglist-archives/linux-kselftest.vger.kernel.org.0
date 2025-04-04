Return-Path: <linux-kselftest+bounces-30094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE6A7B725
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 07:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02F13B8A96
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8F15FA7B;
	Fri,  4 Apr 2025 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRHv+aGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3991514F6;
	Fri,  4 Apr 2025 05:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744420; cv=none; b=qKeJt9FL0lV9D7KgTlTfEczRLYCsqY+kV0NGxzaWd/jRU81YvPpIep9UGmkHMkwdtedcxb1bSRh0UO+DyjNhcIcVjWcudrKWEnyTGVXlhDzQj22ntu4yxx0rD2dUWafW3pWLOVg159O/WuWycsfUTO7cA1C2G5ZLCM5qkTAwimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744420; c=relaxed/simple;
	bh=C0lYSua6fDsvQmLvI+OydGXMoruw7uB1CrIim3MA25U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpkRK+g72oKSu2W1Sa1CryTZ9w9p14svKyupH3+KnWc1BOv8pr7wCpCUWlNAW8sUq2MTaca3e+D8KviydC5oiLdr1Rl9saE3M/JW7/gYqeciZuTNHIZm8Rjej7tyhK3Vt0ZoDSGxcUiJpgN9glJfxVvx6m304jjKbGdW8BpMBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRHv+aGI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so2899973a12.1;
        Thu, 03 Apr 2025 22:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743744416; x=1744349216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy+e4bb9BRoQ0to6ueXIVMI4Q4x2sVS+j5MkPGS0Bqc=;
        b=QRHv+aGI0N7ad2A0O/AdFc0JmNNx0IUkPhUw2fePDVTccTaXZPIOAwA+HlKWuq2NJn
         iaAEmJWZu8vh46+a+wUoUQzY/o2pBKlgTHkm3/Gd4ss1Iybbm+tS6zd++Bbv0GGIEjU8
         jv2P30yrjYb1zubvjRiemezIqdeLr26+gSlVUGzZmb8TqEaOfgod2tgQ1Vyuoy8UJ32N
         ccs0hC2ijt8vTOQrRRJba2P/EsTpfKCtS1u39PIwFBJu4mSgqWdn3YN2SOw0vzk9hAHk
         SmvbW7q/16lgjCjkQg9R04tWllxkywHe+/fKUkz73yv4K10JP88SufJ00pI6bgnrQ9U1
         lLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743744416; x=1744349216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy+e4bb9BRoQ0to6ueXIVMI4Q4x2sVS+j5MkPGS0Bqc=;
        b=e7paw+py0CFq8ZixV73o/ZeGX1LWaJsJoeVBjFR0KjXLKQdX9S4crwVNySICQHI5FX
         f8uM3TWLD/RauFIrUyQNdypgYjJ/iOPuXtF5R08EEd4xR8Eg6EfqXgYEdc5f4Kw+me7j
         k601RMaW42B1EDmMGExiQdWkxe4ffRuAC4RGD4soLcDf6Pw5pT+XAlKgJ5up8bby30mH
         pcOHBXmUhq5XiuQjZPKx7/ccwMfjZt4uSGcfGk5rUuKu//VkpNfak7YytuAUiYDLwvEF
         o0dQV+XjAxb8vT7AfjX9vIFyxeqgID3yeT70zAGLoGFJlJlea+PhIy1lKjUTDiL+hXiA
         VYIA==
X-Forwarded-Encrypted: i=1; AJvYcCVrgQDp290g/8sSHqfXuLaiIFoU2ueuP0nkdVk5YD9k0T0Xn4ada8+cjgtYlUF3MItv/Fz1AatJcksJOW2XeV0=@vger.kernel.org, AJvYcCWD1UX9Wkp0uNbBbVCyu3YDcggrfJ+cqJS3dRqRTGBfbDVLRhyLsHk+Z32yt4qteYjB7slKOmGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzukdJi6Jz0D2OwTvZW29U7uQJLeNQV3Z5vP05stSudydXt5njN
	1WxscwivFwykKTo4VqSDb31EiJgZgx9+t/jeUN9dfFt2yUfrVEp1AZv3cb8UXO9fbXwFMYxtMxs
	juB2An3bT4D5Sq56KBBYaiFAZ1to=
X-Gm-Gg: ASbGncv3CDAVtLBCv06b31UiQ0zld550mcGGj/r7vcLcmSAAQB2E8oMREoogeX6hL9E
	tfQQcT76AHCHaebRCDIEuu5GumEg5Fl/JtSgpEwW9r6AWNIbZjOzGZ+IbLKaz3mQ3Thn5XIKsf1
	VpJeLeIMEfEsc0YwyYJSjGNCUBAQZd+wMUpUnmka4=
X-Google-Smtp-Source: AGHT+IEcjKP2DTqW6Dispo7VWlGa1QY7FyMsbyTJnCxp3oSVcKtMJhWbPm53ZKUo+HoZnLghMVs+u1TCve9CPZFp190=
X-Received: by 2002:a05:6402:1ed0:b0:5ec:9352:7b20 with SMTP id
 4fb4d7f45d1cf-5f0b3098f92mr1629339a12.0.1743744416017; Thu, 03 Apr 2025
 22:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403060423.1209435-1-ap420073@gmail.com> <20250403060423.1209435-3-ap420073@gmail.com>
In-Reply-To: <20250403060423.1209435-3-ap420073@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Apr 2025 14:26:44 +0900
X-Gm-Features: ATxdqUGOs0AuEO4WvYTuBmixNzS8_qiL4-yaXIguazEm_h5TsUnaWTszF2wfxCw
Message-ID: <CAMArcTWRnAqBNZd+dgULkm7saw24S_0f1Pw2X6e7Mfgd6zEpbQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests: drv-net: test random value for hds-thresh
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: kory.maincent@bootlin.com, willemb@google.com, 
	aleksander.lobakin@intel.com, ecree.xilinx@gmail.com, almasrymina@google.com, 
	daniel.zahka@gmail.com, jianbol@nvidia.com, gal@nvidia.com, 
	michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 3:04=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> hds.py has been testing 0(set_hds_thresh_zero()),
> MAX(set_hds_thresh_max()), GT(set_hds_thresh_gt()) values for hds-thresh.
> However if a hds-thresh value was already 0, set_hds_thresh_zero()
> can't test properly.
> So, it tests random value first and then tests 0, MAX, GT values.
>
> Testing bnxt:
>     TAP version 13
>     1..13
>     ok 1 hds.get_hds
>     ok 2 hds.get_hds_thresh
>     ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by
>     the device
>     ok 4 hds.set_hds_enable
>     ok 5 hds.set_hds_thresh_random
>     ok 6 hds.set_hds_thresh_zero
>     ok 7 hds.set_hds_thresh_max
>     ok 8 hds.set_hds_thresh_gt
>     ok 9 hds.set_xdp
>     ok 10 hds.enabled_set_xdp
>     ok 11 hds.ioctl
>     ok 12 hds.ioctl_set_xdp
>     ok 13 hds.ioctl_enabled_set_xdp
>     # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:1 error:0
>
> Testing lo:
>     TAP version 13
>     1..13
>     ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
>     ok 2 hds.get_hds_thresh # SKIP hds-thresh not supported by device
>     ok 3 hds.set_hds_disable # SKIP ring-set not supported by the device
>     ok 4 hds.set_hds_enable # SKIP ring-set not supported by the device
>     ok 5 hds.set_hds_thresh_random # SKIP hds-thresh not supported by
>     device
>     ok 6 hds.set_hds_thresh_zero # SKIP ring-set not supported by the
>     device
>     ok 7 hds.set_hds_thresh_max # SKIP hds-thresh not supported by
>     device
>     ok 8 hds.set_hds_thresh_gt # SKIP hds-thresh not supported by device
>     ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
>     ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by
>     device
>     ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
>     ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by
>     device
>     ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported
>     by device
>     # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:13 error:0
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/hds.py | 28 +++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/s=
elftests/drivers/net/hds.py
> index 8b7f6acad15f..3ba8e4d69c4c 100755
> --- a/tools/testing/selftests/drivers/net/hds.py
> +++ b/tools/testing/selftests/drivers/net/hds.py
> @@ -6,7 +6,7 @@ import os
>  from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
>  from lib.py import CmdExitFailure, EthtoolFamily, NlError
>  from lib.py import NetDrvEnv
> -from lib.py import defer, ethtool, ip
> +from lib.py import defer, ethtool, ip, random
>
>
>  def _get_hds_mode(cfg, netnl) -> str:
> @@ -109,6 +109,31 @@ def set_hds_thresh_zero(cfg, netnl) -> None:
>
>      ksft_eq(0, rings['hds-thresh'])
>
> +def set_hds_thresh_random(cfg, netnl) -> None:
> +    try:
> +        rings =3D netnl.rings_get({'header': {'dev-index': cfg.ifindex}}=
)
> +    except NlError as e:
> +        raise KsftSkipEx('ring-get not supported by device')
> +    if 'hds-thresh' not in rings:
> +        raise KsftSkipEx('hds-thresh not supported by device')
> +    if 'hds-thresh-max' not in rings:
> +        raise KsftSkipEx('hds-thresh-max not defined by device')
> +
> +    while True:
> +        hds_thresh =3D random.randint(1, rings['hds-thresh-max'])

If a hds-thresh-max value is too small, it will not work.
As far as I know, the gve's hds-thresh-max would be 0.

I will send a v2 patch to fix this.

Thanks!
Taehee Yoo

> +        if hds_thresh !=3D rings['hds-thresh']:
> +            break
> +
> +    try:
> +        netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thre=
sh': hds_thresh})
> +    except NlError as e:
> +        if e.error =3D=3D errno.EINVAL:
> +            raise KsftSkipEx("hds-thresh-set not supported by the device=
")
> +        elif e.error =3D=3D errno.EOPNOTSUPP:
> +            raise KsftSkipEx("ring-set not supported by the device")
> +    rings =3D netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
> +    ksft_eq(hds_thresh, rings['hds-thresh'])
> +
>  def set_hds_thresh_max(cfg, netnl) -> None:
>      try:
>          rings =3D netnl.rings_get({'header': {'dev-index': cfg.ifindex}}=
)
> @@ -243,6 +268,7 @@ def main() -> None:
>                    get_hds_thresh,
>                    set_hds_disable,
>                    set_hds_enable,
> +                  set_hds_thresh_random,
>                    set_hds_thresh_zero,
>                    set_hds_thresh_max,
>                    set_hds_thresh_gt,
> --
> 2.34.1
>

