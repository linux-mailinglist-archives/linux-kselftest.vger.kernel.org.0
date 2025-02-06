Return-Path: <linux-kselftest+bounces-25923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B1A2A933
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A501684D1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 13:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CFE22DFB3;
	Thu,  6 Feb 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4g8H6V9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B813D897;
	Thu,  6 Feb 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847541; cv=none; b=dg5dwp+uRbR0VhNVCuy9Tiz4bOU12PpCs3dHK05ZaNEEnF7LhRy4ujTD4JR+qxFCoL+1KVJoK2WAH7ncjopthP0p2hzm+vzMsP+JO3PGVtAUS9E3QalLrJUrUMKzM/H18ExpSZqe7E3vsDO1KyueKQmugZbTljBKSN4sUEe5jSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847541; c=relaxed/simple;
	bh=TEmqSELUyJ7FOVralpYOozTcqfT8xM5sG8e5zOJ2PAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S680cqE69/atsgGFv9ZrbB/4bv0YR5zCnawPqg01KR1WtKZJjY5QRnw/wneWfJrDFW/s3IzIxIVGih1MI+4wksejry7B8dmd0MBL7Wurmo47eYggFZZmhR+OORzv/8RHQgSRTpmzEp6hucqaYyO8DvszdN8wuKkqcerEOlmJYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4g8H6V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF3FC4CEDD;
	Thu,  6 Feb 2025 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847541;
	bh=TEmqSELUyJ7FOVralpYOozTcqfT8xM5sG8e5zOJ2PAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4g8H6V9xt4rJB6oV/y2PH/j/SEjiHZvAHqAZZVBebG4mYSv+ISg5Y2fUfeAxgirn
	 68GKQwaf+MJFbwfNmSBsGt30VorPvYqVSL5g/WnepkmSe1aa2lKvXufRI0+m37PLYo
	 wuV0wnaCrwh2X+E0OGa6COTcqtn6FB1chILJUP4hPkvZqmXvwZMQE6lRfgqZywHyx3
	 HDEJNvooFYFquNn4gzBSCyw1CHxN6D3o2RlgyXEasVnazGWOoIKHtH3H81WV/KZVde
	 qrZvj2uxRlvTKnIcJWF/xVNZuQwkZa+M6tbSiPeUs8x6WCOMuQNj2aIiquvvolKg1C
	 3UkCo11HZrnAA==
Date: Thu, 6 Feb 2025 13:12:17 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 10/17] net: pktgen: remove extra tmp variable
 (re-use len instead)
Message-ID: <20250206131217.GS554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-11-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-11-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:46PM +0100, Peter Seiderer wrote:
> Remove extra tmp variable in pktgen_if_write (re-use len instead).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


