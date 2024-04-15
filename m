Return-Path: <linux-kselftest+bounces-7945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343A88A4A5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 10:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4AEB2598C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A136AF5;
	Mon, 15 Apr 2024 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba2uALYD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49113A1C4;
	Mon, 15 Apr 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169747; cv=none; b=XR8/XgRZUv7QyRvz2lcpe+UljTLizRtEkvBBpaQ1PcMdc3o3q1lZuwQfN+Ju0nf9aIQ65kJHvfbLoP5KsFhGBV5jUXNIahWSozSgMK19rSduEsBcJRxTsaO08Sb6xB+ho+9vfZxgC1ADRIYqOlZVX4NRN7gtcsMuqpbfRb1yfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169747; c=relaxed/simple;
	bh=9cXWdhwC67L+YkDlq/QMU8TBe8DOVvU+n0DtcSKoJNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQwWzerM0QCL6y+vm2bOrFwDK+n0fN0wcSfjixWMrxT1UMaZ7CTsYeI7Ja/Y+XoaQtydmhZrLtMadxUIWXpV7Bci1HUPHmviGgk4XIO/MRuYelZZtPZehtFuzBbXkKAxHp7IdIrizMhJnegMeDIDLYm5YciGWzAFaPjlHxuiCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba2uALYD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso1813134a91.1;
        Mon, 15 Apr 2024 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713169745; x=1713774545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hP+2QX/H0ZueJKSjWMUb9vhDF5EfBcSMN9YfrSR6mlA=;
        b=Ba2uALYD7zKk9nj7lG5kSCUKYLhH0RFk575gmtVOLMQIw0k12l23Vyf6zQ2rYNDqpO
         ssLjtf+/yj52njNOEkAsK1kOBwXbzvtkvq1k6FHUYPWNA+Q1BmMHGV32Xg0nBymB/KKi
         hziizBQ2g2AqkKAru6Bq0yyJpfG/BoTZEGuDl5gL8OL5dqHpkWCW2x0oVZgEXApGb46W
         UGp2Oe2XWSSb5hlbjFSew/mv1S2mo7jBISOvQs0Td51Hs7PBWGiJduxBPkAitBlGfnpu
         vnHrNUg0kxb9Av+pisH21IOidzieohvA4gz2rgjAVH4SiWtF1TQa9GwyFefr0AzvnfzH
         Eqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169745; x=1713774545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP+2QX/H0ZueJKSjWMUb9vhDF5EfBcSMN9YfrSR6mlA=;
        b=FvOh0p3dD9r78iyNturqr6F2TgacxRAdYEeok3unDcp2e2YfblfRfCJTgMEN45pLGp
         hg/3AECeYyeX1z64dq4ttMcLMtMDRBV6m06B5X8QVPy0jFcuNKWfiOBR7mVXGXbQAAQ7
         LFdZ5dfUERAhjYZNArhQVE3ZJH/5yMrQRYrSeLJFVx11O0fsWGj33OWFTtYHWHyrrp4e
         BQ7rYvzXdLyY8O8A6PLT/GD2xCIcGPeOXFnM6UGYN9klwbNpBgiGvUiks+Nlbu+CrsCK
         mAqkRgSKxEPq70J1CJf0T+SUObCGJTTsYlzD2QIcSsan9JBgPpW41Ye7liFMW1W4oINp
         EaqA==
X-Forwarded-Encrypted: i=1; AJvYcCUwC4RGNnjdxH6nXuRIuk7t9Erqh7eW4cC5BUoDhqO9MJtyWalXsbC/p6MJWUT4bm5u9TaCsTaPuiLdQNZqJO2Io5aprqp4UfhUr/0c6SZg0m4JBBrfSZS9D1+Iy7HkGpd9gDnLQinS
X-Gm-Message-State: AOJu0YxzEul8S68/qNiRf6C79r1Ubpw5PYwaJFQj/TbglSUF6MpoYjSt
	Q73W++6xczpaET0U17rgfKLioj9vxixdgDDsPG1U9vRYHZDwvPJV
X-Google-Smtp-Source: AGHT+IFmgleNeb8MP80jT48gXePVg0xAG1PVFkhlBn5+teiBdtYC/zS+4yXKcG0kc10Z5JS5cm+/Gg==
X-Received: by 2002:a17:90a:51a6:b0:2a2:faf4:71da with SMTP id u35-20020a17090a51a600b002a2faf471damr16204856pjh.10.1713169745013;
        Mon, 15 Apr 2024 01:29:05 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090ab88500b0029ffcf1df72sm8144313pjr.38.2024.04.15.01.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:29:04 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:28:59 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH net-next 08/10] selftests: forwarding: router_mpath_nh:
 Add a diagram
Message-ID: <ZhzlS1htaCaAWGmv@Laptop-X1>
References: <cover.1712940759.git.petrm@nvidia.com>
 <2f82d982bf2a7c23dbd8ae63e94c3655ce9f92c8.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f82d982bf2a7c23dbd8ae63e94c3655ce9f92c8.1712940759.git.petrm@nvidia.com>

On Fri, Apr 12, 2024 at 07:03:11PM +0200, Petr Machata wrote:
> This test lacks a topology diagram, making the setup not obvious.
> Add one.
> 
> Cc: David Ahern <dsahern@gmail.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../net/forwarding/router_mpath_nh.sh         | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> index 3f0f5dc95542..2ba44247c60a 100755
> --- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> +++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
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

