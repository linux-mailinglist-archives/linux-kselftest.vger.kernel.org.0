Return-Path: <linux-kselftest+bounces-2442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BBC81E778
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 13:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD4B1C21D94
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844314E63E;
	Tue, 26 Dec 2023 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn9w1i8n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9E4E631;
	Tue, 26 Dec 2023 12:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4136750b3a.0;
        Tue, 26 Dec 2023 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703595109; x=1704199909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8I6eOdWU4tKnR7IavMXk04RzDq/PuX82Y4y0SpAzUkk=;
        b=Bn9w1i8nqDndcNqdMAJihuW4TqwDCcsfk7QyAVW5/o7XZaZpuF0bj35f7XyxbVJQK9
         MLBM1IklObu2iZn1iw/0ltt7MgojcQ9ru68BiEeJBcH8BikCoDl2Y3teODLcilTra4bu
         wIljksUbqzV0ZFvw4Sls4pyW40SaYptl7CyDzZ2jLgkpe3Ny8nCwmpMap2CMGSntWBuW
         q1KVhqUiXWNrwwLFnKlJZN72QO+sChAd1+a2ShvSW352rGo/CgGxbzqN5zaRH5yrXdj3
         G1LO5g1QsB2ZOVZ/bp0Ihx+DaxZy4OF5qAc7mHhI23mdRWDP2sw2ZmJD85v9gi5KZqBU
         Srxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703595109; x=1704199909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I6eOdWU4tKnR7IavMXk04RzDq/PuX82Y4y0SpAzUkk=;
        b=LxadtMwHfnFMVPuS8UTEUwyL1/sFMeN6Zy+2TIhXiYWFC31tYxEovn9yuNQ3C9Umuo
         7igqCw6pOQ7q8KobeFMtoWPHrDvRi1RNO4aplLkYFUKggfXJZK3DWp+YSkbu023JjkQR
         6q0i1UzoXrMdu0kKGY62/n4ItQuWUKinBG7xkz0bpNWansaM4L4Vvl8mVPaQygkUsKE+
         dBMg2aBsRWjxWT8/2vtDkPrzilVvGkmjqsB+0bxH75HnVSZWSpfNI/bxNt03VoRTq+S3
         qu/vyafMHXkfSeScXVmX4dnGk6rWu6iTHGkIIImeBwy2pBnljmnJJYu8RT9HroTRZYng
         cf1g==
X-Gm-Message-State: AOJu0YxyuAom01anorV5nIjbIAbWRyga6lQTMWqfnqty6TW0+6/1NIIi
	7eRDvog77Y8qhE3YMmTMu4I=
X-Google-Smtp-Source: AGHT+IEm6DwiwwbjMok5Hg2b2sDi1RmVsgcgt7KlVA48YtMdjivpc6UnEOvWham0wYyY5EgxS7Kf2g==
X-Received: by 2002:a05:6a20:324b:b0:190:35f4:c515 with SMTP id hm11-20020a056a20324b00b0019035f4c515mr7495561pzc.12.1703595109295;
        Tue, 26 Dec 2023 04:51:49 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fb35-20020a056a002da300b006d9bff075cfsm2726177pfb.33.2023.12.26.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 04:51:48 -0800 (PST)
Date: Tue, 26 Dec 2023 20:51:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, lkp@intel.com,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH net-next] selftests/net: change the shebang of
 unicast_extensions.sh to bash
Message-ID: <ZYrMX5GTjxCzGeK-@Laptop-X1>
References: <20231225072109.3835503-1-yujie.liu@intel.com>
 <ZYl37fnxGGop7VCs@Laptop-X1>
 <ZYqSJk9rMxGxLx8s@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYqSJk9rMxGxLx8s@yujie-X299>

On Tue, Dec 26, 2023 at 04:43:18PM +0800, Yujie Liu wrote:
> Hi Hangbin,
> 
> On Mon, Dec 25, 2023 at 08:39:09PM +0800, Hangbin Liu wrote:
> > On Mon, Dec 25, 2023 at 03:21:09PM +0800, Yujie Liu wrote:
> > > The patch set [1] added a general lib.sh in net selftests, and converted
> > > several test scripts to source the lib.sh.
> > 
> > Oh, I didn't know dash doesn't support "source". Thanks for the fix.
> > Would you please also help fix the pmtu.sh, which has the same issue?
> 
> It looks like pmtu.sh was not converted in patch set [1], so it doesn't
> have "source lib.sh" yet. The cover letter of [1] mentions that the
> whole process of conversion will be split into several parts. Not sure
> if pmtu.sh will be converted in the subsequent parts soon? If so, would
> you like to change the shebang of pmtu.sh when converting it later, or
> change it together in this patch? Thanks.

The pmtu.sh update is in this patch set.
https://lore.kernel.org/all/20231219094856.1740079-1-liuhangbin@gmail.com/

It would be good to fix these 2 tests together.

> 
> BTW, in addition to pmtu.sh, I noticed that there are several other
> scripts in net selftests which have "/bin/sh" shebang:

Yes, but the other tests don't use "source".

> 
> linux/tools/testing/selftests/net$ grep -rF '#!/bin/sh'
> openvswitch/openvswitch.sh:#!/bin/sh
> in_netns.sh:#!/bin/sh
> netdevice.sh:#!/bin/sh
> test_bpf.sh:#!/bin/sh
> test_blackhole_dev.sh:#!/bin/sh
> vlan_hw_filter.sh:#!/bin/sh
> run_netsocktests:#!/bin/sh
> pmtu.sh:#!/bin/sh
> bareudp.sh:#!/bin/sh
> l2_tos_ttl_inherit.sh:#!/bin/sh
> veth.sh:#!/bin/sh
> ipv6_flowlabel.sh:#!/bin/sh
> unicast_extensions.sh:#!/bin/sh
> reuseport_addr_any.sh:#!/bin/sh
> run_afpackettests:#!/bin/sh
> ip_local_port_range.sh:#!/bin/sh
> amt.sh:#!/bin/sh
> udpgso.sh:#!/bin/sh
> ip_defrag.sh:#!/bin/sh
> rps_default_mask.sh:#!/bin/sh
> 
> > BTW, you can change the "source ./lib.sh" to "source lib.sh" to consistent
> > with other tests.
> 
> Sure, will respin a v2 with this change added.

Thanks
Hangbin

