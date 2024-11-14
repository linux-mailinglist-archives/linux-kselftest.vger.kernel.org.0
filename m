Return-Path: <linux-kselftest+bounces-22021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7329C869A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A731F24287
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4F1F757C;
	Thu, 14 Nov 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeBPxPZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE841F583E;
	Thu, 14 Nov 2024 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578098; cv=none; b=oeA8R/72lAaSjeaxMmvKMxPj44U6ErVw5n30WMl2qJdwshd4oi7EugEHZYRfR8MCYNXBDw38W92lnZtMFk12/WnWVkFmrMy+b8JiE6n3gX2/S4v0cH9CVX/Lmx8SAtEmN1pw2yCDbU4aZ3eJAOhSm74Jku6DoyZO14Cwbo9GHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578098; c=relaxed/simple;
	bh=Z3muD82mHVVsYQwb7TJOHXqfE63qLbx25wYI/Jovb+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATmNRlCOEEzRfdppzwh/HHxmknIVyKDc7mVNDP2OH83VPpmAioRZ48CefY6KKCeAoT8Mk+51tElyKU3X2tCa6uaEn4/85g9zcHlUrbMnIdrH9ZUZhnFr06Ta3iimtEfDL80YGcXTH+dCZMg+8B6AZFTDj8YEGRt3e4ULM7VHqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeBPxPZS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso4069465e9.0;
        Thu, 14 Nov 2024 01:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731578094; x=1732182894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En8mtDH0VYwSMajBOxcQPHpg1q90WQUYmbPWHTexEKQ=;
        b=JeBPxPZSIC8mP5x6R2hfbv7QtyQy5EMUWUtuO7ZadrzlS0XYp6Mh1GZoLxVnen/ELV
         oZUcaQTS86Qt66yBgoXjmEToVtBA+oh9uVAnL6X34yseU2TbUi7X8aghbCNjhLrlcBMM
         0Hw3gPue9AmIUp/9xAxofawBexGWnoYD2XTCfwUb+qJwKOFuoLRsdCAGV8zCMAc4G8Oj
         4tGXbVv8UVGFMHQlAIVEdd6mwqoMDSMkNeZIOSS+l661zuDvFMnmSaKCZW9p0YGnWIkv
         JvwjX5U9mLlYUQOrZWO9iREW2K6jFsELMUca46RrtPxUoWqB7ZGAQ/xZg/qqPPVOyMvE
         A9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578094; x=1732182894;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=En8mtDH0VYwSMajBOxcQPHpg1q90WQUYmbPWHTexEKQ=;
        b=J0/goXy+SZhhvxL8D+wHdY8cydAneJEaePVUbX+cljxqJN8xF/FfShO2seaYRyDItl
         b+GMcmqni4ImVcPDXgX4AeC42iHsiTt1eFhjqYj5VyxBzbv2rq8i8kdz3kFjNDhSZFiy
         Yq52ulD/0EIoOLq2Z9DJGBmvYRmaCacAgBdhzca5NpjRHA/waKgge2tg385RIMhtHCZJ
         KUkvpR8041RKMXuqEhxsZ+DFC7Rv0UBJtpVmBwWY28kUL4Eo/QnD2B8Lb7uxaMmxt+TW
         G+/wt/MgjUxCTPDaZAJ8yz8LwhXCVh8FUOWerLRNeTb+FGSsgDyHmmi6FkNcMXjWJahZ
         9yOw==
X-Forwarded-Encrypted: i=1; AJvYcCUJlo2vGUU7XDaR/Xqm0RFpDlPRqsE4G+JslfpP0cUhH164YWV48dHYOrvoYDOHGCHBQULhINiq@vger.kernel.org, AJvYcCXy+w4MMHn1X/xmV3HtRuWOyvE4XQhDi62k18hxLcaTQoHq/Sj69fOPnTy8RR2pcnTpymjFgqF0td2pIim3DyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw70lSsYmOap/eefDMnrsfekVZ/At0a6/5bx97n8NHEuEIgab
	tG1bGw5ycRQAcGacAGc7/+NW0UIBSAEwRLDBI4Woq9CIV+SY/7+v
