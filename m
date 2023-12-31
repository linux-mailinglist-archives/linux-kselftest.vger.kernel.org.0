Return-Path: <linux-kselftest+bounces-2537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84F820B62
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 13:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F8A281D0C
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86E4691;
	Sun, 31 Dec 2023 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOaOR2kz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046F53A4
	for <linux-kselftest@vger.kernel.org>; Sun, 31 Dec 2023 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704025037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adPJVxO7TfBjcBAzSxJW6gA78OICpm0oYZHYg9+yj2U=;
	b=OOaOR2kzUz3iZyfTeo634m2LlbVa08kVZJb2wJn8HU9pxe7ZM58gQBBtKwQszRjwro3red
	Th+Z0ob2QwgucctUay2svh7PRPhHfstV2yu/DkTjBpsDIWaMhnDt9TbAow3bgKFGu322E5
	7Q7MS4Z7wVJ+a2eZ+FPLnE2s02DeEQ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-dwEz1lVlOw-EaI8ZoqHNDQ-1; Sun, 31 Dec 2023 07:17:15 -0500
X-MC-Unique: dwEz1lVlOw-EaI8ZoqHNDQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d5bf5ca25so35256995e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 31 Dec 2023 04:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704025035; x=1704629835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adPJVxO7TfBjcBAzSxJW6gA78OICpm0oYZHYg9+yj2U=;
        b=khr7OYoesig7PesZh5r8No7LWVEqHr2XQJpJ9gy4g5KjJHp2C7+4nCiK84v4PV7Zix
         vfFxlCEqk+r7zZh7yoEeaqL96JrWzIe9+89BnbqKyjNDvMS530BuKySjKO6RiJJWuXkB
         sHYB0pK29Hi2L8poW8Cz5Zw+JjVFvfRMiLT4GXR0gzTLn/+XBc6VL7OQcKnbAfYM5Q2G
         7MWv+A5CoEFcIv64jK6Aykz3WzPuWDTMut06YgM87TE4OKV9jh4AIQe4MVNPP/gl2ruO
         CckWy/PrydsXk9EMOjpfzZBFnbvBjiTejcv8y7ZCSn31j5DriOY8bMaxKRTi54fcZX4G
         qjkw==
X-Gm-Message-State: AOJu0YxEoV2hXlZSVkYnbER1kumlt4O+jcxV/BX4Uss8mFei/wHDamp1
	HNKET+CRjpqpGX6LqzoHV7AKbYlKkWB/G3LEUhMTRBjdvdyuOcK6zY1qmv6SYU+HuADaKt1o692
	1KgFTTXX0OEwtfslLBGYduhHYyPk5MUafptJ3
X-Received: by 2002:a05:600c:1709:b0:40d:3d98:3747 with SMTP id c9-20020a05600c170900b0040d3d983747mr7936486wmn.121.1704025034865;
        Sun, 31 Dec 2023 04:17:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeRa3sSYC/IDsaC8X9PK91/olU5JA7EPp9i6CTQtNttPRgB8n1xtBNim78bDbOVNO55tcCYw==
X-Received: by 2002:a05:600c:1709:b0:40d:3d98:3747 with SMTP id c9-20020a05600c170900b0040d3d983747mr7936482wmn.121.1704025034585;
        Sun, 31 Dec 2023 04:17:14 -0800 (PST)
Received: from debian (2a01cb058918ce00b14e8593d3a1c390.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b14e:8593:d3a1:c390])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040d6eb862a7sm11145610wmo.41.2023.12.31.04.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 04:17:13 -0800 (PST)
Date: Sun, 31 Dec 2023 13:17:11 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Message-ID: <ZZFbxyQeHgf3UQrN@debian>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229131931.3961150-1-yujie.liu@intel.com>

On Fri, Dec 29, 2023 at 09:19:31PM +0800, Yujie Liu wrote:
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

Looks like it'd be simpler to just replace the "source" commands with
"." and leave the shebang as is (unless there are other bash-specific
constructs in these scripts of course).

Generally speaking, I think we should avoid madating a specific shell,
unless that really simplifies the test script (which is not the case
here).

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
> -- 
> 2.34.1
> 
> 


