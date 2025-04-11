Return-Path: <linux-kselftest+bounces-30628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EEDA868DC
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Apr 2025 00:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8AA7ADA66
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 22:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D929898A;
	Fri, 11 Apr 2025 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qR61Q5/H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E74270ED8;
	Fri, 11 Apr 2025 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744410538; cv=none; b=TG/uG+52dxjQejGUm1HgoP3YDm+vwL5iICNAocvaA4Hd7+6fZyRdQMUhlRCgpbYGGAXYKm/brWJxioq4fSlFUawoJp4MBz3+aesB8FTkl5N3+xMa3iCr7uqDBONc2VpOXElkxoW+8hPUcq75M4A4nZwpZNO7qeqWGqK55WDsIUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744410538; c=relaxed/simple;
	bh=q0dosBq62p8nJI13NCPBgpG7xr4NCIfSVpSNWnjWU1k=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XCu1zB2GGNNa4W4gEjdzdrulpT2tkinOczAFVKU2BXCRrhIhmfjRGxbmmbTtMol9+QJ53ROOpwgi3ow+jmim7O6gjTa/J+6kYO7wZaz6I7wGSzkc8lwOqHduTEYUQoPOEV1RIHLKeLHk4fKfoL8Uk1QNH6vMCJMOl+KPCd+8IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qR61Q5/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0CAC4CEE2;
	Fri, 11 Apr 2025 22:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744410537;
	bh=q0dosBq62p8nJI13NCPBgpG7xr4NCIfSVpSNWnjWU1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qR61Q5/HTr1CGOIXBKrDgK0weL86YiOWk9RAqh9a9n0ZIQiTubhlELGmLwxgtXg9X
	 5HY+GuiUSbm3fqv7YTa9aYrBaLihP9XHN44/GMmG0sXeqOfMzaAH4YChPvI2se3hot
	 +c/tdqFnRk/IPbetbqMuvMwdW9IpNzJuUgJcbgbs=
Date: Fri, 11 Apr 2025 15:28:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <llong@redhat.com>
Cc: Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Muchun
 Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-Id: <20250411152856.41a12ac2b3eb1005a86168e6@linux-foundation.org>
In-Reply-To: <6d81d576-7e94-4523-af9a-d43298ea64ba@redhat.com>
References: <20250407014159.1291785-1-longman@redhat.com>
	<20250407014159.1291785-2-longman@redhat.com>
	<awgbdn6gwnj4kfaezsorvopgsdyoty3yahdeanqvoxstz2w2ke@xc3sv43elkz5>
	<6d81d576-7e94-4523-af9a-d43298ea64ba@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 17:08:33 -0400 Waiman Long <llong@redhat.com> wrote:

> > - * A/B/F  memory.current  = 0
> > + * A/B/C  memory.current ~= 29M, memory.events:low > 0
> > + * A/B/D  memory.current ~= 21M, memory.events:low > 0
> > + * A/B/E  memory.current ~= 0,   memory.events:low not specified (==0 w/out memory_recursiveprot)
> > + * A/B/F  memory.current  = 0,   memory.events:low == 0
> >    * (for origin of the numbers, see model in memcg_protection.m.)
> 
> Sorry for the late reply. I think it is a good idea to update the header 
> as well. This function is actually used by both test_memcg_low and 
> test_memcg.min. So I will use low/min instead.

It appears that quite a few updates are expected for this series,
so I'll drop v4 from mm.git.

