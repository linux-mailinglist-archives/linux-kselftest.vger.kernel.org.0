Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E557323DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 01:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbjFOXrc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 19:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbjFOXr3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 19:47:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770932944;
        Thu, 15 Jun 2023 16:47:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8cc04c2adso390185e9.3;
        Thu, 15 Jun 2023 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686872845; x=1689464845;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WubxQvcgIlFA6V3TisKRN4J5Y421r52QRaGOsMXM65Q=;
        b=eCNmD3yBq/LG530po0EXJGex/14UifXn8/8oZ2uRDyigOyhZRUtX2eLTaBD8dnj2E6
         HVTppvGSLfb/begoPnzgs9rapuzDzYHxDsrNVZJB0OYvH1Ha1W3msZU73nvmWQMaCbJ5
         Ic/BE6dMAAmlXQq560lu7sKpyUWQhSSjxk/aMaECF5wCWuFgp7J1PWkBQ5s2c48sLW9v
         l0tylErb4d4R3Z7+iBw8A4pTbcdT2jf/BwOaUI/C2iXq3wVKc7MVN2XK+qsWiwHpNHEZ
         e6PlPH2PzzKAtMttQpbryGZUuM/LWYcpvMuDdxUEYQURHIgvK8Cho8Uns2wSyLXKQneO
         sEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872845; x=1689464845;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WubxQvcgIlFA6V3TisKRN4J5Y421r52QRaGOsMXM65Q=;
        b=gwrO6TxB23HEdl1eDvSIce/W1rHW0Wm8xXdTqdn+aUTlA3Bj1NGXqXMOXX3cGF5cXp
         jiR6k2JNtKafzx3dMlzYu5SZF88qN9+whBUE6YxX4XjJLNNgMOTsxmE70Hwqp31NhkEE
         LHB8+iSGsefC6YDfQSPQLITkBvPBelwG12hfcRWqXp5m4xcXrl5xqk/8UksgSjKrA0Iq
         yxWzLsu84OwDJDlf6e40KVBl8RR0nylfNl4r4hDFp3LD+GjWfCiu6PJWXNKRzzJuKtWV
         wuvnAL4pNtlyZuPf/7zVQ4ob6t9nh+6OKbg4lLtlIoHIYG8nuq+aPeEmUuyE9sDx7WtP
         TJpw==
X-Gm-Message-State: AC+VfDyG65UzNBmI9o2TQ2mtGNMOLkb7Dai92Bl0WQR2Sk6EOB2UkoN5
        EebMMwCB/fhp0FUW1iKIYow=
X-Google-Smtp-Source: ACHHUZ4uQRZfrrUrBPSxeJd4zEcpjQy3rY+wEE0NAjHeOBQE3IquEFE26e0hbiX7l8ujfqF4X565Yw==
X-Received: by 2002:adf:f811:0:b0:311:17af:df96 with SMTP id s17-20020adff811000000b0031117afdf96mr182992wrp.44.1686872844729;
        Thu, 15 Jun 2023 16:47:24 -0700 (PDT)
Received: from localhost ([146.70.132.158])
        by smtp.gmail.com with ESMTPSA id e40-20020a5d5968000000b002fda1b12a0bsm22249612wri.2.2023.06.15.16.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 16:47:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Jun 2023 01:47:22 +0200
Message-Id: <CTDMILRDUJ0C.385MPE3EIPRUP@vincent-arch>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Andreas Hindborg" <nmi@metaspace.dk>,
        "Philip Li" <philip.li@intel.com>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 1/6] rust: init: make doctests compilable/testable
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "David Gow" <davidgow@google.com>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
References: <20230614180837.630180-1-ojeda@kernel.org>
 <20230614180837.630180-2-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-2-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Rust documentation tests are going to be build/run-tested
> with the KUnit integration added in a future patch, thus
> update them to make them compilable/testable so that we
> may start enforcing it.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---


Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
