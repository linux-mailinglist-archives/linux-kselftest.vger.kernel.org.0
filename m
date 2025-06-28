Return-Path: <linux-kselftest+bounces-36056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86DAEC803
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 16:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76F03AE2D3
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA024DCF3;
	Sat, 28 Jun 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/eNoT2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B622FDFA;
	Sat, 28 Jun 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122644; cv=none; b=cFeIrfIIlhoo6SyV8a2uQ6yrhi7cvusjwK4kT7cr7Zi/5VJ8jCq2RELQIs/pjyrPGaKWo281WoNCzuB+FTKIpjZNQmD+6ehYps33/h7e+mRrh6TpNjYfDykLqK1VS93ZQWO+ZLkl0oVwSMiZnipCSpN4q04Qa1YFXHCXHXu1x4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122644; c=relaxed/simple;
	bh=SwzbnejU3tqgV3LGzggIBwHqOVjO86XhlPtGXKvpeGo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=u5ZSXY/yNZ9GN0OogyMZFLPk2TV9SKvfn2pr+cV2HrCOMvdELpRH1qQ+cK7BqfpnJgb/wtTLqiDRFNoU/u0FwqfC1y5UcTZptvjGqi48rdTFoluVjwE6CUsBTiiV6iwPw/r7oHa03ER39t/a5dwWK3f338eZkZReejjEffGhxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/eNoT2T; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70e3e0415a7so30539097b3.0;
        Sat, 28 Jun 2025 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751122641; x=1751727441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVI6KE3CiLAJW0/dC26n8dgxJZIKjo1EZecPaQ7D6U4=;
        b=k/eNoT2Tdi6nRwYR72t6CCjQSvbI1tMbIHgiw5pYcNX/S3IKTBt+Rxsa69n/tapTnf
         HwpG3vVUsK14/C+GB8s/4/p1q8jMrBeFu0a8Y36mIRpM6z1ngZHDrWjjFykXM10sVFUR
         2JT10MSEB4S2hia2F741U4DGQYbw6klN9KN7KZ7KcL1KxarTRclgZyr1n/CoDwk5///i
         1/ghYWndO6Ldxw8yBqTFhkkf5Ff3BXYQmNt1Z8fKtRM91NcEsG+joI44JTtbcYwDjctj
         9+SLe/o+2DncskpQb0wIxqlOeoMOw5VDbX8gw50UylQKtZnRIMHU4HJvNnfnbK3OJQSW
         1nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751122641; x=1751727441;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qVI6KE3CiLAJW0/dC26n8dgxJZIKjo1EZecPaQ7D6U4=;
        b=xOrVU0M1ByxqE9N/GuyKElZKM0NgX/4Qe70fHcu8dLXr81nGV3eXYDvcvkM5jrvx/H
         NfLxNppJaGnEG7NTM2ouX/ieofx3ruBH/390JblpfMwExc3ONwRw7yr91cpMWoDgIIgl
         IprTHiTBM1kd8ODg4lOHbxN4sb12DLEyTH8NpXbkgTOTZSXY92CeSq0S3YQv8NBPe/dS
         RGLvCi/Ojd9YglllFIGMwTDggHfHByG0wuUjCo/7rNbtnybxyfyUuTYci7QmzoHthFXN
         20MMAWBPkGfKmPVL7JCDKTntZjOkOxK8WMf1SOxNPhn0rbLCxV5uRQYRFipvwKUtq4gQ
         Ze1w==
X-Forwarded-Encrypted: i=1; AJvYcCUAz2GPdqDU5Spt/3Rpk+SI8s7ZgddTJxijIyEiE8gYLCbkV6cb9jjm/5kf6smFAYdYbO6G2mP/@vger.kernel.org, AJvYcCUU71SxKmW2EiIm0dEutj2J/dfyKLxZRKnGY2DQpipbOHdiGPSUVEDbcAeojrEufkCMI+S+xCTKmeLai2hs2Ew/@vger.kernel.org, AJvYcCXcAOpuWmHufAIL/wbZM+uvOmAoWxONc/ga0EODbG0jWZ6qwErzyE20YLGzBjQp6GP8xDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTSs0tk9FJzDUueYVNdBAc1lhg16/QSSHcVYid3irLUQ+44jm
	yEdhzZkZNwDtiTVmkx7eXy4QjGtcbsXVT4c/mtu8jxzTdMtiYbm2pm4v
