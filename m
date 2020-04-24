Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3321B7DDE
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Apr 2020 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgDXS3N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Apr 2020 14:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727033AbgDXS3M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Apr 2020 14:29:12 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E05EC09B049
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 11:29:12 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r2so10191455ilo.6
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Apr 2020 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o3ECeOnWmOOIX7JhONBpTDrU6V2RncHpVLywz33DaM0=;
        b=B1/5SqL0yLaKdQZ0nVzCSET6KOFzOezDBatJbZRoANF6iAyGl68o1Z4bZsudRV09sh
         PnubkcySFifqXIcbIugrfnLPzy1jXIU1LJb6B1TxJAJ454iWUvnlc8zRMNJc0wZm8QNO
         luAsBYEmRZSzphToZbUw8440p0nnXREQkeZuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3ECeOnWmOOIX7JhONBpTDrU6V2RncHpVLywz33DaM0=;
        b=Y/NcuqlpZUfw4xMMksNd4NMByZOg4YEsKyRbVXDs8WCkasyxpzmsfMzxI3lfUb8eLa
         ZBNy6ybSjnh+xfZBq7zSK3NDXCGh8jT8AIQdkd3hwweXlssz7p/23bRw69QEt4c3Wv8a
         D6e3Kh0QDIaAb0WXW0xEM3cv0u8x6mhAXFqrcwegFl7/NNgJS6kGFhBft4CzmJ/Vo5/y
         CTpT1SWyNTYmVdY9yFCW72hNkMpNVhuWWhBKKLz63fZ0jeT4tTYWzksHWSO4aEdFytw2
         yCbDvwtJkuQHOmKLVQGQpSaVlAfEDKwcHF3k5qw8HIhao+/1e1NN42kfzO37kkitqENo
         Wj+w==
X-Gm-Message-State: AGi0PuaMb553n6XXdTLWiM8RfPj5QDtHa/tfXa267YRzTlTKheFWAEWT
        4rzswe9dEjvoZbP3ze7ZvlzpWQ==
X-Google-Smtp-Source: APiQypL779N+IIt95hyM/PzjM4PPg8knZ/jgyJ3ubr7vLM8Nr7bmHptbylBBO3nXHUcwZ+5v2tR6tA==
X-Received: by 2002:a92:d846:: with SMTP id h6mr8165453ilq.248.1587752951431;
        Fri, 24 Apr 2020 11:29:11 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l14sm2047083ioj.12.2020.04.24.11.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:29:10 -0700 (PDT)
Subject: Re: [PATCH] selftests: add build/cross-build dependency check script
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bamv2005@gmail.com" <bamv2005@gmail.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200414212208.21667-1-skhan@linuxfoundation.org>
 <374866ac-4519-f367-bdc6-ec8d0c1b6347@infradead.org>
 <CY4PR13MB1527A6A6F9BCEADAF14A3C6BFDD00@CY4PR13MB1527.namprd13.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <177a6b62-630d-7b30-dbb6-7e6ca7054790@linuxfoundation.org>
Date:   Fri, 24 Apr 2020 12:29:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB1527A6A6F9BCEADAF14A3C6BFDD00@CY4PR13MB1527.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/24/20 11:28 AM, Bird, Tim wrote:
>> -----Original Message-----
>> From: linux-kselftest-owner@vger.kernel.org <linux-kselftest-owner@vger.kernel.org> On Behalf Of Randy Dunlap
>>
>> On 4/14/20 2:22 PM, Shuah Khan wrote:
>>> -CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(MOUNT_CFLAGS)
>>> -LDLIBS += $(MOUNT_LDLIBS)
>>> +CFLAGS += -O2 -g -std=gnu99 -Wall -I../../../../usr/include/ $(VAR_CFLAGS)
>>> +LDLIBS += $(VAR_LDLIBS)
>>
>>
>> (1) Can that series of ../../../.. be replaced by $(objtree)?
>> If so, that would be much cleaner IMO.
> 
> kselftests doesn't set $(objtree) when it is run directly
> (ie make -C tools/testing/selftests)
> 
> I had my own solution which was to use KBUILD_OUTPUT, like so:
> This was a patch in my queue, that I didn't send in because I wasn't
> very happy with it.  I was still considering alternatives.
> 
> ---------------- (patch)
> Subject: [PATCH] selftests/vm: use includes from KBUILD_OUTPUT directory
> 
> The Makefile for the vm tests was specifying a relative path
> (in the source directory) for accessing include files.  This
> doesn't work when the headers files are placed in another
> directory (with O= or KBUILD_OUTPUT).  It may appear to work,
> but ends up using includes from the host machine, which may
> not match the kernel source being compiled against.
> 
> Without this change, when the program userfaultfd.c was
> compiled, it generated errors like the following:
> 
>      userfaultfd.c:267:21: error: 'UFFD_API_RANGE_IOCTLS_BASIC' undeclared
>      here (not in a function)
>        .expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC,
>                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>      userfaultfd.c: In function 'uffd_poll_thread':
>      userfaultfd.c:529:8: error: 'UFFD_EVENT_FORK' undeclared (first use in
>      this function)
>         case UFFD_EVENT_FORK:
>              ^~~~~~~~~~~~~~~
>      userfaultfd.c:529:8: note: each undeclared identifier is reported only
>      once for each function it appears in
>      userfaultfd.c:531:18: error: 'union <anonymous>' has no member named
>      'fork'
>          uffd = msg.arg.fork.ufd;
>                        ^
> 
> Change the CFLAGS definition in the Makefile to reference
> KBUILD_OUTPUT.
> 
> Signed-off-by: Tim Bird <tim.bird@sony.com>
> ---
>   tools/testing/selftests/vm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 7f9a8a8..0208659 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -3,7 +3,7 @@
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
>   
> -CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
> +CFLAGS = -Wall -I $(KBUILD_OUTPUT)/usr/include $(EXTRA_CFLAGS)
>   LDLIBS = -lrt
>   TEST_GEN_FILES = compaction_test
>   TEST_GEN_FILES += gup_benchmark
> 

This should be $(OUTPUT) instead of $(KBUILD_OUTPUT). OUTPUT is
set by selftests Makefile and lib.mk which is common for all
tests even when make -C is used for compile.

Using KBUILD_OUTPUT will break other use-cases.

Send me the patch when you are ready.

kselftest Makefile invokes headers_install from the main Makefile.

This sequence doesn't install headers again when kselftest make
is done:

Main directory:
# make headers_install
[headers_install runs]

# make headers_install
INSTALL ./usr/include
[does nothing - headers are there]

make kselftest-all
make --no-builtin-rules ARCH=x86 -C ../../.. headers_install
make[2]: Entering directory '/home/shuah/lkml/linux_5.7'
   INSTALL ./usr/include

[Same here - headers aren't installed]

I didn't check O= and KBUILD_OUTPUT cases though.

thanks,
-- Shuah
