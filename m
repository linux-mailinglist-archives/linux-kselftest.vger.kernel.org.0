Return-Path: <linux-kselftest+bounces-24393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B9A0C095
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11576168039
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC511D356F;
	Mon, 13 Jan 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="es15qPXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C901C5D48;
	Mon, 13 Jan 2025 18:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793432; cv=none; b=EZ3qXRFAGR6q3H2fQmER2Nt+72nzrvfkbw1QzjYr1k+x2SLQxbejJ2ej/wKRKJ4HtTgfKMbgXrkYcF+28X2AZanXGHhQhUquF3nkE4fg8XNcVsr8pdnER66xUwkhyoPImuS1RUe+oTS9RYJ8HWVrCwSn9jfftD2kzrClbuw7euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793432; c=relaxed/simple;
	bh=6+VQ9THEiI1ZZwCSRtko4jOaY2YLpIP247O/uPa3z10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW948Mbx5LNhWIAHFBgOH6BbFdzg/N9uGUTBFWFtoYEN02UVEZ4z8NkVAcWVDCb95qxvmvTg0ZspQCa1w0MCFUtGXw5A5jfJdE+xhhTIvedpr5dEFdKlBw4i/pyqRuz5a6CNSz4HMabuxlm4il738nrtAh0DBYS+LCb8OmtsMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=es15qPXi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87A7C205919B;
	Mon, 13 Jan 2025 10:37:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87A7C205919B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736793424;
	bh=djdn6sUoKPo5R33GjEHz1PAs/0o/NCncJlCI8ioGXwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=es15qPXijfZL06qCowo3I7Brl146r1IQiqqu3zRdkif5KMsBme4h96h2GaXQCfhgc
	 9L2bM/vfvpXbwqY/tesh4BwI4MMKr+kReIKqO4kwAb7m8slwRle3iQLwnHM1fwnDpk
	 /XBPlO2MxBaJ4bxSW4If8zH9oVOx8g+EeJgm15H0=
Date: Mon, 13 Jan 2025 10:37:02 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: brendan.higgins@linux.dev, davidgow@google.com
Cc: rmoar@google.com, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit: Introduce autorun option
Message-ID: <20250113183702.GA10431@skinsburskii.>
References: <172920085854.4578.9203147717033046574.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172920085854.4578.9203147717033046574.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Thu, Oct 17, 2024 at 09:34:25PM +0000, Stanislav Kinsburskii wrote:
> The new option controls tests run on boot or module load. With the new
> debugfs "run" dentry allowing to run tests on demand, an ability to disable
> automatic tests run becomes a useful option in case of intrusive tests.
> 
> The option is set to true by default to preserve the existent behavior. It
> can be overridden by either the corresponding module option or by the
> corresponding config build option.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Good time of day,

Could you update with the status for this change?

Thanks,
Stanislav



