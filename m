Return-Path: <linux-kselftest+bounces-7947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E708A4A62
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 10:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260E21C222B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E612C37707;
	Mon, 15 Apr 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWRup/SG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9230A2868D;
	Mon, 15 Apr 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169919; cv=none; b=pbgyeoxSdNrQfojpioFoxn1mreAnSBs6XTIb6O6jxvGbpE/GwgyC0Tf504vZeRHekuj5cJ7w5PoeRUFmROphFsgqXqQI21xvAKOV3QfO3c9UTobRHcWZope6zlKD3zq+xfWnXBFoI2urjQmyUcudc6fLHT9fLYxsOYEzxv/FnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169919; c=relaxed/simple;
	bh=4Ik2Ko1zBi6l+eZz8A/Ik9o0FLr9nF6jobrAJvLC0Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdD90bQXv+jvZkqkSLtiqMvOUE8u0GIxayOw4SC3l06wfxdqVDw6wH0H35hoS9pitUw1wf6FxLfJ83e1jHypALCGWvbQQfRUH483CXpYAcIbKJVSjeiV2JjqU7wyz2D3osC1uzhkMNETvhIqBK76LOm1wijCKLrU8BWGO/iUWAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWRup/SG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecec796323so3106173b3a.3;
        Mon, 15 Apr 2024 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713169918; x=1713774718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rV5r33AzK19B4yToz4RMwSjQuySmQzfJ9nUG6alLpRo=;
        b=BWRup/SGuhgQJIe81o0SjCYVXAxDSbqoHyYsW5+tr19PXVtXfaWRQRMLXrFivGpQ5q
         ifd3G5pmuuxsqV6kX5dax4KbIISh2hGzmRbf7Cg56tQEn2gjW31Tbu5qkklUuCstgqIF
         tnUWY4vRLMjKM1J2WxJ/MKi174YjWhieBGF0Uq6cgOxJclTv9XKXZr+vP8ULbM2rxMyl
         f1qlHvZ/HSXEuK9uakzA5sueJP2P1ayjfQdOcG31VLLnPwjQ7ZrsbXE9hstj4YhdcMPh
         3LWGF9QVLqbpgn0jVLE6OS7r2say4wWbGPuIEl6X5XUU9j6qFZ+bUS0biYpnFqtx964w
         3yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169918; x=1713774718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV5r33AzK19B4yToz4RMwSjQuySmQzfJ9nUG6alLpRo=;
        b=OFH8O4EyryF3wcnuk+iV6bUXqwQXgF1CbX6lVj6PWHFBZNtP2whcB/ndOie7z1T00O
         /o8Jo0F9mVhiMNeLxorE1ENvm368q6CG7y0yQQvK2fL1l6QbL/IdPyCgtQzr+ZH7nLly
         1jOE0B5vmfbrdC3iSr6bsMswV5wyTBCiJDJzgSYBlj5z/Dl1kGKtrBCn0HkhOPRulols
         PczPIOQKxoqUYoQ4+RmEPk4c8AYL2xATsU4w1G0ZGMjYDNlZq4sWeHc8e+4M0VW0eO7l
         C3QyScRtujyfw0bog/4M9+POBD+CpIKMWXTQdzpwCGg98dKSed/wia/8jEvy6FTxBuev
         AG7g==
X-Forwarded-Encrypted: i=1; AJvYcCUW8Lj7VSfmKoQ9rnX4lYRtgBvG5IPnUwvY8xfSYpBob9A7znT6MzoQR/qOg23daz9GM4NAaKaRHsEOricdurETGyCH/38BNEazxSiSYCqF3cCyTfU+byPV23IDSvFIAQK/9pNw8Zr+
X-Gm-Message-State: AOJu0YzZzFjjgIo1CxpYCP/gACdZ68T+r3lFME9QTu6STxOtcj3/vIk6
	k/1BdNYNs1/UMgAcTAMQLtqK04ZgnAue8FscIVBViDc6d6I2YRDG
X-Google-Smtp-Source: AGHT+IEJoDoKUh2VyN+Orxdp9uNfZAd0UfuULXqu898lDIsZPXg9eBwYs+eyLou/T2WaehxbCJtnww==
X-Received: by 2002:a05:6a00:a8c:b0:6ec:f28b:659f with SMTP id b12-20020a056a000a8c00b006ecf28b659fmr12049252pfl.3.1713169917830;
        Mon, 15 Apr 2024 01:31:57 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b006ecf76df20csm6740839pfh.158.2024.04.15.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:31:57 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:31:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 09/10] selftests: forwarding:
 router_mpath_nh_res: Add a diagram
Message-ID: <Zhzl-NuWNtNJZIcN@Laptop-X1>
References: <cover.1712940759.git.petrm@nvidia.com>
 <1a34016962a2678462c656516ad90d4c0b7ae258.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a34016962a2678462c656516ad90d4c0b7ae258.1712940759.git.petrm@nvidia.com>

On Fri, Apr 12, 2024 at 07:03:12PM +0200, Petr Machata wrote:
> This test lacks a topology diagram, making the setup not obvious.
> Add one.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../net/forwarding/router_mpath_nh_res.sh     | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> index 4b483d24ad00..cd9e346436fc 100755
> --- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> +++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> @@ -1,6 +1,41 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> +# +-------------------------+
> +# |  H1                     |
> +# |               $h1 +     |
> +# |      192.0.2.2/24 |     |
> +# |  2001:db8:1::2/64 |     |
> +# +-------------------|-----+
> +#                     |
> +# +-------------------|----------------------+
> +# |                   |                   R1 |
> +# |             $rp11 +                      |
> +# |      192.0.2.1/24                        |
> +# |  2001:db8:1::1/64                        |
> +# |                                          |
> +# |  + $rp12              + $rp13            |
> +# |  | 169.254.2.12/24    | 169.254.3.13/24  |
> +# |  | fe80:2::12/64      | fe80:3::13/64    |
> +# +--|--------------------|------------------+
> +#    |                    |
> +# +--|--------------------|------------------+
> +# |  + $rp22              + $rp23            |
> +# |    169.254.2.22/24      169.254.3.23/24  |
> +# |    fe80:2::22/64        fe80:3::23/64    |
> +# |                                          |
> +# |             $rp21 +                      |
> +# |   198.51.100.1/24 |                      |
> +# |  2001:db8:2::1/64 |                   R2 |
> +# +-------------------|----------------------+
> +#                     |
> +# +-------------------|-----+
> +# |                   |     |
> +# |               $h2 +     |
> +# |   198.51.100.2/24       |
> +# |  2001:db8:2::2/64    H2 |
> +# +-------------------------+
> +
>  ALL_TESTS="
>  	ping_ipv4
>  	ping_ipv6
> -- 
> 2.43.0
> 
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

