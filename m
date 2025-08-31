Return-Path: <linux-kselftest+bounces-40378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE5B3D189
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 11:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF75189B4E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5547B239E88;
	Sun, 31 Aug 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kV4H0+cm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836F20A5EA
	for <linux-kselftest@vger.kernel.org>; Sun, 31 Aug 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631419; cv=none; b=aTIOUYJnLCskWkTfYpoyj8oCAta4vnMftPR9nSPjk8qKWm0yUr3X1O1QbwdgA2Ie3zhS7mFkTDvuRDB3VfeDWTWFtkXCzSchWlB878z9UN53qpANoc2J8KhIPgdhZTT2GEAdwKxfMvZBTwLeGBMF3VjxvTiFQC1GfNRAXzz0eTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631419; c=relaxed/simple;
	bh=V7VBob5yraU5V4x0wd6nbu7xsOgkxqKovgjKyZK/b4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcAZeWdCDBnpWmiUaEdTsaI2QjJGcwtHQHoLAO+XI33ehdUOrbrxPEsdIlXzPbwjyFDbBNgL5XQ+IiAn4tHldw9zEeFS9P0kecQxmsJBtWYyuNUczDmV9IfiwCfpjy0/NzB/TUjlPQT2q/FVXhGy+T8NjtPonFUJPmBEQU0/DGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kV4H0+cm; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6e207b2b-b0ae-496c-b545-01e9844ffa15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756631413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nqnRHuIYIAsRUmY4xnLxWedSVnKIyUnTiAb2YVdvUE0=;
	b=kV4H0+cmRIES71OIBVLXhw2NCY54Qxgr/+8h8Zx0v5d3vDX1Ew9EmpNa2FYp3lyALJPfhy
	s0MMXRVldnhHMHPLd0yVX/qEYVKR6tYbH/x8ea/T895PMdXLfOebCit7CCpH2vtpmTjJ2F
	18c6ENX/h4PP+5W9bJR6w8joy6J2RUc=
Date: Sun, 31 Aug 2025 10:09:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] selftests: drv-net: csum: fix interface name for
 remote host
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org, petrm@nvidia.com
References: <20250830183842.688935-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250830183842.688935-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/08/2025 19:38, Jakub Kicinski wrote:
> Use cfg.remote_ifname for arguments of remote command.
> Without this UDP tests fail in NIPA where local interface
> is called enp1s0 and remote enp0s4.
> 
> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: petrm@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>   tools/testing/selftests/drivers/net/hw/csum.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
> index cd23af875317..3e3a89a34afe 100755
> --- a/tools/testing/selftests/drivers/net/hw/csum.py
> +++ b/tools/testing/selftests/drivers/net/hw/csum.py
> @@ -17,7 +17,7 @@ from lib.py import bkg, cmd, wait_port_listen
>       ip_args = f"-{ipver} -S {cfg.remote_addr_v[ipver]} -D {cfg.addr_v[ipver]}"
>   
>       rx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -n 100 {ip_args} -r 1 -R {extra_args}"
> -    tx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
> +    tx_cmd = f"{cfg.bin_remote} -i {cfg.remote_ifname} -n 100 {ip_args} -r 1 -T {extra_args}"
>   
>       with bkg(rx_cmd, exit_wait=True):
>           wait_port_listen(34000, proto="udp")
> @@ -37,7 +37,7 @@ from lib.py import bkg, cmd, wait_port_listen
>       if extra_args != "-U -Z":
>           extra_args += " -r 1"
>   
> -    rx_cmd = f"{cfg.bin_remote} -i {cfg.ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
> +    rx_cmd = f"{cfg.bin_remote} -i {cfg.remote_ifname} -L 1 -n 100 {ip_args} -R {extra_args}"
>       tx_cmd = f"{cfg.bin_local} -i {cfg.ifname} -L 1 -n 100 {ip_args} -T {extra_args}"
>   
>       with bkg(rx_cmd, host=cfg.remote, exit_wait=True):

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

