Return-Path: <linux-kselftest+bounces-18893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DF98D202
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 13:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566BA1C218F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 11:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0F81E7676;
	Wed,  2 Oct 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFw3XzrW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264081940AA;
	Wed,  2 Oct 2024 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867360; cv=none; b=mLJZrvne6gvirEBjWUv3mXKolp6RTw2sbocJ6Vnm0pFUnmgRMh3HdaWE8Ic+itjARHqhxxZe9tL4E0sPMljTT0fIyjN+ml1NvDNay8pSI/dY57Y27zfTHv69oBb21tNZE6gzU+zubIJvqJw+MB+EVsdXlQ9dwjwHGa62+O2+rJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867360; c=relaxed/simple;
	bh=HZibFmP+HJLtb/VpknTHlBzQC4E+VI/DkfIx7Ca31YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkQiE/7T5XYjKVO/OTTB5HZzWWuq6lEbqW8ZIBoEPT2jYeilOthSqxfucB1AKOhhw+AZFbZoaNJoyZ+kNORPmZZCqsxLbNeiiHTYwku11l/BG5tk46vpZiRdWYKNO0oxWbG4OlWJH8ng7nMbl/ygWqwbM1ioU+0E3SPQ3iYdX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFw3XzrW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727867358; x=1759403358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HZibFmP+HJLtb/VpknTHlBzQC4E+VI/DkfIx7Ca31YU=;
  b=cFw3XzrWWcdxIF7si2ZQrl1ZO3t/d8Wlf0ajr/p1hxgIvxEu0fT+GmGS
   AUwYPXeoSNxk1XP7uJ9eXsPIWcs1dedDjl9qD/6kxLblQEWlHsBmkJ+Sm
   ze8dYk4hNVxAK1IfU9rB2NjEKFuDfNcegA3n17liQ+KaFSQYL23euuR8v
   fMBN+1NnzZDESvkDlTo20dtr1QONs9fZ2hY18AfA5f5Y1MqKaCCJ+MMJq
   JAYoGQ8HM1xaSCJmgFkx4bqnaUEnqUxcsMipgLRfXOlhdRtiuUY2Bqc2M
   233D7XTpZuuu5QZzBu9LnLndXAML/9E5a2y21zke/omHuTixpItPzvEEN
   g==;
X-CSE-ConnectionGUID: OjZnq9SFQxm/+9sNZhp2mQ==
X-CSE-MsgGUID: ZS+n0K+pRQuElqxB3RCcTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26977539"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="26977539"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:09:17 -0700
X-CSE-ConnectionGUID: S9UTSiDeTcmTAyymhyhLAA==
X-CSE-MsgGUID: pqeGrsQBRcqYgWqPhxUtzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="74774408"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 02 Oct 2024 04:09:14 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svxEF-000Rxf-0M;
	Wed, 02 Oct 2024 11:09:11 +0000
Date: Wed, 2 Oct 2024 19:08:28 +0800
From: kernel test robot <lkp@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	sd@queasysnail.net, ryazanov.s.a@gmail.com,
	steffen.klassert@secunet.com, antony.antony@secunet.com
Subject: Re: [PATCH net-next v8 02/24] net: introduce OpenVPN Data Channel
 Offload (ovpn)
Message-ID: <202410021829.6fqjQrRB-lkp@intel.com>
References: <20241002-b4-ovpn-v8-2-37ceffcffbde@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-b4-ovpn-v8-2-37ceffcffbde@openvpn.net>

Hi Antonio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 44badc908f2c85711cb18e45e13119c10ad3a05f]

url:    https://github.com/intel-lab-lkp/linux/commits/Antonio-Quartulli/netlink-add-NLA_POLICY_MAX_LEN-macro/20241002-172734
base:   44badc908f2c85711cb18e45e13119c10ad3a05f
patch link:    https://lore.kernel.org/r/20241002-b4-ovpn-v8-2-37ceffcffbde%40openvpn.net
patch subject: [PATCH net-next v8 02/24] net: introduce OpenVPN Data Channel Offload (ovpn)
reproduce: (https://download.01.org/0day-ci/archive/20241002/202410021829.6fqjQrRB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410021829.6fqjQrRB-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/rustc-1.78.0-bindgen-0.65.1/cargo/bin:/opt/cross/clang-18/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make KCFLAGS= -Wtautological-compare -Wno-error=return-type -Wreturn-type -Wcast-function-type -funsigned-char -Wundef -fstrict-flex-arrays=3 -Wformat-overflow -Wformat-truncation -Wenum-conversion W=1 --keep-going LLVM=1 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
>> ./drivers/net/ovpn/main.c: 12 linux/version.h not needed.
   ./samples/bpf/spintest.bpf.c: 8 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 423: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

