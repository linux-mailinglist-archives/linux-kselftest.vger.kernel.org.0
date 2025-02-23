Return-Path: <linux-kselftest+bounces-27294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7EA40EFF
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 13:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C718970B9
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Feb 2025 12:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990519C542;
	Sun, 23 Feb 2025 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7glxNqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C824C7D;
	Sun, 23 Feb 2025 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740313988; cv=none; b=bqfVHOOPamS3eszh61eD7gdlOzZDVV/F+NBycUFzCJ+9MMv/u4K9ULOT+YwVV/dRoYiGA9EbLfW6LihOc0zEVteY4SsWUS9ZVoFskMQ77UQSCLcMlCykqBF3yVFO4aeczPNlLHudBQg/H8a10cHA3mjBabiWb+U1qTql69nBzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740313988; c=relaxed/simple;
	bh=iWirZrAR6AkwlQyFL8cX4ThTjZaGhPR9+4baDrEbXHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szTfOua+gG7OPjR5m5/hZ+f0JeKalJCW4ZVKqyP9ayj42ursF6H2gtWbPzWSsQ9IypdPWu0olrRJJGK1Xnv8B10Ytssgc2lDJ/FFkghdkLD1Ux0iE6ugfqTB1BQGT9Ko0izlSEkSXIX3YYBWnPAYvCbG81HUZrMj+LULgsmHURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7glxNqn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abbdf897503so785965966b.0;
        Sun, 23 Feb 2025 04:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740313985; x=1740918785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSrP8BKo3Mr/oi0uI3kUQPgIbaqgwcIBSAzYGd1fJwI=;
        b=K7glxNqndetNz93KbVQShNYWf5B0Pzj328fLUeKeYK0caum7Dzo0zqS3PyfY4fpyIc
         bXJL3xoLIoEZ0LN4ex5TwZ1K92lE+hjOaWyarPZkObi1Db1v5TgP7jfOxEHm0xBwq0iC
         ineGqK8UE40K18GI67I1+iLW4QPuW+ud8GW4bxs7m4uGBnepDXHnyzyB04Nd+iYk9YzO
         xbAvjyfLhAnjGJ/AkZRdPbzudBwF7X77sQ4Cw000dFz9ytG1a5GY8pSUIc5WzRen7SiU
         OnFdaujasJT1V1GwEN3HXC3zi8gkP28vjSQJJ+bpe84w6Em6ax0ShS6sFhFIpYL7Oxjm
         a10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740313985; x=1740918785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSrP8BKo3Mr/oi0uI3kUQPgIbaqgwcIBSAzYGd1fJwI=;
        b=LiskmPjlOqebZAJxdxJTfiRrXX1O2D2qSrUaPO2U4fTH+JVCcQKITyVoq/Jugba1jz
         kuVuSIbGdgDpVlpbX/vXOzct9nWUlVquDk+FRejfM8D70E00ko1sApnQv40AbVHUJU8v
         Fg825BTNRJq+4KF1uWv5wr8eVifWdlJWHdRz03+Fo6RMhBqkuWHIQcBn2indRrS5RbeO
         NWTY3/T6bjMYVbFYcB3odlvDiJ5csfomfnqbVFDtq31iyIVTQGOXI/KXdscS6fZR8xFM
         42oniNzFnY6K7BkniWVusGXxPx5E0Ig3afUkqMOrEXxcI9swK3vT99UkfFDyvdMXdxaW
         M/hg==
X-Forwarded-Encrypted: i=1; AJvYcCU+oicfQXvOtFpjCtB7JT3TUKrAArhu0p7NfAL5ikUtZMBOrhu9+4pUocAHgza12U1oOAbvoA3T@vger.kernel.org, AJvYcCVuYFdkUFg1oPuGJogy3lj/JmZTS0H4HnKSUFug1d+IcC2wfxmEIJn/lFWtzERRwlzA0jD8jUhjUAhJNGg5IFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+GUtx60x9MyQEbk4P1KdpHNUy3yOaJjvPfLck+fgpY7RTMII
	dgqc4F5wyZ/KmiMFa6fE0WRvPBjnElABy5GRg2f6mhfucxp0YeQAcyVxO/zPCe91tGF5q1o0Lmc
	WC5HXb+H3IhHMjgbVH4+pKRhERXg=
