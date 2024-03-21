Return-Path: <linux-kselftest+bounces-6463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E8885A62
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 15:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4111F22578
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D8484FBC;
	Thu, 21 Mar 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gN3Ga45N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D184FB0
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030092; cv=none; b=TmaYfPTWmlZJr9Nr+nTfI1F80gLeQYtVdp2bnBlT01HF/8ET1wqF5PSAjLHgI6yn7W4+29WLN1YA7bD/jJ9eQjQd8QsHPVukpYuuZXrnr8Os1lS/dBowAi5Z+TWLKP8megXfdtS02IDNTxzAiR/0EXVRnjn1Mgb6DAzlkMDWqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030092; c=relaxed/simple;
	bh=QGtU3voANvgiuJJEXu/In7OqOdpLhXPTl/N949TQFKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKftFMcwJiVIw1g2JeQNn8VD4nGSm7yL2J2cqqi0PaHsWzFdEZP98EAZz6MzCMOxBCAWcZASQVLvAMGnaC108Ty5KlmNRgVMiibg1KM3fq33/XN+G5GBOcN1ZYK8PyNA8d44qx/KjHMW/ZnDbZ9npY6Dq+h1QUd8LrvygJOkcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gN3Ga45N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711030089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGt0hq38PgC+ets/mWtoTDv2O0j1R9kFJsbjJf3FOO8=;
	b=gN3Ga45NuYEyOyuaNF5OvwNF05rUJw3xPI1ByMqvTjxlosEktWdS2LfnZPrSxxKHWc5+Nb
	mDlQBtsS7bp+VZ8Nv8y7s7uqT3Ce+xC/XM+9Fj9QGpPI/xhjT2jk7Q7OjJ2BpQasPG4KqL
	F55wUvv76zHMHDJfQ4mfCazmUVpDFbU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-5y2lgekWPdSbWfKwWdmlsQ-1; Thu, 21 Mar 2024 10:08:07 -0400
X-MC-Unique: 5y2lgekWPdSbWfKwWdmlsQ-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-789eaa86ed9so92019985a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Mar 2024 07:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030087; x=1711634887;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGt0hq38PgC+ets/mWtoTDv2O0j1R9kFJsbjJf3FOO8=;
        b=qhARuAVMGKxaCi0pAccdeQbUQasMMstIORJBfaT+ipOOlIPDYfocFJVu+xHVuaMZNK
         I8/QeevN9Z4sZiUTENyX54ARVSq1WicxMIgtROIVaDz5d0RzcSulr//IosMi3mbqPywt
         OMME3t4F0Aud7yAAQXugk2Si+Qksb+CVbvLZNR13NLy5yyvRR/WxbeF/wlCyEzjrTrGA
         pdXR18vryy9kDNpF9ztjHqyI1TS+dzypUwNk/z4t5XZsWPdYhNjpJJZzS5W7fMOdoNXb
         KHE14A7DAgmTsJTBkG7Yu4kxAq2bte3wUr5/P7gKozeX6+hvjx9b1NpEZkIb2CJcQNIn
         gEww==
X-Forwarded-Encrypted: i=1; AJvYcCXnwIlq46FsiwT+ylvNoQx1kepHyg2BoE3kArf4UFBdMaU7H9vGfOBkbiftfUscXApbFSeUnoG97e5qf9w3rFgYiJv9xm41yB8ZsX9OcssM
X-Gm-Message-State: AOJu0YyLzqib7697VTD53mpjHRoW1l06AffxpLyV2ZZo5o8fy9LCu9Ax
	ndOWnxRPDsVDouGmL9oa9ahKU5Q4i5P10cet7fWBAlAz5vjy21mk/NejI4jrRUMe93m8PxTsucA
	euxak+m5AFKjh6UHD/J70CM3TdROdrEUIvBSEjhl5H+THth85KSb4mhwhRuHjIvvDPg==
X-Received: by 2002:a05:620a:5a5c:b0:78a:342e:12d3 with SMTP id wx28-20020a05620a5a5c00b0078a342e12d3mr1027474qkn.34.1711030087169;
        Thu, 21 Mar 2024 07:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEyVW4WJN5XQZi5kxd7nWPRN8JSQDwuKljyarECMCnFkbh6fgxTipnCqkUOA0LcKVcJLLlfw==
X-Received: by 2002:a05:620a:5a5c:b0:78a:342e:12d3 with SMTP id wx28-20020a05620a5a5c00b0078a342e12d3mr1027449qkn.34.1711030086859;
        Thu, 21 Mar 2024 07:08:06 -0700 (PDT)
Received: from [192.168.1.24] (pool-68-160-135-240.bstnma.fios.verizon.net. [68.160.135.240])
        by smtp.gmail.com with ESMTPSA id e7-20020a05620a12c700b00789ea49fd22sm5449407qkl.49.2024.03.21.07.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 07:08:06 -0700 (PDT)
