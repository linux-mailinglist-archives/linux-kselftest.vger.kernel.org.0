Return-Path: <linux-kselftest+bounces-35662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27468AE5937
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 03:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E2027B0AF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 01:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC21DE2CD;
	Tue, 24 Jun 2025 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBKKlvGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D831C84CB;
	Tue, 24 Jun 2025 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750728608; cv=none; b=rih1nkQ84RE7XZyce+oQqjwDa3e+jlHXWhx/RhEbW3AV8lmH7h8mmsn+sMCnc39Nh24N/l6yv7DICmt5l1Bh0EqQxK7av8gtBNA0Xmm0MfxF6seGpkkt5HqzfXVd8WNMOj/lhszokf01NctqQQ2lnPKeVedxP7zFh5c3GsQH92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750728608; c=relaxed/simple;
	bh=44ONU4dm7fL4tNZ/rYEEwW5vxHtDl7iBN8uwj17Lg+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CO6NyNbX05rBlk+JVk7cRINx60YHg9mWvAQzcYKW6ResxwAS8YJasL32kVo1NfrKkkXYxjKKnFFr+6beBbMe7zz5SuxxpBQAJMtzKroLhuhL0PbxF1+8v+bK53fQJOIH5dcBA/sXhoctXssVE1fCTfyoW0QjEaWVZnZLlPHNJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBKKlvGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14412C4CEEA;
	Tue, 24 Jun 2025 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750728607;
	bh=44ONU4dm7fL4tNZ/rYEEwW5vxHtDl7iBN8uwj17Lg+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CBKKlvGyGgiIk1EJ/AeAKuYaFCk+JI2/r3GDMH6VJeHZNyaPM++hh+P34BqIoBYTP
	 SepwKX62ov0By/+If7WKMqMGevHf9u+gJWqyVmlhINKdxoQ2wfYzePxjn4gk1e3WjJ
	 Q7ktDrQe64pRjmuWKKHxGZnwKF9p5Z3aaMvYtAhbmjf440WrO9S34upLyBt7a4huaH
	 YbkPBGDWud7X++4895LCeirJ5dGG5lbjO4WJJ84oMgoKj1OqrXllqoi75TPHlJcg8B
	 Dq3D4ycM1sz7/PaJnmcI2ZHXDcyo5gNgOzcPUGyBGpDnXkzCp8Wnp4uBw10HhFyY4U
	 E/lEGbEMxQM4A==
Date: Mon, 23 Jun 2025 18:30:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, gustavold@gmail.com
Subject: Re: [PATCH net-next] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250623183006.7c1c0cfc@kernel.org>
In-Reply-To: <20250620-netpoll_test-v1-1-5068832f72fc@debian.org>
References: <20250620-netpoll_test-v1-1-5068832f72fc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 02:38:31 -0700 Breno Leitao wrote:
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
>   5. Delete and create new netconsole targets after 5 iterations
> 
> The test validates a critical netpoll code path by monitoring traffic
> flow and ensuring netpoll_poll_dev() is called when the normal TX path
> is blocked. Perf probing confirms this test successfully triggers
> netpoll_poll_dev() in typical test runs.
> 
> This addresses a gap in netpoll test coverage for a path that is
> tricky for the network stack.

