Return-Path: <linux-kselftest+bounces-42479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32163BA3FE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F70C189F031
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C172F7AD2;
	Fri, 26 Sep 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3C7fGrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6994A19CC0C;
	Fri, 26 Sep 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894949; cv=none; b=Ya72IHoj3ys975XhM3zzuWX9iewb9bkfnypIBioD+8e1w9+4ha1z1DWfwulCk41POLr0xvb8LIckuGf8b1P1yNLXnFsQYV/EmO1rqDJyQNJq1Wi91ZxD2sojkGueA/aUVWiY6OgjDs7+6eZlhLvagM3+Kcv4yLl1FOtyt0zw8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894949; c=relaxed/simple;
	bh=4VAqWWI3OS29sqBNVGKsdaNsKc/MGtsp6/KLxrF7hWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bm9rY8FvJrJQeEIVOXKUPdBWwJ5rhTiCAuaoYkL6iwnqJXlhxriID2h3djRp+PfxeviPf7jefDvHov6Y7rOhHi7cc3oKMZoxTSIPxUjWlUxVcOdHuaABQb45xpnZI5jvVqPbwYhm86z3IptaYagdSNg6ivJPub236LEt1rc/Aak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3C7fGrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF80C4CEF4;
	Fri, 26 Sep 2025 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894949;
	bh=4VAqWWI3OS29sqBNVGKsdaNsKc/MGtsp6/KLxrF7hWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3C7fGrh6//14Zc0DDlIlpHZVc/yLjlN5Yin34j2uvHRBfzkYbXl1BgjE5nrWnWk3
	 Ol5sBLGGNZ8YjROxbJff4mFx6GdTRmDEqQlMVo1T0PRE18QJEX5qFn/e64m1LwtVXo
	 ilZInxAYpFH+aROZNPVH8eXKLtCtl7l1Lecs8UjyGGNtcFyR+sODJ6trg6hl0NEARb
	 X/7pwjnzoGH1neMroVCNgnHCkCxK7POUNJKNMxSy8xDu/A3iGZWTHvjAP6ox2hi6G1
	 l2W9bGhM5qLnebw+MTXuY4jw+mLAS+DIElyQAMvJ+9Xxp3C8fHNasuv51parr0PWbk
	 HHDW63zXJVlZg==
Date: Fri, 26 Sep 2025 14:55:45 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 09/13] selftests: net: vlan_bridge_binding:
 Rename dfr_set_binding_*() to adf_*
Message-ID: <aNabYRHihwnZLTLH@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <5f0c81b39e9e1f56f706cc4b53f82238a1d1e2f9.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0c81b39e9e1f56f706cc4b53f82238a1d1e2f9.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:52PM +0200, Petr Machata wrote:
> This test contains two autodefer-like helpers, but namespaces them as dfr_*
> instead of adf_* like this patchset. Rename them.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


