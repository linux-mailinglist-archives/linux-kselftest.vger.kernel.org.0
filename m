Return-Path: <linux-kselftest+bounces-48897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8122D1BAAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 00:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96341302D886
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33551369992;
	Tue, 13 Jan 2026 23:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqAAh529"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC8335CB93;
	Tue, 13 Jan 2026 23:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345980; cv=none; b=KcIZy2X6gGlM5j4Zib5R0f1IICzHVB8UlrEkDXhdrUx9z59X3NEVlvWO5d/635cROUQM9gi8GuGHFi3wcv+P5FPUGeAQ75uBEjNPUT/ffydelTXlforaztNUigKr9vf03S/Kr3slDKGz5j0OIDTD3yMWQtyrzTrWWs4w7/vLWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345980; c=relaxed/simple;
	bh=tfux4HuM++A7BLYQlaWz5mpF//WwyNWgU6Ipl96sA5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIoomfMS18r7Qpy4BSLqBXioMPiXzEGH8tiDMwErwmJA5vDc2yRBjkQo2DI5qmtGXZhF2Ig0sNxNUXAbTRuldDG5o+xKDIks28l6CR605eF0goebpETeuQzWt3cLLJ8o1NJWAjP/X6V2LjjvrrjxWYDvPg5z2jQm6cA9IoeIfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqAAh529; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768345978; x=1799881978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfux4HuM++A7BLYQlaWz5mpF//WwyNWgU6Ipl96sA5I=;
  b=nqAAh529Wap5PRAuBNWOW1ERqtSVdKqybJiJ2X0aGgs8bkMDkE4Ogk5y
   SqEdgCbGQwAczu0baC93vAUgXpYKyBCfwFpAKxR67zSRxPXZwekkv8/SG
   DGRdgVLTHv+F2UMaWFVojMUMGh4pzIF73sZVGD7NtMy0Ud2FWZIEJduLL
   UCYWgXaIkMVhlzLSGTfPPEtUnVhL9gDQRFzrEIB8QOIf9uk9UjfTDe421
   3z/I6+EOQjSi742o7f2dNl2sVUimySh64fHhUcN4l08TkGLAqzhPOEmMH
   02V4ZU0eG0n3X+Tmu3jXTOGKmq+wmhwqVJjrJl5tuu0ZcRqztR6xvw2aM
   Q==;
X-CSE-ConnectionGUID: Dzp/q/EJQ3Sbq7j+4clz+Q==
X-CSE-MsgGUID: KQ/P4AJmQV2SNN53EoZ6WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69376945"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69376945"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 15:12:57 -0800
X-CSE-ConnectionGUID: kzgyrO3ORaOlo4V3eNE03g==
X-CSE-MsgGUID: IWu9cYVeQviBmeKCDLTDgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204307734"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Jan 2026 15:12:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfnZB-00000000FTo-04NN;
	Tue, 13 Jan 2026 23:12:49 +0000
Date: Wed, 14 Jan 2026 07:12:08 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <202601140749.5TXm5gpl-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-004-20260113 (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260114/202601140749.5TXm5gpl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601140749.5TXm5gpl-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: net/vmw_vsock/vsock: section mismatch in reference: vsock_exit+0x25 (section: .exit.text) -> vsock_sysctl_ops (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

