Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91596730DB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 05:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbjFODw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 23:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbjFODwV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 23:52:21 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6311C212C;
        Wed, 14 Jun 2023 20:52:20 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a693718ffbso3733191fac.0;
        Wed, 14 Jun 2023 20:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686801139; x=1689393139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+dev0gi3mOMoRwFhsdS2OBBCly4pJkh/R4J7IbY+Y=;
        b=hevgJyNa92SUhRA4jSL4apc9un7ooERZR6KZUDIGuQ555+v5l9VIy1ZaddPfH5Lpoh
         HOjPiQig0uZ38Bp4MnQWRPUU/4VBl2xLHCWqituJhvHx1VvPMEt7VgTmVSESZjrBddYY
         ag8/FkWyxiINE6286GWL4fKk1dldIHOBfCO+pQ7F3w6JUu7p55QiXAGAqfeqOWwYGE0y
         /2wLpTMPlnuLDwHWil2qzMvyy1JeKS/VtiQIety5QsEeSa+AJcMV4HwaSZHVkr+ECk92
         VhQ0+KOviNI3N1PL7R0skiklRE3KrJfhxm3BaaaZ7mgMD4gwLxBrmOAjNHXJkzrXrDmN
         Uj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686801139; x=1689393139;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+dev0gi3mOMoRwFhsdS2OBBCly4pJkh/R4J7IbY+Y=;
        b=DozZ/RCRz+32iNGmleFfzTDjdjETDCMHmed6xWQCMXa8Cdbaedp6p7QaxLgfg1mcu2
         eg+MpZimsNih2Kj73xoyeaib9fAdLjtaXoCWKJKAZUMG2Nq+sMIhWU1xmhqsuG0u7/vh
         RzXb31CjpNnU3pBa1GZvXoXwjmbtIBjkC+zKmdIvbT44ia+T7aAmrMtyd9KxLAY31muz
         Pr6eUd2uweoo7YDW8zi7cbzQtu6fF6K/YmkOm/hwudP4iGK4odMta/IBrA2HB+jr0oDg
         qMcMWuc0CjeHN+o91boQ1uqmfa3UPhPwxUUc6pCACO6df9MlIeiCBKmasJEs8CJgIm3+
         ZowA==
X-Gm-Message-State: AC+VfDzbeX8x8m/uPdwMGZ7gr1b0LNLZVXZqDTQDpjxOxVvliBXcetcb
        hsEWwJ/XhxmbJewKPfrxLeY=
X-Google-Smtp-Source: ACHHUZ6TBgwkoBuExJECC3LHCYuqlfHoGKSK1w1caiD/ZoHx9m2PFGtaZJjverxSgFIrVruuYYLyWg==
X-Received: by 2002:a05:6808:1119:b0:39a:98c3:b9f3 with SMTP id e25-20020a056808111900b0039a98c3b9f3mr10023523oih.41.1686801139612;
        Wed, 14 Jun 2023 20:52:19 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j189-20020acab9c6000000b0039600e3376asm7042303oif.1.2023.06.14.20.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 20:52:19 -0700 (PDT)
Message-ID: <0cfe45d9-74f0-c198-0fb9-74d24d36b621@gmail.com>
Date:   Wed, 14 Jun 2023 22:04:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/6] rust: sync: make doctests compilable/testable
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230614180837.630180-1-ojeda@kernel.org>
 <20230614180837.630180-4-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230614180837.630180-4-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/14/23 15:08, Miguel Ojeda wrote:
> Rust documentation tests are going to be build/run-tested
> with the KUnit integration added in a future patch, thus
> update them to make them compilable/testable so that we
> may start enforcing it.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