X-Gm-Gg: ASbGncuh+wlrEiMqa64oZAfsGbvSLYO4L4rYe4//in33EjOgPT/jyKZjV76cji0toqu
	bioHS1Irhp2I+PZ3+bf7afb5ZrjZF2dQOGHWevEAvYw2d5x+0pZ2Mr+tmYSV0Vj/YEJbl04vkxT
	paLSf0694SUyO4OtGvwB0k7478ceU/uSURqPgkS/hr9uYNAUGipk1t5GcbizOhGc5Cw2cwbKKK2
	THE+EhxqtmPjukf/4bdfH/rBe+TVEctcgPlkfIaLkgDjyK2lJdZVloj1dwkEFDU91OW/8BW+U6L
	xsUfGalheCKyCN3dYXfgOrA8ogcJ6ZExBuaZ41Gl3nfeXnpbt1bQRFc+r6q+Gx0Ff+w4fZf1lKt
	Z2WSwjoD0yUkYD9t/WSSDCsLvAs7rkadIiSkgNlvYeogXmP7Q5g==
X-Google-Smtp-Source: AGHT+IFgeirmaDnGq3vMwkXaLQ96M5Zym1hkCAISen7XUJghStxKv/n9fFuaoyHf8V53rEQ+BU65hg==
X-Received: by 2002:a05:690c:6089:b0:712:c55c:4e54 with SMTP id 00721157ae682-715175584e0mr95734117b3.4.1751122641016;
        Sat, 28 Jun 2025 07:57:21 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c915c7sm8416127b3.71.2025.06.28.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 07:57:20 -0700 (PDT)
Date: Sat, 28 Jun 2025 10:57:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <686002d028f_a131d29458@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
 <20250627-netpoll_test-v3-3-575bd200c8a9@debian.org>
Subject: Re: [PATCH net-next v3 3/3] selftests: net: add netpoll basic
 functionality test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Add a basic selftest for the netpoll polling mechanism, specifically
> targeting the netpoll poll() side.
> 
> The test creates a scenario where network transmission is running at
> maximum speed, and netpoll needs to poll the NIC. This is achieved by:
> 
>   1. Configuring a single RX/TX queue to create contention
>   2. Generating background traffic to saturate the interface
>   3. Sending netconsole messages to trigger netpoll polling
>   4. Using dynamic netconsole targets via configfs
>   5. Delete and create new netconsole targets after some messages
>   6. Start a bpftrace in parallel to make sure netpoll_poll_dev() is
>      called
>   7. If bpftrace exists and netpoll_poll_dev() was called, stop.
> 
> The test validates a critical netpoll code path by monitoring traffic
> flow and ensuring netpoll_poll_dev() is called when the normal TX path
> is blocked.
> 
> This addresses a gap in netpoll test coverage for a path that is
> tricky for the network stack.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  tools/testing/selftests/drivers/net/Makefile       |   1 +
>  .../testing/selftests/drivers/net/netpoll_basic.py | 345 +++++++++++++++++++++
>  2 files changed, 346 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index bd309b2d39095..9bd84d6b542e5 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -16,6 +16,7 @@ TEST_PROGS := \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
>  	netcons_sysdata.sh \
> +	netpoll_basic.py \
>  	ping.py \
>  	queues.py \
>  	stats.py \
> diff --git a/tools/testing/selftests/drivers/net/netpoll_basic.py b/tools/testing/selftests/drivers/net/netpoll_basic.py
> new file mode 100755
> index 0000000000000..f523d5a1c707e
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
> @@ -0,0 +1,345 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +# Author: Breno Leitao <leitao@debian.org>
> +"""
> + This test aims to evaluate the netpoll polling mechanism (as in
> + netpoll_poll_dev()). It presents a complex scenario where the network
> + attempts to send a packet but fails, prompting it to poll the NIC from within
> + the netpoll TX side.
> +
> + This has been a crucial path in netpoll that was previously untested. Jakub
> + suggested using a single RX/TX queue, pushing traffic to the NIC, and then
> + sending netpoll messages (via netconsole) to trigger the poll.
> +
> + In parallel, bpftrace is used to detect if netpoll_poll_dev() was called. If
> + so, the test passes, otherwise it will be skipped. This test is very dependent on
> + the driver and environment, given we are trying to trigger a tricky scenario.
> +"""
> +
> +import errno
> +import logging
> +import os
> +import random
> +import string
> +import threading
> +import time
> +
> +from lib.py import (
> +    bpftrace,
> +    ethtool,
> +    GenerateTraffic,
> +    ksft_exit,
> +    ksft_pr,
> +    ksft_run,
> +    KsftFailEx,
> +    KsftSkipEx,
> +    NetDrvEpEnv,
> +)
> +
> +# Configure logging
> +logging.basicConfig(
> +    level=logging.INFO,
> +    format="%(asctime)s - %(levelname)s - %(message)s",
> +)
> +
> +NETCONSOLE_CONFIGFS_PATH: str = "/sys/kernel/config/netconsole"
> +NETCONS_REMOTE_PORT: int = 6666
> +NETCONS_LOCAL_PORT: int = 1514
> +# Max number of netcons messages to send. Each iteration will setup
> +# netconsole and send 10 messages
> +ITERATIONS: int = 20
> +# MAPS contains the information coming from bpftrace
> +# it will have only one key: @hits, which tells the number of times
> +# netpoll_poll_dev() was called

