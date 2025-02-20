Return-Path: <linux-kselftest+bounces-27108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C86EA3E576
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11975163B5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E6C2641F1;
	Thu, 20 Feb 2025 20:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km2V4IiK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE421480E;
	Thu, 20 Feb 2025 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081698; cv=none; b=Yz2iCvidgkSL2EkYWgt+K7Pf/MP79OfVAWVH15rhj0fYhyQ6/Cbo5PZCZcLb2MpiO2VEKe8S2ggu0EtGpjXyOv2ooqi8qR0tHOzslszlGyrZm405f0AxtJe2dtm13Bm5i7FL+nlu5P8SUh4U8FCRYiPkO/cUKWfYlr3vPhdiwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081698; c=relaxed/simple;
	bh=GXCL6RSUSvS7HAMVCHd+mRQklIK6uRVePTBP+wR/0W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/f/rmjp278LRNGJeB9SRVUuIAF6g7Yickb01Qn/KZj5anwN3vMmGhIzbeoFloG97gXm5m/C+yzjhCYA8YYoRDJ2CQaswixR05tVMvv2dk+TzfiWMOL0k3/zfAW8MNcaeXCwcYnWxZ17d0QfDUm8dN4UoEkajH+fNpJD/KjKq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km2V4IiK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2212a930001so36278175ad.0;
        Thu, 20 Feb 2025 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740081696; x=1740686496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXVAzd9z1Xkj/FF5pL9lHEU7EIbxtObnzcYt42L9wXI=;
        b=Km2V4IiKN+8oyygJqnvSkXYk6PSpLi5nQISnNQXbmt4pDA75m2Bglpb7RgqVIiZmey
         uqHdyrHCO+UM5M+7cn3OGdpseZDSdq1Kl8s6YiX1eLi/S1biySxPGs82ho2HBc9i/cp4
         tzVSBgu/4bmmy+99leS1bOZMl2Mva84g7CzYLjJ28+UN7l6wDibyrfxcc8KJ1CnZ0rLC
         rj7UBUxRytZN7QJamk6jTLhjaLXCN6NlABSm8G0Vgbe7CfBS+U+ZP4Kxt494sUTdfHYT
         V5PcdrPDb1QXDiNLA+sI1wJBZ2xCs9a+LUd+zDDZ3Sg8wuUFP5opxeTooLqk6DV+6bwz
         +C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740081696; x=1740686496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXVAzd9z1Xkj/FF5pL9lHEU7EIbxtObnzcYt42L9wXI=;
        b=ggrwfkFScaJLZZfM7Dred98mMpjioxWQxMYUWCnmdNg+AO/Zz4bWZkVb7IryKTw3cP
         W8dud0r1InXw8EYPVUwOaY7A+ZPSg39AK/joAh/x6xyaNvKJcY/i8YOxBZh89kCkh4K9
         z8BEkDRxgYu+Cg5WAbUoiIh9j6WMVNmPUOHkjnZkOpTmE4lBCApnjX8jBo3PUMDKs2ZA
         677cpaywm5z/xDeRWRcY95c4futfuJ07H7w/w0p4LSKKcQ2ZLw87ImjPXYp9tEMZyGvD
         CrkP40I47taiifAjMAno66sYhteqVRvieKQ8pwGRGJjHc9CV39pmqTzvbEKc1CVVRfT8
         scEA==
X-Forwarded-Encrypted: i=1; AJvYcCUrLyze1fS/90yu041bopIDQGnlojVUarAnxKyACb4T/sBfswg98L5GdhQJMZJcpywM3FY=@vger.kernel.org, AJvYcCVv3Aqlec0QOUXlTGdjgcTBREoSpvWeHhCMENi+1jNySCBQ8N+b1J/o9Zn+h5BNAVxQ7WM9J+CAyRHq@vger.kernel.org, AJvYcCWTyVP8hVrPJ92AadN8Ni619TXPtJir+pNAo2px/eZwJhIPr5EXc1ijAjRZSUlzkNKaAZ99zhF4fq0FaMkBTFez@vger.kernel.org, AJvYcCX+STVJ1nC7yjgI88iNsxmu0u8MLZ89M8qGelwEwQO5MpC3XpmCntaH9AqFqT0U5GnFTpDuHY+NfLeP4pu0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6nnRG8PBW2TiF8r1TAu/MaaE0pXlFSdecfLwwXOVAtmwEkBLP
	I0G44s2ktTo2qsinPLy68QaVgQpVSYzFm9rzIYgSo5PSl9xQPRM=
X-Gm-Gg: ASbGnctqEVUbCvKr2i8zX/mfrj4HFyIo/MKJeuU1XhJYm8wm+5gXjWMOn89e9cefeO3
	kh8HxLvXdndSE7Z/gVG3tbRnPQZU15rsPoI8UR5tRXYgqTW+p5cpUdVzKFM+/QF6vqk3lyWVGnE
	5MqQVIanUpYa8iGa1lPinU+QJjML87lBKTDXI3ln9fnsGjL5a/xiiifkEh/hrh37WO+KGEMHuD4
	9lLSoquQJJYQZyn8Xg+kYug4Ok6uSaL+Y/ErO7qiOUjpuc3fQb2hBg8pz3pY5FcLzWIsZNYEVWS
	oMk+YaswGIQ8BMU=
X-Google-Smtp-Source: AGHT+IG15zCfEBW31sU+1aRPB26CfUNNJjIKvAOSrUMtD5sMukp+5wmY0Gkb9qUidKnvxdpmpChoZA==
X-Received: by 2002:a17:902:e5c5:b0:220:cd9a:a177 with SMTP id d9443c01a7336-221a0ec33d8mr457305ad.9.1740081696137;
        Thu, 20 Feb 2025 12:01:36 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d556e15esm126564135ad.190.2025.02.20.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 12:01:35 -0800 (PST)
Date: Thu, 20 Feb 2025 12:01:34 -0800
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
Message-ID: <Z7eKHlA0rCF2Wgxb@mini-arch>
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
>  
>      with bkg(listen_cmd) as socat:
>          wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}]:{port}", host=cfg.remote, shell=True)
> +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:{port},bind={cfg.remote_v6}:{port}", host=cfg.remote, shell=True)

IPv6 address need to be wrapped into [], so has to be at least:
	socat -u - TCP6:[{cfg.v6}]:{port},bind=[{cfg.remote_v6}]:{port}

But not sure why we care here about bind address here, let the kernel
figure out the routing.

Also, seems like "bkg(listen_cmd)" needs to be "bkg(listen_cmd,
exit_wait=True)", otherwise sometimes I see racy empty result.

