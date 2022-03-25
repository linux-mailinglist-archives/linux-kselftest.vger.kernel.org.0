Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A79D4E7C81
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiCYXgG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 19:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiCYXgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 19:36:04 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859C7E2F50
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 16:34:29 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 12so9817636oix.12
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 16:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NzU86xZaAdGK70/Ylql0VEFWbXnUz3zwu9f5VKchj38=;
        b=TvokyQbYjz/bU8RXDbUmZTN5CfzDWJFx3PmF3AxOUPnbb6m1OlHuiLtOZhh55des80
         5bVM7+hehCyFX7lW9rkWGDGxEy+AT6pbsE2TGMOa+mObx4ni/WYOhw+zr3z5Z+TAeHbr
         skqnmQNn2ONyi3KYF27Qeaa5zSPyAN5MZDUME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NzU86xZaAdGK70/Ylql0VEFWbXnUz3zwu9f5VKchj38=;
        b=WElNcgRqt9Sza520Ahq9Qflsne1Umv/Fi9L9mHJDISVWNClxTmyIh0jxoeamOEZdSY
         ND5Xp3qhWJFbpKiXdUJ5JRTig5e1ZAOEiWlCmZ/bWb1ayrJQxkZpXBi733Sbq69c5UQR
         RV6RF5GVMS85dXkxSh6v1+xrdH+GcmEsBVAITswEkumXd8CDWsErC/cbh3Rspth6aCmF
         gxEMt4Lo8LqjneL9qEdW2f45neQ2IJCK0oODIkeR66aPS4tzCKyjvFudbxGW2+GgPCLk
         FI7cNfrjwiBc4pJV/I25s7gfU+rScJG52yOM9eUumx2U6/NpneynD2GuqkSK64VlT/oG
         afYg==
X-Gm-Message-State: AOAM532IY8MIKbiBrXlvTUOmMCFupfixljkyWz+/NDC+dftZjtT2hw7P
        p2sW7irAf+ejxN8Oegzvck5YJw==
X-Google-Smtp-Source: ABdhPJzypVCEjWeYdeWGllov1AsB7BD9SYlONC7Lg5sTzPKknX6lsHwfE5yOvbucTxzf86+gPV6+uQ==
X-Received: by 2002:a05:6808:1999:b0:2d9:f6ef:f875 with SMTP id bj25-20020a056808199900b002d9f6eff875mr6855311oib.6.1648251268752;
        Fri, 25 Mar 2022 16:34:28 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id u7-20020a05687036c700b000da4bcdae42sm3138649oak.13.2022.03.25.16.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 16:34:28 -0700 (PDT)
Subject: Re: kselftest: net: tls: hangs
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CA+G9fYsntwPrwk39VfsAjRwoSNnb3nX8kCEUa=Gxit7_pfD6bg@mail.gmail.com>
 <8c81e8ad-6741-b5ed-cf0a-5a302d51d40a@linuxfoundation.org>
 <20220325161203.7000698c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <08c5c6f3-e340-eaee-b725-9ec1a4988b84@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 17:34:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220325161203.7000698c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/22 5:12 PM, Jakub Kicinski wrote:
> On Fri, 25 Mar 2022 16:13:33 -0600 Shuah Khan wrote:
>>> # #  RUN           tls.13_sm4_gcm.splice_cmsg_to_pipe ...
>>> # # tls.c:688:splice_cmsg_to_pipe:Expected splice(self->cfd, NULL,
>>> p[1], NULL, send_len, 0) (10) == -1 (-1)
>>> # # tls.c:689:splice_cmsg_to_pipe:Expected errno (2) == EINVAL (22)
>>> # # splice_cmsg_to_pipe: Test terminated by timeout
>>> # #          FAIL  tls.13_sm4_gcm.splice_cmsg_to_pipe
>>> # not ok 217 tls.13_sm4_gcm.splice_cmsg_to_pipe
>>> # #  RUN           tls.13_sm4_gcm.splice_dec_cmsg_to_pipe ...
>>> # # tls.c:708:splice_dec_cmsg_to_pipe:Expected recv(self->cfd, buf,
>>> send_len, 0) (10) == -1 (-1)
>>> # # tls.c:709:splice_dec_cmsg_to_pipe:Expected errno (2) == EIO (5)
>>> [  661.901558] kworker/dying (49) used greatest stack depth: 10576 bytes left
>>
>> This seems to be the problem perhaps.
>>
>> Jakub, any thoughts. The last change to tls.c was a while back.
> 
> Yes, sorry, kicked off a build and got distracted.
> 
> I can repro the failures, TLS=n in the config I must have not tested
> that in the new cases.
> 
> But I can't repro the hung, and we have a timer at the hardness level
> IIUC so IDK how this could "hang"?
> 
> Naresh, is there any stack trace in the logs? Can you repro on Linus's
> tree?
> 

I couldn't reproduce this either - I have TLS=m

thanks,
-- Shuah
