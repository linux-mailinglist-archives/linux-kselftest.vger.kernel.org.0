Return-Path: <linux-kselftest+bounces-6592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7649088B11A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 21:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5703CBA82DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67E487B3;
	Mon, 25 Mar 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a9mXK77w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE90487AE;
	Mon, 25 Mar 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397068; cv=none; b=aLFENKEhPFGChM/q6MEub9Htbn16srfWSdXYGfCxVzYsk9a4Er/8FCcVAJSazmFmU8Z6fhP0Kexl5cnYH04+zIHLNbPZm6U0xAXEgSAKTfL8oU92K9UrEHyM3J7onLJ/hOW5GZ2pKEKrbGo9jwVkO2Wyyv7/MEEf5USQzLGRs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397068; c=relaxed/simple;
	bh=MVqf+1W2/O29sWIHzizwdV/AJ1AIoW9I4gu/EhMFulc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SwHrLFjcowG63pbTxrDgXU3ptw5uTr5RCfZk8sJoX9+DNHp55AzTJdps6zzpXrESn9EGMePeRZ+PIqv8vKw8Omynq/K1FDrFr8nC8Q0KiaBqohrOUjyHKcR3BNr0bq5NyNEQ1LohqaalCcGxsvLc6V0mqHk1oshNh3qrBQcJPBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a9mXK77w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC570C433F1;
	Mon, 25 Mar 2024 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711397067;
	bh=MVqf+1W2/O29sWIHzizwdV/AJ1AIoW9I4gu/EhMFulc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a9mXK77waDCkVLz4nDbjGRzZeFm29rSR7jtobIf3ZvNDfIRcIhhPbuCRNaJP/3P0W
	 gcTK7QJUkpnGxXLy5TOAUUQOEKnyDJyCTsH6VIu2p+QiEeAjXLLswIFVFV6I5Vs3F7
	 xXliFaODWHltJW/IvV8nIyTZ8paI73yzBlZ4Izl0=
Date: Mon, 25 Mar 2024 13:04:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Jann Horn <jannh@google.com>,
 linux-kselftest@vger.kernel.org, kernel-team@android.com, Lokesh Gidra
 <lokeshgidra@google.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-mm@kvack.org, llvm@lists.linux.dev, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3] selftests/mm: Fix ARM related issue with fork after
 pthread_create
Message-Id: <20240325130426.fba5287fcc437475123e76cc@linux-foundation.org>
In-Reply-To: <20240325194100.775052-1-edliaw@google.com>
References: <20240325194100.775052-1-edliaw@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 19:40:52 +0000 Edward Liaw <edliaw@google.com> wrote:

> Following issue was observed while running the uffd-unit-tests selftest
> on ARM devices. On x86_64 no issues were detected:
> 
> pthread_create followed by fork caused deadlock in certain cases
> wherein fork required some work to be completed by the created thread.
> Used synchronization to ensure that created thread's start function has
> started before invoking fork.

hm, you cc'ed the whole world apart from peterx.  Fixed.

> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> [edliaw: Refactored to use atomic_bool]
> Signed-off-by: Edward Liaw <edliaw@google.com>

I'll add cc:stable.  For which a Fixes: is desirable.  I used
760aee0b71e3 ("selftests/mm: add tests for RO pinning vs fork()"),
please check that.


