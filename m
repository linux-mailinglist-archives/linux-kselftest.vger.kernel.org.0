Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8697B8E70
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 23:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjJDVCi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 17:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243833AbjJDVCi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 17:02:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C0B8
        for <linux-kselftest@vger.kernel.org>; Wed,  4 Oct 2023 14:02:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso4217a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Oct 2023 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696453352; x=1697058152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRnzUT3DiFSeZdax6GSEDOPt9Ko6V8xM4p4KQTX8gQM=;
        b=Jpz0IKEeD3EUQQPh8xSj9RBwF6HOOHeaoLnUjghiMo+9p4Jsb3wifiJit8zrz5Wxj9
         I3TajWmBKu9/Py1rN/zoBWruxU8iqkxBhrUb0o3KyQAroBdEpNQ7hhzQUypqSr1XewtJ
         04T1/bekDk0O/vvX+w+EoNwGbf3NtCxKeszscun9mF9b6RTqKZAPG6KeA3Zhaa70Ctv5
         OsRpNShZcE/IPAUJ7c1jlezVQbtMCXBYxnxnTjmSww0db99ehKvqAvxdF+NBaQ/WR4So
         B0Pej4iN8sk4rcxt/ASQGvfngMjLonZaz4NfXjdaBYf0OHqvtuso9n8gn+OyOBn20F5u
         0PFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696453352; x=1697058152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRnzUT3DiFSeZdax6GSEDOPt9Ko6V8xM4p4KQTX8gQM=;
        b=GImniAK5mZ+GJ1ce6XOuUKDimFfh3lgE3Hf7pMx3gTItsiHXQBIz7/VhV3LRWoWBAA
         20fUz3exw7FI0H9/WkpdcR6rOPjevBsAH828CsvYjRJUBTNM9fxG03feeUP+bd6xodbK
         QyT+/ILCBnikE485vZ8ImNiY1rajFS76XnXs6OwcbWxseDWDrDHin9RGeHp40kI3/8QP
         H/YEiTTs2zvPZB82OoRw3TE3W0Cv6ZmlxOaCwmvoUAWsTO05MFZBP18KdTEkJmP5NpPT
         SYLR092OJ0K023FBlxoppaltiBDRdbvkxQzarVn8F99mc9d9DLlEUHMMoZ4nMduRpTpx
         RPvw==
X-Gm-Message-State: AOJu0Yygbb3Bkhk2HrKWa84Zw/0m8vwtfsF1VAV+f9bO8GZ2CcswhuN7
        8GQMdH0OTPP0oXwIjfSJLRQK5tORcQ7lBAo0jBXSVg==
X-Google-Smtp-Source: AGHT+IE84GSS/iaLmMLhqaakOjqpH+gHmbYHtpAwuemCdFmEQD71KL2K1PGTnZ2hMmrcVM1c17JPkaagAEKGv1Sh6EU=
X-Received: by 2002:a50:c04a:0:b0:538:1d3b:172f with SMTP id
 u10-20020a50c04a000000b005381d3b172fmr5363edd.3.1696453351865; Wed, 04 Oct
 2023 14:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230908213148.3610108-1-rmoar@google.com> <20230908213148.3610108-2-rmoar@google.com>
 <CABVgOS=0coPxNE12EsOb-y-VGQ4hafSiNiVj8sLfCCG8LLz8Vw@mail.gmail.com>
In-Reply-To: <CABVgOS=0coPxNE12EsOb-y-VGQ4hafSiNiVj8sLfCCG8LLz8Vw@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 4 Oct 2023 17:02:20 -0400
Message-ID: <CA+GJov4c0dXjsvC5EoE52RayEvU8KTYMyCue+SuRjx9RHMzoUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Documentation: Add debugfs docs with run after boot
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 5:06=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 9 Sept 2023 at 05:32, Rae Moar <rmoar@google.com> wrote:
> >
> > Expand the documentation on the KUnit debugfs filesystem on the
> > run_manual.rst page.
> >
> > Add section describing how to access results using debugfs.
> >
> > Add section describing how to run tests after boot using debugfs.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > Co-developed-by: Sadiya Kazi <sadiyakazi@google.com>
> > Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> > ---
>
> Looks good to me, a few nitpicks, and the fact that we'll probably
> need to add something about init section suites when those are
> implemented.
>
> (Also, since you sent the email, your sign off should be at the bottom
> of the list above.)

