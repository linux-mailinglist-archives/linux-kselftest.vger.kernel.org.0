Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5AC5F193F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 05:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbiJADJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 23:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiJADIN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 23:08:13 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1075C18274D;
        Fri, 30 Sep 2022 20:07:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e129so5595593pgc.9;
        Fri, 30 Sep 2022 20:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=72VbjhRWlgAwdbhThbX1+r5OGqqoZFzDMkMotTN36YI=;
        b=HKIm8sUWrKr4PCRwaqCH508rlTrKgpYA14FFWn0mw8SVxO2R/FL2ZsxanugF57qv6f
         hptW1gl+Ytwp9yLquB93l1pJC8+3MbFCSHEvDFUMDycoQcdMSU95h3KatHQtXL/AhGHk
         z6eMtoULZvFFRXN+zU5GP/Fv+HZCdT36t5gFb1TTbLnH4ovmm3tKU/nugg8yLppTQmfn
         5KNg622Gq9fX+sA+vzdWU7cZC+Xt+IyJctX9Zky8kQxi/HS2DRi4Dv/c9WAKhEbTaRMK
         G/epkrnTJkqDXiFPMWxvZbbjMbJZ6xRtYHRW5lp99mjr3DWcQO9S56TVVU2pC2oLOD/g
         bk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=72VbjhRWlgAwdbhThbX1+r5OGqqoZFzDMkMotTN36YI=;
        b=v2ezGjjFTBeD1LYKawGGali3AqJhcnZ/LBtoYWOXObLpa+zbldsJDWnw70QZIzgCUa
         dAr3guOgw9/BAFAUTyeIXeyCfBRswskmb2JHlAgBiqWFqTcejZ2eUtsJWpcOHS2RUyGq
         Bn9cwynYQ6iXJBpzXd4qEmYVGIXt4cD8iLuVBWBD4lV3GPcI96PD3uM3pyp/pYEdiY7P
         3rt2sJYbf9NlwJw9M9P9DuoKt9ctDjbRpfdp0S32Rxzf/1W+JbjQ08qV7eHIO1ZFNXDG
         SXnp+CszDnbm39VR6LbW7+QydnND451oEl+SBStwi/NNwqlVJpvG+I3A4VA7GRA08yEb
         8XQQ==
X-Gm-Message-State: ACrzQf0QethSNPWj4FWqVD+EL++pUm/6vICVUHTs4prtdM+4tQuKk3hx
        NY+SmbPmWU7xob40f/1ImDZ8VPU9WOyXTQ==
X-Google-Smtp-Source: AMsMyM5mEoG5OV/d2pEFEPAsELU8L+ViMKV218DSnTkdlbQojzLQ5R2ifp3I5bxIkaIK2UealMmFYQ==
X-Received: by 2002:a63:4d5b:0:b0:42c:299e:eecc with SMTP id n27-20020a634d5b000000b0042c299eeeccmr9937227pgl.41.1664593673144;
        Fri, 30 Sep 2022 20:07:53 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-5.three.co.id. [180.214.232.5])
        by smtp.gmail.com with ESMTPSA id f69-20020a623848000000b0055fd8b687fdsm13563pfa.95.2022.09.30.20.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 20:07:52 -0700 (PDT)
Message-ID: <41fe0989-9157-944d-c796-21e28c8265b9@gmail.com>
Date:   Sat, 1 Oct 2022 10:07:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] Documentation: kunit: rewrite writing first test
 instructions
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
References: <20220929132549.56452-1-bagasdotme@gmail.com>
 <CABVgOSkT-EWLqr6R=RvbEgmkMAY0680YbRnEBg1un6h-=TzrUg@mail.gmail.com>
 <464981b6-d9d7-e656-261f-ef48661deaa2@gmail.com>
 <CABVgOSko6kgA_T3LNgTPxQZS8Ab8E+XhMcOGHFx76nd2HN_RBg@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CABVgOSko6kgA_T3LNgTPxQZS8Ab8E+XhMcOGHFx76nd2HN_RBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/30/22 17:32, David Gow wrote:
>>
>> The indentation for code-block directive is required, since the preceding
>> paragraph is multiline; otherwise there will be Sphinx warnings.
>>
> 
> I don't see any such warnings on my machine (which claims to have
> sphinx-build 4.5.0).
> 
> Could you send an example warning, and your sphinx version to me so I
> can try to reproduce it.
> 
> Regardless, if it's causing warnings, keep these changes. (Though it'd
> be nice to include the warnings in the commit message, so it's obvious
> that these are being re-aligned for a reason.)
> 

I'm using Sphinx 2.4.4 (as installed from pip through
Documentation/sphinx/requirements.txt).

Sorry I can't reproduce the warning I mentioned earlier (I forget
the recipe that triggers it when writing the improv).

In any case, I'd like to keep code block aligning in the separate patch.
It would be nice to see code blocks aligned to the instructions list.

-- 
An old man doll... just what I always wanted! - Clara
