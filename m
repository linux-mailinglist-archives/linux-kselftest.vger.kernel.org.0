Return-Path: <linux-kselftest+bounces-34191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E1CACBE6B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 04:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A57170D83
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A31149C51;
	Tue,  3 Jun 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="j//vDRUu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65529AD23;
	Tue,  3 Jun 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916737; cv=none; b=kXXVXXPCb5vQPqEizu6uLaJNIfnur03a1kv2J7IXUzdQTDKNdXr1BCCuUb/tFaIJon5CXehD99vP6L/lvBGGGiqa7xVKo7ATaVyRiGozi+Vlbnn4zQa2dW5/BJa6oPLHybwXsgG8tN6CJpfSlyWiigx9ztLiBsIr6iUEhkWYcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916737; c=relaxed/simple;
	bh=iSnNBGbsqCxVEZgDWP/TPN2p1e/vwAekYOJXt2gIxzo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mNQmMvzf0Docqc8AwNOKTfWM39eIipLwiAPMOPvO9D4Wi3S8CKT4IQRxYlAvH0peK4bsJto/YEs6fJUVGSmemlGC1+Ti+ermO9QqXjJJ2sx8DtpBul0xfSrJ7vrg2+LGt8OcYB2b+HJmqAYff0qfgvpifu+pTZREmusmuf540qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=j//vDRUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA438C4CEF0;
	Tue,  3 Jun 2025 02:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1748916736;
	bh=iSnNBGbsqCxVEZgDWP/TPN2p1e/vwAekYOJXt2gIxzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j//vDRUuMhEfxOx/h4IuIYPd0uqddYAJvS7lWqPYH9eopkxR8qbZYuKCi3/Oykobu
	 LljW5ZJGknEkKtHyZW29tHF2z1EwCIbZ58Qht/kCOMaKO31HKHs7oQylOpZsNkaw78
	 X5Ua/IqKPtqQMzfvyq9UfcDs4NqRZoAg+jX+2PVk=
Date: Mon, 2 Jun 2025 19:12:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] selftests/mm/run_vmtests.sh: skip hugevm tests
 if write_to_hugetlbfs is missing
Message-Id: <20250602191216.7173b77e4f9ab5f659d1a448@linux-foundation.org>
In-Reply-To: <20250602232233.224099-1-khaledelnaggarlinux@gmail.com>
References: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
	<20250602232233.224099-1-khaledelnaggarlinux@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Jun 2025 02:22:32 +0300 Khaled Elnaggar <khaledelnaggarlinux@gmail.com> wrote:

> The hugevm tests 'charge_reserved_hugetlb.sh' and 'hugetlb_reparenting_test.sh'
> depend on the 'write_to_hugetlbfs' binary to simulate writes to hugetlbfs
> while checking reservations asynchronously in the background.
> 
> When this binary is missing (e.g., excluded from the build), these tests hang
> for up to 180 seconds. During this time, run_vmtests.sh is eventually killed
> due to timeout, aborting all subsequent tests.
> 
> This patch skips these tests if the binary is not found, preventing delays
> and ensuring that the test suite runs to completion.

OK, but why is write_to_hugetlbfs missing?  If we're in a situation
where we _could_ run it then we _should_ run it!  The user wants to
test stuff so we should test as much as we can.

So I'm thinking that it would be preferable to make sure the dang thing
is there?


