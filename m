Return-Path: <linux-kselftest+bounces-45771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAE9C65639
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 042C23666C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF13304BB7;
	Mon, 17 Nov 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXRkM0oz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41430304BAF;
	Mon, 17 Nov 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398811; cv=none; b=CEzMq6gETk/E1WFlZINnuddkEZRtcBijbgAIEE95NzxR5vgoI1WWQ7E5WUt0ZR+IN4RgPWSrwJvWK+m8RfX04juqrukeCG+VaTMyI4/T5q1p1hVKwf6Vr32gEyebPOMmNnJzRFu2OCVJUmZai3xcPAGOwemCt/X6Fv4OlUStJeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398811; c=relaxed/simple;
	bh=DD5aJ0CYO5FJNOi0XizsUc+cIpf1vb2XlK1BACSazP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=clCuyGRUzVmsXFt4qNPBblFgQal+kMYSBGZ+OzhaO8zKAROVIACgOQPtyhyeGLZW2Kw6+JmuwuxEOMt023Fvsr/90wzpAFU+tMvRSe72+2pDHkCppwOoqQL/11Kao66IpttyXYIhbhEXUHa7FNQjY4q8218BtFgOsA1m8LR62Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXRkM0oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A21C19423;
	Mon, 17 Nov 2025 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398810;
	bh=DD5aJ0CYO5FJNOi0XizsUc+cIpf1vb2XlK1BACSazP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DXRkM0ozBdjtfmku47EUoC5aecIc/EhtwKbfV03r6i/hnVF43NpNJqwcS5qsIM4sZ
	 avJzaJxVZPsWIk57vzZFBdJ8qMZwHaZgWPw2J8z1rcKS6opHRvYWcSampBtKJNuyi+
	 8LbTFQqizNyKlp3G/TpTx3az3+xSzmy585HKNQKygHRc95Spvxd4mCuwtv20Ol0uZ9
	 0/W56NbOhupcwU+sCxTDUbL9FQ321StUqwAvFcpMbdKax710y+6ZE+Oz+xrxJ/laew
	 y+8QoolAbRNF4F6Hq9e7TkPvEUMYzfDVNhvgt5o3x+z4NagMG8v7lKnxf7vJF5NP5y
	 rkUHC+7R4jnJw==
Message-ID: <4c5a9201-b2dc-4765-bfc7-f89ec095b629@kernel.org>
Date: Mon, 17 Nov 2025 18:00:04 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] userfaultfd: move vma_can_userfault out of line
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251117114631.2029447-1-rppt@kernel.org>
 <20251117114631.2029447-2-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251117114631.2029447-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.11.25 12:46, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> vma_can_userfault() has grown pretty big and it's not called on
> performance critical path.
> 
> Move it out of line.
> 
> No functional changes.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

