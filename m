Return-Path: <linux-kselftest+bounces-2526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDB78203C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043F7B215CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2F417D9;
	Sat, 30 Dec 2023 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8tQRX16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036D41FAF;
	Sat, 30 Dec 2023 06:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-204301f2934so5387604fac.1;
        Fri, 29 Dec 2023 22:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703917213; x=1704522013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zD0gbNM/UIbn0G76bHrolSGtyxKet6ZoZHv6TMp/l8A=;
        b=G8tQRX16KBSB6lj88K91hyVSs86myy1va1Ti/8F1JjYKROOO9xzkjGb5G4ljpL0I4E
         tqRd3gcWywwbZdl/N88XFPHjZiSYItoAvBOh/+dXXAhK+dQa/mDkhEGLknIl0lmRKWVn
         ju3TYXgFGjla4yZ+h4IIxEPknZw6zT7i0qcrpS2MBd75CgWnNKXVGEc4IplwRObKmZn1
         /p0l8zkNdd/+afNKp+CkOJtMG/EIO/VcXBTHoGzc2WiQ2YDC5+UCf6qCuwuSElrteKOA
         E+eR8agxaVsKGvlGsizF1GRV4C/6Y6uNMabnd/Rah0sgh2i9A6KqrAFTG51LhWqfFdhR
         174g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703917213; x=1704522013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD0gbNM/UIbn0G76bHrolSGtyxKet6ZoZHv6TMp/l8A=;
        b=G4BAwRGBnbjz9F23JdWPurO2TuxC+mmrTAZ01LdmHfJcefQBwaP5uKaQ1nB2R+UgMI
         GrzYGI5Kxs4cVGYYdl6Ok7aVmjUxKVOK/TsJu0HJCNE+Rnsih9pAI41ikiliq79XY2Jj
         wRON7OY+Ruwn4R4U7R1LcJxwRR5333r6MdvxR3KcByTEVsnL8h0TWjRxAkVaXwZM75Qd
         UF6XkDBwYQ/E6ptTdGA7I/5V+BpY6DSyo4qB09ImMRdfeBRphJ1c1P2waN69lQFiTo+Q
         IcjqDowCzfjbUIdO1OgtLumxW3ASwghRiOXsaHX8l4oCk0rLsGYNXnRzKcmr9GW5hMsY
         cuHg==
X-Gm-Message-State: AOJu0YyTaxDQWdxkYIyHk3MdvNk4BEa1n+sYBeeeqJBQO3rJ35TQ/Olf
	4gWOReTSJlIH7lx9c6EIkRc=
X-Google-Smtp-Source: AGHT+IGavIK/6vyvX/lLQaJRpYsnZcYYQzg+ku/2dTUvTSSkb7NoOscrrN0INxKZBsg24ioBg/kgfg==
X-Received: by 2002:a05:6870:6106:b0:204:14ac:afff with SMTP id s6-20020a056870610600b0020414acafffmr16079953oae.63.1703917212899;
        Fri, 29 Dec 2023 22:20:12 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id px9-20020a17090b270900b0028c952fd855sm5788464pjb.52.2023.12.29.22.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 22:20:11 -0800 (PST)
Date: Sat, 30 Dec 2023 14:20:07 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, lkp@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Message-ID: <ZY-2lxptTmZqLfvb@Laptop-X1>
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

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

