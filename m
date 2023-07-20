Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B802875AB86
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGTJz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGTJzz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 05:55:55 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CD5ED;
        Thu, 20 Jul 2023 02:55:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so523958276.0;
        Thu, 20 Jul 2023 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689846947; x=1690451747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FLg5w4lDWIr9h+nDTSVvwZ06StSjnLpOQ138ZfnB4g=;
        b=Fz/oPal1Dl3Txwaou60rukURA8B4NOHCTsLz6Ep0RmTRV6bQ7LNaeYtsW7rynq4i5l
         vZ5nheF4yqXKoNDNnm9UA1JLJponL7SkxVbbo2vgfyQ9DBjBoux6FqalvRGwWkEORCif
         cJ+NRCaoiRBIb67hJ+4zLdBpDGer1yIC2DHbd5Z3K7lb1sIZrE4HN6RRc9YRcWzzgq1j
         Dz8U6aiNzFsXr7XyNjeTU8/OafX3/xm4dhUMuxibjd6A+wLbzwnTKRLW2pi67FMxLC0j
         k95S9iKdUYvb2P3QfnEqZWUrZ+xCuzjtf8C/Cub37+faIF5PAnzy2WH7PeUwFqfc2dqI
         j8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846947; x=1690451747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FLg5w4lDWIr9h+nDTSVvwZ06StSjnLpOQ138ZfnB4g=;
        b=K4d3nlSPdtZs4J3bVeSfxJ++MSBfXUJUkIsnyoQCvb+6b3MKcLPmc9P3gaEqKZpVoU
         sNHY3Fi9g+IogtnO5h3REybaODztp0NjMRRnVZw/8O2W2cQ/7h3nxBxY/Y6ilsz1fHrz
         ggrnVMkCDluRfIYsjGd2T1dgw7Dk0q3HMOi+Rd1cTAnLsC7oXYkImfRq7pxprH1oa3eb
         tekNSzIOxbo0CAq6n/Ho5VVKb+FA4mdXl/1YgJHDl3NVdbpXKawSYz8ZbtFo+gv+3YKW
         TYMs9qSKFSmMA6AdRVaAelfi1dxemDZkiC96XbVq/US0V+69ze2gxA1XAxRmcmyALc0T
         Fwgw==
X-Gm-Message-State: ABy/qLbB3NwKn2uW6QaH21JldogdHcoEgM59+ew8rLokenp+SzWoQsms
        zqYDNA7vzsAnmjH1OzBEegTCL4SKC05lxwDsWz4=
X-Google-Smtp-Source: APBJJlGp5JsBSpSIG7GjjwdK0yzHG9WT2MLhM6tTWhnc6zgjiFpZs4TfhGAum7vV1O8n63oXkYMpIz2EU+WaUkTC2Xs=
X-Received: by 2002:a05:6902:18d5:b0:c12:29ac:1d3b with SMTP id
 ck21-20020a05690218d500b00c1229ac1d3bmr7003409ybb.11.1689846947439; Thu, 20
 Jul 2023 02:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230720062939.2411889-1-davidgow@google.com>
In-Reply-To: <20230720062939.2411889-1-davidgow@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jul 2023 11:55:35 +0200
Message-ID: <CANiq72k5mJDP8L2Mx8xWxts++kwiJXPTk88MTJQOvCiEKRMvYw@mail.gmail.com>
Subject: Re: [PATCH] rust: doctests: Use tabs for indentation in generated C code
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 20, 2023 at 8:30=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> While Rust uses 4 spaces for indentation, we should use tabs in the
> generated C code. This does result in some scary-looking tab characters
> in a .rs file, but they're in a string literal, so shouldn't make
> anything complain too much.
>
> Fixes: a66d733da801 ("rust: support running Rust documentation tests as K=
Unit ones")
> Signed-off-by: David Gow <davidgow@google.com>

The indentation for the `KUNIT_CASE()` lines should be changed too:

diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
index 5ebd42ae4a3f..9623e2e6313d 100644
--- a/scripts/rustdoc_test_gen.rs
+++ b/scripts/rustdoc_test_gen.rs
@@ -213,7 +213,7 @@ macro_rules! assert_eq {{
         .unwrap();

         write!(c_test_declarations, "void {kunit_name}(struct kunit
*);\n").unwrap();
-        write!(c_test_cases, "    KUNIT_CASE({kunit_name}),\n").unwrap();
+        write!(c_test_cases, "    KUNIT_CASE({kunit_name}),\n").unwrap();
     }

     let rust_tests =3D rust_tests.trim();

With that:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Since the changes are within string literals, I don't expect issues,
but I just in case I ran it through `checkpatch.pl`, `rustfmt` and
`CLIPPY=3D1`:

    Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
