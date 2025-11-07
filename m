Return-Path: <linux-kselftest+bounces-45149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3C5C41D01
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 23:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A62F44E220C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 22:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B68313526;
	Fri,  7 Nov 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dT6JdUUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8024BBE4;
	Fri,  7 Nov 2025 22:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762554189; cv=none; b=gUhR/M97MGymMvtJtBt9yI+4W5PrtoYK025tyN5n3ZOm237AWYv+DojJPgzIgzPUV6oeH1DCjfgzIjZUwqB3OYnrp4/lUTh92W2XAEJRCQqV1tfF8zDjPRuVPCkUMIszKALOyT4xgTobLYykBcK7K3kjA/z+Gmzcdw53PVgqZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762554189; c=relaxed/simple;
	bh=FmDzUf7SRYX26khc/FKuixQdWMPPvqBeIjyLbJIHFBs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XuY71hlw/GZV6wYrY95mvwamp9VdEzzIptdxyc12+n+D2iYDzwT5Rtb7LphogUZZpnFEQVBE/PIrm8QF6u5gtqdZvHIligl3qnwsRAsn2U+wk7E3M1JXv8wliG8MZAqRdbOhcgbMdIptZI2kJVgS4mQ3kCP9/4jhu4QSKBsgmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dT6JdUUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215AEC4CEF5;
	Fri,  7 Nov 2025 22:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762554185;
	bh=FmDzUf7SRYX26khc/FKuixQdWMPPvqBeIjyLbJIHFBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dT6JdUUOd3RRXNCr+BF5z4qtDip1YMFAJDddH6o9kkPBlPjwM4PLsv26aW9NqWTbK
	 2j51WG4IOwihfeKZOyhnK4035ea0hYTn+L4GHaVZnsxvlrzpXFNJ8yfoua/Xaqcvph
	 6DNCvhV6w94ohERu6WaMgjwyjLaMUXAnjACmeAno=
Date: Fri, 7 Nov 2025 14:23:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: brauner@kernel.org, corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
 pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org,
 yanjun.zhu@linux.dev
Subject: Re: [PATCH v9 7/9] liveupdate: kho: move to kernel/liveupdate
Message-Id: <20251107142304.6d22289c96023fbb7e99464c@linux-foundation.org>
In-Reply-To: <20251101142325.1326536-8-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
	<20251101142325.1326536-8-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Nov 2025 10:23:23 -0400 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> Move KHO to kernel/liveupdate/ in preparation of placing all Live Update
> core kernel related files to the same place.

I notice that menuconfig is a bit weird after this.

The "General setup" menu offers the "Live Update and Kexec HandOver"
menu but there's nothing in there.  If one sets
DEFERRED_STRUCT_PAGE_INIT then things look normal.

Perhaps we shouldn't be offering "Live Update and Kexec HandOver" at
all if !DEFERRED_STRUCT_PAGE_INIT.

