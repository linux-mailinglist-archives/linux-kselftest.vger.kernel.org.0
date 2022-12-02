Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C569C640F27
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 21:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiLBUYP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 15:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLBUYO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 15:24:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A4DF45;
        Fri,  2 Dec 2022 12:24:12 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o5so9539814wrm.1;
        Fri, 02 Dec 2022 12:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWLZbrwyvitTVJVVBqs7BQW3jKoB+thAYx4GCZD+AaM=;
        b=FEqFFlYrW/PjdzCFSbIy0xo7MCTyw6Dd/+lFO0vSj6yz/EHiSVCxCAbTGULKWVY3E4
         RBK6katbdYqRtyu7pW1h6sQBg5+HKQwVXgtwXfrLcKc4/3P5DF0gk7UFc7mphRRo+KZL
         VMYT3SkuqPHkbCLCSaz73S4bYESirD6nOfxu/OnBKyk8FKQttG9/ugfmntjZqlZ4AJFP
         qj0CcX8a2cduamYphmw/+tbVxSzqmHKMtUhKUnqhSDzfv+GO2RhxbGetAmOdFZnrvYFo
         LrAJpExZnqifF0ebRo1ZLLb2jRepTSFL64Nw5xaUzaIBO58D+V7zX1eyaXOwhbHOHe1l
         6D4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HWLZbrwyvitTVJVVBqs7BQW3jKoB+thAYx4GCZD+AaM=;
        b=TnK46Jv0MIyoxR3parSvdIHzpAaGZ4ZST4h21qgSyAKlOfeZlTwIdDuG8eGvm/Pvus
         LKfL6ksJTaCUfJxATsvqeTPKLOLHntYXXgzG8He+cX4vTtF4vSV0naKqKBgOGx7QsWMT
         USg+UGMBQxe4HmcIqh/gejcNQH8KxpoiOdQbO1YVASFKQUDL+gSeQVd+fkLukCFj/Oo2
         1xPuDvGBVE4pm8+1+iqlpHx3ZZvfpROj4VMDPdshnmJpUkMmxmzWVeAagGtiIrfzxshn
         0ZGDK6LeEDpWbkG+lJyjnZ/ULrG2GTSbMI4zkaO6ZJRJ+0r1pmdoWYXVAJyA92Na1a+V
         vSxw==
X-Gm-Message-State: ANoB5pmhPi46ijtDkj3/rADSJjgJUvcyfQiLwUeW/TcWb/0WxfpDtzC1
        wMfI896s+UB7cc2blZrsSl2KY2rYQsYsbKKg
X-Google-Smtp-Source: AA0mqf43bVKPAjCTIQl32HsfqJj4TL6iP3u2fljVt3YhggxW8aCWKn3wq7M0qtIbscDGuokESlgivw==
X-Received: by 2002:adf:f24a:0:b0:242:3be9:71c7 with SMTP id b10-20020adff24a000000b002423be971c7mr5301585wrp.329.1670012650632;
        Fri, 02 Dec 2022 12:24:10 -0800 (PST)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id bg28-20020a05600c3c9c00b003cfa3a12660sm15154616wmb.1.2022.12.02.12.24.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 12:24:10 -0800 (PST)
Message-ID: <4fb9ef31-4d40-8e74-640f-bdbe60825bf1@gmail.com>
Date:   Fri, 2 Dec 2022 20:24:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake
 "probabalistic" -> "probabilistic"
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201091354.1613652-1-colin.i.king@gmail.com>
 <Y4o0Nq4SKGZgDOxi@google.com>
 <10445a4d-0175-3e5e-aa74-9d232737a7c2@gmail.com>
 <Y4pEaaQsnDWEOxjH@google.com> <Y4pKfrX1ZfKhAT6y@google.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <Y4pKfrX1ZfKhAT6y@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02/12/2022 18:57, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Sean Christopherson wrote:
>> On Fri, Dec 02, 2022, Colin King (gmail) wrote:
>>> You may be better off with using codespell
>>
>> Heh, my kind of nitpicking people :-)
>>
>>    MSDOS->MS-DOS
>>
>> Thanks a ton, that's exactly what I was looking for!
> 
> For anyone following along and/or laughing at me, checkpatch even supports using
> codespell, e.g.
> 
>    ./scripts/checkpatch.pl -g HEAD --codespell

checkpatch also uses a misspelling dictionary that I occasionally 
contribute to with common spelling mistakes that I find and fix.

Colin

