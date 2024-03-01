Return-Path: <linux-kselftest+bounces-5767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E7386E933
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 20:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA6B2354C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359139AE7;
	Fri,  1 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMXuiEgp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A62575F;
	Fri,  1 Mar 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319307; cv=none; b=TWXxamb8lIElFn/BS0NeICGcHDeTJv2/ifu0PebP3nqMlRNTsifmmMLrsUc7kNVr0nyFPPNaL5EYwBwfRN5ja4/mqsqDbKujTNf0q4LFo4QMody4tTS4EybqTyFQOXgKE3te01nMJAzozg8ekeQ9eMnsh20PBxwLW4bbBRnCuyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319307; c=relaxed/simple;
	bh=XCC6vlXOFksp/35D+aqHfXii8v2d5MABVGmpsgCqCPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0ZV6lpeD0zzDDx9kT4qgWFaEfdN9pPtf1DdzHtaGaoRT3K0AbHZfiPJOgjt7VIk5T1OeoQUl+4rA+hLOHM7No1BZBJGXqGiaKKpkRh+jHstcAiCotVt6PpejQdh/hQncKQ4MMKtMhi3KfeZlHNsKVrvOZy8SzCD52AB/4zGyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMXuiEgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D029C433C7;
	Fri,  1 Mar 2024 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709319307;
	bh=XCC6vlXOFksp/35D+aqHfXii8v2d5MABVGmpsgCqCPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMXuiEgpD8QUmcXSUBOXo/tUAwIsKBI0y33mLcsQwglyFEbYYrjVADOogllAfQnHq
	 yIPEH6AgFeZWPiisnhtNqkPPG+mw14uXg/Rp/VlkUvur+xZoTJciFCan29fht6276F
	 yKeL0UBtWJ6Q+KGlG3EoT040/UBT8cW+snCkJpCSZfrKdVMwxj7qy4g9bCevJTHLdj
	 KEUtjfDaGz8FSYzLXB7HapVuZwsw2UX/wdfnt0y5m8ms3SSBb4tGEkAF/z4NP83gyB
	 pLvjXHY7ZibXkwuelzk/c3iMo7J3UHauRS6KSJDUibHJzDZL88FnjU59c0f/LNqQDo
	 kUCbhfcgThnuA==
Date: Fri, 1 Mar 2024 10:55:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal
 <fw@strlen.de>, Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan
 <shuah@kernel.org>, Peter Krystad <peter.krystad@linux.intel.com>,
 Christoph Paasch <cpaasch@apple.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 10/10] selftests: mptcp: explicitly trigger the
 listener diag code-path
Message-ID: <20240301105505.7909a451@kernel.org>
In-Reply-To: <52f0cd4c-9306-43af-87a7-3f5c47646059@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
	<20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org>
	<20240301063754.2ecefecf@kernel.org>
	<09046dcc-a388-4703-83bb-9fa0c36af861@kernel.org>
	<52f0cd4c-9306-43af-87a7-3f5c47646059@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 19:24:53 +0100 Matthieu Baerts wrote:
> > Thank you for this message!
> > 
> > I didn't have this error on my side, even without '-d SLUB_DEBUG_ON' we
> > do on top of the debug kconfig, but I see I can reproduce it on slower
> > environments. Indeed, it looks like it can be caused by that
> > modification. I will send a fix ASAP!  
> 
> The following patch fixes the issue on my side (when using 'renice 20'
> and stress-ng in parallel :) ):
> 
> https://lore.kernel.org/netdev/20240301-upstream-net-20240301-selftests-mptcp-diag-exit-timeout-v1-2-07cb2fa15c06@kernel.org/T/

Nice! Note only a fix but also lowers runtime, if I'm reading right!

> I queued it for -net, but the issue should only be visible in net-next
> due to the reduction of the timeout, as you suggested. This patch can
> also be applied in net-next if preferred, it will not cause any
> conflicts between net and net-next.

No strong preference, net sounds good.

Thanks for a quick turnaround!

