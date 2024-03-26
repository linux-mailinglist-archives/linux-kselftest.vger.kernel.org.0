Return-Path: <linux-kselftest+bounces-6610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA1C88BC1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 09:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7031C3002A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 08:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F755130AC8;
	Tue, 26 Mar 2024 08:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVd5tMVx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0456412AADB;
	Tue, 26 Mar 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440979; cv=none; b=CUuOFFRFYi+O5Ria73UWk+e5X8Lli/LNBgiIw/eUydaOfhemN9k1+/vQ9ff11DqNgNJxQX+2ZWMfWYAWNQ7D1nNvChHfpWyJf+jiZ3IHNCwJKQUE07VYK5/h9/2TATVlcBwfgcYPZhqmcFnldgqk6TgXZv7ZySvwb3yNkHd72h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440979; c=relaxed/simple;
	bh=cfHV3so/oLbM3PTbry+d/EPObawsMb4Bf5kpaemSprk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBGdkkbHr/cFCV+eNtWGzTsdJwwj3VpLc6OPUo9e4AnPUmYgbKmSnVJHRGcfCH/YFQA3XlNEhaXQ5bCoEeiR4hSEebDNRgjyW7ANb1Ye1CDjo3boOSr/ByopJiLQsEYVmUJotQBrvvpRBr2aOBIlMyDJlUOMS/4tjs6AsUZKoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVd5tMVx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711440977; x=1742976977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cfHV3so/oLbM3PTbry+d/EPObawsMb4Bf5kpaemSprk=;
  b=DVd5tMVxZ6ZyvZLGyjYshZlSIrnjODBR0j35FKLth35S8zuwLEXICJMH
   i0y5yyeNGfeM76nSB7+a8I/64e0UCB/ERv+JWokXcvqL1jMImduFDFEjX
   G4cKHpx+MIC20c/O1aBZH7yxLSNIjSSOiTTgU66VoMAgr7DzVLZ0flFhn
   wJCKzA3NbwJphzosTDjqWIHc5OGm+jQjVrf0RzT2qbPutbNfs028ocLYs
   ig+e5+dxylMJnKZ12whF5wJyFAVecSZvZki6xGpdlm4OXM6MBJ+Wft2Ly
   +ykoQI202+5hyh1SPbdmAPWPrwrS8eL09K9PkX/JRGuCeRe93OFwNtX7T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6370621"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6370621"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 01:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20603139"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost) ([10.239.160.36])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 01:16:14 -0700
Date: Tue, 26 Mar 2024 16:30:09 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Use TAP in the steal_time test
Message-ID: <ZgKHkd+qpE4XsiOI@intel.com>
References: <20231019095900.450467-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019095900.450467-1-thuth@redhat.com>

On Thu, Oct 19, 2023 at 11:59:00AM +0200, Thomas Huth wrote:
> Date:   Thu, 19 Oct 2023 11:59:00 +0200
> From: Thomas Huth <thuth@redhat.com>
> Subject: [PATCH] KVM: selftests: Use TAP in the steal_time test
> 
> For easier use of the tests in automation and for having some
> status information for the user while the test is running, let's
> provide some TAP output in this test.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  NB: This patch does not use the interface from kselftest_harness.h
>      since it is not very suitable for the for-loop in this patch.
> 
>  tools/testing/selftests/kvm/steal_time.c | 46 ++++++++++++------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


