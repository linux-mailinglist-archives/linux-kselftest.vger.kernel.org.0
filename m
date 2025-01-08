Return-Path: <linux-kselftest+bounces-24043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095B9A0526B
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 05:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE652167A06
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 04:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0E5198851;
	Wed,  8 Jan 2025 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lOHbqkuu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB079FE
	for <linux-kselftest@vger.kernel.org>; Wed,  8 Jan 2025 04:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312192; cv=none; b=LSAYLEI6pg9PmdxPgbzGOoYbBYNUzel+dQnE0q7CdOJr5MDK2UZKHDgsNcHzIDRVqF/Lh3lGaqhmwm0YpPkAJHIgWC4CNQKHCCXlMRBvne6XIEJp8G68Q1JAoE0lkCjkd6eQgR+7wZmRCcmgA756edwQoAwoCMFESQIuwPn8h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312192; c=relaxed/simple;
	bh=NGu6EmnLNJaRhak7jqhR5JYU9X+B4KMm8+roVR5/bs4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WDybWcix3wmWbS2jB7oW37/75/X4Sd7Ti5ZZrr4sVHx6D/buSSgGXdIWbi3Ty24CJdsfV8He/ywFXBfncHLLEMW4zql/vXUxqHXFL8k2/7C5pYKt/fsdKEcFUMlQmVubb/fkPNZrQHQ+whi4AOocNrfgTC5WMjhuNMI3j/7cHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lOHbqkuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2301C4CED0;
	Wed,  8 Jan 2025 04:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736312191;
	bh=NGu6EmnLNJaRhak7jqhR5JYU9X+B4KMm8+roVR5/bs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lOHbqkuuxi5z7p6qOjJl1B56mZ7J6qDhEducjWri5zo2wASlxkx5QNqWBbCqKpqg7
	 3Gg6jv/inAceczUzoST2icC04dVUdfoHX+pbYTFofsZ9UVxTofu1Ds5jHYlGyEqo+E
	 O4OoJvdWJzoqwy9LQMvfbIszzBab//c6e7W6Ch9I=
Date: Tue, 7 Jan 2025 20:56:31 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Usama Arif
 <usamaarif642@gmail.com>, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v1] selftests/mm: Set allocated memory to non-zero
 content in cow test
Message-Id: <20250107205631.6db80f0947102792c3f956a3@linux-foundation.org>
In-Reply-To: <20250107142555.1870101-1-ryan.roberts@arm.com>
References: <20250107142555.1870101-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 14:25:53 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:

> After commit b1f202060afe ("mm: remap unused subpages to shared zeropage
> when splitting isolated thp"), cow test cases involving swapping out
> THPs via madvise(MADV_PAGEOUT) started to be skipped due to the
> subsequent check via pagemap determining that the memory was not
> actually swapped out. Logs similar to this were emitted:
> 
> ...
>
> The commit in question introduces the behaviour of scanning THPs and if
> their content is predominantly zero, it splits them and replaces the
> pages which are wholly zero with the zero page. These cow test cases
> were getting caught up in this.
> 
> So let's avoid that by filling the contents of all allocated memory with
> a non-zero value. With this in place, the tests are passing again.
> 

Thanks, I'll add

Fixes: b1f202060afe ("mm: remap unused subpages to shared zeropage when splitting isolated thp")
...
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>

