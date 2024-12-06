Return-Path: <linux-kselftest+bounces-22915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E701B9E72A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 16:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA411887CE6
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239D206F34;
	Fri,  6 Dec 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCWoMCke"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B888153836;
	Fri,  6 Dec 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497869; cv=none; b=PRn9aJEkNiCpbwl2q6uzL3nt/FceGGQ+XTAHq2KIxO6v/hICtVf1uxVnAxbVBgBoJN6bPonn0ysRwPSlsVVAvsWrN80xVD17M1IPRnKU9QGLyvxM1TDkAh/FqO/ftObphM/5OMyfbLjRfB4gyuhywFUP0esEWG3OIY9p0Ot+2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497869; c=relaxed/simple;
	bh=LcpnZ33ejtMHavlZpq6cgaiqoQshy/LP9BpKpAqooDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJAp/gKCMveeSzRb9Tc4NuyYLx0SaaSgAXjavpGZBo1CGb0Sqfmp0b0+JJpviGN3b9iGlIpUZiDa7ywONzLbPC0XOZmb8FhqUVWSxoAQRtnEB5S4+wyMBHtriy485qZYMb+/8U7oo6yc24Vx6I58FYhUc23aYcLjbBhuvzFp5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCWoMCke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20819C4AF15;
	Fri,  6 Dec 2024 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733497869;
	bh=LcpnZ33ejtMHavlZpq6cgaiqoQshy/LP9BpKpAqooDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCWoMCkegxfeQz4+PvkXAoFL7ZTJkUR/Xz24GQTAQlizgOCibfHAa4VXtg8oX2W8T
	 f9BPpwpBxGUOUXOuV6NQbLAnPCoulgVdq1/xDs5ewmbUWr7WG6MPrI1kfKCmNdSZZo
	 bd+fBjpjfjRB3BDmcyesFgpka5JEzXbVOQbwdy35yQchoYZGC3Qk6VFuoQyuoE9I0d
	 Hr2H2HXLEIFMy8mUrHYMp4PGfnnpyrtC0UqXXZNAVAy4numUeLjUT7aZqkI/9wC0WA
	 jm5ZnHlnkfv5wIT5tTa1Yohn8fBZUpmRkOGRxj86ln2rsJ7ILN6u37hjkxp6ZDFWMe
	 oJvgjPwFcUqyA==
Date: Fri, 6 Dec 2024 15:11:05 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] netconsole: Warn if MAX_USERDATA_ITEMS
 limit is exceeded
Message-ID: <20241206151105.GV2581@kernel.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
 <20241204-netcons_overflow_test-v1-1-a85a8d0ace21@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-netcons_overflow_test-v1-1-a85a8d0ace21@debian.org>

On Wed, Dec 04, 2024 at 08:40:42AM -0800, Breno Leitao wrote:
> netconsole configfs helpers doesn't allow the creation of more than
> MAX_USERDATA_ITEMS items.
> 
> Add a warning when netconsole userdata update function attempts sees
> more than MAX_USERDATA_ITEMS entries.
> 
> Replace silent ignore mechanism with WARN_ON_ONCE() to highlight
> potential misuse during development and debugging.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


