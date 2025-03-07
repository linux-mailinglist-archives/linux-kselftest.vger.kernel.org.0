Return-Path: <linux-kselftest+bounces-28487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C197A5670E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 12:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73ABE17753E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D9B217F5C;
	Fri,  7 Mar 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDWnw6xR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E4211A29;
	Fri,  7 Mar 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348236; cv=none; b=GkbOGnxp8il5nmoQ9RmOAmEj2w0sEW8ls/kEYYTEKFdCSG9syaJQuCsd2HTk7ZvdQD1m+B0hxPExX0KwrnjyCxZq/J/Q2Dha0R2QvatpDQaF8weRJs2vnQJqqxMfoyzB9Xd+i3S0vQaPXxfcw0VMs+vkGTe9Q2yiA8TuPOrAX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348236; c=relaxed/simple;
	bh=T+Orm0wQjlNfpFi4uG0aCx02nXd2HC1pXE9JVAR8020=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwt0vsDWgE8HJraHkR5T4txxoDRfjGXtUey4Fymjw5wbJ70uQix20AieR3tPXCGu2TYzSfQOGC8bcdLg1xnm77InPWDdfXd/nbDhk1v2iP6EgiTY+EvoDG7cAZoYCtv+o+dhs40b81ck8X8yJH++ZUK+h4o6ZH1BY8LbvkaiZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDWnw6xR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741348235; x=1772884235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+Orm0wQjlNfpFi4uG0aCx02nXd2HC1pXE9JVAR8020=;
  b=jDWnw6xRryroPQMMDUYOWz40FKGSgDEEO2me+T0f8CZC12C6blftaM00
   ktgenbTJgith/uhUOZeM8Hw+zzIUOFkN2rzEUtBA4rN8zmNaanzfJkTCw
   G/8tDtkoXR9XwkFTj8r9IJyrTYYApmejdG7Jr2MfvPsEfDotybsgj7g54
   Y9NIzR86VaZTY/u8Occ3FzMYNQpbkcWBCL12N/qmJDkeDdlEaEQiLxKEI
   PCddUnXhPWpR+Wspczu42VT1hhkV40M1GMO9ghLMvYRJuq+inEthiSMpH
   YxLPSr6uPIFJYR+0SeR/K9pB7WnOGDeXdKLXzCUQm+kycEuKEO0F/oxMB
   A==;
X-CSE-ConnectionGUID: FviWXe+3Q9ScvEGl4z150g==
X-CSE-MsgGUID: Et57ws7vSzy2ItOKvAq8/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46048711"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="46048711"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 03:50:34 -0800
X-CSE-ConnectionGUID: E0BrROxpTHqLf8kj9yuT+w==
X-CSE-MsgGUID: O2Lf7UYNTs2kDv3mgNZ5Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124526006"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 07 Mar 2025 03:50:27 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWDh-0000Pb-1J;
	Fri, 07 Mar 2025 11:50:25 +0000
Date: Fri, 7 Mar 2025 19:50:12 +0800
From: kernel test robot <lkp@intel.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, Lei Yang <leiyang@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 3/6] tun: Introduce virtio-net hash feature
Message-ID: <202503071936.EzoojQZO-lkp@intel.com>
References: <20250306-rss-v8-3-7ab4f56ff423@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-rss-v8-3-7ab4f56ff423@daynix.com>

Hi Akihiko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dd83757f6e686a2188997cb58b5975f744bb7786]

