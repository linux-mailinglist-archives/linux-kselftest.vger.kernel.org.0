Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4917323DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 01:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjFOXsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjFOXsC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 19:48:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9FD2962;
        Thu, 15 Jun 2023 16:47:51 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so29326e87.0;
        Thu, 15 Jun 2023 16:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686872870; x=1689464870;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yf3QILbJ9sRzhzF2PoMYVw4hbclOb2Vg8iQx5dyLYzo=;
        b=S4+7X3x1MhqFzqF9Pbyo3LB9150OMrfgzHssXAOFbs+kKShkgkyJgmh0sj0Oa2pW2I
         LZYMhJpAa7c+4T9SCC5YTnJi+scaa8sjVadtbIwe0BtYwEkrotPDh2y/q69n8WPqPVqh
         oniQbg9blKOTUba17yBY2EwEGVmOFpoCwoQgR6UrZCQBxiwX3eMO5DL3kVNmFg6EeHng
         8KKXap7ppdpqZQu5oDYb6/N+MaaAq0FPoTaR+gEoAikK5YP3r1snl3qcwCguTat3QDIY
         /aggYUfMCjBfVgwe7IAq+Maj3aQAGdS5zZDoSZ6kyuyGL8UQuS5ZUbekPdToazAjSo2V
         H3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872870; x=1689464870;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yf3QILbJ9sRzhzF2PoMYVw4hbclOb2Vg8iQx5dyLYzo=;
        b=L/VpufAbvrYxKY6QsAH+NF+sITNHwqdjUZ7rfNdJyWMjIW7iJjhxbKWyWOPVTBZXBY
         grznIzoQR2l9cc/oZBIXEpOoyBQQ+Msfflp3CpHqLr+cZmFS5G4i0p++GWrpKutcrkQH
         Prp7+40Zx8ufH8ZL+fl9ZcExLhCAoU+se0t/OoeZwjAVqL+J+1jzJzclapbgj4Aua5dE
         HxjetW4U1gK82MGkCnqxgP/2oHAYxf6yPU5IheqOez/p1l77UwlLLDOnNoEV7fqQYWaZ
         fNB4s3seE1OJhhN7ZcrEKj5Qdncbu8VRHbNKuh9DgZtJx3ePN88BkkJB1xmJvSC4ViR7
         vwmQ==
X-Gm-Message-State: AC+VfDzNddjttJtGfhNTi8AeMW/ZpauZrZ30hKmMkI4ra0FuAeIncwJk
        b1F6n5Y3w4gCHm9lBwpgI24=
X-Google-Smtp-Source: ACHHUZ6YbWrh09j2k5T+J04sVygSmkwhQcbZT+VQj3PFb8ngeE1UFNS0aCe1XG9mA4jGqpqCcLpvxA==
X-Received: by 2002:ac2:5bca:0:b0:4f8:4263:433 with SMTP id u10-20020ac25bca000000b004f842630433mr94075lfn.66.1686872869344;
        Thu, 15 Jun 2023 16:47:49 -0700 (PDT)
Received: from localhost ([146.70.132.158])
        by smtp.gmail.com with ESMTPSA id y3-20020a5d6203000000b003062c0ef959sm22130703wru.69.2023.06.15.16.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 16:47:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Jun 2023 01:47:47 +0200
Message-Id: <CTDMIX08TTIR.AM5Z9I4YE6XQ@vincent-arch>
Subject: Re: [PATCH 2/6] rust: str: make doctests compilable/testable
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "David Gow" <davidgow@google.com>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Andreas Hindborg" <nmi@metaspace.dk>,
        "Philip Li" <philip.li@intel.com>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230614180837.630180-1-ojeda@kernel.org>
 <20230614180837.630180-3-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-3-ojeda@kernel.org>
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
