Return-Path: <linux-kselftest+bounces-40233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08867B3ADE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 00:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C567D7A8097
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D6299AAA;
	Thu, 28 Aug 2025 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L1f61/R9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0628BABB;
	Thu, 28 Aug 2025 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421655; cv=none; b=cXu99sWBMYtbzu3+72DIB+cAgyEwneLDjcVYPasfQKf9hmLFoR2mS2QI3G+C0aaZnKcPjnY4QEC3z6X0k2VZvfPUz9he/TizYeo81NPU+loc4jGktAeFHyvH67NE9BHwgLX0M0jTnXNOoEABBFEJ7JC52eYO3SlmQhXZtx97ihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421655; c=relaxed/simple;
	bh=2+UzjJF2BlEl8nA15jThQAGkqhW2IMETJx5lsJ1gMK4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J2jZhxvLgyTPTHbLA1tUay2z3oWcB5Nn/qC+6RVXBQLf4/TZ/Z9U4Qw1HSSU+kmO4IixsQp3bLn4wKT14beg7ICTmFsnu6AWLuEMoopfuIDZT0n2hIL9icxN0yUFtRD+s50vOn0pA3kfRlYiYOrv9NXliZrkqNyFHO1F4k1q8ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L1f61/R9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6E3C4CEEB;
	Thu, 28 Aug 2025 22:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756421653;
	bh=2+UzjJF2BlEl8nA15jThQAGkqhW2IMETJx5lsJ1gMK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L1f61/R9NWDd46wsfh3wOnq5DAyDH1ultA74tABD9myh4H3YI7/pC6Qmnh9NvqvEL
	 GM3tAXqIrrO9F1VaWGcXa7y5OdCe/japCYCzgUASGPbCeUQIkwbb7jeqQpEy6JmW+F
	 qTNFK/FCMZNPGCwq9NU3g/7VQt4xYczY/vAy2OFo=
Date: Thu, 28 Aug 2025 15:54:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Brendan Jackman <jackmanb@google.com>, Ujwal Kundur
 <ujwal.kundur@gmail.com>, peterx@redhat.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Muhammad
 Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v7 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
Message-Id: <20250828155412.2b1b2095125428af24896af5@linux-foundation.org>
In-Reply-To: <kd6uteyd4vzlnbdwzjydwd7hoqyxewc5fx24z5sq7svmtoa3oo@n57xyeu3vtyy>
References: <20250817065211.855-1-ujwal.kundur@gmail.com>
	<DCE2EJ3KWX3K.1Y198FHBV8UG7@google.com>
	<kd6uteyd4vzlnbdwzjydwd7hoqyxewc5fx24z5sq7svmtoa3oo@n57xyeu3vtyy>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 14:49:37 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> * Brendan Jackman <jackmanb@google.com> [250828 08:37]:
> > On Sun Aug 17, 2025 at 6:52 AM UTC, Ujwal Kundur wrote:
> > > -static void noop_alias_mapping(__u64 __unused *start, size_t __unused len,
> > > -			       unsigned long __unused offset)
> > > +static void noop_alias_mapping(uffd_global_test_opts_t *gopts, __u64 __unused *start,
> > > +			       size_t __unused len, unsigned long __unused offset)
> > 
> > After a rebase this is now falling afoul of the -Wunused-parameter added
> > here:
> > 
> > https://lore.kernel.org/all/20250731160132.1795351-5-usama.anjum@collabora.com/T/#m0449dc0d6a5ac3b1f71f7182c13b6829e1b444cf
> > 
> > I really don't think we want that flag, I'll comment on that thread, but
> > just as an FYI here too.
> 
> I was under the impression that it was decided to drop that flag,
> otherwise I would have also spoken up about it.

err, yes, I thought I'd dropped that.

No -Wunused-parameter, please.

The v2 series needs work and a v3 series is expected so I'll drop the
v2 series "selftests/mm: Add compiler flags and fix found warnings".


