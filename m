Return-Path: <linux-kselftest+bounces-39058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A0B278E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5600AA0198
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EE9280037;
	Fri, 15 Aug 2025 06:14:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFE4257ACA;
	Fri, 15 Aug 2025 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238459; cv=none; b=k8QoUor/NxmyqKUFhkIKr/m/mngADXhrdtkBG/VpYDWXJsQOMdxzVyUTEwxCxqQnX7R4h1T6pag5P4V2la6aFUZKHjFUGIlzuRRgagTD5EMrX5DM2hiiTdHdbHAwo+DMTKMhRJR1tFgbP32ELroXUx5VnIT+tqyRFJE+qp+RHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238459; c=relaxed/simple;
	bh=qKWRkm37hVBPKiByb3llVWhtPN5gfJ3uWzGw9QoP1z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIZiXY6FLU2RUhso5khxNHVXSeEIy585RU34UEWdDnDLhPfhBgmbx2PXRgVe9B1RtqgqtovWuo9Yoje+RMuqc8V1yKtJms6n51IVLGCgHoDj+SpwkUWTD5i3dVEq3hHbJCCifEKYIHm46RVVjU+5ahlkvUY7MqRnk51AeD+2wDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id AD4BB605B5; Fri, 15 Aug 2025 08:14:12 +0200 (CEST)
Date: Fri, 15 Aug 2025 08:14:07 +0200
From: Florian Westphal <fw@strlen.de>
To: Soham Metha <sohammetha01@gmail.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/6] setftests: net: netfilter: fix spelling mistakes in
 output
Message-ID: <aJ7QL0BHj7xJNqPw@strlen.de>
References: <20250815000859.112169-1-sohammetha01@gmail.com>
 <20250815001803.112924-1-sohammetha01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815001803.112924-1-sohammetha01@gmail.com>

Soham Metha <sohammetha01@gmail.com> wrote:
> found/fixed following typos
> 
> - add add -> add
> - cannnot -> cannot
> - fowarded -> forwarded

OK, but what tree are you targetting?

In case netdev maintainers or someone else wants to take it:

Acked-by: Florian Westphal <fw@strlen.de>

Else we can route it via nf-next in the coming week.

