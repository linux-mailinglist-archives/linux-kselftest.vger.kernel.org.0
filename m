Return-Path: <linux-kselftest+bounces-23845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA75A003D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 06:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68291883B91
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 05:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D759B71;
	Fri,  3 Jan 2025 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aQZpAR0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DEDBE4F;
	Fri,  3 Jan 2025 05:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735883837; cv=none; b=iZFI0UzDrYkrToxuwBMnE3s6AxAXNdlKt6f1N9gFHPIsGYGV1GF7JQFTpL97ryDpaEwHkHSKotJjLaHGbDwK+oyq/oLtThPuJ1XOzxGOxCpeTeM/jVem0XHHEHZLq+1HJJKh8FUtv1JrkFuZcA3W8BQ8soHNb288ZUXB9D3Hrrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735883837; c=relaxed/simple;
	bh=ahkJxGtysqPWgnOL67yhgSmmIjzKoeYD0h3gq1Efw8s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qjZHujU8EJbrI+2bPTDN1//ge5GnByQYQfZp0kot0CHrDc2upTqXVjxCieIJiHQujqyJY18scziqXAvLPwOiDzIxhTCUa2CKtg7pq8xcsAPVH/N1/qACLAr7ldOzfMgGmnogg1uNCJXGYWDqhdIewgyHCv3QmvCjH7Oy25l6XRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aQZpAR0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77287C4CECE;
	Fri,  3 Jan 2025 05:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1735883836;
	bh=ahkJxGtysqPWgnOL67yhgSmmIjzKoeYD0h3gq1Efw8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQZpAR0mwD+9uME8jJKLdIKsDsBBNx7RFftbrdOt2Z9ezUhGkaSxQYeWN3B5a5lXK
	 swbw4eAbHvBcyBGp53eUADLv9enJyd7F1VABGcwP2T6kkfI7+ZcsM5B7c9YUKvQsve
	 5gOb9teUK9gxiG0ELqADgwYPpQaTpTwlUT6BuhO0=
Date: Thu, 2 Jan 2025 21:57:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: lorenzo.stoakes@oracle.com, anton.ivanov@cambridgegreys.com,
 bp@alien8.de, brendan.higgins@linux.dev, da.gomez@samsung.com,
 danielt@kernel.org, dave.hansen@linux.intel.com, davidgow@google.com,
 dianders@chromium.org, hpa@zytor.com, jason.wessel@windriver.com,
 jikos@kernel.org, joe.lawrence@redhat.com, johannes@sipsolutions.net,
 jpoimboe@kernel.org, kgdb-bugreport@lists.sourceforge.net,
 kirill.shutemov@linux.intel.com, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 live-patching@vger.kernel.org, luto@kernel.org, mark.rutland@arm.com,
 mbenes@suse.cz, mcgrof@kernel.org, mhiramat@kernel.org, mingo@redhat.com,
 peterz@infradead.org, petr.pavlu@suse.com, pmladek@suse.com,
 richard@nod.at, rmoar@google.com, rostedt@goodmis.org, rppt@kernel.org,
 samitolvanen@google.com, shuah@kernel.org, song@kernel.org,
 tglx@linutronix.de, x86@kernel.org, Juergen Gross <jgross@suse.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH 6/8] modules: switch to execmem API for remapping as RW
 and restoring ROX
Message-Id: <20250102215714.a37e828cf073ea6a14d30559@linux-foundation.org>
In-Reply-To: <d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
References: <86eba318-464b-4b9b-a79e-64039b17be34@lucifer.local>
	<d48193a3-65fe-4aa9-98f6-dd5869bd9127@citrix.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 02:06:10 +0000 Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> > Hi Mike,
> >
> > This commit is making my intel box not boot in mm-unstable :>) I bisected it to
> > this commit.
> 
> For what it's worth, we've found the same under Xen too.
> 
> There's one concrete bug in the series, failing to cope with the absence
> of superpages (fix in
> https://lore.kernel.org/xen-devel/6bb03333-74ca-4c2c-85a8-72549b85a5b4@suse.com/
> but not formally posted yet AFAICT).
> 
> The rest of the thread then found a crash looking to be the same as
> reported here, but you've made better progress narrowing it down than we
> have.
> 

Thanks.  I removed this series from mm.git while this is worked on.

