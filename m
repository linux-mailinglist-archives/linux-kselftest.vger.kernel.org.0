Return-Path: <linux-kselftest+bounces-29437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AF8A693CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59EF463B22
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF11D54FA;
	Wed, 19 Mar 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNvaUI2d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79788195811;
	Wed, 19 Mar 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398879; cv=none; b=Y4whdzBxqlbzNFn6VsBXvo28cNGq58INNQdeCbqDjtu75AOxebO5hgDbJMu2fx3ax6nXvELxaeOM916SmtExhL7VzkIE8HvOJhBGx4I+4/8ngIUEwM/et8Pt8amnl24MPXOcZM2d+iergz4Bi2Q9dvubvY12Kz1sdLqntSecos0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398879; c=relaxed/simple;
	bh=BsA0LrId7WbOubiCQ3kD5eqRtjwstQZya6n4rn4U2TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgb6ofg8XT12yZWPg0eb/h+uIliTwP10oC7W45ZrCGq60+9Zv+CSrIQKiYZmtVOszwJrf8dxJcLSs0Gh/12riFOCOXGhxh1FkvFn7xtehr0GbWk7Qxz8WmxXB6YxWZW9RFG1ZVdl+do5bL3J972ZMUNir342xE5gZCDDG6O9QR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNvaUI2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CA7C4CEE4;
	Wed, 19 Mar 2025 15:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398878;
	bh=BsA0LrId7WbOubiCQ3kD5eqRtjwstQZya6n4rn4U2TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNvaUI2dJe1cgOjxyOe4l7BbIds77qOYx1Wz2Yh2hKOoyqi8I+C8jVEFiiUXpuEsZ
	 SMM4bNiF5VEdr6h85X8p4se4l5+QI8byViCG8fbQo1TtdIX5XEaoTDJmVI/qdE7x5L
	 mbnVxNGMZ2ySBynjKkhfukhmvSWVraAicSedPuw0L+aZE15uvPqe+Bfuit+z8Z1nDc
	 peG4w+usSew0S9yGYZBKxPPpGPcA75Ybrf+jxSDdmpV/88Wf4GcK4AuU22islt+Xoi
	 ENM//w4DKBTlKgq1A5PgnFesTKrQbyMTebb6XC2dYcOhMRa9EQGWEdhxkFJLb1HmyI
	 tXcI7RZGB9nTA==
Date: Wed, 19 Mar 2025 15:41:10 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	Manu Bretelle <chantr4@gmail.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next 3/6] netconsole: add 'sysdata' suffix to related
 functions
Message-ID: <20250319154110.GH768132@kernel.org>
References: <20250314-netcons_release-v1-0-07979c4b86af@debian.org>
 <20250314-netcons_release-v1-3-07979c4b86af@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-netcons_release-v1-3-07979c4b86af@debian.org>

On Fri, Mar 14, 2025 at 10:58:47AM -0700, Breno Leitao wrote:
> This commit appends a common "sysdata" suffix to functions responsible
> for appending data to sysdata.
> 
> This change enhances code clarity and prevents naming conflicts with
> other "append" functions, particularly in anticipation of the upcoming
> inclusion of the `release` field in the next patch.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


