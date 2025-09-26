Return-Path: <linux-kselftest+bounces-42473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48027BA3FC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D16178453
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0572ECD34;
	Fri, 26 Sep 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q41CCXo+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C772605;
	Fri, 26 Sep 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894867; cv=none; b=oVzgZbFrnZNu0h9ce6F7iUgzZn6AXp4WSCC9uaEtv36DggBZKun3u0KfNfQA4brN2zFecOTEFKLM0sfh5dOnb8+Kfjaeiyx0STroEKu+CyMCp8k21BEj3X359DHBBLyBXX6YD1dJzLs/wM7tyb6RGxnSrompVUNmyJXK52Da01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894867; c=relaxed/simple;
	bh=tOCaYjTsiyAoNqDMjzZ3MujuRGWbFMZzV/fDyKA72Ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epVTTmc+mye0fg3CJqt5/wg/Zjf0XhCi+G8lRTnL9DXyZB9D0I5MD65jpq4UC5xoDRPLyVoRUbpF2hOdVfCW4jrqSpx9PAp3Bi+APFFGm0hbYCKpByXHKeasJ5YdL/PLTWWGzerHi3hnKbhJ+U9+UH9n6VP7Y7hE9ptYaMKRx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q41CCXo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A74C4CEF4;
	Fri, 26 Sep 2025 13:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894865;
	bh=tOCaYjTsiyAoNqDMjzZ3MujuRGWbFMZzV/fDyKA72Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q41CCXo+38q2R5d5Johgx8c3QtN1zKUZ0/V3s+3ptmtUjp+PpSZIFQDYpoeYbC+WI
	 1CIp33uK0Rtdkim64c+RvpUcG7Bag7uRQ29rWVO7J+gDjYr3Rz7SVkVXe1o4pblllZ
	 g/afsDK4JY+6SIU5vZHQoGGan1RmhpS9B8pdMbE8R9stN15ctE+Mxnsxf9E9T+82BS
	 GCySPVSsyJhwkVEiKFXko6HywbsdoxJpHo/6grwmKK04AE2zZe5YG6rKbIVDK1OXw6
	 qKAEciq5BFqHkKD3cbNX1QkUCpFeO2WfdhIGm8VheOtPD1F0aOD67JZoHASITpxriu
	 +cCvU25cod3MA==
Date: Fri, 26 Sep 2025 14:54:21 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 03/13] selftests: net: lib: Rename
 ip_link_set_addr() to adf_*
Message-ID: <aNabDQdG3M3rGs_c@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <5318e90f7f491f9f397ac221a8b47fdbedd0d3b2.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5318e90f7f491f9f397ac221a8b47fdbedd0d3b2.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:46PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


