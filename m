Return-Path: <linux-kselftest+bounces-16328-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5975695F8DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 20:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF5DB21A07
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1680034;
	Mon, 26 Aug 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kduJ2JbL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3972B9B0;
	Mon, 26 Aug 2024 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696373; cv=none; b=JWpnSMkBU46J8L9A8qfIR1QIXXFjk2hhI8KegllDG+ciUpI42oFVWW7dBd3omrgxPv5md1MY5Zz3ZspQma8Nsicx9SGe7JKBZlie8F3SHlykJIkK6vOWP1bITpvZ+bWBfyuk2H7o/VlK2cEN+64Jj3kC0kB/FnrX+NF3mJKP/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696373; c=relaxed/simple;
	bh=HiDwydrWBWpTLMEtWaYGMPMkxiH9FwgHVIe1nh3vqYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teUdFbh6AS7O/ips+ZbGBY2SwIrRht9Z2drwfM1Yk/p610pNKdDHCdTPrkJh4IMGw6XB1Kalccq6ZJx+IwfUuxMpm9rODFR4MH6O0wtqH9XXvDdK9MDMheN9N2QUnLfwMQXridJbL44CZ7vJzyVQREHHxeR/eJQhzGgdhxyMnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kduJ2JbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09C3C8B7D6;
	Mon, 26 Aug 2024 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724696372;
	bh=HiDwydrWBWpTLMEtWaYGMPMkxiH9FwgHVIe1nh3vqYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kduJ2JbLCqIIKpuhel8LiEP2z2QShwqhJOtFQ/XDxZMaphDHKvrPXqNGFqQuOUbaf
	 Heu7roiz5ohUXt+DoB28quzUY0G5HbO/tWQgUUyp8bZvdrUDqu//fqtRi9EXkY/MOE
	 bBsj1DYccy9R/1YBGeXrR6HwQ+K/iDsDavhd8zBSRZLyXdgek74bIUW0r2+mE3FJU3
	 xTmrdF20RMd8CV1uSye1UCzH1CTFX4cRFXcpN8ESDYTQ4QXL3eIe0/yHrnCJflqFob
	 ttKSD6/uNiWQKhA8PGZoaSxiNsFRdg8vPkYUnSAv4foLVLDFHOPDu1L9Rd/mypiSx0
	 rLgae+SrIrNEQ==
Date: Mon, 26 Aug 2024 08:19:31 -1000
From: Tejun Heo <tj@kernel.org>
To: JoshuaHahnjoshua.hahn6@gmail.com
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
	shuah@kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] Tracking cgroup-level niced CPU time
Message-ID: <ZszHM_UV24aSWTC8@slm.duckdns.org>
References: <20240823201317.156379-1-joshua.hahn6@gmail.com>
 <20240823201317.156379-2-joshua.hahn6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823201317.156379-2-joshua.hahn6@gmail.com>

Hello,

On Fri, Aug 23, 2024 at 01:05:17PM -0700, JoshuaHahnjoshua.hahn6@gmail.com wrote:
> From: Joshua Hahn <joshua.hahn6@gmail.com>
> 
> Cgroup-level CPU statistics currently include time spent on
> user/system processes, but do not include niced CPU time (despite
> already being tracked). This patch exposes niced CPU time to the
> userspace, allowing users to get a better understanding of their
> hardware limits and can facilitate better load-balancing.

You aren't talking about the in-kernel scheduler's load balancer, right? If
so, can you please update the description? This is a bit too confusing for a
commit message for a kernel commit.

Thanks.

-- 
tejun

