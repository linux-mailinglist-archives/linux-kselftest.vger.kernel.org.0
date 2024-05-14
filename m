Return-Path: <linux-kselftest+bounces-10196-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C148C5C8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271C81C219AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED1A17BB0D;
	Tue, 14 May 2024 21:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="p+vex417"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B261DFD1;
	Tue, 14 May 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715720406; cv=none; b=AwSO/XJQ2lhgbNm4kIUHbLn9lL8ElPYyVtsdhROMtSGNvhq69CMkITMxTR7cEy6hVqkv+8t8IIX6/13nzCTp1pnWCJHXqR/JSUastmr6IWepsZFU+LA9gVwEXnyAvvTR7f11V40ADMRlHfOZ5nzWAREoUJkif995+tvCV/OC1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715720406; c=relaxed/simple;
	bh=LzIjbm8EmhE8nz2vY1r+uwzY38OtTNn3Qux8G3lPnvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=myO82dOphTUZdOfS4QyPOBBaP8ZUQtu0bWBqyjcYq50lyVKzNxI6BIR4cWXe5IC+e5f8NQ36xI567T2HroZZuQ385/cYFX56qiLYWtZKT3Gu1rgO8vVQmPSAbhTupLKNH/iQ23sPLaDVGSwAV7DgbnOX1zPButt+fPPGUj+249M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=p+vex417; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E2D8847C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715720398; bh=Pm5GQXvf/+T4Nt95ku2E3tncArTWJsHx/sY7VG5ZKk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=p+vex417G255x4AnYioFbmLzZwUfVWPjslsURVv7taRXwTjPhbNIKXelbcHcM+MHc
	 9akB/ulGNSIlMfk+xZynwa4QJTvWehWuSw/lqxXkjgsP0WkNsU+EWxPcEGce1kNczs
	 JZr3Yz34r/86v6FF7E+cuyjKxAOirYHnxfD1jTeXW89Cq7pQ1IxE1q4TGx3bjXIvq3
	 NcIc/t0VZrwDWBVuqDDWmj3ivv6e0wGfmQtr/1z0g8aTMuRxG+J3qIlqBKFZGSC7E5
	 UPvCg5LKwNVTTskGHeK5DQ5Vd6oVG1O6+evGJQxmiUPcCgGjutu9qxI9sHp9ixOJlU
	 aZTRYcQ6cJ96g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E2D8847C39;
	Tue, 14 May 2024 20:59:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org
Cc: keescook@chromium.org, jannh@google.com, sroettger@google.com,
 willy@infradead.org, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com,
 Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
 rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
 groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
In-Reply-To: <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
Date: Tue, 14 May 2024 14:59:57 -0600
Message-ID: <871q646rea.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
>
>> This patchset proposes a new mseal() syscall for the Linux kernel.
>
> I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> of the total lack of Reviewed-by:s and Acked-by:s.
>
> The code appears to be stable enough for a merge.
>
> It's awkward that we're in conference this week, but I ask people to
> give consideration to the desirability of moving mseal() into mainline
> sometime over the next week, please.

I hate to be obnoxious, but I *was* copied ... :)

Not taking a position on merging, but I have to ask: are we convinced at
this point that mseal() isn't a chrome-only system call?  Did we ever
see the glibc patches that were promised?

Thanks,

jon

