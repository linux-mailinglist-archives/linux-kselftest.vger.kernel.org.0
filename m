Return-Path: <linux-kselftest+bounces-15022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB5094B99E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 11:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495461F20FF5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05360189B9A;
	Thu,  8 Aug 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXaJql3Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1C148823;
	Thu,  8 Aug 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723109072; cv=none; b=VTjxCje1VwkTOAZmCAsfrxR76BYO12uo5LGu/zRpGPlqA1gQHBHjZWLBbhNlM+9WG8LH8RC9BZzITpDAlcUS9pUorPIKUGZ5+HlHS+KcokE9yEe5aXG0E1LHYxcwhbK2hp9BbKPV/MMnvvA9n/4pY6h0Isjgzv+UbzVA8RtgUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723109072; c=relaxed/simple;
	bh=SOQnEtBvleji89IyJOxm5wCC0qJiPC98MXc3jWBM3hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CamKvG5DjBHOt9Z/HBoKRFY+U0X6v4U3GNYyMmcjsYpz1oaO3UZdUe3nHToTJdi5QwmNfMA/Zaz0wnIUv0ZsWZXd/FPnbIIrXokVzhuRCeaZR6buLPfNxAW0bmNsorkp/TYoBedALF6N7YSFZgirfcjfhhA2dFpKsr+pVW1rPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXaJql3Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723109071; x=1754645071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOQnEtBvleji89IyJOxm5wCC0qJiPC98MXc3jWBM3hI=;
  b=gXaJql3YSdwbJZ5sN5i+6vDGp/hOOJ036FF+3tVVT7GayKmJLYaXEsFb
   adUPMp3Pzt/KjEP0hEv1emjf6J0o1p6oHE5Ly3N+zifLIZRnvsBq+S1M+
   w7Yiipq6QELvTYpLIKqtLIxHArhEPYCyx84cKDvubYIjA+pnatXtETQIr
   tIqOZ9qM7egJOiD6w0tmdk7EgXc5NORWS+O5D2Bu1sLKi1e+aqkLLZKGN
   kyNILOFDq0byzTO6xPaPMLX0DLWrqv8gps7wh1B5nEWCPmuiiuMPJr/l5
   uHTbPEvdTLdxV7aV98b8oihZ7yqnHRjx9906cM+9mmyi/iJTY+qyYmpky
   Q==;
X-CSE-ConnectionGUID: Gvy4AtZHTUS+Q+AQEPPA7A==
X-CSE-MsgGUID: gkJmuiXOSwqy1E03v5HoHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21390950"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21390950"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 02:24:30 -0700
X-CSE-ConnectionGUID: yrB9vEkUTFaKwU2RzBSCSw==
X-CSE-MsgGUID: xS7a7xWERVmYhDPINGWdtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="87809875"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 08 Aug 2024 02:24:27 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbzNb-00065M-0q;
	Thu, 08 Aug 2024 09:24:21 +0000
Date: Thu, 8 Aug 2024 17:22:38 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz, tiwai@suse.com,
	corbet@lwn.net, broonie@kernel.org, shuah@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr, aholzinger@gmx.de
