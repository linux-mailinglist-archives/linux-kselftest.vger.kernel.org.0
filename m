Return-Path: <linux-kselftest+bounces-2626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEDE82377B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 23:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FBB2103B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jan 2024 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5291DA34;
	Wed,  3 Jan 2024 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRDjHM81"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F81DDE9
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jan 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35d374bebe3so5269155ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Jan 2024 14:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704319762; x=1704924562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=te2PH2Kdt4cQrnvMOmJ454BBecoYeY1JOfYpAxEXWxY=;
        b=NRDjHM81w/sZiM8JrKwggU2qq7U5V4q/crH6ON1yBYTp2vZZhLcgkLmmUv9mGCkTqQ
         NOAUtvVjPVSJmK3wmDU5BnUXP9dHxDKOlvhhwrLcVk2gmrTFm1HyUj9H/hGEzoOdvyXd
         zZ7QvoiOd617OtYbSpl8eMXtzaJnS7Xa5Gkaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704319762; x=1704924562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=te2PH2Kdt4cQrnvMOmJ454BBecoYeY1JOfYpAxEXWxY=;
        b=TlRUjOV7d3sxtPr7PLbR7bC9jnqK9XPIREy/z26o6M1IJ6aHHyimEc2j50xPEhUyC4
         CkoTVaE+JHKM16hgDKznTlPWSdXGoWBzupe+S3RjbWv6rskMoWZTs3QRkO3nhW+ShznD
         yMLHetI9GfktgbYDwKbFgcj72LJ3jQztU6Sbx2koZlsUUktBVkI9d7mWolSR7S+WnEv2
         dV2L9On/qgt7p5V4FUYiRTXiuNDevbhvv3WnBAqcJAsjiEPcGVmuczkdYvSOo0IU2/Fc
         2QHU9btSC9kV7oI8mxP2geJjaxKeekLDgoVkXclEJQT7tlC1jaS4JczacznO4O+Ly+bD
         SKeQ==
X-Gm-Message-State: AOJu0YxZ1fPJuXVSYnTGZqjl4rpoSWEfpLCJHwbNCclDxv+jhtyExGIm
	iFjqAK0rocIheK0QzsrC7qMP2sfVDIpZIA==
X-Google-Smtp-Source: AGHT+IFaaY5Skh+o7ny4ui5W9ZhTFlM4FEgUH0yIGmZMDbedaycTOwiYk25gWja3CQeLGAKe5kxYVg==
X-Received: by 2002:a05:6602:2190:b0:7ba:a0f9:7660 with SMTP id b16-20020a056602219000b007baa0f97660mr30672565iob.1.1704319762050;
        Wed, 03 Jan 2024 14:09:22 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bq11-20020a056638468b00b0046dd22fd24csm1096998jab.87.2024.01.03.14.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:09:21 -0800 (PST)
Message-ID: <4fb169fd-393c-441e-b0f7-32a3777c1d11@linuxfoundation.org>
Date: Wed, 3 Jan 2024 15:09:20 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR
 variable
Content-Language: en-US
To: Joe Lawrence <joe.lawrence@redhat.com>,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, live-patching@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
 <20231220-send-lp-kselftests-v4-1-3458ec1b1a38@suse.com>
 <ZZSOtsbzpy2mvmUC@redhat.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZZSOtsbzpy2mvmUC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/2/24 15:31, Joe Lawrence wrote:
