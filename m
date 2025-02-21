Return-Path: <linux-kselftest+bounces-27181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451EBA3FA8C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1DD442E45
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18E1E7C1E;
	Fri, 21 Feb 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2reqoYI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8511DF73A;
	Fri, 21 Feb 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154028; cv=none; b=uZSXdZauLSOjJ5SvGSfuhBxfzmD3mu5mwKXKLYZQifPIHLQpVcCGRDoGuVoVzrZ9qGcrwPTdnzLksoJtmZct4bruBbSbkxUF5PitUfu2wpN2gHk5eVRU191SM6KgG0QaskFBy4cmeqlGRACg0iNmW647Q1/gZAnVWqxrV8aREQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154028; c=relaxed/simple;
	bh=R9CX2qGFOMKtOpbBq89u8Ru20KtYEUQdBPmdT7JZ0kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NElYi510QuJI9Mb8uwFFG439512bg13PFZ4rRSdzE4VgIj7F3aAh7tmmJzC1SgxjqW2NWwsjeJniYpvjsnpie5KIsoTsDPh77Gs1XDOwe8jbkJyju52ARvaG9lfCwSFCCsHn22hLFMzGdxs2gOCbYcsFRF3wgQoAHpQ+FqSMxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2reqoYI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d601886fso35458495ad.1;
        Fri, 21 Feb 2025 08:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740154024; x=1740758824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXMa2xyXvo743Y0woStBvwk3tmVqDmNqL4DB+2dBsrk=;
        b=X2reqoYIqIVBb6n7llu45SeONXH9raVFq7xOYesqM7uSsNOc1MCrb92iMkj8PGnEi8
         9CP4EBLmty0F15Zu4PTBE+fLxa9rcHGl2Oto2eImXoixBrF2YxoIbdi/TY1jQQvsX7F5
         vMSXTzFZzjGVMdXc0BXTk2gXm26wQvVhVqeByWwAcecOOJSnQmwInP7iMtgs8fTmpjLp
         xaWWUvSlfrgbhYGw6+t9yu7K5N+xDfaJAp0Jq147cORwCcvGSKL1bMvG9sZA22dhUhG+
         YH3Yj3s1HWuRijTozlK60rCNWVLnTbNQYClE/slGQUhfFAShTX4eKiNOunoytFxhI7zA
         jvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154024; x=1740758824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXMa2xyXvo743Y0woStBvwk3tmVqDmNqL4DB+2dBsrk=;
        b=rkOcLM+UFzfcIXZUXqbxH5EaN6KRgJo3KIOg5Fx4fCSLjYI8SEuaThHJ3T89gw55Or
         Wp193YcN9jLhhEX1BThM9xKfjTqUzS6QFVDj0ujLaI+b9PtYRm3H9dhkGJhFDrsc6uRG
         OgZzMCWAfw1LDMxkbwFSE6rnmmBJGAbDoJUpZqoPCH6gBk+rqLeOCEpr8THW36khJ7+j
         huaHk0FJQj4vbswUq/wk9vdaVK5CFhqw4lxkik0nStHOsXcwzzz6Yup1Vt6xBC2TKCNg
         5zDTlnl4LfGHiZXMVVnz6mycoCxtm2GTP3QIkSKhUdoihdKl/wgRAYbomC/7xQO8Txj0
         MtBg==
X-Forwarded-Encrypted: i=1; AJvYcCU7yGN3oSLfWwQQZfJdQcEmjnnJpkdTrOD2Eels8c+eQKtiTsqe/MjH8HwqB/mfNsrUhUuxRomuSLDDEFI6/yI=@vger.kernel.org, AJvYcCUG0gB4JtrQfXQbWGzkLApG2o3xeN5KX6uSorsCQloQn/SjIZOI428cdeYdehwbBC6OTQ9U6Pon@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYcn0K/PdqHqA7R5E8pGBr8qWW5MXBrcDE8l+wTGzbYng+92b
	BDMSTbEkMTFGu8ug2BQwMIqe/FK4HXjvlnvDR2vVB9LECkyEmi0=