url:    https://github.com/intel-lab-lkp/linux/commits/Akihiko-Odaki/virtio_net-Add-functions-for-hashing/20250306-180546
base:   dd83757f6e686a2188997cb58b5975f744bb7786
patch link:    https://lore.kernel.org/r/20250306-rss-v8-3-7ab4f56ff423%40daynix.com
patch subject: [PATCH net-next v8 3/6] tun: Introduce virtio-net hash feature
config: x86_64-buildonly-randconfig-001-20250307 (https://download.01.org/0day-ci/archive/20250307/202503071936.EzoojQZO-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071936.EzoojQZO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071936.EzoojQZO-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/tap.c:1056:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1056 |         case SIOCGIFHWADDR:
         |         ^
   drivers/net/tap.c:1056:2: note: insert '__attribute__((fallthrough));' to silence this warning
    1056 |         case SIOCGIFHWADDR:
         |         ^
         |         __attribute__((fallthrough)); 
   drivers/net/tap.c:1056:2: note: insert 'break;' to avoid fall-through
    1056 |         case SIOCGIFHWADDR:
         |         ^
         |         break; 
   1 warning generated.


vim +1056 drivers/net/tap.c

2be5c76794b0e5 drivers/net/macvtap.c Vlad Yasevich      2013-06-25   964  
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   965  /*
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   966   * provide compatibility with generic tun/tap interface
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   967   */
635b8c8ecdd271 drivers/net/tap.c     Sainath Grandhi    2017-02-10   968  static long tap_ioctl(struct file *file, unsigned int cmd,
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   969  		      unsigned long arg)
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   970  {
635b8c8ecdd271 drivers/net/tap.c     Sainath Grandhi    2017-02-10   971  	struct tap_queue *q = file->private_data;
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10   972  	struct tap_dev *tap;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   973  	void __user *argp = (void __user *)arg;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   974  	struct ifreq __user *ifr = argp;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   975  	unsigned int __user *up = argp;
39ec7de7092ba9 drivers/net/macvtap.c Michael S. Tsirkin 2014-12-16   976  	unsigned short u;
55afbd0810922a drivers/net/macvtap.c Michael S. Tsirkin 2010-04-29   977  	int __user *sp = argp;
7f460d30c8e130 drivers/net/macvtap.c Justin Cormack     2015-05-13   978  	struct sockaddr sa;
55afbd0810922a drivers/net/macvtap.c Michael S. Tsirkin 2010-04-29   979  	int s;
02df55d28c6001 drivers/net/macvtap.c Arnd Bergmann      2010-02-18   980  	int ret;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   981  
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   982  	switch (cmd) {
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   983  	case TUNSETIFF:
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   984  		/* ignore the name, just look at flags */
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   985  		if (get_user(u, &ifr->ifr_flags))
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   986  			return -EFAULT;
b9fb9ee07e67fc drivers/net/macvtap.c Arnd Bergmann      2010-02-18   987  
b9fb9ee07e67fc drivers/net/macvtap.c Arnd Bergmann      2010-02-18   988  		ret = 0;
635b8c8ecdd271 drivers/net/tap.c     Sainath Grandhi    2017-02-10   989  		if ((u & ~TAP_IFFEATURES) != (IFF_NO_PI | IFF_TAP))
b9fb9ee07e67fc drivers/net/macvtap.c Arnd Bergmann      2010-02-18   990  			ret = -EINVAL;
b9fb9ee07e67fc drivers/net/macvtap.c Arnd Bergmann      2010-02-18   991  		else
635b8c8ecdd271 drivers/net/tap.c     Sainath Grandhi    2017-02-10   992  			q->flags = (q->flags & ~TAP_IFFEATURES) | u;
b9fb9ee07e67fc drivers/net/macvtap.c Arnd Bergmann      2010-02-18   993  
b9fb9ee07e67fc drivers/net/macvtap.c Arnd Bergmann      2010-02-18   994  		return ret;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   995  
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30   996  	case TUNGETIFF:
441ac0fcaadc76 drivers/net/macvtap.c Vlad Yasevich      2013-06-25   997  		rtnl_lock();
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10   998  		tap = tap_get_tap_dev(q);
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10   999  		if (!tap) {
441ac0fcaadc76 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1000  			rtnl_unlock();
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1001  			return -ENOLINK;
441ac0fcaadc76 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1002  		}
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1003  
02df55d28c6001 drivers/net/macvtap.c Arnd Bergmann      2010-02-18  1004  		ret = 0;
39ec7de7092ba9 drivers/net/macvtap.c Michael S. Tsirkin 2014-12-16  1005  		u = q->flags;
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1006  		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
39ec7de7092ba9 drivers/net/macvtap.c Michael S. Tsirkin 2014-12-16  1007  		    put_user(u, &ifr->ifr_flags))
02df55d28c6001 drivers/net/macvtap.c Arnd Bergmann      2010-02-18  1008  			ret = -EFAULT;
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1009  		tap_put_tap_dev(tap);
441ac0fcaadc76 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1010  		rtnl_unlock();
02df55d28c6001 drivers/net/macvtap.c Arnd Bergmann      2010-02-18  1011  		return ret;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1012  
815f236d622721 drivers/net/macvtap.c Jason Wang         2013-06-05  1013  	case TUNSETQUEUE:
815f236d622721 drivers/net/macvtap.c Jason Wang         2013-06-05  1014  		if (get_user(u, &ifr->ifr_flags))
815f236d622721 drivers/net/macvtap.c Jason Wang         2013-06-05  1015  			return -EFAULT;
441ac0fcaadc76 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1016  		rtnl_lock();
635b8c8ecdd271 drivers/net/tap.c     Sainath Grandhi    2017-02-10  1017  		ret = tap_ioctl_set_queue(file, u);
441ac0fcaadc76 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1018  		rtnl_unlock();
82a19eb8c02ab9 drivers/net/macvtap.c Jason Wang         2013-07-16  1019  		return ret;
815f236d622721 drivers/net/macvtap.c Jason Wang         2013-06-05  1020  
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1021  	case TUNGETFEATURES:
635b8c8ecdd271 drivers/net/tap.c     Sainath Grandhi    2017-02-10  1022  		if (put_user(IFF_TAP | IFF_NO_PI | TAP_IFFEATURES, up))
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1023  			return -EFAULT;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1024  		return 0;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1025  
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1026  	case TUNSETSNDBUF:
3ea79249e81e5e drivers/net/macvtap.c Michael S. Tsirkin 2015-09-18  1027  		if (get_user(s, sp))
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1028  			return -EFAULT;
93161922c658c7 drivers/net/tap.c     Craig Gallek       2017-10-30  1029  		if (s <= 0)
93161922c658c7 drivers/net/tap.c     Craig Gallek       2017-10-30  1030  			return -EINVAL;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1031  
3ea79249e81e5e drivers/net/macvtap.c Michael S. Tsirkin 2015-09-18  1032  		q->sk.sk_sndbuf = s;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1033  		return 0;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1034  
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1035  	case TUNSETOFFLOAD:
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1036  		/* let the user check for future flags */
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1037  		if (arg & ~(TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
399e0827642f6a drivers/net/tap.c     Andrew Melnychenko 2022-12-07  1038  			    TUN_F_TSO_ECN | TUN_F_UFO |
399e0827642f6a drivers/net/tap.c     Andrew Melnychenko 2022-12-07  1039  			    TUN_F_USO4 | TUN_F_USO6))
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1040  			return -EINVAL;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1041  
2be5c76794b0e5 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1042  		rtnl_lock();
2be5c76794b0e5 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1043  		ret = set_offload(q, arg);
2be5c76794b0e5 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1044  		rtnl_unlock();
2be5c76794b0e5 drivers/net/macvtap.c Vlad Yasevich      2013-06-25  1045  		return ret;
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1046  
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1047  	case TUNGETVNETHASHCAP:
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1048  		return tun_vnet_ioctl_gethashcap(argp);
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1049  
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1050  	case TUNSETVNETHASH:
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1051  		rtnl_lock();
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1052  		tap = rtnl_dereference(q->tap);
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1053  		ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, true, argp) : -EBADFD;
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1054  		rtnl_unlock();
2c592c9b450ea4 drivers/net/tap.c     Akihiko Odaki      2025-03-06  1055  
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11 @1056  	case SIOCGIFHWADDR:
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1057  		rtnl_lock();
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1058  		tap = tap_get_tap_dev(q);
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1059  		if (!tap) {
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1060  			rtnl_unlock();
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1061  			return -ENOLINK;
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1062  		}
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1063  		ret = 0;
3b23a32a63219f drivers/net/tap.c     Cong Wang          2021-02-11  1064  		dev_get_mac_address(&sa, dev_net(tap->dev), tap->dev->name);
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1065  		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
3b23a32a63219f drivers/net/tap.c     Cong Wang          2021-02-11  1066  		    copy_to_user(&ifr->ifr_hwaddr, &sa, sizeof(sa)))
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1067  			ret = -EFAULT;
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1068  		tap_put_tap_dev(tap);
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1069  		rtnl_unlock();
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1070  		return ret;
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1071  
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1072  	case SIOCSIFHWADDR:
7f460d30c8e130 drivers/net/macvtap.c Justin Cormack     2015-05-13  1073  		if (copy_from_user(&sa, &ifr->ifr_hwaddr, sizeof(sa)))
7f460d30c8e130 drivers/net/macvtap.c Justin Cormack     2015-05-13  1074  			return -EFAULT;
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1075  		rtnl_lock();
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1076  		tap = tap_get_tap_dev(q);
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1077  		if (!tap) {
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1078  			rtnl_unlock();
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1079  			return -ENOLINK;
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1080  		}
3b23a32a63219f drivers/net/tap.c     Cong Wang          2021-02-11  1081  		ret = dev_set_mac_address_user(tap->dev, &sa, NULL);
6fe3faf86757eb drivers/net/tap.c     Sainath Grandhi    2017-02-10  1082  		tap_put_tap_dev(tap);
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1083  		rtnl_unlock();
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1084  		return ret;
b5082083392224 drivers/net/macvtap.c Justin Cormack     2015-05-11  1085  
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1086  	default:
69113cb5de68da drivers/net/tap.c     Akihiko Odaki      2025-02-07  1087  		return tun_vnet_ioctl(&q->vnet_hdr_sz, &q->flags, cmd, sp);
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1088  	}
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1089  }
20d29d7a916a47 drivers/net/macvtap.c Arnd Bergmann      2010-01-30  1090  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

