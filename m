Return-Path: <linux-kselftest+bounces-14440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772594058E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BDA282E78
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 02:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5357CB5;
	Tue, 30 Jul 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvUZhhsQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10B3CA6F;
	Tue, 30 Jul 2024 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308303; cv=none; b=GbyGiuO6UVXBCl6aQMtYwi+L2ysoLmjgBFjwfdC+FviFq6rfvwGBt4QNISRGDungoW5bNdMPDAk0gjVnm23+8Ge3of49dEcaV1x1K8ylX8Q+YN5oQ9VkXIujxycziZCYNMHf/BmQY7ijfi/daUZg/x7DT2DqR3dxMyQlJkAOEJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308303; c=relaxed/simple;
	bh=oJEsx3xbe0US5zKtnHkifmq15x8BlK/2xDiLeLK2+JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO9O8oOnlEnq8Wk4UvITKUb5rTxjjB1WaQdXejfqI2h3f9wbkoEMFcZKNd2HSfwYv++0xOHjZ4GZL2CP59PPFJbBs1/SWdPHIFLagyF3gErLecxnpGF9f69Wfz7uYBbWXVq6UyBYz9knm5gf6VXksRXhZvxdGHF0J8Q7qBuk6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvUZhhsQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722308302; x=1753844302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oJEsx3xbe0US5zKtnHkifmq15x8BlK/2xDiLeLK2+JQ=;
  b=XvUZhhsQz8AkoFQbXffipdW5SEe44jUCcbQiW1BGqRlG4VXrhGBJQphV
   4gfSv80akAetOhEbdZylS327Km5uVX+jNbGxHjtGEp2nDesd7rBe4E3oB
   qia3vWNzqazhMaTrzsjzOc4H5h9X+5nwpCpbBC5D+VKHRkimi4fLgP2zZ
   m/NsesFfCSGuKrQcQe3sSPPiOt4Fh3+Xz8PpFY97DiuNmJpgbhPFqvuuC
   ymwZuY9m8T14ivISlBKx//EsAqIAzXu16AMO0AQidF14PVOtGYTuUl/0O
   hBBND/qthvJJMryVbwQcK8PvSyKzzM1ez8SSFrr4WT5m8aEn/ZNl8eN9W
   Q==;
X-CSE-ConnectionGUID: kCB5EPRaQiSMf7ECrxl9rQ==
X-CSE-MsgGUID: rDD93Z6pTMuIasD2nRigkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31496393"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="31496393"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 19:58:21 -0700
X-CSE-ConnectionGUID: SnWCYWfWTYm4KsasHgyTAw==
X-CSE-MsgGUID: tCPHR/58QA2oVwgK2BcKuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="59007393"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Jul 2024 19:58:18 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYd43-000sP4-31;
	Tue, 30 Jul 2024 02:58:15 +0000
Date: Tue, 30 Jul 2024 10:57:58 +0800
From: kernel test robot <lkp@intel.com>
To: Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz, tiwai@suse.com,
	corbet@lwn.net, broonie@kernel.org, shuah@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr, Axel Holzinger <aholzinger@gmx.de>
Subject: Re: [PATCH v2 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
Message-ID: <202407301002.SaoBM0NA-lkp@intel.com>
References: <20240729085905.6602-4-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729085905.6602-4-ivan.orlov0322@gmail.com>

Hi Ivan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.11-rc1 next-20240729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Orlov/ALSA-aloop-Allow-using-global-timers/20240729-171015
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240729085905.6602-4-ivan.orlov0322%40gmail.com
patch subject: [PATCH v2 3/4] ALSA: timer: Introduce virtual userspace-driven timers
config: nios2-randconfig-r113-20240730 (https://download.01.org/0day-ci/archive/20240730/202407301002.SaoBM0NA-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240730/202407301002.SaoBM0NA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301002.SaoBM0NA-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/core/timer.c:2030:1: sparse: sparse: symbol 'snd_utimer_ids' was not declared. Should it be static?
   sound/core/timer.c:230:12: sparse: sparse: context imbalance in 'check_matching_master_slave' - different lock contexts for basic block
   sound/core/timer.c:405:9: sparse: sparse: context imbalance in 'remove_slave_links' - wrong count at exit
   sound/core/timer.c:456:9: sparse: sparse: context imbalance in 'snd_timer_close_locked' - wrong count at exit
   sound/core/timer.c:492:15: sparse: sparse: context imbalance in 'snd_timer_resolution' - different lock contexts for basic block
   sound/core/timer.c:541:12: sparse: sparse: context imbalance in 'snd_timer_start1' - wrong count at exit
   sound/core/timer.c:596:12: sparse: sparse: context imbalance in 'snd_timer_start_slave' - wrong count at exit
   sound/core/timer.c:616:12: sparse: sparse: context imbalance in 'snd_timer_stop1' - wrong count at exit
   sound/core/timer.c:673:9: sparse: sparse: context imbalance in 'snd_timer_stop_slave' - wrong count at exit
   sound/core/timer.c:780:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
   sound/core/timer.c:798:9: sparse: sparse: context imbalance in 'snd_timer_clear_callbacks' - wrong count at exit
   sound/core/timer.c:806:13: sparse: sparse: context imbalance in 'snd_timer_work' - different lock contexts for basic block
   sound/core/timer.c:825:6: sparse: sparse: context imbalance in 'snd_timer_interrupt' - different lock contexts for basic block
   sound/core/timer.c:1049:6: sparse: sparse: context imbalance in 'snd_timer_notify' - different lock contexts for basic block
   sound/core/timer.c:1323:9: sparse: sparse: context imbalance in 'snd_timer_user_interrupt' - wrong count at exit
   sound/core/timer.c:1430:12: sparse: sparse: context imbalance in 'realloc_user_queue' - wrong count at exit
   sound/core/timer.c:1672:12: sparse: sparse: context imbalance in 'snd_timer_user_gstatus' - different lock contexts for basic block
   sound/core/timer.c:2412:9: sparse: sparse: context imbalance in 'snd_timer_user_poll' - wrong count at exit

vim +/snd_utimer_ids +2030 sound/core/timer.c

  2024	
  2025	#ifdef CONFIG_SND_UTIMER
  2026	/*
  2027	 * Since userspace-driven timers are passed to userspace, we need to have an identifier
  2028	 * which will allow us to use them (basically, the subdevice number of udriven timer).
  2029	 */
> 2030	DEFINE_IDA(snd_utimer_ids);
  2031	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

