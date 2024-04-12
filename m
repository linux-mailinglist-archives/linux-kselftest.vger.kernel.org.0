Return-Path: <linux-kselftest+bounces-7885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3568A38AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 00:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB711F237F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 22:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822F915099C;
	Fri, 12 Apr 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JZdIOl9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547438827;
	Fri, 12 Apr 2024 22:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712962501; cv=none; b=uTMQbzKgVFbL1JAKmoWh6NAyL2wOEcdwmrQ693AmVkb3GvBBPugqX27fhlbGHg8N9gXVhEGPZVCUozP18PAnCBQxOSCluaDeH8GYSLQvGdRwh1vfh/pkQDL8+VWBiat8rPy/kMD8gu5KHH08eH/xHZNdD07rMz6Xyh/O2Aa3d9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712962501; c=relaxed/simple;
	bh=jdaQw07Ypa2Z8SryCpTTYkyyR1tt7zOsabX117YNchA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aVPW9i8rszOGgP6ZkWe9L8Wsa4JlUQlaj793o4jHuUD56RjK6Y4BeohHdmIFjbudnSUGOgR6wfSaiIcewBxrTe81VP4cB1FTBJCqlLiCS6D708a01DJEawUtGoxSySgraIuOHQeUYpsGgSghT3mGXusLg+mhgZKxAiNS/qGN6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JZdIOl9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5A5C113CC;
	Fri, 12 Apr 2024 22:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712962500;
	bh=jdaQw07Ypa2Z8SryCpTTYkyyR1tt7zOsabX117YNchA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JZdIOl9hH+XhYBQBRru6BF94jGLNKTAmi/gWiNkIUWx10S6feG9V2KsiNfaNe5Jvh
	 9SCklgTQfe3yZPCvA5uvWyjrz1Ii5XCPFyVuA5wCoFqLuxW7UV2BQeFcBr4qnvmuPL
	 QlakJw7EOIdJIx5QXVpkMFYF6yJAdE1CILW1VKHY=
Date: Fri, 12 Apr 2024 15:54:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Andy
 Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah
 Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Peter Xu <peterx@redhat.com>, David
 Hildenbrand <david@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/harness: remove use of LINE_MAX
Message-Id: <20240412155459.918890839d9305aaba466391@linux-foundation.org>
In-Reply-To: <CAG4es9Wti4JACt9KzvEW4oSX0wZyBWC9NCLDW11NXYeeOzLM1w@mail.gmail.com>
References: <20240411231954.62156-1-edliaw@google.com>
	<20240411163409.4f8969fa8a46b63d04a28f77@linux-foundation.org>
	<CAG4es9Wti4JACt9KzvEW4oSX0wZyBWC9NCLDW11NXYeeOzLM1w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 12 Apr 2024 12:30:15 -0700 Edward Liaw <edliaw@google.com> wrote:

> On Thu, Apr 11, 2024 at 4:34 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Thanks, I'll grab and shall send it Linuswards for 6.9-rcX.
> >
> > I added
> >
> > Fixes: 38c957f07038 ("selftests: kselftest_harness: generate test name once")
> >
> 
> Thanks, I just realized I forgot to remove the <limits.h> includes.
> Should I send another patch for that or send a v2 of this one?

I fixed it up, thanks.

