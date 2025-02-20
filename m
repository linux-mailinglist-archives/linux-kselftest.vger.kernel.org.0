Return-Path: <linux-kselftest+bounces-27105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49EA3E4C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44587702CA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED52147F9;
	Thu, 20 Feb 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewzv8ieo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C21F4E47;
	Thu, 20 Feb 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078601; cv=none; b=k/ThvX8WqLp9NHTMT9fHwbMhnXX8plkHJ/MibhLjXAQLiaB9urWPx3QgnNRiTxf1p9wDyC26hwU/GVdyZ+N6S4zCnPrksD7Pl9lcZ1QN/OHc4HWBJzf2UtSAfzftiXCXr6Gh3mcMldNtM+x7AQnmXQzCu6+qhcAfESPo8LncJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078601; c=relaxed/simple;
	bh=mpA/MrEeSlFfQy/SUQZrdZ86KKOSDip+BWmaXv9pjDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Poli8oaH7fQ6KbUlaxC1j0V1utP++VxYvELgUrABGpux27uatG3iVXls4rWFM8M3Kjm/R5MCCvrklAuKLcFVHWY07gBoy5aR4vfLvQftvWQkyNhoHvXRZ0XnVZHB4MmQGMlAQBKq9SmCD9BJO++M0++YpxadgVNnEyiVIgmN7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewzv8ieo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220dc3831e3so38018775ad.0;
        Thu, 20 Feb 2025 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740078599; x=1740683399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQV/ZoI7XcCPA75+erkDe6R94FlXLvLV8fokf9ogYZQ=;
        b=ewzv8ieo4Vv1N1dc1o9/gFFPozRkVWRodj5+F2bKZ7mLB4htZbhVjji6njRS7xaT5l
         4m9FjQZKG5NZCLx4S+oTcPwstlJrvSyxRZtuJ0ZBP2uJwYgVm4HLetw9M+REZZVq7kpi
         lE+M0ykL4hsOpwXIDpPhYK41WM4dbYywQwkxaMmOWe6nL9Wwbc8nFEw1sfmBTq2wq337
         Mi3DNv+RIPrg2C5NiXVmShXGFGx8tHlrPsXqh+vL9TOoZFoj223XqAXqhPjR1EOkKMCA
         qZA6W1LfpS8T/jv+ELMAZcgK5iUhryE8gY8G1vSYkBXSysa+C3Lgl9beiwodoiignnjL
         KPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078599; x=1740683399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQV/ZoI7XcCPA75+erkDe6R94FlXLvLV8fokf9ogYZQ=;
        b=siIAVdnETVVJv4TzDUEsiHRMDNwrnKiRX4uU/YbW/R0wCs+wuCPcbayPBRurWPUOAn
         ZED9VS+jZ1DmOhvh3UsVJFooPajPIjI+37ZeFfAXskjIZtsE0TOh2iEx+eu0r7O6xj1b
         HdE1LiLcT0z/6RyEnieyEU4+iZqHevigujhhXKyezlayfrytrxNhnJzvuViEz7d//RPt
         ErgMeVU5Lk1hCaKyRqPPAvxiuCGmw5ZoIC+mXAUrt5qpADatLr5PEb0bNlSgIAG7/5Xy
         fEDQg7Y663mvPGDrf/5cZQbruwoASTGo024JVJFxObIig5kE2h6wiWIFh5a+3HUs4E8g
         DvJw==
X-Forwarded-Encrypted: i=1; AJvYcCUXifdeXGlbIoCYbasXfZK9XxPUrWTWJbt8TZb0WLi5O1OoGNL1B/B09ORviSY6dF163ngTP2owevfe@vger.kernel.org, AJvYcCVwwULCxjMpB/QSRVk7NFfC73V55cFe2g2QdoxWKA2cBCf0Ht1TREhSxiPE/DGq1Z22shY2yFv+i0CumdrIKFju@vger.kernel.org, AJvYcCWWJtoikBTzuoiGGNjPtjCC54VY+waLYkMN1HuLUgu5orkHqPzOSRo2MH+Zp/hOYwhSr41Gq45Rw9b65Buk@vger.kernel.org, AJvYcCX7LyTZHaf1pxd5wOY+moMR+E/E+/HFHFKBDAtd16fYW73sBFdpNCQSbBysasRMIr4tlmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCYm65llLXklFZ1zRdG5YWNMMLo5AqrR0lqKR3Q5mxzZU9D73
	Q2YlUmY82L9XghFoovfQpw50kUF1EViBt7kWFXUConEf5A1OS68=
