Return-Path: <linux-kselftest+bounces-47296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 216DACAF298
	for <lists+linux-kselftest@lfdr.de>; Tue, 09 Dec 2025 08:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24BC6301143F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023F286D73;
	Tue,  9 Dec 2025 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRtbQdo8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42592226D02;
	Tue,  9 Dec 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265871; cv=none; b=p/z0xR4GPoLlWMNemYkbNCweyQMwPdR37poAzOmvwTz0kA4Xk+Bc+Z1rV7/AaBL1aVBK6v+tqhFHywVeNaWhtjKVh5ZukPmuoZz9APNMNY08wr4wSI65h7GYcPk9m9BViD9fo7Bi60eA2S6YGGO2xTH08MsKkWRCGOV7nqznbGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265871; c=relaxed/simple;
	bh=PvvpvDEgxqUV3rvRXi5qKsznNiPJ9ikDtGVfJCATNhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaKzgC16Wbw1HDUzmGi4vISsOMrsKeH1Y346oT+lvv/bPa3SdzX06UO4H0YVWWX8freuC2Ey3+q1VgmzJeYjixOO2EUD+/BVM0ZtVX01X/nrX9nD3WcpfNMcMHVaL8qx+dNhIQCOkQ3CppeLa8Buk5qd5xB5iH3a2yGW4mm5Y74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRtbQdo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53BEC4CEF5;
	Tue,  9 Dec 2025 07:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765265870;
	bh=PvvpvDEgxqUV3rvRXi5qKsznNiPJ9ikDtGVfJCATNhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRtbQdo8NqlOi3WcWIgiE2/q74u9pmr2xr2OyqS+YGl3T1aK7IXIECeXNOLBUjFtO
	 5hdQbtSMy4uatkCZqbo9fUg9YbuiPPH5Nj1GWE8NVDIVNvcK2j0LFOkISgQPxKwbvY
	 K8t4DXIyvmkV1W2Gi3iOl9275qMtskAD5dzaYbQGJZGOHPqOW+nBua+ifs/b9o4PwB
	 trxVfveyDVyHE/tDRw75MI67e1vayU4//fExuhRoa3tB0vzI+w8RD0S00U/ZQbS+Mz
	 86hdawVt1pXE070HoUciv4/u0gleWZKsjcmCYVc6/UTiCQNtEJiGk6hkDmxScobbmC
	 THIYKbKsJE9+w==
Date: Tue, 9 Dec 2025 16:37:45 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Petr Mladek <pmladek@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
 kernel-team@meta.com, davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 0/4] (no cover subject)
Message-ID: <20251209163745.3d0fcdfe@kernel.org>
In-Reply-To: <7jdruzcpkeyhuudwi6uzg2vsc5mhgpq7qz4ym7vqqmgs7j3524@cvtnzneddg2d>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
	<20251201163622.4e50bf53@kernel.org>
	<4oybtunobxtemenpg2lg7jv4cyl3xoaxrjlqivbhs6zo72hxpu@fqp6estf5mpc>
	<20251202102442.568f91a7@kernel.org>
	<aTFmew5trILX3RpO@pathway.suse.cz>
	<aTFnzmc0ZtBvGg4y@pathway.suse.cz>
	<7jdruzcpkeyhuudwi6uzg2vsc5mhgpq7qz4ym7vqqmgs7j3524@cvtnzneddg2d>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 02:21:08 -0800 Breno Leitao wrote:
> 1) Have a binary in each machine:

> 2) Send a ping directly to the console

> 3) Using per-loglevel patchset.

> 4) send messages only to netconsole (this patchset)

I think I was alluding that another option (not saying that it's the
best but IIUC your requirements it'd be the best fit)):

5) Add a keepalive configfs knob, if set to a non-zero value netconsole
will send an empty (?) message at given interval

  Pros:
   - truly does not require a user binary to run periodically, netcons
     would set a timer in the kernel
  Cons:
   - does not provide the arbitrary "console bypass" message
     functionality

