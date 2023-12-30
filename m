Return-Path: <linux-kselftest+bounces-2527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE88203CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FE81F21D92
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D617D9;
	Sat, 30 Dec 2023 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wxPHgnG3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441879D8;
	Sat, 30 Dec 2023 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703917811;
	bh=Jadexy0SMnKker8eqnZd2xRLk+xbpxqZD/9apBM550c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=wxPHgnG3RNBUxzlhzKz1SQdqneucuudlcmMHHIo4rxRFYRKs5Y79+4o/wyl6f3vpp
	 TZLZdWwualNEHKglUZ0M97A7IuDAh1gK1AKlEJw+xpMi+A0KmV/dSgUZEx5qDxJ8sx
	 WmSasXaVlXAZJzZyGMLqY9srQRvQnadQiSIKxxJVpvixzP1sviSsBDtG9pbll6k4ld
	 4f5LG6sOvecfO4IQCFmMSqjMn6XSJlhsBJnIWcOsSQGsT5B4VAtQRFPrQGmam0loFW
	 CmoKJzZNpJGGANWKBIxvwWzTY/aeSkdL/3x+QXtEL0VOhT6nEAOJvVUsPiyhYQZgVX
	 PKFqNGcMKGFxQ==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E9C28378105A;
	Sat, 30 Dec 2023 06:30:07 +0000 (UTC)
Message-ID: <3e98be92-8507-410b-bfa2-dfdd42829764@collabora.com>
Date: Sat, 30 Dec 2023 11:30:04 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
To: Yujie Liu <yujie.liu@intel.com>, netdev@vger.kernel.org,
 Hangbin Liu <liuhangbin@gmail.com>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231229131931.3961150-1-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 6:19 PM, Yujie Liu wrote:
> The patch set [1] added a general lib.sh in net selftests, and converted
> several test scripts to source the lib.sh.
> 
> unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
> have a /bin/sh shebang which may point to various shells in different
> distributions, but "source" is only available in some of them. For
> example, "source" is a built-it function in bash, but it cannot be
> used in dash.
> 
> Refer to other scripts that were converted together, simply change the
> shebang to bash to fix the following issues when the default /bin/sh
> points to other shells.
> 
> # selftests: net: unicast_extensions.sh
> # ./unicast_extensions.sh: 31: source: not found
> # ###########################################################################
> # Unicast address extensions tests (behavior of reserved IPv4 addresses)
> # ###########################################################################
> # TEST: assign and ping within 240/4 (1 of 2) (is allowed)            [FAIL]
> # TEST: assign and ping within 240/4 (2 of 2) (is allowed)            [FAIL]
> # TEST: assign and ping within 0/8 (1 of 2) (is allowed)              [FAIL]
> # TEST: assign and ping within 0/8 (2 of 2) (is allowed)              [FAIL]
> # TEST: assign and ping inside 255.255/16 (is allowed)                [FAIL]
> # TEST: assign and ping inside 255.255.255/24 (is allowed)            [FAIL]
> # TEST: route between 240.5.6/24 and 255.1.2/24 (is allowed)          [FAIL]
> # TEST: route between 0.200/16 and 245.99/16 (is allowed)             [FAIL]
> # TEST: assign and ping lowest address (/24)                          [FAIL]
> # TEST: assign and ping lowest address (/26)                          [FAIL]
> # TEST: routing using lowest address                                  [FAIL]
> # TEST: assigning 0.0.0.0 (is forbidden)                              [ OK ]
> # TEST: assigning 255.255.255.255 (is forbidden)                      [ OK ]
> # TEST: assign and ping inside 127/8 (is forbidden)                   [ OK ]
> # TEST: assign and ping class D address (is forbidden)                [ OK ]
> # TEST: routing using class D (is forbidden)                          [ OK ]
> # TEST: routing using 127/8 (is forbidden)                            [ OK ]
> not ok 51 selftests: net: unicast_extensions.sh # exit=1
> 
> v1 -> v2:
>   - Fix pmtu.sh which has the same issue as unicast_extensions.sh,
>     suggested by Hangbin
>   - Change the style of the "source" line to be consistent with other
>     tests, suggested by Hangbin
> 
> Link: https://lore.kernel.org/all/20231202020110.362433-1-liuhangbin@gmail.com/ [1]
> Link: https://lore.kernel.org/all/20231219094856.1740079-1-liuhangbin@gmail.com/ [2]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/net/pmtu.sh               | 4 ++--
>  tools/testing/selftests/net/unicast_extensions.sh | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
> index 175d3d1d773b..f10879788f61 100755
> --- a/tools/testing/selftests/net/pmtu.sh
> +++ b/tools/testing/selftests/net/pmtu.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # Check that route PMTU values match expectations, and that initial device MTU
> @@ -198,7 +198,7 @@
>  # - pmtu_ipv6_route_change
>  #	Same as above but with IPv6
>  
> -source ./lib.sh
> +source lib.sh
>  
>  PAUSE_ON_FAIL=no
>  VERBOSE=0
> diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
> index b7a2cb9e7477..f52aa5f7da52 100755
> --- a/tools/testing/selftests/net/unicast_extensions.sh
> +++ b/tools/testing/selftests/net/unicast_extensions.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  #
>  # By Seth Schoen (c) 2021, for the IPv4 Unicast Extensions Project
> @@ -28,7 +28,7 @@
>  # These tests provide an easy way to flip the expected result of any
>  # of these behaviors for testing kernel patches that change them.
>  
> -source ./lib.sh
> +source lib.sh
>  
>  # nettest can be run from PATH or from same directory as this selftest
>  if ! which nettest >/dev/null; then
> 
> base-commit: cd4d7263d58ab98fd4dee876776e4da6c328faa3

-- 
BR,
Muhammad Usama Anjum

