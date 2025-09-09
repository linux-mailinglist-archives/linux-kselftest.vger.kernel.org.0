Return-Path: <linux-kselftest+bounces-41009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712A7B49EEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 04:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7523BFB79
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09D227599;
	Tue,  9 Sep 2025 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bQfHnx6f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2E1F4C8C;
	Tue,  9 Sep 2025 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383370; cv=none; b=SeXvvaZ+7KAXqg4AXB718ftjpMVpzSWe0wjo9XLsi174wDptrH1iYsc82n/+VcFWUheefH2cdQkhYD2jd5CkF6LaY7ntRjTFtRjulqvJw/xGF8rJdEK+IMeENF2dbZHdZxcA1KRVmn7joGUOrjXaBern0kerpko9RYrXPkYEhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383370; c=relaxed/simple;
	bh=c5J+iIMRm2kgguzDoOwH0NIHbsCxHv+R42DDyiYg0Pw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YhIWvCrNJWgDtQZ0m1YydL7mLi15GQ2SPETDbjG4OZpznbY8x5bN9kpLy3bWj5Vyyq699OhftgNarBrtNUGlrAUWNvjBfVY4T9zHkYqXzfH2BO9pb+mXVTYOWzsJQwZ9dUU0pBPfEoJ5al9I0rPYyvyTaq4zqLqtbiwB6+yuypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bQfHnx6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66513C4CEF1;
	Tue,  9 Sep 2025 02:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757383369;
	bh=c5J+iIMRm2kgguzDoOwH0NIHbsCxHv+R42DDyiYg0Pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bQfHnx6f4Rd++MMzXx4qgIhsJbsEpEKKQX2LoB8hcv1eLKSTsJqoO+P48jWA6fUbX
	 SWVr0MltkJjI4H5jIHt+/3pA6qiaZIF3x2v6qK45wR7zPmJXe+TmYgIRT7CEz0Y0Va
	 pg7E8qshmdjwufRFKKCZ/NnlQVRVbE7TImnvZdxQ=
Date: Mon, 8 Sep 2025 19:02:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dev Jain <dev.jain@arm.com>
Cc: david@redhat.com, shuah@kernel.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, npache@redhat.com,
 ryan.roberts@arm.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/mm: uffd-stress fixes
Message-Id: <20250908190248.d2d6de27715fefc4e89afb10@linux-foundation.org>
In-Reply-To: <1634f29f-81a6-46f7-86d4-c9eac953d4f1@arm.com>
References: <20250826070705.53841-1-dev.jain@arm.com>
	<1634f29f-81a6-46f7-86d4-c9eac953d4f1@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 13:52:05 +0530 Dev Jain <dev.jain@arm.com> wrote:

> 
> On 26/08/25 12:37 pm, Dev Jain wrote:
> > This patchset ensures that the number of hugepages is correctly set in the
> > system so that the uffd-stress test does not fail due to the racy nature of
> > the test. Patch 1 corrects the hugepage constraint in the run_vmtests.sh
> > script, whereas patch 2 corrects the constraint in the test itself.
> >
> > Dev Jain (2):
> >    selftests/mm/uffd-stress: Make test operate on less hugetlb memory
> >    selftests/mm/uffd-stress: Stricten constraint on free hugepages before
> >      the test
> >
> >   tools/testing/selftests/mm/run_vmtests.sh | 2 +-
> >   tools/testing/selftests/mm/uffd-stress.c  | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Hi Andrew,
> 
> I wanted to make a v2 of this series to replace 10 with min(32, nrcpus - 1)

That sounds line a one-line change?  Send a one-line change ;)

> (see computation of nr_parallel in uffd-stress.c) but I see that it has
> been pulled into mm-new, and on top of that, the following patch makes
> things complicated to just revert my commits in mm-new and make v2 on top of that -
> https://lore.kernel.org/all/20250830033424.8C44FC4CEF0@smtp.kernel.org/
> 
> So shall I just send a new separate patch based off mm-new?

Or just resend the whole series based on mainline or something?

