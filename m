Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A97323D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jun 2023 01:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbjFOXrI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjFOXrH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 19:47:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2E2D54;
        Thu, 15 Jun 2023 16:46:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8d2bfed53so1456155e9.1;
        Thu, 15 Jun 2023 16:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686872814; x=1689464814;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cok297KiEkBtIanAPvWodXIpSbY3USJpVP/auvzSoo=;
        b=GEWzOBjU9+uklUn8K1KiJ3HxTLmkUx9v6wLg6ny+j7IskV/jkFniTlJAR6uk0Mo868
         vwY9L0y1g5vpjAyb8r8/zSzXxy0QmvoUcmMGtvPi+2QIUpWX4xbvNneZ2FyvCIHm6sPu
         Dnup7WCuPXYJeUH+qFJmRSZV0vZ+UMxleSRxKdWMkguwHbsEclDn8fVAR38HQErwoY3F
         kYb2oyV43zb+19M5owAo2K5GZat+mnwtrzY5lKzMCKjajvjJuY96IOakuJfxQZyFB6ym
         taMzqIhTty0uhkNglC+ytKNqpjZF1aHvH4hwhZo7cwqUDkaog3xC1YBLkD1c88S+KEJN
         9NGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686872814; x=1689464814;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+cok297KiEkBtIanAPvWodXIpSbY3USJpVP/auvzSoo=;
        b=GYNfBZqCSZqPNsREyCyH8fDGatKXtVoFh/PG/w8inLUc3coq4KFHGpqZzv1/P4TNAh
         0pnMNiqeFDRzvskU8dx+kw3qLXEZYo3yZm2j8mWZDQR+qGOwSEGa1WQXXqT4pNUpiaoX
         OIZuUkCUdqK9uyxHrM6qehccHVFgG39BdRdVEB1LVRc/xV2sSpK2wGRHiZEjvRWjN9ox
         Nf03aC/07YZ4l1KBHUHGLSREV4plWa6/ROo1bIsxJEs/g4pVi//+j6sleFHKFTtvXUvW
         TtF+LpkblWwgK24aDI7fUfsCpXh4kC5WaDTXBiqKUNRcWranWQVCCwe+61h4YO8velnA
         2b1g==
X-Gm-Message-State: AC+VfDzKj7DchPAPT7WnzojQiFg5NpSP7A1Jhusib2P7jW3PwcAEZ/9E
        wnVmnZJ/cL79hNAl6wBIh68=
X-Google-Smtp-Source: ACHHUZ4McPXi8/B0MVcUFH60m4X3rhsNMsiSCE1318ihls99X0Jo2hKc8kOG6o63XEtNWhnh5HVF3g==
X-Received: by 2002:a1c:f616:0:b0:3f6:d90:3db with SMTP id w22-20020a1cf616000000b003f60d9003dbmr194999wmc.3.1686872814417;
        Thu, 15 Jun 2023 16:46:54 -0700 (PDT)
Received: from localhost ([146.70.132.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003f4283f5c1bsm14034217wmq.2.2023.06.15.16.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 16:46:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 16 Jun 2023 01:46:52 +0200
Message-Id: <CTDMI7T6JJCN.3PY8NVQ79IMJM@vincent-arch>
Cc:     "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Andreas Hindborg" <nmi@metaspace.dk>,
        "Philip Li" <philip.li@intel.com>, <kunit-dev@googlegroups.com>,
        <linux-kselftest@vger.kernel.org>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 6/6] MAINTAINERS: add Rust KUnit files to the KUnit
 entry
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "David Gow" <davidgow@google.com>,
        "Brendan Higgins" <brendan.higgins@linux.dev>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>
References: <20230614180837.630180-1-ojeda@kernel.org>
 <20230614180837.630180-7-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-7-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> The KUnit maintainers would like to maintain these files on their
> side too (thanks!), so add them to their entry.
>
> With this in place, `scripts/get_maintainer.pl` prints both sets
> of maintainers/reviewers (i.e. KUnit and Rust) for those files,
> which is the behavior we are looking for.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>


Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
