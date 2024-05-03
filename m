Return-Path: <linux-kselftest+bounces-9437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288F88BB676
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 23:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE911C23EEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACA3347A2;
	Fri,  3 May 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjdoBBMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE117C66;
	Fri,  3 May 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773273; cv=none; b=nbE88Fbh3gqgJQ0116Cm00lqjeNG3DKuYUTyfS8WXH1UxUKkwjc5iDTE9oUzTpJ5RUJYQOf8GPEjPkN4h62bpkh0zw0N3GUYuvI55NrF7+Q6rdhjIt2kjBbL0kg+sEKiHCqb3UItyvcR8cHVfUfokxGZsyb7QnsMZPRuOUzwHsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773273; c=relaxed/simple;
	bh=JkIY4DPw1A1Bp9xSVKa/b5H46V+5ijQYhRsfck55Xl4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W0LNbLdTe8BjqcBGZlo7b2ja6Nvq+iJM/t2m6EwhRdz3XO55yoXri4Vc9KjgdyVLZlBaRtHrZrOnsntTedrpdcBbIRUldl+WFV0atBXuVGnKS4hUKC+NinkomMj5EWnYEbKI6ee6x8i5ALLBkhXyEDt4wGwBCigc1LE/ARD0PA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjdoBBMl; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43a317135a5so1152191cf.0;
        Fri, 03 May 2024 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714773269; x=1715378069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1DBSoI6f4nIZbJerJnUI6kYv5fUTFNA9ddAbWv4IP4=;
        b=IjdoBBMlPJ7dbbjKDzHZEX7F/egggHhG2EYx2q94wc4uH7HTGrgcB71p9Q5GHvvd1x
         kI9IrjxzifxuytrGaRWtC4WKzqUiVMDNAJvvrvzVaza5JuWYyCjx2jjPpSES54Jz89CG
         11rwm8FaN/sJRfisps4WfiGTvw/8C+NOfYJXlqO/6CjbHHpfX8gbbtydCJbR5zN3b67R
         TvLFskg6NEEHkHUierRgKd6QM3Gho2Qe68FqXszxCog/m0mUZFZDl+QQun4F6zgnjjG7
         s/wG6+W0X37GdQwxs7ELVfRv0EAK6A19WIAOxvOy0GJ5N/lZiNgs9HHHbMdbBsN960Hk
         tTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714773269; x=1715378069;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k1DBSoI6f4nIZbJerJnUI6kYv5fUTFNA9ddAbWv4IP4=;
        b=qZvokbXx70nAmsr+sjSZmRRguttGUSWs8nT0Lz1V5gb8FYgawsN2Dcx2ciG6hdwEL+
         Kt2XBWN9wq8bT+2Al9/90lLlmAGrJ8CaR/dUOGv8KYg0dLNpu+KY24QbfxcWwFYyOPtv
         6a7rlCN0EBHh0XZ332tQZ/OBK6zdkE8tQh0uedTKD3xGctWi+kp/ayE9SnwudMUsWA4Q
         yjVKny4V6gRFjjSiiPkQqnh+nHK2+5gdAwLdBljxB/PIRsh2gpURRNo8BemfElnXPL9M
         fChpBTnBwOPzaoLBxW5D3A6ORcNj/q8sNS9npvrioPpohWgXqP7Y7dN5LeWXnKREnZ+e
         ul8g==
X-Forwarded-Encrypted: i=1; AJvYcCWUFlnlV2hsw0ajKaCzBfj9hz4UA7f50/9N2ZvpP1xpBHO/acIqS9czZhvUzjAbvldJK0huPewaHQFN/Wd9jsCVb6u6N/DLI7jXQpilSYgg8BB6nxm1AhbidBYIMxBHuh/Hen7Uu2OH
X-Gm-Message-State: AOJu0YxbIsrxV9YG9inTcI5NfO+X9LVDsCl2XF6qbS2ImL1ysCMau2iL
	B6o/rcx+F9cSGMk9EwRfEBxDat25tR5IpNuviCs3hEyPTeaKQ6Nj
X-Google-Smtp-Source: AGHT+IE/MyCp/XmAQkqWfYxWKT9eIliqXg4tcTSAWsD8cYhHQA36E3FYTMKfH/oGzOTjZ7AGYaNDew==
X-Received: by 2002:a05:622a:5b8f:b0:43a:df01:167d with SMTP id ec15-20020a05622a5b8f00b0043adf01167dmr13354447qtb.4.1714773269588;
        Fri, 03 May 2024 14:54:29 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id er5-20020a05622a5e8500b0043cd93be06asm1278908qtb.62.2024.05.03.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 14:54:29 -0700 (PDT)
Date: Fri, 03 May 2024 17:54:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66355d15d44d_3de36e29464@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240503202511.4044515-1-willemdebruijn.kernel@gmail.com>
References: <20240503202511.4044515-1-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2] selftests: drv-net: add checksum tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Run tools/testing/selftest/net/csum.c as part of drv-net.
> This binary covers multiple scenarios, based on arguments given,
> for both IPv4 and IPv6:
> 
> - Accept UDP correct checksum
> - Detect UDP invalid checksum
> - Accept TCP correct checksum
> - Detect TCP invalid checksum
> 
> - Transmit UDP: basic checksum offload
> - Transmit UDP: zero checksum conversion
> 
> The test direction is reversed between receive and transmit tests, so
> that the NIC under test is always the local machine.
> 
> In total this adds up to 12 testcases, with more to follow. For
> conciseness, I replaced individual functions with a function factory.
> 
> Also detect hardware offload feature availability using Ethtool
> netlink and skip tests when either feature is off. This need may be
> common for offload feature tests and eventually deserving of a thin
> wrapper in lib.py.
> 
> Missing are the PF_PACKET based send tests ('-P'). These use
> virtio_net_hdr to program hardware checksum offload. Which requires
> looking up the local MAC address and (harder) the MAC of the next hop.
> I'll have to give it some though how to do that robustly and where
> that code would belong.
> 
> Tested:
> 
>         make -C tools/testing/selftests/ \
>                 TARGETS="drivers/net drivers/net/hw" \
>                 install INSTALL_PATH=/tmp/ksft
>         cd /tmp/ksft
> 
> 	sudo NETIF=ens4 REMOTE_TYPE=ssh \
> 		REMOTE_ARGS="root@10.40.0.2" \
> 		LOCAL_V4="10.40.0.1"