X-Gm-Gg: ASbGncujyBbQ/wcHJtZFndjgXoVDdutrKFSnhL3JjG65lrTgL7JVNHiXQvwyufl3Bcc
	ofPPMa7qz/gqp6EhBo/SO0c2aY4UNem1sFJmzLhd8FK6V/gEtD8wUUO4RlkDCKCapMcv8wlFRRm
	2+vt6OqobL
X-Google-Smtp-Source: AGHT+IE2n0nMREu6a1w2HAjBSSxQarNRRTVs9hI6miyr6acqThSkNeUscDq/Qd35/9ysU/BHv2lRTXXxD4FQCobfS2o=
X-Received: by 2002:a17:907:6c13:b0:ab9:d282:d42e with SMTP id
 a640c23a62f3a-abbedeea657mr1286207266b.21.1740313984632; Sun, 23 Feb 2025
 04:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221025141.1132944-1-kuba@kernel.org> <20250221025141.1132944-2-kuba@kernel.org>
In-Reply-To: <20250221025141.1132944-2-kuba@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sun, 23 Feb 2025 21:32:53 +0900
X-Gm-Features: AWEUYZl4kFIA3pvfR4w4GSD_vAIKDBynQa7ZzDC1NiA3RIXNY6sCUSDF1eG-5OY
Message-ID: <CAMArcTVXb_0sw5K6fwcEiyQnZa6OHOTKD8_bizVMLSfvrnP5Xw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: test XDP, HDS auto and the
 ioctl path
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dxu@dxuuu.xyz, 
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com, willemb@google.com, 
	jstancek@redhat.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:53=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Test XDP and HDS interaction. While at it add a test for using the IOCTL,
> as that turned out to be the real culprit.
>
> Testing bnxt:
>
>   # NETIF=3Deth0 ./ksft-net-drv/drivers/net/hds.py
>   KTAP version 1
>   1..12
>   ok 1 hds.get_hds
>   ok 2 hds.get_hds_thresh
>   ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the d=
evice
>   ok 4 hds.set_hds_enable
>   ok 5 hds.set_hds_thresh_zero
>   ok 6 hds.set_hds_thresh_max
>   ok 7 hds.set_hds_thresh_gt
>   ok 8 hds.set_xdp
>   ok 9 hds.enabled_set_xdp
>   ok 10 hds.ioctl
>   ok 11 hds.ioctl_set_xdp
>   ok 12 hds.ioctl_enabled_set_xdp
>   # Totals: pass:11 fail:0 xfail:0 xpass:0 skip:1 error:0
>
> and netdevsim:
>
>   # ./ksft-net-drv/drivers/net/hds.py
>   KTAP version 1
>   1..12
>   ok 1 hds.get_hds
>   ok 2 hds.get_hds_thresh
>   ok 3 hds.set_hds_disable
>   ok 4 hds.set_hds_enable
>   ok 5 hds.set_hds_thresh_zero
>   ok 6 hds.set_hds_thresh_max
>   ok 7 hds.set_hds_thresh_gt
>   ok 8 hds.set_xdp
>   ok 9 hds.enabled_set_xdp
>   ok 10 hds.ioctl
>   ok 11 hds.ioctl_set_xdp
>   ok 12 hds.ioctl_enabled_set_xdp
>   # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Netdevsim needs a sane default for tx/rx ring size.
>
> ethtool 6.11 is needed for the --disable-netlink option.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Tested-by: Taehee Yoo <ap420073@gmail.com>

