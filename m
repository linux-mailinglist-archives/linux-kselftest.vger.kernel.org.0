Return-Path: <linux-kselftest+bounces-45545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA0C58184
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4D1D4E1722
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F062DC345;
	Thu, 13 Nov 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI9vAkIq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKLoRhEv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564292DA779
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763045880; cv=none; b=BHBcGw7ZK9CYRla0U+Fn4d9Ul8jzrL+mnElcXDv9JkB0P26djKSLJMJ4497VVyftepMHRV+ipJVUrD15BxF7bsJJQtXRcKd3i+WdCZs0NOE2+T0iOcLHgSVIxU1TjhjUzCp8xP0kdkT8gk70hVskP9uOGTYnnqDp6PCmHsrOBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763045880; c=relaxed/simple;
	bh=faj86vAeazNGZyO4GIiqZNPU1r2huFPhAw+qock7rN4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gjx4y35nfBrw5ayKHBw210a5mB4yMhcCXwAmpNnmxj701da0VQ5L3tL86aheDe4WObIkL0yHFE+t1IftNwzhi4WJHE9qlILol9ap+as9eWTMiYBuM6hshy4j4hWJrGxRSfI9l+sIq94260zmmnh8DKCILmZdQO6psm4t37C5gUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CI9vAkIq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKLoRhEv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763045875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJxYtQRZI2oPZefjc4khJHiI16kn+fD7Y9WQvYzGtO0=;
	b=CI9vAkIqjGWpu7uw1qjki4tMXVXX3zTj9Xb81RewFehOobjkWxXna1F4ZRpkf89kUjNLWl
	GDo93+pmf+zTkSrXRne+t1XjDsKQG3VA1jZtGIVSZsMNLlDNwC/TKDL52a04+TMjaRimDf
	4INo1udqtsciAkREF2SF92rQ7DWX9Lg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-pQUm589CNbK0rVPvwmw4Bw-1; Thu, 13 Nov 2025 09:57:54 -0500
X-MC-Unique: pQUm589CNbK0rVPvwmw4Bw-1
X-Mimecast-MFC-AGG-ID: pQUm589CNbK0rVPvwmw4Bw_1763045874
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-880441e0f93so30449206d6.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763045874; x=1763650674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJxYtQRZI2oPZefjc4khJHiI16kn+fD7Y9WQvYzGtO0=;
        b=XKLoRhEvE0u30FPSr8aF8KDRUt5ZEHjGLWJqEE7wHn23FOSrFk6qLOFrIqyD5f1zu0
         sGHkpYvNy/PQdZEXTMdutdyfXbaLxsOXiY08Fac4AHmFGeHZ/nO/qO4A49xQeIOPadyL
         GV+YrkHCzS87KaV4Ajjmjb+YHpx1ZUpnWFMmsWcLhSsISxrPzvPGimlykGK1zVMUtXcM
         71CCrLTMwjno3LtAU7H75XziTS1S+6YSrEd5vmZWx21sByjxzpMED1mlJz1sooNLTT3K
         tTqqB5S0lm/rioODIf9FpBrILuAIPD/xZFrmdwzHZ+/3L16UxSjuy20DIvk1Goo82RDo
         HHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763045874; x=1763650674;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJxYtQRZI2oPZefjc4khJHiI16kn+fD7Y9WQvYzGtO0=;
        b=vhzUYo4WBcg9H+z1H7+9jf6KXHnArnpjX1c7WlYxQVppEp5Kcfs87CU6Fgjgq2RTuZ
         sEJyogKTeAc4cnXD8wFCnnYQE3e6FyaLj0Zs8rDUV+p77QR3/M6SmyJ9pP/cJjGtQpE3
         1XBgbyGVCvGxYIg466Etq7hh+oc099GevWBp+x1w/hGeTEVZet7HIhaJFnhIEiPpCnSy
         v2LUPlBYK6WzB7WrZIZePsuxtB9OsPrOnVZHbWHiKqv3P+4bsvAJfndx5Q00TyosHbk9
         GtJWNVzxppYr21kbQU5utSZqckTt0ai1ZpsoLOH7Q6obvN/VyQ36vRGzNniZfLOS9zeb
         g6Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU5I266tczHIAcc9XzA+x0eZ6z5qhVOr4QAysOw2tqd5D47P9W5KouBffmZBHbi7G9TLB23du73+ojdwI6O3lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWi/+ppyIHTqhpwN13jcNdqTiozVDDCg9yOd86zq1PpdGPR3E
	vTvLYFlKjjQyO2TQZI7V9LbK0wWuBBCaR3Y6PDJvCV1VvydaEqjtH20rZENPwGoG9WoLQ1yqdd8
	1KEhYGkCbBUB5RmaPTI5pndteFM8z64f2XJFjTd6bx/afKbL/So9sLnXoUJfd7VrRpnfOdQ==
X-Gm-Gg: ASbGnct79Oicyq2JaP4XepshHh7tR2YAPu4ntFSLLhmI3f/qdu87tM7xOm7DlRIxW/j
	B2NrAH8FRnIvGzm20apvrcqSyirGF9ReBRPbQT+AMby3iuEwM8+hAeobXdSb1hY8tuA6N6gLzK3
	Or8uqjuNrbF3fZ4OonX+BKrTfJgdS7IS4BTRbncZqdamaCmVF4PawDq/9+tL+PAmNePRNnSgut3
	I0q9uCGh95D8U6WTNPofpguTM+MVzc8ucq+bOcHcsnabi9C70ykZWKZfLsaU+fAUuEfr8lFpD6n
	0C6IVApqbrXorOxBuKa4Wuv38dZE6NPG8xyxy8xHxCR/1qr2Z6HahLBQ5U9G36ABW9Npj3+obSl
	mxewmAZzz5+No1m+74ubfXZTQ3N7SNvnbsN9axMNxZyuaQw==
