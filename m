Return-Path: <linux-kselftest+bounces-40717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DFB42EAE
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 03:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D707C619E
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 01:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C6433C8;
	Thu,  4 Sep 2025 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIlLAeoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FD4437A;
	Thu,  4 Sep 2025 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947767; cv=none; b=hTm5IQThus9wp58QQW0gWt7YJG9klN4YzCDs5H9A5cVi7luT3Om1nE6ubxKSqwjtwZRqWEmMr5M2Jo9/ROYkxeMD0OZcPokR1WY4HNPOV3qGXLYdPIcxJVSp7hwCeRVya3pz4r0NaJyPjmy8G97SPmkrvqYCWpmD5O9N1qP9NfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947767; c=relaxed/simple;
	bh=yfrt/zDhiGVB9EhXktNjC0u/OdwEFgrsHE28cu4FGsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlFa8BocwQyo08WIZ/JUmrzE0maa+yAIj7YnSoEmBl1DXOuofBY3HxZ6yaP04U3snMNaTwxFJSrwF5tdlk20Ll1h6MCQW7s/jomm6G5Kg8ZQK5dJ9XPscTFL6QpWo0c9TznDbksRx7cwPdCM33Ue3ueJLWuf68S+cztXfNeghu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIlLAeoZ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso328997a12.3;
        Wed, 03 Sep 2025 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756947765; x=1757552565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJBbEVpiHhGAAAzjqJbgBv5NzpKL1kkAvvdQqE+g36Q=;
        b=lIlLAeoZoM8twDyImmPSEnzUUhEvU38+yqv9jDnBd/PlWxDg9v1CfVi9VH+PLFBmWy
         AHE3VP4ZTOT1d5ckorAgubrddhZKg9OV+Fs2eMMPls+RAUFunlk1rQQOlWNdU+KrhQke
         MUGfVj4y+kyvTYevtJjEu+RI0GgV0yu0i0po5mQ1dCISpQemQi5N+D1n/+NxrjVFzW8x
         VYrnDS69zzfsgtrg8tK8BP5XND+vj2eFssaB1aOcHsoCNTyvJ56DK1L3hWibKo4DTa53
         mawH4J3bS4YZPIaWAPdQj1aTt4as5X5sfPGqQSuSs8IhFYrIMu2CT3WdMvOMYDuH+MPs
         UtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756947765; x=1757552565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJBbEVpiHhGAAAzjqJbgBv5NzpKL1kkAvvdQqE+g36Q=;
        b=IKQAoc0gE9gtb3r3IkLwRSv2edlmA5OV9W9a3Qc7bBUOd3V6LBD4ayfcQGw6yQdzE9
         sYWskglqsPZZGfuLhWqFtJERKpX/2koSs2tUUXiRUtU1yInin0O0jsuyuXMTJjkH8KxG
         ccmCSjjLA4drp/cWF6Wf00d6bs05KfYweKJY0EzlgNTV3oLwHi3HqBk5y7D5a3XPPH99
         0849cXQNj8Xb3eLZ52c69MoqNk2gv9IqduaQgQ0hpXLcq7nqssc87MAmSphHYswJDDtO
         NdvkC+4g3PWeapSdFN4asAyfAjquRha4rvvdBxMEiAy1UvRqZImQSvKVJ4TbEEEDzkDa
         2+Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWvuTo6Ltyn4673v3QZfYV0OPzbpyln9NWK/PSO9R8qiQlXhV9WvjyIOkuuQChGdUqi6Dy9Jls3@vger.kernel.org, AJvYcCXX2E3K7jNj/uUzH9GkKsfudDwwNfNB2IuNkbKWiBQnb4aXe09IwO2YwjgFlGnV91PJRcD6pq2Oy1+uc79NSo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykAwJuZMen742Njna+yYxOxDdXoJqEejct5hPP5p2bkTy1D75
	MzUzgKFfLhCB/SGdc2glCQ2McVpjJp940sjnBEVT04+lXwdTQGj7USogbkD4TBg9Ar4=
