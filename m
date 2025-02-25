Return-Path: <linux-kselftest+bounces-27429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3341A43B79
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30963AB301
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BE267B04;
	Tue, 25 Feb 2025 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5n6FZG1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414C267383;
	Tue, 25 Feb 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478862; cv=none; b=l2DV1X0zYdOHhVDzoEq2ebcBYPQhtwQaLZQQR9VqerO7TU/Q3AXEelrqPAGn0MDjvY3QVE/6Ab4Lyo2IPmXlPpC1Il9WmnQ9KhRW1iUKpI46474XBkgaMCQZqi6kv+KycIvAYrrAVFqFD1ggERujv247t0slHO0mLii0FSTlz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478862; c=relaxed/simple;
	bh=BU6oDpxl5FJ4d9egWKABxwLJU2CsLYkP7Xa1l5vYAQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcH8Jd1A4bY8WwCm8Fk1JwQoLHP/9MvIdh/+xitcYc6kojME4nyg6jq5KSljJOSe4n4Ziq5nWT6RzR3VSgu4WLWy8PxkdQJqREeKjoS6lDNaPBCyFIRzzMPad+pxr9DpdY8QibnxCWHWHnNf4SKvte7Y2KfImcu4tg5XDqZwhaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5n6FZG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D063C4CEE2;
	Tue, 25 Feb 2025 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740478861;
	bh=BU6oDpxl5FJ4d9egWKABxwLJU2CsLYkP7Xa1l5vYAQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5n6FZG1N5iG3jZAGTuMaz8gYzTngP4SVop/FaVZ031KUnXvMjGj8T0PbpIkn2r8M
	 ODAFNdD9kV0tMV+BrvhUUCxplCHAO/1TkPalw5xd94+CHwyEEnvXWw1C5SqFF9UX/f
	 ryayeKDQuxLWloEQ4hwl7pXsKh2SwEazCeinDDoJZydEshOZkt/M2I/cWau4zdZAzB
	 /SjQKVCbj/4r522BKiamKEY5kAf/gCuLqh1v+DYvPILHk83F+U+YQOFybizhzjJa0B
	 gjZFtWl+SDVAGlLOq/LfKX0DAUti+YuiApvLg1Wo3wlRLpGObV3SgzIHfJ0WHWNBqD
	 Vso8SPqvRhYfQ==
Date: Tue, 25 Feb 2025 10:20:57 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 6/7] netconsole: docs: document the task name
 feature
Message-ID: <20250225102057.GQ1615191@kernel.org>
References: <20250221-netcons_current-v1-0-21c86ae8fc0d@debian.org>
 <20250221-netcons_current-v1-6-21c86ae8fc0d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-netcons_current-v1-6-21c86ae8fc0d@debian.org>

On Fri, Feb 21, 2025 at 05:52:11AM -0800, Breno Leitao wrote:
> Add documentation for the netconsole task name feature in
> Documentation/networking/netconsole.rst. This explains how to enable
> task name via configfs and demonstrates the output format.
> 
> The documentation includes:
> - How to enable/disable the feature via taskname_enabled
> - The format of the task name in the output
> - An example showing the task name appearing in messages
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


