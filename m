Return-Path: <linux-kselftest+bounces-43278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDECDBE17E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 121A14E68A5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8261E2222B6;
	Thu, 16 Oct 2025 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="geBJxByL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E997221FB4
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760591278; cv=none; b=O4vmLXPQBx7maxRNyKo/GEOxmPCRqr+Zlwg42ZARuONpPLjSkgmPMaNDhVFMHt/0z24Ls/x8Qh5194FqNTqMvnvrlIMe5LiHVsrx6tJE3H2x8nIDVMyYlh1UJqYJLEd/e0HFR3kvuDAoGPW2neENfHmnkx27Cq29eKH20F4UAUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760591278; c=relaxed/simple;
	bh=BUn/w7Ujb8/rDnrs/nT1AxSoHEFiEVHXe9U2H1NnrMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjrjNgbiOzxeR4OO/YE2ppj1Ode0b4eOghzk/lrySnpH7XmjDSi7k8ri1f4nBS97ztQB36HJafiH+VYxfhKIuCzEt20E5tv1Hnw4G6/5KkP+01av6phfQRXPXjnruMTfLBd0mAQq1+Ck7XhWwHw8g0x3o4MmWEj7AqpC8tu54ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=geBJxByL; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760591263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCAq3Tpy90yiw+VRqp/jzmhdqwWtKZRonlnTXaNao8c=;
	b=geBJxByLcvWBiujKOiaOahCqNyndVoWuu2mZ45TF8xE284+jE46+6ntqZCrEJOY3tjLJtS
	CA04TcSdtSgMTu+1LyL0JCiZYt8KyHlnhHzez+oDkOoqTGathzLcXzzn8tcestdiOMA31r
	Wv+r/T6z/ByuejbAoTutxC4uLBsXkfs=
Date: Thu, 16 Oct 2025 13:07:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][v4] hung_task: Panic when there are more than N hung
 tasks at the same time
Content-Language: en-US
To: lirongqing <lirongqing@baidu.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, David Hildenbrand <david@redhat.com>,
 Florian Wesphal <fw@strlen.de>, Jakub Kacinski <kuba@kernel.org>,
 "Jason A . Donenfeld" <jason@zx2c4.com>,
 Joel Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Petr Mladek <pmladek@suse.com>, Phil Auld <pauld@redhat.com>,
 Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
References: <20251015063615.2632-1-lirongqing@baidu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251015063615.2632-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

LGTM. It works as expected, thanks!

On 2025/10/15 14:36, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>

For the commit message, I'd suggest the following for better clarity:

```
The hung_task_panic sysctl is currently a blunt instrument: it's all
or nothing.

Panicking on a single hung task can be an overreaction to a transient
glitch. A more reliable indicator of a systemic problem is when multiple
tasks hang simultaneously.

Extend hung_task_panic to accept an integer threshold, allowing the kernel
to panic only when N hung tasks are detected in a single scan. This
provides finer control to distinguish between isolated incidents and
system-wide failures.

The accepted values are:
- 0: Don't panic (unchanged)
- 1: Panic on the first hung task (unchanged)
- N > 1: Panic after N hung tasks are detected in a single scan

The original behavior is preserved for values 0 and 1, maintaining full
backward compatibility.
```

If you agree, likely no need to resend - Andrew could pick it up
directly when applying :)

> 
> Currently, when 'hung_task_panic' is enabled, the kernel panics
> immediately upon detecting the first hung task. However, some hung
> tasks are transient and allow system recovery, while persistent hangs
> should trigger a panic when accumulating beyond a threshold.
> 
> Extend the 'hung_task_panic' sysctl to accept a threshold value
> specifying the number of hung tasks that must be detected before
> triggering a kernel panic. This provides finer control for environments
> where transient hangs may occur but persistent hangs should be fatal.
> 
> The sysctl now accepts:
> - 0: don't panic (maintains original behavior)
> - 1: panic on first hung task (maintains original behavior)
> - N > 1: panic after N hung tasks are detected in a single scan
> 
> This maintains backward compatibility while providing flexibility for
> different hang scenarios.
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Florian Wesphal <fw@strlen.de>
> Cc: Jakub Kacinski <kuba@kernel.org>
> Cc: Jason A. Donenfeld <jason@zx2c4.com>
> Cc: Joel Granados <joel.granados@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Phil Auld <pauld@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---

So:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
Tested-by: Lance Yang <lance.yang@linux.dev>

Cheers,
Lance

