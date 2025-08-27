Return-Path: <linux-kselftest+bounces-40052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860D3B381A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178DD681D52
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17B302741;
	Wed, 27 Aug 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWPSLaqg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375C302772
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294905; cv=none; b=XCE0pdpUA1I7iBw310EpzhyppFPnZilb0AjxVfV+lkrXHf3tu5AOZMeX+iGAWhTEd6W69GHIOv4uj6bEZmxNtLZLtmyIrPMZ9HLIV1nRLSyxdMDvCJlpQSDx0xiS4kITJgZjvKcm9HNL90TeYsNOSAVNBaPBsT0e++v9z/8T7YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294905; c=relaxed/simple;
	bh=gpzJgwGUB84I34ePuaz7BMCZpd8bZhEo2g/I/U029Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmegKGgvNEcxPo/VA+O9IAd7poG/x5BeRxNHC/9ujsJwTuNig5ZV0rIwCt0ZbeCuWFNEijvks/dtBh5vM1idoE7UHPjfpR7W9Gak0Iit6zcLiAWfO+7IGV02qFi3QGFnlyGwq6ku2ynuGHwkt6jRhrwj16jAWog3iokFMRnSKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWPSLaqg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756294902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HV/xZcVuFLtiCGviUqTx61DCXk4F4wUkVDUlnEBoh2w=;
	b=AWPSLaqggk+JnD+XMY6LeEaM9lYFxtXjz/1GeQFeu8oJKjdS37XKinsBJ2UTge4Zs30HGW
	IR/Eeq8Ynb73n2bS1vA3pF9/GA+narAf5Jd+3wPJNWfrbyTQhc5HtJMTTFnuDFNc+Qcpvu
	LmjtgJN8mVT2tItXpVmoHcK6UalO2fw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-H1MuRNijN2GiZ-rU7CVB9g-1; Wed, 27 Aug 2025 07:41:39 -0400
X-MC-Unique: H1MuRNijN2GiZ-rU7CVB9g-1
X-Mimecast-MFC-AGG-ID: H1MuRNijN2GiZ-rU7CVB9g_1756294899
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70de52d2904so11540586d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 04:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294899; x=1756899699;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HV/xZcVuFLtiCGviUqTx61DCXk4F4wUkVDUlnEBoh2w=;
        b=O+/uc7X4mO3h+Mlp7UKKyDq53wN0w0hA0mXhQEvK/ZvkNH6yodaxgTQDEQNR+m55Ha
         2mbCLoJnRnIj6c1t5CG3Ig/I6Ui+tWIhkRhrIiSmxQGgpBu3Ct3M6CMjnlnsbPrwwfPi
         ff4VZS/4qeGpVZajXEQxI3/ExZqOnCoKRl2dNKF62jvolX7Ego8hwwgPwlb9O0/c9ZMW
         W/O8y+2Y10A0a82CkelyfXCePEv04hHycq1kLtWQNuhHuNHRJPka38nSJxCcm0nm99ld
         02bLO9zmAYF01UBcKlZvrOSatzWWc8lmJw0vSGtBuQ3qqicewAIqDJkdxT1q+Dm5upA2
         ze7Q==
X-Gm-Message-State: AOJu0YygUl2xaTw7xDIsJlRCQ2cZZqya0b1oz2WB4LpWTfy+XQE+Jl+L
	GN0zahE5W8o28d277uG6tM1KSJTJ8KUqQU+uKDI0+fZKuG0blPkxEvTCyk/lpv3pbnjKGfmDyTK
	i0Nm3WrGGftXI4d3hNHkNiGD9lFKRyTRT8i8EjTU6xIobUaFUT4MnCrJAhQQ8SiBCNnBQeg==
X-Gm-Gg: ASbGncvZj7VbahtRfCcPrwkudpusqwHd5+OqMyuZQasUMVH1dJVkGCrcgIMyn/BrDZA
	BufSR6JsAI601fdhzilwS81taTw7shtPe9cQPG6ra5Za1/KCzLHTOU4CU4ZH8ck3Jucq5an985s
	blxzLE6pGwo+krpjY/rpNXPPvnPS7Qpk8kNFwTg/gb+/v71P++9gV+SXdqp1aglZIKUQbuv2bgV
	DwjQgB7Bnjwlqe/zJzksWtpz+TPZ2fFf1RVToZGUNxMvi/GnB8ud5yS+vfFBKDVfAs9TjlJrJma
	fzBgh9CuNe8iQOa9vbF4oNJ/oXwAPT6FNNG7Wv/j4Aei75CldbYqJ90+QDL+eg==