nit: no longer has ampersand prefix

> +MAPS: dict[str, int] = {}
> +# Thread to run bpftrace in parallel
> +BPF_THREAD: threading.Thread = None
> +# Time bpftrace will be running in parallel.
> +BPFTRACE_TIMEOUT: int = 15
> +
> +
> +def ethtool_read_rx_tx_queue(interface_name: str) -> tuple[int, int]:
> +    """
> +    Read the number of RX and TX queues using ethtool. This will be used
> +    to restore it after the test
> +    """
> +    rx_queue = 0
> +    tx_queue = 0
> +
> +    try:
> +        ethtool_result = ethtool(f"-g {interface_name}").stdout
> +        for line in ethtool_result.splitlines():
> +            if line.startswith("RX:"):
> +                rx_queue = int(line.split()[1])
> +            if line.startswith("TX:"):
> +                tx_queue = int(line.split()[1])

Does this work on devices that use combined?

> +    except IndexError as exception:
> +        raise KsftSkipEx(
> +            f"Failed to read RX/TX queues numbers: {exception}. Not going to mess with them."
> +        ) from exception
> +
> +    if not rx_queue or not tx_queue:
> +        raise KsftSkipEx(
> +            "Failed to read RX/TX queues numbers. Not going to mess with them."
> +        )
> +    return rx_queue, tx_queue
> +
> +
> +def ethtool_set_rx_tx_queue(interface_name: str, rx_val: int, tx_val: int) -> None:
> +    """Set the number of RX and TX queues to 1 using ethtool"""
> +    try:
> +        # This don't need to be reverted, since interfaces will be deleted after test
> +        ethtool(f"-G {interface_name} rx {rx_val} tx {tx_val}")
> +    except Exception as exception:
> +        raise KsftSkipEx(
> +            f"Failed to configure RX/TX queues: {exception}. Ethtool not available?"
> +        ) from exception
> +
> +
> +def netcons_generate_random_target_name() -> str:
> +    """Generate a random target name starting with 'netcons'"""
> +    random_suffix = "".join(random.choices(string.ascii_lowercase + string.digits, k=8))
> +    return f"netcons_{random_suffix}"
> +
> +
> +def netcons_create_target(
> +    config_data: dict[str, str],
> +    target_name: str,
> +) -> None:
> +    """Create a netconsole dynamic target against the interfaces"""
> +    logging.debug("Using netconsole name: %s", target_name)
> +    try:
> +        os.makedirs(f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}", exist_ok=True)
> +        logging.debug(
> +            "Created target directory: %s/%s", NETCONSOLE_CONFIGFS_PATH, target_name
> +        )
> +    except OSError as exception:
> +        if exception.errno != errno.EEXIST:
> +            raise KsftFailEx(
> +                f"Failed to create netconsole target directory: {exception}"
> +            ) from exception
> +
> +    try:
> +        for key, value in config_data.items():
> +            path = f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{key}"
> +            logging.debug("Writing %s to %s", key, path)
> +            with open(path, "w", encoding="utf-8") as file:
> +                # Always convert to string to write to file
> +                file.write(str(value))
> +                file.close()
> +
> +        # Read all configuration values for debugging purposes
> +        for debug_key in config_data.keys():
> +            with open(
> +                f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{debug_key}",
> +                "r",
> +                encoding="utf-8",
> +            ) as file:
> +                content = file.read()
> +                logging.debug(
> +                    "%s/%s/%s : %s",
> +                    NETCONSOLE_CONFIGFS_PATH,
> +                    target_name,
> +                    debug_key,
> +                    content,
> +                )
> +
> +    except Exception as exception:
> +        raise KsftFailEx(
> +            f"Failed to configure netconsole target: {exception}"
> +        ) from exception
> +
> +
> +def netcons_configure_target(
> +    cfg: NetDrvEpEnv, interface_name: str, target_name: str
> +) -> None:
> +    """Configure netconsole on the interface with the given target name"""
> +    config_data = {
> +        "extended": "1",
> +        "dev_name": interface_name,
> +        "local_port": NETCONS_LOCAL_PORT,
> +        "remote_port": NETCONS_REMOTE_PORT,
> +        "local_ip": cfg.addr_v["4"] if cfg.addr_ipver == "4" else cfg.addr_v["6"],
> +        "remote_ip": (
> +            cfg.remote_addr_v["4"] if cfg.addr_ipver == "4" else cfg.remote_addr_v["6"]
> +        ),
> +        "remote_mac": "00:00:00:00:00:00",  # Not important for this test
> +        "enabled": "1",
> +    }
> +
> +    netcons_create_target(config_data, target_name)
> +    logging.debug(
> +        "Created netconsole target: %s on interface %s", target_name, interface_name
> +    )
> +
> +
> +def netcons_delete_target(name: str) -> None:
> +    """Delete a netconsole dynamic target"""
> +    target_path = f"{NETCONSOLE_CONFIGFS_PATH}/{name}"
> +    try:
> +        if os.path.exists(target_path):
> +            os.rmdir(target_path)
> +    except OSError as exception:
> +        raise KsftFailEx(
> +            f"Failed to delete netconsole target: {exception}"
> +        ) from exception
> +
> +
> +def netcons_load_module() -> None:
> +    """Try to load the netconsole module"""
> +    os.system("modprobe netconsole")
> +
> +
> +def bpftrace_call() -> None:
> +    """Call bpftrace to find how many times netpoll_poll_dev() is called.
> +    Output is saved in the global variable `maps`"""
> +
> +    # This is going to update the global variable, that will be seen by the
> +    # main function
> +    global MAPS  # pylint: disable=W0603
> +
> +    # This will be passed to bpftrace as in bpftrace -e "expr"
> +    expr = "kprobe:netpoll_poll_dev { @hits = count(); }"
> +
> +    MAPS = bpftrace(expr, timeout=BPFTRACE_TIMEOUT, json=True)
> +    logging.debug("BPFtrace output: %s", MAPS)
> +
> +
> +def bpftrace_start():
> +    """Start a thread to call `call_bpf` in a parallel thread"""
> +    global BPF_THREAD  # pylint: disable=W0603
> +
> +    BPF_THREAD = threading.Thread(target=bpftrace_call)
> +    BPF_THREAD.start()
> +    if not BPF_THREAD.is_alive():
> +        raise KsftSkipEx("BPFtrace thread is not alive. Skipping test")
> +
> +
> +def bpftrace_stop() -> None:
> +    """Stop the bpftrace thread"""
> +    if BPF_THREAD:
> +        BPF_THREAD.join()
> +
> +
> +def bpftrace_any_hit(join: bool) -> bool:
> +    """Check if netpoll_poll_dev() was called by checking the global variable `maps`"""
> +    if BPF_THREAD.is_alive():
> +        if join:
> +            # Wait for bpftrace to finish
> +            BPF_THREAD.join()
> +        else:
> +            # bpftrace is still running, so, we will not check the result yet
> +            return False
> +
> +    logging.debug("MAPS coming from bpftrace = %s", MAPS)
> +    if "hits" not in MAPS.keys():
> +        raise KsftFailEx(f"bpftrace failed to run!?: {MAPS}")
> +
> +    return MAPS["hits"] > 0
> +
> +
> +def do_netpoll_flush_monitored(cfg: NetDrvEpEnv, ifname: str, target_name: str) -> None:
> +    """Print messages to the console, trying to trigger a netpoll poll"""
> +    # Start bpftrace in parallel, so, it is watching
> +    # netpoll_poll_dev() while we are sending netconsole messages
> +    bpftrace_start()
> +
> +    do_netpoll_flush(cfg, ifname, target_name)
> +
> +    if bpftrace_any_hit(join=True):
> +        ksft_pr("netpoll_poll_dev() was called. Success")
> +        return
> +
> +    raise KsftSkipEx("netpoll_poll_dev() was not called. Skipping test")
> +
> +
> +def do_netpoll_flush(cfg: NetDrvEpEnv, ifname: str, target_name: str) -> None:
> +    """Print messages to the console, trying to trigger a netpoll poll"""
> +    netcons_configure_target(cfg, ifname, target_name)
> +    retry = 0
> +
> +    for i in range(int(ITERATIONS)):
> +        if not BPF_THREAD.is_alive():
> +            # bpftrace is done, stop sending messages
> +            break
> +
> +        msg = f"netcons test #{i}"
> +        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
> +            for j in range(10):
> +                try:
> +                    kmsg.write(f"{msg}-{j}\n")
> +                except OSError as exception:
> +                    # in some cases, kmsg can be busy, so, we will retry
> +                    time.sleep(1)
> +                    retry += 1
> +                    if retry < 5:
> +                        logging.info("Failed to write to kmsg. Retrying")
> +                        # Just retry a few times
> +                        continue
> +                    raise KsftFailEx(
> +                        f"Failed to write to kmsg: {exception}"
> +                    ) from exception
> +
> +            if bpftrace_any_hit(join=False):
> +                # Check if netpoll_poll_dev() was called, but do not wait for it
> +                # to finish.
> +                ksft_pr("netpoll_poll_dev() was called. Success")
> +                return
> +
> +        # Every 5 iterations, toggle netconsole
> +        netcons_delete_target(target_name)
> +        netcons_configure_target(cfg, ifname, target_name)
> +        # If we sleep here, we will have a better chance of triggering
> +        # This number is based on a few tests I ran while developing this test
> +        time.sleep(0.4)
> +
> +
> +def test_netpoll(cfg: NetDrvEpEnv) -> None:
> +    """
> +    Test netpoll by sending traffic to the interface and then sending
> +    netconsole messages to trigger a poll
> +    """
> +
> +    target_name = netcons_generate_random_target_name()
> +    ifname = cfg.dev["ifname"]
> +    traffic = None
> +    original_queues = ethtool_read_rx_tx_queue(ifname)
> +
> +    try:
> +        # Set RX/TX queues to 1 to force congestion
> +        ethtool_set_rx_tx_queue(ifname, 1, 1)
> +
> +        traffic = GenerateTraffic(cfg)
> +        do_netpoll_flush_monitored(cfg, ifname, target_name)
> +    finally:
> +        if traffic:
> +            traffic.stop()
> +
> +        # Revert RX/TX queues
> +        ethtool_set_rx_tx_queue(ifname, original_queues[0], original_queues[1])
> +        netcons_delete_target(target_name)
> +        bpftrace_stop()
> +
> +
> +def test_check_dependencies() -> None:
> +    """Check if the dependencies are met"""
> +    if not os.path.exists(NETCONSOLE_CONFIGFS_PATH):
> +        raise KsftSkipEx(
> +            f"Directory {NETCONSOLE_CONFIGFS_PATH} does not exist. CONFIG_NETCONSOLE_DYNAMIC might not be set."  # pylint: disable=C0301
> +        )
> +
> +
> +def main() -> None:
> +    """Main function to run the test"""
> +    netcons_load_module()
> +    test_check_dependencies()
> +    with NetDrvEpEnv(__file__, nsim_test=True) as cfg:
> +        ksft_run(
> +            [test_netpoll],
> +            args=(cfg,),
> +        )
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> 
> -- 
> 2.47.1
> 



