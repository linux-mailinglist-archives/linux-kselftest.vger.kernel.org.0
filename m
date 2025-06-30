Return-Path: <linux-kselftest+bounces-36090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCFBAED92D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D56189846C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 10:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6129D24166A;
	Mon, 30 Jun 2025 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRDTHx7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32375221726;
	Mon, 30 Jun 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751277632; cv=none; b=h6Gr6RdgMdFY288mjn0wvZIy5P0yNtcT/InbFjJx21fUFOxnnTuCYXaOeC7BvnZYXR7nNvEmL3MltFYWt70v0AYLYBHGVad1/o9k5zQrKsAqtY3BzU4pxNXSzZcMgN12lN4maSVh8IKTSwN9TAuyh3h6spHXvIECXaJ+q4/Mo3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751277632; c=relaxed/simple;
	bh=9spNnoYwI1cRqx/qxDV7MvKkpSEQhiTrDNLBhi150G0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIs9hhaq0CamJen6tX0Ifh/+JGrieys6bMUqRtvUwTNS9IcNvleE2Zeczzoy6LobwToiNGMFdIqz2n6P5gvpEjy7feDLmfbeADQrmWZ0aF0D/RPnU1m5Lg/tCIU/bP8l9R5JJi7OL4BtQEljG3ssUkPlZxq3rhpGEVxqJ0gmCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRDTHx7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF44DC4CEEB;
	Mon, 30 Jun 2025 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751277631;
	bh=9spNnoYwI1cRqx/qxDV7MvKkpSEQhiTrDNLBhi150G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aRDTHx7jOwU8HdIYA42uAt2zXj+WuM7rWA9DcY8yRdt+WP3WKhWBlYc/6OLtLaEct
	 s7UT0K8IkaxGSPBvLoY7PIHCDTZPhS5B4lDkvTtDEBR9DSS1DNdSZhws/smtP5hn89
	 Uns9AupYJakYVVuy2D+Fjj8PlLlxe4EzkYxdnewS4tr+1viiG6CBq80CFNGknvbgdM
	 4F5HTCkLGtAe40p/Opxl1/bFLdPeQvixaiY1Yk6BChSEEDAlMeQov3Z4IPqlRfmQE9
	 srJxM4TKpndnwgdVg4xiRL3Dwkk1yQmB518od3ddTmDeeGYupdLKYaFoJ5QRlRUxGV
	 vAx9JZXp4CWsw==
Date: Mon, 30 Jun 2025 11:00:26 +0100
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v1 1/2] selftests: pp-bench: remove unneeded
 linux/version.h
Message-ID: <20250630100026.GA41770@horms.kernel.org>
References: <20250627200501.1712389-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627200501.1712389-1-almasrymina@google.com>

On Fri, Jun 27, 2025 at 08:04:51PM +0000, Mina Almasry wrote:
> linux/version.h was used by the out-of-tree version, but not needed in
> the upstream one anymore.
> 
> While I'm at it, sort the includes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271434.Gk0epC9H-lkp@intel.com/
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


