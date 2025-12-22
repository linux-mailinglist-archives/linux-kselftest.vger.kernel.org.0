Return-Path: <linux-kselftest+bounces-47823-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDF0CD5795
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19F4C304B94D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253C3126C3;
	Mon, 22 Dec 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HI38sG+t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A55A30FF37;
	Mon, 22 Dec 2025 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766397967; cv=none; b=YN/4jU0JJeuG3BRxAq53IvNSXN8WfVmrmmKZRUbJQNUq8L8ThhARNf6aAMCmDkeFlactmxk5+GJHglWRUoHN5kagBp7xiNOhzEIxzMYUaummYw3WOV95jN0JfjytJqqmoMnvSfOI5mcS1rwX0ChepbI2bPUy+/PfQCLLHKXaERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766397967; c=relaxed/simple;
	bh=eebHz6ssj2w0wto0mRjf/UfvVDz8o6LFYZj+RkpDE+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fY0rwc2/KM9rSTzzanO054v0LI33o5Aztw6JF0CQxfQy6CjVVBGsD5CM1oWBOafsCT+xC6FRAQOoKaghA57AupJ9x7DgBr0ibMMQ8UI7hmR8nJniRiACYQqWAghYWsCrZ98Albcjb4NqHVXQXqF9z8F13OZG7v4dWQeU+n6VZ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HI38sG+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0FFC4CEF1;
	Mon, 22 Dec 2025 10:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766397966;
	bh=eebHz6ssj2w0wto0mRjf/UfvVDz8o6LFYZj+RkpDE+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HI38sG+tzHdHXWzV6JAYYcfwtG+HOZkEHEjLyqrsyxBrVqaXpBRvG0CIYBJU7rxBj
	 x63MmyJVvgzTXJrCkyxA033xaJESAh2jcupf620fhkrUCtYyUBYki0zkU2TCMFsmH4
	 ki15M8L7sM6oTZcbyRPAy/wDYnEG0ysR0TTpoS6E2hqy4unWVWIat17Fs+z8VNmpGa
	 ErOTaC7ruAPX0RjkyDrTeg1SjEyGW717rpv6ZChAplSxtvq47OFI2vh2Lrt0fZoLVP
	 T8vm1shliwcWwZJ7M7m6D3vyILr9dV4zC+e1hpXiPqRMp6L0HwuzSiol883B9U+5qZ
	 yVqptsfWnpUog==
Message-ID: <233fb781-49fb-4a45-aa5a-d2815018272d@kernel.org>
Date: Mon, 22 Dec 2025 11:06:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests/mm/charge_reserved_hugetlb.sh: add waits
 with timeout helper
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Cc: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Waiman Long <longman@redhat.com>
References: <20251221122639.3168038-1-liwang@redhat.com>
 <20251221122639.3168038-4-liwang@redhat.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251221122639.3168038-4-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/21/25 13:26, Li Wang wrote:
> The hugetlb cgroup usage wait loops in charge_reserved_hugetlb.sh were
> unbounded and could hang forever if the expected cgroup file value never
> appears (e.g. due to write_to_hugetlbfs in Error mapping).
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
> This makes the waits consistent and adds a hard timeout (60 tries with
> 1s sleep) so the test fails instead of stalling indefinitely.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> ---
>   .../selftests/mm/charge_reserved_hugetlb.sh   | 51 +++++++++++--------
>   1 file changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
> index fa6713892d82..447769657634 100755
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
> @@ -112,41 +112,50 @@ function setup_cgroup() {
>     fi
>   }
>   
> +function wait_for_file_value() {
> +  local path="$1"
> +  local expect="$2"
> +  local max_tries=60
> +
> +  if [[ ! -r "$path" ]]; then
> +    echo "ERROR: cannot read '$path', missing or permission denied"
> +    return 1
> +  fi
> +
> +  for ((i=1; i<=max_tries; i++)); do
> +    local cur="$(cat "$path")"
> +    if [[ "$cur" == "$expect" ]]; then
> +      return 0
> +    fi
> +    echo "Waiting for $path to become '$expect' (current: '$cur') (try $i/$max_tries)"
> +    sleep 1
> +  done
> +
> +  echo "ERROR: timeout waiting for $path to become '$expect'"
> +  return 1
> +}
> +
>   function wait_for_hugetlb_memory_to_get_depleted() {
>     local cgroup="$1"
>     local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
> -  # Wait for hugetlbfs memory to get depleted.
> -  while [ $(cat $path) != 0 ]; do
> -    echo Waiting for hugetlb memory to get depleted.
> -    cat $path
> -    sleep 0.5
> -  done
> +
> +  wait_for_file_value "$path" "0"
>   }
>   
>   function wait_for_hugetlb_memory_to_get_reserved() {
>     local cgroup="$1"
>     local size="$2"
> -
>     local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$reservation_usage_file"
> -  # Wait for hugetlbfs memory to get written.
> -  while [ $(cat $path) != $size ]; do
> -    echo Waiting for hugetlb memory reservation to reach size $size.
> -    cat $path
> -    sleep 0.5
> -  done
> +
> +  wait_for_file_value "$path" "$size"
>   }
>   
>   function wait_for_hugetlb_memory_to_get_written() {
>     local cgroup="$1"
>     local size="$2"
> -
>     local path="$cgroup_path/$cgroup/hugetlb.${MB}MB.$fault_usage_file"
> -  # Wait for hugetlbfs memory to get written.
> -  while [ $(cat $path) != $size ]; do
> -    echo Waiting for hugetlb memory to reach size $size.
> -    cat $path
> -    sleep 0.5
> -  done
> +
> +  wait_for_file_value "$path" "$size"
>   }
>   
>   function write_hugetlbfs_and_get_usage() {

It would indeed be cleaner to propagate the error and make it clearer 
how we then cleanly abort the test.

But if it keeps working for the time beiing, fine with me

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

