Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D65E7D69
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Sep 2022 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiIWOmi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Sep 2022 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWOmi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Sep 2022 10:42:38 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9112968F
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Sep 2022 07:42:37 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id g12so258047ilj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Sep 2022 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KPF2lqF/WtNz1hYLUge3B8Vp3BuerYZNr3G0LKFM+pI=;
        b=gGnxOJrzA69G0jn1C8f+RQVhfmTHqoKHFI3+99865brwbstNc1J2/z9iqIIu10QDLB
         4NLuEqFsYK96WzVR7C2e6Em/Q7fFvn9PQvfUdFE0Kgc7zk5U97BgfP0YtQkqSMDzKaqG
         fe3C0co8WGjRk1ntXTXbg/lLRF0PXK8bDayXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KPF2lqF/WtNz1hYLUge3B8Vp3BuerYZNr3G0LKFM+pI=;
        b=d4S+5RU5zTpkodIO01UUgon2/puskSOOdjLX013sun3Ddt7c7COc33E4dIyNtxfHwY
         KrdnOzIDdQi9hFIC38kbx72zAt+EAguBoy5zDfxEIdFBHIJtxGcgbBxd5dIlmV1jubCL
         yIZzgeQf8/K0xbuLjEWNM6RXd2p2kMh5bNRrQcP+PFIyeJrG3uKfbuGXbOm6/mkq2BP+
         5HqxRYwqDCDArRfHEyoMTFeSjuaV5hahJNXDOrTWjGs1oj87CDTDSOtoWn8APMOSkWLk
         nXxpShxkj+gUq9IjUwmvwTTwLDwSHD4F4QoXY8sn4yonHbwwmlDSkDs0C5AdBu7NmVhJ
         Ps6g==
X-Gm-Message-State: ACrzQf0+jvfQ/XziWtmAq+ZzOaMPrArE7s2KvSbDT96ErRH4po2sNT1A
        416rFgiFTIwTnNBX6MXBopP23w==
X-Google-Smtp-Source: AMsMyM5B06KoxoN0qBRyK2rGavS6PZzCApYyN7HCsCIYb2derNbv+I2Yo72cxf2knFUZ1oV3smdxZQ==
X-Received: by 2002:a05:6e02:194c:b0:2eb:6cfa:1615 with SMTP id x12-20020a056e02194c00b002eb6cfa1615mr4251985ilu.10.1663944156485;
        Fri, 23 Sep 2022 07:42:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q39-20020a027b27000000b0034b362d5a12sm3365431jac.97.2022.09.23.07.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:42:36 -0700 (PDT)
Message-ID: <19cecfa3-7333-d97f-374a-12150acda79c@linuxfoundation.org>
Date:   Fri, 23 Sep 2022 08:42:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] Landlock fix for v6.0 #2
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220923104322.3182116-1-mic@digikod.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220923104322.3182116-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/23/22 04:43, Mickaël Salaün wrote:
> Hi Linus,
> 
> This change fixes out-of-tree builds for Landlock tests, which was
> initially identified here:
> https://lore.kernel.org/r/CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com
> 
> Please pull this Landlock fix for v6.0-rc7 .  This change merged
> cleanly with your tree, and have been successfully tested in the latest
> linux-next releases for a week.
> 
> Regards,
>   Mickaël
> 

Thank you for taking care of this Mickaël.

thanks,
-- Shuah
