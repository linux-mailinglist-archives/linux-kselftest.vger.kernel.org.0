Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17950534105
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbiEYQGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 May 2022 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiEYQGn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 May 2022 12:06:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010FB2250
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 09:06:42 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id p26so27629967eds.5
        for <linux-kselftest@vger.kernel.org>; Wed, 25 May 2022 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Z7Dq8yp4MZDxLPt+EoyHCLTOMSa7x8uy4FDYVoNiio=;
        b=p8QaueAPRVWKJA4gQJtNvb1RI3hm2XqlvoyhUBkOKOs0ML0icz7yfQZdIgAH88OkcC
         rZyy/xrJ7gYt6ykjZBgauo/+mkPVO03fWr1cN0qrOBViqZU3GmFVT3KPTu+bz2OsFWTp
         B9W0E3/m1rt7h8nXPkEvvqV+nkGZdqtBB17T89aoAM0zK42qWDjlqosQBsyD+QJIX4h9
         fXvdSmqqevD/JhyM6H2ZsqzAJ8F11IuyVgIqPyM7TEafgG/5cYab3+oAQfkLVPtCPPox
         CZzwW3Yve4g75uNBuM/C+GQoyk1HaBdggX1Pcwy8FTw/RogC6sz8/c6iSc99qxGmQq7a
         eqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Z7Dq8yp4MZDxLPt+EoyHCLTOMSa7x8uy4FDYVoNiio=;
        b=1m8bybS1tJPRmeUghdC/e82saBDWeV5kIwgYbJqSaarMuIAu1oiVa0baJlUimdB2KD
         xes1S4smrkdAkwMH5CVgOMI4KvmMOV69cFaG98gsiS0vPgQca0PSG1QLyZCc6oJ257o8
         MAX2N9QyrFhwp+Vdqvfm4XggBNQ1rVd/gyLDrBm8abkkPHRG30mQara7h6aprM8d+xdy
         H4pRIdqoJAQ2NHji0O7IO3qSBSQLsRmOkiM9SXFQJVp9f3sEVw3pkmYKLSfrWN33+NC+
         xeMhbXghsgtEFDOA06gYrXwKp8j8YmZ5b26bivlxf2D99lyckXXtnp6nlNp2d1CuZUfc
         qjbw==
X-Gm-Message-State: AOAM533Z2Y1bTXVJF/mSDdikIeHYnwUmM04uCKepJgEIlk9Kv8zbO4lq
        2mJNBJteJwhUn28w+z5tLxJuXTLPVkv0ievcvM7S+Q==
X-Google-Smtp-Source: ABdhPJwnKB+w/ACJYs1idaMe5SwT17w0cNbs0EcsX7aTCwh6DyPsRasoshDoxFrNDisUksS05dbLy/TFALsgD2m86Lk=
X-Received: by 2002:a05:6402:1113:b0:428:679e:f73f with SMTP id
 u19-20020a056402111300b00428679ef73fmr35606808edv.378.1653494801065; Wed, 25
 May 2022 09:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220525154442.1438081-1-dlatypov@google.com> <CANiq72=hRbmHE865bwxQnCn2+kwB5nTaQgGAM0nijJnEL=3TJQ@mail.gmail.com>
In-Reply-To: <CANiq72=hRbmHE865bwxQnCn2+kwB5nTaQgGAM0nijJnEL=3TJQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 25 May 2022 09:06:29 -0700
Message-ID: <CAGS_qxo-HfwSOdOW7WNZb78GebJsdUF1-ka3U2PQb=qg0C1L5A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] kunit: more assertion reworking
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 25, 2022 at 8:56 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Daniel,
>
> On Wed, May 25, 2022 at 5:44 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Note: this does change the function signature of
> > kunit_do_failed_assertion, so we'd need to update the rust wrapper in https://github.com/Rust-for-Linux/linux/blob/rust/rust/kernel/kunit.rs
> > But otherwise, I don't think this series changes anything on the
> > rust-side.
>
> Thanks for the heads up! I can take care of that.

FYI This probably won't need to happen soon.
I'd mentioned the idea of patch #1, which changes
kunit_do_failed_assertion(), and Brendan didn't seem keen on it
before.

But the diff should be simple, e.g. just something like this:
@@ -38,9 +38,7 @@
             });
             static CONDITION: &'static $crate::str::CStr =
$crate::c_str!(stringify!($cond));
             static ASSERTION: UnaryAssert =
UnaryAssert($crate::bindings::kunit_unary_assert {
-                assert: $crate::bindings::kunit_assert {
-                    format: Some($crate::bindings::kunit_unary_assert_format),
-                },
+                assert: $crate::bindings::kunit_assert {},
                 condition: CONDITION.as_char_ptr(),
                 expected_true: true,
             });
@@ -67,6 +65,7 @@
                     core::ptr::addr_of!(LOCATION.0),
                     $crate::bindings::kunit_assert_type_KUNIT_ASSERTION,
                     core::ptr::addr_of!(ASSERTION.0.assert),
+                    Some($crate::bindings::kunit_unary_assert_format),
                     core::ptr::null(),
                 );
             }

The only tricky bit will be coordinating the changes :)

Daniel
