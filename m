Return-Path: <linux-kselftest+bounces-45235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB5FC4856A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67B824EE231
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 17:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EB32BDC1B;
	Mon, 10 Nov 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Oadw5e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4E2BD5BF;
	Mon, 10 Nov 2025 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795549; cv=none; b=gZGFo0fbtgjxzrRBiep8Dw0gzT/sPW3i1cbH9oevRiu/oMkRjkIK/T44DTvPwQjPotfKihLfwFatlChbj/GWn3YvXAHuHrHbKtJsmIDVtRKC5jErdF4FZmI71Cinp0R2QBPajuRPPlIQBV+qYvyvCKA9uOxSGiTyj3GOeB8kgLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795549; c=relaxed/simple;
	bh=BqthlMxeQGgTeXcxMiXnjyGiCBdUl9fdqdr1v7CnvGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3liGRG5kbjvpgAOOvfS9XzrAs8zpIyIVW2EKLqrgOW9Q2PLm0RQn19lHjXzWtTo1im2vdXgezZFtH++utcp8VNRsBF2cF6EjmkWDRp4pD3uR+7CED6KaEgYro0a/ZWFVSSAnouTxA8wDcwsvFZYsy6ukj2SV9EolNGcEXfPUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2Oadw5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61CBC4CEFB;
	Mon, 10 Nov 2025 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762795548;
	bh=BqthlMxeQGgTeXcxMiXnjyGiCBdUl9fdqdr1v7CnvGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2Oadw5evnHO/ZUXp1QTfeO9cy0/NLc59RMUYaja0nfL0BUontq9sNn8KYVAlpqYr
	 5p8kzuu1ewN+uR9w38Qs2pYigpDGa4CyRIINWdOBrFHLP/orRqqCBwXLwIkyBgzxwX
	 MAwcpqiJFMgS1zqipRH0S6tPnvha5s9NiVWlz7KWnzeE+nTufhdhTannFN9vm+lLs/
	 HiBRwuhoiNDzz+FsdqmXPAefX9bThMiXUU9AGrfoA6nYKg/+zW+dXWzhHMypeuZcyc
	 T9OaJUarNp5XTTLJuUtnjvhpxv76oIuXncakozNQzPTed8Osm2/uNPTFkhfqp6VwMI
	 xYwjPmxtoVjEA==
Date: Mon, 10 Nov 2025 17:25:43 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, david decotigny <decot@googlers.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v9 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <aRIgFxf0t7XgL55t@horms.kernel.org>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
 <20251106-netconsole_torture-v9-4-f73cd147c13c@debian.org>
 <aQ3ExWwuiiN0xyBE@horms.kernel.org>
 <f44ccmfiiq47ecug5jyfxsi2imsytzhg25szr5yotpdry2b32h@5hxqifqyvsjz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f44ccmfiiq47ecug5jyfxsi2imsytzhg25szr5yotpdry2b32h@5hxqifqyvsjz>

On Fri, Nov 07, 2025 at 05:55:36AM -0800, Breno Leitao wrote:
> Hello Simon,
> 
> On Fri, Nov 07, 2025 at 10:07:01AM +0000, Simon Horman wrote:
> > On Thu, Nov 06, 2025 at 07:56:50AM -0800, Breno Leitao wrote:
> > >  function create_dynamic_target() {
> > >  	local FORMAT=${1:-"extended"}
> > >  	local NCPATH=${2:-"$NETCONS_PATH"}
> > > -	_create_dynamic_target "${FORMAT}" "${NCPATH}"
> > > +	create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"
> > 
> > Sorry for not noticing this when I looked over v8.
> > It's not that important and I don't think it should block progress.
> > 
> > create_and_enable_dynamic_target() seems to only be used here.
> > If so, perhaps the 'enabled' line could simply be added to
> > create_dynamic_target() instead of creating adding
> > create_and_enable_dynamic_target().
> 
> This is a good catch. I _think_ it is worth fixing, in fact.
> 
> I will send a v10 with this additional change.

Thanks, LGTM.


