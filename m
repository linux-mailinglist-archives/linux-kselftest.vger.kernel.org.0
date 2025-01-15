Return-Path: <linux-kselftest+bounces-24606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2DA12EC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 23:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD093A868D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 22:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5701DAC80;
	Wed, 15 Jan 2025 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EMJ7AYOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392F28F77;
	Wed, 15 Jan 2025 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736981665; cv=none; b=bL+cOOn7jI7sOuGIGpogR7kZeQMSYnnS7HRkZ3h4qTDyvz6HkfXBax/v66ddP5JgFh7SRXwaACBjGQkXQ2R2cgwAR9oy66nRpFmvZh0sVTHCbqrxdyN2XozBByGe4hBF397FtiIci0L24a5cjIidz+qkaU1ZwgZXoejB91h7onU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736981665; c=relaxed/simple;
	bh=GztnMrOjBn6CpkdQ0LThEvpzVmWPcr/qYWuQD4BWq9c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qQ3UYTyMLfS+D+KPs/k6+DMESQnQUVPtBUz1WJjVXvIUShScmERB7lXicRuABICbAIf7t9yb1cwoWW2Bn4rfIXHH74gAn4SwXw66+alOW9bYVJ55JWDqaD8L0L5BMKGFk9OSJwULEENqt5zib0VPM6LOyike0nt+/PJTCczNGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EMJ7AYOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475D0C4CED1;
	Wed, 15 Jan 2025 22:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736981664;
	bh=GztnMrOjBn6CpkdQ0LThEvpzVmWPcr/qYWuQD4BWq9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EMJ7AYOZmeaV/MS6YAhMcx1TTnZlauCOzegbWX0GBnGhpPeffEwzLGJUH4WgFh3OV
	 5gvtaX/WzwPBR5MGiZYizj2+3CWhMhk++bVyqc1tVhZre1mMWY0iTNq5VIhJDTuIND
	 a12I25A1btyaduJTAHEtP+3804rzZjvQztDdPWQo=
Date: Wed, 15 Jan 2025 14:54:23 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Muchun Song <muchun.song@linux.dev>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand
 <david@redhat.com>, =?UTF-8?Q?Miko=C5=82aj?= Lenczewski
 <miko.lenczewski@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm: Clear uffd-wp PTE/PMD state on mremap()
Message-Id: <20250115145423.62ec971812b8d975c16b9993@linux-foundation.org>
In-Reply-To: <9221000a-161b-46ea-a065-ee339837aacb@lucifer.local>
References: <20250107144755.1871363-1-ryan.roberts@arm.com>
	<20250107144755.1871363-2-ryan.roberts@arm.com>
	<26ee9ae0-405f-4085-a864-48d1ee6371f1@arm.com>
	<Z4fui1wQ97Hlmbqd@x1n>
	<9221000a-161b-46ea-a065-ee339837aacb@lucifer.local>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 17:30:20 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> I sort of favour putting hotfixes in quick, but this one has gone in
> quicker than some reviewed hotfixes which we left in unstable... however
> towards the end of a cycle I think Andrew is stuck between a rock and a
> hard place in deciding how to handle these.
> 
> So I'm guessing the heuristic is 'allow to simmer in unstable if time
> permits in cycle', if known 'good egg' + no objection + towards end of
> cycle + hotfix - send.

Yup.  Plus this patch had such a convincing changelog ;)