Subject: Re: [PATCH v3 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
Message-ID: <202408081612.hvfwzVlB-lkp@intel.com>
References: <20240806125243.449959-4-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806125243.449959-4-ivan.orlov0322@gmail.com>

Hi Ivan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master v6.11-rc2 next-20240808]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Orlov/ALSA-aloop-Allow-using-global-timers/20240806-210332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240806125243.449959-4-ivan.orlov0322%40gmail.com
patch subject: [PATCH v3 3/4] ALSA: timer: Introduce virtual userspace-driven timers
config: arm-randconfig-r064-20240807 (https://download.01.org/0day-ci/archive/20240808/202408081612.hvfwzVlB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408081612.hvfwzVlB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408081612.hvfwzVlB-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_submit_wmt_recv_urb':
   drivers/bluetooth/btmtk.c:531:(.text+0x6c2): undefined reference to `usb_alloc_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:537:(.text+0x6e6): undefined reference to `usb_free_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:561:(.text+0x750): undefined reference to `usb_anchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:562:(.text+0x75a): undefined reference to `usb_submit_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:567:(.text+0x796): undefined reference to `usb_unanchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:570:(.text+0x7a0): undefined reference to `usb_free_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_submit_intr_urb':
   drivers/bluetooth/btmtk.c:1174:(.text+0x80e): undefined reference to `usb_alloc_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:1181:(.text+0x83a): undefined reference to `usb_free_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:1195:(.text+0x8c4): undefined reference to `usb_anchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:1197:(.text+0x8cc): undefined reference to `usb_submit_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:1202:(.text+0x908): undefined reference to `usb_unanchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:1205:(.text+0x912): undefined reference to `usb_free_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_suspend':
   drivers/bluetooth/btmtk.c:1265:(.text+0x988): undefined reference to `usb_kill_anchored_urbs'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_intr_complete':
   drivers/bluetooth/btmtk.c:1145:(.text+0xbf2): undefined reference to `usb_anchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:1147:(.text+0xbfc): undefined reference to `usb_submit_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:1157:(.text+0xc48): undefined reference to `usb_unanchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `__set_mtk_intr_interface':
   drivers/bluetooth/btmtk.c:991:(.text+0xcf4): undefined reference to `usb_set_interface'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_isointf_init':
   drivers/bluetooth/btmtk.c:1224:(.text+0xd30): undefined reference to `usb_kill_anchored_urbs'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_hci_wmt_sync':
   drivers/bluetooth/btmtk.c:610:(.text+0xf26): undefined reference to `usb_autopm_get_interface'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:618:(.text+0xf54): undefined reference to `usb_autopm_put_interface'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:625:(.text+0xf7e): undefined reference to `usb_autopm_put_interface'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_reg_read':
   drivers/bluetooth/btmtk.c:790:(.text+0x1248): undefined reference to `usb_control_msg'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_write':
   drivers/bluetooth/btmtk.c:738:(.text+0x12e0): undefined reference to `usb_control_msg'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_uhw_reg_read':
   drivers/bluetooth/btmtk.c:761:(.text+0x1374): undefined reference to `usb_control_msg'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_recv_acl':
   drivers/bluetooth/btmtk.c:946:(.text+0x1e06): undefined reference to `usb_disable_autosuspend'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `btmtk_usb_wmt_recv':
   drivers/bluetooth/btmtk.c:508:(.text+0x1e72): undefined reference to `usb_anchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:509:(.text+0x1e7c): undefined reference to `usb_submit_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.c:518:(.text+0x1ec0): undefined reference to `usb_unanchor_urb'
   arm-linux-gnueabi-ld: drivers/bluetooth/btmtk.o: in function `alloc_mtk_intr_urb':
   drivers/bluetooth/btmtk.c:1037:(.text+0x1fc8): undefined reference to `usb_alloc_urb'
   arm-linux-gnueabi-ld: sound/core/timer.o: in function `snd_utimer_create':
>> sound/core/timer.c:2127:(.text+0x255c): undefined reference to `__aeabi_uldivmod'


vim +2127 sound/core/timer.c

  2112	
  2113	static int snd_utimer_create(struct snd_utimer_info *utimer_info,
  2114				     struct snd_utimer **r_utimer)
  2115	{
  2116		struct snd_utimer *utimer;
  2117		struct snd_timer *timer;
  2118		struct snd_timer_id tid;
  2119		int utimer_id;
  2120		int err = 0;
  2121		u64 resolution;
  2122	
  2123		if (!utimer_info || utimer_info->frame_rate == 0 || utimer_info->period_size == 0)
  2124			return -EINVAL;
  2125	
  2126		/* Let's check that we won't get an overflow in the resolution */
> 2127		if (NANO / utimer_info->frame_rate > U64_MAX / utimer_info->period_size)
  2128			return -EINVAL;
  2129	
  2130		resolution = NANO / utimer_info->frame_rate * utimer_info->period_size;
  2131	
  2132		if (resolution == 0)
  2133			return -EINVAL;
  2134	
  2135		utimer = kzalloc(sizeof(*utimer), GFP_KERNEL);
  2136		if (!utimer)
  2137			return -ENOMEM;
  2138	
  2139		/* We hold the ioctl lock here so we won't get a race condition when allocating id */
  2140		utimer_id = snd_utimer_take_id();
  2141		if (utimer_id < 0) {
  2142			err = utimer_id;
  2143			goto err_take_id;
  2144		}
  2145	
  2146		utimer->name = kasprintf(GFP_KERNEL, "snd-utimer%d", utimer_id);
  2147		if (!utimer->name) {
  2148			err = -ENOMEM;
  2149			goto err_get_name;
  2150		}
  2151	
  2152		utimer->id = utimer_id;
  2153	
  2154		tid.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION;
  2155		tid.dev_class = SNDRV_TIMER_CLASS_GLOBAL;
  2156		tid.card = -1;
  2157		tid.device = SNDRV_TIMER_GLOBAL_UDRIVEN;
  2158		tid.subdevice = utimer_id;
  2159	
  2160		err = snd_timer_new(NULL, utimer->name, &tid, &timer);
  2161		if (err < 0) {
  2162			pr_err("Can't create userspace-driven timer\n");
  2163			goto err_timer_new;
  2164		}
  2165	
  2166		timer->module = THIS_MODULE;
  2167		timer->hw = timer_hw;
  2168		timer->hw.resolution = resolution;
  2169		timer->hw.ticks = 1;
  2170		timer->max_instances = MAX_SLAVE_INSTANCES;
  2171	
  2172		utimer->timer = timer;
  2173	
  2174		err = snd_timer_global_register(timer);
  2175		if (err < 0) {
  2176			pr_err("Can't register a userspace-driven timer\n");
  2177			goto err_timer_reg;
  2178		}
  2179	
  2180		*r_utimer = utimer;
  2181		return 0;
  2182	
  2183	err_timer_reg:
  2184		snd_timer_free(timer);
  2185	err_timer_new:
  2186		kfree(utimer->name);
  2187	err_get_name:
  2188		snd_utimer_put_id(utimer);
  2189	err_take_id:
  2190		kfree(utimer);
  2191	
  2192		return err;
  2193	}
  2194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

