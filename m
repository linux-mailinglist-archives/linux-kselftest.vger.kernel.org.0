Return-Path: <linux-kselftest+bounces-42597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C3BAA495
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090D91C47E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE308238D3A;
	Mon, 29 Sep 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtt5vqR4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EE19F13F;
	Mon, 29 Sep 2025 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170490; cv=none; b=DocBqUB69G5XCLrEn3Tr47ppI3YdZlZaniyHitnlwAs9QiNfUanX9+R/fWww0kf0MwNVEK2ATFQZ/CUG0Z7G6kN7hwdCoUy00wWNYnO6qoEFh4KeIptPUoHKDbsd3fylNBhUyr45M66oJiQrme8LNuF6xhT25SjeBKZU4ldC0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170490; c=relaxed/simple;
	bh=E/gMtczZViFlJRfZ8Rcqk40Ma9nxDLETdfvmmLbwKko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atx6vQS5HYj0ObQh+pfxCuEXu+/Xm1ucFy4Z4zvymjZ1kRne8pB108DnNcObreSDlu++9FtS58MokthkBVBTfD2Odj53zGikHcz+aO4F664AJ3HOUXTconVCSCxkAoN5R0JUgN6ZpenPwJP4kC4oQDKxR/ypPWQfM0cbbuKRKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtt5vqR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91816C4CEF4;
	Mon, 29 Sep 2025 18:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759170490;
	bh=E/gMtczZViFlJRfZ8Rcqk40Ma9nxDLETdfvmmLbwKko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jtt5vqR4VrDqgACMKUCh2gmRns4+JZQIRGYPEtzGI+lho8pElvrJYU8b8n2KDvuKo
	 ajQhiM8N9PjZxrgvmyOJpsbjFh5w/b5dVVWK6ODB/Y0p6f4dDajGGguFG4g/XyPRbA
	 t1JSV8+XAGKyLDDK+L2dJmtA3PYEj4pC/A5DDAcWkdfs75qpFbnXhyYP3vzuo/+Ac1
	 dCh623ciq3AAWFknZEEefKGLff5WOj6FEY7Yg1/q4PU0EhT68j3XpdDazljfU3PScZ
	 QooGWtB1uezqYc9PQkvuGa07Nv0hFb2+NnKsF9xih0u7PXppdq+VAItDbVF0yV7TSy
	 vnRMkwrHbtLTA==
Date: Mon, 29 Sep 2025 11:28:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman
 <horms@kernel.org>, david decotigny <decot@googlers.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
 calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v5 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <20250929112808.186808fe@kernel.org>
In-Reply-To: <3drbbpiyfpqfzule75q5qi7jm6xkpbvwukzfh6gf4vdibqsef4@v3o7u4rgsq2n>
References: <20250918-netconsole_torture-v5-0-77e25e0a4eb6@debian.org>
	<20250918-netconsole_torture-v5-4-77e25e0a4eb6@debian.org>
	<20250919174901.1a6062d7@kernel.org>
	<w33kl7gd5b4yrakxkg5cnkwgvvzdz6jgwzmwmxyrrf3nxvyspn@3354jtfl26vu>
	<20250926113208.07fa0b2f@kernel.org>
	<3drbbpiyfpqfzule75q5qi7jm6xkpbvwukzfh6gf4vdibqsef4@v3o7u4rgsq2n>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 07:50:17 -0700 Breno Leitao wrote:
> Not sure if I understand this case correctly, but I've added a test
> where I create a bonding interface (let's call it bond0) with one
> device, then I enable netconsole in bond0. Later, I've added a second
> interface to bond0, and make sure netconsole is enabled in bond0.
> 
> Is this what you meant?

Please post v6 to get the patch into the normal review queue.
We don't usually continue patch review in comments :)

