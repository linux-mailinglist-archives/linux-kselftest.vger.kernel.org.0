Return-Path: <linux-kselftest+bounces-43142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14106BDB6A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 23:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECAD24F30B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9833F2DE202;
	Tue, 14 Oct 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zn8vuI9M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBE270553;
	Tue, 14 Oct 2025 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477401; cv=none; b=BjIeUphUU0fQ8+A6nYz8Im5Vsk+D3lmeEF5AvVjTlBEQcprD5cGj+G5SUEmaupPBcSI1Ed9QukxSKG3g+lEJ0TbMdBW2Sze+9M9+DPDFEGTZgPtLCNDKgGPCqRq3fv4HOLf/TjuzHL/9S8S4UlhO5jMDRjCGmVBTIifefYBRpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477401; c=relaxed/simple;
	bh=sz0RIab+uJDmAtx+yofP3RZAaWLPnwR8PIrrUTZ0djo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IO8zV+lTTidzW/dSnnvJ7GSILytkFPOxnW0ZUk1cTFc1yZqgZuBZ8/wuKeBQh46uEd6rkVppMLqG3Dn/ZBCFZO9Fh0kDohpcPU+WVzzr5BmztsFtvj0e1H98ugCdeatXBX+rvwm2bTikaKh6sxw3DhcN3UEYoT7wI5mzCEyKE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zn8vuI9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBDEC4CEE7;
	Tue, 14 Oct 2025 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760477400;
	bh=sz0RIab+uJDmAtx+yofP3RZAaWLPnwR8PIrrUTZ0djo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zn8vuI9MGoprYrCJqaLNdOcaMkWNA39uHSdnWX7pIlJsyEOgxQ9Jbu/CMR/HdS8QJ
	 v6T2xsObYK/nuDBNmbUCj6PzyKt5Oye0QVOqWaU+eEe7jPALPSF0VeeEzVsPFhD8Gm
	 JLyEF4e5x0eoYTFiLL69Ldcx8dpcDCZf+xFZeKSo=
Date: Tue, 14 Oct 2025 14:29:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Itamar-Dalal <dalalitamar@gmail.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shuah@kernel.org
Subject: Re: [PATCH] Add a new test 'migrate.cow_after_fork' that verifies
 correct RMAP handling of Copy-On-Write pages after fork(). Before a write,
 parent and child share the same PFN; after a write, the =?UTF-8?B?Y2hp?=
 =?UTF-8?B?bGTigJlz?= PFN differs, confirming proper COW duplication.
Message-Id: <20251014142957.4253f2fc62e9e49bfc4433ab@linux-foundation.org>
In-Reply-To: <20251014194944.20341-1-dalalitamar@gmail.com>
References: <20251014194944.20341-1-dalalitamar@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 22:49:44 +0300 Itamar-Dalal <dalalitamar@gmail.com> wrote:

> Subject: [PATCH] Add a new test 'migrate.cow_after_fork' that verifies correct RMAP handling of Copy-On-Write pages after fork(). Before a write, parent and child share the same PFN; after a write, the child’s PFN differs, confirming proper COW duplication.
> Date: Tue, 14 Oct 2025 22:49:44 +0300
> X-Mailer: git-send-email 2.34.1
> 
> Signed-off-by: Itamar-Dalal <dalalitamar@gmail.com>
> ---
>  tools/testing/selftests/mm/rmap.c | 45 ++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)

OK, somehow your changelog was pasted into the email Subject, so please
resend.

Please prefix the Subject: with something which tells readers what part
of the kernel is affected. eg,

:
: Subject: selfstests/mm/rmap: verify correct RMAP handling of COW pages after fork()
:

Then enter the details in the changelog body, eg:

:
: Before a write, parent and child share the same PFN. After a write, the
: child’s PFN differs.  Check this to confirm proper COW duplication.
:

