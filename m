Return-Path: <linux-kselftest+bounces-15405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7CD952FE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F147D1C24C1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A4F1A00CF;
	Thu, 15 Aug 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPEqGsa4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298B19FA92;
	Thu, 15 Aug 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729026; cv=none; b=gFo1JSPFMG8eDC+0NxrSm7LpJywvudXR775k2x/3VJfyqOaR9gRcwFoROOtcp7YAml/Xk51nlSsYNiP2ZCMMGBD2rMOP8B8oOsZ/EuqQA9cyM2oaMv78+opk56t/MvvSi7jaISGSqBHD2mgp3rYzUjvGvMH9i81+/XW9FpGWWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729026; c=relaxed/simple;
	bh=C0REqQ8bYvLooFvtBXI3ykCRV2HA3TZfc6hkK4WOSSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JImw0bC1d8h5Eiz306Dqo0sdbRS1mA7UIJ5741Rl/cT911+VB7xHmqYQO+vAhj8GRP73F3Hhs039UO+ENr0wpVFIeQowzFz5SG+zqyuB5WQ+f8EpwECCsAoU2BlkHHAS5UJt/6bpDRP2e1P91DP0mmLXBlpFvucp9d3sIY1Hfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPEqGsa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBC1C32786;
	Thu, 15 Aug 2024 13:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723729025;
	bh=C0REqQ8bYvLooFvtBXI3ykCRV2HA3TZfc6hkK4WOSSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IPEqGsa4HiknOQDc9sMqE8vB54t15nDwA6eIwtVJ+APpbDFH/EJGjrA1h9tNAsgKS
	 oCKObwOnHcDlqwezKfcDs4WXgi8P4X1xQvkao9VMnigQRF7BOA2+qQv+ck9k+nsZfx
	 4eXbKHvrHeaURZDB1nCECv85WV9M/wTk+GS+Q6nKCCfXS03PAbFycPDKG3oWlTdOo5
	 JeWIhuaApO/OsK/fRRg7b1JqYlsF3kDJgpe6rkrd0wEj44dcE7qX6U/iJ+D+vttCiZ
	 iYg7Rhtu6bt4rP5na8qflLqE1JT9lJ0P3ZxGzHjyiIAT6u/Ff+E2JuWPAejWA9OJAN
	 A6Zr0+voFjV0Q==
Date: Thu, 15 Aug 2024 06:37:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 liuhangbin@gmail.com, petrm@nvidia.com, matttbe@kernel.org, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, David Wei <dw@davidwei.uk>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org (open
 list), linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST
 FRAMEWORK)
Subject: Re: [PATCH net-next v3] net: netconsole: selftests: Create a new
 netconsole selftest
Message-ID: <20240815063704.0d83c8f8@kernel.org>
In-Reply-To: <20240815095157.3064722-1-leitao@debian.org>
References: <20240815095157.3064722-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 02:51:44 -0700 Breno Leitao wrote:
> +CONFIG_NETCONSOLE=m
> +CONFIG_NETCONSOLE_DYNAMIC=y

It's missing dependencies, configfs but maybe more.
Please test the build as described here:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style#how-to-build

