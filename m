Return-Path: <linux-kselftest+bounces-47792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F42CD3D6F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C52530014C4
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE761149E17;
	Sun, 21 Dec 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEWtcsSM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C76186A;
	Sun, 21 Dec 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766308637; cv=none; b=l2HM57AEEPwZsjBa8wzPAZIYJKtO0iYZm4KXvtFGhKPyJCV5BZAVXzhFsj972Ecfz+YzWfVqWY+OHa9BVg3hyMf9e+CZzCfbtJpQhdOgEKHjoavRn3JyAD08iHeBW2yVbRQzxA6IuiJxq2WAvKkiYHz/QR+Cg0Q5Dvg3oe/MH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766308637; c=relaxed/simple;
	bh=4eUA6zMGUNJWxe38oDOSWKwnrNVk4Nx/VqQvXb9wl/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2LZ2hKZr40+/BzwvSYeKWM06JfuG+zIkzAUaNRw9WuGvkr/P4lp129dfZaaom0rtrRcJBX314JN6Q9IfNFbPvZ5zQtjIIaD65UrGhc9ecuWOTgpdpsw+g/5wLUt9Gp3bZ3u61P+BFP47H9FMoaxlR6Wp0YEerU0kxLsgubRAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEWtcsSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04EEC4CEFB;
	Sun, 21 Dec 2025 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766308637;
	bh=4eUA6zMGUNJWxe38oDOSWKwnrNVk4Nx/VqQvXb9wl/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nEWtcsSMv3X8IEXCQ8ilT++XBsGdu99zZSG4GQRMRicqoAG6z7D4s6Sjcs2zUs3Gi
	 MnOPLHswFOUldvFzErPD/etpuQLMhf2/vK/MCoP+HH8USOFpWUxMmUZDE+Hp9J8AIN
	 XUF+AUjgp1z3J7udB81iSZwKamO0vXN24lvP37+viWs33PipIh9TX4YCM+6RAvnEUO
	 mhITa188sLjIon2/QrFf6fH/KWGXOddMJ/7xOQJRQ8wVMEXEEkaAad7A5SJdrJ3Fhf
	 WZBk4EVYR3+do0mkL5Ns2xDjdTsgxUTQbFgg7vIqmzq1CyJUAWsfgLHfZkVWnriwiQ
	 wF4vF/1jj41GA==
Message-ID: <970fa015-9ec8-4903-8e2f-f3e847d550d1@kernel.org>
Date: Sun, 21 Dec 2025 10:17:12 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/mm/charge_reserved_hugetlb: fix
 hugetlbfs mount size for large hugepages
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20251221085810.3163919-1-liwang@redhat.com>
 <20251221085810.3163919-4-liwang@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251221085810.3163919-4-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 09:58, Li Wang wrote:
> charge_reserved_hugetlb.sh mounts a hugetlbfs instance at /mnt/huge with
> a fixed size of 256M. On systems with large base hugepages (e.g. 512MB),
> this is smaller than a single hugepage, so the hugetlbfs mount ends up
> with effectively zero capacity (often visible as size=0 in mount output).
> 
> As a result, write_to_hugetlbfs fails with ENOMEM and the test can hang
> waiting for progress.

I'm curious, what's the history of using "256MB" in the first place (or 
specifying any size?).

-- 
Cheers

David

