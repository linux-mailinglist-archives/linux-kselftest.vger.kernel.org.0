Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCD5A7073
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 00:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiH3WQi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 18:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH3WQh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 18:16:37 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BCF6D57B;
        Tue, 30 Aug 2022 15:16:36 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d18-20020a9d72d2000000b0063934f06268so9096097otk.0;
        Tue, 30 Aug 2022 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=E/nyH/3foDxtGmIpzv0kFzFIyfD8qg2WZXXTeapubaI=;
        b=aleLjERqp1LW6YXXzsbNFYloljaBys8t7B5VCraRETR/5ZqZSHy3oVct65uewmmRO/
         y84S6F4UZE7GM0ax8bllzZll6ssuZzdOUzMCbm+g0WpYEIoX80pIpENOYzsSmL+3oHkR
         1tlwWy75lwdts1PGGp1Gin5KtX44Fsby9XATU/UQjtnKg0p8IQ8PqK9ntM4soE4zM0K1
         33SVv0U3qL0W8C5nF+u7Up/jYYhKovt4jaifGWvn3fmqXXOSz0WUiYhdPIwnNeLvHZuB
         bIWsFt4iB5GmpDGenTuyrdsMSUKZSf/uTAbyo+xfxFFdzQE/XdAHEVRqpoYLb1x+XnEW
         UG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=E/nyH/3foDxtGmIpzv0kFzFIyfD8qg2WZXXTeapubaI=;
        b=gE2RJ7jFJK3/2p5nVJWHkq/wpHCy9R6iNtuEwj5fzObiXo9A1n+iN+7Of9kyTuE6iX
         OE8KC/mt7oFs2PafoCsuDlAVtp9jYRFhTg4+pfiMpHHy0EnNMYLa96AmyKpHjpJujs3r
         kejt1h2DVvbH7DaFDrYUmp+1acHucFoPUHJRDbhHHljmw9sj8lwCep7F+CBpreDwSzhs
         5ryUPyMiuUpkMDNhqA5tvCkT14QMwB1TUEC/fKfhfT5VuU+v49WM0gih0ncMNKSKB7c+
         9t1LdEXfhiouOydmOvw5yrYEs8gPAoiEkO/mzJKDYffS76o3zUZ2lqXDdrk8kOkk9FaD
         Q1Pg==
X-Gm-Message-State: ACgBeo21Isu9IId7w7GRntA48gT5dQmMHQeDSCdAZCkNndQ6yIQ57DYt
        QRdpupW6Bvgyb8qKWKJunTo=
X-Google-Smtp-Source: AA6agR5jcgaxWchPKuW3dNX3lxYpGsOf2VOT7pIQ3io1qrIVEaeid8kBi8k2D0V1OkLk5Sr9VSi8Xw==
X-Received: by 2002:a05:6830:2704:b0:638:8d4f:8eb8 with SMTP id j4-20020a056830270400b006388d4f8eb8mr9786428otu.40.1661897795979;
        Tue, 30 Aug 2022 15:16:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:891d:81c:f58f:3bd4? ([2600:1700:2442:6db0:891d:81c:f58f:3bd4])
        by smtp.gmail.com with ESMTPSA id s41-20020a056870612900b0011f035022b8sm4064296oae.17.2022.08.30.15.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 15:16:35 -0700 (PDT)
Message-ID: <63b5fa8c-9fb8-b2ff-3f15-cc8649224f06@gmail.com>
Date:   Tue, 30 Aug 2022 17:16:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/2] begin KTAP spec v2 process
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829233150.3564612-1-frowand.list@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220829233150.3564612-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/29/22 18:31, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The process to create version 2 of the KTAP Specification is documented
> in email discussions.  I am attempting to capture this information at
> 
>    https://elinux.org/Test_Results_Format_Notes#KTAP_version_2
> 
> I am already not following the suggested process, which says:
> "...please try to follow this principal of one major topic per email
> thread."  I think that is ok in this case because the two patches
> are related and (hopefully) not controversial.
> 
> Changes since patch version 2:
>    - correct version 1 change text
>    - version 1 patch 2/2 had not yet been applied when I created version 2,
>      refresh version 2 patch 2/2 for new context
> 
> Changes since patch version 1:
>    - drop patch 2/2.  Jonathan Corbet has already applied this patch
>      into version 1 of the Specification
>    - add new patch 2/2
> 
> Frank Rowand (2):
>   ktap_v2: change version to 2-rc in KTAP specification
>   ktap_v2: change "version 1" to "version 2" in examples
> 
>  Documentation/dev-tools/ktap.rst | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 

The process for developing KTAP spec v2 and the status of proposals
and accepted patches can be found at:

  https://elinux.org/Test_Results_Format_Notes#KTAP_version_2
