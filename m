Return-Path: <linux-kselftest+bounces-3615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73E83D232
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 02:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF4428FB1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3E1EC3;
	Fri, 26 Jan 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mmWYdPED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8F7465;
	Fri, 26 Jan 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233441; cv=none; b=Bx7yi4/MVB+cKnGLmxQAst4NXgVmQwqP57DLF1b11d9PqkV0/kmd/hmZXzzTaxTlxGhdL1MxIbVbAqRbkKhgZrpydr2NC4iQbNffTRg9wAuVKx5ACzOrjyhytDjXkyM+4OrjAtqkG28kzTjFEwRXCNGya7Dm8PwWNHuGlo8lpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233441; c=relaxed/simple;
	bh=wWiDiMeWoSlCCvhLdyjnd8NOVWU10SYkwMYuvm1Cvwo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gZwBlfco5Lq4arL1IeEqyN+I0DoqzlnhhoZt2T3KFw7dmyQ2kz1NNwRIoNXWIRAIP9P4TOkgSI7db0hxsqVR/HqJtgSUywe1r+CoK6tL+suL8gXNOrAkjdUfowcNkDt0CRjitI+owK8eokpuYGK4B2RcuREZ+ChkMa21d9o7Ywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mmWYdPED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C5C433F1;
	Fri, 26 Jan 2024 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706233441;
	bh=wWiDiMeWoSlCCvhLdyjnd8NOVWU10SYkwMYuvm1Cvwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmWYdPEDIXpbLZGTVzSt0GPSULdfPOK/mNSysWrmKiUtTJ1nu601UGe6phcaZjVJO
	 EkvZvMOcdEU+OvqVSKp0y9r74UhZ3NV5yoZKQTSP4yVV1xf0Dwis1BtKPLiy6TCErK
	 50XiBG7d11gOUz1XTopcBJSsnAbeHgGVY5FaTROk=
Date: Thu, 25 Jan 2024 17:43:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Audra Mitchell <audra@redhat.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, raquini@redhat.com, Adam Sindelar
 <adam@wowsignal.io>
Subject: Re: [PATCH] selftests/mm: Update va_high_addr_switch.sh to check
 CPU for la57 flag
Message-Id: <20240125174356.199f44f329e137f9a6437648@linux-foundation.org>
In-Reply-To: <ZbETFZX33L2ELujO@fedora>
References: <20240119205801.62769-1-audra@redhat.com>
	<20240121143153.5dcfe26dea53ba0e896dbf85@linux-foundation.org>
	<ZbETFZX33L2ELujO@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 08:39:33 -0500 Audra Mitchell <audra@redhat.com> wrote:

> > A more complete description of these "test failures" would be helpful
> > please.
> > 
> 
> Hey, sorry for the incomplete description. The test does a series of mmap
> calls including three using the MAP_FIXED flag and specifying an address that
> is 1<<47 or 1<<48. These addresses are only available if you are using level 5
> page tables, which requires both the CPU to have the capabiltiy (la57 flag)
> and the kernel to be configured. Currently the test only checks for the kernel
> configuration option, so this test can still report a false positive. Here are
> the three failing lines:
> 
> $ ./va_high_addr_switch | grep FAILED
> mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FAILED
> mmap(HIGH_ADDR, MAP_FIXED): 0xffffffffffffffff - FAILED
> mmap(ADDR_SWITCH_HINT, 2 * PAGE_SIZE, MAP_FIXED): 0xffffffffffffffff - FAILED
> 
> I thought (for about a second) refactoring the test so that these three mmap
> calls will only be run on systems with the level 5 page tables available, but
> the whole point of the test is to check the level 5 feature...
> 
> If you would like me to also update the description on the patch let me know
> and I'll update it and resubmit. Thanks!

I pasted the above into the changelog, thanks.

