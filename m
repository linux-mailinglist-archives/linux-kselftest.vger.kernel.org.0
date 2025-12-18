Return-Path: <linux-kselftest+bounces-47684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6AFCCAC40
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 09:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B81302FA25
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2B2E7F32;
	Thu, 18 Dec 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScuoED96"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7CE2E6CC0;
	Thu, 18 Dec 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045051; cv=none; b=YV6lR8u0Lkbk48i9BXJhZXmAYfaC5qiYkvRhUZcMA9NqOEYBDht2a4vFQjaDaildmT5qdD+rjLn6ubgYelkYVTdzo5n+N1GKiOJ6g0iWmYiXlVq7hrhBhh5GxDEwJzd3pQFb7haTWcQ7zMgTAC3e+N7XKmNZwqGkK045ViuNtro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045051; c=relaxed/simple;
	bh=P5j+XO6ZjaENjKuewLksE3ekOUwMU7DjJUpX/8fUNP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUkF870Ft5xFq5Zyv9JXfX8zg2K6vAkcRdw2+GUPUlHvaqUl9Mc0c0Jz/9GA/Wz3nAPZIy63Dh6/zoC0RDrrvmxuYA0NtBLk677S4SUsukwt82TcMFxO0HcI6iAKKEmIN5U4PwscEEJwNb423467qZf3REdqgvUI2RRyArcdIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScuoED96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8893C4CEFB;
	Thu, 18 Dec 2025 08:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766045051;
	bh=P5j+XO6ZjaENjKuewLksE3ekOUwMU7DjJUpX/8fUNP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ScuoED96KlGLH+e9ca2TdAAkZ2KycpUFFJ/O38GUWklvk6tnVbCBdGx8S2Vb30hhv
	 Zf9b8xtlWa0Rk+w5l6h3GAyJCNQlyJHG6e5Hh7YTfJhaz6roIEfXA7RCjrsaKMWGsT
	 UCMdVRE6a0PI/h2JNy5R7aKyaIA5P6rbX6uKE5He4A7pthdfD9KnQN8TCc3vSp3X/7
	 WQfxRQJVdoGC/8gncvRhLfvqHNvRY/fXo+sYIhjwUm/HPle+gkgh+oSYbZac5VaLnW
	 H9I7sXYLItuHtAEFrLIf0lPR68ACfIpzjKGyFXOcbKq/O5yBU7TTkKlOtNvzjq4NRk
	 fSKEpO/OYzA8Q==
Message-ID: <0d4e08d3-db9e-4b0e-8229-9e7ac1b58708@kernel.org>
Date: Thu, 18 Dec 2025 09:04:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] selftests/mm: pass down full CC and CFLAGS to
 check_config.sh
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Mark Brown
 <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-3-kevin.brodsky@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251216142633.2401447-3-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/16/25 15:26, Kevin Brodsky wrote:
> check_config.sh checks that liburing is available by running the
> compiler provided as its first argument. This makes two assumptions:
> 
> 1. CC consists of only one word
> 2. No extra flag is required
> 
> Unfortunately, there are many situations where these assumptions
> don't hold. For instance:
> 
> - When using Clang, CC consists of multiple words
> - When cross-compiling, extra flags may be required to allow the
>    compiler to find headers
> 
> Remove these assumptions by passing down CC and CFLAGS as-is from
> the Makefile, so that the same command line is used as when actually
> building the tests.
> 
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---

Looks reasonable to me and I hope we find no surpirses :)

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

