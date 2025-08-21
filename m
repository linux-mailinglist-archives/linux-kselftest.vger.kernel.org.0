Return-Path: <linux-kselftest+bounces-39610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1975B308F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 00:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E26AE72C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 22:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013E2EA731;
	Thu, 21 Aug 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h8Pefxhw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284F7262F;
	Thu, 21 Aug 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814391; cv=none; b=f8dDEE4K348gHXS4Mr2zk/J2SLqKCDT6AVt0lE6gazfrMiI0g4VqF/O/2hAVXx/whI5Qf3w7JbGKTypf3Ciu1ZftBpKPSJMYH0zKz7s5RwNpa2Se01u/GziBtKX/vYaMrLAZMPeDqCvgPhJUO25rXaQW6ukAgcHBkFuSZLISAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814391; c=relaxed/simple;
	bh=OZVsV1pjh5cFcCuKO5I5KInQUt83XkwpyN8e5LAvhKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=okzgF/g/0Nplf/BKBk01yJA6C5f+gl4dzaMh7RskUHkqClzOQnakwlqdbbCuqlub6rpmkDUfUBUmg4YFSm4nFR2tQVUuYQ7tw+OAGSuVmaWIZbcRmyVvHk39UDtjbb3zov6TJgD/3DNitJihOaDI4XXPDC4DvOUgxx1DNXH8Nj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h8Pefxhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA09C4CEEB;
	Thu, 21 Aug 2025 22:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755814390;
	bh=OZVsV1pjh5cFcCuKO5I5KInQUt83XkwpyN8e5LAvhKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h8PefxhwzUDkEVO/G7Udqk5ywBFaWt9v80jL/AxtOQi2x3HrajmGLKlp/Jzy3IK33
	 jRNdGw8nWXvygM/jJFn4eftYLX1BV7wHKc/GKOYZJypKp3M12AanRlfcEb8RG6EBDB
	 3AU+Ot/yjoAk7wmY5xRhet+2x2RivUMY3LZGC/Qg=
Date: Thu, 21 Aug 2025 15:13:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, kernel@collabora.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Vlastimil
 Babka <vbabka@suse.cz>, Albert Ou <aou@eecs.berkeley.edu>, Zi Yan
 <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>, Suren Baghdasaryan
 <surenb@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, Mike Rapoport <rppt@kernel.org>,
 Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Palmer
 Dabbelt <palmer@dabbelt.com>, Ryan Roberts <ryan.roberts@arm.com>, Leon
 Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
 linux-kselftest@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-mm@kvack.org, Nico Pache <npache@redhat.com>, John Hubbard
 <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 4/8] selftests/mm: Add -Wunused family of flags
Message-Id: <20250821151308.915362b14e82f5626f659481@linux-foundation.org>
In-Reply-To: <4abd97fe-412d-4e3e-9efc-cf3092d66e57@collabora.com>
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
	<20250731160132.1795351-5-usama.anjum@collabora.com>
	<57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
	<8e9d7c59-46b4-4e1b-8a55-1898302f5080@collabora.com>
	<88ea592c-c6ff-4a19-a366-eadeca66b039@arm.com>
	<4abd97fe-412d-4e3e-9efc-cf3092d66e57@collabora.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 17:31:21 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> > My
> > feeling is that unused parameters are expected to be allowed in the
> > kernel and it isn't helpful to go against that expectation in just a
> > small subset of kselftests.
> I thought kernel must be giving error for unused parameters as well (from
> my memory). But just checked and it doesn't seem like it. I'm okay with
> dropping -Wunused-parameters.
> 
> We need to drop patch 6/7 and in Patch 4 should have only:
> 
> -CFLAGS += -Wunused  -Wunused-parameter -Wunused-function -Wunused-label -Wunused-variable -Wunused-value
> +CFLAGS += -Wunused
> 
> @Andrew, Should I resend the entire series or would you can make the change?

I think a new series would be clearer, please.  It's unclear (to me)
whether Kevin's various comments have all been addressed.

