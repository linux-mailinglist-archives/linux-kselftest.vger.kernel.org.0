Return-Path: <linux-kselftest+bounces-47993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE9FCE7A66
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1CD830087B2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 16:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A96212FB9;
	Mon, 29 Dec 2025 16:39:24 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E53145B27;
	Mon, 29 Dec 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026364; cv=none; b=oSggwiNLl2/NtS8Q7pNuScZfbAA2IH5JER/7b3W9JwvjF76sd/N6eEoluhBFuKESiqr1onYTs9RQLRU3lUac8A6F4be+r9548lG84RiAn7SUpe2cnkqxVSvIaVSYa8fXGKRNlmWMfgbvBOnnZyH5ldfCQat2UXp8lwnt9U6CLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026364; c=relaxed/simple;
	bh=rYXUNxDIW/DguEmwYF0Mt5Ud1Jj6zP1xSCqlFnWGzm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8nB1CnESgS4F+yLr+e5DCEdTY2NXdrERwN+CROHPUEslErUrTv0z8di6+aPOx8syvzmJ+kn58SQnzWuIVr6+cmmIswOVN+/Ay8L6CL0vq6ntXl5X3ARSwRuS8DY0QZ99wPP1owNRW6YLVaH61t0unElGuyK38qxm68jfyfgLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 67689C1591;
	Mon, 29 Dec 2025 16:39:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 3E10120029;
	Mon, 29 Dec 2025 16:39:12 +0000 (UTC)
Date: Mon, 29 Dec 2025 11:39:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Shuah Khan <shuah@kernel.org>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] rcutorture: Prevent concurrent kvm.sh runs on
 same source tree
Message-ID: <20251229113917.1c9568c4@gandalf.local.home>
In-Reply-To: <3a6bfd87-570d-49fa-854f-8d5802549f6a@nvidia.com>
References: <20251228220519.150179-1-joelagnelf@nvidia.com>
	<24f4df13-0875-49bd-95d1-4bf1a400ff15@infradead.org>
	<3a6bfd87-570d-49fa-854f-8d5802549f6a@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iweuhg8w6knq7dxzyeqfepefy6b6n911
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3E10120029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18OjaLolaVaSJvuOjp5++Z2MOKRGTCa+m4=
X-HE-Tag: 1767026352-752526
X-HE-Meta: U2FsdGVkX1+kT7wZgEt9v6MbkEf/3gGZSSTzLmIne2VYubMHzdI8165prhdMxEF8HMofNmrWcCJv8rEVZm1QPpszlvPC+v7zPSe/NiICzgPBKTpvlwCQkPvQl/Yjz85Q763Ht76L4BDFzCwq63F1tkoH+kefNQhvtocyMVUuJlHBxvOeoPXpdEWkA9wJzoiWB5ewgCLrXVICoCh2pXoSTu84hsVIfsKrPAU2GdByCJhFg0/+eVIWHSDQ3hBBtV2l7PwD9Al0+tpBe45z9JJmqNloBK4wgoqlU6R0ukE1KJ4cwQIZIDw5DtOMEEJSAB2v4Y/tBhQf5zWseFeNJymRvuwSkquIQALC

On Sun, 28 Dec 2025 17:37:33 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> >> base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
> >> prerequisite-patch-id: 912adecf969d167ddd35b26844249c809a2d4664
> >> prerequisite-patch-id: 95ca224b0870cebb545ddaf313691fd18dfd04e1
> >> prerequisite-patch-id: 68a218b9aaada53aa85cf33fcf4afe1592fe160f
> >> prerequisite-patch-id: e40912ee9655a8abef17413a1bb9b05d2d4520de
> >> prerequisite-patch-id: c0511755626728abcbed2f76e9a0b1d2f15e7c9e
> >> prerequisite-patch-id: 0a8814cf3965ce3d5fb30d18db3daf2b96c3db74
> >> prerequisite-patch-id: 450827b1f88e4ab714a63a24a66bd209f8c332af  
> > 
> > Are all 54K of these required?  
> 
> Ouch, this looks like a case of git format-patch scripting gone bad. Anyway, the
> patches applies cleanly to Linus's master branch. I'll go look into the
> scripting issue.

That base-commit is 6.15. Seems you likely made every commit from 6.15 to
now a prerequisite ;-)

-- Steve

