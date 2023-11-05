Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEDF7E1607
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 20:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjKETZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 14:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKETZq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 14:25:46 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32DDD;
        Sun,  5 Nov 2023 11:25:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-da37522a363so3937540276.0;
        Sun, 05 Nov 2023 11:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699212343; x=1699817143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaVcP1OUvM+IHuK36JwRec0IpW7xfP/90XYqk3katdA=;
        b=e7IfJKZGlR064B1WbRYbMIU/7+qIF8wcrvoPczoy4rYeVsYf6DwEH9EY8KaEXzgtFT
         tGQUwuWZt34/MzHQc3xMNKQlV6mEfrKfSbDMgc04mTVonGJSBPD7wLtcU0u2Fh+Dx6XX
         5s5lbF1DtiHhigwQxOthUsT0eJiPpnTuY41gMd5FaO/+3XIcCoy3/C9hVVUbZJJzk9XI
         6Y0sjmf7d7dZ8rHyBBSWxulZnfQRRF04ZKdkxtwBZL7SRBVMycN4/6s3hyVNxy0NA83g
         UwlvMBAFu58tbhC17REkeRTEjyfD0+1ThdwWOGqqYjZ7K6LDmPU98z7ziHmbSrtXJk+X
         pRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699212343; x=1699817143;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaVcP1OUvM+IHuK36JwRec0IpW7xfP/90XYqk3katdA=;
        b=uCKzLsYJC27R+GfldtVKnqYhVuSbkWzKNWdj0iEXjqFRnfWgPBENBCfAbt9aUxwK78
         PW2RfdFrYT5uiSA1y4RbBU8dTeRtkwz/4ooeqUk+V0LVaVVo7BrU6POrIFBHf1AmZ2C3
         Sc8dAzCJoqcDIkTDhVfHTvw9whFjdUHkbgsKDrKewx/SU+Ug1bSTx3wnc6MWoVHWkFYp
         LHYVF5B5zafyFN741zqYyszbfQSC/QUPZJVFXtf71kPzdAzwdaG+a7yQCAuYcTK0QuOK
         r09j5IJu1n2RMJnaWThfeHb/wTppw50OwKEpLmG3FrJbUPop60KbrLRoeSWiN3KRVV+H
         NEvg==
X-Gm-Message-State: AOJu0YxXNUhtaDffDdT7CkD5n+PVCknRdRzshQLiveqpwTvnLDc3surR
        i19jBRvhs+sn2jrAq9wFg8I=
X-Google-Smtp-Source: AGHT+IEK6qNbJls/V4ECdUxLd0BeyIKz65RaMcAVM2tds4JbOsGdJI19+TeOkAYc/NbHDxtTXSZBQg==
X-Received: by 2002:a25:aa2e:0:b0:da0:d0e6:905d with SMTP id s43-20020a25aa2e000000b00da0d0e6905dmr23325275ybi.59.1699212343144;
        Sun, 05 Nov 2023 11:25:43 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id m6-20020a056902004600b00d72176bdc5csm3042752ybh.40.2023.11.05.11.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 11:25:42 -0800 (PST)
Message-ID: <8281dc2b-86a5-469b-b3a5-58eb23494a4e@gmail.com>
Date:   Sun, 5 Nov 2023 16:25:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kunit to check the longest symbol length
Content-Language: en-US
To:     =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org
References: <20231105184010.49194-1-sergio.collado@gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231105184010.49194-1-sergio.collado@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/5/23 15:40, Sergio González Collado wrote:
> The longest length of a symbol (KSYM_NAME_LEN) was increased to 512
> in the reference [1]. This patch adds a kunit test to check the longest
> symbol length.
> 
> [1] https://lore.kernel.org/lkml/20220802015052.10452-6-ojeda@kernel.org/
> 
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
> ---
> [...]
Alles gut!

Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
