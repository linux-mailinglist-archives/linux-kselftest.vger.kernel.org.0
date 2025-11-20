Return-Path: <linux-kselftest+bounces-46094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD3DC739FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE5342925
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AA932FA06;
	Thu, 20 Nov 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tQoAq4Xn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEF30F93A;
	Thu, 20 Nov 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636617; cv=none; b=Kc0//RGSd/ElmiVq5wPjVEhxA9l5MJRkIG/yD5BdqwivGoEOBMDjogKMxt0wYdh09/7cQNmS4sqfPGHiJZeMinN/EEkLJFcpSpPxanCU+VkvNRai57byX/i6Pp4OTLgIZHChaIugaYP/Ioe/3YCm4cScsOe530VbNTn3jr4FlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636617; c=relaxed/simple;
	bh=q6aHjq2CdKofDCbAcVPL8d8sQTWTMjDjyu7pdoqFJsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjvVqd/hXlcdCC/mtMEs9U0CUibb4yeHqqUobxPfs3EZj40LQSvEEs5AsEmYF24KwV4puw+t/J+5Ja9q4jC2DWq7fErkPVNouPNga4/5sVoBxyNn7f6rJ7gS69Km0Hzvk5lKNpeQNOzQ40EB6X7QdJMF6NESdD2U1E+/lhb3Gds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tQoAq4Xn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yCz/FMIZji/PvoiJot+5/wA8TowD75fCD3bFIfgB5hk=; b=tQoAq4XnfLhM5KuhP2jf3goVaq
	U4Uzd+lMsjoVr81gTR9UvX5fqtkUrt6/nJLCpnK+srG/eJqf5+E4m4YYyCKvICLPgz7JJffh4tQ/M
	MctrFM4gz8XYNwbGqss0+sy19Ad/RiGUk7LyB8uTqIwXSmQbxv95ITr5UKMB/Jglx7ks0X/r7VXX+
	+gfg1pdyTV6D60pTDxWS9+LytH6yvPICBe14nIoiRBvnrsVLNVVIlt1WrFY4VfaocQYde98ZE3RQe
	6r9YHepEmbG5M+L7CLp7v24TrQYlyp1gWOEK8AToAomVQpgFE8MV10aeebJwVQZ2pYL420p7ieYpI
	YPTgwhrQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vM2Rk-00GqpJ-V9; Thu, 20 Nov 2025 11:03:29 +0000
Date: Thu, 20 Nov 2025 03:03:24 -0800
From: Breno Leitao <leitao@debian.org>
To: Gustavo Luiz Duarte <gustavold@gmail.com>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] netconsole: Dynamic allocation of
 userdata buffer
Message-ID: <n4b3usqvtxp34aq5q4veuvc6n6oqjnxa5pwci5wbt5j6s3hugm@3zqpwun6j233>
References: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
 <20251119-netconsole_dynamic_extradata-v3-3-497ac3191707@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-netconsole_dynamic_extradata-v3-3-497ac3191707@meta.com>
X-Debian-User: leitao

On Wed, Nov 19, 2025 at 04:14:51PM -0800, Gustavo Luiz Duarte wrote:
> The userdata buffer in struct netconsole_target is currently statically
> allocated with a size of MAX_USERDATA_ITEMS * MAX_EXTRADATA_ENTRY_LEN
> (16 * 256 = 4096 bytes). This wastes memory when userdata entries are
> not used or when only a few entries are configured, which is common in
> typical usage scenarios. It also forces us to keep MAX_USERDATA_ITEMS
> small to limit the memory wasted.
> 
> Change the userdata buffer from a static array to a dynamically
> allocated pointer. The buffer is now allocated on-demand in
> update_userdata() whenever userdata entries are added, modified, or
> removed via configfs. The implementation calculates the exact size
> needed for all current userdata entries, allocates a new buffer of that
> size, formats the entries into it, and atomically swaps it with the old
> buffer.
> 
> This approach provides several benefits:
> - Memory efficiency: Targets with no userdata use zero bytes instead of
>   4KB, and targets with userdata only allocate what they need;
> - Scalability: Makes it practical to increase MAX_USERDATA_ITEMS to a
>   much larger value without imposing a fixed memory cost on every
>   target;
> - No hot-path overhead: Allocation occurs during configuration (write to
>   configfs), not during message transmission
> 
> If memory allocation fails during userdata update, -ENOMEM is returned
> to userspace through the configfs attribute write operation.
> 
> The sysdata buffer remains statically allocated since it has a smaller
> fixed size (MAX_SYSDATA_ITEMS * MAX_EXTRADATA_ENTRY_LEN = 4 * 256 = 1024
> bytes) and its content length is less predictable.
> 
> Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

