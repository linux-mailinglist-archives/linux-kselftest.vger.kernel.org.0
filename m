Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5EABD90
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 18:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfIFQTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 12:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfIFQTx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 12:19:53 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53434206CD;
        Fri,  6 Sep 2019 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567786792;
        bh=2cYrskkJv+XHuoOzx15GcaqK9klaADLHMr7jpndxPfQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zJq/5ZJIe2DQLfxRek22OTrRHinxPhB3d2q/YAIS0EPtSDJPjJbYUjNw9ZXOx1vvD
         Fs8NDTM4A4VvtnCeqox1iTOCJ0cLt7sJO5WirwLTEluWS0G3E4CddttaWXAzLdQoNG
         qBAhKSS92HR313Dq5+I0juKRftZLoOGCxiBHn2Vw=
Subject: Re: [PATCH] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, shuah <shuah@kernel.org>
References: <20190903145052.94735-1-iii@linux.ibm.com>
From:   shuah <shuah@kernel.org>
Message-ID: <24060b0f-1322-2b80-70ab-a053c8816b68@kernel.org>
Date:   Fri, 6 Sep 2019 10:19:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903145052.94735-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/3/19 8:50 AM, Ilya Leoshkevich wrote:
> The current logic prepends $(OUTPUT) only to the first member of
> $(TEST_PROGS). Use $(foreach) loop to prepend it to each member.
> 
> Fixes: 1a940687e424 ("selftests: lib.mk: copy test scripts and test files for make O=dir run")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/testing/selftests/lib.mk | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 1c8a1963d03f..857916ebbb9b 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -75,7 +75,8 @@ ifdef building_out_of_srctree
>   		@rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT)
>   	fi
>   	@if [ "X$(TEST_PROGS)" != "X" ]; then
> -		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS))
> +		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
> +				  $(foreach p,$(TEST_PROGS),$(OUTPUT)$(p)))
>   	else
>   		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS))
>   	fi
> 

Hmm. with this patch there is a regression:

make kselftest O=/tmp/kselftest TARGETS=splice

fails for me with


TAP version 13
1..1
# selftests: splice: splicedefault_file_splice_read.sh
# Warning: file /tmp/kselftest/splicedefault_file_splice_read.sh is missing!
not ok 1 selftests: splice: splicedefault_file_splice_read.sh
make[1]: Leaving directory '/tmp/kselftest'

Without your patch works just fine:

make kselftest O=/tmp/kselftest TARGETS=splice
make[1]: Entering directory '/tmp/kselftest'
make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
	ARCH=x86 -C ../../.. headers_install
   INSTALL /tmp/kselftest/usr/include
gcc     default_file_splice_read.c  -o 
/tmp/kselftest/splice/default_file_splice_read
TAP version 13
1..1
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
make[1]: Leaving directory '/tmp/kselftest'


thanks,
-- Shuah
