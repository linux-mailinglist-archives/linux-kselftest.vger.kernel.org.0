Return-Path: <linux-kselftest+bounces-35804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A3AE90D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 00:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F7C179B7D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBE12877D8;
	Wed, 25 Jun 2025 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhhVQukH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC9127B4E4;
	Wed, 25 Jun 2025 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750889571; cv=none; b=jtdDv6/WlOTS/84YaYA+BNQ4kK3zhf6MyfYcFvkuBw5tIfRnQCfEEM0WA3wxwn6LOF18Tq080ooWA4FoItW6DO+HntHeA2PGsTkkZn048g+EjWce0nGLB/2vUftYtk9/HV+vMaXlrDcjP+QZSgniRY/rMG7E7WG7jDYH8YXaINY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750889571; c=relaxed/simple;
	bh=QmYH8iz7I+hLnHHXLpT4R2xRHfQmPJ3xgDQkAv1dxvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0j6y3Mnof8/+DjERQRxa/MFggNKV6Ic0f3xWyxLcUaQ2amZMQOR5oYUxSYUOLqBFOZwp9CBbJ29QZnw9XeNx8/3YnPhUMeKw/JPgnmp1a0LKWB98L4cIdBi8KOqOfUvw6Z1WMpqaBZ/Pe1yxb0o59Bdm6IVFVK7ppJAruYFc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhhVQukH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B0C4CEEA;
	Wed, 25 Jun 2025 22:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750889571;
	bh=QmYH8iz7I+hLnHHXLpT4R2xRHfQmPJ3xgDQkAv1dxvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZhhVQukHhyp2I54I7VvZp1jd++sQGhmz8Be2pEFbQLlKF+/sp4JBVT5rSuj5+O2VV
	 PxQ67Rtl3Xm2ZgWqqGl4qBZReImW0Sw2RsjX/z3vgdvk7NMp8t6Pa5k4sGv2HVxok5
	 x4TqZJPdT5Kpw5IhDkMetGmjsxP5jUjIiR6SqBbSiuTWu+oQG7A3f/aEwXc+G8YobP
	 GVKSs/ZWKr5IIsq/rWWgODE4m4KCQVBgTMO6+KLpEYcOUIFXNTdeopo9uTAjpSSO2h
	 A/cuwuz3dU58gvu23Hagf2H5RTF6zc6RcFZ6JvAJ/GSvFORMO6QaXX6xBcw0NAPJ5J
	 eyjb/JrANp26g==
Date: Wed, 25 Jun 2025 15:12:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, gustavold@gmail.com
Subject: Re: [PATCH net-next v2 1/4] selftests: drv-net: add helper/wrapper
 for bpftrace
Message-ID: <20250625151249.14e5cd79@kernel.org>
In-Reply-To: <20250625-netpoll_test-v2-1-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
	<20250625-netpoll_test-v2-1-47d27775222c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 04:39:46 -0700 Breno Leitao wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> bpftrace is very useful for low level driver testing. perf or trace-cmd
> would also do for collecting data from tracepoints, but they require
> much more post-processing.
> 
> Add a wrapper for running bpftrace and sanitizing its output.
> bpftrace has JSON output, which is great, but it prints loose objects
> and in a slightly inconvenient format. We have to read the objects
> line by line, and while at it return them indexed by the map name.

Could you squash this in? Otherwise pylint can't find it

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 9ed1d8f70524..98829a0f7a02 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -14,7 +14,8 @@ KSFT_DIR = (Path(__file__).parent / "../../../..").resolve()
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
         NlError, RtnlFamily
     from net.lib.py import CmdExitFailure
-    from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
+    from net.lib.py import bkg, cmd, bpftrace, defer, ethtool, \
+        fd_read_timeout, ip, \
         rand_port, tool, wait_port_listen
     from net.lib.py import fd_read_timeout
     from net.lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx

and with that I think it should be possible to make pylint clean on the
past patch?

