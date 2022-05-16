Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B426528D6C
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbiEPSuO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345066AbiEPSuI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 14:50:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3193EB81;
        Mon, 16 May 2022 11:50:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so186527pjr.1;
        Mon, 16 May 2022 11:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ogFgPpVvtLABZGqhLzO7aVIGrK84/NfIlVnDOzWwbx8=;
        b=Hd0Yorn0RW/CYIBNSer8vE7Dkgu4vN8r5CmeQz/yRlhWDVzomT7yKboUIDrEYN8r6H
         fuPXEADzXBCgJBnKMFjASpP31MlP4WKde1RvxkWhfeiwZwed/VkEkOSpUY78oPDAx5nH
         vnXswqBP3oQ4laULsL4AVvrMiF3woZrNQwOx+zT0oiiwiKi4t0Uzv7sKv6Qy0AoSTLOz
         j2BtRCNMtIEmnpzHMK8SHi8OLI10I9r0kB9r9g5yrrgNoLUhbZbrQ5WI5GAkpI7ePLtv
         ZEL7VVNDuTcYRffrLhc/kRD+xGfSvzZi5PMixafVOTRpY2A1sBZEKfnYkZHyLf5QqNuG
         loPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ogFgPpVvtLABZGqhLzO7aVIGrK84/NfIlVnDOzWwbx8=;
        b=e+t/+JGNpPnBccKOeR1Pj+L+y6xVADtY9QVkt+4NGgMW13/6Dgm+l1J0gO2z7BqM8c
         XrGbVX/Z8EbxvoYpioWHOTmVzvCEENBIVFjUPEFyyWJHbvLkzRQyuage34ZITc3Z/OSU
         Dv631edAtJrz3AjAE0g+ctqiTu1zG9D6f+2vxW+RORoEfrefPA73M+3qe/B9DlRP2maz
         BSsMRF1Ey25hcnksWRGsXNy6ByhsdW1uBAcm9z6G4rIIAC/a0o9KoskFiUjGoQoe1Flp
         a3c24NmGeIsnqYkGnJK1eCJ/sm3cMKZ1rbhSL8rgTNuT35hDnaTloEJJvnHgjdYg8L7A
         oE5A==
X-Gm-Message-State: AOAM533XlEC+AMlo3iUC6umB0nkrZIpkdFYWzlutl2SZYmjmo24aWxUW
        jKEjtzvTnD0snkcRUJSjp04=
X-Google-Smtp-Source: ABdhPJwJWStGtq2F73tDt655k7SukiNeC417jxnY4Q7eSvMJW6/+8fSvzNv6EKJ51TvR0GUJcSrMHw==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr20801877pjb.98.1652727007097;
        Mon, 16 May 2022 11:50:07 -0700 (PDT)
Received: from [192.168.0.107] ([103.86.19.192])
        by smtp.gmail.com with ESMTPSA id h20-20020aa786d4000000b0050dc76281a5sm7289062pfo.127.2022.05.16.11.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 11:50:06 -0700 (PDT)
Message-ID: <3f2e9cb6-9b3a-5054-34a8-7c7e1c77a15a@gmail.com>
Date:   Tue, 17 May 2022 00:20:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] selftests: alsa: Better error messages
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <skhan@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8598037d-0e24-9bc1-3f2c-a2751ec8e871@gmail.com>
 <YoJnhulbKk49rZsw@sirena.org.uk>
From:   Siddh Raman Pant <siddhpant.gh@gmail.com>
In-Reply-To: <YoJnhulbKk49rZsw@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thank you very much, Takashi, and Mark, for reviewing the patch. Helps me getting
the hang of kernel development coding styles and conventions while starting out.

The particular motivation for this was that this test tends to potentially
generate a very long list of warnings/errors.

On Mon, May 16, 2022 At 20:32:30 +0530, Mark Brown wrote:
>>  	if (err < 0) {
>> -		ksft_print_msg("Unable to parse custom alsa-lib configuration: %s\n",
>> +		ksft_print_msg("Unable to parse custom alsa-lib configuration (%s)\n",
>>  			       snd_strerror(err));
> 
> I'm really unconvinced that replacing : with () is helping either people
> or machines - the form we have at the minute is probably more common for
> command line tools?

The intent was to separate card and error with the colon. While it may not affect
parsing, you are right, the colon separator is seemingly the standard. Apologies.

> Why add the space before the : here?  That really is not idiomatic for
> Unix stuff, or just natural language.
> ...
> This should definitely be a separate commit.

You are right. Again, apologies for this.

>>  		bool is_volatile = snd_ctl_elem_info_is_volatile(ctl->info);
>> -		ksft_print_msg("%s.%d expected %lld but read %lld, is_volatile %d\n",
>> -			       ctl->name, index, expected_int, read_int, is_volatile);
>> +		ksft_print_msg("%s.%d : Expected %lld, but read %lld (%s)\n",
>> +			       ctl->name, index, expected_int, read_int,
>> +			       (is_volatile ? "Volatile" : "Non-volatile"));
> 
> I don't understand the comma here?

Those are independent clauses, hence used a comma. Looking back, the "but" can probably
be removed here for brevity.


Please let me know if there are any other things which bugs you, and whether or not
should I send a v2 with the issues addressed.

Thanks for the reviews,
Siddh