X-Gm-Gg: ASbGncvh04sqJy2yZfLMc8ifeV8Qw73jioO49DNWPaOND/YjH4cXYOLhansApdu0o55
	1C+TjWiJi9y6JMk0zUHQ/N6p1JF39vXQ77PLGcD4cC3lBfqTvBocChhStLCgBPGJ8q/CacxeKWr
	qJ/KmikSSQeq2qoQCsc8KpAFA6t6K7MFxG7F1KmgJdWMXTx34RfvnyhauJeD+byj0x01ygmtlAk
	p96jlm5P8w5waEP/DB2XE4/FsnJPggixz+cga4rqx9F5mPOADcDQ3sfigx1dWGsV9Q8KgpAjD+c
	wwoFPhXt9E5Fflo=
X-Google-Smtp-Source: AGHT+IEvQXeZzfRjz714HfRbuoChSJiph3o3vx35z1y6/TWaF62kBH0YqfkLwI1WQdwkSFnjKYBxnA==
X-Received: by 2002:a05:6a00:8a17:b0:732:6a48:22f6 with SMTP id d2e1a72fcca58-7341410bb54mr6308200b3a.9.1740078597790;
        Thu, 20 Feb 2025 11:09:57 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7326b5ef448sm10144080b3a.173.2025.02.20.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:09:57 -0800 (PST)
Date: Thu, 20 Feb 2025 11:09:55 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH net-next v4 9/9] selftests: ncdevmem: Implement devmem
 TCP TX
Message-ID: <Z7d-A7yhzH1t8D_3@mini-arch>
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-10-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220020914.895431-10-almasrymina@google.com>

On 02/20, Mina Almasry wrote:
> Add support for devmem TX in ncdevmem.
> 
> This is a combination of the ncdevmem from the devmem TCP series RFCv1
> which included the TX path, and work by Stan to include the netlink API
> and refactored on top of his generic memory_provider support.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> ---
> 
> v4:
> - Add TX test to devmem.py (Paolo).
> 
> v3:
> - Update ncdevmem docs to run validation with RX-only and RX-with-TX.
> - Fix build warnings (Stan).
> - Make the validation expect new lines in the pattern so we can have the
>   TX path behave like netcat (Stan).
> - Change ret to errno in error() calls (Stan).
> - Handle the case where client_ip is not provided (Stan).
> - Don't assume mid is <= 2000 (Stan).
> 
> v2:
> - make errors a static variable so that we catch instances where there
>   are less than 20 errors across different buffers.
> - Fix the issue where the seed is reset to 0 instead of its starting
>   value 1.
> - Use 1000ULL instead of 1000 to guard against overflow (Willem).
> - Do not set POLLERR (Willem).
> - Update the test to use the new interface where iov_base is the
>   dmabuf_offset.
> - Update the test to send 2 iov instead of 1, so we get some test
>   coverage over sending multiple iovs at once.
> - Print the ifindex the test is using, useful for debugging issues where
>   maybe the test may fail because the ifindex of the socket is different
>   from the dmabuf binding.
> 
> ---
>  .../selftests/drivers/net/hw/devmem.py        |  28 +-
>  .../selftests/drivers/net/hw/ncdevmem.c       | 300 +++++++++++++++++-
>  2 files changed, 312 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index 1223f0f5c10c..3d4f7fc5e63f 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -1,6 +1,7 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  
> +from os import path
>  from lib.py import ksft_run, ksft_exit
>  from lib.py import ksft_eq, KsftSkipEx
>  from lib.py import NetDrvEpEnv
> @@ -10,8 +11,7 @@ from lib.py import ksft_disruptive
>  
>  def require_devmem(cfg):
>      if not hasattr(cfg, "_devmem_probed"):
> -        port = rand_port()
> -        probe_command = f"./ncdevmem -f {cfg.ifname}"
> +        probe_command = f"{cfg.bin_local} -f {cfg.ifname}"
>          cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
>          cfg._devmem_probed = True
>  
> @@ -25,18 +25,36 @@ def check_rx(cfg) -> None:
>      require_devmem(cfg)
>  
>      port = rand_port()
> -    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> +    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.v6} -p {port}"

Commit de94e8697405 ("selftests: drv-net: store addresses in dict indexed by
ipver") just went it, so v6 needs to be addr_v['6'] and remote_v6 needs
to be remote_addr_v['6'].

>  
>      with bkg(listen_cmd) as socat:
>          wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
> +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:{port},bind={cfg.remote_v6}:{port}", host=cfg.remote, shell=True)
> +

[..]

> +    ksft_eq(ncdevmem.stdout.strip(), "hello\nworld")

s/ncdevmem/socat/ (or rename socat in the with block above)

> +@ksft_disruptive
> +def check_tx(cfg) -> None:

[..]

> +    cfg.require_v6()

This is also now require_ipver("6") I think..

Gonna try to run the selftest and see if anything else pops up...

