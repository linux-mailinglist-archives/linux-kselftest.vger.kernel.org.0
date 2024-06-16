Return-Path: <linux-kselftest+bounces-12025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028D8909E92
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 18:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753F0B20D89
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jun 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D044A19BA6;
	Sun, 16 Jun 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9HZMdr1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292A12B93;
	Sun, 16 Jun 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718555431; cv=none; b=t9P8zDTdqE1mwb5DVf+b4L+mNLLuBOnHmlfBiBWuJOqwNt+IbwfHkcf3Xx4j98z6x2tZdrYBI219lBE6ljKq1wMpk4m7kalUIhoDIPKxk7/e/RyciRPDcr9ADCH5AlXx6i/LZJEHfHRhHbWgdtlrh78GGC7/AjjSJf7zowup1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718555431; c=relaxed/simple;
	bh=sCR8D2uVxVaWZ5pRDD9mWIDZvnVZCm6QCci6666x5/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikqmB9zGjdbByZqTxV04Dq2ij6w9jtUHfOeSPjqt7WLhqJVyGGAaGqS5HP4VVtu/zplkM36bT09+XMJWjaGadJySFkTs08M71/3XfL/EZjmD4ECERjw52Xg/1TcsUB7+5r69bdHuFnmB7m617RTdcj63kM8jxL+yCfnRU1ut4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9HZMdr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B395DC2BBFC;
	Sun, 16 Jun 2024 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718555430;
	bh=sCR8D2uVxVaWZ5pRDD9mWIDZvnVZCm6QCci6666x5/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9HZMdr1WOnwKDgydRzxSLmzMBQni9412eAkPqMbKpNYJMmilYkB/w8zz/CLfmP4L
	 j5vqK2YM8WkYQkAeIYxFLSijbXzFSGb5S7/dfuhAn6OwK4kfnfZ2Sw9F5T7PmR5j5/
	 uqahqZNopnrKN9CrczZgMnicnmKr8PWdvlZVgIbrbUy2Qlj8tL1XKBrim7HMvfbpVB
	 F4EiEonPwmjIj+LpI769Q0JK1ZqSPPDRDzwTxz+XeG7jmHC5NP0L9dU8NlTpFFhs7i
	 cwSe3y/yuSwRpOu3Crmj4fyEUOEsDW/6D6gRK39PJjTL4VKqOIGjxKfA1+0qv42JHD
	 cUvTpYfrAqQqg==
Date: Sun, 16 Jun 2024 17:30:25 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kernel@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [RFC net-next 7/7] selftests: net: add config for
 openvswitch
Message-ID: <20240616163025.GN8447@kernel.org>
References: <20240613181333.984810-1-aconole@redhat.com>
 <20240613181333.984810-8-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613181333.984810-8-aconole@redhat.com>

On Thu, Jun 13, 2024 at 02:13:33PM -0400, Aaron Conole wrote:
> The pmtu testing will require that the OVS module is installed,
> so do that.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>


