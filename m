Return-Path: <linux-kselftest+bounces-2668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 869E1825879
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 17:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA021F2348E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45BA28E15;
	Fri,  5 Jan 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lg62Go09"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0031725;
	Fri,  5 Jan 2024 16:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B432C433C8;
	Fri,  5 Jan 2024 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704472959;
	bh=suBhTmjG+VJFnVqEaF1rhD3QMNGDempWa1saCFE24LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lg62Go09lt5PN6BwUrRzJfTp2ZKmCZv99fkqpYccFXk8KzAuH82zBMdPnpVc7+8gv
	 hXS7Ki2pnq5+P6Jgpxmn1UBe7EiLF3LRDSVkq1FSD5uFkG2xpHlP5RVC31UzrgrAC2
	 ZwbfvM03IkQRo2YKEdSnmWvBPtVJnnlG3RsShiJk=
Date: Fri, 5 Jan 2024 08:42:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: riel@surriel.com, linux-mm@kvack.org, vegard.nossum@oracle.com,
 rppt@kernel.org, songmuchun@bytedance.com, shy828301@gmail.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] selftest/mm/hugetlb: SIGBUS on stolen page
Message-Id: <20240105084238.306269c3f3a63cb0fd130baa@linux-foundation.org>
In-Reply-To: <20240105155419.1939484-1-leitao@debian.org>
References: <20240105155419.1939484-1-leitao@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 07:54:18 -0800 Breno Leitao <leitao@debian.org> wrote:

> This test case triggers a race between madvise(MADV_DONTNEED) and
> mmap() in a single huge page, which got stolen (while reserved).
> 
> Once the only page is stolen, the memory previously mmaped (and
> madvise(MADV_DONTNEED) got a SIGBUS when accessed.
> 
> I am not adding this test to the un_vmtests.sh scripts, since this test
> fails at upstream.

Oh.  Is a fix for this in the pipeline?  If so, I assume that once the
fix is merged, we enable this test in run_vmtests?

