Return-Path: <linux-kselftest+bounces-47796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E19B6CD3E3F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F83B3005EAE
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F98B27B34C;
	Sun, 21 Dec 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMRRYsYK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609423536B;
	Sun, 21 Dec 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766310733; cv=none; b=qvjEaalgOiG0A26V39FbmhzZJCbZX3Y0CoGfF7DTYINawNx1zEyHegkbaU8kRzIFBdVXiqfME98TpNLhyBt4ZPI5v0LXGbfeGEDiipXlAile+V1mynLh1wUd5/5qkCwTNl1iAolEIS0kGTUqYtR/pMMPEifk9765KT700R+Il9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766310733; c=relaxed/simple;
	bh=ogVOCJZTSd7k8LM4Om8v4u1baSeyYlcMXQJDVl+klUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrzUILWzHZO/4qTvNtheC/rTNxXGgpeBUBY4LlbYhdz9THfjc1C8nHbedq7MadKrnZIaRfzdvJplAjE5WJba6kgAxPXcrHUUeaG2dqUEgy+SicCT3OpbvixQrwupuhhunD3xs96gqKysLXRUHuj2t4Jr2ugdYbJGT3Wqfk3uzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMRRYsYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638E4C4CEFB;
	Sun, 21 Dec 2025 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766310732;
	bh=ogVOCJZTSd7k8LM4Om8v4u1baSeyYlcMXQJDVl+klUM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BMRRYsYKm0QDjudC92wFnYoTb6yXHEk2dZ/ra8sXxalHAXuLMD7nm3eCJp6TP8kmA
	 GNhviJ2ovXvsrsCyJTdYAw0KNacfnY0Amy5I89EVvk+9mPh17CbNu+2d6xEOmDmk6H
	 fqm2wRfsZgHJSDmCJqUXuA1k+1XwxsZAK/J6sAXSh/BgX+Z6XpgN7NiG28c8fR7pc0
	 u9S9A7aGq8cBYquID6OvV2uJYH3mGu2VrvibslLyb6GJMcP/EfYGuAA8cuF4tHxNNc
	 65TtN2ZroWfximrzJ0QSiL5yvbI/n17VQC+jdowfQUUE4bZSa8aZUxTFKynaJm2oGK
	 eMqMtqdLby+uQ==
Message-ID: <de5fa614-65c2-43d4-8c3c-549eeeaa5683@kernel.org>
Date: Sun, 21 Dec 2025 10:52:08 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm/charge_reserved_hugetlb.sh: add waits
 with timeout helper
To: Li Wang <liwang@redhat.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20251221085810.3163919-1-liwang@redhat.com>
 <20251221085810.3163919-3-liwang@redhat.com>
 <74414ade-63fb-47ff-adda-903949468b88@kernel.org>
 <CAEemH2eH0a6vHhv80hDcTBxTUYHALrOKjtvWnajCwPk_zLpJ3Q@mail.gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <CAEemH2eH0a6vHhv80hDcTBxTUYHALrOKjtvWnajCwPk_zLpJ3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/21/25 10:35, Li Wang wrote:
> David Hildenbrand (Red Hat) <david@kernel.org> wrote:
> 
>> On 12/21/25 09:58, Li Wang wrote:
>>> The hugetlb cgroup usage wait loops in charge_reserved_hugetlb.sh were
>>> unbounded and could hang forever if the expected cgroup file value never
>>> appears (e.g. due to bugs, timing issues, or unexpected behavior).
>>
>> Did you actually hit that in practice? Just wondering.
> 
> Yes.
> 
> On an aarch64 64k setup with 512MB hugepages, the test failed earlier
> (hugetlbfs got mounted with an effective size of 0 due to size=256M), so
> write_to_hugetlbfs couldn’t allocate the expected pages. After that, the
> script’s wait loops never observed the target value, so they spun forever.

Okay, so essentially what you fix in patch #3, correct?

It might make sense to reorder #2 and #3, and likely current #3 should 
get a Fixes: tag.

Then you can just briefly describe here that this was previously hit due 
to other tests issues. Although I wonder how much value this patch here 
as after #3 is in. But it looks like a cleanup and the timeout of 60s 
sounds reasonable.

I know the reservation of hugetlb folios can take a rather long time in 
some environments, though.

-- 
Cheers

David

