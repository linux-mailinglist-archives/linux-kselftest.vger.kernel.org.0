Return-Path: <linux-kselftest+bounces-5216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46785E5F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 19:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0974B2288F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ECE85276;
	Wed, 21 Feb 2024 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Im7AT0YG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547285295
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540024; cv=none; b=JGZm0alcM9Wq1TnVZo0FTE+Ovv8pWc2MZCtTk4NTr9NSMxvRXdi9nkh4yzup4EWB+vP4vMJw02Z//I2bvqfZou36DJZ/ke1wgsN9Jv87xfbCd0/mlj8qtYRkDl35kDZGcQXSNqvT7mYnpwXqShDazBJr1UGQMsk/XibfHF0dMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540024; c=relaxed/simple;
	bh=6VC1qcHGtWcfwYOSabJJ8ZSmJ/99a6jDL4crh0KLPVk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=BumUO46USAwg8sdrFk9sR2HLCWN/UegicIQU8iKSr4i1lvYj7EKPwwEBwXbNxKt8mEu5Pkhva6n75eZpsDaQMwo4Xv28uCtnFNBs7KELCjDbaFxxDkUx4bYjHsBP+MPy3124H3czpkuxFVMk1TNPuz8lLMzf8ATXD87kynUcUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Im7AT0YG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708540021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEojIl750TYVuyYtzldN9G7sEW6mfeIF1z8MGEw+SFo=;
	b=Im7AT0YGBHxZk5o0w/ZWYkxkljVOjgwyidwxR2FydygDfFekdGJ9/BpSDp2VQCU2w8gzvq
	ZeEVno5f2583h1KTUrGKBzjI/cYLyiNvV83mCeX2sUgTYDdPwX2BafBmNm9eeUWDrF33hd
	n8mGUCysHq+HyXxQhZXUL3vAaaMviiw=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-DQEm3-9cNPasujumK5T1ng-1; Wed, 21 Feb 2024 13:27:00 -0500
X-MC-Unique: DQEm3-9cNPasujumK5T1ng-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4cc41f459afso1005272e0c.3
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 10:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708540019; x=1709144819;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEojIl750TYVuyYtzldN9G7sEW6mfeIF1z8MGEw+SFo=;
        b=o8VIrtS45M8bgmzr9YmsdNtnshkrpfytXa8SUmjcM6DtP/R/EuONVHXx/qr+U2dHeb
         9rm/1GZLGXrCgMt72+Hq0T9oRApGz0kkmhAH0oaViQWRFAdUrjefOXq61sveQQdrh0C6
         6Coi+Q8uBJynRjd+MLmlYbJaP1hKRjWVobs9M+skwmTBG9nnqP8P2xgXbXHCUXwE4SYS
         mQlfe3df8mmYPGBaOqKt4RDvwRQkudea+SZkn9kA1Z2ke1PuegHQWT3PfNaKLE8EYeCY
         hPeRPiyffk1IT3bO6Udkuo2qCuRvGzc4nFWWmE2i7pG4D78dxA7it3EsfUKJXinbJJPy
         C+5A==
X-Forwarded-Encrypted: i=1; AJvYcCWuSsKiKhVGcxbJ9hxcQEis5J/eEubzeNupR5U2PAygCoQoPXRUEfELaXH0NZzDHrnMh5cfKFvllLGQIo/htDmSZ+uTKPDTRssYmY6HRJGG
X-Gm-Message-State: AOJu0YyKG4C/e25tkQaotgQ3PKu071qd1M17Ug5IV0BPEBA9oI4yR4Ff
	dAAUDhTiIxghcBpnDPpCqZC/x/9X9Ffq/ci7BSvDr1hfhicoJW7KMqp5hSSOz38U4uQvzpXMNI4
	WrM3TCCkNPPvGa1+dCbEJH0TERuKDh6wmMpDx+KX+OgJuNJ6YoNEHPbRsmgq/1l7GEA==
X-Received: by 2002:a05:6122:4f05:b0:4d1:34a1:c887 with SMTP id gh5-20020a0561224f0500b004d134a1c887mr3318945vkb.9.1708540019327;
        Wed, 21 Feb 2024 10:26:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVeAkg3MpsRAS/vobA8hq7pIispK+lnPkq/9Wp7nPrxR6fPAfqKmvjqwfiX/cWcrVq6/8GSQ==
X-Received: by 2002:a05:6122:4f05:b0:4d1:34a1:c887 with SMTP id gh5-20020a0561224f0500b004d134a1c887mr3318929vkb.9.1708540018987;
        Wed, 21 Feb 2024 10:26:58 -0800 (PST)
Received: from [192.168.1.35] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id ny13-20020a056214398d00b006862b537412sm5803551qvb.123.2024.02.21.10.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 10:26:58 -0800 (PST)
Message-ID: <88672d5a-1b12-a6f2-bf7b-8670eeddc711@redhat.com>
Date: Wed, 21 Feb 2024 13:26:57 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Nicolai Stange <nstange@suse.de>,
 Shresth Prasad <shresthprasad7@gmail.com>
Cc: zhangwarden@gmail.com, jikos@kernel.org, jpoimboe@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 live-patching@vger.kernel.org, mbenes@suse.cz, mpdesouza@suse.com,
 pmladek@suse.com, shuah@kernel.org, skhan@linuxfoundation.org
References: <ff1078b2-447d-4ae7-8287-d0affd23588d@gmail.com>
 <22981.124022107441100115@us-mta-655.us.mimecast.lan>
From: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH] Fix implicit cast warning in test_klp_state.c
In-Reply-To: <22981.124022107441100115@us-mta-655.us.mimecast.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/21/24 07:44, Nicolai Stange wrote:
> Shresth Prasad <shresthprasad7@gmail.com> writes:
> 
>> I checked the source code and yes I am on the latest Linux next repo.
>>
>> Here's the warning:
>> /home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/test_modules/test_klp_state.c:38:24: warning: assignment to ‘struct klp_state *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
>>    38 |         loglevel_state = klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
>>       |                        ^
> 
> 
> Is the declaration of klp_get_state() visible at that point, i.e. is
> there perhaps any warning about missing declarations above that?
> 
> Otherwise C rules would default to assume an 'int' return type.
> 

This is an interesting clue.  I thought I might be able to reproduce the
build error by modifying include/livepatch.h and running `make -j15 -C
tools/testing/selftests/livepatch` ... but that seemed to work fine on
my system.  I even removed the entire include/ subdir from my tree and
it still built the test module.  Huh?

Then I moved /lib/modules/$(uname -r)/build out of the way and saw that
the compilation failed.  Ah hah -- that's right, it's using the system
build tree.  That version of livepatch.h may have a missing or
completely different definition of klp_get_state().

How does this sequence work for you, Shresth:

  # Verify that kernel livepatching is turned on
  $ grep LIVEPATCH .config
  CONFIG_HAVE_LIVEPATCH=y
  CONFIG_LIVEPATCH=y

  # Build linux-next kernel tree and then the livepatch selftests,
  # pointing KDIR to this tree
  $ make -j$(nproc) vmlinux && \
    make -j$(nproc) KDIR=$(pwd) -C tools/testing/selftests/livepatch

-- 
Joe


