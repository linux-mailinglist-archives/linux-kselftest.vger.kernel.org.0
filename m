Return-Path: <linux-kselftest+bounces-41007-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC25B49EB1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 03:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2C31B20902
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 01:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1722154B;
	Tue,  9 Sep 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maBhzAIG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2C233F3;
	Tue,  9 Sep 2025 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381399; cv=none; b=c5FLAk6ln5diJXtSq+JmS7S57jrl20FfiUISt2+N/+urXWK79FtWVNwaqR4qNjx7zLIMemp6wtIj9qvlRPMZdrQtEvR6sIxdgpzFQk4afvI2kE19LQMJP2CTIktqwfGyzoZ+PLJuldlBbwASuT2b/nGqb4VhIN4kRH83rZbD/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381399; c=relaxed/simple;
	bh=Wqapk0+eaqtSD15mKMmr53PCF2kw+iCzMequet+Vqt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8U3YSNQF0x7Hb1V792yJgyo+XhDyqVsCCB5UdLqY5QZzujJm3WSSud2Eo04CMEq4DFFru5wYwG5QUomtqSyahRVItSICZI2IB7PTPSePa/J5caifEOAvR+tIavLrABnWJZIulJ34P6Sj3fHmnBmTni934uJWAlcpJbCZHqoEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maBhzAIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14C1C4CEF1;
	Tue,  9 Sep 2025 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757381399;
	bh=Wqapk0+eaqtSD15mKMmr53PCF2kw+iCzMequet+Vqt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=maBhzAIGXLLFjbhO4eaj17vfOar03If8hr51V7PJgYNOsg7uomVQFfCbnm+aPAwkU
	 e/O7dgbyvoEDshWc1LTz6Sb9HMO2ACqgP9LFL1WUIVfWLgNqa+0qxAhb70EnX0qXC+
	 wqz4pJFbhYfNdM2QHY5BrxJX/gXnr1Z/3/4cKN27f9MMxsyMUc7MW2Ds2smvvFNWca
	 a28h5eCwNPJ/k/3JFWYNL2S74cvxwUIX/zZR9Bc0KiQpJeZ2tboyAfXg9q9mobTIY+
	 /7TyRS31NcQm0p3OIhvUrO6GO4heb9LTyvBIqImPIVSMSxpnhcBhrPwdpgRQQNPGb9
	 Pd+jQ0lLE/oWw==
Date: Mon, 8 Sep 2025 18:29:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, david decotigny
 <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 kernel-team@meta.com, stable@vger.kernel.org, jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <20250908182958.23dc4ba0@kernel.org>
In-Reply-To: <aL9A3JDyx3TxAzLf@mozart.vkv.me>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
	<20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
	<aL9A3JDyx3TxAzLf@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 13:47:24 -0700 Calvin Owens wrote:
> I wonder if there might be a demon lurking in bonding+netpoll that this
> was papering over? Not a reason not to fix the leaks IMO, I'm just
> curious, I don't want to spend time on it if you already did :)

+1, I also feel like it'd be good to have some bonding tests in place
when we're removing a hack added specifically for bonding.