X-Google-Smtp-Source: AGHT+IGdONrOeY5x4NfMnxD3n+379++JNuQwIM+S6L5Y6jlJGamTCRtIa92K5yRXTfpiJjWx+qE62w==
X-Received: by 2002:a05:600c:8715:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-432b75199famr181054945e9.32.1731578094356;
        Thu, 14 Nov 2024 01:54:54 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da265e0bsm17580135e9.15.2024.11.14.01.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:54:53 -0800 (PST)
Date: Thu, 14 Nov 2024 09:54:49 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: edward.cree@amd.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>,
	netdev@vger.kernel.org, linux-net-drivers@amd.com, horms@kernel.org,
	andrew+netdev@lunn.ch, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] selftest: include dst-ip in ethtool ntuple
 rules
Message-ID: <20241114095449.GA667167@gmail.com>
Mail-Followup-To: edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, horms@kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <8e5d23c8f21310c23c080cc7bcd31b76f8fd3096.1731499022.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5d23c8f21310c23c080cc7bcd31b76f8fd3096.1731499022.git.ecree.xilinx@gmail.com>

On Wed, Nov 13, 2024 at 12:13:11PM +0000, edward.cree@amd.com wrote:
> 
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> sfc hardware does not support filters with only ipproto + dst-port;
>  adding dst-ip to the flow spec allows the rss_ctx test to be run on
>  these devices.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
> I'm not sure if this change will break the test for other drivers that
> perhaps support the old filter but not the new one.  If so we might
> need to add an option to cfg to control this choice.
> 
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> index 29995586993c..fb61dae20fd8 100755
> --- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> +++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
> @@ -215,7 +215,7 @@ def test_rss_queue_reconfigure(cfg, main_ctx=True):
>          defer(ethtool, f"-X {cfg.ifname} default")
>      else:
>          other_key = 'noise'
> -        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
> +        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
>          ntuple = ethtool_create(cfg, "-N", flow)
>          defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
>  
> @@ -429,7 +429,7 @@ def test_rss_context(cfg, ctx_cnt=1, create_with_cfg=None):
>          ksft_eq(max(data['rss-indirection-table']), 2 + i * 2 + 1, "Unexpected context cfg: " + str(data))
>  
>          ports.append(rand_port())
> -        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id}"
> +        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {ports[i]} context {ctx_id}"
>          ntuple = ethtool_create(cfg, "-N", flow)
>          defer(ethtool, f"-N {cfg.ifname} delete {ntuple}")
>  
> @@ -516,7 +516,7 @@ def test_rss_context_out_of_order(cfg, ctx_cnt=4):
>          ctx.append(defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete"))
>  
>          ports.append(rand_port())
> -        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {ports[i]} context {ctx_id}"
> +        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {ports[i]} context {ctx_id}"
>          ntuple_id = ethtool_create(cfg, "-N", flow)
>          ntuple.append(defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}"))
>  
> @@ -569,7 +569,7 @@ def test_rss_context_overlap(cfg, other_ctx=0):
>  
>      port = rand_port()
>      if other_ctx:
> -        flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {other_ctx}"
> +        flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {other_ctx}"
>          ntuple_id = ethtool_create(cfg, "-N", flow)
>          ntuple = defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
>  
> @@ -587,7 +587,7 @@ def test_rss_context_overlap(cfg, other_ctx=0):
>      # Now create a rule for context 1 and make sure traffic goes to a subset
>      if other_ctx:
>          ntuple.exec()
> -    flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
> +    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
>      ntuple_id = ethtool_create(cfg, "-N", flow)
>      defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
>  
> @@ -620,7 +620,7 @@ def test_delete_rss_context_busy(cfg):
>  
>      # utilize context from ntuple filter
>      port = rand_port()
> -    flow = f"flow-type tcp{cfg.addr_ipver} dst-port {port} context {ctx_id}"
> +    flow = f"flow-type tcp{cfg.addr_ipver} dst-ip {cfg.addr} dst-port {port} context {ctx_id}"
>      ntuple_id = ethtool_create(cfg, "-N", flow)
>      defer(ethtool, f"-N {cfg.ifname} delete {ntuple_id}")
>  

