Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1694AE166
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 19:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356645AbiBHSsn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 13:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbiBHSsm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 13:48:42 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACC4C0613CB
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 10:48:41 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id m185so184752iof.10
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 10:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LtG9xiEE4jQ44T6HhsufQS8ADKi1yJRAek9eLEpW3Ys=;
        b=ht1mBR1BKvtHYuXL0CeSG5fNz805lGf+inQGeHOQ9GZDWl4dbLbFfhtJcQJ3ldQjqA
         vQ3eGmgzG17XoIkACoJ+bheV8tS3KtZTE9QE/eZ6V3XfmxAI2+F3lXpDiortIXa7U6/I
         6hONZbB1KczxazQqEXdQ3gu/ylGsnumG0WFvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LtG9xiEE4jQ44T6HhsufQS8ADKi1yJRAek9eLEpW3Ys=;
        b=HxSC5e15FLan806UN0yPBD0FY4fRoOcgUl7LwJRLZdW63ccAYZVapxtpzAau9A+6TV
         0Jkjaw+OBQoADZVZT01h2AxX2UptbLRqXsW1KOcbC+sQN2DQgkmZ4yeLj+8+7TxFs6Mx
         vYCOTaWKkvGK/rvWMYaITofO1n7sPmywg6NoCmGLNFWBT3UpJPDEYvEf+2a3ynGkJKZx
         LeiN86/19bICm+V0XQxU7rNolmE/7zBWidYZgILNE86HOi7BJmh6P4xGYhDry7WohkWb
         RwSbHO+BsHy+ISki1tzExf9U58jFd1pVnGQ1tMjRAqF1QfDRmG4bHNd1GClpKZ+UtNYN
         BFfQ==
X-Gm-Message-State: AOAM533nszu0brLFG5hhq0okbN18RYbBbvuZdCwCS0pMESdrAOF2w31p
        83C7blsGr5cQ41nx71lCrwhZHw==
X-Google-Smtp-Source: ABdhPJybY7CIIniHpQEPbw++VUMg7Tcma6su/YX6uw9r/4qtIDTaKIhRtbG8v/LRWEK2aygphsOhKA==
X-Received: by 2002:a02:2301:: with SMTP id u1mr2833843jau.119.1644346121235;
        Tue, 08 Feb 2022 10:48:41 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id i30sm693163ila.32.2022.02.08.10.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 10:48:40 -0800 (PST)
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <49da0f58-7a20-e557-54c3-34bd7074f711@linuxfoundation.org>
 <YgKQTLwW+ha5XNx8@sirena.org.uk> <YgK4kKrSs6e9seG8@sirena.org.uk>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <e6d76104-b7f6-1588-d734-1a09c2990299@linuxfoundation.org>
Date:   Tue, 8 Feb 2022 11:48:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YgK4kKrSs6e9seG8@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/8/22 11:38 AM, Mark Brown wrote:
> On Tue, Feb 08, 2022 at 03:46:27PM +0000, Mark Brown wrote:
>> On Mon, Feb 07, 2022 at 05:10:35PM -0700, Shuah Khan wrote:
>>
>>>> +++ b/Documentation/arm64/sme.rst
>>>> @@ -0,0 +1,432 @@
>>>
>>> Missing SPDX here?
> 
>> Only a couple of rst files have SPDX documentation here, I guess the
>> SPDX people aren't worrying about documentation?
> 
> I can't find any free format plain text files with SPDX in them, even
> really prominent stuff like README.  The process documentation is silent
> on what's supposed to be done here too, it says you should use the
> comment style for whatever format you're writing in but that's not a
> thing for free format text.  Dealing with this feels out of scope for
> this series, probably something for whenever someone gets round to doing
> a conversion to .rst or some other format.
> 

There are about 570+ files under Documentation directory that have SPDX
including Documentation/index.rst

Based on a recent doc patch I did, I have seen warns during doc build
about the missing SPDX.

Let's add it now so it doesn't need fixing later.

thanks,
-- Shuah