Message-ID: <56bf6323-9e9b-a0e3-f505-d628aac793d4@redhat.com>
Date: Thu, 21 Mar 2024 10:08:05 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests: livepatch: Test atomic replace against
 multiple modules
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240312-lp-selftest-new-test-v1-1-9c843e25e38e@suse.com>
From: Joe Lawrence <joe.lawrence@redhat.com>
In-Reply-To: <20240312-lp-selftest-new-test-v1-1-9c843e25e38e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/24 08:12, Marcos Paulo de Souza wrote:
> This new test checks if a livepatch with replace attribute set replaces
> all previously applied livepatches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  tools/testing/selftests/livepatch/Makefile         |  3 +-
>  .../selftests/livepatch/test-atomic-replace.sh     | 71 ++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index 35418a4790be..e92f61208d35 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -10,7 +10,8 @@ TEST_PROGS := \
>  	test-state.sh \
>  	test-ftrace.sh \
>  	test-sysfs.sh \
> -	test-syscall.sh
> +	test-syscall.sh \
> +	test-atomic-replace.sh
>  
>  TEST_FILES := settings
>  
> diff --git a/tools/testing/selftests/livepatch/test-atomic-replace.sh b/tools/testing/selftests/livepatch/test-atomic-replace.sh
> new file mode 100755
> index 000000000000..09a3dcdcb8de
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-atomic-replace.sh
> @@ -0,0 +1,71 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2024 SUSE
> +# Author: Marcos Paulo de Souza <mpdesouza@suse.com>
> +
> +. $(dirname $0)/functions.sh
> +
> +MOD_REPLACE=test_klp_atomic_replace
> +
> +setup_config
> +
> +# - Load three livepatch modules.
> +# - Load one more livepatch with replace being set, and check that only one
> +#   livepatch module is being listed.
> +
> +start_test "apply one liveptach to replace multiple livepatches"
> +
> +for mod in test_klp_livepatch test_klp_syscall test_klp_callbacks_demo; do
> +	load_lp $mod
> +done
> +
> +nmods=$(ls /sys/kernel/livepatch | wc -l)
> +if [ $nmods -ne 3 ]; then
> +	die "Expecting three modules listed, found $nmods"
> +fi
> +
> +load_lp $MOD_REPLACE replace=1
> +
> +nmods=$(ls /sys/kernel/livepatch | wc -l)
> +if [ $nmods -ne 1 ]; then
> +	die "Expecting only one moduled listed, found $nmods"
> +fi
> +
> +disable_lp $MOD_REPLACE
> +unload_lp $MOD_REPLACE
> +
> +check_result "% insmod test_modules/test_klp_livepatch.ko
> +livepatch: enabling patch 'test_klp_livepatch'
> +livepatch: 'test_klp_livepatch': initializing patching transition
> +livepatch: 'test_klp_livepatch': starting patching transition
> +livepatch: 'test_klp_livepatch': completing patching transition
> +livepatch: 'test_klp_livepatch': patching complete
> +% insmod test_modules/test_klp_syscall.ko
> +livepatch: enabling patch 'test_klp_syscall'
> +livepatch: 'test_klp_syscall': initializing patching transition
> +livepatch: 'test_klp_syscall': starting patching transition
> +livepatch: 'test_klp_syscall': completing patching transition
> +livepatch: 'test_klp_syscall': patching complete
> +% insmod test_modules/test_klp_callbacks_demo.ko
> +livepatch: enabling patch 'test_klp_callbacks_demo'
> +livepatch: 'test_klp_callbacks_demo': initializing patching transition
> +test_klp_callbacks_demo: pre_patch_callback: vmlinux
> +livepatch: 'test_klp_callbacks_demo': starting patching transition
> +livepatch: 'test_klp_callbacks_demo': completing patching transition
> +test_klp_callbacks_demo: post_patch_callback: vmlinux
> +livepatch: 'test_klp_callbacks_demo': patching complete
> +% insmod test_modules/test_klp_atomic_replace.ko replace=1
> +livepatch: enabling patch 'test_klp_atomic_replace'
> +livepatch: 'test_klp_atomic_replace': initializing patching transition
> +livepatch: 'test_klp_atomic_replace': starting patching transition
> +livepatch: 'test_klp_atomic_replace': completing patching transition
> +livepatch: 'test_klp_atomic_replace': patching complete
> +% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
> +livepatch: 'test_klp_atomic_replace': initializing unpatching transition
> +livepatch: 'test_klp_atomic_replace': starting unpatching transition
> +livepatch: 'test_klp_atomic_replace': completing unpatching transition
> +livepatch: 'test_klp_atomic_replace': unpatching complete
> +% rmmod test_klp_atomic_replace"
> +
> +exit 0
> 

Hi Marcos,

I'm not against adding a specific atomic replace test, but for a quick
tl/dr what is the difference between this new test and
test-livepatch.sh's "atomic replace livepatch" test?

If this one provides better coverage, should we follow up with removing
the existing one?

-- 
Joe


