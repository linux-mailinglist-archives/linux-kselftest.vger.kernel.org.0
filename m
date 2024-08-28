Return-Path: <linux-kselftest+bounces-16477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F3961B1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 02:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71086B22B1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC7511CA0;
	Wed, 28 Aug 2024 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCsMQgiy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAA2F32;
	Wed, 28 Aug 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805547; cv=none; b=ayKVOTn81ytsRmCu0IR5yAw50ynYoHGE/SRIDwWnggrkCrmko2zJCgA6ELL0Fe6aqy8WbivuJz0wsLnysSvW8CAg6Z2y1m4SYgJSqArHgc0CS6rcCWLuQ6+lPS2/Jc0xCMPhq3NAn6S+HlhVZzxZkcgK58+WoISERubjW6Oe73o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805547; c=relaxed/simple;
	bh=bqqXYjsDI3v/YMyiPhsZWWLlGKzzqS12MDRqcJeZsZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGmDwQrAPwGESG5riR9rmc/HCB5mFH0GCPcMJgsBnALrmUYc3k+Rp/W73AKdu1q2d7FlkDUp7VWwN3ZVOAq9GjvOV9P3BBovJgqGLP13Vz39E1omJ/Kr6ZpDib4sUD6sVma3HX6V8pw8fjk64R3XAFj5doMwv8oqPFG6LE8dqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCsMQgiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B7EC4AF12;
	Wed, 28 Aug 2024 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805547;
	bh=bqqXYjsDI3v/YMyiPhsZWWLlGKzzqS12MDRqcJeZsZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LCsMQgiyVesUfADKt6f2CX7QpSFcerb60JKu4QepXMr27IESIpC6wLpEt2mtmgBar
	 +v32OE9OzFAgr4t/HzNMCn+agIhPVGz8zwLjlXsRlVeCROsaEc28J0SmZkoQmBAzJ2
	 uc5/Ac28tYxMUm2PG3a1+PUQbJL0TJbR8pvpYwEsOxBazVPwMMtl/vD6pZPX8Qc0tA
	 6EI9VUiSTQoK2xs0++GECsqGigixQd7MHXHLHqa5D7qA/BWw6IVAQQxAPZY3eiCPDq
	 ATdKNUwDqdA06+PGP5UBk7t9A3KJT12GZ6vAwgSknVAYF1lkQPXXda+JIP/27P4fut
	 aeJt6/s3kkDTw==
Date: Tue, 27 Aug 2024 17:39:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240827173905.65b8efcc@kernel.org>
In-Reply-To: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Very exciting to see packetdrill tests making their way upstream!

On Tue, 27 Aug 2024 15:32:29 -0400 Willem de Bruijn wrote:
> RFC points for discussion
> 
> ksft: the choice for this python framework introduces a dependency on
> the YNL scripts, and some non-obvious code:
> - to include the net/lib dep in tools/testing/selftests/Makefile
> - a boilerplate lib/py/__init__.py that each user of ksft will need
> It seems preferable to me to use ksft.py over reinventing the wheel,
> e.g., to print KTAP output. But perhaps we can make it more obvious
> for future ksft users, and make the dependency on YNL optional.

No preference here, the wrapper script uses little of the python
code, and use of YNL seems unlikely, so it's a coin toss whether
it's worth linking up to net/lib/py or just writing a bit of bash.

> kselftest-per-directory: copying packetdrill_ksft.py to create a
> separate script per dir is a bit of a hack. A single script is much
> simpler, optionally with nested KTAP (not supported yet by ksft). But,
> I'm afraid that running time without intermediate output will be very
> long when we integrate all packetdrill scripts.

Not sure what you mean by intermediate output (the perl wrapper prints
immediately, do you have perl?). We do have some nested ktap parsing
in nipa, but small tweaks would be necessary to "decapsulate" the first
layer completely. My bigger concern would be runtime, if the time it
takes to run all tests grows we spawn multiple VMs and load balance
the test cases. 

All in all, trying to support single script is probably not worth the
extra effort.

> nf_conntrack: we can dedup the common.sh.
> 
> *pkt files: which of the 150+ scripts on github are candidates for
> kselftests, all or a subset? To avoid change detector tests.

Other than avoiding known flakes - no concerns. Is the distinction
between "change detector" vs hard tests (uAPI change / RFC compliance),
well defined? Not sure if that's really possible but if so it would be
nice to "sort" the tests into different dirs.

> And what
> is the best way to eventually send up to 150 files, 7K LoC.

Just send them, slice into a handful (<10) of patches if you can. 
7k LoC is same order of magnitude as initial drivers we merge.

To be clear let's start with a small patch like this one.
Since this is a new target I'll have to reconfigure the runners.
So we'll see how well this works once it's merged.
Spinning up new runners is a bit tedious but here new target seems 
quite justified.

>  tools/testing/selftests/Makefile              |  7 +-
>  .../selftests/net/packetdrill/.gitignore      |  1 +
>  .../selftests/net/packetdrill/Makefile        | 28 ++++++
>  .../net/packetdrill/lib/py/__init__.py        | 15 ++++
>  .../net/packetdrill/packetdrill_ksft.py       | 90 +++++++++++++++++++
>  .../net/packetdrill/tcp/common/defaults.sh    | 63 +++++++++++++
>  .../net/packetdrill/tcp/common/set_sysctls.py | 38 ++++++++
>  .../net/packetdrill/tcp/inq/client.pkt        | 51 +++++++++++
>  .../net/packetdrill/tcp/inq/server.pkt        | 51 +++++++++++
>  .../tcp/md5/md5-only-on-client-ack.pkt        | 28 ++++++

prolly need a config file to enable kconfig for MD5 ?
perils of adding new targets

> diff --git a/tools/testing/selftests/net/packetdrill/.gitignore b/tools/testing/selftests/net/packetdrill/.gitignore
> new file mode 100644
> index 0000000000000..a40f1a600eb94
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/.gitignore
> @@ -0,0 +1 @@
> +tcp*sh

Is this right or should it be tcp_*.py ?

> diff --git a/tools/testing/selftests/net/packetdrill/Makefile b/tools/testing/selftests/net/packetdrill/Makefile
> new file mode 100644
> index 0000000000000..d94c51098d1f0
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/Makefile
> @@ -0,0 +1,28 @@
> +# SPDX-License-Identifier: GPL-2.0

Would be nice to add a few lines here with an overview of how the
packetdrill tests get executed. People may jump in here to try to
add new tests, since that's how ksft usually operates.

> +def scriptname_to_testdir(filepath):
> +    """Extract the directory to run from this filename."""
> +
> +    suffix = ".sh"

.sh again ?

> diff --git a/tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh b/tools/testing/selftests/net/packetdrill/tcp/common/defaults.sh

> +# Override the default qdisc on the tun device.
> +# Many tests fail with timing errors if the default
> +# is FQ and that paces their flows.
> +tc qdisc add dev tun0 root pfifo
> +

nit: double new line

> diff --git a/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py b/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py
> new file mode 100755
> index 0000000000000..5ddf456ae973a
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp/common/set_sysctls.py

What calls this one? I can't grep it out.

