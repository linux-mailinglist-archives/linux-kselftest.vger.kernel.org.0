Return-Path: <linux-kselftest+bounces-39480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF25B2F80A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFABB3A37A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 12:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91419E83C;
	Thu, 21 Aug 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pxY2U7T6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7AE2F5E;
	Thu, 21 Aug 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779490; cv=none; b=GeWOyD5l6SKkV8O0sfXQqBEWjypRtg3a3ZjA/BjInZczWWXS/CgjUygqo7NNQVeVPLtUCK1FOdEP6anIqKXDLitjX3NvsBc69qfp5nLCMv+J6AqGYu9OQJNn0g0ORQXjeKiCyTIGpOolZEvlqaCUiHF/i9e4K32YWAENd7mEO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779490; c=relaxed/simple;
	bh=1X8YBWQ47kcR3NLnc+BPXG4nANE+2JC2KP0lrQKG31k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bqu4LarT25Gd9/MzyDrKA+hTp7/2zP8Yq1/soOJIIh3xpG1cZK1Hi5C/Tk9jq9KJXaP1vJ/PwcoO1f8YZD71gYtnOGAAppCq5OWz7VOf76m+Xfih0d+4+nY6Ty1E1OQWBJkyQGbjOH3m+PqPWXsNylGHKLz9SKyApjB62wWgkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pxY2U7T6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755779487;
	bh=1X8YBWQ47kcR3NLnc+BPXG4nANE+2JC2KP0lrQKG31k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pxY2U7T6feWMfT06C+jDFtze1Osu/4/30Jd05L50qRP1+VvZiFq28HhygitP/Ob3X
	 7AgKEzRJm4aK65dep/E37eDo07STb6zGmIi+1+o2wGt4mG3JJF6H6B/GVyz/+s3BIq
	 5HUlOnikVBzFqJn+/fRC+dqu3++s9wG4MPjSjg+tIE7auAevL/3Uxkm2mKAOju655V
	 f7Y854pDGZHftB2+BHbQ73Mb+mKQr2yHyg/sFlDVH2WsrBiY+nBVp7YEXrVOgeJom7
	 M25vTND0UIyH52A1ZGChgPa4YAVPMHoBlP6iVU0/TmnMIzYYlBlt+P7oQ4ziPu4UU+
	 LZZjStQTddfhQ==
Received: from [192.168.100.175] (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E4E8D17E0154;
	Thu, 21 Aug 2025 14:31:22 +0200 (CEST)
Message-ID: <4abd97fe-412d-4e3e-9efc-cf3092d66e57@collabora.com>
Date: Thu, 21 Aug 2025 17:31:21 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, Albert Ou <aou@eecs.berkeley.edu>,
 Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Leon Romanovsky <leon@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-kselftest@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-mm@kvack.org,
 Nico Pache <npache@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
 Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 4/8] selftests/mm: Add -Wunused family of flags
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
 <20250731160132.1795351-5-usama.anjum@collabora.com>
 <57c816d6-a9ba-47c9-8f40-3978580b7f67@arm.com>
 <8e9d7c59-46b4-4e1b-8a55-1898302f5080@collabora.com>
 <88ea592c-c6ff-4a19-a366-eadeca66b039@arm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <88ea592c-c6ff-4a19-a366-eadeca66b039@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/21/25 3:43 PM, Kevin Brodsky wrote:
> On 21/08/2025 08:28, Muhammad Usama Anjum wrote:
>>> As to -Wunused-parameter I am frankly not convinced it's worth the
>>> hassle. We're getting 90 lines changed in patch 6-8 just to mark
>>> parameters as unused, in other words noise to keep the compiler happy.
>>> It is not enabled by default in the kernel proper precisely because it
>>> is so noisy when callbacks are involved.
>>>
>>> Patch 5 is clearly an improvement, but I'd rather take it without
>>> actually enabling -Wunused-parameter. The rest of this patch isn't that
>>> useful either IMHO.
>> Patch 5 removes genuinely unused parameters flagged by the compiler. If we
>> drop the -Wunused-parameter option, however, new unused parameters will
>> continue to creep in with future patches. The goal of enabling this warning
>> is to surface such issues early so developers can address them during
>> development, rather than later during review or debugging.
>>
>> Long term, I’d like us to rely more on compiler and static analysis just like
>> kernel to catch these kinds of problems proactively, instead of waiting until
>> they’re reported or someone fixes them later. While it may feel like noise
>> initially, this is largely a one-time cleanup—once done, developers will
>> simply fix warnings as they arise, keeping the codebase cleaner going forward.
> 
> Agreed on the general principle, but I think the hassle is just too big
> for what we're getting in return here (see also Andrew's reply). New
> code may also introduce a bunch of unused parameters for legitimate
> reasons and it's easy to imagine contributors ignoring such seemingly
> harmless/irrelevant warnings instead of sprinkling __unused all over.


> My
> feeling is that unused parameters are expected to be allowed in the
> kernel and it isn't helpful to go against that expectation in just a
> small subset of kselftests.
I thought kernel must be giving error for unused parameters as well (from
my memory). But just checked and it doesn't seem like it. I'm okay with
dropping -Wunused-parameters.

We need to drop patch 6/7 and in Patch 4 should have only:

-CFLAGS += -Wunused  -Wunused-parameter -Wunused-function -Wunused-label -Wunused-variable -Wunused-value
+CFLAGS += -Wunused

@Andrew, Should I resend the entire series or would you can make the change?

> 
> - Kevin


-- 
---
Thanks,
Usama