> On Wed, Dec 20, 2023 at 01:53:12PM -0300, Marcos Paulo de Souza wrote:
>> Add TEST_GEN_MODS_DIR variable for kselftests. It can point to
>> a directory containing kernel modules that will be used by
>> selftest scripts.
>>
>> The modules are built as external modules for the running kernel.
>> As a result they are always binary compatible and the same tests
>> can be used for older or newer kernels.
>>
>> The build requires "kernel-devel" package to be installed.
>> For example, in the upstream sources, the rpm devel package
>> is produced by "make rpm-pkg"
>>
>> The modules can be built independently by
>>
>>    make -C tools/testing/selftests/livepatch/
>>
>> or they will be automatically built before running the tests via
>>
>>    make -C tools/testing/selftests/livepatch/ run_tests
>>
>> Note that they are _not_ built when running the standalone
>> tests by calling, for example, ./test-state.sh.
>>
>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>> ---
>>   Documentation/dev-tools/kselftest.rst |  4 ++++
>>   tools/testing/selftests/lib.mk        | 20 +++++++++++++++-----
>>   2 files changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
>> index ab376b316c36..7f3582a67318 100644
>> --- a/Documentation/dev-tools/kselftest.rst
>> +++ b/Documentation/dev-tools/kselftest.rst
>> @@ -245,6 +245,10 @@ Contributing new tests (details)
>>      TEST_PROGS, TEST_GEN_PROGS mean it is the executable tested by
>>      default.
>>   
>> +   TEST_GEN_MODS_DIR should be used by tests that require modules to be built
>> +   before the test starts. The variable will contain the name of the directory
>> +   containing the modules.
>> +
>>      TEST_CUSTOM_PROGS should be used by tests that require custom build
>>      rules and prevent common build rule use.
>>   
>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
>> index 118e0964bda9..6c7c5a0112cf 100644
>> --- a/tools/testing/selftests/lib.mk
>> +++ b/tools/testing/selftests/lib.mk
>> @@ -70,12 +70,15 @@ KHDR_INCLUDES := -isystem $(KHDR_DIR)
>>   # TEST_PROGS are for test shell scripts.
>>   # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common run_tests
>>   # and install targets. Common clean doesn't touch them.
>> +# TEST_GEN_MODS_DIR is used to specify a directory with modules to be built
>> +# before the test executes. These modules are cleaned on the clean target as well.
>>   TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>>   TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>>   TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
>> +TEST_GEN_MODS_DIR := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_MODS_DIR))
>>   
>>   all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
>> -     $(TEST_GEN_FILES)
>> +     $(TEST_GEN_FILES) $(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
>>   
>>   kernel_header_files:
>>   	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
>> @@ -105,8 +108,8 @@ endef
>>   
>>   run_tests: all
>>   ifdef building_out_of_srctree
>> -	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
>> -		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
>> +	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)$(TEST_GEN_MODS_DIR)" != "X" ]; then \
>> +		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(TEST_GEN_MODS_DIR) $(OUTPUT); \
>>   	fi
>>   	@if [ "X$(TEST_PROGS)" != "X" ]; then \
>>   		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
>> @@ -118,6 +121,12 @@ else
>>   	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
>>   endif
>>   
>> +gen_mods_dir:
>> +	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)
>> +
>> +clean_mods_dir:
>> +	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean
>> +
>>   define INSTALL_SINGLE_RULE
>>   	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
>>   	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
>> @@ -131,6 +140,7 @@ define INSTALL_RULE
>>   	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
>>   	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
>>   	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
>> +	$(eval INSTALL_LIST = $(TEST_GEN_MODS_DIR)) $(INSTALL_SINGLE_RULE)
> 
> Hi Marcos,
> 
> Sorry for the late reply on this, but I'm reviewing this version by
> trying to retrofit it into our selftest packaging (pre-build the test
> module .ko's and stash those into an rpm rather than building on the
> test host).
> 
> Since $TEST_GEN_MODS_DIR is treated as a directory, I found that the
> selftest install target copies a bunch of intermediate object and kbuild
> files:
> 
>    $ mkdir /tmp/test-install
>    $ make KDIR=$(pwd) INSTALL_PATH=/tmp/test-install TARGETS=livepatch \
>         -C tools/testing/selftests/ install
> 
>    [ ... builds livepatch selftests ... ]
> 
> the rsync in question:
> 
>    rsync -a --copy-unsafe-links /home/jolawren/src/kernel/tools/testing/selftests/livepatch/test_modules /tmp/test-install/livepatch/
>    ...
> 
> and then looking at the destination:
> 
>    $ tree -a /tmp/test-install/
>    /tmp/test-install/
>    ├── kselftest
>    │   ├── module.sh
>    │   ├── prefix.pl
>    │   └── runner.sh
>    ├── kselftest-list.txt
>    ├── livepatch
>    │   ├── config
>    │   ├── functions.sh
>    │   ├── settings
>    │   ├── test-callbacks.sh
>    │   ├── test-ftrace.sh
>    │   ├── test_klp-call_getpid
>    │   ├── test-livepatch.sh
>    │   ├── test_modules
>    │   │   ├── Makefile
>    │   │   ├── modules.order
>    │   │   ├── .modules.order.cmd
>    │   │   ├── Module.symvers
>    │   │   ├── .Module.symvers.cmd
>    │   │   ├── test_klp_atomic_replace.c
>    │   │   ├── test_klp_atomic_replace.ko
>    │   │   ├── .test_klp_atomic_replace.ko.cmd
>    │   │   ├── test_klp_atomic_replace.mod
>    │   │   ├── test_klp_atomic_replace.mod.c
>    │   │   ├── .test_klp_atomic_replace.mod.cmd
>    │   │   ├── test_klp_atomic_replace.mod.o
>    │   │   ├── .test_klp_atomic_replace.mod.o.cmd
>    │   │   ├── test_klp_atomic_replace.o
>    │   │   ├── .test_klp_atomic_replace.o.cmd
>    ...
> 
> On the other hand, variables like $TEST_GEN_FILES specify individual
> files, so only final binaries like test_klp-call_getpid (and not
> test_klp-call_getpid.c) are copied to $INSTALL_PATH.


Thank you Joe for finding this problem.

Copying source files and object files doesn't sound right. This isn't
how the ksleftest installs work. Let's fix this.

thanks,
--Shuah


