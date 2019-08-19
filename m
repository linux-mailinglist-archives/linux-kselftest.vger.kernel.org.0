Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3980D94EB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2019 22:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfHSUH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Aug 2019 16:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfHSUH4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Aug 2019 16:07:56 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4AF0206C1;
        Mon, 19 Aug 2019 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566245275;
        bh=9qErU7zoZi/gN4TKy6hFAtqTwhsJ2c7jCan+McstIBw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fv24PsTskgvfwGqWTPvrgXRWHaotE4vHz50rjxRu7bW0Bu9hPro+ombpEMF8EGex5
         vZuWKj72hKa0WU39JwwPRaalNsipkjVOH9Mqwo9R6YSiAgqFMK847ndFkE3P4a/Zgp
         cNWZCFjoPykhaUY+30WK2fXVNZj3uv2GfZa5bH48=
Subject: Re: [PATCH] selftests: use "$(MAKE)" instead of "make"
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, shuah <shuah@kernel.org>
References: <20190816160604.61294-1-iii@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <138130b1-cecc-2e9d-757e-db28a3ad9028@kernel.org>
Date:   Mon, 19 Aug 2019 14:07:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816160604.61294-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/16/19 10:06 AM, Ilya Leoshkevich wrote:
> When doing "make kselftest TARGETS=bpf -j12", bpf progs end up being
> compiled sequentially and thus slowly.
> 
> The reason is that parent make (tools/testing/selftests/Makefile) does
> not share its jobserver with child make
> (tools/testing/selftests/bpf/Makefile), therefore the latter runs with
> -j1.
> 
> Change all instances of "make" to "$(MAKE)", so that the whole make
> hierarchy runs using a single jobserver.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> I tested this with:
> 
> 	make kselftest
> 	make -C tools/testing/selftests
> 	make -C tools/testing/selftests/bpf
> 
> Unfortunately, in my setup a lot of tests fail for a number of reasons.
> However, this change does not make it worse.
> 
> tools/testing/selftests/Makefile | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 25b43a8c2b15..c3feccb99ff5 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -126,9 +126,9 @@ endif
>   # in the default INSTALL_HDR_PATH usr/include.
>   khdr:
>   ifeq (1,$(DEFAULT_INSTALL_HDR_PATH))
> -	make --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
> +	$(MAKE) --no-builtin-rules ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   else
> -	make --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
> +	$(MAKE) --no-builtin-rules INSTALL_HDR_PATH=$$BUILD/usr \
>   		ARCH=$(ARCH) -C $(top_srcdir) headers_install
>   endif
>   
> @@ -136,35 +136,35 @@ all: khdr
>   	@for TARGET in $(TARGETS); do		\
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
>   		mkdir $$BUILD_TARGET  -p;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$TARGET;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
>   	done;
>   
>   run_tests: all
>   	@for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
>   	done;
>   
>   hotplug:
>   	@for TARGET in $(TARGETS_HOTPLUG); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$TARGET;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
>   	done;
>   
>   run_hotplug: hotplug
>   	@for TARGET in $(TARGETS_HOTPLUG); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$TARGET run_full_test;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_full_test;\
>   	done;
>   
>   clean_hotplug:
>   	@for TARGET in $(TARGETS_HOTPLUG); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
>   	done;
>   
>   run_pstore_crash:
> -	make -C pstore run_crash
> +	$(MAKE) -C pstore run_crash
>   
>   # Use $BUILD as the default install root. $BUILD points to the
>   # right output location for the following cases:
> @@ -184,7 +184,7 @@ ifdef INSTALL_PATH
>   	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
>   	@for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
>   	done;
>   
>   	@# Ask all targets to emit their test scripts
> @@ -203,7 +203,7 @@ ifdef INSTALL_PATH
>   		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
>   		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
>   		echo -n "run_many" >> $(ALL_SCRIPT); \
> -		make -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
> +		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
>   		echo "" >> $(ALL_SCRIPT);	    \
>   		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
>   	done;
> @@ -216,7 +216,7 @@ endif
>   clean:
>   	@for TARGET in $(TARGETS); do \
>   		BUILD_TARGET=$$BUILD/$$TARGET;	\
> -		make OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
> +		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
>   	done;
>   
>   .PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
> 

Thanks. I will apply this for 5.4-rc1

thanks,
-- Shuah
