Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69755714AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiGLIdC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 04:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiGLIco (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 04:32:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604DBA44FA;
        Tue, 12 Jul 2022 01:32:42 -0700 (PDT)
Received: from [192.168.0.107] (cpc108961-cmbg20-2-0-cust263.5-4.cable.virginm.net [80.5.129.8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CEA666601A21;
        Tue, 12 Jul 2022 09:32:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657614761;
        bh=+cl4EO3THpsgls4aPf6BTDrlKA7Yjs+kfP1d1rvGTWc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mkDBM2aIoz1HERzwbFKAJi0eIv4NrgSipgEvct9wjEMTEFTpVX4V70XZihNV4F4+D
         Sa2PUFSii/5gNfGK2lMQmzu63fFSs/nO6L0yXRF1Boioje/8KB2GNSQUZ8JGd0piJ9
         4vR4mXVQ7qL0PhVEnVsFINrZY9PqW8y+56bKvvpDUm3WudpU4NDYTr3Nmw+IUmi/D6
         W3kw0mXy8m50q7CZN7RzCocgc6iutLjm4iAl7mYiOY2UMND5DjLbipf/nZgkxGEak3
         2ptHBAhyySC2XB4GOsKr1kW2QTHb7CWyuSk/Hz14Bsb894OYUuApvG+BrDQHap37Zr
         /4ocQmCK3blXA==
Message-ID: <5b394bca-335a-4a32-0a68-bebdb33358e8@collabora.com>
Date:   Tue, 12 Jul 2022 09:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/4] Makefile: add headers_install to kselftest targets
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>, kernel@collabora.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <cover.1657296695.git.guillaume.tucker@collabora.com>
 <4d34d06baf945dc31c78f873771cef3a75b60067.1657296695.git.guillaume.tucker@collabora.com>
 <CAK7LNASe3zQv82pQsTdWtia9nQQm8XGgs_mrUMvbLRkxa0T48Q@mail.gmail.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <CAK7LNASe3zQv82pQsTdWtia9nQQm8XGgs_mrUMvbLRkxa0T48Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/07/2022 02:35, Masahiro Yamada wrote:
> On Sat, Jul 9, 2022 at 1:23 AM Guillaume Tucker
> <guillaume.tucker@collabora.com> wrote:
>>
>> Add headers_install as a dependency to kselftest targets so that they
>> can be run directly from the top of the tree.  The kselftest Makefile
>> used to try to call headers_install "backwards" but failed due to the
>> relative path not being consistent.
>>
>> Now we can either run this directly:
>>
>>   $ make O=build kselftest-all
>>
>> or this:
>>
>>   $ make O=build headers_install
>>   $ make O=build -C tools/testing/selftest all
>>
>> The same commands work as well when building directly in the source
>> tree (no O=) or any arbitrary path (relative or absolute).
>>
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>  Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 1a6678d817bd..afc9d739ba44 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1347,10 +1347,10 @@ tools/%: FORCE
>>  # Kernel selftest
>>
>>  PHONY += kselftest
>> -kselftest:
>> +kselftest: headers_install
>>         $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> 
> Nit.
> Please use 'headers' for in-kernel use of exportedI headers.
> 
> kselftest: headers
> 
> 
>>
>> -kselftest-%: FORCE
>> +kselftest-%: headers_install FORCE
>>         $(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> 
> Ditto.
> 
> kselftest-%: headers FORCE

Thank you all for the reviews.

I've sent a v2 with this tweak and double-checked that the
kselftest build produced exactly the same result.

Best wishes,
Guillaume
