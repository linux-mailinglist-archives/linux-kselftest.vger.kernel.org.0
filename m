Return-Path: <linux-kselftest+bounces-40786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8E1B43FB1
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 16:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8E3483D9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD3D3009C3;
	Thu,  4 Sep 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UJBNJPgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF52FE079;
	Thu,  4 Sep 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997669; cv=none; b=ZyZ3WozAKnsC5VSfDWXIIFlDwfsOM2DRXMRS92uK471pVy7ic2DlI07Nv0WFC/N+gmwSXnvts7Vpm/alhvtoEXrxJ8Adyn/tjRd6apxJQ/CszV6t6XdwzdpM4s2kCsjoUUdAp1hRqdtgH/tSgI824uV6ma0elZNNklcpW5//JXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997669; c=relaxed/simple;
	bh=U5GevkF+cOyj1KYlkQ98Uiw69qbSwaHKdRRBPX8wLjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKdaksuYpUkDOSzFmhWGi7ak51Bs8qGjXxvmtpFn3qL3m+TFBrysgy+8A8nQfiPLNTv7MrpPxjG43fkiNU2UIjJ+y1TegDGOSbu/XN+q5EXOdukKOFuoceEG8GcJW486GvfIcaivafLUY4nsiWrmC0Bd5E+6Y5vKm3m+xHNcqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UJBNJPgN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+KGTa++fE1o/QSkIN9FVC/7XXIZU3mX08lTkxBMB+YM=; b=UJBNJPgN40zbt/sWSTQtnZUSl3
	0id5qS5iGWYZhXg8cY5MtpIJybKvmST5YhghrA+ScUH82tRDAmGofjWFaBWz+Ulvp9z4y7+k8ctDx
	87oEBZ3IynLjJkFLZVR0Qujs1YWDCuzZ2WAOh8Oyert3cbfdVoaJIBDtjabdnBIJzlBI/QRTs8pDh
	kP0Z4DOCZUIiuEv5JZJZkf/mzdVDVxOIPTA2ktBQVWd/+aaNr0d8hAFQ35NFo5J76tfxCIf8GgF+x
	gEqmgwlwNAgPja9PjtDSJtG3PXteqF2cjRhMug4VvJ1OXhIjnwc9Wk7Wd3tpjbq7awbAoYDnq6pLm
	ObbMA+Mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuBLw-00000003DEe-31wV;
	Thu, 04 Sep 2025 14:54:20 +0000
Date: Thu, 4 Sep 2025 15:54:20 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Sargun Dhillon <sargun@sargun.me>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] seccomp: Add SECCOMP_CLONE_FILTER operation
Message-ID: <20250904145420.GP39973@ZenIV>
References: <20250903203805.1335307-1-tom.hromatka@oracle.com>
 <CAADnVQLve3KgrqNqSqVrmL-wz6Jj1QUdjAcE5P26Z4wvh9e4HA@mail.gmail.com>
 <42cf76db-6cda-4606-9128-6f433da57d48@oracle.com>
 <CAADnVQJSgcAjEnU-A9bF6-9MQRFvbHqRsCCY7a0Y6bhVGtcGpA@mail.gmail.com>
 <21b618d5-7f6c-4b06-81be-eea6cbac5ba6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21b618d5-7f6c-4b06-81be-eea6cbac5ba6@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 04, 2025 at 08:26:30AM -0600, Tom Hromatka wrote:

> This snippet addresses the double irq issue.  I also added a
> check to make sure that task != current.  (A user shouldn't
> do that but who knows what they'll actually do.)
> 
>         if (task == current) {
>                 put_task_struct(task);
>                 return -EINVAL;
>         }
> 
>         spin_lock_irq(&current->sighand->siglock);
>         spin_lock(&task->sighand->siglock);

What do you expect to happen if two tasks do that to each other
at the same time?  Or, for that matter, if task has been spawned
by current with CLONE_VM | CLONE_SIGHAND?

