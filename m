Return-Path: <linux-kselftest+bounces-5096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCF285CCA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D591C21A9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483B0A47;
	Wed, 21 Feb 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGmgz4In"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5EA3F
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Feb 2024 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474799; cv=none; b=SwG6qvB3XAz4ajN1nPF9MDw8kIW51YnQQA0SD4MadNSUJFODEIlk1MtDt1t2vcD+/4TLpWTJ4jFmUVW9ZxLq+JlpVIQukws/7NKIoowfbzpPb3J9qjLh0u3kvXxlNkwV5iQv/6nx7EE5vk0iOLTGCXpsLyu8pgedsZ3YKI73POk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474799; c=relaxed/simple;
	bh=K7QkEMeFgCEOBDdteVUHDL15AVxzWVVyz5SmmokOZXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSPsd3eLmMCj2VAA1Tu4zuB7qnQ5eJInkhSC9qx9TngaCEgaznp0+5jnBs3ikYo99n5FOLSbVdfRboqdlcIV+sCJiAB7tQ5TMo4vPohk/2TtzVl7VXjpiPpcaaZqtRgEtMU2489v7Cz8poepSPZze0heDBEZSw8tnL1pZc7AlpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGmgz4In; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso99597839f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 16:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708474796; x=1709079596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1SSchokFBeolQFf43F1Ki91lkNWxa302wO4DNZKIww8=;
        b=ZGmgz4InfEOdPa4mtx0gqh8QkxsZbhOmJeVjxYaB+LKKYiQHYVu2v8wK0eki469hUp
         sdh8TGch/eG9NHkPfsm8VVXCBDe7F27k46EpRzNErcdiNmkR/HSXhVmZVZHeAzv+MmFv
         WjtKjbvDCcsUSg2hRfQTuRfDlrSbcexNclV88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474796; x=1709079596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SSchokFBeolQFf43F1Ki91lkNWxa302wO4DNZKIww8=;
        b=efIPli+qSk4sfRjYeYMv35HW/JgMnbAQew1LTsnfFYGBVKWH22+ECIq9ygPXmRvfHa
         5uTm6SpHKiDiMeLS4LoYqZNAnDiyQ7XEjgYfyXsPSQUT1Gbw3AMZUaq+Gitsz4Wuon2S
         ASjyKjjOAZ4BTxXmWsTuage2xD4IUEbYNFEiDFsb8uu1h/H24DDT84ZWvIkJVdhUS4VA
         9paOcpbP9j70btjx9WNkbqckgsHKDmFsMTRz13GmvSaHfjkd/UlWYmDyAisnYnv261f3
         mBSyB/1r8zrva5q0q7xUqxdS+OaqgnjdIRnNiyO/vtcL4/9x9Y7Gv1jK9kgb3QjN+gwZ
         Q/XA==
X-Forwarded-Encrypted: i=1; AJvYcCWzZz729SM7hUF5TogBSNX6Oy85SgLS/SCk5QAcKKEjWAwKiSRAtL5TrDocldIIoklsIa/henMvhHlKjqx4e4Kjn3/25ZWxsnmqDlGih19W
X-Gm-Message-State: AOJu0YyrOoTPPb08h97HRG3RifO2OjPh+W6I4kIgSL5WOngg58eYjxkt
	n1lg7MzLvmvF8iiviUZ2Ec0RRoU8/aJj8zNDumdQSlp4jie7J3ncR1YBb194SQA=
X-Google-Smtp-Source: AGHT+IHjKllnuZm8GTJktzvD7k1+Fmvk1+TpjJvDUR7WXcS/dDJj3/rdo98ETt9VO7T5uUrGvECeJg==
X-Received: by 2002:a05:6602:f15:b0:7c7:28f7:cc81 with SMTP id hl21-20020a0566020f1500b007c728f7cc81mr11052980iob.1.1708474795830;
        Tue, 20 Feb 2024 16:19:55 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d5-20020a056602280500b007c73e9033fcsm1884269ioe.2.2024.02.20.16.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:19:55 -0800 (PST)
Message-ID: <c3ee4083-fca7-43cc-b955-3b7e4faed2b0@linuxfoundation.org>
Date: Tue, 20 Feb 2024 17:19:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 oe-kbuild-all@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240219135325.2280-1-mpdesouza@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240219135325.2280-1-mpdesouza@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 06:53, Marcos Paulo de Souza wrote:
> On Mon, 19 Feb 2024 09:15:15 -0300 Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> 
>> On Mon, 19 Feb 2024 14:35:16 +0800 kernel test robot <lkp@intel.com> wrote:
>>
>>> Hi Marcos,
>>>
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on 345e8abe4c355bc24bab3f4a5634122e55be8665]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Marcos-Paulo-de-Souza/selftests-lib-mk-Do-not-process-TEST_GEN_MODS_DIR/20240216-021601
>>> base:   345e8abe4c355bc24bab3f4a5634122e55be8665
>>> patch link:    https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-1-89f4a6f5cddc%40suse.com
>>> patch subject: [PATCH 1/3] selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240219/202402191417.XULH88Ct-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> make[3]: *** /lib/modules/5.9.0-2-amd64/build: No such file or directory.  Stop.
>>
>> We should ask the kernel test robot machine owners to install kernel-devel
>> package in order to have this fixed.
> 
> Or maybe ask them to change the reproducer to specify KDIR to the git tree,
> instead of /lib/modules/?
> 

This would be a regression to automated test rings. Do you have any other
solutions?

We could remove livepatch from default test until these changes are made
to test ring environments?

thanks,
-- Shuah


