Return-Path: <linux-kselftest+bounces-31101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788CA92DD2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EE43BB960
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99C221710;
	Thu, 17 Apr 2025 23:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O+EkSq1c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8829221568;
	Thu, 17 Apr 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931384; cv=none; b=REd1rNepViEIDGX80nGnsFRVg8B+92q9nsjIPAtplAqs2LTLf0k61SomXLYEqZ1CXYjzT9PD3qbupPHn4QeNAP4S8wUaHARlYZe2spsNKwHBTIdj36JEelxIvavcAf0UBRVXNknNVC5+fkDtIWj9iPJLyyljcjVWXQDIL+18uZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931384; c=relaxed/simple;
	bh=1wudyAEeo9ZxUBCPzH6bp44SfvfV/MxkFpdCzNjXyRM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GrBMvAbACi2y6qGb34yHDzk3B/xUMMpaGVHfgsBJv1MrMMj+SbjGaswIPRYh4hQ5sSn7Gp2olmiM9J/zYFJQGkaWe+/UIzzyGvQLH2an0RLVf36G+JcE1fn3gX1KGU/XpCBmBZWGyW+YGPoKxThVS0mLq6LfnAFqpJEHXEtZu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O+EkSq1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F4AC4CEE4;
	Thu, 17 Apr 2025 23:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744931383;
	bh=1wudyAEeo9ZxUBCPzH6bp44SfvfV/MxkFpdCzNjXyRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+EkSq1cerYI3SpW1BKN3OV+bECvq47aHuz2MTB9FCJJh3Zc0iyAcMhgnoQLf8GsG
	 rg0WsCP6Euyo8wqA/81nTZZxdd8h7TjePa48hqZpHBc+161kj6UfS+k1+YUp+ykIbs
	 fKpGjG1PHuo18A46Jib3VtwI4DaHai+6pSEKjDuI=
Date: Thu, 17 Apr 2025 16:09:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, david@redhat.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, shuah@kernel.org, ziy@nvidia.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
Subject: Re: [PATCH v4 3/4] khugepaged: add defer option to mTHP options
Message-Id: <20250417160941.5e6c8063c990e1acf0c0ef2e@linux-foundation.org>
In-Reply-To: <20250417001846.81480-4-npache@redhat.com>
References: <20250417001846.81480-1-npache@redhat.com>
	<20250417001846.81480-4-npache@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 18:18:45 -0600 Nico Pache <npache@redhat.com> wrote:

> Now that we have defer to globally disable THPs at fault time, lets add
> a defer setting to the mTHP options. This will allow khugepaged to
> operate at that order, while avoiding it at PF time.

khugepaged.c has changed somewhat in mm.git's mm-new branch.  Can you
pleae take a look?

