Return-Path: <linux-kselftest+bounces-11716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBB9046E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 00:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0C31F246E0
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5230D1553A1;
	Tue, 11 Jun 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0jIxQgOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06D15535D;
	Tue, 11 Jun 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144600; cv=none; b=V7eiNzV0tGfHWqx+UbMvhrNHgWd9jD7HNcWrBr+mdFeX8jiglh4byi8wouNXbbacqyHT8zsVFBRsFwlkJBUL+uyPBAUvk9di/wp30oPklfivVQFigU8W9TpwjXlreHjXHZH8KV3sbO4b5q/1Tk01jrHs3bRETty/JiIcAWXN2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144600; c=relaxed/simple;
	bh=N7J/BKFpAmEyLroeB6EgYBai+EdxjrGGyxlJYhRnzzo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=exvmf2LqlAuCy5VY3NOp1e3iogLG2Gij7JyZHPeDdRXGAxmF/HNMscgJEZpagP3OJZ4Ijm5W6Mz0P3Z1bPTUGTLpTxzTp4wMdGeuEm4+1tQS9KGo3rFA5M75c8Lf2MShtycLbUPORJZ3EzQFu2Q6FB6eRSJZeRIWZkqoIO2HeZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0jIxQgOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DE5C2BD10;
	Tue, 11 Jun 2024 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718144599;
	bh=N7J/BKFpAmEyLroeB6EgYBai+EdxjrGGyxlJYhRnzzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0jIxQgOmjhTJF9j2Le1iYYfgjpUM9ZW5eXdch5pbaNr8a+mL+nP0dbaKMlVFofRGy
	 2DJZVQUoAXGPSGadWc108A+G+L0E+Sts9WHlQ5O7MdIoYO6SbbboHCkZA0yysMeRks
	 leaUZ3XjBh0x7S0wZXH7YMkk2GC9HlQjqlcn561c=
Date: Tue, 11 Jun 2024 15:23:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>, Ryan Roberts <ryan.roberts@arm.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: mm: Make map_fixed_noreplace test names
 stable
Message-Id: <20240611152317.8e72edb3a545a685a2a0b395@linux-foundation.org>
In-Reply-To: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
References: <20240605-kselftest-mm-fixed-noreplace-v1-1-a235db8b9be9@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 23:36:12 +0100 Mark Brown <broonie@kernel.org> wrote:

> KTAP parsers interpret the output of ksft_test_result_*() as being the
> name of the test.  The map_fixed_noreplace test uses a dynamically
> allocated base address for the mmap()s that it tests and currently
> includes this in the test names that it logs so the test names that are
> logged are not stable between runs.  It also uses multiples of PAGE_SIZE
> which mean that runs for kernels with different PAGE_SIZE configurations
> can't be directly compared.  Both these factors cause issues for CI
> systems when interpreting and displaying results.
> 
> Fix this by replacing the current test names with fixed strings
> describing the intent of the mappings that are logged, the existing
> messages with the actual addresses and sizes are retained as diagnostic
> prints to aid in debugging.

This sounds fairly annoying and I'm inclined to backport the fix into
-stable kernels(?).


