Return-Path: <linux-kselftest+bounces-40165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E702B39A65
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74813A6AC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591530DD12;
	Thu, 28 Aug 2025 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EI7KTp8P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4830C624;
	Thu, 28 Aug 2025 10:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377376; cv=none; b=GYthD3XFuJQmHG7EBQ1zGTpB2M5osfNprwX1EsE16wwlemr6pkZpir74O+MpHIanTiPVgk4kYpdo+A8bGST7wGFVTZZkYJamp+32esO8KP2F9S6qFwERI5cSJ3Kfd58CK1pFjBw98ftdk9o8CR6YvYH3bnGlLx9TALCLWnak8lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377376; c=relaxed/simple;
	bh=Q++vDmJGmmqheRrUrP0W8dSS7fcanjr4UJG7gMXFg6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7DDjoJPCp8LD1C60kAwgxpCgiay8rN3pnCh2v47+bHZ+M129APzGpuKgIoUrei4PQLe+fYhYxjdjZAuuQ9MNNasBCUTMoX7HMRtSy7JLRc4UZNBrEehT3jmT+sSDBm5hLm2VMEcyGht5odhEWAD+BfmCJx4383Vl6PZoodAGCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EI7KTp8P; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756377375; x=1787913375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q++vDmJGmmqheRrUrP0W8dSS7fcanjr4UJG7gMXFg6o=;
  b=EI7KTp8Pkv/KuGNq6iMaeNGcX7oZqe/zW0XobJEVyWN6WEk4vnqBfXxZ
   iR20JrwF36o2mPO7G/MpIAHjbxliRSqsbdufmH34IGVbtRN7ZNnmQnMrH
   Bmc1hq9BtGcCgdqArDgwKAfiUyPDLb0ZTKSiCLbeDRcTk7G4QYTpOK4cB
   5PhY8Y2wsjCNyzZ3FO0PHyELe5DM2RFeVNLhA3pwoxKpsAnwAgxiByMF0
   6Lm1GGW2hF502wVVSTkez5qADgmkrdekkt+yKjbcZb6+gTdCnJlIXWVwZ
   TtAKFU5P4QyV3V68l4Su9p5PYjQh9DfLDyQd0/eI3Xv0qMiUivx0vYr5i
   g==;
X-CSE-ConnectionGUID: J+9phYcOT5ihtlS0WasbOg==
X-CSE-MsgGUID: 8TSymqXeTmC3pFCMFRhIJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="62465683"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="62465683"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:36:14 -0700
X-CSE-ConnectionGUID: 0KXzwk6SSTqEhED/Xo7AIg==
X-CSE-MsgGUID: uo1IoHNKR1Gi41sgQk9IWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="200992693"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 28 Aug 2025 03:36:08 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urZzC-000TeJ-18;
	Thu, 28 Aug 2025 10:36:06 +0000
Date: Thu, 28 Aug 2025 18:35:21 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com
Subject: Re: [PATCH net-next v5 4/9] vsock/loopback: add netns support
Message-ID: <202508281824.3XZiIgxs-lkp@intel.com>
References: <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-vsock-vmtest-v5-4-0ba580bede5b@meta.com>

Hi Bobby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 242041164339594ca019481d54b4f68a7aaff64e]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/vsock-a-per-net-vsock-NS-mode-state/20250828-083629
base:   242041164339594ca019481d54b4f68a7aaff64e
patch link:    https://lore.kernel.org/r/20250827-vsock-vmtest-v5-4-0ba580bede5b%40meta.com
patch subject: [PATCH net-next v5 4/9] vsock/loopback: add netns support
config: nios2-randconfig-001-20250828 (https://download.01.org/0day-ci/archive/20250828/202508281824.3XZiIgxs-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250828/202508281824.3XZiIgxs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508281824.3XZiIgxs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/vmw_vsock/af_vsock.c:137:35: warning: 'vsock_net_callbacks' defined but not used [-Wunused-variable]
    static struct vsock_net_callbacks vsock_net_callbacks;
                                      ^~~~~~~~~~~~~~~~~~~


vim +/vsock_net_callbacks +137 net/vmw_vsock/af_vsock.c

   136	
 > 137	static struct vsock_net_callbacks vsock_net_callbacks;
   138	static DEFINE_MUTEX(vsock_net_callbacks_lock);
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

