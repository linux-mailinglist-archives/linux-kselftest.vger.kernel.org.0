Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC0730DB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 05:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjFODwX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 23:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjFODwO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 23:52:14 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E52706;
        Wed, 14 Jun 2023 20:52:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b296cadbffso4485100a34.2;
        Wed, 14 Jun 2023 20:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686801132; x=1689393132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+dev0gi3mOMoRwFhsdS2OBBCly4pJkh/R4J7IbY+Y=;
        b=duuH4kCz0axWUugesyNEbfAcxNNK6xxrhiicP4rIRpHV/4McQs7u01KdFYhipuSAs1
         7nDTNHg/cA6fsfj6MbQYZmSPvYM3GzklsgkXFS30iJI+uVQl5ZHtubD9m2rURYjmXEwM
         ISKhebj8DWINJ58qW1mFlUSeeGm3kMNe5592NaHDrFC+NR9zTwDQXGKREoKrzR73auC2
         xmTl36iu0vFJWzgLTYMPZNKlcw80DOqjZj5bBA5o3Y8dKSidawbghKWevxQkqs/UsF2N
         ZG0Vnn6+IAycTwdxZ//bkpg2/KdnZf5Hu1FyLdX7PFaP+NWDexVAEabA3jkiCR7Khz3K
         WLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686801132; x=1689393132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+dev0gi3mOMoRwFhsdS2OBBCly4pJkh/R4J7IbY+Y=;
        b=FTj7XhMWV2E+i+BAMKiAje9kCfsehHban7RCjZv5BemPNmXmAG1wU5pN0vJsXc1/di
         xxgt7n1Q7VgMKoFZyknL0OXHGEyTMNyacTMXgV+/JYRfqpM1xwoOkOJNLPmZSibWF74N
         uMgT80R5Ue6XqWWBDZyQ4HlKCsNL9NUo8TagQ7ifI+P0anbv5M7AJrh3T/nTmA1D/PvU
         vOke9809m9HJvQK0+Fr/ERwfmdCV8nLQghp1UNTeLO4xwiEoPnGebgHSIC54FUQmY/gR
         wxNp9N1oItwwG+u8Thk4wBKqwsJUeCoG+uzI0W8ttN6ukRahtv3bwZbLoLZ0B+wgy2Le
         XfMg==
X-Gm-Message-State: AC+VfDyG4XsJ/Ez2gkTDL3MphFhXO85Ph23kaAbI1aAEvVfTurRKaZcl
        mMQq8Jx/JdFR+5kGNNP0PyQ=
X-Google-Smtp-Source: ACHHUZ4xd4qQiOULvIWnC2Pwt8SpZGQsc1HXIoSJymjTcE7P2FOSgLsK70rNERPHvqAsONGm/ndlKA==
X-Received: by 2002:a05:6870:7715:b0:1a6:8f83:bcd7 with SMTP id dw21-20020a056870771500b001a68f83bcd7mr8351111oab.53.1686801132318;
        Wed, 14 Jun 2023 20:52:12 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y17-20020a4ade11000000b00555907ad82esm5650922oot.14.2023.06.14.20.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 20:52:11 -0700 (PDT)
Message-ID: <78df9732-6b70-3e75-75a3-303fd1477c71@gmail.com>
Date:   Wed, 14 Jun 2023 22:04:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/6] rust: str: make doctests compilable/testable
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
 <20230614180837.630180-3-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230614180837.630180-3-ojeda@kernel.org>
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
