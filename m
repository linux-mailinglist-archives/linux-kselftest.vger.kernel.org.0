Return-Path: <linux-kselftest+bounces-48856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18248D192F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4DE1302D2E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142553921F2;
	Tue, 13 Jan 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnOpY8CE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D85255F5E;
	Tue, 13 Jan 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312459; cv=none; b=onWwUy6Yypw7jB0VKyuPx0Rper/VA48vpynZlW+GHASug0ZtytmWHT3dqerby+kMEwjGmocOa3zJFKthXsGAdK+NS7Jg1oLQyk9WG6DySfhG3GGSfA2J0Z/+4/9g5LXR+xDHP53gQHrh9+f2sxFMBei6hSfRVhgN207oTXL+LL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312459; c=relaxed/simple;
	bh=+bhepDGuDR6MhZWdEj77cvVlTGoNDFhvxgoQK+HG8cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/wHilKtHu8C63mQUy4K33/fYs9THsF3tgpPPhMLhWiKbt7J97Jb8VXdLEhk9PpgrHflj7EIi7Xu1VcyAWut4UgDqSIhrhR/MH0RXwtYdPn+JGMPEW/94RXkGq/bGwuq9EE0+mdbcdCcqmedAJ4TcI5XuIVncZWJgCDomNx/giI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnOpY8CE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768312458; x=1799848458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bhepDGuDR6MhZWdEj77cvVlTGoNDFhvxgoQK+HG8cY=;
  b=AnOpY8CEbmdo2dNDJhZsO9dsiY/KtLXLMR/OcqPnnwHF8gO6fLMxI2Oo
   /VPdxWjc7+xofgAMOYozpMWI77wrvhERkToIWjtuRMyq8iHA/NHbQbF91
   Pgrv0krni1qLLXydQN0wCw4J2RW6Qn1Ka01MpQs0exUPvrWrnLd86PYsa
   iA3MAnd1JZG0FTxUvucTNjapFVdM9iaYSYkIcIumPb/9kqUjbnOcXdF7K
   AhKFIKxjp/7+LcMeVk1t0W2H1zdKAQZQLLuQ+w3oON74Z2gRE1BJd1Kju
   htD8+nD8VtuQPLW1Sp6/rru9J25CukFYFrzGN9vq2Dx7TYASnVSZ5jhKR
   A==;
X-CSE-ConnectionGUID: s5YjPEpVRfSuGOmsSDuoDQ==
X-CSE-MsgGUID: nWBsFUCfRAmu4aevwFhk3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69518449"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69518449"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 05:54:18 -0800
X-CSE-ConnectionGUID: S18dgBAeToiEfghkImEGvQ==
X-CSE-MsgGUID: kD+YWK5HRN66BnGy6WLQVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208550518"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Jan 2026 05:54:10 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfeqV-00000000ErM-25kG;
	Tue, 13 Jan 2026 13:54:07 +0000
Date: Tue, 13 Jan 2026 21:53:29 +0800
From: kernel test robot <lkp@intel.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Long Li <longli@microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <202601132126.k8ZgzA9M-lkp@intel.com>
References: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>

Hi Bobby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Bobby-Eshleman/virtio-set-skb-owner-of-virtio_transport_reset_no_sock-reply/20260113-125559
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260112-vsock-vmtest-v14-1-a5c332db3e2b%40meta.com
patch subject: [PATCH net-next v14 01/12] vsock: add netns to vsock core
config: hexagon-randconfig-002-20260113 (https://download.01.org/0day-ci/archive/20260113/202601132126.k8ZgzA9M-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260113/202601132126.k8ZgzA9M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601132126.k8ZgzA9M-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: vsock_exit+0x34 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: vsock_exit+0x38 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

