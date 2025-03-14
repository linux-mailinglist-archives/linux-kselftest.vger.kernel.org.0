Return-Path: <linux-kselftest+bounces-29021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE7A60D48
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 10:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8783BD99A
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291B91F03C7;
	Fri, 14 Mar 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG5d4d1/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C11EB187
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944485; cv=none; b=PnL0o4koVUvGPhXD79cPJtJWkeUtiUy+qRi+aJ/3dPWFRQ3VcBZDNKh6FKXa6DI/lOaH3dzFBVlbbllGXn4ZMPN0DSBYmkvtjLY3Jek6HwT5rt09ZmpEgty9Pu1cDyI6HyGLrwniZDUmw11DUtRpy/3fVZ1QtgbI92GsHyP6Wyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944485; c=relaxed/simple;
	bh=vsPV74bHjFFKgF9PSNyIa/k5Nno6ObGS6QrL0HdfSYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6OW9IozUdS+5lFvegDWtLtYfCDWBdf13wlndHM+u3M7Mdabf+mQZKGg/2BfV0Qdfp+JaJpCiaRNWo/5tWzgRzWwqtNyKEQK1PdZ4eVGDvRSXJvRbGkvK5hAA9oqXLaihVeJdOkWDJ8K4T+zSTJag3h1H1QCo0kjdqjANgm/1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG5d4d1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741944481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
	b=OG5d4d1/ResZhWD4CtxyCdEf+fszr2CSWYNVmmo9qQ72Qnr3uAP48ys7ePcju5VMp38bMY
	nPxRGV/bZ8MCpB08PNAk5umx+tEnG7WbrBAIowZSvR1GuEVAj6h3uhS359craMS3juhOQk
	aoeY4XjBSRWKi4T9BdJhcfKQZOV2B60=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-fseCGPZJNhmOkwdooMk7jg-1; Fri, 14 Mar 2025 05:27:59 -0400
X-MC-Unique: fseCGPZJNhmOkwdooMk7jg-1
X-Mimecast-MFC-AGG-ID: fseCGPZJNhmOkwdooMk7jg_1741944478
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947a0919aso14201205e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Mar 2025 02:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944478; x=1742549278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=319xWC7kBsMMKIlkxDgvjIvvfT6rutmSJuA6sY1hnVk=;
        b=UzQuErTUjxR3hNznxyeHAmRxOc3Q+l9y+FJReFHdgx+WlLZUgO5lVJcXp0LKQzSEn2
         u9JgBZ0WB90bf7P85TL1o24evkcI4x4VdAOZKXs4REBZ/AZd6ETCzcOMlmlVUTATRTqK
         crpHFcUu9QYtQ/J0uVvdp2hgNBY+ISv3oNfQn5Vg+MFqsSuJMnqG5vmivy0aj5oSIJto
         ZNgWhA1QduCHALb66+YF0E2Jno5keQ0Ddv2tTjThriaUYKCsAAnR1SBnOsFKv7EBjLYm
         THIga1vUXektrlr5DdZhoDjh65WejDw+AjeiLot9so/ryAl1wy59x1FIEDdBB6aMFiJ+
         x52w==
X-Forwarded-Encrypted: i=1; AJvYcCWmnIcIfhBGvdiSkANo6gWp1EclHRwN476+90WxrPchquKdmyAfyDegvzDzlsnyR8qNaAzf54IXmp0LphT/ixE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztG5DZlCtGwffTc4I3WFILmh99dSNoz1H7X504X+orsPwxNRaT
	7cJ/HswYwZ/uz7kCLY/PeX6tuhlJj2lqAXipJwCkst+lJ06e6g7nLOu7hZJJSUYWtP5hz9DU2zx
	qgfS2/zYP2M+hfeoUI5Zkx+PeWnyiMcqV8vPV3I+JeEqTiZxOhDJgVlUrkI4jEEpjIw==
