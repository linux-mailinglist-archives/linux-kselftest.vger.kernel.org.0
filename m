Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84969730A66
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 00:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbjFNWJN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 18:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjFNWJN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 18:09:13 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFDD1A1;
        Wed, 14 Jun 2023 15:09:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bd6446528dcso1070710276.2;
        Wed, 14 Jun 2023 15:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686780551; x=1689372551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZY8IYbBCwqFgvXl6puz847AvvCr9iy7X2X1F65i07c=;
        b=qo4/gsWJ49ZV1RB1v9Hag7fSKofMhHFr1Yb7+yLi+CrZbmi+/fIuin5MH/8Tl4CNnz
         4Z4+5viyR5gSk/SfWjh28CJRg2X5Rqf/91o3cpPKNlrAyhS8+kWcTkk3P+mYEC10xVb7
         4NjuEzf/rN8Xe/iB1VoTALNNo5Auue5tlDCL2gU576oMLQMNboy+JhgiM124otpssHvs
         UIeupf1PHsM7N/nBZXDLJXE5bzSdp6XHcNGF/6qqnmGF9y4ZD1L7f2GtkmH98pBzvRMy
         QoChaQyLB4L2h39C2PAotdwpDz+S6fUuk/K7roJFjOV9qXwCNkfs7/HB+MvA5PxRUiOK
         iXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686780551; x=1689372551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZY8IYbBCwqFgvXl6puz847AvvCr9iy7X2X1F65i07c=;
        b=ZeviJZ4EBXRRp7DcLwguvAa5U0P5cbEKzZDAJtQn7R1tLC/NExs/NaMfGiK47aQ6km
         tUHo4nuWk/7xJhhmqTrtQAsRzxwkr/hTn+HMOrmerGMk5e9drPEtNqRtitBqt+W88OOA
         2tM3rpdDS9lh43j3ad6Fn1iJr1HiD2cdIcvYwbN+fIhTTis2E+Rjgf6CQGU3t2un5KGD
         5n1IFONCcFuR2qGIMrYszVAzpHNc+v2uTpPNpsvCKtSWtt/uRwC5QS472kRNkCBX0OIF
         WU+e0kktCLnoud1Lx71QO/uKbj3l2KvLnYg/j95p2Fsue4/6D9XcGLVVgdUw2X7exQOO
         oBww==
X-Gm-Message-State: AC+VfDyezzAU7b+9bI35l/ZtvpchhVahjzbkU8rL0dGI8FCHVdvH6ufM
        bEQOpeHo6mgRMxXuBzQuSkCEFAUZoxbq7qtspGo=
X-Google-Smtp-Source: ACHHUZ73VU9isra/qJrbZ9eQzPjDJFWewvwYjUqCmdZqS2Lkk2a0g9gKp33Fa1FYuwamE3ks65eoCOh+SYJDegLKPVE=
X-Received: by 2002:a25:d86:0:b0:bd5:ddcd:bc9e with SMTP id
 128-20020a250d86000000b00bd5ddcdbc9emr3275028ybn.17.1686780551502; Wed, 14
 Jun 2023 15:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-6-ojeda@kernel.org> <20230614203803.2910957-1-aliceryhl@google.com>
In-Reply-To: <20230614203803.2910957-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 15 Jun 2023 00:09:00 +0200
Message-ID: <CANiq72n-WocEegVc2-Em6muU4pOTOh+Lf8RAwiAtjuUUjnysbQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     ojeda@kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        brendan.higgins@linux.dev, davidgow@google.com, gary@garyguo.net,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, nmi@metaspace.dk,
        patches@lists.linux.dev, philip.li@intel.com,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
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

On Wed, Jun 14, 2023 at 10:38=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This could just be
>
> std::fs::write(path, body.as_bytes());

+1, simpler, less `use`s needed and less size:

     320429      12736        368     333533      516dd
scripts/rustdoc_test_builder
     314701      12440        368     327509      4ff55
scripts/rustdoc_test_builder

Thanks for the review!

Cheers,
Miguel

diff --git a/scripts/rustdoc_test_builder.rs b/scripts/rustdoc_test_builder=
.rs
index e3b7138fb4f9..e5894652f12c 100644
--- a/scripts/rustdoc_test_builder.rs
+++ b/scripts/rustdoc_test_builder.rs
@@ -15,8 +15,7 @@
 //! from that. For the moment, we generate ourselves a new name,
`{file}_{number}` instead, in
 //! the `gen` script (done there since we need to be aware of all the
tests in a given file).

-use std::fs::File;
-use std::io::{BufWriter, Read, Write};
+use std::io::Read;

 fn main() {
     let mut stdin =3D std::io::stdin().lock();
@@ -69,5 +68,5 @@ fn main() {

     let path =3D format!("rust/test/doctests/kernel/{name}");

-    write!(BufWriter::new(File::create(path).unwrap()), "{body}").unwrap()=
;
+    std::fs::write(path, body.as_bytes()).unwrap();
 }
