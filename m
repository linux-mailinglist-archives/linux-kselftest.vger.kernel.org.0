Return-Path: <linux-kselftest+bounces-34219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4812EACC886
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024013A3335
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D08233701;
	Tue,  3 Jun 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEgqHlOq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2A132111;
	Tue,  3 Jun 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958938; cv=none; b=eRYfzOMQrBHax6zYKNPP37lcVip55wuSaZTIPKDw8gOgRyJH4lpm+voKXcfDNYPaOS3aPmT7Y3FUWeZQgXJRHBl7q+4T1jJyqiipww4VuvlQfdJr3TJLSWsAvGNrc34oxxzAytCmMivysDKbRtrut89CSpeMaW2LSGiypzOmeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958938; c=relaxed/simple;
	bh=G6EUbrZW2Zba7uI+N/OovsE6gXVigC3VmieJfKLitK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tkq93e2lLGodH+BKZPIQ5vKfqFNHPe4bOrS28YuSIwiSvUakf9QNPBToigEbDZrPfvgoTLBOOp/1QBXtHxvdkNzaFG3JEfs2P9jhbl1xvXEVlVmr/YcbXUbnOygyU6oRKdiuFc1mm6hpXG9+3a8YmJVIHjKbs8iHfXD0BuxESno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEgqHlOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5738C4CEEF;
	Tue,  3 Jun 2025 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748958938;
	bh=G6EUbrZW2Zba7uI+N/OovsE6gXVigC3VmieJfKLitK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DEgqHlOq15AJKpjpU2eTKPw5Ii64PADW695a8Cm5nR+unAc5U9aaccu5M1pUhOBo6
	 GTVPLzCo3OoXW0GfuDhfgOnGIABeC9qV5lEEuL73nBrWfWrPsW5ZQCPfRQp/mj0YfR
	 bh4G73Ds2Iu7SFvcl8bH4muI391CwTGYg4FRYfBlSEnwkasV1YYRs3bBO3pjwxHLAT
	 /5fhAs9pA0rG/LyMyd2qYCXSlTs7dRNoFpZ+se1bA/mIGrsoHNgogGI9wjwQsald4o
	 C1u/5l9LXJ9s08dO3S3cuSmY1SBY/d31mBjSc0HhgJlZGOmjyEC07E0jCMtCFB1e9U
	 Dik0XrEJdI6cw==
Date: Tue, 3 Jun 2025 06:55:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: drv-net: add configs for the TSO test
Message-ID: <20250603065537.718be88c@kernel.org>
In-Reply-To: <bc91b431-9cb5-400a-afee-f5cbfda11788@redhat.com>
References: <20250602231640.314556-1-kuba@kernel.org>
	<bc91b431-9cb5-400a-afee-f5cbfda11788@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Jun 2025 13:17:25 +0200 Paolo Abeni wrote:
> On 6/3/25 1:16 AM, Jakub Kicinski wrote:
> > diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> > new file mode 100644
> > index 000000000000..ea4b70d71563
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/config
> > @@ -0,0 +1,6 @@
> > +CONFIG_IPV6=y
> > +CONFIG_IPV6_GRE=y
> > +CONFIG_NET_IP_TUNNEL=y  
> 
> I think the above it's not strictly needed, because it's selected by gre
> and vxlan (indirectly), but it should not hurt, nor I think we have
> minimal non redundant knobs list in other config files.

Oops, you're right. I'll respin after 

  netlink: specs: rt-link: decode ip6gre

gets thru CI, this change alone fixed TSO but broke the stats test :S

