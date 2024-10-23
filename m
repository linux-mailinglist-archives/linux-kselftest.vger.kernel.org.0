Return-Path: <linux-kselftest+bounces-20432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF069ABABC
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 02:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BE1C20F76
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 00:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545821BC2A;
	Wed, 23 Oct 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PQFr+82T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EA1A270
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 00:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644794; cv=none; b=Ur1KMELfgU+Jd94v6iBqsHchUGSZhMxmut0JucYl99mmZxoF3YqYW2wQusruWx5118v150ZebuJUPDtw57LYO1ik+k2BYb6vjaYORdd1jaqq9zaYkq4gCxY/PmaM282C7zu/LkfNqfoKY8rCYZWCoJDMuZtyJNZMQBUu+9Sz5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644794; c=relaxed/simple;
	bh=lIxKrnVZi4OzdtnAM6X5raOD38x0R+vhcvjiqMDjT78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCACDs7H7tsBOm7MDd1mgT9SRNiaaET4+kz1BtMrPb4Ve5cUrFGTRSYZEr3UDphDMyDzo7nFih3oZA7bNemoQsHggPwL2wMY02a6q8csOpoVobMW7K2rS6bjBfj7ybLZtIRmtsdz5rzJdRkZhBRXxgCh6SeGTadoX+9NxV4Bk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PQFr+82T; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Oct 2024 17:53:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729644789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6kCNsEXTfjhm2VD7RcuSJFj1WDFRY4+e/zOdiNTxOWg=;
	b=PQFr+82TnUdLaIYZFFzshQFVmAmk1Yd7+0V/csbKw1Q5g5ouUoT7Egf2+eOTF9SVzA6x3K
	XlThe6JZGnxty58saIYF+G6jJ8wg1xPOeZdmiXyXDSIfO6cjO9eniEPWJTBAIqbRCz/E+W
	cQWGDsXIMg4UcpTrpNJLEGFUKjgsf2U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, 
	Shuah Khan <shuah@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Sang <oliver.sang@intel.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 2/4] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <fhy36lhgeedrdwoubuuxarownhji2k4avcherjnedtid35yael@jokjnyb6i66b>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 17, 2024 at 10:05:50PM GMT, Lorenzo Stoakes wrote:
> It is useful to be able to utilise the pidfd mechanism to reference the
> current thread or process (from a userland point of view - thread group
> leader from the kernel's point of view).
> 
> Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> 
> For convenience and to avoid confusion from userland's perspective we alias
> these:
> 
> * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
>   the user will want to use, as they would find it surprising if for
>   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
>   and that failed.
> 
> * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
>   have no concept of thread groups or what a thread group leader is, and
>   from userland's perspective and nomenclature this is what userland
>   considers to be a process.

Should users use PIDFD_SELF_PROCESS in process_madvise() for self
madvise() (once the support is added)?

> 
[...]
>  
> +static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
> +{
> +	bool is_thread = pidfd == PIDFD_SELF_THREAD;
> +	enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> +	struct pid *pid = *task_pid_ptr(current, type);
> +
> +	/* The caller expects an elevated reference count. */
> +	get_pid(pid);

Do you want this helper to work for scenarios where pid is used across
context? Otherwise can't we get rid of this get and later put for self?

> +	return pid;
> +}
> +

Overall looks good to me.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