> diff --git a/tools/testing/selftests/drivers/net/netpoll_basic.py b/tools/testing/selftests/drivers/net/netpoll_basic.py
> new file mode 100755
> index 0000000000000..2a81926169262
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netpoll_basic.py
> @@ -0,0 +1,231 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test aims to evaluate the netpoll polling mechanism (as in
> +# netpoll_poll_dev()). It presents a complex scenario where the network
> +# attempts to send a packet but fails, prompting it to poll the NIC from within
> +# the netpoll TX side.
> +#
> +# This has been a crucial path in netpoll that was previously untested. Jakub
> +# suggested using a single RX/TX queue, pushing traffic to the NIC, and then
> +# sending netpoll messages (via netconsole) to trigger the poll. `perf` probing
> +# of netpoll_poll_dev() showed that this test indeed triggers
> +# netpoll_poll_dev() once or twice in 10 iterations.

Could you turn this into a docstring?

tools/testing/selftests/drivers/net/netpoll_basic.py:1:0: C0114: Missing module docstring (missing-module-docstring)

Some more pylint warnings:

+tools/testing/selftests/drivers/net/netpoll_basic.py:200:0: C0301: Line too long (111/100) (line-too-long)
+tools/testing/selftests/drivers/net/netpoll_basic.py:1:0: C0114: Missing module docstring (missing-module-docstring)
+tools/testing/selftests/drivers/net/netpoll_basic.py:61:8: W0707: Consider explicitly re-raising using 'raise KsftSkipEx(f'Failed to configure RX/TX queues: {e}. Ethtool not available?') from e' (raise-missing-from)
+tools/testing/selftests/drivers/net/netpoll_basic.py:77:12: W0707: Consider explicitly re-raising using 'raise KsftFailEx(f'Failed to create netconsole target directory: {e}') from e' (raise-missing-from)
+tools/testing/selftests/drivers/net/netpoll_basic.py:106:8: W0707: Consider explicitly re-raising using 'raise KsftFailEx(f'Failed to configure netconsole target: {e}') from e' (raise-missing-from)
+tools/testing/selftests/drivers/net/netpoll_basic.py:135:8: W0707: Consider explicitly re-raising using 'raise KsftFailEx(f'Failed to delete netconsole target: {e}') from e' (raise-missing-from)
+tools/testing/selftests/drivers/net/netpoll_basic.py:208:11: W0718: Catching too general exception Exception (broad-exception-caught)

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
> +# being called at least once in 10 iterations. Having 20 to have some buffers
> +ITERATIONS = 20
> +DEBUG = False
> +
> +
> +def generate_random_netcons_name() -> str:
> +    """Generate a random target name starting with 'netcons'"""
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

Would be nice to be able to run this test on real HW too.
Can you add appropriate defer() calls to undo the configuration changes?

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
> +        os.makedirs(f"{NETCONSOLE_CONFIGFS_PATH}/{target_name}", exist_ok=True)
> +        ksft_pr(f"Created target directory: {NETCONSOLE_CONFIGFS_PATH}/{target_name}")
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

Could be personal preference but I think that using temp variable to
store the argument looks better than breaking out the function call
over 5 lines..

FWIW we don't care about Python black upstream.

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
> +    stat2 = get_stats(cfg, netdevnl)
> +    pkts_per_sec = stat2["rx-packets"] - stat1["rx-packets"]
> +    # Just make sure this will not fail even in slow/debug kernels
> +    if pkts_per_sec < 10:
> +        raise KsftFailEx(f"Traffic seems low: {pkts_per_sec}")
> +    if DEBUG:
> +        ksft_pr(f"Traffic per second {pkts_per_sec}")
> +
> +    return pkts_per_sec
> +
> +
> +def do_netpoll_flush(
> +    cfg: NetDrvEpEnv, netdevnl: NetdevFamily, ifname: str, target_name: str
> +) -> None:
> +    """Print messages to the console, trying to trigger a netpoll poll"""
> +
> +    set_netconsole(cfg, ifname, target_name)
> +    for i in range(int(ITERATIONS)):
> +        msg = f"netcons test #{i}."
> +
> +        if DEBUG:
> +            pkts_per_s = check_traffic_flowing(cfg, netdevnl)
> +            msg += f" ({pkts_per_s} packets/s)"
> +
> +        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
> +            kmsg.write(msg)
> +
> +        if not i % 5:
> +            # Every 5 iterations, toggle netconsole
> +            delete_netconsole_target(target_name)
> +            set_netconsole(cfg, ifname, target_name)
> +
> +
> +def test_netpoll(cfg: NetDrvEpEnv, netdevnl: NetdevFamily) -> None:
> +    """
> +    Test netpoll by sending traffic to the interface and then sending
> +    netconsole messages to trigger a poll
> +    """
> +
> +    target_name = generate_random_netcons_name()
> +    ifname = cfg.dev["ifname"]
> +    traffic = None
> +
> +    try:
> +        set_single_rx_tx_queue(ifname)
> +        traffic = GenerateTraffic(cfg)
> +        check_traffic_flowing(cfg, netdevnl)

Any reason to perform this check? GenerateTraffic() already waits for
traffic to ramp up. Do we need to adjust the logic there, or make some
methods public?

> +        do_netpoll_flush(cfg, netdevnl, ifname, target_name)
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
> +def load_netconsole_module() -> None:
> +    """Try to load the netconsole module"""
> +    try:
> +        os.system("modprobe netconsole")
> +    except Exception:
> +        # It is fine if we fail to load the module, it will fail later
> +        # at check_dependencies()
> +        pass
> +
> +
> +def main() -> None:
> +    """Main function to run the test"""
> +    load_netconsole_module()
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
> base-commit: 4f4040ea5d3e4bebebbef9379f88085c8b99221c
> change-id: 20250612-netpoll_test-a1324d2057c8
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 


