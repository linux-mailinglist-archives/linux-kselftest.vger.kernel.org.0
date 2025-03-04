Return-Path: <linux-kselftest+bounces-28248-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7AA4F0BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 23:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE01B188DDC4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 22:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C55204C34;
	Tue,  4 Mar 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5G5hRTz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1171F7561;
	Tue,  4 Mar 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128612; cv=none; b=gwdHfJmoPN3UZlO/7JjEJkeYjNwZXmBxyDu7tC3gsxySvap+xdYvl7KyFH71YuMgtFXZAUSO1bOp9esyoq/dEY6AF0hacliJg1Bl3I2xSWyGC+GbzUdNo0miODa+TFOC2fSMJQRcE1wRe/4abS8xtZja8RW8wNKr0XGg4gIIoT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128612; c=relaxed/simple;
	bh=lmqAu2pRTyzGtngpjLwnclpVd2w+T2QccFoyTGwIxFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Oxw1Dw7Sir8JivfJEu32wE0mc+aXH4eabd6UCWvhe7r7WarsxXxuFYM6E0/q8SWRdeu5u/g3ziRcACzjWy7q/7bf3Wj+zQvDHNeZnPLd//ROwA2m3dbyWWhVYcjVnd3rd29YLXg8eFkju0Fnn92eHJCtV+N+fVla+wFe18W43ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5G5hRTz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702EC4CEE5;
	Tue,  4 Mar 2025 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741128612;
	bh=lmqAu2pRTyzGtngpjLwnclpVd2w+T2QccFoyTGwIxFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r5G5hRTzpFf4wTBKkZXFATErnzRhl19ONjZy63rzu4qr0Y4XFVtk8yhQnZ63azrZ4
	 jEjaUMOJiqUPj0Y54iLW7dVTcv/ixR52Su0f009pkAq7XWrRnjaPYFFBH4C/L2XU5o
	 2JvKL/d+l0F/QNZYaRzTyYzWzPmeOaP0HjM4t0N8SkOndszxMSIppQahIW10/ZVy5R
	 yZraBgpLwa4QkzT0F0lhQedwTLAmsMLFUiZtqrr0QZ/S34ThAkVp3KBdVWRSI+cytk
	 hLH6D3ZDEvriifnLw+icXgmMAXC8ruDdHu79c69pWe/U1xpIiKVu+iyikVyuMoxMmZ
	 77uQnBw92eCgQ==
Date: Tue, 4 Mar 2025 16:50:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yi Lai <yi1.lai@intel.com>
Cc: ilpo.jarvinen@linux.intel.com, shuah@kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/pcie_bwctrl: Add "set_pcie_speed.sh" to
 TEST_PROGS
Message-ID: <20250304225010.GA261848@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8FfK8rN30lKzvVV@ly-workstation>

On Fri, Feb 28, 2025 at 03:00:59PM +0800, Yi Lai wrote:
> The test shell script "set_pcie_speed.sh" is not installed in
> INSTALL_PATH. Attempting to execute set_pcie_cooling_state.sh shows
> warning:
> 
> "
> ./set_pcie_cooling_state.sh: line 119: ./set_pcie_speed.sh: No such file or directory
> "
> 
> Add "set_pcie_speed.sh" to TEST_PROGS.
> 
> Fixes: 838f12c3d551 ("selftests/pcie_bwctrl: Create selftests")
> Signed-off-by: Yi Lai  <yi1.lai@intel.com>

Applied to pci/bwctrl for v6.15, thanks!

> ---
>  tools/testing/selftests/pcie_bwctrl/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/pcie_bwctrl/Makefile b/tools/testing/selftests/pcie_bwctrl/Makefile
> index 3e84e26341d1..48ec048f47af 100644
> --- a/tools/testing/selftests/pcie_bwctrl/Makefile
> +++ b/tools/testing/selftests/pcie_bwctrl/Makefile
> @@ -1,2 +1,2 @@
> -TEST_PROGS = set_pcie_cooling_state.sh
> +TEST_PROGS = set_pcie_cooling_state.sh set_pcie_speed.sh
>  include ../lib.mk
> -- 
> 2.39.2
> 

