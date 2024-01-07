Return-Path: <linux-kselftest+bounces-2687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683C826416
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 13:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE3D1C20ACD
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 12:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745212E75;
	Sun,  7 Jan 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0Ku7Egw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C712E6D;
	Sun,  7 Jan 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-204f50f305cso898078fac.3;
        Sun, 07 Jan 2024 04:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704631799; x=1705236599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fw6LNu+4Os2RyArnTn0kvCbw+nWEEHo4TWDigi7tfZk=;
        b=H0Ku7EgwBjhxFs9GHxH2Y38toXnmCSBYyn9R5j5agjechdBCTOFCrbzMz+YmoBm191
         xop6t4fqRYL5Yj2dVhf8OPNQb6Cfx0JyOv3gQv3nZYOiwDxnjolqkbDc6xZVKdoWuMea
         wq83dxhqkvil+hUlePS0xXGGxu3X6Uyok2Nnsh2ZqMGose5GTCcfRWz/elPpfAr6wF+F
         WJ3HXDHPBgo7EkY7JtkIeldTvzMGtNkrB+8l82Croix2GkojityoNW4QgKnCJuzmtCuL
         n+WfDDYMdoJp/QP7FaqOBrFdPBw9bXWBwmyK4kMO8DMYf5qsf2kM2wogCJVq+3TWgI/+
         lHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704631799; x=1705236599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw6LNu+4Os2RyArnTn0kvCbw+nWEEHo4TWDigi7tfZk=;
        b=NKmLUXk2McHsoe8rk5cpCn/3NfNaB0wwYO3vPj84RH4slpTgFUeZDt9i7FJGtwWY6H
         1Ma8hT0qRueDXQ+uEwteWVYd92nR79BjG/fD/LiXOZH7EqzMITHm5tLy2s9NBarciitl
         yKoFOCO5lrobhtNLWEYU4JLRtoNf0UN+9/7hGEjRv8gPQYsa5xXuVnkONeLFlIeRaQhj
         oAznF5HV15xUx8Lp3d/yAc5RnOo2XozM/Hk/VnmwjRDQLovpSXhGbfN7iRR+/ApJf4zH
         0xG6T8Vuly1V/ulOFqPA4ZU0loaTaCwbiZd2d1gk7YMHeOAIe4ALM0WURUvNKU9XO5WI
         x/yA==
X-Gm-Message-State: AOJu0YxreCgAXLkvSFN2apw9HU2QIM82HADPBBgvnJXb2PvdDZZiLsLM
	fu45DYhImjuiAHsJokkfcToQFLBYco8KIAgu
X-Google-Smtp-Source: AGHT+IExWjMjl5bhO/eiUz2V64PosSrE/WPB8weni3JzT4kna+np4EHpEd0PIMfh/kqvMGZDhxzB4g==
X-Received: by 2002:a05:6870:4150:b0:1fb:75a:6d2c with SMTP id r16-20020a056870415000b001fb075a6d2cmr3260537oad.83.1704631798705;
        Sun, 07 Jan 2024 04:49:58 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090ad30b00b0028ca92ab09asm4646551pju.56.2024.01.07.04.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 04:49:57 -0800 (PST)
Date: Sun, 7 Jan 2024 20:49:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH v1 1/1] selftests: net: increase timeout value for tests
Message-ID: <ZZqd8PqvHlYCqbMX@Laptop-X1>
References: <20240107003929.891669-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107003929.891669-1-mirsad.todorovac@alu.unizg.hr>

On Sun, Jan 07, 2024 at 01:39:29AM +0100, Mirsad Todorovac wrote:
> In particular, fcnal-test.sh timed out on slower hardware after
> some new permutations of tests were added.
> 
> This single test ran for almost an hour instead of the expected
> 25 min (1500s). 75 minutes should suffice for most systems.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
>  tools/testing/selftests/net/settings | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
> index dfc27cdc6c05..ed8418e8217a 100644
> --- a/tools/testing/selftests/net/settings
> +++ b/tools/testing/selftests/net/settings
> @@ -1 +1 @@
> -timeout=1500
> +timeout=4500
> -- 
> 2.40.1
> 

FYI, the net-next patch 779283b7770f ("selftests/net: convert fcnal-test.sh
to run it in unique namespace") has extended the timeout to 3600s.

Thanks
Hangbin

