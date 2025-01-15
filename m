Return-Path: <linux-kselftest+bounces-24602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BF7A12E32
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 23:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8270516564E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD41DB158;
	Wed, 15 Jan 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyten9uD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01E132C38;
	Wed, 15 Jan 2025 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736979582; cv=none; b=V6oJrI34rzRLP0on2JlM46q6fwHLJGBH7Q1AEtbOGitOKqKwga5WR00D1YDIwgWei0jpP23bYPO4r7HU0wBV4AxKI+HTBISqNaiiVcUz7ELEu3fge8GR/7wwH6OJ9VfaA1/kO4nBZ+uMTFqKEhqhR3tZ8hnBWG6Z7mwZKMna4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736979582; c=relaxed/simple;
	bh=cHrmy7zaz+reWz1imJe3e1MpHjJwQfuGaFL+mD/SSvE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXy9DwqLZvzyADbWxmPmh7d2SjlJg3/X95UA88Y6LIyFq+dFozmtaBVIXHAndX/zGp/XYwvdIFCW5EOQ/Qdx1YrgY6oTDABn+RYe49hWkOKkr6EcULOOJs+Ikmnt3eyJ+v7XbtoeTIgjlQavDgrTz5vH54HvXiguIZYHOGTmy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyten9uD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B3BC4CED1;
	Wed, 15 Jan 2025 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736979581;
	bh=cHrmy7zaz+reWz1imJe3e1MpHjJwQfuGaFL+mD/SSvE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tyten9uDuElwKZ1qE1fANxF5KpmdxYcjAPsqYDvsbu8fsbllINNBv/IXGdM7RW4RN
	 p7gndwjcVt+dDWjDm064vRB4REUKfO0gJB6bpyFgR43kXeHasPqcMuTfuexYo4fC3s
	 uxM7le/PyptHvR2oRzsVKXgEOXfkcjbminrNcH5dqmTLL12M1TDr8L563r1OsPrl7g
	 XNZr/LEUSiy9x3vOu18fl/Pnf63gM8/rzi1A1n2H74h3WauZw5/oYV4n1Osy6obyHa
	 QQgeAkwzBtGeBJl7rEtoeVJDT/W/txEAKNOA4iNAgzy8/eaIb8ItEg/yMsVwFIh526
	 mmHd0kyZpPN+Q==
Date: Wed, 15 Jan 2025 14:19:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Liu Ye <liuye@kylinos.cn>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 shuah@kernel.org, steffen.klassert@secunet.com
Subject: Re: [PATCH net V2] selftests/net/ipsec: Fix Null pointer
 dereference in rtattr_pack()
Message-ID: <20250115141940.399ecd28@kernel.org>
In-Reply-To: <20250115031322.43561-1-liuye@kylinos.cn>
References: <20250114160126.GJ5497@kernel.org>
	<20250115031322.43561-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 11:13:22 +0800 Liu Ye wrote:
> From: liuye <liuye@kylinos.cn>
> 
> From: Liu Ye <liuye@kylinos.cn>

too many From lines.

> Address Null pointer dereference in rtattr_pack.

I think size is 0 in the bad case, so it's more of an undefinied
behavior.

> Flagged by cppcheck as:
>     tools/testing/selftests/net/ipsec.c:230:25: warning: Possible null pointer
>     dereference: payload [nullPointer]
>     memcpy(RTA_DATA(attr), payload, size);
>                            ^
>     tools/testing/selftests/net/ipsec.c:1618:54: note: Calling function 'rtattr_pack',
>     4th argument 'NULL' value is 0
>     if (rtattr_pack(&req.nh, sizeof(req), XFRMA_IF_ID, NULL, 0)) {
>                                                        ^
>     tools/testing/selftests/net/ipsec.c:230:25: note: Null pointer dereference
>     memcpy(RTA_DATA(attr), payload, size);
>                            ^
> Fixes: 70bfdf62e93a ("selftests/net/ipsec: Add test for xfrm_spdattr_type_t")

Your Sign-off needs to be right after fixes.

> ---
> V2: Modify description.
>     Add code checking tools.
>     Separating family and given name in Signed-off-by line.
>     Modify code format.
>     Add fixes.
> ---

Please post v3 as a new thread (not in reply to).
-- 
pw-bot: cr

