Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27358730DB4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 05:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjFODwU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 23:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbjFODwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 23:52:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F0B26B6;
        Wed, 14 Jun 2023 20:52:06 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b2afc1ec49so277226a34.0;
        Wed, 14 Jun 2023 20:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686801125; x=1689393125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvOg6IfbDqELoJ+xhmzfRwP+bYiifV5+pLJQKyD2w2k=;
        b=mc/lDSJlyiOvuCU0/kkMoWp3+Qa3gQ1ViKUT8uc95AOn+AXSA5VSlE9WJ1HQsI7IRr
         KsmRtH32ZHgQ4Hlv1g/oF8L2iDIIx7orxQ5HMr3hX7c/wVvv3Zb3KLCqtLi/xaYUs1Jc
         h5iBQaoFu/IzLJ8Xyuu7R16T4cTqd4AapakxQRGDTODajej2QnBCVWmUigc+nMjqpqL5
         nwj/W2K5CfTbZd+1mQUX42cy4tjkMzMnBj6Cc1eUPQM1hxf6QaKXCHH3b7yEUPBFf1gl
         3kLL4Si6UgrroKc/LniXIXnP9lNLVwR4AMPQf+W2WQ9GcKfzDJzxy60Z8VNK9EctvHwd
         6RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686801125; x=1689393125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvOg6IfbDqELoJ+xhmzfRwP+bYiifV5+pLJQKyD2w2k=;
        b=f7zqEWt64ExCeHTzMrjG2ikhkRDLCnZPp1I0h3K1UktbbhUBQ/A2NPhnFUlQFbf+01
         zJkerYjngltq01yK3vz+wClzhi78CKsTOGxIZkLCyuw2jb5XEPptXxozjb/hBfIjuJ8J
         aT9Dd+tZi/2J6Ry5znaBOhiwG1/Hzr7qOKqIpwpRAyO0BGjT0M50e1VeLNpffVTu0uYI
         NOdEin3z5pHKOokHAzYZ6tCfwSBHjLcK0ziI+EccVkhwawPPHl/DjhEw/pNi2rBnAmGr
         PAA/xedwhDwe1y4a0kpWYyjjUzclB+36iKirZShQ/C4S9CUAPrdPKRnmAgWuvqVQKArB
         +3ZA==
X-Gm-Message-State: AC+VfDxe6APS9kCVkdyJNBmysoohtwthIG5saTDpEvu63/8YFBD8qbpG
        y2A7d//6AmNjEIcbi3+J9SY=
X-Google-Smtp-Source: ACHHUZ65QNp1nT4Po7nJM3CDNMKAiSKyD8qHADr54qw8cYq2P0sGXMiG2Eur0+P3JLDKa0U6gGnshw==
X-Received: by 2002:a05:6830:6112:b0:6b4:293e:b99a with SMTP id ca18-20020a056830611200b006b4293eb99amr2953804otb.9.1686801125584;
        Wed, 14 Jun 2023 20:52:05 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id c8-20020a9d4808000000b006b296562566sm6338554otf.79.2023.06.14.20.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 20:52:05 -0700 (PDT)
Message-ID: <2b4b23ce-316e-b998-7faf-e529b121a8b4@gmail.com>
Date:   Wed, 14 Jun 2023 22:03:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] rust: init: make doctests compilable/testable
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
 <20230614180837.630180-2-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230614180837.630180-2-ojeda@kernel.org>
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
>   //! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
>   //! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 { 0 }
>   //! # }
> +//! # trait FromErrno {
> +//! #     fn from_errno(errno: core::ffi::c_int) -> Error {
> +//! #         // Dummy error that can be constructed outside the `kernel` crate.
> +//! #         Error::from(core::fmt::Error)
> +//! #     }
> +//! # }
> +//! # impl FromErrno for Error {}
>   //! /// # Invariants
>   //! ///
>   //! /// `foo` is always initialized
> [...]

Little question, what's the purpose of `FromErrno` here?
