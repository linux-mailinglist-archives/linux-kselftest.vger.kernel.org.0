Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901097313E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 11:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbjFOJbw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbjFOJbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 05:31:51 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716801FE4;
        Thu, 15 Jun 2023 02:31:50 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so935970276.0;
        Thu, 15 Jun 2023 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686821509; x=1689413509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di66cKm4TSNTvyJIxIEt8peXod16WLfPyBmGUqyjx8A=;
        b=e02FzfAAe7TAzqPFI1NcUDpyeWS8RO+q/51tmwLU9bP2Ro8bCXmKckt2kbm2ZjdxCy
         fm3Pq8acrGSYhTJgQHto02XStVs4+X5cV9PGaXc5+msESCBYpbGe15S9IQI/7XBPHVwD
         Et5+5hXyrvQPTLNccgcN3v0KHj6OJrr6m910qVknvd6M1PsQ+viNQr5lzG39v3MJhpV+
         Jk5Is0s1GXsPATCc/FDmcNqhY6QK+J+ADjZ39RCzK4j9Fzi3I6gdP8DKLx6Hawkw6Voo
         7D+tt1yiS0+fP1ivNHykUxMZEcYv9lcgG8NSDc/OBAluZG/NvPPUlVzz58O3TgCAw9pE
         +BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686821509; x=1689413509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=di66cKm4TSNTvyJIxIEt8peXod16WLfPyBmGUqyjx8A=;
        b=hLXr9lYrFf949tDJry5TGLoN3b7PKL2eXXUde6th7gJtO00G7E5bClJB1RBI3DkIND
         3iGkWzBYuVrkKr2hpcrmwr0FGnfo7SEXb87KxJ7zePyjx4LfcL6PyGsk0phcCO3pWWwR
         H2DHF1Hdd8yLoweqxCzIOFNpqzmQxzEj8112OLgWwLpvVprjUqTQSRDI6aclztquGw9k
         OOC/4Y0JgEGU1UW36nH+Wcl+GsjrcOadCiHFaEjIj6Yt8kscyuvlmuFiv+h/xCo11XnZ
         vDUaWNCNwwujXwE1BEw5eSKBQjWpC5lXgwB2rwyb59EO7utiG3YQ3geOJTjztq6/ykCf
         Jokw==
X-Gm-Message-State: AC+VfDwpXhdUORt4naWuPgnJRZiDjaIOVr6t6rRa9lEgC6yiEuY9ceBp
        AYGnlovje28JL3bPFhq7Hi1LIkwef57GKOZcOlGiZRzIYmQ=
X-Google-Smtp-Source: ACHHUZ6gTgwthX4La0xbY3vwt2dDYdqybB2xqWiZHioIDURaKg4OHiGOZ2lS1gUUCClyR9i4ST922OsezwVW9+gw8oU=
X-Received: by 2002:a25:7316:0:b0:bc4:f2e5:5343 with SMTP id
 o22-20020a257316000000b00bc4f2e55343mr4915969ybc.28.1686821509582; Thu, 15
 Jun 2023 02:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-2-ojeda@kernel.org>
 <2b4b23ce-316e-b998-7faf-e529b121a8b4@gmail.com>
In-Reply-To: <2b4b23ce-316e-b998-7faf-e529b121a8b4@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 15 Jun 2023 11:31:38 +0200
Message-ID: <CANiq72mApAXEtoWgkaLvZJu6gn=9CkyogRXVfbYxPsR5TeFUVQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: init: make doctests compilable/testable
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 15, 2023 at 5:52=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Little question, what's the purpose of `FromErrno` here?

It was because `Error::from_errno` is `pub(crate)` in the `kernel`
crate. I should have added a comment -- my bad! :)

If we decided to make it `pub` eventually, then this `FromErrno` hack
can be removed.

Cheers,
Miguel
