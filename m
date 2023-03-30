Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C146CFDBF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC3IKm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC3IKl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 04:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D020469A
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680163793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+kZDFg3lmlfEXt7vrPYf2wFRjTPUJsHa1umgwkaIJU=;
        b=AVFAU5zmx76goUKiFszEHoPv9unmiRg98GR+P26Jh8Lyt/XLvJDKcbHnd1uZPUJqFirVIq
        9woGMAsAPRUKAIzZATpFBekIf0bGVw1mWHKSuuvaNf+9vSfG1agKn2GQfcmmvqqMvgCSqp
        820P6ke6gnLKs34YPZq48mpS1f6rTdw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-zUzMmub4OQiqJ5Ix0o8_cg-1; Thu, 30 Mar 2023 04:09:52 -0400
X-MC-Unique: zUzMmub4OQiqJ5Ix0o8_cg-1
Received: by mail-wm1-f70.google.com with SMTP id v7-20020a05600c470700b003ef6ebfa99fso6049774wmo.8
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 01:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163791;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+kZDFg3lmlfEXt7vrPYf2wFRjTPUJsHa1umgwkaIJU=;
        b=teTo5aS4cU1/My9e2b7w3YfNNX5F+wyVqHMDKMqJYL8f6C1FDDVnyIyLU2yPbWz6ej
         UTLMFsvFfgY9JQaXiCuuwvIjOwrnIoMIv7Reugk+B5Ob+Rln0UPq07sWA6G0C58TxloI
         BkzKDbWethk8mkvYIFv1NjgUWlAmQtn62XoPxHvAsSPMGgvIDTNYKeHjImPz2xXcci9h
         xoy0G0k2UpEgbBp3qX782tGqiKqolUnkqYGpnnE2GCDUNTS4OF0AvZHClNQVXu6HpMmL
         i0tVaYtPg6Lr9BWnAXqrr6/iCi83aNAURy0RJmqv8I22ZfFDrN8bOufhNZezzvC6s2KX
         nsOQ==
X-Gm-Message-State: AAQBX9chmxS32NAhgVNFFXtS1RiUBEWENbOD0Oh6mIM4slfb3SmM6IbK
        PaloixUIYaP3UfR8XoHLNPBA5cKZ/D1PmJgs3o/3r/h6wv23WA7o+lso66Jj+0C5lrE3H5kOZyq
        M9m0iC5AjWkyrbYFFqAtunRpTPAyd
X-Received: by 2002:adf:ef09:0:b0:2ce:a944:2c6c with SMTP id e9-20020adfef09000000b002cea9442c6cmr17202657wro.12.1680163791149;
        Thu, 30 Mar 2023 01:09:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350b+lhfU3YqiOsoIgk9QUtyARFh7zv1+Jz6/tkkgpyht/XGLopg8s5IdYP+a7WiC4h4LY7zpqg==
X-Received: by 2002:adf:ef09:0:b0:2ce:a944:2c6c with SMTP id e9-20020adfef09000000b002cea9442c6cmr17202635wro.12.1680163790813;
        Thu, 30 Mar 2023 01:09:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s8-20020a1cf208000000b003e203681b26sm4855785wmc.29.2023.03.30.01.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 01:09:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kselftest@vger.kernel.org,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: Add KUnit tests for some of the input core
 helper functions
In-Reply-To: <CAGS_qxpEzXRWqy2Xd8qJn7GRxv+8HF40Lxt8esD-59CzeePZSw@mail.gmail.com>
References: <20230329092332.2143623-1-javierm@redhat.com>
 <CAGS_qxpEzXRWqy2Xd8qJn7GRxv+8HF40Lxt8esD-59CzeePZSw@mail.gmail.com>
Date:   Thu, 30 Mar 2023 10:09:49 +0200
Message-ID: <87cz4qfynm.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Daniel Latypov <dlatypov@google.com> writes:

Hello Daniel,

Thanks a lot for your feedback!

> On Wed, Mar 29, 2023 at 2:23=E2=80=AFAM Javier Martinez Canillas
> <javierm@redhat.com> wrote:

[...]

>>
>>   $ ./tools/testing/kunit/kunit.py run \
>>     --kunitconfig=3Ddrivers/input/tests/.kunitconfig
>
> Nice!
> A few small suggestions below as someone who has worked on KUnit.
>
> FYI, to save a few keystrokes, you can omit the "/.kunitconfig" and
> just pass the dir, i.e.
>   --kunitconfig=3Ddrivers/input/tests
>

Ah, cool. I didn't know that.

[...]

>>  drivers/input/tests/input_test.c | 144 +++++++++++++++++++++++++++++++
>
> I don't see the .kunitconfig in the diff.
> Was it accidentally forgotten or does this patch apply to a tree that
> already has the file?
>
> (it's easy to forget since git will still ignore it by default, IIRC)
>

I did indeed forgot because as you mentioned git add complained and I
missed that needed to force to add it.

[...]

>> +         Say Y here if you want to build the KUnit tests for the input
>> +         subsystem. For more information about KUnit and unit tests in
>> +         general, please refer to the KUnit documentation in
>> +         Documentation/dev-tools/kunit/.
>> +
>> +         If in doubt, say "N".
>
> FYI, I know this is in the style guide, but I'd personally feel free
> to leave out this paragraph.
>
> Having such "advertising" about what KUnit is made more sense when
> less people knew about it.
> It's not known by everyone in the community yet, but we might be
> getting to a point where this turns into repetitive bloat.
>

Ok, I'll drop these.

[...]

>> +
>> +       ret =3D input_register_device(input_dev);
>> +       KUNIT_ASSERT_EQ(test, ret, 0);
>
> (very unlikely that this matters, but...)
> Hmm, should we call input_free_device() if this fails?
> i.e. something like
>
> ret =3D ...;
> if (ret) {
>   input_free_device(input_dev);
>   KUNIT_ASSERT_FAILURE(test, "failed to register device: %d", ret);
> }
>

Indeed. I'll do this too.

[...]

>> +
>> +       ret =3D input_get_poll_interval(input_dev);
>> +       KUNIT_ASSERT_EQ(test, ret, -EINVAL);
>
> minor suggestion: can we inline these? E.g.
>   KUNIT_ASSERT_EQ(test, -EINVAL, input_get_poll_interval(input_dev));
> This way on failure, KUnit can print the function call instead of just `r=
et`.
>
> Users could always find out what failed by the line #, but including
> it in the output would be a bit nicer.
>
> E.g. w/ KUNIT_EXPECT_EQ(test, 0, ...)
>
>     # example_simple_test: EXPECTATION FAILED at
> lib/kunit/kunit-example-test.c:29
>     Expected 0 =3D=3D input_get_poll_interval(input_dev), but
>         input_get_poll_interval(input_dev) =3D=3D 42 (0x2a)
>
> verus
>
>     # example_simple_test: EXPECTATION FAILED at
> lib/kunit/kunit-example-test.c:28
>     Expected ret =3D=3D 0, but
>         ret =3D=3D 42 (0x2a)
>

Great suggestion. I'll change too, it would also get rid of the ret variabl=
e.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

