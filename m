Return-Path: <linux-kselftest+bounces-7946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054CA8A4A60
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 10:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01391F22CA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1C937707;
	Mon, 15 Apr 2024 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPsUmEr9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA52574D;
	Mon, 15 Apr 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169909; cv=none; b=cXxrL7AhTUWy+ZJyMY3U4MReS9kqWI1+lJ0ERtXjLlYFGkny8JM9ZanzMQrkhs5K7EfyG0xiqrI3yYAAf0bFUmyjf3RuTAF3aVhY9yihR13i603acWL/1V/D6hATblXkQu385LLqR0MMmG7vdAmVbA64N9wxXMRcjEg4IceUtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169909; c=relaxed/simple;
	bh=aAYDM0iwMQ7dd+CPBUfJvLCaSlxetUNb1D1kqK275S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXLU5vNU7h7mJCKKJdY986bQlc/WrbgYS5pLan1AGCVmh3lGOgMRm2YyFk5Cd7IVhKuIYJOF0zIjjQdegUKUWsN2qZ6JLYdi8isKro+2KYvVNmgWUcX/k0ARTiyitfpZcIt9nV/9FNdpJodX/XO6ypE9qgwXDIrJI8L8fTqWAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPsUmEr9; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6eb6b9e1808so571690a34.3;
        Mon, 15 Apr 2024 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713169907; x=1713774707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/CXSvWWc6OWJUE3YYXkuiQ5tggmIa/LVhvP9cEOR8Q=;
        b=DPsUmEr9FjXkR7RyUK6OFEkCSk/kqSFCsyvmMtJrvCUuFKQ0z0nljGCpTYnSrdX/cn
         6tIDLwye67rrdPYJYsnic/LfkFXXHAklJK/fWVUsph0iakaw6JTbK5DwC4o/HuxcSgJT
         Oo9UgLZDJUQ2wNAqSc3+IQLmuaJIgRJBWjdKtK+hRaj885lPmlx/HdG+ET8em8jHzc+R
         DkJ17VcolDfkg9LeXAqcVDM0zb6kz4P3Q5VHUIXdknjtruACWd9m46f2AgvTxDGsbdnd
         qw7lvqYhPMpMuRMlOOusyW2nOkneI9G5tMrn+KxxEQLaS20GLhxs78wkQsgSS0WzGFAK
         Zwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713169907; x=1713774707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/CXSvWWc6OWJUE3YYXkuiQ5tggmIa/LVhvP9cEOR8Q=;
        b=RfPbXjzJ0x1LAbUgsU/mFMcsS3WihxLrHbO3btnvu7Qou9AjLaNOxgG6BPe5GOTU0V
         SsEsH9UNPP9CwfG0rehUw1Lt+53fV1eELVJohQxKqbbr3ZvsO19lHdY9mK+x3AKNvSVF
         p/ucHXhCpemlCi5Fe3y3H4E0FU4hBkinktQ9iaznDYUesffGn1G1VlW2/n95Ky3+kkc2
         SPDM7pZLsIcvf/hKlQMm3LjCgVpBztoSeuj3lgG4ikXUpThOKaeK12jXPDJ3OGPnzwBf
         6fr0pR3FmKwhw1l1iaQwwqXow/fy5gWZSdIbjye+6Lzpf9Tckxw4v1Gymsh+AjjX8Zt2
         UxAg==
X-Forwarded-Encrypted: i=1; AJvYcCUaBzAJE5W8Hv5F7NN6tSdyZajVKiur+rI6vk76K2ymm4wIxT2TMfCyUDzXDEdoDEkY+kkuUGS1+IzlfyLgMp0hJEaV+kpOrKOWrQa4D/SB2o8TmG8ImO27fIws7OBitimnnAYLVPSj
X-Gm-Message-State: AOJu0YxA6WcriAYs/H2SiBe2ZteX6CTcg6twfVyuqj/Krjg09YtgYPnc
	XcgPxWa7krSOwgAZl0yYhFmDYnht3uiXd6ZB+jQik3GQkRRHeWj4
X-Google-Smtp-Source: AGHT+IEd0N39PkwMKMj8kCWStnbK/A1uUHCZ2dtPCHpzv20pAN4cHhKQfOxem9M4EiI68ZBya9LnhQ==
X-Received: by 2002:a9d:4d89:0:b0:6eb:7cc9:93c3 with SMTP id u9-20020a9d4d89000000b006eb7cc993c3mr3286244otk.0.1713169907256;
        Mon, 15 Apr 2024 01:31:47 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f17-20020a63dc51000000b005f750c31cf4sm3363485pgj.32.2024.04.15.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:31:46 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:31:42 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 10/10] selftests: forwarding: router_nh: Add a
 diagram
Message-ID: <Zhzl7q3SwtPYoTHw@Laptop-X1>
References: <cover.1712940759.git.petrm@nvidia.com>
 <ec60c64b682c307d8db9c9cb1f35d6e43bebd1e5.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec60c64b682c307d8db9c9cb1f35d6e43bebd1e5.1712940759.git.petrm@nvidia.com>

On Fri, Apr 12, 2024 at 07:03:13PM +0200, Petr Machata wrote:
> This test lacks a topology diagram, making the setup not obvious.
> Add one.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  .../testing/selftests/net/forwarding/router_nh.sh  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/router_nh.sh b/tools/testing/selftests/net/forwarding/router_nh.sh
> index f3a53738bdcc..92904b01eae9 100755
> --- a/tools/testing/selftests/net/forwarding/router_nh.sh
> +++ b/tools/testing/selftests/net/forwarding/router_nh.sh
> @@ -1,6 +1,20 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  
> +# +-------------------------+  +-------------------------+
> +# | H1                      |  |                      H2 |
> +# |               $h1 +     |  |               $h2 +     |
> +# |      192.0.2.2/24 |     |  |   198.51.100.2/24 |     |
> +# |  2001:db8:1::2/64 |     |  |  2001:db8:2::2/64 |     |
> +# +-------------------|-----+  +-------------------|-----+
> +#                     |                            |
> +# +-------------------|----------------------------|-----+
> +# | R1                |                            |     |
> +# |              $rp1 +                       $rp2 +     |
> +# |      192.0.2.1/24              198.51.100.1/24       |
> +# |  2001:db8:1::1/64             2001:db8:2::1/64       |
> +# +------------------------------------------------------+
> +
>  ALL_TESTS="
>  	ping_ipv4
>  	ping_ipv6
> -- 
> 2.43.0
> 
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

