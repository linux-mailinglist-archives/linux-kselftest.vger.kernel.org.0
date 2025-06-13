Return-Path: <linux-kselftest+bounces-34857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E13AD8104
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 04:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472BA7A6CB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316B23A9BE;
	Fri, 13 Jun 2025 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knBOJV76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39C1FDA6A;
	Fri, 13 Jun 2025 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749782158; cv=none; b=AjTkvRDdzWJaSiLR+jX1o9N4XG7qq1DbzJcErwENfjvHnswwE6pfZxe63fxTuuj8UPQ/bP65gwdy1Hwe+ojlXKtT71gdIuGDjjjnNG6y9+pTbQRrGVU1tBlfPmiGbfv9Ogt88hIrQHCFEQAjR5UQBOGVs/UqQzgjLBVjVNmzI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749782158; c=relaxed/simple;
	bh=XIWU2XDjW5+h5bArSTzpvYP6TB4r1wjjDsdWeKNO3uo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FV92EckpTCrRtKXze3kds/zt0MK+Np7bUysTt7HMvzv34yzV4xz8d6L9yh11yQ2F0tRCPPF2ssCz5BCDgZ7oS6SOk8igx4Xwi7bBzL1Pm9wDUQfwRjGb5/15pmkEC6YrN4NbL2BXveaMwGBOXnlKAU8Bi98QP6VNvoGtMBCtFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knBOJV76; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e817b40d6e7so1552417276.1;
        Thu, 12 Jun 2025 19:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749782156; x=1750386956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9/RTvn6g2/NjL4CXoXWixdaLM44Q5nbltEazxhI+J8=;
        b=knBOJV76uHQk0eVpI84e+VU9Sz7bKEVjiUCFjAp0KaJYRn1ZTetnmsHBXkXYAq7sEs
         1YDO1j47cnUxiRNoIu+fJRl2a5r3cXrjeBwXFj3byW7xMeYAHQ/XOZ2NM3L45fIwjQac
         nc2RcEtqxRc6dziuUOCtkwp7Yw/uiyhxegqx8pNiuuKtFMNOSVGrwQcLUF6ZA3qywn+o
         SqmBI0sKVRKh1zNVyzb4m4t+1gh0Qx3ROB0PbZP3O5VFe2SHtH3Y9MfdNrgT1FVaYa2x
         feItZNr+cck7tbO8+6ZHGUJepoDXU5/3Uhvl+3B+yI3pR0whvcoOuHlBKkomXeshFmst
         nJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749782156; x=1750386956;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9/RTvn6g2/NjL4CXoXWixdaLM44Q5nbltEazxhI+J8=;
        b=CfUfuaHjRIZXFcMCsfnjTeOVN/NQRd/fDLdJUd5KsrJseDGGCLVOzhCsrFhyQI+1jU
         iMSCzkqaLr3guaeO8Jtuu64qq62E2JVrf3xMsKKxMkrrbWkPU2SvMgiXMtWsTqg3u2Q1
         tZUY2MdGvD8tPpzmXq6jaJVSK4BlEKaRFBn4moTZo/fPSCPhR6xlvpWgGXn+60FFKFym
         ST833H51UT4Cg0poyac+5/ACd2SHNhQS3ldwl2pAWtL1MXkDdrObpBu3FcIYmNskiUnf
         7imO/ekgxF6PChO3gDw6qo3R323NSqCfz0c/9oRMIH6+KNgyH10qLq0D7duel3i8kyJn
         rThQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+jc75kb3u38QvNBPhzBhH8SLgkbn0KI7Jf61OrFzt06lVFUblDn7u6Fml6odFEtlDm8CaeF8Wx91y/Z72omY=@vger.kernel.org, AJvYcCXM4YJefe5DEjwoBqJ7mLRCrWyo1g/HeklEOwSDVmSRUpsAHbwP4PJxE6YYVlMikrJl9QSpXvke@vger.kernel.org
