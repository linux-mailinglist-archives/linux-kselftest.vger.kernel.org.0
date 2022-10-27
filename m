Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19460F33F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 11:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiJ0JKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiJ0JKJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 05:10:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5663C1145E
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 02:09:58 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f37so1451095lfv.8
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmfGV//KmMuic4TgO6B6vfIweF0JdsZfuu3s+Qe2Rfc=;
        b=BOMLOipgWTGcIVb7PapOdU9iiCF8wgQ45BNUdfX0F957+X8rdd2g09ehnb/YzoQE0U
         1+urSVIxFDBtB7meLqbvaxdg+t5vQj2AHEL8XLuElrDsXQ+gc8B1uJxlFaDBKH6ZnMHA
         NTmHmfkbZaav1fWDblzrnvLqaUo+Vlj6UUecY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmfGV//KmMuic4TgO6B6vfIweF0JdsZfuu3s+Qe2Rfc=;
        b=z5dJMfSrispdSUze7lwW2z1698sHNoNwehwDpOwHf+EeUrsjCbpuVXm8nvmjCPes+C
         HARjRDWC9JXcnCMgJDYjvtGEazCdkkqs5yE9NyBtfwAc4s5NNw3A/+jHKYZru0tR0MRd
         GxbCQxPxwCHJ87O3OuOiH9pHKL+XtfopAYF0e3NqIUU0EZZ5mMoiN9014klhOqK7IA6b
         odzeGxXHPj6reLG8Zxs2nPnscajoUmd1tObLHFI7KLCDNPjBFPweIXy8Gat4CD5dlzAn
         EGUMgPDQc1x2If6XzYAT/0BVXaxn9H70d6fdIEI+vk6sKVHvdorzemJY6G4n3N8zKIbT
         oTOA==
X-Gm-Message-State: ACrzQf1M06XwGyRpeaCiVjltXZ7lt5+Ezq/13fItrMo/f4AQeBhnjgc2
        wGDXA5kTWE2/xaXpzTOhgnQhojjmTJwDgwSR8os=
X-Google-Smtp-Source: AMsMyM5jjPBa7Tcg65INJ5Gwrp3OOniDuXxIBIYwfP4ATGzQwGtdbjWycZGpTSapwM38W6w8zOuSeQ==
X-Received: by 2002:a19:700a:0:b0:4a4:7fc2:788b with SMTP id h10-20020a19700a000000b004a47fc2788bmr19520859lfc.117.1666861797193;
        Thu, 27 Oct 2022 02:09:57 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004946c99e78asm107237lfk.277.2022.10.27.02.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 02:09:56 -0700 (PDT)
Message-ID: <0b8feeb2-6ec6-d2af-8aa7-0bf34e7ab4b2@rasmusvillemoes.dk>
Date:   Thu, 27 Oct 2022 11:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221021060340.7515-1-w@1wt.eu>
 <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021170134.GB8420@1wt.eu>
 <20221021170738.GM5600@paulmck-ThinkPad-P17-Gen-1>
 <20221021172026.GC8420@1wt.eu>
 <20221021180040.GN5600@paulmck-ThinkPad-P17-Gen-1>
 <20221022112228.GB30596@1wt.eu>
 <20221024155357.GZ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221026053922.GA19206@1wt.eu>
 <a5233381-4081-afce-07b5-72d653eeeefb@rasmusvillemoes.dk>
 <20221026195224.GA24197@1wt.eu>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221026195224.GA24197@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 26/10/2022 21.52, Willy Tarreau wrote:
> On Wed, Oct 26, 2022 at 11:08:41AM +0200, Rasmus Villemoes wrote:
>> On 26/10/2022 07.39, Willy Tarreau wrote:
>>>
>>> No more false positives nor false negatives anymore. I'm sending you
>>> the patch separately.
>>
>> While you're at it, may I suggest also adding a few test cases where the
>> buffers differ by 128, e.g. 0x0 v 0x80 and 0x40 v 0xc0.
> 
> I initially thought about it but changed my mind for +/- 0xc0 that
> covered the same cases in my opinion. Do you have a particular error
> case in mind that would be caught by this one that the other one does
> not catch ?

Not really, but in a sense the opposite: for the +/- 0xc0 case, both
ways of comparison will give the wrong sign because -192 becomes +64 and
vice versa. For +/- 0x80, one way of doing the comparison will
"accidentally" produce the right answer, and I thought that might also
be a little interesting.

I'm fine for proposing a respin of the patch to improve
> it if it brings some value,

It's your call, you can respin, do an incremental patch, or just ignore
me :)

Rasmus
