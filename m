Return-Path: <linux-kselftest+bounces-6185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D8878011
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9E11F2184D
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9825755;
	Mon, 11 Mar 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3ctDCSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433B122075;
	Mon, 11 Mar 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160787; cv=none; b=LyzgJU7K8YpRWbtNt20n2+ZnO1NXUwI58SVDyizqjkuRBIeqR3Ng5w/L0byC07LYxmzM12cJ7RosH85eXkqlUllAjmJLxC+z2LI3f5Qw9HRR0uCHwxCCNAjyJrrEWox4spEOhSOTWLEPLOE4J9ZYYOgQLoGDAEjG1++aZQ4FAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160787; c=relaxed/simple;
	bh=Mue2Gxnjnz+y7+UdTMk/8YtlTakb04KMp4OBMQYNzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp/3LzqtP3o6z6cOV1I0WJczRPkvYTFRvTjH2eKblmW3+/zhqBtt+ag3K/lfbiEBipxq9vHdP/076IJY8egzbrCuiPkEd+RTDCkWF4tAnmINekP2/O+UMuyx1RfVo3V2cbEQb7zdAccvnTgqbMIfPj99yD8lzbdj9AAIo2Bs6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3ctDCSQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710160785; x=1741696785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mue2Gxnjnz+y7+UdTMk/8YtlTakb04KMp4OBMQYNzDg=;
  b=K3ctDCSQOySKh2R6R0GSMH/ghRMFHoeXjozvWwlEIxLp8nQRnJIi3nUh
   RvDzQBGI2PmgUhqwJLWAh32fjaeLCkMDM0bN76/WV+swu0U9cqTKX16Ut
   qZj4L3uzmPYfhVRbSDqtBmShU0aTLicH9WZDxi+9Uaj9ixARhzscL2qz7
   B0NWK/toJibNR8tTnH636oaZBwPSIRkBbZNJUGbbtDhv/1RY2DjqGUj3v
   7plHpLcpJzZpzFwl2dEx5BaehfJYtZOmKDPkmTOSTVo9aGIih+dBb/wkW
   lZDQ2AwVRZotYJkByhSkgbuVLnri4Ku1tECJcLk7Chu6aWakZKuIFXlWA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4663042"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4663042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="937049752"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="937049752"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2024 05:39:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5D6FF177; Mon, 11 Mar 2024 14:39:40 +0200 (EET)
Date: Mon, 11 Mar 2024 14:39:40 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, 
	"Chang S. Bae" <chang.seok.bae@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Weihong Zhang <weihong.zhang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, angquan yu <angquan21@gmail.com>, kernel@collabora.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
Message-ID: <zictuia2d66mhb4hdr436quvkyef5a433pnem2yoxgybhbrki5@54vv3sk4sxkl>
References: <20240307183730.2858264-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307183730.2858264-1-usama.anjum@collabora.com>

On Thu, Mar 07, 2024 at 11:37:22PM +0500, Muhammad Usama Anjum wrote:
> diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
> index 215b8150b7cca..c0f016f45ee17 100644
> --- a/tools/testing/selftests/x86/lam.c
> +++ b/tools/testing/selftests/x86/lam.c
> @@ -1183,7 +1183,7 @@ int main(int argc, char **argv)
>  
>  	if (!cpu_has_lam()) {
>  		ksft_print_msg("Unsupported LAM feature!\n");
> -		return -1;
> +		return KSFT_SKIP;
>  	}
>  
>  	while ((c = getopt(argc, argv, "ht:")) != -1) {

Looks good to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

