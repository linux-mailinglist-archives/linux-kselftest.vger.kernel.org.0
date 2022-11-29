Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2E63CBE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 00:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiK2Xbb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 18:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiK2XbH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 18:31:07 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216871F07
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 15:30:41 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id z9so7401640ilu.10
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 15:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JfTE0wye7LTPK/U7NOzfJnWWxw++LJ/TUF4lsfmPtFk=;
        b=YhB8mzlJgfRmK85mMB5VDdLW+yGp3Hjjj4NSh1AYwLokWHkP4S3HJm8mlAHcezYPOa
         4GdlkdOkGHdpzXvCvePTJtuG7RldXI2ZPP6y1VPmZSGENNJ1NeYw9cIEPYPGDTWOPPds
         4nsBPDRdiKkGiSzTaQsnGF6BgauD5PZkg+oQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JfTE0wye7LTPK/U7NOzfJnWWxw++LJ/TUF4lsfmPtFk=;
        b=3xlTjaXw0TJ0C+D6IiaA6WLx9u/zkX1eS4FRaY71wL4qCZEOpmdyzMVe75bYmfSuia
         3IfeOePsSxJMFgjMW56mqRv7OTRjZZfqiJjvn+YHZJhTEhQRkgDu+JGmQEydUyK3iVBb
         sdzy3vBOWHWyLDTjajnjsSYRa4kWQMg1lcYDYKQ0yc8f8Ofbndj6+b3Upyj9ylziitnp
         vt540P9Hd6QMjhELPqxSYocqdPkLn6xs6xjHh21nHLTx8k4pGPfEwNWSLhk0tskjDQU6
         bKiWgeRbfwrJy4+X1hiX9IrqshcB1uMhgxitzb94uLM1fLyqtdh+OvBH2dM0Osnqs+D3
         ATfw==
X-Gm-Message-State: ANoB5pmicIvLReND83Moi63h1I+Ip4zPqCDfmqa/sPNdQI8QdqlwMo5+
        tlD+b/Z8K2VMnnxEbIV6i03gxw==
X-Google-Smtp-Source: AA0mqf4uGQ6McVLvcY8GzQ2GHRIzKqmC6ZptyPot1v7oW9ixuvhW5c0mdZjzhLvOrkYkB1y+gvhCxA==
X-Received: by 2002:a92:6e07:0:b0:300:1f82:73e5 with SMTP id j7-20020a926e07000000b003001f8273e5mr17223063ilc.85.1669764640682;
        Tue, 29 Nov 2022 15:30:40 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z26-20020a05660217da00b006bccaa66ee4sm5914087iox.40.2022.11.29.15.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 15:30:40 -0800 (PST)
Message-ID: <07f475de-98ae-87b2-0215-12a4a2b054d6@linuxfoundation.org>
Date:   Tue, 29 Nov 2022 16:30:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/6] selftests: Use "grep -E" instead of "egrep"
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <1669165413-12035-1-git-send-email-yangtiezhu@loongson.cn>
 <bf9b26b5-2793-204f-ba9c-4d9cd55b08ad@loongson.cn>
 <dc7cb519-584c-55f1-4baa-44cd4e0bbfe9@linuxfoundation.org>
 <20221129221344.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <d48804d5-2ad5-fbfb-ce17-83fbc450d3d6@linuxfoundation.org>
 <20221129232212.GG4001@paulmck-ThinkPad-P17-Gen-1>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221129232212.GG4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/29/22 16:22, Paul E. McKenney wrote:

> Lazybones that I am, I would rather carry the patch than resolve
> conflicts.  Especially given the tendency for new rcutorture patches to
> appear, thus changing the conflict resolution.
> 

Sounds good. I will drop the one I applied to my tree.

> My guess is that the patch is this one:
> 
> https://lore.kernel.org/lkml/1669165413-12035-2-git-send-email-yangtiezhu@loongson.cn/
> 
> Or should I be looking elsewhere?
> 

Yup that is one.

thanks,
-- Shuah