X-Gm-Gg: ASbGncvAf/eb9lZ7E43Xw3Ola1vgOJvzCdYpu+hYpfdCINbzECK8u7uVfGkjJiCot5b
	mX+vXt2l+m1kBjvuEIMIKr3XyVaLX/TAq6liHK/uLT5uYm7Tr4uP3z71FqhrdpgRtfoANWiz+Ng
	19aT5x1KPVe8lWWHcb3rKNqA+HvZlVk6Kx/q+MyqjLa7sgEWWPJMuI/2mOf6KcpBZllw56aHEC1
	iZ5B1qXSj9UTDNCBRyQEwbzvg7X2EDMGJ+HR7F/Z5OfOJ375SqoiTMKuH+GNv4DYWVSLIDFQIip
	mCoPo+S30Qtyq0Tiff6fgMGPAqTZ1s9NA6FsohZjAzuAZtQHhhUQZ1mM1sKl5b/C2ylMd1/5Ojq
	2UVCtFXdh/p76u6eLZxEeJzC0vi8=
X-Google-Smtp-Source: AGHT+IFU3Q/Hh7RTuXGq5dmiT8HB39+ZCVp6icWdNbUoXfZ/HHwJEsFc9N1HvQBAcTmLjvTr7scKIw==
X-Received: by 2002:a17:902:c945:b0:24a:a6c8:d6e4 with SMTP id d9443c01a7336-24aa6c8f42cmr162919645ad.32.1756947765147;
        Wed, 03 Sep 2025 18:02:45 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b16429692sm58897355ad.122.2025.09.03.18.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:02:44 -0700 (PDT)
Date: Thu, 4 Sep 2025 01:02:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Marc Harvey <marcharvey@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, edumazet@google.com,
	willemb@google.com, maheshb@google.com, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: Add tests to verify team driver
 option set and get.
Message-ID: <aLjlLl03-YJ_avaa@fedora>
References: <20250902235504.4190036-1-marcharvey@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902235504.4190036-1-marcharvey@google.com>

On Tue, Sep 02, 2025 at 11:55:04PM +0000, Marc Harvey wrote:
> There are currently no kernel tests that verify setting and getting
> options of the team driver.
> 
> In the future, options may be added that implicitly change other
> options, which will make it useful to have tests like these that show
> nothing breaks. There will be a follow up patch to this that adds new
> "rx_enabled" and "tx_enabled" options, which will implicitly affect the
> "enabled" option value and vice versa.
> 
> The tests use teamnl to first set options to specific values and then
> gets them to compare to the set values.
> 
> Signed-off-by: Marc Harvey <marcharvey@google.com>
> ---
>  .../selftests/drivers/net/team/Makefile       |   6 +-
>  .../selftests/drivers/net/team/options.sh     | 194 ++++++++++++++++++
>  2 files changed, 198 insertions(+), 2 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/team/options.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/team/Makefile b/tools/testing/selftests/drivers/net/team/Makefile
> index eaf6938f100e..8b00b70ce67f 100644
> --- a/tools/testing/selftests/drivers/net/team/Makefile
> +++ b/tools/testing/selftests/drivers/net/team/Makefile
> @@ -1,11 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for net selftests
>  
> -TEST_PROGS := dev_addr_lists.sh propagation.sh
> +TEST_PROGS := dev_addr_lists.sh propagation.sh options.sh
>  
>  TEST_INCLUDES := \
>  	../bonding/lag_lib.sh \
>  	../../../net/forwarding/lib.sh \
> -	../../../net/lib.sh
> +	../../../net/lib.sh \
> +	../../../net/in_netns.sh \

I didn't find you use namespace for testing, so why include the in_netns.sh ?
BTW, It's recommended to use namespace for testing to avoid affect the main
net.

Thanks
Hangbin