X-Gm-Message-State: AOJu0YzqHaluIhq7S57iumB+budGc8LO1D9zjoO9ndV8b6dS57AlJ6F/
	kLjSjHTY/8uoXXITkAX2FSEUb2et/fdQ4DRMqYTfSk3z9OIWfrSI0RKR
X-Gm-Gg: ASbGncsiivV5f9oCARTkjruMNwRLcaqzdtCbXfMFqMAcrkGDzixt6lD4YTQKeFciIg3
	7k6Snjs5aOFDWSWugFmiPxTtPSHs/ZmYErHB4/dO8C8Aic3hndMGls3eqNBxBWBkQVqFBsJycMN
	TnSc1ymaLGuSADdeJOeIMZ8XifabvtskscFcuekTHzj3K4F31lfyse/iKzz73Obvb/cK/NiiG69
	SZLvmcAbqxxEWJQUetHOA3nRcl8rdF7ssSRo6ZsHQ7u8qflBvdY/v8aSSlMcuNxNMIX6AI7Rmpv
	M/tCRf5QMAJoIWqcHsdvro9hqwXAQFZ2cUHVZgusIit4QsKcFUSimhkujXErTBuKRgc/IxcA4lf
	m9OxeiaTSBrY+anniGuUliqUHu49hcRhDYhC2wlMhxA==
X-Google-Smtp-Source: AGHT+IFcpdxpKDi4ohUAFGf90rvNUqzkDTY/yd1ySZ3hH5mZRjLML/wRihyO8goObxVbYPQq91CJsA==
X-Received: by 2002:a05:6902:140f:b0:e81:9a82:fcc0 with SMTP id 3f1490d57ef6-e821c049f41mr2037248276.13.1749782155719;
        Thu, 12 Jun 2025 19:35:55 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e820e09d3ffsm821744276.23.2025.06.12.19.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 19:35:55 -0700 (PDT)
Date: Thu, 12 Jun 2025 22:35:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 ast@kernel.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
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
> maximum sppend, and netpoll needs to poll the NIC. This is achieved by:

minor type: sppend/speed
 
>   1. Configuring a single RX/TX queue to create contention
>   2. Generating background traffic to saturate the interface
>   3. Sending netconsole messages to trigger netpoll polling
>   4. Using dynamic netconsole targets via configfs
> 
> The test validates a critical netpoll code path by monitoring traffic
> flow and ensuring netpoll_poll_dev() is called when the normal TX path
> is blocked. Perf probing confirms this test successfully triggers
> netpoll_poll_dev() in typical test runs.

So the test needs profiling to make it a pass/fail regression test?
Then perhaps add it to TEST_FILES rather than TEST_PROGS. Unless
exercising the code on its own is valuable enough.

