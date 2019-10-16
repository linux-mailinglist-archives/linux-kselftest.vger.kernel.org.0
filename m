Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611C5D84DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 02:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbfJPAea (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 20:34:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38595 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfJPAe3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 20:34:29 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so51065882iom.5
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2019 17:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tdwxlxT49wwsw3Y93gmkZdThii7gARbRCcpafd1NUdM=;
        b=Fb3+ymMsLC3X/c4nMEm5ABAyVDRGKLXEp32XgnZlCt9QMHdQ5esQyxz/zVHnG2Dl6H
         UiJSDNUS98lN1j9AWQCmcL6VsIRdAoz/NftjzoGtSQq5xyxRiynABNXl+80hFxNmcRR4
         loywgVM85cs/VAKrzrgPnhiVb4X+gzsVT8paM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tdwxlxT49wwsw3Y93gmkZdThii7gARbRCcpafd1NUdM=;
        b=iEHR0x8m5LrRp0TXTXOeqknZ2ua/sPW7QXai1RUKn2z36xkGvbLPo9ULuyDaYIP1qy
         Qqi0GfZ/BNbQuE6zMioFMoXPwMcLfBWRzV4MbM1+eyAeSQBff+d2OkXDm1QV6Kg60zfM
         zlkRk3CB146bXawrw24JWAjc4FNqZET3M+LSW39kxLYW81BTjcYW1dSmbRFkxMKYGGKi
         cOb5l9HDIfSdkHPpipzH8xQlf1XBk0n/BEUZ61536Aud6igyolftoWUvMFhQvcngcxy0
         G+G43aP8qvn+i0tZ61cngjXtzjzfmC0PmWUnbHX/FgGT/8UrHTf/OjQxuHtjh4/HtwX2
         20Jw==
X-Gm-Message-State: APjAAAVnBsiBBLlvb6vQ27aC/r9CoItAKNVG8MDjJ+L+ktT/jglJb8lU
        vTEErIFvSwXYpBR9m/ibJzI/oiboGY0=
X-Google-Smtp-Source: APXvYqytf4csWmX79LuBLwD3/PG4NBtqeGgCFq87d1KcwuO6TlNGnQ0QsSVbcuWxMd/L/BjHtlLwHg==
X-Received: by 2002:a02:ce39:: with SMTP id v25mr45785770jar.58.1571186067111;
        Tue, 15 Oct 2019 17:34:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 80sm20513746iou.13.2019.10.15.17.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 17:34:26 -0700 (PDT)
Subject: Re: [PATCH] selftests: Fix O= and KBUILD_OUTPUT handling for relative
 paths
To:     Tim.Bird@sony.com, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        "skha >> Shuah Khan" <skhan@linuxfoundation.org>
References: <20191015014505.14259-1-skhan@linuxfoundation.org>
 <ECADFF3FD767C149AD96A924E7EA6EAF977CC2AB@USCULXMSG01.am.sony.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0ec9669e-98ce-4b1e-f98a-ce133dac724c@linuxfoundation.org>
Date:   Tue, 15 Oct 2019 18:34:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF977CC2AB@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/15/19 5:27 PM, Tim.Bird@sony.com wrote:
>> -----Original Message-----
>> From: Shuah Khan on  Monday, October 14, 2019 3:45 PM
>>
>> Fix O= and KBUILD_OUTPUT handling for relative paths.
>>
>> export KBUILD_OUTPUT=../kselftest_size
>> make TARGETS=size kselftest-all
>>
>> or
>>
>> make O=../kselftest_size TARGETS=size kselftest-all
>>
>> In both of these cases, targets get built in ../kselftest_size which is
>> a one level up from the size test directory.
>>
>> make[1]: Entering directory '/mnt/data/lkml/kselftest_size'
>> make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
>>          ARCH=x86 -C ../../.. headers_install
>>    INSTALL ../kselftest_size/usr/include
>> gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o
>> ../kselftest_size/size/get_size
>> /usr/bin/ld: cannot open output file ../kselftest_size/size/get_size: No such
>> file or directory
>> collect2: error: ld returned 1 exit status
>> make[3]: *** [../lib.mk:138: ../kselftest_size/size/get_size] Error 1
>> make[2]: *** [Makefile:143: all] Error 2
>> make[1]: *** [/mnt/data/lkml/linux_5.4/Makefile:1221: kselftest-all] Error 2
>> make[1]: Leaving directory '/mnt/data/lkml/kselftest_size'
>> make: *** [Makefile:179: sub-make] Error 2
>>
>> Use abs_objtree exported by the main Makefile.
>>
>> Reported-by: Tim Bird <Tim.Bird@sony.com>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   tools/testing/selftests/Makefile | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/Makefile
>> b/tools/testing/selftests/Makefile
>> index 4cdbae6f4e61..3405aa26a655 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -86,10 +86,10 @@ override LDFLAGS =
>>   endif
>>
>>   ifneq ($(O),)
>> -	BUILD := $(O)
>> +	BUILD := $(abs_objtree)
>>   else
>>   	ifneq ($(KBUILD_OUTPUT),)
>> -		BUILD := $(KBUILD_OUTPUT)/kselftest
>> +		BUILD := $(abs_objtree)/kselftest
>>   	else
>>   		BUILD := $(shell pwd)
>>   		DEFAULT_INSTALL_HDR_PATH := 1
>> @@ -102,6 +102,7 @@ include $(top_srcdir)/scripts/subarch.include
>>   ARCH           ?= $(SUBARCH)
>>   export KSFT_KHDR_INSTALL_DONE := 1
>>   export BUILD
>> +#$(info abd_objtree = $(abs_objtree) BUILD = $(BUILD))
>>
>>   # build and run gpio when output directory is the src dir.
>>   # gpio has dependency on tools/gpio and builds tools/gpio
>> --
> 
>   This works great.  Thanks very much.
> 
> Tested-by: Tim Bird <tim.bird@sony.com>
> Acked-by: Tim Bird <tim.bird@sony.com>
> 
>   -- Tim
> 
Thanks for testing. Will get this into 5.4-rc4

thanks,
-- SHuah
