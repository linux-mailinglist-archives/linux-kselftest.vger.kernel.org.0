Return-Path: <linux-kselftest+bounces-19021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D87990499
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F74FB212B5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D00210198;
	Fri,  4 Oct 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj0tX4Fa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFED15B97E;
	Fri,  4 Oct 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049136; cv=none; b=qjI4UrZylYwyjp+IWTXvu0iH2arKUWQAI5gqmptgmmkXZs55dlY8c81JcaYFRRaPnsGKUJfK8N03gS4jnWQ6s0LVTxA5bS4yWNN5pJVxQu5WRzwV+IG4eF1cM+9g4djvQF28fBwBaMo1hB4GlocR9kGQ70Bg/gUxb7Xham6FtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049136; c=relaxed/simple;
	bh=MbwCBbQfVBOEVxdvZYeuqOkCdxo6nLHQpcZl976M6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVJwiiSkXl3ITyGNmclhoxPkuB1u2eGrakaKvzjIthZmRQ9cWty3I1KealgJEjEfmusBpl5tGf/q8a9aAgulGPSFTbB0DdPRjfuEwUyKOKRVOjYYg2+MOpTTW6MvM71JLU+jTefxdJXhdyXOpc/H87yxQ7Al/PD0GRtYJcJANag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj0tX4Fa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01DAC4CEC6;
	Fri,  4 Oct 2024 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728049136;
	bh=MbwCBbQfVBOEVxdvZYeuqOkCdxo6nLHQpcZl976M6o0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lj0tX4FaMuRJS1fv4v7zpxIlE0o/Za6sIyhw/UD2qmRYqLiPx0rtogMqJg+995uV3
	 sIs4vTIJC5UPeDaOijmMTNyG1Tqe56y4NFTE4tGfbY9opoXVl8anZciVlRfYCDUei4
	 gWcIOdvjlMkHMLNi+R8yWt+qAc6meUCa0nv83nmqd6n6wAnxg/EuLxqQNTdxiz6jHk
	 TEbZd1oCh1es3pn0vdxrAkxZaoBg+0n41vjSTpU82HxxJqvz/9zFBslJp+FVS43JTV
	 GyLD1VUCfI/ZZI0Bc3DsE1m2Yqgb5HkjP43E4deW14wK7p6uRiWHyXtUMWaWdyYmQ4
	 oib+OzhqAku+w==
Date: Fri, 4 Oct 2024 06:38:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com
Subject: Re: [PATCH net-next v8 01/24] netlink: add NLA_POLICY_MAX_LEN macro
Message-ID: <20241004063855.1a693dd1@kernel.org>
In-Reply-To: <m2msjkf2jn.fsf@gmail.com>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
	<20241002-b4-ovpn-v8-1-37ceffcffbde@openvpn.net>
	<m2msjkf2jn.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 13:58:04 +0100 Donald Hunter wrote:
> > @@ -466,6 +466,8 @@ class TypeBinary(Type):
> >      def _attr_policy(self, policy):
> >          if 'exact-len' in self.checks:
> >              mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
> > +        elif 'max-len' in self.checks:
> > +            mem = 'NLA_POLICY_MAX_LEN(' + str(self.get_limit('max-len')) + ')'  
> 
> This takes precedence over min-length. What if both are set? The logic
> should probably check and use NLA_POLICY_RANGE

Or we could check if len(self.checks) <= 1 early and throw our hands up
if there is more, for now?

> >          else:
> >              mem = '{ '
> >              if len(self.checks) == 1 and 'min-len' in self.checks:  
> 
> Perhaps this should use NLA_POLICY_MIN_LEN ? In fact the current code
> looks broken to me because the NLA_BINARY len check in validate_nla() is
> a max length check, right?
> 
> https://elixir.bootlin.com/linux/v6.11.1/source/lib/nlattr.c#L499
> 
> The alternative is you emit an explicit initializer that includes the
> correct NLA_VALIDATE_* type and sets type, min and/or max.

Yeah, this code leads to endless confusion. We use NLA_UNSPEC (0) 
if min-len is set (IOW we don't set .type to NLA_BINARY). NLA_UNSPEC 
has different semantics for len.

Agreed that we should probably clean this up, but no bug AFAICT.

