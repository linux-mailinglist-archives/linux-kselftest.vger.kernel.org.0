Return-Path: <linux-kselftest+bounces-37434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47AB07828
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7929B7B5175
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D8626B76D;
	Wed, 16 Jul 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGqOXs1u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92155263C9F;
	Wed, 16 Jul 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676250; cv=none; b=T09tE91Sue3efDA+1emlkw24trNOUbxx85KfKf/QbtO/e6K7UBc03Ux8RFNd8cOMxAh/A7O+3Z3ttBCBtqvKtlG1AL8lLxFWA2WAiRQufsAP2DCkAAwjt5O6wGtu5m0Lvw6oSTkVeicaeZ1WR2U4aXa7XQodde8V1mq8Q4Oi3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676250; c=relaxed/simple;
	bh=+7GaLCQmfxsw2Ze83ywPS5OxpKBvvXdTtasxk+627lU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8BOA693WXQ+f4i49kWDtj0sXDH/XVHVGJHer9EuKVnJ7gcqHKvtiIKLz5R4oUN5aqoCbBgbiLLy4Cf+XC+b+af0CQxpGkmKcZWS6N8GZGx/jbBNwe4ABUSEcRqC3EpBPg89GmJzxwK3fIBREXHS2GxEFT+WfmtNoTpflWUfLCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGqOXs1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9A7C4CEE7;
	Wed, 16 Jul 2025 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676250;
	bh=+7GaLCQmfxsw2Ze83ywPS5OxpKBvvXdTtasxk+627lU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QGqOXs1u0zySTLcUmFrIDYXDkv2yPNs1SuBpeQt/Re5xhNXypKTWDW7vNlCCbSLpo
	 xlr9MYwyVcddC6UmAPn4bl+dYJ1QOV1V3MdCDsmEJr6etSlz9Q7DtpeXa7lEpqRbrL
	 2z/YD75gDjbWNjTXokItmjd9xF7aSrSwig5MG1twuoa+Oh/jNEsleJFMZ43OLeg5zP
	 cRK5TEVHo6t4uuxxdXnoN0818O4zVPqewc0uv/qDqagsq+lAuZBiux3Zg1i4XYngWj
	 qnTlHpMwqpVTwQBh7u5pgpPlifRJtRa6fLU+uLLAwXWYTQr8hfbPhfN6dURQfAoL7E
	 Got7FyN64ebKg==
Date: Wed, 16 Jul 2025 07:30:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com,
 justinstitt@google.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next V5 0/5] net: netdevsim: hook in XDP handling
Message-ID: <20250716073048.03e117a1@kernel.org>
In-Reply-To: <20250715210553.1568963-1-mohsin.bashr@gmail.com>
References: <20250715210553.1568963-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 14:05:48 -0700 Mohsin Bashir wrote:
> This patch series add tests to validate XDP native support for PASS,
> DROP, ABORT, and TX actions, as well as headroom and tailroom adjustment.
> For adjustment tests, validate support for both the extension and
> shrinking cases across various packet sizes and offset values.
> 
> The pass criteria for head/tail adjustment tests require that at-least
> one adjustment value works for at-least one packet size. This ensure
> that the variability in maximum supported head/tail adjustment offset
> across different drivers is being incorporated.
> 
> The results reported in this series are based on fbnic. However, the
> series is tested against multiple other drivers including netdevism.

Not much luck, on netdevsim with a debug kernel build the test seems to
time out after 3min 30sec without printing anything.

A normal VM it doesn't time out but it seems to reliably fail as follows:

TAP version 13
1..1
# timeout set to 180
# selftests: drivers/net: xdp.py
# TAP version 13
# 1..9
# ok 1 xdp.test_xdp_native_pass_sb
# ok 2 xdp.test_xdp_native_pass_mb
# ok 3 xdp.test_xdp_native_drop_sb
# ok 4 xdp.test_xdp_native_drop_mb
# ok 5 xdp.test_xdp_native_tx_mb
# # Exception| Traceback (most recent call last):
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/net/lib/py/ksft.py", line 243, in ksft_run
# # Exception|     case(*args)
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./xdp.py", line 466, in test_xdp_native_adjst_tail_grow_data
# # Exception|     _validate_res(res, offset_lst, pkt_sz_lst)
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./xdp.py", line 337, in _validate_res
# # Exception|     raise KsftFailEx(f"{res['reason']}")
# # Exception| net.lib.py.ksft.KsftFailEx: Adjustment failed
# not ok 6 xdp.test_xdp_native_adjst_tail_grow_data
# ok 7 xdp.test_xdp_native_adjst_tail_shrnk_data
# # Failed run: pkt_sz 512, offset -256. Last successful run: pkt_sz 512, offset -128. Reason: Adjustment failed
# ok 8 xdp.test_xdp_native_adjst_head_grow_data
# # Exception| Traceback (most recent call last):
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/net/lib/py/ksft.py", line 243, in ksft_run
# # Exception|     case(*args)
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./xdp.py", line 625, in test_xdp_native_adjst_head_shrnk_data
# # Exception|     _validate_res(res, offset_lst, pkt_sz_lst)
# # Exception|   File "/home/virtme/testing-17/tools/testing/selftests/drivers/net/./xdp.py", line 337, in _validate_res
# # Exception|     raise KsftFailEx(f"{res['reason']}")
# # Exception| net.lib.py.ksft.KsftFailEx: Data exchange failed
# not ok 9 xdp.test_xdp_native_adjst_head_shrnk_data
# # Totals: pass:7 fail:2 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: drivers/net: xdp.py # exit=1
-- 
pw-bot: cr

