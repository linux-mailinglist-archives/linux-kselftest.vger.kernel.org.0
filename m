Return-Path: <linux-kselftest+bounces-46092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51CC73627
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9DC834BF35
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F86B30E843;
	Thu, 20 Nov 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="d67b7j1Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21926C39B;
	Thu, 20 Nov 2025 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633050; cv=none; b=p1ESFvebiPjPGXWS48nbeoDQV3W7S7KEjA1DQuCNX4FCPJS1shGHoMR3cTfv8WDQuZE3Zp43qM5zgCGC6MJHhORMX1UqVfmuqZVNcPZcWSZ08Cja0sW3QDHKmn2Xr2R7mUfYLcrVrBtfcx3M0cwW8gqk+iuJ3S0lcWW6UmccSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633050; c=relaxed/simple;
	bh=1dokCFfTg9IDBaB1SWan4W5GoJTFxFQOl4so3J73uII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAYs8UtyWNgyWA+yFfZ1O/jqB1kEgDqaveEMy/yFK1k2nDxlDzKD2MLCAAaGp3iTxKQy4KQngJT/y9Bh9TyV0IuyKEKmuZIq2XKFKmzJtOBiysm8cp9fesnx/1KiCuI/b1+W8kprIen9GjER+sesyK4bFlchatWgpzDoFlixlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=d67b7j1Z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vdeArdTGf3LKHOnchP/pJVJkcG6D2j5qJk0Ex/IGsNY=; b=d67b7j1ZwpjHeeNpeOykuVkKu/
	mVfSQ/ymQ4vpZ25jDXJmh6kYwKCvAQHXwV7DV1kJRIPNzUWkYsHKJb7Nn1DhxKpMtDhs7iexjY9nd
	kgXMrwkEEvmLZtH/Zq3s7MgeX8PvEGeiHvnary3aFra5VCHxNNOYFvsSgPfHeKDmUOE2nPF/S/MP/
	6VhJZmeLMTV3ijJfiWxVgJ1t3qH+BAMYMO7RlxmTgrMpT0oGAxW9jy6Wkhiavj8ljJ+ehVTAyxmmf
	mbsM5g83SqabY7aUxFgOjx9HsqHmvVOn/vy2she7YwAuYX8qy2OIktJQxUZN/bMi9yfo24/Xh1oie
	CieX5pzQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vM1W3-00GoXf-0z; Thu, 20 Nov 2025 10:03:51 +0000
Date: Thu, 20 Nov 2025 02:03:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	willemdebruijn.kernel@gmail.com, shuah@kernel.org, sdf@fomichev.me, krakauer@google.com, 
	linux-kselftest@vger.kernel.org, petrm@nvidia.com, matttbe@kernel.org, 
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 06/12] selftests: net: py: support ksft ready
 without wait
Message-ID: <qshy7xf5pzgabrbvioe7v5tz45etzk22r3t3phklrnkq7tn6hs@3kv76yk73afl>
References: <20251120021024.2944527-1-kuba@kernel.org>
 <20251120021024.2944527-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120021024.2944527-7-kuba@kernel.org>
X-Debian-User: leitao

On Wed, Nov 19, 2025 at 06:10:18PM -0800, Jakub Kicinski wrote:
> There's a common synchronization problem when a script (Python test)
> uses a C program to set up some state (usually start a receiving
> process for traffic). The script needs to know when the process
> has fully initialized. The inverse of the problem exists for shutting
> the process down - we need a reliable way to tell the process to exit.
> 
> We added helpers to do this safely in
> commit 71477137994f ("selftests: drv-net: add a way to wait for a local process")
> unfortunately the two operations (wait for init, and shutdown) are
> controlled by a single parameter (ksft_wait). Add support for using
> ksft_ready without using the second fd for exit.
> 
> This is useful for programs which wait for a specific number of packets
> to rx so exit_wait is a good match, but we still need to wait for init.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: breno Leitao <leitao@debian.org>

