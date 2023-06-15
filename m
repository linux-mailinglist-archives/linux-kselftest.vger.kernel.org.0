Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE7730DB9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 05:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbjFODwa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 23:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbjFODw1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 23:52:27 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D1211D;
        Wed, 14 Jun 2023 20:52:26 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a2c85ef3c2so6052911fac.0;
        Wed, 14 Jun 2023 20:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686801145; x=1689393145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+dev0gi3mOMoRwFhsdS2OBBCly4pJkh/R4J7IbY+Y=;
        b=HMGneszKZx3DqzPLVRN595fUIlQMoOFQ2J56MaxufPmvXS0GSk7iYI/Y413o+U8WSg
         3m5z1Z7pA3YIuC9U+f7iTixOyu86MN6n6BFpoQGHM7MxYMcKi2QYMgjbEnIQtit7w5e+
         gVS3WQLbjd8+e52iDqi8iKlHgihvS59TvHn1X5CLif0MTYKiB7/4wn0H5He6nP8+z2VX
         HpqeNxJ2LkRDmYxHO5FOudd5jNTiMEkEDfCut2loLTffQ/54fU5pxQ598SuYZjbFMfTI
         aP0OJt7MX7iUNd1yjIx0NnvetMXGv7R5lkye6tLEu9Mpz9rxkGRhTl0Zycv2WELM559s
         CORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686801145; x=1689393145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb+dev0gi3mOMoRwFhsdS2OBBCly4pJkh/R4J7IbY+Y=;
        b=KnzSznMXE610lDEKX1aknPnyfLdjvzdoNtLXdqvlMAnnS5T7hsPghhazy5MqFkMZF6
         QUlGCdMG2n5HKcCXK3qOif3V5rK8SdwELCnS/Ci0s8Y/74MI/crgqCBTJAgDPZqmZguO
         LwZfkUvsrrBDM5IbfoG4emLMFSBX3t+LaZvZUgbtov4tA6RlIgXB/wnQA7Lqh1hdCqU0
         Fkd8A+eTuLV8JN4flXYrKhtYl3+yq5VPaHdVSdHJINdBJe4L9ecqkJMsNPmZUi5O7YPE
         2bnVuV36a5IVCodlgLJmiZ7BzPHDXPtnxeDxSPmIawEzCGqe1o4cw/Qc5/8kBhge+DqU
         yGFg==
X-Gm-Message-State: AC+VfDw/AiZO1KYKBjgQCS2Dagb6mkFBYQDMIGz/48KIAHPI8/U7WmDJ
        ie4DRXR2eA9uHtpHUS/ASRE=
X-Google-Smtp-Source: ACHHUZ6ObkR3NCdWKvmSDOzhkha4QMAJLH4kdLTv1KHz+3JqI8z5nQ/R2og8O4aQ3HTjlnYq808aOQ==
X-Received: by 2002:a05:6870:c355:b0:1a6:67e2:6ea8 with SMTP id e21-20020a056870c35500b001a667e26ea8mr10791546oak.36.1686801145472;
        Wed, 14 Jun 2023 20:52:25 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g17-20020a056870c39100b001726cfeea97sm9606098oao.29.2023.06.14.20.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 20:52:25 -0700 (PDT)
Message-ID: <94de067c-e848-cc3d-406d-e9d7e14dbfd1@gmail.com>
Date:   Wed, 14 Jun 2023 22:06:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] rust: types: make doctests compilable/testable
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
 <20230614180837.630180-5-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230614180837.630180-5-ojeda@kernel.org>
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
