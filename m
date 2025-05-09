Return-Path: <linux-kselftest+bounces-32775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B9DAB1D24
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985147A69EB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1B1253950;
	Fri,  9 May 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIZfaHgr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1388241697;
	Fri,  9 May 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817651; cv=none; b=tur7IaVlgcCTw1lx2A3F3VlOIA7UaMznhJSHIBP+r8u1Z8bNfjDhGqkb/zpSy5s+rJ9meAlbn/wdj+RJhGg15epL2FEtiMNEYEw8Df5QRcXbPS5TrQVtT7fWCaW+mEM27T1YPgYIwRoxuZXh0CyzdvrS3T0khMWxKIvl5ztB418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817651; c=relaxed/simple;
	bh=8DLbL6KlBz6zFIebHWqSHoxtM2Ww+VT55GJUJnILT+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMdTRSoBEiRXrwdXckbnWN0Aegi3PHC8WLuxED2iM09e5tb8Tghc+XaZ0JkpSZVXjpo975567L1O1tR7DcGmvLB99DTkmE/g8KgBqu0RKo2M5PwgjAwkY319y8T/1XDK48B9pVQiJ7CKypbYY1UUlyW/Vw8aNl7xTqX5QemtEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIZfaHgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF89C4CEE4;
	Fri,  9 May 2025 19:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817651;
	bh=8DLbL6KlBz6zFIebHWqSHoxtM2Ww+VT55GJUJnILT+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIZfaHgrLnDgoFKgjkAXj5LA8OMfoq2SJ+3mJqMYozxrTlQCNN7U8+QQH/Kdc9qN3
	 6WG1yR7cA/Jz94xgsNM8+L4OsHn536pQTvkhtHW/VXQSvAYB9OLYLX+QtU6trTYWIS
	 MaSwgQXI5U4f/gmfjTRkJhdfJsHUkv6KCN8XUEA7CrYKtDpQsmqkNFMQPECLlhqCCj
	 u3EbVps2kLDF090Kt/Q1EI7FyFDZbdwSdOl9uxQtfaTNCHFNG91eOBLG25ibbtCQ29
	 8/HX82Q8YhPMp4QD3lnSwgqHygsD0KTJMFqMWlYZUtbU+Z+NdfECabZhyDHX64Lo0T
	 qucaUaM31l5gw==
Date: Fri, 9 May 2025 12:07:28 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
	"Bird, Timothy" <Tim.Bird@sony.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/timens: Print TAP headers
Message-ID: <202505091206.B4DD09AB27@keescook>
References: <20250502-selftests-timens-fixes-v1-0-fb517c76f04d@linutronix.de>
 <20250502-selftests-timens-fixes-v1-1-fb517c76f04d@linutronix.de>
 <5609c6de-e5cf-4f6d-8412-71149fae2580@linuxfoundation.org>
 <20250509172639-61bade20-67f9-4815-8316-1bb16749f8d9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250509172639-61bade20-67f9-4815-8316-1bb16749f8d9@linutronix.de>

On Fri, May 09, 2025 at 05:41:03PM +0200, Thomas Weißschuh wrote:
> The suppression was actually there at some point and got removed by Kees in
> commit f41c322f17ec ("selftests: Remove KSFT_TAP_LEVEL").

Right, to get consistent output and to work with indentation, there's no
need to track level any more.

If you want to be able to explicitly supress KTAP output, that's
probably a new thing to be added. But normally it's not needed -- things
should be fairly readable even with KTAP output.

-- 
Kees Cook

