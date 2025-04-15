Return-Path: <linux-kselftest+bounces-30811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258A8A890E5
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901A81897C73
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D75336D;
	Tue, 15 Apr 2025 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jF8PKxXT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112E6FC5;
	Tue, 15 Apr 2025 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744678220; cv=none; b=fRgrR7ewnwqvZ0RA45TgL9Kpz7iUjSuftFlGbXjIZtAVvibOcDavFjNiHJ25Q8omyLh5b17vU4gvcWL6m6AvpLp0MBVcFhush241T5CodvNNGjoxDzlpJGHIWfKU0rx/X1Cyjmh8I9GAFDq42XWdPe50yxE62+AuL/erZ1TqaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744678220; c=relaxed/simple;
	bh=fkIT4XOhmgQ9Dgwghj4eYY0BwPt0ZkTj4KhWD2vfeM4=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FH5lvHYn76hO2au1SMrtf/vLQEXO4txTj7pWMwAlv644qE0zVlx6xOe7kocZrzHe70F8vnmVBr5Y2wR1zTp4qJbiOBrXMceE2+1eya0eOMWCK5RSXfAbiAgHTTkwswdGQ3VxnO0EX/cDMq+ld7gwxobgY5+cIBn0Xj8ZBwnrPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jF8PKxXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA5EC4CEE2;
	Tue, 15 Apr 2025 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744678219;
	bh=fkIT4XOhmgQ9Dgwghj4eYY0BwPt0ZkTj4KhWD2vfeM4=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=jF8PKxXTj/N1UV0q80okyrWrgOjARI0AeiQqrGWHe8a1efJ2U8u8oDRund6nyswIf
	 FiZqBYIzxNPULTV6+3dfQqLqlPJBLwAXG8q+oiXyWLach1PkSSIStRLD770BPj873k
	 ulnUYLbvRhACyOXIIkXo0ZO3uhIL6D6TSxa5jIbA=
Date: Mon, 14 Apr 2025 17:50:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, corbet@lwn.net, shuah@kernel.org,
 david@redhat.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 ryan.roberts@arm.com, willy@infradead.org, peterx@redhat.com,
 ioworker0@gmail.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 dev.jain@arm.com, mhocko@suse.com, rientjes@google.com, hannes@cmpxchg.org,
 zokeefe@google.com, surenb@google.com, jglisse@google.com, cl@gentwo.org,
 jack@suse.cz, dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de,
 catalin.marinas@arm.com, anshuman.khandual@arm.com, raquini@redhat.com,
 aarcange@redhat.com, kirill.shutemov@linux.intel.com,
 yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com,
 vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v3 0/4] mm: introduce THP deferred setting
Message-Id: <20250414175017.872f9cf6d475674b28922a92@linux-foundation.org>
In-Reply-To: <20250414173735.b6df2f87c2e8dea610efa901@linux-foundation.org>
References: <20250414222456.43212-1-npache@redhat.com>
	<20250414173735.b6df2f87c2e8dea610efa901@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 17:37:35 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> This will need updating to latest kernels, please.

There I go, applying patchsets in reverse time order again.

"[PATCH v3 07/12] khugepaged: add mTHP support" has one reject against
current mainline, and two against current mm.git.