Or is there another way that the packets could be observed, e.g.,
counters.
> This addresses a gap in netpoll test coverage for a path that is
> tricky for the network stack.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Sending as an RFC for your appreciation, but it dpends on [1] which is
> stil under review. Once [1] lands, I will send this officially.
> 
> Link: https://lore.kernel.org/all/20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org/ [1]
> ---
>  tools/testing/selftests/drivers/net/Makefile       |   1 +
>  .../testing/selftests/drivers/net/netpoll_basic.py | 201 +++++++++++++++++++++
>  2 files changed, 202 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index be780bcb73a3b..70d6e3a920b7f 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -15,6 +15,7 @@ TEST_PROGS := \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
>  	netcons_sysdata.sh \
> +	netpoll_basic.py \
>  	ping.py \
>  	queues.py \
>  	stats.py \
> diff --git a/tools/testing/selftests/drivers/net/netpoll_basic.py b/tools/testing/selftests/drivers/net/netpoll_basic.py
> new file mode 100755
> index 0000000000000..8abdfb2b1eb6e
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
> @@ -0,0 +1,201 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test aims to evaluate the netpoll polling mechanism (as in netpoll_poll_dev()).
> +# It presents a complex scenario where the network attempts to send a packet but fails,
> +# prompting it to poll the NIC from within the netpoll TX side.
> +#
> +# This has been a crucial path in netpoll that was previously untested. Jakub
> +# suggested using a single RX/TX queue, pushing traffic to the NIC, and then sending
> +# netpoll messages (via netconsole) to trigger the poll. `perf` probing of netpoll_poll_dev()
> +# showed that this test indeed triggers netpoll_poll_dev() once or twice in 10 iterations.
> +
> +# Author: Breno Leitao <leitao@debian.org>
> +
> +import errno
> +import os
> +import random
> +import string
> +import time
> +
> +from lib.py import (
> +    ethtool,
> +    GenerateTraffic,
> +    ksft_exit,
> +    ksft_pr,
> +    ksft_run,
> +    KsftFailEx,
> +    KsftSkipEx,
> +    NetdevFamily,
> +    NetDrvEpEnv,
> +)
> +
> +NETCONSOLE_CONFIGFS_PATH = "/sys/kernel/config/netconsole"
> +REMOTE_PORT = 6666
> +LOCAL_PORT = 1514
> +# Number of netcons messages to send. I usually see netpoll_poll_dev()
> +# being called at least once in 10 iterations.
> +ITERATIONS = 10

Is usually sufficient to avoid flakiness, or should this be cranked
up?

