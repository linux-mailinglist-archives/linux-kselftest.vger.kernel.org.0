Return-Path: <linux-kselftest+bounces-37373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D9B06542
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 19:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312B216A6F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 17:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A222E2874F7;
	Tue, 15 Jul 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nA7UpD6y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A082868B5;
	Tue, 15 Jul 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601047; cv=none; b=TLLYwjcD5z76Cx/YyBiKQhbZXL2LkGeePBFDUok0k3wXQvVJ1EmyrprYlW74pEbdht3QFbf0P1xihFosE+7Y5lDtBTxchnPrKhYYjwtq5J9lzJP+m4swD/kwqaWaCeDxUlz+40KJpFvpPFobb7IIcQpzZYX0KE6dNy6kXExT+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601047; c=relaxed/simple;
	bh=8AgQS+Cb1TP+dRcSbrfn/4MUpirrtqrxKm9XtZ08b2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmjz+/MWKAPLkn3DJRVUT95vRqSGjsxqwthG1hJ+dKyVaMg5wBfmXEoKfFNzEYSru1ZYblFag0S8JNWyjkI77tyRif5JtQ4hd5HFSvPb+oywNvAmdFryGsmf1IMqvta0mjm/c6rT50p8x1B4/RDhuv+LMJoOPc5tZXwBZKhq6bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nA7UpD6y; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752601046; x=1784137046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8AgQS+Cb1TP+dRcSbrfn/4MUpirrtqrxKm9XtZ08b2c=;
  b=nA7UpD6yeQxh9qsHC3XTvaX7qiwBpLkbPTR2gjA3oeh5zPbBh+5u/ytR
   hp018q1PVygKvkvXmnSuNgILfDX2c1u0vn5PFCVHoHdHBJOGgEJiOLrc+
   sZVUCRBAaEDkxG8CvqLYT1KRek2C59Qf/mf4Amxfr7qfYP81ZkXBmqFgD
   ylEFxQOCdtSu9Et/xukQtzbevjxo4s6sYIgIDJKLC+CPykYzaqqrvV1f4
   0WmScwJK5ndc6ELW56ztyq7Q4IJiGprGqsNlA7m4wYavLuJlJPBO6yLHZ
   ANLsD54cSDxS3HrEWKxfUPGlP3F0sklno+giQ5WSG0x8mEnhKEjt2drd+
   g==;
X-CSE-ConnectionGUID: Ph6DjMbRQ6WMyCLZomtRXQ==
X-CSE-MsgGUID: vDpRAiB6T2mOFvwjdC5EQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="53944862"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53944862"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:37:21 -0700
X-CSE-ConnectionGUID: Ee+pO6bzQP+wYLSfxqj40w==
X-CSE-MsgGUID: /3hacP+xQVGfCZekUD5Y5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="158009571"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jul 2025 10:37:15 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubjab-000BOJ-1X;
	Tue, 15 Jul 2025 17:37:13 +0000
Date: Wed, 16 Jul 2025 01:36:40 +0800
From: kernel test robot <lkp@intel.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org, cratiu@nvidia.com,
	noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
	mohsin.bashr@gmail.com, jdamato@fastly.com, gal@nvidia.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next V4 1/5] net: netdevsim: hook in XDP handling
Message-ID: <202507160103.dqVvaCEE-lkp@intel.com>
References: <20250714210352.1115230-2-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714210352.1115230-2-mohsin.bashr@gmail.com>

Hi Mohsin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Mohsin-Bashir/net-netdevsim-hook-in-XDP-handling/20250715-050721
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250714210352.1115230-2-mohsin.bashr%40gmail.com
patch subject: [PATCH net-next V4 1/5] net: netdevsim: hook in XDP handling
config: m68k-randconfig-r121-20250715 (https://download.01.org/0day-ci/archive/20250716/202507160103.dqVvaCEE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250716/202507160103.dqVvaCEE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160103.dqVvaCEE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/netdevsim/netdev.c:342:20: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/netdevsim/netdev.c:342:20: sparse:    struct bpf_prog [noderef] __rcu *
   drivers/net/netdevsim/netdev.c:342:20: sparse:    struct bpf_prog *

vim +342 drivers/net/netdevsim/netdev.c

   331	
   332	static int nsim_rcv(struct nsim_rq *rq, int budget)
   333	{
   334		struct net_device *dev = rq->napi.dev;
   335		struct bpf_prog *xdp_prog;
   336		struct netdevsim *ns;
   337		struct sk_buff *skb;
   338		unsigned int skblen;
   339		int i, ret;
   340	
   341		ns = netdev_priv(dev);
 > 342		xdp_prog = rcu_dereference(ns->xdp.prog);
   343	
   344		for (i = 0; i < budget; i++) {
   345			if (skb_queue_empty(&rq->skb_queue))
   346				break;
   347	
   348			skb = skb_dequeue(&rq->skb_queue);
   349	
   350			if (xdp_prog) {
   351				/* skb might be freed directly by XDP, save the len */
   352				skblen = skb->len;
   353	
   354				ret = do_xdp_generic(xdp_prog, &skb);
   355				if (ret != XDP_PASS) {
   356					dev_dstats_rx_add(dev, skblen);
   357					continue;
   358				}
   359			}
   360	
   361			/* skb might be discard at netif_receive_skb, save the len */
   362			skblen = skb->len;
   363			skb_mark_napi_id(skb, &rq->napi);
   364			ret = netif_receive_skb(skb);
   365			if (ret == NET_RX_SUCCESS)
   366				dev_dstats_rx_add(dev, skblen);
   367			else
   368				dev_dstats_rx_dropped(dev);
   369		}
   370	
   371		return i;
   372	}
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