X-Gm-Gg: ASbGncs7cRaZXrI9WeqWROV8WH9u6kqYnkFEhBu5YYVkFlHE7jUrucyiBu9M8JXQgSk
	jkDu6IQjL2TXnzLUZ1cWcUM95RozHbC/0/WHytM/r9HLC3xz4N5oO0ctR232vTFtJdQ80MZ7/qq
	UvoRrGHlBCk4h9T9blD0Rkzi4062wYqqlJu3akaxR0JcpQ5WEYOtjQdzABeJHF4x2yvtjzzKT3D
	vKp/tD+jTQUjBGm51QJdsPccxN1h5i84mO7asBTVRCs627beBQPScZkEtWE61DBpuVC67ukNMdl
	GL57UFOzLC5k2hB3DSSaYdBneWUKOG7p16OZsBw0Vci2pw==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439403f8f.4.1741944478425;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSZopK7VodYGavJXVWlDpju0bgDr38GUC5squ/pcPs+slUfrLvt93Hpt7yU6EFnjFbYLAnfw==
X-Received: by 2002:a05:6000:1846:b0:392:bf8:fc96 with SMTP id ffacd0b85a97d-3971ddd5714mr1439386f8f.4.1741944478015;
        Fri, 14 Mar 2025 02:27:58 -0700 (PDT)
Received: from [192.168.88.253] (146-241-24-221.dyn.eolo.it. [146.241.24.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe15488sm11754075e9.16.2025.03.14.02.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 02:27:57 -0700 (PDT)
Message-ID: <0a205f79-b0b5-4cd6-b237-3c61b61bc806@redhat.com>
Date: Fri, 14 Mar 2025 10:27:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: fix merge conflicts
 resolution
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314-net-next-drv-net-ping-fix-merge-v1-1-0d5c19daf707@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 9:35 AM, Matthieu Baerts (NGI0) wrote:
> After the recent merge between net-next and net, I got some conflicts on
> my side because the merge resolution was different from Stephen's one
> [1] I applied on my side in the MPTCP tree.
> 
> It looks like the code that is now in net-next is using the old way to
> retrieve the local and remote addresses. This patch is now using the new
> way, like what was in Stephen's email [1].
> 
> Also, in get_interface_info(), there were no conflicts in this area,
> because that was new code from 'net', but a small adaptation was needed
> there as well to get the remote address.
> 
> Fixes: 941defcea7e1 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> Link: https://lore.kernel.org/20250311115758.17a1d414@canb.auug.org.au [1]
> Suggested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/ping.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 7a1026a073681d159202015fc6945e91368863fe..79f07e0510ecc14d3bc2716e14f49f9381bb919f 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -15,18 +15,18 @@ no_sleep=False
>  def _test_v4(cfg) -> None:
>      cfg.require_ipver("4")
>  
> -    cmd(f"ping -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v4}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v4}", host=cfg.remote)
> +    cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["4"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["4"], host=cfg.remote)
>  
>  def _test_v6(cfg) -> None:
>      cfg.require_ipver("6")
>  
> -    cmd(f"ping -c 1 -W5 {cfg.remote_v6}")
> -    cmd(f"ping -c 1 -W5 {cfg.v6}", host=cfg.remote)
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.remote_v6}")
> -    cmd(f"ping -s 65000 -c 1 -W0.5 {cfg.v6}", host=cfg.remote)
> +    cmd("ping -c 1 -W5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -c 1 -W5 " + cfg.addr_v["6"], host=cfg.remote)
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.remote_addr_v["6"])
> +    cmd("ping -s 65000 -c 1 -W0.5 " + cfg.addr_v["6"], host=cfg.remote)
>  
>  def _test_tcp(cfg) -> None:
>      cfg.require_cmd("socat", remote=True)
> @@ -120,7 +120,7 @@ def get_interface_info(cfg) -> None:
>      global remote_ifname
>      global no_sleep
>  
> -    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_v4} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
> +    remote_info = cmd(f"ip -4 -o addr show to {cfg.remote_addr_v['4']} | awk '{{print $2}}'", shell=True, host=cfg.remote).stdout
>      remote_ifname = remote_info.rstrip('\n')
>      if remote_ifname == "":
>          raise KsftFailEx('Can not get remote interface')

Thanks for the very quick turnaround!

It really solves the mess I did.

Exceptionally applying (well) before the 24h grace period to keep the
tree sane.

Thanks!

Paolo


