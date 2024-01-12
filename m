Return-Path: <linux-kselftest+bounces-2889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F11282BAE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 06:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C08B24D9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 05:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27A5B5CE;
	Fri, 12 Jan 2024 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8dcbZV4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C95B5C6;
	Fri, 12 Jan 2024 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705037690; x=1736573690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+D2V+TmU64uAjVM3eOUsnNLgN7TXw+iA4jUZDqS1rPI=;
  b=n8dcbZV4NpW6fR1kGVjAYLofnDfZNaIO8/fR+F0dACcLh+l0K4O8TJea
   2u9DaKLCLhqZ4SmDOqY1bMoK/F7SM+hVJjY0i5alCg5VMCZJHouODQ0yP
   LngNtbkM6sq6t5uCZp8nbxgdpb8Wag+etPQQQJ6eRKgTLYweqwWM4DX/v
   n/PNLP3e9Kp1/SociQ7iy/tZHJl+YVw4kQ89d+jws62t6Tky8ECvk+y0v
   PtaFPvkzOsqgIm4HwT69NipNcPErmvWMvXrtJL3rB/FKJazXJzcXjTTwD
   /tj5oZrX6hBXoNfrl57IsVll3edSZ46s1JtMZk1zg4Ni1q9Ha8xCr/PJj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6173688"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="6173688"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 21:34:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="24599545"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by orviesa002.jf.intel.com with ESMTP; 11 Jan 2024 21:34:48 -0800
Date: Fri, 12 Jan 2024 13:34:46 +0800
From: Yuan Yao <yuan.yao@linux.intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
	seanjc@google.com, shuah@kernel.org, stevensd@chromium.org
Subject: Re: [RFC PATCH v2 2/3] KVM: selftests: add selftest driver for KVM
 to test memory slots for MMIO BARs
Message-ID: <20240112053446.cywurmvjebuavsf6@yy-desk-7060>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <20240103084457.20086-1-yan.y.zhao@intel.com>
 <20240104081604.ab4uurfoennzy5oj@yy-desk-7060>
 <ZZfP3/pYyPnbgL3P@yzhao56-desk.sh.intel.com>
 <20240110062708.zf3arjmha5czgpzp@yy-desk-7060>
 <ZaCGCS6xY2KXubf8@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaCGCS6xY2KXubf8@yzhao56-desk.sh.intel.com>
User-Agent: NeoMutt/20171215

On Fri, Jan 12, 2024 at 08:21:29AM +0800, Yan Zhao wrote:
> On Wed, Jan 10, 2024 at 02:27:08PM +0800, Yuan Yao wrote:
> > > > Do you have plan to allow user to change the bar_size via IOCTL ?
> > > > If no "order" and "bar_size" can be removed.
> > > >
> > > Currently no. But this structure is private to the test driver.
> > > What the benefit to remove the two?
> >
> > It's useless so remove them makes code more easier to understand.
> Just my two cents:
> Keeping bar_size & order in a device structure is better than spreading
> macro BAR_SIZE everywhere and the code is more scalable.

yeah, that depends on the perspective, no big deal to me.
You can wait other's input.

