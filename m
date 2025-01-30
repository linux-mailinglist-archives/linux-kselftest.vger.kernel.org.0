Return-Path: <linux-kselftest+bounces-25407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0CA2279C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 03:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0B0162C9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 02:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E15038DD3;
	Thu, 30 Jan 2025 02:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0d6ylW6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415E928F3;
	Thu, 30 Jan 2025 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738202873; cv=none; b=CIa8uT9929xbTUeOyD5rlKKHiepvRTteGv8s9q1WJtW5wW0/VHfGHv1T9UBzxKSvzQ1QEG4rQ0UgJZn78CDtuiEu/8+SJgdk/Ukt1WyCOUNvvAXS2wdpCWzVWMe0aVek+1pwuecP/9NmXe+FJAiIJIxmwo+pVI2wS927bXcmCWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738202873; c=relaxed/simple;
	bh=ojgfQkn3Kkd9q23VDwOsl3QP/6qNttcggfPTEkNxGw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT5GfJIR/XlTx14o0n5eIB07aYiU91jyJuanKLQbo+NHUMKiL2tloZOhfUiVJp/UmBAaQ0qfHCf31HGImADDF8lY/Rfchz1jzfbRfNM9mF2QXmh+Z2uLPj0gRXjoDvVJF0Hho9XAj79tuhfnB6vbBiGGDacWd+gyJPEaYet9rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0d6ylW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B84FC4CED1;
	Thu, 30 Jan 2025 02:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738202872;
	bh=ojgfQkn3Kkd9q23VDwOsl3QP/6qNttcggfPTEkNxGw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0d6ylW6U0fPppPk4GxypN0u9hj+bxJyVFUhdZ9GSAxpeM2hNgzum10uUadjMAx/K
	 PGCbLQRthqGiXRs/PEOwjaCChcGTPx/MAEYIU54b8Ok44L89c+Qhfy1Scs6FaWXhF9
	 DMtRLTH2TMfB/uJ2jBmmyDkKcsiWXbHJ5jLlWvUcNZjKtp8MCXZ5LVgnVrQMx1ogtk
	 qnG2THe+cxwufk9rudL1YAmnKs7vGhC8ZueUb+QqrYQtAm7yevCza5fAo9mVj26sYu
	 pPPiBJUnKLRGxJXF3bK2G2Bo9OUL0EaQUSucKV+Dor6JCTmXMPyElFuauwPSX5J0Bi
	 69HVOAlvel1XA==
Date: Wed, 29 Jan 2025 18:07:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, sridhar.samudrala@intel.com, Shuah Khan
 <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, linux-kernel@vger.kernel.org (open
 list), linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST
 FRAMEWORK), bpf@vger.kernel.org (open list:XDP (eXpress Data
 Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [RFC net-next 2/2] selftests: drv-net: Test queue xsk attribute
Message-ID: <20250129180751.6d30c8c4@kernel.org>
In-Reply-To: <20250129172431.65773-3-jdamato@fastly.com>
References: <20250129172431.65773-1-jdamato@fastly.com>
	<20250129172431.65773-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 17:24:25 +0000 Joe Damato wrote:
> Test that queues which are used for AF_XDP have the xsk attribute set.

> diff --git a/tools/testing/selftests/drivers/.gitignore b/tools/testing/selftests/drivers/.gitignore
> index 09e23b5afa96..3c109144f7ff 100644
> --- a/tools/testing/selftests/drivers/.gitignore
> +++ b/tools/testing/selftests/drivers/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  /dma-buf/udmabuf
>  /s390x/uvdevice/test_uvdevice
> +/net/xdp_helper

Let's create our own gitignore, under drivers/net
we'll get conflicts with random trees if we add to the shared one

>  def sys_get_queues(ifname, qtype='rx') -> int:
>      folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
> @@ -21,6 +24,31 @@ def nl_get_queues(cfg, nl, qtype='rx'):
>          return len([q for q in queues if q['type'] == qtype])
>      return None
>  
> +def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
> +    test_dir = os.path.dirname(os.path.realpath(__file__))
> +    xdp = subprocess.Popen([f"{test_dir}/xdp_helper", f"{cfg.ifindex}", f"{xdp_queue_id}"],
> +                           stdin=subprocess.PIPE, stdout=subprocess.PIPE, bufsize=1,
> +                           text=True)

add:
	defer(xdp.kill)

here, to make sure test cleanup will always try to kill the process,
then you can remove the xdp.kill() at the end

> +    stdout, stderr = xdp.communicate(timeout=10)
> +    rx = tx = False
> +
> +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> +    if queues:

if not queues:
	raise KsftSkipEx("Netlink reports no queues")

That said only reason I can think of for no queues to be reported would
be that the device is down, which is very weird and we could as well
crash. So maybe the check for queues is not necessary ?

> +        for q in queues:
> +            if q['id'] == 0:
> +                if q['type'] == 'rx':
> +                    rx = True
> +                if q['type'] == 'tx':
> +                    tx = True
> +
> +                ksft_eq(q['xsk'], 1)
> +            else:
> +                ksft_eq(q['xsk'], 0)
> +
> +    ksft_eq(rx, True)
> +    ksft_eq(tx, True)
> +    xdp.kill()

