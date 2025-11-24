Return-Path: <linux-kselftest+bounces-46376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCDCC800BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 11:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48CB93420ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D1D2FB62E;
	Mon, 24 Nov 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC85DyZS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC2D13AA2F;
	Mon, 24 Nov 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981974; cv=none; b=VFh7rxn9u91VZfrbzD34+uKk1jxdXYmVqG1TW0NezSMQEPlkVCPEuaoivCnkr9xvZoarkGk2KH3GiaS8E1aHpmsKH/TG2XsT02xZQ2bzz3yF2SRHlHtXDLAgRzd0vk72k4AFzyofb1n0JgU6naasXQZo1d8qbJ9I4w+FmpxVq/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981974; c=relaxed/simple;
	bh=qLtkeaNDsB2tmDLOENGtmBtmZgPrR5Q1pBKk7Jh7MKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXSTg7OOgMr5PnBC/j78WFs6S7BhkRnLYVMh/DvO6Vom9FbdcIpNA4/7cgQ9dxKuTrb8ILlM3Pzvm3PXjp7qZbyJwRMBZMqGwEe2nWXVgLju32pcFO1nMsBdmt4qL77wipe7LzhVmkH2b9rEzl5Ap5DpFINk9IV/B60ZAiqk1f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC85DyZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D929C116D0;
	Mon, 24 Nov 2025 10:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763981973;
	bh=qLtkeaNDsB2tmDLOENGtmBtmZgPrR5Q1pBKk7Jh7MKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bC85DyZShd95NPEK1pyA4HmcKPMgnE1eCpXYyMlFo/LrZmCPIMkjzXbCdHdVPNdYh
	 40H+oOIzaTi26eBYT1hEmJlWXVgjFgoElkXRbOm0zxZIG9UqC+fJp7831F82iQ066G
	 oexWubXGLmQJgIrTh16XpTfaeLl3w6jghcRQsNJ/gqhRjKCxYB2AuFkYzK33YqUkRi
	 KL3z1vi6DiEIyGofW7iQbZbl6BaD+QJw9CdpqlpRgBcUN+1lkfaAgX2H3Bj0p786hi
	 AYvifNMxW6DHHqK2IVvwvqz2w09NQBaP3jLc49a5VasABGT8CKU3TWhp4DbEpLbwi3
	 cpuLjbyR12lLA==
Message-ID: <6d2d4b0a-a1dc-48a4-83c1-1fe02f294181@kernel.org>
Date: Mon, 24 Nov 2025 11:59:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mm, kvm: add guest_memfd support for uffd minor
 faults
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Nikita Kalyazin <kalyazin@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20251123102707.559422-1-rppt@kernel.org>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251123102707.559422-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/25 11:27, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> These patches allow guest_memfd to notify userspace about minor page
> faults using userfaultfd and let userspace to resolve these page faults
> using UFFDIO_CONTINUE.
> 
> To allow UFFDIO_CONTINUE outside of the core mm I added a get_shmem_folio()

get_shared_folio() I assume :)

-- 
Cheers

David