X-Received: by 2002:a05:6214:2241:b0:882:42a7:9a10 with SMTP id 6a1803df08f44-8828188ab58mr53149276d6.19.1763045873943;
        Thu, 13 Nov 2025 06:57:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7ivS+/VnFbxs2+/hbdR+e606kVPGVkUdYiPwGihBy73ZEjeUI63aBB6N9af8uBkgape58ng==
X-Received: by 2002:a05:6214:2241:b0:882:42a7:9a10 with SMTP id 6a1803df08f44-8828188ab58mr53148946d6.19.1763045873459;
        Thu, 13 Nov 2025 06:57:53 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865cff46sm13273816d6.57.2025.11.13.06.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:57:52 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <52ce4948-4285-4846-8ca8-d997cc0c6868@redhat.com>
Date: Thu, 13 Nov 2025 09:57:51 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
To: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mkoutny@suse.com, shuah@kernel.org, tj@kernel.org
References: <20251113131434.606961-1-sunshaojie@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20251113131434.606961-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 8:14 AM, Sun Shaojie wrote:
> In cgroup v2, a mutual overlap check is required when at least one of two
> cpusets is exclusive. However, this check should be relaxed and limited to
> cases where both cpusets are exclusive.
>
> The table 1 shows the partition states of A1 and B1 after each step before
> applying this patch.
>
> Table 1: Before applying the patch
>   Step                                       | A1's prstate | B1's prstate |
>   #1> mkdir -p A1                            | member       |              |
>   #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
>   #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>   #4> mkdir -p B1                            | root         | member       |
>   #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member       |
>   #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |
>
> After step #5, A1 changes from "root" to "root invalid" because its CPUs
> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
> use CPUs 2-3, so it would be more reasonable for A1 to remain as "root."
>
> This patch relaxes the exclusive cpuset check for cgroup v2 while
> preserving the current cgroup v1 behavior.
>
> Signed-off-by: Sun Shaojie <sunshaojie@kylinos.cn>
>
> ---
> v1 -> v2:
>    - Keeps the current cgroup v1 behavior unchanged
>    - Link: https://lore.kernel.org/cgroups/c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com
> ---
>   kernel/cgroup/cpuset.c                            |  9 +++++++--
>   tools/testing/selftests/cgroup/test_cpuset_prs.sh | 10 +++++-----
>   2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..3240b3ab5998 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -592,8 +592,13 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
>    */
>   static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
>   {
> -	/* If either cpuset is exclusive, check if they are mutually exclusive */
> -	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
> +	/* If both cpusets are exclusive, check if they are mutually exclusive */
> +	if (is_cpu_exclusive(cs1) && is_cpu_exclusive(cs2))
> +		return !cpusets_are_exclusive(cs1, cs2);
> +
> +	/* In cgroup-v1, if either cpuset is exclusive, check if they are mutually exclusive */
> +	if (!is_in_v2_mode() &&

You should just use cpuset_v2() here as is_in_v2_mode() checks an 
additional v1 specific mode that is irrelevant wrt to exclusive bit 
handling. Also please update the functional comment about difference in 
v1 vs. v2 behavior.

Note that we may have to update other conflict checking code in cpuset.c 
to make this new behavior more consistent.

Thanks,
Longman

> +	    (is_cpu_exclusive(cs1) != is_cpu_exclusive(cs2)))
>   		return !cpusets_are_exclusive(cs1, cs2);
>   
>   	/* Exclusive_cpus cannot intersect */
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index a17256d9f88a..903dddfe88d7 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -269,7 +269,7 @@ TEST_MATRIX=(
>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2|A2:3|A3:3 A1:P0|A2:P2 3"
>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
>   	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
> -	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3|A2:1-3|A3:2-3|B1:2-3 A1:P0|A3:P0|B1:P-2"
> +	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-1|A2:1|A3:1|B1:2-3 A1:P0|A3:P0|B1:P2 2-3"
>   	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
>   	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
>   	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3|B1:4 A3:P2|B1:P2 2-4"
> @@ -318,7 +318,7 @@ TEST_MATRIX=(
>   	# Invalid to valid local partition direct transition tests
>   	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
>   	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
> -	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
> +	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0 0-4"
>   	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
>   
>   	# Local partition invalidation tests
> @@ -388,10 +388,10 @@ TEST_MATRIX=(
>   	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
>   	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
>   
> -	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
> -	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
> +	# A non-exclusive cpuset.cpus change will not invalidate partition and its siblings
> +	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:3 A1:P1|B1:P0"
>   	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P-1"
> -	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P0|B1:P-1"
> +	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-1|B1:2-3 A1:P0|B1:P1"
>   
>   	# cpuset.cpus can overlap with sibling cpuset.cpus.exclusive but not subsumed by it
>   	"   C0-3     .      .    C4-5     X5     .      .      .     0 A1:0-3|B1:4-5"


