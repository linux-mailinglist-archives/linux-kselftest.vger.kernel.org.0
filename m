Return-Path: <linux-kselftest+bounces-16335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F795FA77
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E4D1F222BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C20199225;
	Mon, 26 Aug 2024 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/mhEIWq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6A74C1B;
	Mon, 26 Aug 2024 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724703389; cv=none; b=i+ti0DlqHblQouXJuzo+od3F/QJxSXEgDm/2pmGJafEQfBhRD0QIudOoDm5h66Do84i5eUZ+vjAJmOq25HHi3eX7bCVA6JksJtHeb1Ut5QMQjRfGlf4J7KFhD6K/0mw/EGJGGYkICjXc6IZwGjKsA+GkOBFW7tEXzmzTQdGmAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724703389; c=relaxed/simple;
	bh=+Q5TY5gb0wPsicqaWodqX2lp/Us/eVeWkOlgVsSN6NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gxo7ZUAVlxUnxmsz2EeJuzSYs3oezHBP1HXuwWovLm2jNkhXfSPEfHe0ksa310sjh5ECYBSOZRpMk4StXlh6m1eRHMiooP2jukP3Cu3Fkh9vXMruYU4DMz0mlUYJ0zTB9O0pzdV+c+5lETb2LbKODUkTBbDFjWmxK0GITnQXY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/mhEIWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA1DC8B7AA;
	Mon, 26 Aug 2024 20:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724703388;
	bh=+Q5TY5gb0wPsicqaWodqX2lp/Us/eVeWkOlgVsSN6NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O/mhEIWqyVsHCmnsNxPtmboyVGyiNnl+XGsrsU0zSK0eoFYDd2xGfvjm5D21LZarK
	 dT9hHFSQRs43ojzwjvTb7O5yO5KCNDt9BKjIU6EZEH/lvRlP4rV5Rs2/0NrErHt/KO
	 NX5tgOmrDI8wYMSnoCuMCdEU7rG7lK8IMdJ10fMlu0gq2AqTD9rPgGbjG098gxzdfg
	 YlvSEMYD1xsx7RZApKIBQW4S4vASPtQutPd+4N3HeRqK04l7JLgrDqnK0YqZS3UBX6
	 bwqk0pVY+p7XsvyXxiDwub8pV0Jkl4932MrD+1wpVnD29L3eO5kG2NwriLt37z2fxD
	 YyDPhhjVY09lg==
Date: Mon, 26 Aug 2024 10:16:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 0/2] cgroup/cpuset: Account for boot time isolated
 CPUs
Message-ID: <Zszim7DjSPdQn7Ie@slm.duckdns.org>
References: <20240820195536.202066-1-longman@redhat.com>
 <ce01caf5-e576-4614-b6b8-0206da1a7c49@redhat.com>
 <ZszSDG7GlvKQTydh@slm.duckdns.org>
 <102a1760-6440-4535-aaf4-d7c1aa6e97b3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102a1760-6440-4535-aaf4-d7c1aa6e97b3@redhat.com>

On Mon, Aug 26, 2024 at 03:41:23PM -0400, Waiman Long wrote:
> 
> On 8/26/24 15:05, Tejun Heo wrote:
> > Hello, Waiman.
> > 
> > On Mon, Aug 26, 2024 at 03:01:21PM -0400, Waiman Long wrote:
> > > Ping! Any comment on these patches?
> > cgroup side looks fine to me. Ping isol people?
> 
> This patchset is specific to cpuset code and doesn't touch any isolation
> code at all. My other isolation related patch series [1] does have a
> dependency on this one to work correctly.
> 
> [1] https://lore.kernel.org/lkml/20240821142312.236970-1-longman@redhat.com/

Oh, I was confused of the two patchsets. I thought the second one was the
replacement for this one. Will take another look.

Thanks.

-- 
tejun

