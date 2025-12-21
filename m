Return-Path: <linux-kselftest+bounces-47791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F2CD3D68
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 10:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 272C5300ACFC
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15A186A;
	Sun, 21 Dec 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cv2Fm09G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C910FD;
	Sun, 21 Dec 2025 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766308539; cv=none; b=P/susv8eYNyePvaxRAnPAnUDP4/LgeBn1UBJlP5+2g98b1Ul+orw2Wd+UEmOLEdHksxLx+uk2C1/b90HRiOzXpUkpjNFXQfiYFAOqrgFpE4dGF2+oHFC2BS+SyEdMbvPhmxoU92PAmeVsQVQX8TqrzqLBYBVaKczvz/3f5DOtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766308539; c=relaxed/simple;
	bh=b357hX9Xdp9bwQpTLLwjh3lWhYTvtLb8BnlVRU/osgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrbHTuPT95At/yeOejc0UIGhz2oYXCepO755qtyMe5SwdZ88/uTIsCGrCsDYKACZktVXPNanhk5n7y5KUHPmjf0cJ3grzoTWvKDc3htt7m2sl9BEt5Iric3BkN3Pk3Bwm66UV+RmUgdJUDw67uS2ykcyYc+QtmPce2ijWhlgggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cv2Fm09G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE692C4CEFB;
	Sun, 21 Dec 2025 09:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766308538;
	bh=b357hX9Xdp9bwQpTLLwjh3lWhYTvtLb8BnlVRU/osgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cv2Fm09GF7eALT3WIQbM1x9zuA1ec7ZvrD2y/x19aVuh4erT7QOl97VSGNP5iR95l
	 T9jB7VOn0ifuVzFaRjZfC5f7B4sqJo/g5CISq9vwCP80Jl+VeWT7AOxoZwDA/Xplry
	 aDxdUd+YXhRg6Lrhp0tPLba/9ttn5ICGNqeOASjQVzkIHiU7eUAdB27x+55aVvmV3c
	 7TffflSjiwv/9rgXkOhvNtpyhhwfbJOr4nBc1UIUk1EUmxBtqJ3EDagbI7BAm1qfes
	 Y9O6f7VPGGFDmTwOUibpJz1Gynudn6/elhIZroI/6GZSAMAy+eI4woYtJJSmbej916
	 l5HjWQ1+P3DsA==
Message-ID: <74414ade-63fb-47ff-adda-903949468b88@kernel.org>
Date: Sun, 21 Dec 2025 10:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm/charge_reserved_hugetlb.sh: add waits
 with timeout helper
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20251221085810.3163919-1-liwang@redhat.com>
 <20251221085810.3163919-3-liwang@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251221085810.3163919-3-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 09:58, Li Wang wrote:
> The hugetlb cgroup usage wait loops in charge_reserved_hugetlb.sh were
> unbounded and could hang forever if the expected cgroup file value never
> appears (e.g. due to bugs, timing issues, or unexpected behavior).

Did you actually hit that in practice? Just wondering.

> 
> --- Error log ---
>    # uname -r
>    6.12.0-xxx.el10.aarch64+64k
> 
>    # ls /sys/kernel/mm/hugepages/hugepages-*
>    hugepages-16777216kB/  hugepages-2048kB/  hugepages-524288kB/
> 
>    #./charge_reserved_hugetlb.sh -cgroup-v2
>    # -----------------------------------------
>    ...
>    # nr hugepages = 10
>    # writing cgroup limit: 5368709120
>    # writing reseravation limit: 5368709120
>    ...
>    # write_to_hugetlbfs: Error mapping the file: Cannot allocate memory
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    # Waiting for hugetlb memory reservation to reach size 2684354560.
>    # 0
>    ...
> 
> Introduce a small helper, wait_for_file_value(), and use it for:
>    - waiting for reservation usage to drop to 0,
>    - waiting for reservation usage to reach a given size,
>    - waiting for fault usage to reach a given size.
> 
> This makes the waits consistent and adds a hard timeout (120 tries with
> 0.5s sleep) so the test fails instead of stalling indefinitely.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> ---
>   .../selftests/mm/charge_reserved_hugetlb.sh   | 47 ++++++++++---------
>   1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> index e1fe16bcbbe8..249a5776c074 100755
> --- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> +++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> @@ -100,7 +100,7 @@ function setup_cgroup() {
>     echo writing cgroup limit: "$cgroup_limit"
>     echo "$cgroup_limit" >$cgroup_path/$name/hugetlb.${MB}MB.$fault_limit_file
>   
> -  echo writing reseravation limit: "$reservation_limit"
> +  echo writing reservation limit: "$reservation_limit"
>     echo "$reservation_limit" > \
>       $cgroup_path/$name/hugetlb.${MB}MB.$reservation_limit_file
>   
> @@ -112,41 +112,46 @@ function setup_cgroup() {
>     fi
>   }
>   
> +function wait_for_file_value() {
> +  local path="$1"
> +  local expect="$2"
> +  local max_tries="120"
> +
> +  local i cur

I would just move "cur" into the loop; I don't see a reason to print it 
on the error path when you printed the value on the last "Waiting" line?

	local cur="$(cat "$path")"

Also, not sure if you really need the "local i" here.

What if the path does not exist, do we want to catch that earlier and 
bail out instead of letting "cat" fail here?

> +  for ((i=1; i<=max_tries; i++)); do
> +    cur="$(cat "$path")"
> +    if [[ "$cur" == "$expect" ]]; then
> +      return 0
> +    fi
> +    echo "Waiting for $path to become '$expect' (current: '$cur') (try $i/$max_tries)"
> +    sleep 0.5

Any reason we don't go for the more intuitive "wait 1s" - max 60s wait?

> +  done


Nothing else jumped at me.

-- 
Cheers

David

