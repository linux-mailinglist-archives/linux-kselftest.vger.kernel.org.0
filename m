Return-Path: <linux-kselftest+bounces-11434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638A900CB5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF461C21021
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C050297;
	Fri,  7 Jun 2024 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VhcVZAw8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E5A20;
	Fri,  7 Jun 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790785; cv=none; b=SNwbfSYozow5tYLQKsXkWjLAR51HkQWWB0POE9uwCUROXYrnCGarOb7Ga0tWy+Mh2p9o8X0d2HJPO8RWIEoSzbAHVW+p6U0Gwq2Kb07cwS1JLAOYgo/7MM793CT+83S+TDRwF4ZX7lafFFRV2n97BHEJGa9rHDbHmWbaqiegW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790785; c=relaxed/simple;
	bh=l+MzTCrE+QhkM/SGOM47J9fZob9RAcpn4S4cOQ09WjM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r6rnUDoqmtTPPzwbcD74lbVajLONvJYxs2AJG8C6j6/mpOBE5AewH6FVzldx7As7+wLIWp38V2IbtcGSH2lOEVb8G/fzLfBoUeXzrPlIsZY9rsl1S0tN002iP/iKS6I556JZoCyAW9fQDtN0+4S+dfs8gZYQde6douwBJ6jC8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VhcVZAw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B90FC2BBFC;
	Fri,  7 Jun 2024 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717790784;
	bh=l+MzTCrE+QhkM/SGOM47J9fZob9RAcpn4S4cOQ09WjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VhcVZAw8YVqckma6gCRFJjjbTX4WSeR2cejP0qeOAq1uuvmWfFw8/5l5KclhfSMsJ
	 EkbGTDrcI3zncJ2iVGkYNY+qXP2ivFd8AzBxylock6mOdqS67HO6fJTyvXVOkua7c2
	 NpJnUfFzWxjngUgBuFHGQsj3pySQgstFqfxXlurk=
Date: Fri, 7 Jun 2024 13:06:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Ritesh
 Harjani <ritesh.list@gmail.com>, Mike Rapoport <rppt@kernel.org>, Muchun
 Song <songmuchun@bytedance.com>, David Hildenbrand <david@redhat.com>,
 p.raghav@samsung.com, usama.anjum@collabora.com
Subject: Re: [PATCH v4] selftest: mm: Test if hugepage does not get leaked
 during __bio_release_pages()
Message-Id: <20240607130623.76ba44371f8f406f5d1678b7@linux-foundation.org>
In-Reply-To: <20240607182000.6494-1-donettom@linux.ibm.com>
References: <20240607182000.6494-1-donettom@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 13:20:00 -0500 Donet Tom <donettom@linux.ibm.com> wrote:

> V4:
> - Added this test to run_vmtests.sh.

v4 also contains this change:

--- a/tools/testing/selftests/mm/hugetlb_dio.c~selftest-mm-test-if-hugepage-does-not-get-leaked-during-__bio_release_pages-v4
+++ a/tools/testing/selftests/mm/hugetlb_dio.c
@@ -40,7 +40,7 @@ void run_dio_using_hugetlb(unsigned int
 		ksft_exit_fail_msg("Unable to determine huge page size\n");
 
 	/* Open the file to DIO */
-	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT);
+	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
 	if (fd < 0)
 		ksft_exit_fail_perror("Error opening file\n");
 