> Since this is targeting net there is no cfg.rpath(),
> I'll follow up once in net-next.
>
> v2:
>  - add the ioctl tests
>  - factor out some common logic
>
> CC: shuah@kernel.org
> CC: hawk@kernel.org
> CC: petrm@nvidia.com
> CC: willemb@google.com
> CC: jstancek@redhat.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/Makefile      |   3 +
>  drivers/net/netdevsim/ethtool.c               |   2 +
>  .../testing/selftests/net/lib/xdp_dummy.bpf.c |  13 ++
>  tools/testing/selftests/drivers/net/hds.py    | 145 +++++++++++++++++-
>  4 files changed, 160 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/xdp_dummy.bpf.c
>
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/sel=
ftests/net/lib/Makefile
> index bc6b6762baf3..c22623b9a2a5 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -9,7 +9,10 @@ TEST_FILES :=3D ../../../../../Documentation/netlink/spe=
cs
>  TEST_FILES +=3D ../../../../net/ynl
>
>  TEST_GEN_FILES +=3D csum
> +TEST_GEN_FILES +=3D $(patsubst %.c,%.o,$(wildcard *.bpf.c))
>
>  TEST_INCLUDES :=3D $(wildcard py/*.py sh/*.sh)
>
>  include ../../lib.mk
> +
> +include ../bpf.mk
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/etht=
ool.c
> index 5c80fbee7913..7ab358616e03 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -184,9 +184,11 @@ static const struct ethtool_ops nsim_ethtool_ops =3D=
 {
>
>  static void nsim_ethtool_ring_init(struct netdevsim *ns)
>  {
> +       ns->ethtool.ring.rx_pending =3D 512;
>         ns->ethtool.ring.rx_max_pending =3D 4096;
>         ns->ethtool.ring.rx_jumbo_max_pending =3D 4096;
>         ns->ethtool.ring.rx_mini_max_pending =3D 4096;
> +       ns->ethtool.ring.tx_pending =3D 512;
>         ns->ethtool.ring.tx_max_pending =3D 4096;
>  }
>
> diff --git a/tools/testing/selftests/net/lib/xdp_dummy.bpf.c b/tools/test=
ing/selftests/net/lib/xdp_dummy.bpf.c
> new file mode 100644
> index 000000000000..d988b2e0cee8
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/xdp_dummy.bpf.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define KBUILD_MODNAME "xdp_dummy"
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("xdp")
> +int xdp_dummy_prog(struct xdp_md *ctx)
> +{
> +       return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/s=
elftests/drivers/net/hds.py
> index 394971b25c0b..90807b21a6eb 100755
> --- a/tools/testing/selftests/drivers/net/hds.py
> +++ b/tools/testing/selftests/drivers/net/hds.py
> @@ -2,17 +2,54 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  import errno
> +import os
>  from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
> -from lib.py import EthtoolFamily, NlError
> +from lib.py import CmdExitFailure, EthtoolFamily, NlError
>  from lib.py import NetDrvEnv
> +from lib.py import defer, ethtool, ip
>
> -def get_hds(cfg, netnl) -> None:
> +
> +def _get_hds_mode(cfg, netnl) -> str:
>      try:
>          rings =3D netnl.rings_get({'header': {'dev-index': cfg.ifindex}}=
)
>      except NlError as e:
>          raise KsftSkipEx('ring-get not supported by device')
>      if 'tcp-data-split' not in rings:
>          raise KsftSkipEx('tcp-data-split not supported by device')
> +    return rings['tcp-data-split']
> +
> +
> +def _xdp_onoff(cfg):
> +    test_dir =3D os.path.dirname(os.path.realpath(__file__))
> +    prog =3D test_dir + "/../../net/lib/xdp_dummy.bpf.o"
> +    ip(f"link set dev %s xdp obj %s sec xdp" %
> +        (cfg.ifname, prog))
> +    ip(f"link set dev %s xdp off" % cfg.ifname)
> +
> +
> +def _ioctl_ringparam_modify(cfg, netnl) -> None:
> +    """
> +    Helper for performing a hopefully unimportant IOCTL SET.
> +    IOCTL does not support HDS, so it should not affect the HDS config.
> +    """
> +    try:
> +        rings =3D netnl.rings_get({'header': {'dev-index': cfg.ifindex}}=
)
> +    except NlError as e:
> +        raise KsftSkipEx('ring-get not supported by device')
> +
> +    if 'tx' not in rings:
> +        raise KsftSkipEx('setting Tx ring size not supported')
> +
> +    try:
> +        ethtool(f"--disable-netlink -G {cfg.ifname} tx {rings['tx'] // 2=
}")
> +    except CmdExitFailure as e:
> +        ethtool(f"--disable-netlink -G {cfg.ifname} tx {rings['tx'] * 2}=
")
> +    defer(ethtool, f"-G {cfg.ifname} tx {rings['tx']}")
> +
> +
> +def get_hds(cfg, netnl) -> None:
> +    _get_hds_mode(cfg, netnl)
> +
>
>  def get_hds_thresh(cfg, netnl) -> None:
>      try:
> @@ -104,6 +141,103 @@ from lib.py import NetDrvEnv
>          netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thre=
sh': hds_gt})
>      ksft_eq(e.exception.nl_msg.error, -errno.EINVAL)
>
> +
> +def set_xdp(cfg, netnl) -> None:
> +    """
> +    Enable single-buffer XDP on the device.
> +    When HDS is in "auto" / UNKNOWN mode, XDP installation should work.
> +    """
> +    mode =3D _get_hds_mode(cfg, netnl)
> +    if mode =3D=3D 'enabled':
> +        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                         'tcp-data-split': 'unknown'})
> +
> +    _xdp_onoff(cfg)
> +
> +
> +def enabled_set_xdp(cfg, netnl) -> None:
> +    """
> +    Enable single-buffer XDP on the device.
> +    When HDS is in "enabled" mode, XDP installation should not work.
> +    """
> +    _get_hds_mode(cfg, netnl)
> +    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                     'tcp-data-split': 'enabled'})
> +
> +    defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
> +                            'tcp-data-split': 'unknown'})
> +
> +    with ksft_raises(CmdExitFailure) as e:
> +        _xdp_onoff(cfg)
> +
> +
> +def set_xdp(cfg, netnl) -> None:
> +    """
> +    Enable single-buffer XDP on the device.
> +    When HDS is in "auto" / UNKNOWN mode, XDP installation should work.
> +    """
> +    mode =3D _get_hds_mode(cfg, netnl)
> +    if mode =3D=3D 'enabled':
> +        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                         'tcp-data-split': 'unknown'})
> +
> +    _xdp_onoff(cfg)
> +
> +
> +def enabled_set_xdp(cfg, netnl) -> None:
> +    """
> +    Enable single-buffer XDP on the device.
> +    When HDS is in "enabled" mode, XDP installation should not work.
> +    """
> +    _get_hds_mode(cfg, netnl)  # Trigger skip if not supported
> +
> +    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                     'tcp-data-split': 'enabled'})
> +    defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
> +                            'tcp-data-split': 'unknown'})
> +
> +    with ksft_raises(CmdExitFailure) as e:
> +        _xdp_onoff(cfg)
> +
> +
> +def ioctl(cfg, netnl) -> None:
> +    mode1 =3D _get_hds_mode(cfg, netnl)
> +    _ioctl_ringparam_modify(cfg, netnl)
> +    mode2 =3D _get_hds_mode(cfg, netnl)
> +
> +    ksft_eq(mode1, mode2)
> +
> +
> +def ioctl_set_xdp(cfg, netnl) -> None:
> +    """
> +    Like set_xdp(), but we perturb the settings via the legacy ioctl.
> +    """
> +    mode =3D _get_hds_mode(cfg, netnl)
> +    if mode =3D=3D 'enabled':
> +        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                         'tcp-data-split': 'unknown'})
> +
> +    _ioctl_ringparam_modify(cfg, netnl)
> +
> +    _xdp_onoff(cfg)
> +
> +
> +def ioctl_enabled_set_xdp(cfg, netnl) -> None:
> +    """
> +    Enable single-buffer XDP on the device.
> +    When HDS is in "enabled" mode, XDP installation should not work.
> +    """
> +    _get_hds_mode(cfg, netnl)  # Trigger skip if not supported
> +
> +    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
> +                     'tcp-data-split': 'enabled'})
> +    defer(netnl.rings_set, {'header': {'dev-index': cfg.ifindex},
> +                            'tcp-data-split': 'unknown'})
> +
> +    with ksft_raises(CmdExitFailure) as e:
> +        _xdp_onoff(cfg)
> +
> +
>  def main() -> None:
>      with NetDrvEnv(__file__, queue_count=3D3) as cfg:
>          ksft_run([get_hds,
> @@ -112,7 +246,12 @@ from lib.py import NetDrvEnv
>                    set_hds_enable,
>                    set_hds_thresh_zero,
>                    set_hds_thresh_max,
> -                  set_hds_thresh_gt],
> +                  set_hds_thresh_gt,
> +                  set_xdp,
> +                  enabled_set_xdp,
> +                  ioctl,
> +                  ioctl_set_xdp,
> +                  ioctl_enabled_set_xdp],
>                   args=3D(cfg, EthtoolFamily()))
>      ksft_exit()
>
> --
> 2.48.1
>
>

