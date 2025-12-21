Return-Path: <linux-kselftest+bounces-47807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 766BDCD459D
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 21:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 872C530046D5
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8971EE7C6;
	Sun, 21 Dec 2025 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej9Dbnjf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nB71x+kW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF56C1B3B19
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766349057; cv=none; b=XmIpcU0JX0knMsUtCl4kzvayX2dNBCaGrrrEqi/jovHqdTh7rhI51lFHKba/U+6OxjsxBWBsfBQfo8rpH38vt9QEa+b+748j4hMDgQZYmnllfAYg0NU5EDM+ILxVzzadmnEQ/mcy0hCMzjlfdfEouMVjewaSlq69BUa5rkLsVmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766349057; c=relaxed/simple;
	bh=c5V+C7Bi1t2nnzfwl6kz/YIJhGCetiZvn0W3NB8E8WM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JMQcPDytXEOCpofAgRrSguZLQ/XgG10exT0OuSlz1o4FJ3jMohxO7/fB4HyGhFR/TPgkUhZ2C4xtWedI01nkpyf+ktqGyj6DHAm+8q8aHOl4a45WOcAaamWzIOGel8qOf0Mrvs1IlKW9lt9aGrSV0Sykp3XijbNuq/pmOYT8d4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ej9Dbnjf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nB71x+kW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766349054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQHNqpP/7trjjClrcYJjGk8zMRaBkC2YosgJsTkpIiQ=;
	b=Ej9DbnjfFC+XsGxzF+tMFreCPDUJY7yI/eildX1v85c+NqrwMC307SjXI5pIUheD3mitE9
	inygSOcsa3Vkdl+DpYLvTvh0zI0FwmoVuD52Ny56Z7PZkqLkS5ajRiV54X59ePEazshCtq
	cosBtBlKUWZXPv6oMUkXEywAM70z/9E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-0qh01z5eMLSxfQs9EIxNdg-1; Sun, 21 Dec 2025 15:30:53 -0500
X-MC-Unique: 0qh01z5eMLSxfQs9EIxNdg-1
X-Mimecast-MFC-AGG-ID: 0qh01z5eMLSxfQs9EIxNdg_1766349053
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b51db8ebd9so1076163085a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 12:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766349053; x=1766953853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oQHNqpP/7trjjClrcYJjGk8zMRaBkC2YosgJsTkpIiQ=;
        b=nB71x+kWvLNRxmWBeHLKqWzfakPx8cpQe6Oz8T7sG/6rQfkQ+CxTmS7E2TSOZEHyTy
         Gzt1Th06HlrYCj8MBSezb/VXU63Vvj5n90wgvOIgVHRJAlR3Hz1Mg05C0FKa4UWZbWZh
         azjz9trpue9IFxM+C25bnQJmdzgqbWAZyhTJH3rtvwyPsrt/QwEp902XNH9c5JdwH55q
         qiqBV1cPzK3Y6dErV4aV1B9p73dnDpa+z+2Xa8nhjiHfEsBcniUTsvwS2xGX6juoBCcS
         ifcjFaRSUgMl5G/foQ858uVYVuqhG7UvwtFj/QNP8CAJEEeNGxiGOM/JepoflUkROeNg
         VV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766349053; x=1766953853;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQHNqpP/7trjjClrcYJjGk8zMRaBkC2YosgJsTkpIiQ=;
        b=fR58GZJE6vaIM9ODTDCBSSOF/BtzeBv3T+gLL/evXMaA/FPUOAta5Rm2tkn25cKXcZ
         pzNTaojRNA7emijvoT+kQTDl22V+4rzWXHadpER0bXVI/hnTV1I7Vv5LEU+wIR/cG2b9
         zpMguka7pnFGmnZVw3PwbpTn5g+kui0Cswdukt2Nm9pC8RmwFYvdPGFx1h6DzbZHBjVE
         RiDDQCQQ3J/VQGYYbW2xyjtsozKNllO9CAk4bq2jE1fGbMLXP6gCxVRjhiUoemhmeZRk
         TZdxA195sSJInnVNERBSgPh4HtS3vsmcfdtEn+qawYe4vll6dBUbc6OpYRXGcajXRzBa
         xvUw==
X-Forwarded-Encrypted: i=1; AJvYcCWOImYkHQJBPSCTfTEVOSmmNh2U+c1Ei86W/wIGAwu7e1ZkJjXHfAArK4Yx8XfuMCTGUVkTEOde7nDPKcphRC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBO3nhJuDeV5EXnB6MNcJL+CWJL8pR2kqE6/Nnu/MMcLl3Yso2
	OX8jMMrrle7yWk1cqgawbma14p55sTDwSA65NBerJtAykd9BE7NzUzJ1BvHcD2ABSR7Jet46fcW
	xcF5H3YP74sPa751lSIWHw/MGK8I/rRLWqro/Ad5x+zATiwfNTozfJmbTPtn2hw9mZSvuog==
X-Gm-Gg: AY/fxX60VSX9KdXvk5Zxz6sKxV7BaAp8NrJq3/kppt2/AR5AQ+UlkDQDgxS/EgqqfaU
	BA34iMRSJwukpuOJRYn1tI87INLvAETS0W+FACF3s4SsYCAeDnMMblP4Qg967DVomZ84ReYyyRm
	GF15xwNsHxouZZBOMZBEj7Sg9QqPT4iwUUsTcfNP+mzTOXRGXCiq0RnVLFFrejE89MTb5GQpRdo
	DUa5g42/BtExEkdyLQgmGRHAckIFWBpePAABVP/ZI3UJQQlqL2yFS0dmHU2WxrqfAYMMcL3viHt
	22ELbftiaofkKZZIqyRAeQHoAzp/XluZkwNljwywULla5UXOTeH6Jr0lLugScZnULdpdcXC9BEZ
	6vJRjfKyPTqs1sHvUqSlooEKn5Okg5E4bNR36h/VMUQ06yx0Km1+O2ehv
X-Received: by 2002:a05:620a:4095:b0:8b2:7679:4d12 with SMTP id af79cd13be357-8c08f66bf33mr1473824785a.26.1766349053167;
        Sun, 21 Dec 2025 12:30:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4ZSBwCOROzj1MDk+wseVq5r9oqA/aYULwmmkpJomMHdxkmKpX/uo/s0oZVSGAhDM9U0HtIw==
X-Received: by 2002:a05:620a:4095:b0:8b2:7679:4d12 with SMTP id af79cd13be357-8c08f66bf33mr1473822185a.26.1766349052724;
        Sun, 21 Dec 2025 12:30:52 -0800 (PST)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fcdsm674426985a.29.2025.12.21.12.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 12:30:52 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <33d5bdc7-0fde-4a97-aa1a-f8565e196ccd@redhat.com>
Date: Sun, 21 Dec 2025 15:30:50 -0500
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
Cc: David Hildenbrand <david@kernel.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20251221122639.3168038-1-liwang@redhat.com>
 <20251221122639.3168038-4-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20251221122639.3168038-4-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/21/25 7:26 AM, Li Wang wrote:
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

wait_for_file_value() now return 0 onr success and 1 on timeout. 
However, none of the callers of the wait_for_hugetlb_memory* are 
checking their return values and acting accordingly. Are we expecting 
that the test will show failure because the waiting isn't completed or 
should we explicitly exit with ksft_fail (1) value?

Cheers,
Longman