X-Received: by 2002:a05:6214:29c6:b0:70d:c4cf:66dd with SMTP id 6a1803df08f44-70dc4cf67ebmr95365756d6.20.1756294898630;
        Wed, 27 Aug 2025 04:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoqMNOquK0NnYEjbH/c3aLrCrIDjWCu+uWNdYZocRBUoCUrVCE1pSdaq0vI+MQ/KgHE4I+OA==
X-Received: by 2002:a05:6214:29c6:b0:70d:c4cf:66dd with SMTP id 6a1803df08f44-70dc4cf67ebmr95365266d6.20.1756294898028;
        Wed, 27 Aug 2025 04:41:38 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70dde332f06sm14730336d6.38.2025.08.27.04.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 04:41:37 -0700 (PDT)
Message-ID: <87956f34-e6b0-4d03-b30e-56be4f6b84f1@redhat.com>
Date: Wed, 27 Aug 2025 13:41:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: fix hugepages cleanup too early
To: Chunyu Hu <chuhu@redhat.com>, akpm@linux-foundation.org,
 shuah@kernel.org, linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
References: <20250827075209.2347015-1-chuhu@redhat.com>
 <20250827075209.2347015-2-chuhu@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250827075209.2347015-2-chuhu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.08.25 09:52, Chunyu Hu wrote:
> The nr_hugepgs variable is used to keep the original nr_hugepages at the
> hugepage setup step at test beginning. After userfaultfd test, a cleaup is
> executed, both /sys/kernel/mm/hugepages/hugepages-*/nr_hugepages and
> /proc/sys//vm/nr_hugepages are reset to 'original' value before userfaultfd
> test starts.
> 
> Issue here is the value used to restore /proc/sys/vm/nr_hugepages is
> nr_hugepgs which is the initial value before the vm_runtests.sh runs, not
> the value before userfaultfd test starts. 'va_high_addr_swith.sh' tests
> runs after that will possibly see no hugepages available for test, and got
> EINVAL when mmap(HUGETLB), making the result invalid.
> 
> And before pkey tests, nr_hugepgs is changed to be used as a temp variable
> to save nr_hugepages before pkey test, and restore it after pkey tests
> finish. The original nr_hugepages value is not tracked anymore, so no way
> to restore it after all tests finish.
> 
> Add a new variable nr_hugepgs_origin to save the original nr_hugepages, and
> and restore it to nr_hugepages after all tests finish. And change to use
> the nr_hugepgs variable to save the /proc/sys/vm/nr_hugeages after hugepage
> setup, it's also the value before userfaultfd test starts, and the correct
> value to be restored after userfaultfd finishes. The va_high_addr_switch.sh
> broken will be resolved.
> 
> Signed-off-by: Chunyu Hu <chuhu@redhat.com>
> ---
>   tools/testing/selftests/mm/run_vmtests.sh | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 471e539d82b8..f1a7ad3ec6a7 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -172,13 +172,13 @@ fi
>   
>   # set proper nr_hugepages
>   if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
> -	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
> +	nr_hugepgs_origin=$(cat /proc/sys/vm/nr_hugepages)

I'd call this "orig_nr_hugepgs".

But it's a shame that the naming is then out of sync with nr_size_hugepgs?


>   	needpgs=$((needmem_KB / hpgsize_KB))
>   	tries=2
>   	while [ "$tries" -gt 0 ] && [ "$freepgs" -lt "$needpgs" ]; do
>   		lackpgs=$((needpgs - freepgs))
>   		echo 3 > /proc/sys/vm/drop_caches
> -		if ! echo $((lackpgs + nr_hugepgs)) > /proc/sys/vm/nr_hugepages; then
> +		if ! echo $((lackpgs + nr_hugepgs_origin)) > /proc/sys/vm/nr_hugepages; then
>   			echo "Please run this test as root"
>   			exit $ksft_skip
>   		fi
> @@ -189,6 +189,7 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
>   		done < /proc/meminfo
>   		tries=$((tries - 1))
>   	done
> +	nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
>   	if [ "$freepgs" -lt "$needpgs" ]; then
>   		printf "Not enough huge pages available (%d < %d)\n" \
>   		       "$freepgs" "$needpgs"
> @@ -532,6 +533,10 @@ CATEGORY="page_frag" run_test ./test_page_frag.sh aligned
>   
>   CATEGORY="page_frag" run_test ./test_page_frag.sh nonaligned
>   
> +if [ "${HAVE_HUGEPAGES}" = 1 ]; then
> +	echo "$nr_hugepgs_origin" > /proc/sys/vm/nr_hugepages
> +fi

FWIW, I think the tests should maybe be doing that 
(save+configure+restore) themselves, like we do with THP settings through.

thp_save_settings()
thp_write_settings()

and friends.

This is not really something run_vmtests.sh should bother with.

A bigger rework, though ...

-- 
Cheers

David / dhildenb


