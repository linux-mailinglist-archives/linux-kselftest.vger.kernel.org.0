Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685D6731A6D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344422AbjFONuy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 09:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbjFONux (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 09:50:53 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA83193;
        Thu, 15 Jun 2023 06:50:52 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1a994308bc6so965840fac.3;
        Thu, 15 Jun 2023 06:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686837052; x=1689429052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DojIv4w46I2F3FeQItbDQQuCHIMIGT7OLbgfH+JlnwQ=;
        b=N0XpOh5s++xYT1PbPTgq5mjgxoPU2+YVe7NxEp5HUoBbHK2MA+Kv2aVJ+WPbbIUI3R
         5TWJJ4jOL4FlRKUCZ037736XNKUUXR4SY4IoGu/D0uysuncG5HFJOt9p+hfIM24sK47n
         cz489yggWXEL4wUMrJEiLY/hAfu1G41MQhPYw1qk8YSVvmWZLM8Wl0pEaAIGiLHAaM7P
         5YtztyAR+QKrYxYTv8YgA9+GuynMP1f7sOuBmegdbs6sXOH/Rzl54DsybpRaVxtfLKO/
         9foNFgIfR+N8vHZnFO087fjJ6bnq44R3m2wyXqVSOhWMIm/rDw/TFngSqkDW8N28YSTi
         eZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686837052; x=1689429052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DojIv4w46I2F3FeQItbDQQuCHIMIGT7OLbgfH+JlnwQ=;
        b=S5qSGy3QuyrSWB7JLK455K/WR4VymYpH+eRnZq+D33pZdkvg3FbN7OCVFVyZQhRn7q
         W1+3BZiQEhabNR2o0t08dnoLfi3GBa2PiE9sZ8bfWJiXX0Nx4I8NXyRpfnSLsULI7qwM
         LzkWfzm2KgbIgf2mCZkIjgNTg8eIoAhxdvPJul9koaC2f7rUm4vTXtk7SW+lhpkpMRDt
         2HavQ6Zf82hKbHVK/BP2bgRLw4TkRw5J9k6Nhwn036TZWqGkOxnMsUncSdUnYWcRE6PN
         BzUEZ0ybV50pcV+GXrRKNv3/8/0A6H68VIEBblGtQ8MTnxKTc09PhOOA1Glga8Q88lKC
         KT8g==
X-Gm-Message-State: AC+VfDzjV7JP/cNwp+09lYtqp5yAsQPeepSSJEmTYsClGR85UQZQ0Mkp
        5obBI8OHNcfinWBKXU2Yr44=
X-Google-Smtp-Source: ACHHUZ4QA5CeMfItNvb6CUzhgyiSshhiQxO/S1j7j7mulYZ+gEs9Qgp4gDjmd0Bcx6LPRvCKV7QNaw==
X-Received: by 2002:a05:6870:b791:b0:19e:fae6:c9ab with SMTP id ed17-20020a056870b79100b0019efae6c9abmr14852503oab.57.1686837051941;
        Thu, 15 Jun 2023 06:50:51 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t14-20020a4ad0ae000000b0054fd0b7af2bsm5988465oor.31.2023.06.15.06.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 06:50:51 -0700 (PDT)
Message-ID: <0b7d1e30-52ea-c4cc-d0fd-f879cd67ef3b@gmail.com>
Date:   Thu, 15 Jun 2023 10:50:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230614180837.630180-1-ojeda@kernel.org>
 <20230614180837.630180-6-ojeda@kernel.org>
 <49dad8fe-c509-6c43-559e-13a82563d3d0@gmail.com>
 <CANiq72mq4wYJ77qDKYWTO=FkA1AYat2rJd63Gps9aUrP82c9dQ@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72mq4wYJ77qDKYWTO=FkA1AYat2rJd63Gps9aUrP82c9dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/15/23 06:23, Miguel Ojeda wrote:
> On Thu, Jun 15, 2023 at 5:52 AM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> I can't remember that if this panic it will mention the path on it.
>> Though if it does, then use something more explicit than
>> `.unwrap()`.
> 
> It doesn't print it, and I am happy to make things more explicit, but
> in which case(s) do you see it failing?
> 
>> Please do not use unwrap here, one can easily create a path that
>> it's not compliant under `rust/test/doctests/kernel` and get no
>> clue about where this script has failed. Use `.expect()` or
>> something else instead.
> 
> The folder is removed every time, so that should not happen I think.
> Yes, you can still hack things and call the script manually, but I
> wouldn't call that "easily".

Ah, you are right, I've forgot that the folder was deleted and
remade, and because of that an error is more likely to occur at that
stage and not while `scripts/rustdoc_test_{builder,gen}.rs` is
running. Thus.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

> 
> Nevertheless, I am happy to change it if we think there is a risk,
> e.g. `rustdoc` changing the pattern (though we pin the version so
> far).
> 
> Thanks for taking a look Martin!
> 
> Cheers,
> Miguel
