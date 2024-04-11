Return-Path: <linux-kselftest+bounces-7737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF68A2255
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 01:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CBB1F21C86
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D32481C0;
	Thu, 11 Apr 2024 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0YUw6krO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14E3FE54;
	Thu, 11 Apr 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878451; cv=none; b=HNp19bA3cVVqfP5qx6D+krSA8n/2B13i+Py22goqjPXO6+taE31+UtzIvymTznt+zBFZdyIby9dvnOg2BvSZMSfBNcQ1P6cOzgdipSa4zDsPoO864upkLlwgyIo11S/De5KwccxXq7kcvjIIcKxzwjLnYebl232sdt60VR/vDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878451; c=relaxed/simple;
	bh=fPg+U9aZpiI4UGkeN8+yCCn4g5+/FS3gaks5GuNPqsI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nefrmY4dNqZCQ9+DFra29uzIxZiDcVWea4LtwlISdhxGd1+QdBXc5qQb+xJtV2MfgPJSnsI9b7nyx8J9pcDJiDPeuWNY4AQcWnIm7JCS+HrpcMr5G3ZCLzDJIbXhewwq1AX/E/m4zInnBNit6HNeMxtRkI4bhHP3NX4UlU1P0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0YUw6krO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B724C072AA;
	Thu, 11 Apr 2024 23:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712878450;
	bh=fPg+U9aZpiI4UGkeN8+yCCn4g5+/FS3gaks5GuNPqsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0YUw6krOuT6SZxP9n4r3R5rl2hdNWCjy2HLJZ5JuNBa15CUzYnU7By+GcQOzZwRFE
	 trfMhj3erdcbHW3gNafLSTlBxf2jnNWAJzxdmW4yPQg8wDAkFHyTN1LIyv2xkQhk1d
	 GF2K9rElo7ry/kGDNheLRq+31AxIU+kXqTswbVbQ=
Date: Thu, 11 Apr 2024 16:34:09 -0700
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
Message-Id: <20240411163409.4f8969fa8a46b63d04a28f77@linux-foundation.org>
In-Reply-To: <20240411231954.62156-1-edliaw@google.com>
References: <20240411231954.62156-1-edliaw@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 23:19:49 +0000 Edward Liaw <edliaw@google.com> wrote:

> Android was seeing a compliation error because its C library does not
> define LINE_MAX.  This replaces the use of LINE_MAX / snprintf with
> asprintf, which will change the behavior to not truncate the test name
> if it is over 2048 chars long.

Thanks, I'll grab and shall send it Linuswards for 6.9-rcX.

I added

Fixes: 38c957f07038 ("selftests: kselftest_harness: generate test name once")