Missing backslash

> 		REMOTE_V4="10.40.0.2" \
> 		./run_kselftest.sh -t drivers/net/hw:csum.py
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> Changes
>   - v1->v2
>       - remove dependency on tools/testing/selftests/net: move csum
>       - remove test output from git commit message:
>         has noisy (expected) failures on test platform after bkg changes
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../testing/selftests/drivers/net/hw/csum.py  | 114 ++++++++++++++++++
>  tools/testing/selftests/net/.gitignore        |   1 -
>  tools/testing/selftests/net/Makefile          |   1 -
>  tools/testing/selftests/net/lib/.gitignore    |   2 +
>  tools/testing/selftests/net/lib/Makefile      |   7 ++
>  tools/testing/selftests/net/{ => lib}/csum.c  |   0
>  7 files changed, 124 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/csum.py
>  create mode 100644 tools/testing/selftests/net/lib/.gitignore
>  rename tools/testing/selftests/net/{ => lib}/csum.c (100%)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 1dd732855d76..4933d045ab66 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0+ OR MIT
>  
>  TEST_PROGS = \
> +	csum.py \
>  	devlink_port_split.py \
>  	ethtool.sh \
>  	ethtool_extended_state.sh \
> diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
> new file mode 100755
> index 000000000000..7e3a955fc426
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/csum.py
> @@ -0,0 +1,114 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Run the tools/testing/selftests/net/csum testsuite."""
> +
> +from os import path
> +
> +from lib.py import ksft_run, ksft_exit, KsftSkipEx
> +from lib.py import EthtoolFamily, NetDrvEpEnv
> +from lib.py import bkg, cmd, wait_port_listen
> +
> +def test_receive(cfg, ipv4=False, extra_args=None):
> +    """Test local nic checksum receive. Remote host sends crafted packets."""
> +    if not cfg.have_rx_csum:
> +        raise KsftSkipEx(f"Test requires rx checksum offload on {cfg.ifname}")
> +
> +    if ipv4:
> +        ip_args = f"-4 -S {cfg.remote_v4} -D {cfg.v4}"
> +    else:
> +        ip_args = f"-6 -S {cfg.remote_v6} -D {cfg.v6}"
> +
> +    rx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -n 100 {ip_args} -r 1 -R {extra_args}"
> +    tx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
> +
> +    with bkg(rx_cmd, exit_wait=True):
> +        wait_port_listen(34000, proto='udp')
> +        cmd(tx_cmd, host=cfg.remote)
> +
> +
> +def test_transmit(cfg, ipv4=False, extra_args=None):
> +    """Test local nic checksum transmit. Remote host verifies packets."""
> +    if not cfg.have_tx_csum:
> +        raise KsftSkipEx(f"Test requires tx checksum offload on {cfg.ifname}")
> +
> +    if ipv4:
> +        ip_args = f"-4 -S {cfg.v4} -D {cfg.remote_v4}"
> +    else:
> +        ip_args = f"-6 -S {cfg.v6} -D {cfg.remote_v6}"
> +
> +    # Cannot randomize input when calculating zero checksum
> +    if extra_args != "-U -Z":
> +        extra_args += " -r 1"
> +
> +    rx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
> +    tx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -L 1 -n 100 {ip_args} -T {extra_args}"
> +
> +    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
> +        wait_port_listen(34000, proto='udp', host=cfg.remote)
> +        cmd(tx_cmd)
> +
> +
> +def test_builder(name, cfg, ipv4=False, tx=False, extra_args=""):
> +    """Construct specific tests from the common template.
> +
> +       Most tests follow the same basic pattern, differing only in
> +       Direction of the test and optional flags passed to csum."""
> +    def f(cfg):
> +        if ipv4:
> +            cfg.require_v4()
> +        else:
> +            cfg.require_v6()
> +
> +        if tx:
> +            test_transmit(cfg, ipv4, extra_args)
> +        else:
> +            test_receive(cfg, ipv4, extra_args)
> +
> +    if ipv4:
> +        f.__name__ = "ipv4_" + name
> +    else:
> +        f.__name__ = "ipv6_" + name
> +    return f
> +
> +
> +def check_nic_features(cfg) -> None:
> +    """Test whether Tx and Rx checksum offload are enabled.
> +
> +       If the device under test has either off, then skip the relevant tests."""
> +    cfg.have_tx_csum = False
> +    cfg.have_rx_csum = False
> +
> +    ethnl = EthtoolFamily()
> +    features = ethnl.features_get({"header": {"dev-index": cfg.ifindex}})
> +    for f in features["active"]["bits"]["bit"]:
> +        if f["name"] == "tx-checksum-ip-generic":
> +            cfg.have_tx_csum = True

Also need to test for "tx-checksum-ipv4" and "tx-checksum-ipv6".

Will respin.

> +        elif f["name"] == "rx-checksum":
> +            cfg.have_rx_csum = True

