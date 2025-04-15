Return-Path: <linux-kselftest+bounces-30810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD33A890C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 02:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A73189AD6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB07E552;
	Tue, 15 Apr 2025 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PwkHdwE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA122094;
	Tue, 15 Apr 2025 00:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744677457; cv=none; b=YKejWKhI2yJPVqM9ODZOksMmiMSUF1HcBiZo7Fw3utI7lNwXta7YWjYzANNhSTVUi5EObchEN9VXQT4wB2F/Pm7UkgHPO4u8Ut/Sdon/Au6htrcYpIRBmIdp6Um6nxGVWAhw/C03nYh8G3n+Aux1rgk7BB1HOldkfIjpKSBZiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744677457; c=relaxed/simple;
	bh=BKjY152TqSHnl/R2OkCqnsJ5UUXhKjxjkyZn/0IHKEM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k0r03HEI9q4daZ4asGNvUODS1nY+BWy0R50JLgVfJlXaoEZdflcKUsGdDCC34n+WJT0P671tqTRIMTGNvE5UvWulmCg0a+Op1BZpK8R6AQoHLnMFRX8OmsW6IfLfVNRY18Pg/cl56Mgx+QpG8B7T+0yzANer+0ISwlweGphUXdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PwkHdwE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB70C4CEE2;
	Tue, 15 Apr 2025 00:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744677456;
	bh=BKjY152TqSHnl/R2OkCqnsJ5UUXhKjxjkyZn/0IHKEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PwkHdwE1rRPalwMm1IbYyCJeil1SBZXw0YjTdvnuz6/Z96tKznLgTO6+N8r2Vigm9
	 bi2O5VpS8BaMVnVoK/FbabJZyA7/USMkApPLRTDHQXSibO6Dw9Is5LZbDAZpit/10T
	 hWguV+7O9zv8PqKYevGfICE6KTeGRhcNlEHaEJbE=
Date: Mon, 14 Apr 2025 17:37:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 corbet@lwn.net, shuah@kernel.org, david@redhat.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ioworker0@gmail.com, ziy@nvidia.com,
 wangkefeng.wang@huawei.com, dev.jain@arm.com, mhocko@suse.com,
 rientjes@google.com, hannes@cmpxchg.org, zokeefe@google.com,
 surenb@google.com, jglisse@google.com, cl@gentwo.org, jack@suse.cz,
 dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, raquini@redhat.com,
 aarcange@redhat.com, kirill.shutemov@linux.intel.com,
 yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com,
 vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/4] mm: introduce THP deferred setting
Message-Id: <20250414173735.b6df2f87c2e8dea610efa901@linux-foundation.org>
In-Reply-To: <20250414222456.43212-1-npache@redhat.com>
References: <20250414222456.43212-1-npache@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This will need updating to latest kernels, please.

btw, hpage_collapse_scan_pmd() has a trace_mm_khugepaged_scan_pmd() in
it, which seems wrong...

