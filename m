Return-Path: <linux-kselftest+bounces-5747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CCD86E71C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44A61C21AE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 17:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D66FC3;
	Fri,  1 Mar 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6z+M4m5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA55228;
	Fri,  1 Mar 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313841; cv=none; b=EJdUYQKhJ6NIGM+EdFMVMQHn1mBQiRzAwu+y9XXG/armeD/MUB8c8kZ/zO2ZGv78KSGBu97nbYEow3cOlELq1Upnx2dsiHmImvRNqmIKJrYS6rZgbAhlyGE8TbGxycm8V5K4fvbBM+2ZuUOeRT8IT/YHy1le3C/YCm7OUy8hji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313841; c=relaxed/simple;
	bh=veI8B19i8DnVTq/s4obgrpoRoZCjKRQ6AAnu47Af2jM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YSc775p0Jrbz7c0FrdoE/WkIBNO08wv6xIOP5sP+4uvzUOxlv1+/jJoGoJJPOGjwaYmz+afPBsNMSYyYwYzr7yRSaS2zC/oc2jHrwS2HlnkT+xq9zvssSFEHlwKdp/ef1ja+MOPQWZRSIvyU7TKkOHo1R+UO2vq4bBGQ6HW0VXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6z+M4m5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2017511a12.1;
        Fri, 01 Mar 2024 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313839; x=1709918639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyyU1KTZ+u7IZU/ZLxa5MUX+oMEqsxDrKnYwc61Y+0Q=;
        b=i6z+M4m5cSR+ppHq/yUnHAD1HIe+gJ2UogR1BQ9tffF2aXnrazIW7uGKQ278dBq6Jg
         w9iSZw75EoTF3CfnEjzbLq5t6sFq7KnTzitgwTWW7zJrM7NFL8TcOeT2R7/b6N0hXCDX
         bnpuS13gRqBfCw++y5mkmEiBcB1jYndmT7T+Dkut1FGoENgliKmHZSDbWWC9pknsf4K+
         HlzAFkueXyZYA4TLKtmWCixGi3BsZpT5+V5njCW3GB+zFd3dXBGvnxYmAc+GubGvEDGF
         Rx+IzCqeTtt/L7/0uBgiWSqcOfsU8kRj6SW2F4BV2ZTNnAiUL4JqO4WS/N2tktBx0LJA
         /8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313839; x=1709918639;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RyyU1KTZ+u7IZU/ZLxa5MUX+oMEqsxDrKnYwc61Y+0Q=;
        b=MAnrRG2+9zUx+ywPGEbM7HBiDsA932WaFo3fH0K/Sdn8YNMl/QGPrfjKsoh25vIIQA
         3g3qLfaB9eVr5xjN7Z0MEcJDz+GzdgKghE6C8qYD5lizWDBEeo53rgyZsbB9y1H9THSH
         jGShDiomx/8jyZPW0sdtrySvxmqF3gpo9lWt6Ea7ctM5+ZNB7Ns3p1IFSG+EayHYZLCH
         viJKI8wLcPBEggP5iXJoSOSsm6ieYT6jXAW2QKHIGVk3rOVPfJJ2gEkCrJMxxPPi0ghY
         HJL4IsSIP4mZHY0KD9UpXmCHzVWnRd4sLSD0JF7YIWFCWe3MwOVqZNP2e2F/ih/EZUGT
         JqgA==
X-Forwarded-Encrypted: i=1; AJvYcCWsS5DiDs/lvgW4c2LPW8HgaR4mzK1tlB4Z37tH7I5BeAuYOpkgLMZ68Xa7w6Bxz8EGxI68+mhHVijaSgoE+kg8ZvjJlo5/KezawURllS6bouR+JIKtGEwRnlvDT2HDiRoxzOb5DZrV0gX6DF33caW1h02rYAlPXR89aTP3wHg30QRs66ePOPqe0gIjK3JzMihw/ES9JcTI+b/r
X-Gm-Message-State: AOJu0YysFAEdQ7JDNIMmpYMCp5hZBs++rj2eTG8YiGJDr73TWQYYy1qM
	l5Mg8pIHkMDyUo/0zC9ZfS8utN8Kn2yh9R85XHRfilohHAZqSoRw
X-Google-Smtp-Source: AGHT+IERqxQxkRkE14VITG6EjQITNnYMzffw4XzcbvyQqW4Wc7ZerAs9c1302bg9Ijqngdcp3rSclw==
X-Received: by 2002:a05:6a20:4283:b0:1a0:e3c6:18da with SMTP id o3-20020a056a20428300b001a0e3c618damr2372160pzj.27.1709313839390;
        Fri, 01 Mar 2024 09:23:59 -0800 (PST)
Received: from localhost ([98.97.43.160])
        by smtp.gmail.com with ESMTPSA id i37-20020a635865000000b005dc5289c4edsm3219408pgm.64.2024.03.01.09.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:23:58 -0800 (PST)
Date: Fri, 01 Mar 2024 09:23:57 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>, 
 Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@google.com>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 xdp-hints@xdp-project.net
Message-ID: <65e20f2d314bd_5dcfe20857@john.notmuch>
In-Reply-To: <20240301162348.898619-2-yoong.siang.song@intel.com>
References: <20240301162348.898619-1-yoong.siang.song@intel.com>
 <20240301162348.898619-2-yoong.siang.song@intel.com>
Subject: RE: [PATCH iwl-next,v2 1/2] selftests/bpf: xdp_hw_metadata reduce
 sleep interval
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Song Yoong Siang wrote:
> In current ping-pong design, xdp_hw_metadata will wait until the packet
> transmition completely done, then only start to receive the next packet.
> 
> The current sleep interval is 10ms, which is unnecessary large. Typically,
> a NIC does not need such a long time to transmit a packet. Furthermore,
> during this 10ms sleep time, the app is unable to receive incoming packets.
> 
> Therefore, this commit reduce sleep interval to 10us, so that
> xdp_hw_metadata able to support periodic packets with shorter interval.
> 10us * 500 = 5ms should be enough for packet transmission and status
> retrival.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 878d68db0325..bdf5d8180067 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -480,7 +480,7 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
>  					for (int j = 0; j < 500; j++) {
>  						if (complete_tx(xsk, clock_id))
>  							break;
> -						usleep(10*1000);
> +						usleep(10);
>  					}
>  				}
>  			}
> -- 
> 2.34.1
> 

Acked-by: John Fastabend <john.fastabend@gmail.com>

