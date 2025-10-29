Return-Path: <linux-kselftest+bounces-44365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2E2C1DB3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 00:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847D4188E43F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 23:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B9031A059;
	Wed, 29 Oct 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M84m9vWE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9853191AC;
	Wed, 29 Oct 2025 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781321; cv=none; b=mD82nqHNlTxBg12OHVbjASNfrjEqXC7lqbVrMLIfL2hCf5HqQoB50guci04qp4hUEFDGWJUE+bVpHFxdYFmPoU68U8ngyQOnyHIw6cY8qd34qtscPBnrHM7xaChN9N95N2ohcMcPs5sMDtHo+HWhX/FcwM730hFD7oA0+fUWxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781321; c=relaxed/simple;
	bh=ONAv1gW9fNgvWAkNTAuKtk3AzICyi5zhrnXhg0Unp50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZJ60p8efrpZf1AwYsamkvsVSY8kC4O+SbodXmlToUHhe/81dNLXZl/Uk+qcWNYTqxmOjQeNJl+SRm4tXcyqFSwxkPLoFP+I9yIKiiU9FRV9kkrrT7CUMEzGN5eDEFM/OTmLgroO6BwgJST7ehVAkabL4l0H/DAVe7Jv3LJRRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M84m9vWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF55C4CEF7;
	Wed, 29 Oct 2025 23:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761781321;
	bh=ONAv1gW9fNgvWAkNTAuKtk3AzICyi5zhrnXhg0Unp50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M84m9vWEi2Jzjby28FXCgF5D9Ysf9dYV68EDTvaZnYs5a9xj6NjCMeBDDVagLYPkX
	 RwxOJEw+ezouMChE2y4Wremvm4OKDQullm0HMZ3MDql5wkK1NHUigxs+bvfQoKmSTR
	 eYzD55GILvlfolMQI61eiqLl/u4UNftvYsBxVd/eCtYyZMvtKguOCge2QACWDeYiM2
	 oC2ri90B17Sy+ueuIY78t2tr8zr1033KthRSXuU0x2DdwWrQR8v35voln/h0jggZZN
	 A50ijpN8A/G4i5Jk0EYUa1OAOkZ8MIl/17729LNHXMPwepIsMh2tYh64OpXYAAFuah
	 SJWOemadF4LXA==
Date: Wed, 29 Oct 2025 16:41:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jan Stancek
 <jstancek@redhat.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Guillaume Nault <gnault@redhat.com>, Petr
 Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: net: add YNL test framework
Message-ID: <20251029164159.2dbc615a@kernel.org>
In-Reply-To: <20251029082245.128675-4-liuhangbin@gmail.com>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
	<20251029082245.128675-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 08:22:45 +0000 Hangbin Liu wrote:
> Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
> ethtool functionality. The framework includes:
> 
> 1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
>    operations
> 2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
>    feature gettings
> 
> The current YNL syntax is a bit obscure, and end users may not always know
> how to use it. This test framework provides usage examples and also serves
> as a regression test to catch potential breakages caused by future changes.

Hm, my knee-jerk reaction was that we should avoid adding too much ynl
stuff to the kernel at this point. But looking closer it's not that
long.

Do I understand correctly, tho, that you're testing _system_ YNL?
Not what's in tree?