X-Gm-Gg: ASbGnctShnaYP8ORvmCVqyArmHrw6aAco2qImbWc962VSqsO8bEPMJz37h83aHNgdHG
	64N0WoQFyMTp2q2ptl94YweI4L/dohZH50lREra992lOyG79913KlTQjXjCocL3dS8K+0zomC8g
	9abOU90fIH9SdwTiWbFn+rHtrACEoY6kHEQFnqcP7LENTuz2jC59Lw7dYwP525QIZo49zs+qdyA
	h5mbvLisoqD0G1XFKOW3pgzCqJXKSltWJKfEm0uC0tiPuEzbGphqUtTxu+VoD9l2GjPMntOEEk9
	ZPiJmJOEVloCU1WvBKVBOCCwCw==
X-Google-Smtp-Source: AGHT+IHml8fjUCSIE2ZuwvEzvgY1J8JC+QeEzEUMGL3CllgCnM7QU6VIWvUwwN17Oh6lW2+w27AZYQ==
X-Received: by 2002:a05:6a21:688:b0:1ee:ced0:f0a4 with SMTP id adf61e73a8af0-1eef3d6b2ffmr8315655637.34.1740154023777;
        Fri, 21 Feb 2025 08:07:03 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ae6d9079f20sm3310928a12.48.2025.02.21.08.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:07:03 -0800 (PST)
Date: Fri, 21 Feb 2025 08:07:02 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	dxu@dxuuu.xyz, shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemb@google.com, jstancek@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: test XDP, HDS auto and
 the ioctl path
Message-ID: <Z7ikpmXut900JqA1@mini-arch>
References: <20250221025141.1132944-1-kuba@kernel.org>
 <20250221025141.1132944-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221025141.1132944-2-kuba@kernel.org>

On 02/20, Jakub Kicinski wrote:
> Test XDP and HDS interaction. While at it add a test for using the IOCTL,
> as that turned out to be the real culprit.
> 
> Testing bnxt:
> 
>   # NETIF=eth0 ./ksft-net-drv/drivers/net/hds.py
>   KTAP version 1
>   1..12
>   ok 1 hds.get_hds
>   ok 2 hds.get_hds_thresh
>   ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the device
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

> ---
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
> diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> index bc6b6762baf3..c22623b9a2a5 100644
> --- a/tools/testing/selftests/net/lib/Makefile
> +++ b/tools/testing/selftests/net/lib/Makefile
> @@ -9,7 +9,10 @@ TEST_FILES := ../../../../../Documentation/netlink/specs
>  TEST_FILES += ../../../../net/ynl
>  
>  TEST_GEN_FILES += csum
> +TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
>  
>  TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
>  
>  include ../../lib.mk
> +
> +include ../bpf.mk
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index 5c80fbee7913..7ab358616e03 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -184,9 +184,11 @@ static const struct ethtool_ops nsim_ethtool_ops = {
>  
>  static void nsim_ethtool_ring_init(struct netdevsim *ns)
>  {
> +	ns->ethtool.ring.rx_pending = 512;
>  	ns->ethtool.ring.rx_max_pending = 4096;
>  	ns->ethtool.ring.rx_jumbo_max_pending = 4096;
>  	ns->ethtool.ring.rx_mini_max_pending = 4096;
> +	ns->ethtool.ring.tx_pending = 512;
>  	ns->ethtool.ring.tx_max_pending = 4096;
>  }
>  
> diff --git a/tools/testing/selftests/net/lib/xdp_dummy.bpf.c b/tools/testing/selftests/net/lib/xdp_dummy.bpf.c
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
> +	return XDP_PASS;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
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
>          rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
>      except NlError as e:
>          raise KsftSkipEx('ring-get not supported by device')
>      if 'tcp-data-split' not in rings:
>          raise KsftSkipEx('tcp-data-split not supported by device')
> +    return rings['tcp-data-split']
> +
> +
> +def _xdp_onoff(cfg):
> +    test_dir = os.path.dirname(os.path.realpath(__file__))
> +    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
> +    ip(f"link set dev %s xdp obj %s sec xdp" %
> +        (cfg.ifname, prog))
> +    ip(f"link set dev %s xdp off" % cfg.ifname)

nit: any reason you're not using {format} strings here?

    ip(f"link set dev {cfg.ifname} xdp obj {prog} sec xdp")
    ip(f"link set dev {cfg.ifname} xdp off")

