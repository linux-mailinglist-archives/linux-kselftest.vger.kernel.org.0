Return-Path: <linux-kselftest+bounces-35020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EFEAD9F11
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 20:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3675B170819
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29ED2DCBEA;
	Sat, 14 Jun 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZbP4ua4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DD479D0;
	Sat, 14 Jun 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749926373; cv=none; b=MVOne+dfxRpuxLI8oAVGulbqIdNPVeZlHWPeabvLhEtI4D7XaPbb6WVMa0RXHRoAzK/k1x6WuFg6pVv7ug/UBba5IRvqJaxuOcA9EU1b09vYQryXGtFIk64Lui3p4nO3RgrAxQ3R3qYVDq+ckzrAWz7savYy7g7lnx3xQUFe5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749926373; c=relaxed/simple;
	bh=zTqIdMKpZpW2S1R+w4mXcRem256IapEW60iT/KSKqvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJdmBhoZmYNTK212xERnm5i4xf16NA+pqqVYca5/qkAD0Z2cUNSBFWuVnD3L+phFIvYyaIa368+e7V0krEMjp5sV51dTO/SHfZL0WzW5wlv7j/cPi4eeJ+8CDFXtT0laJOnKLX4BkVw+Pg/sAtH9TRVVletuMvQ/FU79Ga3DD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZbP4ua4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A74C4CEEB;
	Sat, 14 Jun 2025 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749926373;
	bh=zTqIdMKpZpW2S1R+w4mXcRem256IapEW60iT/KSKqvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZbP4ua4x1pQM1UyDEQwIi5L3Zojcsz5V7Kl8JazSAHWVj2Yjiu449+E8bBtu6kH6
	 elEfCTFli4ixmy3lofeT+lf+Z1FQra+Xoeg5HgsXg6Snbz1HN7HUZGhAi6a8f3L3Ky
	 eV5nbeqOJGf4g69S1viGkvGt57RJeEoSMR28iMhx6KrhJ1tf0A5ofj7QJfjgR7Q2/B
	 +z/yM8nb4NtfBd/SLlXPYyc1cobF/QGA+bTLDVslG+6K8l2vPtCi9kgPLAXLeDCSPs
	 7h8kCo6aUNgvuEW63fQTyeAHPwZ0SKy+yWOPPOrjNRm7R/7mBej6Qe3yBIH4JlyiwH
	 2g/GEKlPhkVHQ==
Date: Sat, 14 Jun 2025 11:39:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>
Subject: Re: [PATCH net-next v1 2/4] netmem: fix netmem comments
Message-ID: <20250614113931.26dbbc53@kernel.org>
In-Reply-To: <20250613042804.3259045-2-almasrymina@google.com>
References: <20250613042804.3259045-1-almasrymina@google.com>
	<20250613042804.3259045-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 04:28:02 +0000 Mina Almasry wrote:
> +/* __netmem_clear_lsb - clear the lsb of &netmem and return it as
> + * a net_iov*.

nit: "clear the lsb" spells out the name of the function..
how about: convert netmem_ref to struct net_iov * for metadata access
or some such ?

> + * @netmem: netmem reference to extract as net_iov.

