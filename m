Return-Path: <linux-kselftest+bounces-34757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A13AD6038
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FC21BC061D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 20:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384328850C;
	Wed, 11 Jun 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az4TPHLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727A1B0F19;
	Wed, 11 Jun 2025 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749674441; cv=none; b=l8BAfxhjRbbm3MKfAo1clgGKanGi1qTSF4vRTW986CzksK0pVdLxW9YybK6GU5rzyB4IusR0xxgjATMt3ixt3pUJb1DtqyeB9MdMXmV3IsWd+Y5d6eBhYQGx3TeTBWaRA2SfPjLfLxvawA+1qnFDZftALAt216ZOSNcDL50eKdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749674441; c=relaxed/simple;
	bh=uirVWt9rb13ek5yxqU0kG0tBN6Zipa/a8Qss9K4NP08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYLkj8p22gexdD3ndHVdiOLsxhAD1s5GoSKA71lVPBmMUyOx0EDF9+Ib0TQbeLD9rX8KJ/xspfa2zOfHzfWmmKi3BLsUnzj4dwhF2PPe9VyQAau1nkq3lXZHoX6+cnkC2OH+mPNRbWa0hZIpaa4zlAAVdwhOvKnQj1xPvHPfmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az4TPHLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40462C4CEE3;
	Wed, 11 Jun 2025 20:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749674440;
	bh=uirVWt9rb13ek5yxqU0kG0tBN6Zipa/a8Qss9K4NP08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Az4TPHLmHMfaLzHXZZo1Ngmr/4uyeu35qgcp/QJLbYVTof+ctGIwnYQII+473UU81
	 snqTDX411u4Qf52NN/iOnkE0GkniFLRFXWNmLbhfhmiRmxMVpfraywXku9yF42fAsX
	 ymWu2ZIu2sByBs2WZl+8x+sEJXUQHyvGHtpz4ZsrluO2E7jRgMvuL0qpTPSFgKVFDS
	 a+15vqcdnu0XbEVRHXMrUny0/XUiwkoy0omczR7bWl9S1feBi1JybNMP+WE8BEqSQr
	 07Truc8Xzm4WbDzDmWHLvfDGODPVlwqJwoDUyl0QESBR/e+KVjUoVabO/UXN3gvZfx
	 QLcdHkEkCErsg==
Date: Wed, 11 Jun 2025 13:40:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] netconsole: append msgid to sysdata
Message-ID: <20250611134039.6f5430fe@kernel.org>
In-Reply-To: <aEmhA0QoZy3LbAu+@gmail.com>
References: <20250611-netconsole-msgid-v1-0-1784a51feb1e@gmail.com>
	<20250611-netconsole-msgid-v1-3-1784a51feb1e@gmail.com>
	<aEmhA0QoZy3LbAu+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 08:30:11 -0700 Breno Leitao wrote:
> >  static int prepare_extradata(struct netconsole_target *nt)
> >  {
> > -	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME;
> > +	u32 fields = SYSDATA_CPU_NR | SYSDATA_TASKNAME | SYSDATA_MSGID;  
> 
> This might be gone now, according to your last patch.,

Right, please wait until tomorrow afternoon (Pacific Time), then rebase
and repost. We will merge the net tree into net-next after we send the
pending fixes to Linus. Otherwise by the time we try to merge this it
will no longer apply..

