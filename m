Return-Path: <linux-kselftest+bounces-25418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52152A22BC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 11:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636D7168EAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 10:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E381BD01E;
	Thu, 30 Jan 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YENIgAFm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B011BC07A;
	Thu, 30 Jan 2025 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233468; cv=none; b=NFVBpnxM/6/UTxy7IrBixMllqxdhzUz7K7MRE2ml57phhegRmnYp9cJyX2hpUkGE5FXUf4155Eyuh0zZIoqYOwDQAA5aLhvZPo2BFchDkf8408wuTBz7bHPQmgh5CCVlo5sZD+iSyflS20xdhYGvF9Ug5COzvZLYWMsx3nmdp3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233468; c=relaxed/simple;
	bh=aMiXgMRCIIw50Lsolr18CvrrPGFvk5T4nv8gIaefhvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3IIe2MT5vG1ufOHz+R161kRQWJKrcfM07ZWx8NaEatsf8A8fnv5unucFWC6IYZOGcRkTMM/sg9uPBIik5XeX53xEDcC8kKWiRukWWwgS4IW01mbWaI88ha2mnIzTMbNioiZ4ANWZyIT69OGejlnzbCQ5zNJQgY5jscIrQ1w6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YENIgAFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84D2C4CED2;
	Thu, 30 Jan 2025 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738233468;
	bh=aMiXgMRCIIw50Lsolr18CvrrPGFvk5T4nv8gIaefhvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YENIgAFmnF6+qyINsNj3SxZ3zFehXYAPkKcnF8jPEZLCtMGrUebT8QWEbU/KiI5XP
	 kb4y8NFLE/vPCsILJHiG3w1KtxGcaEGqPxNc/Tr+8jCi07SPpxXZA1x+WJ7q9eAWEW
	 Es6zZxiZ8wiZSRQK5UeqPEE5Zm9IqzvNxfLZ09yVkLSrWt86p0gpQCSlR+kKxp8KsO
	 zNZgMjcBXcmf7EBCufFENBsmWgKIrndFfwl+hBgkgdugB/6tV9eZ3l1nAis6EijpTQ
	 WC+PuoOiAPrPxjZgc75gu5I2Xc4LOOHNlaTjE/OnsvxTV43pXTzCrXPx9mOxvEa6gB
	 W5Rc5KPG+/62A==
Date: Thu, 30 Jan 2025 10:37:43 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 4/8] netconsole: Introduce configfs
 helpers for sysdata features
Message-ID: <20250130103743.GH113107@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-4-12a0d286ba1d@debian.org>
 <20250128161234.GC277827@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128161234.GC277827@kernel.org>

On Tue, Jan 28, 2025 at 04:12:34PM +0000, Simon Horman wrote:
> On Fri, Jan 24, 2025 at 07:16:43AM -0800, Breno Leitao wrote:
> > This patch introduces a bitfield to store sysdata features in the
> > netconsole_target struct. It also adds configfs helpers to enable
> > or disable the CPU_NR feature, which populates the CPU number in
> > sysdata.
> > 
> > The patch provides the necessary infrastructure to set or unset the
> > CPU_NR feature, but does not modify the message itself.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> 
> ...
> 
> > @@ -792,7 +817,62 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
> >  	return ret;
> >  }
> >  
> > +/* disable_sysdata_feature - Disable sysdata feature and clean sysdata
> > + * @nt: target that is diabling the feature
> 
> nit: disabling

...

Hi Breno,

With that addressed feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

