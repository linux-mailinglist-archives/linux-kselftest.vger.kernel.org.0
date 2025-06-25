Return-Path: <linux-kselftest+bounces-35798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F0CAE8CF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842D97BA7BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305DC2DECA9;
	Wed, 25 Jun 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs1M4is6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5272DA76E;
	Wed, 25 Jun 2025 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877031; cv=none; b=e8W5Nr5gHAduQHbiZq7jp+/al5y92jUNBJ9aTTAGhj+QL6F505ip+0mpshBHGZeofq4hogjNRyS877mwSZeUSV3DsBb20jHOoJrHg2Ia+o3Z0E5wlPng7jwdGNieT11wmQeR5jWQkdhL4hAPScNXbpu1dJV44ju8lL82y9CfGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877031; c=relaxed/simple;
	bh=ZJVbUo8OzFrzFVasPxRUa8SWl41d6RCby7I8OisKltY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn0tv/icMjSpsOeR/G0Upgn5ID2OPwOX3aQC5PM3AQB3SBg9kz2kTA12116uhtoW5jtt8WRWzx3SSkpm4j/VLKFLbtOdFxg5tqR17GE/BrDvU92n9FbtYAs5+J4u7L6/8d8UD3f6G94sDre4PLsHnNh7lzCreH8fqB8mPcwLQJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs1M4is6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A98C4CEEA;
	Wed, 25 Jun 2025 18:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877030;
	bh=ZJVbUo8OzFrzFVasPxRUa8SWl41d6RCby7I8OisKltY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fs1M4is6UuD6YDlS4Mm0P26Eiaw+z9EhqbZQiVDp9Eh7safu51xOT5HLLZApf04Px
	 TrBi+PfzewbyNvwv98cscMb92Jg1jnu4E1/8IRnjo1rqT2NJvXdCrNm8yR10GKL0A2
	 LJcwNVtKEcST4CP7vXHOQy3Z+6ch0BefBvOF18MfISHq8rcUWpxSA8Br907l/d208q
	 RRQB2VubFCDpuR+F45biE6dQ4GaK2eLQGFJIoB0QqGIQMyyXiEQzQjTRaftWRjpMyV
	 9Dux8YQgehnjMvQIKM8zLjmaySmj29ed5Mo9zGFgolUe/CSKgM34oR9Cgx3P8jxfRV
	 eg0yn47judCcg==
Date: Wed, 25 Jun 2025 19:43:46 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	bpf@vger.kernel.org, gustavold@gmail.com,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 0/4] selftest: net: Add selftest for netpoll
Message-ID: <20250625184346.GM1562@horms.kernel.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>

+ Stan

On Wed, Jun 25, 2025 at 04:39:45AM -0700, Breno Leitao wrote:
> I am submitting a new selftest for the netpoll subsystem specifically
> targeting the case where the RX is polling in the TX path, which is
> a case that we don't have any test in the tree today. This is done when
> netpoll_poll_dev() called, and this test creates a scenario when that is
> probably.
> 
> The test does the following:
> 
> 1) Configuring a single RX/TX queue to increase contention on the
>    interface.
> 2) Generating background traffic to saturate the network, mimicking
>    real-world congestion.
> 3) Sending netconsole messages to trigger netpoll polling and monitor
>    its behavior.
> 4) Using dynamic netconsole targets via configfs, with the ability to
>    delete and recreate targets during the test.
> 5) Running bpftrace in parallel to verify that netpoll_poll_dev() is
>    called when expected. If it is called, then the test passes,
>    otherwise the test is marked as skipped.
> 
> In order to achieve it, I stole Jakub's bpftrace helper from [1], and
> did some small changes that I found useful to use the helper.
> 
> So, this patchset basically contains:
> 
> 1) The code stolen from Jakub
> 2) Improvements on bpftrace() helper
> 3) The selftest itself
> 
> Link: https://lore.kernel.org/all/20250421222827.283737-22-kuba@kernel.org/ [1]

Jakub, Stan, all,

It looks like bpftrace needs to be installed on the CI workers.
Currently they report something a lot like this:

# timeout set to 180
# selftests: drivers/net: netpoll_basic.py
# Exception in thread Thread-1:
# Traceback (most recent call last):
#   File "/usr/lib64/python3.9/threading.py", line 980, in _bootstrap_inner
#     self.run()
#   File "/usr/lib64/python3.9/threading.py", line 917, in run
#     self._target(*self._args, **self._kwargs)
#   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 198, in bpftrace_call
#     MAPS = bpftrace(expr, timeout=BPFTRACE_TIMEOUT, json=True)
#   File "/home/virtme/testing-17/tools/testing/selftests/net/lib/py/utils.py", line 205, in bpftrace
#     cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
#   File "/home/virtme/testing-17/tools/testing/selftests/net/lib/py/utils.py", line 60, in __init__
#     self.proc = subprocess.Popen(comm, shell=shell, stdout=subprocess.PIPE,
#   File "/usr/lib64/python3.9/subprocess.py", line 951, in __init__
#     self._execute_child(args, executable, preexec_fn, close_fds,
#   File "/usr/lib64/python3.9/subprocess.py", line 1837, in _execute_child
#     raise child_exception_type(errno_num, err_msg, err_filename)
# FileNotFoundError: [Errno 2] No such file or directory: 'bpftrace'
# TAP version 13
# 1..1
# # Exception| Traceback (most recent call last):
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/net/lib/py/ksft.py", line 243, in ksft_run
# # Exception|     case(*args)
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 308, in test_netpoll
# # Exception|     do_netpoll_flush_monitored(cfg, netdevnl, ifname, target_name)
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 243, in do_netpoll_flush_monitored
# # Exception|     do_netpoll_flush(cfg, netdevnl, ifname, target_name)
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 278, in do_netpoll_flush
# # Exception|     if bpftrace_any_hit(join=False):
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./netpoll_basic.py", line 230, in bpftrace_any_hit
# # Exception|     raise KsftFailEx(f"bpftrace failed to run!?: {MAPS}")
# # Exception| net.lib.py.ksft.KsftFailEx: bpftrace failed to run!?: {}
# not ok 1 netpoll_basic.test_netpoll
# # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0


