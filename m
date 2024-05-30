Return-Path: <linux-kselftest+bounces-10917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9D8D4B52
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED731C231A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 12:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52417FAAF;
	Thu, 30 May 2024 12:10:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4C176183;
	Thu, 30 May 2024 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071042; cv=none; b=G1upMTVIg/w3+Wh/tFbehLvwJqtN9RpNgWoCLqCrkkHxS9VwH0VmJCfKTfPtoyuGC4jPkiTO0Bqt+HB/vZbtPuwA+bt4H8DkRffuwLR7GY4MJpHQl/0vQJYigNXB5bkJHtyy/BN2eh2P0V/e0Hpiehfn5DyNxOtk3vycKVz2KuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071042; c=relaxed/simple;
	bh=P0RD5wePROwgM93a13nPt0ORKlo981rKnfcaHC63to8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkdbQGZfkYn4/AsOgz5f468bwu8wf/iTPeFoEcJvEOfGDR++cPSq0e5Jz4E02T7e07IUY0F9hU3lVc2bdtbkHxxq0BaU8RRurGIrIIXZxAQ1SvsPgp/D3E5+yoVfFAymI2pjFNcroRgEGsT2WmtmHcPnKu+bbXFtoYzCnulq1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6302bdb54aso88117966b.0;
        Thu, 30 May 2024 05:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717071039; x=1717675839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vn5DeFOwNHbs9/RCnEd5ReZXwUcap9a3NbSMJIIwBVg=;
        b=J4DX342m5zqywde/HVqj1vu0YSQCb16JDV/G3RWrSMkuy4BQH/jdwON8iQ+rMOBmZK
         OHbwxMhD74AfqZVCfnSosqrD4lgKHONQUvlFVa1yUxsYA91l43DTND7pyBk5kegYeKdR
         RUKxeBweh1PWHmchI/hGDUU6l+6xgUKTf5U6GJnKDY8rTCSQ6Azka2ukLIbM3TJ5JGoc
         rOqo9MW9i8NBPOxC3yveBPcXRz0EhCzeOnJTBD1leuhPORuhkL8KG7JRAnUVXm8TIO6X
         Jl1x4NYX1xGkSR7H6Wf7iGaXw4pNxwWByRxDeO/R/qA5czPHvoG+Um+TSx4j7Tw03Chk
         oYWg==
X-Forwarded-Encrypted: i=1; AJvYcCXdX6xNkrvT2PGzRWIREfgVLMj01q0qXCPYOvTMSjOwqx5zAhbNGMwqNseizavqcROtrWPp52M04TJChK6s9uvP5/tuFBYJG7Te6nXG4gtjC4YT/xGAW4K150hT6+35uYOwmi94jEpLMnjzVPCH
X-Gm-Message-State: AOJu0Yw5OTRJZDwMu+P8FTzkpcB1VSNXvCAp29WMFrAtavOCstYEJycr
	ic+c8gXhldqKJCn/GUnsWnnsDvX8OhauTw8JmJmqhdy+Cx/S5pYU
X-Google-Smtp-Source: AGHT+IGZ+uD+C4coiMwyWoJiYb1UO0xSkZytq7e7bAEIaII3ZacuBm3TQ4lF6mFpcEIVH8lflRg3Lg==
X-Received: by 2002:a17:906:b245:b0:a5a:4705:ad36 with SMTP id a640c23a62f3a-a65e8e34e38mr121799766b.16.1717071038446;
        Thu, 30 May 2024 05:10:38 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda6cdcsm810394166b.209.2024.05.30.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 05:10:37 -0700 (PDT)
Date: Thu, 30 May 2024 05:10:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Matteo Croce <technoboy85@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: tests
 net.core.{r,w}mem_{default,max} sysctls in a netns
Message-ID: <Zlhsu+9If//CMPv+@gmail.com>
References: <20240528121139.38035-1-teknoraver@meta.com>
 <20240528121139.38035-3-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528121139.38035-3-teknoraver@meta.com>

On Tue, May 28, 2024 at 02:11:39PM +0200, Matteo Croce wrote:
> Add a selftest which checks that the sysctl is present in a netns,
> that the value is read from the init one, and that it's readonly.
> 
> Signed-off-by: Matteo Croce <teknoraver@meta.com>
> ---
>  tools/testing/selftests/net/Makefile        |  1 +
>  tools/testing/selftests/net/netns-sysctl.sh | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100755 tools/testing/selftests/net/netns-sysctl.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index bd01e4a0be2c..6da63d1831c1 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -53,6 +53,7 @@ TEST_PROGS += bind_bhash.sh
>  TEST_PROGS += ip_local_port_range.sh
>  TEST_PROGS += rps_default_mask.sh
>  TEST_PROGS += big_tcp.sh
> +TEST_PROGS += netns-sysctl.sh
>  TEST_PROGS_EXTENDED := toeplitz_client.sh toeplitz.sh
>  TEST_GEN_FILES =  socket nettest
>  TEST_GEN_FILES += psock_fanout psock_tpacket msg_zerocopy reuseport_addr_any
> diff --git a/tools/testing/selftests/net/netns-sysctl.sh b/tools/testing/selftests/net/netns-sysctl.sh
> new file mode 100755
> index 000000000000..b948ba67b13a
> --- /dev/null
> +++ b/tools/testing/selftests/net/netns-sysctl.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash -e

Don't you need to add the SPDX license header?


