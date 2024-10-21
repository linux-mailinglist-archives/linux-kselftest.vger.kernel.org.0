Return-Path: <linux-kselftest+bounces-20236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 662179A5B17
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 08:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC5E1F219E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 06:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39BC15575F;
	Mon, 21 Oct 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="KBzUJF3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6A1D0E1A;
	Mon, 21 Oct 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493363; cv=pass; b=ib21ixMQh8+k5h0Rg37Qubv0P/u2hLqafBM0SxNhzm+zO7T/Vvn6ukQFSxvf04xoQL8EtXd78U65odwhl9ZynIPW5BjfoHSl+ydQfI88EP51l6W4bPYyhWPkzt2CTWvH/xOL6aLHEdo6BwWA2QkHfvsUJxFf4B5cdkpHWz4hTF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493363; c=relaxed/simple;
	bh=O31qd5SCkfOYqmj8pjHYTWjM/5OuBWMei43eQiK/a+I=;
	h=Message-ID:Date:MIME-Version:Cc:From:To:Subject:Content-Type; b=Gph7isqcRXiT98eZViBb1O2mEaCkcI1hwgA620mSWO4vBGVrzlKvGegc6JlM/N0NHh+dOxIUOaYHGqmtsRsiWCeB5AeO6QF0ve+jfsfDFKEydH0+7nhYJYgr6RqyUNmc/pS9xVHSWBRArdJ4ZEUXtYjwTMk4GIVU2vJD49hUG0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=KBzUJF3p; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729493345; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gh7OYhG8mPDzF2AxEmqphfR9zhQAvQfUh5+TBVlbGhO2yONNOS4oHjDKAGO+O4pt03ILd/AhxtWX7K7lDb5hSML/6xPPoYC3VKE7dU1Hq4VO3yysIwQ6gkA4UWbsZvsiLYQGRPqHpNfE9CsYnZJ6jpQcm9q8M7NeU7GyYoDU/l0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729493345; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v8iHK6bjZYLzIOEmNBVWQXJWM7Hq1uPf06zA4c17Sso=; 
	b=i4oWBID16wvPn/fu4spRBm+YDtEQ+uyXci34sOkDWWsDeUBCxj2tpnZ520s25KpqQJvKLvrxtCsjKYEyMfkH0GAWOji5F9gZh5XBOo0jyqeg6gey914tVMRjUDqHH4cTgrO9+wBMSn/JpeX2KYpMQVkGcCG09Q4bmTkydDZj4pQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729493345;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:From:From:To:To:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=v8iHK6bjZYLzIOEmNBVWQXJWM7Hq1uPf06zA4c17Sso=;
	b=KBzUJF3pV1I1LM5ZMXZwq7xhAOC/2iybKdC1qUwB31FLsdWX6rLOHfRq5VXtfJbh
	O1mFrAGNH2lXuiZ2KNDHMhqo4BCAFHl84V8Mde29Hz01T6iNiWI5ASdAxiPSMS9rDk2
	Nwrbc92XhOzBqar4ee9yt8DUev5iFk7Wjg24M8pU=
Received: by mx.zohomail.com with SMTPS id 1729493342530119.03883380317552;
	Sun, 20 Oct 2024 23:49:02 -0700 (PDT)
Message-ID: <3d07e4c3-e413-4378-82da-265a477bedb3@collabora.com>
Date: Mon, 21 Oct 2024 11:48:57 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Kim Phillips <kim.phillips@arm.com>
Subject: [Bug Report] Wrong value of __NR_userfaultfd in asm-generic/unistd.h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

The asm-generic/unistd.h file has wrong __NR_userfaultfd syscall number which
doesn't even depend on the architecture. This has caused failure of a selftest
which was fixed recently [1]. 

grep -rnIF "#define __NR_userfaultfd"
tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define __NR_userfaultfd 374
arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define __NR_userfaultfd 323
arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282

The number is dependent on the architecture. The above data shows that it
is different for different arch:
x86	374
x86_64	323
ARM     347/358

It seems include/uapi/asm-generic/unistd has wrong 282 value in it. Maybe I'm
missing some context.. Please have a look at it.

The __NR_userfaultfd was added to include/uapi/asm-generic/unistd.h in
09f7298100ea ("Subject: [PATCH] userfaultfd: register uapi generic syscall (aarch64)").

[1] https://lore.kernel.org/all/20240912103151.1520254-1-usama.anjum@collabora.com 

-- 
BR,
/Muhammad Usama Anjum

