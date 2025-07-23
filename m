Return-Path: <linux-kselftest+bounces-37882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D6B0F737
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 17:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F44F7A814E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05111F4CBB;
	Wed, 23 Jul 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV2FsyIn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882321F418F;
	Wed, 23 Jul 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285036; cv=none; b=HnP+FXOuh4+Q+Wi6znslJaUqa2MCVWz94UCxfYx9Rn4PtxnzspdPsgoLizoa3tcuoIvagcyCcODMe/JFsb1nqXd3uy9cWW/jdl5vrxT2rKSdMdFchWFULxhLp5HYZbQoGdXseiK2/VWtNbGklhP6lxxaBoUwzEcbG8K9ukx9iDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285036; c=relaxed/simple;
	bh=SLU/oH2qQzt5epCZDYuJw9L1xngH1QoGjNwrxsaTFNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbJhpNG4Q/SZRLIfUViiG6gXoNxuBpjuJTyAFrVDKWhEGhTdyVyaEHckqcjdid3oHDHmT+d16g/IboueOGNHcqY8kuJ4aWczg26uqJbcXHSwEjgHiVhfd7U13r9efcAoHm5eUyQn2/qVZupo5w/qkKtqAS3FAPctw0GrmNX/nSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV2FsyIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFCEC4CEE7;
	Wed, 23 Jul 2025 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285036;
	bh=SLU/oH2qQzt5epCZDYuJw9L1xngH1QoGjNwrxsaTFNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fV2FsyIniQVz8yBHIwB0d2zjdj21ewlEbeNi/P0PlexaKdy5nd/hqZoPJlZVJ5Pb8
	 a+EIdqGxS4uCYP4wAKY3eLScMirDHTJ7fgCR1BnjfbNFqxqhJFJiD6odc2A7K80aU1
	 WBWTxFItuiB7mgrTop3hAjq8cwPGTcEn/IcaGM+1rPPL5Q/9lvC7OJmG73F14leRs+
	 93I1sHRLqBOyV0nY2GKbD8dNWamzRNTQu7VjnMHZa7tGea0L7kHBb66aD9L5PpRWdD
	 ejk0vfiVCSMK7BAWXfOpG7nmdvdaBTiLwrL3Yl8NVlaBUqcLfSG++R0q9PeQf30Iw6
	 DIncnEEs2RbgA==
Date: Wed, 23 Jul 2025 16:37:11 +0100
From: Simon Horman <horms@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net v2] selftests: drv-net: wait for iperf client to stop
 sending
Message-ID: <20250723153711.GG1036606@horms.kernel.org>
References: <20250722122655.3194442-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722122655.3194442-1-noren@nvidia.com>

On Tue, Jul 22, 2025 at 03:26:55PM +0300, Nimrod Oren wrote:
> A few packets may still be sent out during the termination of iperf
> processes. These late packets cause failures in rss_ctx.py when they
> arrive on queues expected to be empty.
> 
> Example failure observed:
> 
>   Check failed 2 != 0 traffic on inactive queues (context 1):
>     [0, 0, 1, 1, 386385, 397196, 0, 0, 0, 0, ...]
> 
>   Check failed 4 != 0 traffic on inactive queues (context 2):
>     [0, 0, 0, 0, 2, 2, 247152, 253013, 0, 0, ...]
> 
>   Check failed 2 != 0 traffic on inactive queues (context 3):
>     [0, 0, 0, 0, 0, 0, 1, 1, 282434, 283070, ...]
> 
> To avoid such failures, wait until all client sockets for the requested
> port are either closed or in the TIME_WAIT state.
> 
> Fixes: 847aa551fa78 ("selftests: drv-net: rss_ctx: factor out send traffic and check")
> Signed-off-by: Nimrod Oren <noren@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> ---
> Changelog:
> v2:
> - Replace fixed sleep with logic that waits for client sockets to close.
> - Update commit title and message to reflect new approach.
> v1: https://lore.kernel.org/all/20250629111812.644282-1-noren@nvidia.com/

Thanks, I believe that this addresses the review of v1
using the wait logic mentioned above.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../selftests/drivers/net/lib/py/load.py      | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
> index d9c10613ae67..44151b7b1a24 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/load.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/load.py
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +import re
>  import time
>  
>  from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
> @@ -10,12 +11,11 @@ class GenerateTraffic:
>  
>          self.env = env
>  
> -        if port is None:
> -            port = rand_port()
> -        self._iperf_server = cmd(f"iperf3 -s -1 -p {port}", background=True)
> -        wait_port_listen(port)
> +        self.port = rand_port() if port is None else port
> +        self._iperf_server = cmd(f"iperf3 -s -1 -p {self.port}", background=True)
> +        wait_port_listen(self.port)
>          time.sleep(0.1)
> -        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {port} -t 86400",
> +        self._iperf_client = cmd(f"iperf3 -c {env.addr} -P 16 -p {self.port} -t 86400",
>                                   background=True, host=env.remote)
>  
>          # Wait for traffic to ramp up
> @@ -56,3 +56,16 @@ class GenerateTraffic:
>              ksft_pr(">> Server:")
>              ksft_pr(self._iperf_server.stdout)
>              ksft_pr(self._iperf_server.stderr)
> +        self._wait_client_stopped()
> +
> +    def _wait_client_stopped(self, sleep=0.005, timeout=5):
> +        end = time.monotonic() + timeout
> +
> +        live_port_pattern = re.compile(fr":{self.port:04X} 0[^6] ")

I do have a concern about false positives with this pattern,
given that it may match anywhere on a line.

But it is a start and I don't think that concern needs to block progress.

> +
> +        while time.monotonic() < end:
> +            data = cmd("cat /proc/net/tcp*", host=self.env.remote).stdout
> +            if not live_port_pattern.search(data):
> +                return
> +            time.sleep(sleep)
> +        raise Exception(f"Waiting for client to stop timed out after {timeout}s")

+1 for the timeout mechanism.

