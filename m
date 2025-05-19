Return-Path: <linux-kselftest+bounces-33332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEFCABC297
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CEB189E27B
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08876286401;
	Mon, 19 May 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftXOqf5Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76993283FCC;
	Mon, 19 May 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669027; cv=none; b=TV2HOPHKpsdM9dZlqYDAPTnX1c+idgyfrYfBynUhGFT+poKwaLDG4xRQ5poFhgYzbcxhLs+g+edS+bRoLDSbbGjWMn5HghAwkqyXjTv1OdwBhIhAQKgA9Hdxn+MTNZIYn9nxC1FlpOaeIr0q4VrtseXIm2tKzB97fCwoXQTAsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669027; c=relaxed/simple;
	bh=Ilb4lq86RBSxeLpmi8ys4nunT8txXiUCKOtDnUyJGts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g79Dydy68BDjbZwBwgwyWiyaL4OFJ+E0XQJHQTI9dyh7eqUvE+ygM8FxjwVzL+3sz9vRDap2HGznNKtG1h6XVbuQYoicXCMdpxQtNaGHgNbsXJmnyioCG6U4Z5ELz76ItjyiWoCxQ3sXAmAxX00ifwvm5vP4dFAPMb1odjzE/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftXOqf5Z; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e16234307so42689415ad.0;
        Mon, 19 May 2025 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747669026; x=1748273826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4K7gl644JNHq1VrcK0z0b35IPZS7/i8H6VNuyxjmNUw=;
        b=ftXOqf5ZFEqIJjwzc6hcfYRek7HKUtJesT5N9iLTj54Fuodv/oxyI729q7Ih9ok20j
         eJMoFMM8t2okqKZ7J4j54gUEQWVViMt1EP3wFu89uvArImXui0tTI6BrwgT4Yl7VN9vc
         5TZ0d5WOz8zPsY4QqIdnvQ721UAtb3YyTlJzvQu4RBNJ+vUt69l0QOmq3a8lZtPLJ1NT
         k7swr6hb53yZEGyKrQbTjMD41cwEcnrC9SvhZnBsyDSnfZKd/l1inG39dtYeVRxgGIrd
         5cpGLmp1eJ+w9X5Aj8flm9zYfqZy4hcJgVuRRt2hkQ9Fq0uWSLA6waLe3oFzXevoGxan
         yhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747669026; x=1748273826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K7gl644JNHq1VrcK0z0b35IPZS7/i8H6VNuyxjmNUw=;
        b=o7U9CMN8nt9zWaoqlEh3gY9zkFjc0SWLloL+D5EfXrxCpKAoIDJ18FbfuqJMSnCJVi
         E/mHcLpv16MrZcDbcG9+tCIw6Botb56/6NSD7Cfe0LqHyTLFci31FtaONIJoLhLNj3J3
         wsHDHevKkNBpPby3XMAdQovrz8HAvawKveIMgKIwuQh1VVD91SA74n77e18aEs6DcUHB
         cv2ZPF/Dwr6qhPsFfuAHnz5Gx1IkEkDqyuHdcuXBD41F0c5HN5ErHBiy3JhvybBEQpYp
         6HsdXDgoQVjqYUnMJyTR/ukjdkMFWzJBdJgOUi6wPBS9Wvt0Z7e5NnzaSonGkYxptvl7
         JUDw==
X-Forwarded-Encrypted: i=1; AJvYcCVDdh9MbiECPOWWkNeWbjuy+xLfazfxXyZDHe15N0Ue0p+swHPzGbZRX+7HYD/wDaDnWBvVGpHJnb0nX2s=@vger.kernel.org, AJvYcCXhkX3evGtrNHHT6rX4gJD3U7F27t3iHfvoW5uU4TAiTF1cxFjO3PWmPVdcmfWk5Urowc0CwUyUKiLMGLoYUfqk@vger.kernel.org
X-Gm-Message-State: AOJu0YxUmTzbShvcnOv3qlNAlrs1L5izAakGSKQcXeHAeMJnUG8Cdv1Q
	T3fsBh04yQvrKkE5uG/LCK8KsJeQhT5e6P3W8vCPZYC5wpUde5VUHEE=
X-Gm-Gg: ASbGncsn7bBJdQfk9IB5ml/yyyXMrxxHW9bfJeagtT9/IznhhC167tFOO0pH9feSkj+
	tTSQ3uOZm+RInA7vXAIQRezWmLZSzZI0tXGt8RmK7o9vECqGUjizZ/qoamJ0Em+meh3Bf5TuR9S
	kFHdRTBsROZuxMIFgxLp2ZVZzWRc0f+BoFt3T2y6+Y62OX1z7/PDkvc9mzg430KMd5i5yoLbEcL
	QcvWT3dsb7DTw++1ueBySfUp6v8YaaeqePAGLTLmYtzGXxY98wNW9v++6D9bS1RK41DNOgoFTyC
	lwwCoPgn3oMcbq7N4yM99Fd0RHICCkphMDj4tDqOxMNqrAB/BmLmOb4rZsTKO9oQuKeVL+QlkIL
	oUySrZjlpSXUm
X-Google-Smtp-Source: AGHT+IFhnMri08isI6YZJWcNoRFLe/GbnBv3EM45BpaV3Bx9jrXsw4IWzXBwHJhsJvAg98J8vFRoQw==
X-Received: by 2002:a17:903:22d2:b0:215:a56f:1e50 with SMTP id d9443c01a7336-231d4b0d49fmr193511565ad.8.1747669025575;
        Mon, 19 May 2025 08:37:05 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231e26d8395sm57951365ad.5.2025.05.19.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 08:37:05 -0700 (PDT)
Date: Mon, 19 May 2025 08:37:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	sdf@fomichev.me, ap420073@gmail.com, praan@google.com,
	shivajikant@google.com
Subject: Re: [PATCH net-next v1 7/9] net: devmem: ksft: add 5 tuple FS support
Message-ID: <aCtQIK-vFm6j6o9w@mini-arch>
References: <20250519023517.4062941-1-almasrymina@google.com>
 <20250519023517.4062941-8-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519023517.4062941-8-almasrymina@google.com>

On 05/19, Mina Almasry wrote:
> ncdevmem supports drivers that are limited to either 3-tuple or 5-tuple
> FS support, but the ksft is currently 3-tuple only. Support drivers that
> have 5-tuple FS supported by adding a ksft arg.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  .../testing/selftests/drivers/net/hw/devmem.py  | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index 39b5241463aa..40fe5b525d51 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -21,14 +21,27 @@ def require_devmem(cfg):
>  def check_rx(cfg, ipver) -> None:
>      require_devmem(cfg)
>  
> +    fs_5_tuple = False
> +    if "FLOW_STEERING_5_TUPLE" in cfg.env:
> +        fs_5_tuple = cfg.env["FLOW_STEERING_5_TUPLE"]

I wonder if we can transparently handle it in ncdevmem: if -c is passed,
try installing 3-tuple rule, and if it fails, try 5-tuple one. This
should work without any user input / extra environment variable.

>      addr = cfg.addr_v[ipver]
> +    remote_addr = cfg.remote_addr_v[ipver]
> +    port = rand_port()
> +
>      if ipver == "6":
>          addr = "[" + addr + "]"
> +        remote_addr = "[" + remote_addr + "]"
>  
>      socat = f"socat -u - TCP{ipver}:{addr}:{port}"
>  
> -    port = rand_port()
> -    listen_cmd = f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.addr_v['6']} -p {port}"
> +    if fs_5_tuple:
> +        socat += f",bind={remote_addr}:{port}"

This we can always do regardless of 3 or 5 tuple?