> +DEBUG = False
> +
> +
> +def generate_random_netcons_name() -> str:
> +    """Generate a random name starting with 'netcons'"""
> +    random_suffix = "".join(random.choices(string.ascii_lowercase + string.digits, k=8))
> +    return f"netcons_{random_suffix}"
> +
> +
> +def get_stats(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> dict[str, int]:
> +    """Get the statistics for the interface"""
> +    return netdevnl.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> +
> +
> +def set_single_rx_tx_queue(interface_name: str) -> None:
> +    """Set the number of RX and TX queues to 1 using ethtool"""
> +    try:
> +        # This don't need to be reverted, since interfaces will be deleted after test
> +        ethtool(f"-G {interface_name} rx 1 tx 1")
> +    except Exception as e:
> +        raise KsftSkipEx(
> +            f"Failed to configure RX/TX queues: {e}. Ethtool not available?"
> +        )
> +
> +
> +def create_netconsole_target(
> +    config_data: dict[str, str],
> +    target_name: str,
> +) -> None:
> +    """Create a netconsole dynamic target against the interfaces"""
> +    ksft_pr(f"Using netconsole name: {target_name}")
> +    try:
> +        ksft_pr(f"Created target directory: {NETCONSOLE_CONFIGFS_PATH}/{target_name}")
> +        os.makedirs(f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}", exist_ok=True)
> +    except OSError as e:
> +        if e.errno != errno.EEXIST:
> +            raise KsftFailEx(f"Failed to create netconsole target directory: {e}")
> +
> +    try:
> +        for key, value in config_data.items():
> +            if DEBUG:
> +                ksft_pr(f"Setting {key} to {value}")
> +            with open(
> +                f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{key}",
> +                "w",
> +                encoding="utf-8",
> +            ) as f:
> +                # Always convert to string to write to file
> +                f.write(str(value))
> +                f.close()
> +
> +        if DEBUG:
> +            # Read all configuration values for debugging
> +            for debug_key in config_data.keys():
> +                with open(
> +                    f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{debug_key}",
> +                    "r",
> +                    encoding="utf-8",
> +                ) as f:
> +                    content = f.read()
> +                    ksft_pr(
> +                        f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}/{debug_key} {content}"
> +                    )
> +
> +    except Exception as e:
> +        raise KsftFailEx(f"Failed to configure netconsole target: {e}")
> +
> +
> +def set_netconsole(cfg: NetDrvEpEnv, interface_name: str, target_name: str) -> None:
> +    """Configure netconsole on the interface with the given target name"""
> +    config_data = {
> +        "extended": "1",
> +        "dev_name": interface_name,
> +        "local_port": LOCAL_PORT,
> +        "remote_port": REMOTE_PORT,
> +        "local_ip": cfg.addr_v["4"] if cfg.addr_ipver == "4" else cfg.addr_v["6"],
> +        "remote_ip": (
> +            cfg.remote_addr_v["4"] if cfg.addr_ipver == "4" else cfg.remote_addr_v["6"]
> +        ),
> +        "remote_mac": "00:00:00:00:00:00",  # Not important for this test
> +        "enabled": "1",
> +    }
> +
> +    create_netconsole_target(config_data, target_name)
> +    ksft_pr(f"Created netconsole target: {target_name} on interface {interface_name}")
> +
> +
> +def delete_netconsole_target(name: str) -> None:
> +    """Delete a netconsole dynamic target"""
> +    target_path = f"{NETCONSOLE_CONFIGFS_PATH}/{name}"
> +    try:
> +        if os.path.exists(target_path):
> +            os.rmdir(target_path)
> +    except OSError as e:
> +        raise KsftFailEx(f"Failed to delete netconsole target: {e}")
> +
> +
> +def check_traffic_flowing(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> int:
> +    """Check if traffic is flowing on the interface"""
> +    stat1 = get_stats(cfg, netdevnl)
> +    time.sleep(1)

Can the same be learned with sufficient precision when sleeping
for only 100 msec? As tests are added, it's worth trying to keep
their runtime short.

> +    stat2 = get_stats(cfg, netdevnl)
> +    pkts_per_sec = stat2["rx-packets"] - stat1["rx-packets"]
> +    # Just make sure this will not fail even in slow/debug kernels
> +    if pkts_per_sec < 10:
> +        raise KsftFailEx(f"Traffic seems low: {pkts_per_sec}")
> +    if DEBUG:
> +        ksft_pr(f"Traffic per second {pkts_per_sec} ", pkts_per_sec)
> +
> +    return pkts_per_sec
> +
> +
> +def do_netpoll_flush(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
> +    """Print messages to the console, trying to trigger a netpoll poll"""
> +    for i in range(int(ITERATIONS)):
> +        pkts_per_s = check_traffic_flowing(cfg, netdevnl)
> +        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
> +            kmsg.write(f"netcons test #{i}: ({pkts_per_s} packets/s)\n")
> +
> +
> +def test_netpoll(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
> +    """Test netpoll by sending traffic to the interface and then sending netconsole messages to trigger a poll"""
> +    target_name = generate_random_netcons_name()
> +    ifname = cfg.dev["ifname"]
> +    traffic = None
> +
> +    try:
> +        set_single_rx_tx_queue(ifname)
> +        traffic = GenerateTraffic(cfg)
> +        check_traffic_flowing(cfg, netdevnl)
> +        set_netconsole(cfg, ifname, target_name)
> +        do_netpoll_flush(cfg, netdevnl)
> +    finally:
> +        if traffic:
> +            traffic.stop()
> +        delete_netconsole_target(target_name)
> +
> +
> +def check_dependencies() -> None:
> +    """Check if the dependencies are met"""
> +    if not os.path.exists(NETCONSOLE_CONFIGFS_PATH):
> +        raise KsftSkipEx(
> +            f"Directory {NETCONSOLE_CONFIGFS_PATH} does not exist. CONFIG_NETCONSOLE_DYNAMIC might not be set."
> +        )
> +
> +
> +def main() -> None:
> +    """Main function to run the test"""
> +    check_dependencies()
> +    netdevnl = NetdevFamily()
> +    with NetDrvEpEnv(__file__, nsim_test=True) as cfg:
> +        ksft_run(
> +            [test_netpoll],
> +            args=(
> +                cfg,
> +                netdevnl,
> +            ),
> +        )
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> 
> ---
> base-commit: 5d6d67c4cb10a4b4d3ae35758d5eeed6239afdc8
> change-id: 20250612-netpoll_test-a1324d2057c8
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 



