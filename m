Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B60F6D551B
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjDCXJc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 19:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjDCXJb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 19:09:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6C31FD6
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 16:09:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d8so18536631pgm.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680563370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm2mdMYlxgOEAlln4oVgIuGqiZVWlR3x3Kt+Ruv0qD4=;
        b=KUmiAtMK1/S3dcCVClx3TpnYw38n3sgVtwGXUMel9HRPQxlTPxy7nv7LwGjuSn9C2n
         5xu3/sJ7DZMTfJLizzmvX9NMSmW1jZ4OigK4G3q1ii/agaRTtYzP4M7VZ7WIO/L/zTW8
         xBRUy5R+ORUDJhOdnpjyBW4oR6ohWjL3bG9Ub2q6XckGTvRV04pW0I7KpnQmUbFn4hit
         FxYbgKUgElYXz6vG//abvBVNWgw/4/5CDiES8wS20Q0rCUEeCmwO9ee723hlYqWQF2fp
         u9mt3FWjMUgNsZNDssNWeZu8fb8VQQjQVXQY3ase8N3uMcxd8kd7GYS4F3KrGfP+2222
         2FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm2mdMYlxgOEAlln4oVgIuGqiZVWlR3x3Kt+Ruv0qD4=;
        b=eImPdb/EPwQemXqeZ8owYE+b87aAb/MbZ15h269tpL87GbKML9zai5B48q13V90bsV
         tFDMWPMvw/aaw8ZoD79QZrlweGan8BZybrPp6R+753yVMCOE1wxwGP6zST+LOipXhqLw
         y9sAOlCn8L131RJUT7uHXbmxvv4+ziL5YwjH5nw1Ym0jrTMVmpjpO+wxM/WUQtW2XRQ6
         DoBrnG+kj0dgYEqzS1To4TON5avBVLJpyW2A+qQToptpNzqcAAmi7WLgSF6h9fr++LKm
         5/JfWC2sanpxqCZ1cXJTH9j2IXQd5dxisfRtrHFIbwhlO+b6F+G+lFkbF/E2QgjsrUAA
         0h6g==
X-Gm-Message-State: AAQBX9ebqgGijmaS/uXM79yQm4AUhb/rVtjLLw+0XzH2RQYTVfnVqrX4
        bUj/NR7zhabb/OFsNSpZthdbUZm/8d7ShY0MZLEUZQ==
X-Google-Smtp-Source: AKy350Y4+plIG562XWpintZQc4vACy7i2JVnLqdKGRxFUL/qetr6AIMSFaGLhVh619kAR3WK8hsJBBOa34m1K+jRuko=
X-Received: by 2002:a63:eb50:0:b0:509:4ac5:7f44 with SMTP id
 b16-20020a63eb50000000b005094ac57f44mr82512pgk.2.1680563370090; Mon, 03 Apr
 2023 16:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230330220506.1399796-1-rmoar@google.com> <CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr+f+mOVKT1bGvA@mail.gmail.com>
 <CA+GJov5YigvgTf7ThaN9g8nOkoFKzJTiOLYO86cD5yVa2BEieg@mail.gmail.com>
In-Reply-To: <CA+GJov5YigvgTf7ThaN9g8nOkoFKzJTiOLYO86cD5yVa2BEieg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 3 Apr 2023 16:09:18 -0700
Message-ID: <CAGS_qxqbdB-1OFUQWXb7XxODWfOWi5yMUCBFebOLmGOj0rMdyA@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: add tests for using current KUnit test field
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 3, 2023 at 12:31=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> On Thu, Mar 30, 2023 at 6:21=E2=80=AFPM 'Daniel Latypov' via KUnit Develo=
pment
> <kunit-dev@googlegroups.com> wrote:
> >
> > I've got a few minor comments below, but this otherwise looks good.
> > I like the idea of testing knuit_fail_current_test().
> >
> >
> > On Thu, Mar 30, 2023 at 3:05=E2=80=AFPM Rae Moar <rmoar@google.com> wro=
te:
> > >
> > > +static void kunit_current_kunit_test_field(struct kunit *test)
> > > +{
> > > +       struct kunit *current_test;
> > > +
> > > +       /* Check to ensure the result of current->kunit_test
> > > +        * is equivalent to current test.
> > > +        */
> > > +       current_test =3D current->kunit_test;
> > > +       KUNIT_EXPECT_PTR_EQ(test, test, current_test);
> >
> > Perhaps we can combine this and the next test case down to
> > static void kunit_current_test(struct kunit *test) {
> >   /* There are two different ways of getting the current test */
> >   KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
> >   KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
> > }
> > ?
>
> Hi Daniel!
>
> Yes, I would be happy to combine these for v2. I might want to alter
> that proposed comment slightly. "Two different ways" seems a bit
> unclear to me. Maybe: Check results of both current->kunit_test and
> kunit_get_current_test() are equivalent to current test. What do you
> think? I might send out a v2 with a proposed comment.

What you went with in v2 works for me.
I'll take a look at the other changes in v2.

Thanks!
Daniel