Hello!

Thanks for the comments! Sorry about the Signed-off order. I will
change that for next time.

>
> >  Documentation/dev-tools/kunit/run_manual.rst | 45 ++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentati=
on/dev-tools/kunit/run_manual.rst
> > index e7b46421f247..613385c5ba5b 100644
> > --- a/Documentation/dev-tools/kunit/run_manual.rst
> > +++ b/Documentation/dev-tools/kunit/run_manual.rst
> > @@ -49,9 +49,46 @@ loaded.
> >
> >  The results will appear in TAP format in ``dmesg``.
> >
> > +debugfs
> > +=3D=3D=3D=3D=3D=3D=3D
> > +
> > +``debugfs`` is a file system that enables user interaction with the fi=
les to
> > +make kernel information available to user space. A user can interact w=
ith
> > +the debugfs filesystem using a variety of file operations, such as ope=
n,
> > +read, and write.
> > +
> > +By default, only the root user has access to the debugfs directory.
>
> These two paragraphs are probably a bit excessive: we want to focus on
> what KUnit can do with debugfs, not describing what debugfs is as a
> whole (which is best left to pages like
> Documentation/filesystems/debugfs.rst )

Got it. Maybe I should just leave the first sentence and then link to
../debugfs.rst.

>
> > +
> > +If ``CONFIG_KUNIT_DEBUGFS`` is enabled, you can use KUnit debugfs
> > +filesystem to perform the following actions.
> > +
> > +Retrieve Test Results
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +You can use debugfs to retrieve KUnit test results. The test results a=
re
> > +accessible from the debugfs filesystem in the following read-only file=
:
> > +
> > +.. code-block :: bash
> > +
> > +       /sys/kernel/debug/kunit/<test_suite>/results
> > +
> > +The test results are available in KTAP format.
>
> We _could_ mention that this is a separate KTAP document (i.e., the
> numbering starts at 1), though it may be obvious.
>
> > +
> > +Run Tests After Kernel Has Booted
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +You can use the debugfs filesystem to trigger built-in tests to run af=
ter
> > +boot. To run the test suite, you can use the following command to writ=
e to
> > +the ``/sys/kernel/debug/kunit/<test_suite>/run`` file:
> > +
> > +.. code-block :: bash
> > +
> > +       echo "any string" > /sys/kernel/debugfs/kunit/<test_suite>/run
> > +
> > +As a result, the test suite runs and the results are printed to the ke=
rnel
> > +log.
> > +
> >  .. note ::
> >
> > -       If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
> > -       be accessible from the ``debugfs`` filesystem (if mounted).
> > -       They will be in ``/sys/kernel/debug/kunit/<test_suite>/results`=
`, in
> > -       TAP format.
> > +       The contents written to the debugfs file
> > +       ``/sys/kernel/debug/kunit/<test_suite>/run`` are not saved.
>
> This is possibly a bit obvious. Maybe it'd be more useful with a bit
> more context, e.g., "The contents written to the file ... are
> discarded; it is the act of writing which triggers the test, not the
> specific contents written."?

I will try to add more context here in the next version.

>
> It might be worth having a note that tests cannot run concurrently, so
> this may block or fail.
>
> Equally, it may be worth having a note for test authors, that their
> tests will need to correctly initialise and/or clean up any data, so
> the test runs correctly a second time.
>

Yes these are two good points. I will add notes on tests not being
able to run concurrently, cleaning up data, and also init tests.

>
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >
