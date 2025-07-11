Return-Path: <linux-kselftest+bounces-37055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC51B010E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 03:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5DB1C8155F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 01:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62454758;
	Fri, 11 Jul 2025 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gh+OgkQ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAA8F77;
	Fri, 11 Jul 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752198338; cv=none; b=dIw3lzMgMmwgk2ThZq5h+pdekEsqf0an/TLEvuulF7QLC5Wpi+rlacmABn6agVAkQUq+g4x8ICRh0JvTY5yoSm4w2YqN/CBxCUbLRplAo1cMo/Dp/ZoDq6YGvPLsKbDgjCd1EBUpUkusPIaO0EDRVWN4mXCjsoTRs1u1ub67rQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752198338; c=relaxed/simple;
	bh=gx8hEFVZ/aa1ORPcFqXp9sS5IQxNVLTFVczaBpglYsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/XRwU16RgKWhb+8Fk49puuyCYnTvJP6ri2SKdAfxJeyboeR8h1HZhYO7ZO2+tEGqoiRRT9Xo+EZrg55n/XlKZ3MRTx0bNDXf+TBU4+RtANJAIKz6qLfixAV6KoKHXoAoOxKG52to60LhiwiEPsv86gVMNfsfVUTR79gNpJfrBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gh+OgkQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D279CC4CEE3;
	Fri, 11 Jul 2025 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752198337;
	bh=gx8hEFVZ/aa1ORPcFqXp9sS5IQxNVLTFVczaBpglYsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gh+OgkQ3BuemAnHv8zGCGZtsoFS95BSEA4GGuzcADG/mMvhWuwJkzZCEDKl9iTm1P
	 hJgzyJWS2Z/8k0AUEDGr1x0GXw2Kn6/tUQLvLY1CWlOdjmArCgf3JBAaAlYK1w19mu
	 wuZ8u3iZRHw00y/A0aAAAOHEm5vyr900LA4xGXwgBs2SuBl67tJ/IzHkTR7pGXRaUt
	 lYKLOHmpucBpMXrNInjuWAKK7gHZ7sYUFla5qAWv+WWipAIMzNKOAvc5WPD3XMTdl7
	 rdzWb3lHwJhN2BWiu03gu9E6X4zt+gfeXA2T5Aew0Rwbn0Wn3yci4GyIEgXdbMj7CV
	 itUSbQJXD26yw==
Date: Thu, 10 Jul 2025 18:45:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
 kernel-team@meta.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v5 3/3] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250710184535.374a0643@kernel.org>
In-Reply-To: <20250709-netpoll_test-v5-3-b3737895affe@debian.org>
References: <20250709-netpoll_test-v5-0-b3737895affe@debian.org>
	<20250709-netpoll_test-v5-3-b3737895affe@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 09 Jul 2025 02:08:17 -0700 Breno Leitao wrote:
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

> +# Max number of netcons messages to send. Each iteration will setup
> +# netconsole and send MAX_WRITES messages
> +ITERATIONS: int = 20
> +# Number of writes to /dev/kmsg per iteration
> +MAX_WRITES: int = 40

FWIW the test takes 25sec on our debug-heavy VMs right now.
I think we can crank the writes quite a bit.. ?

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

json=True please and you'll get a dict, on CLI you can try:

ethtool --json -g eth0

> +        for line in ethtool_result.splitlines():
> +            if line.startswith("RX:"):
> +                rx_queue = int(line.split()[1])
> +            if line.startswith("TX:"):
> +                tx_queue = int(line.split()[1])
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

Well. But that's easily fixed;

	defer(ethtool, f"-G {interface_name} rx {prev_rx} tx {prev_tx}")

> +        ethtool(f"-G {interface_name} rx {rx_val} tx {tx_val}")

This is setting _ring size_ not queue count.
I suppose we want both, this and queue count to 1 (with ethtool -l / -L)
The ring size of 1 is unlikely to work on real devices.
I'd try setting it to 128 and 256 and if neither sticks just carry on
with whatever was there.

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
> +                    content.strip(),
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

this is already done for you
cfg.addr is either v4 or v6 depending on what was provided in the env

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

> +# toggle the interface up and down, to cause some congestion

Let's not do this, you're missing disruptive annotation and for many
drivers NAPI is stopped before queues
https://github.com/linux-netdev/nipa/wiki/Guidance-for-test-authors#ksft_disruptive

> +def toggle_interface(ifname: str) -> None:
> +    """Toggle the interface up and down"""
> +    logging.debug("Toggling interface %s", ifname)
> +    try:
> +        ip(f"link set dev {ifname} down")
> +        # Send a message while the interface is down, just to
> +        # cause more test scenarios. Netconsole should be
> +        # going down here as well, giving the link was lost
> +        with open("/dev/kmsg", "w", encoding="utf-8") as kmsg:
> +            kmsg.write("netcons test while interface down\n")
> +
> +        ip(f"link set dev {ifname} up")
> +    except Exception as exception:
> +        raise KsftFailEx(f"Failed to toggle interface: {exception}") from exception
> +

> +def test_netpoll(cfg: NetDrvEpEnv) -> None:
> +    """
> +    Test netpoll by sending traffic to the interface and then sending
> +    netconsole messages to trigger a poll
> +    """
> +
> +    target_name = netcons_generate_random_target_name()
> +    ifname = cfg.dev["ifname"]

cfg.ifname 

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


> +def main() -> None:
> +    """Main function to run the test"""
> +    netcons_load_module()
> +    test_check_dependencies()
> +    with NetDrvEpEnv(__file__, nsim_test=True) as cfg:

I think nsim_test=True will make the test run _only_ on netdevsim.
But there's nothing netdevsim specific here right?
You can remove the argument and let's have this run against real
drivers, too?
-- 
pw-bot: cr

