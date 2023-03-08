Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C966B11DF
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 20:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCHTRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 14:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCHTRW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 14:17:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6675F6F0;
        Wed,  8 Mar 2023 11:17:20 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o12so69879431edb.9;
        Wed, 08 Mar 2023 11:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678303039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knMVR65U9SghfqZv2uXd6rShiZNASs9ZfBQZD+VIOcY=;
        b=OVxtFwjLWdHmQEPn7eOg54MWglCH6i30XEA0WqG6W/v8xHQ1QxkfcFreOCq9puMKMW
         oOBypV/rHsiyVtZ5W9LwkoJvhvMfz5FpoaR553up6IsyU3jCqnpMuJtHg+OAg6P9AEOp
         wVi93eyuKNjiVAyJ2if3jwYtZ2m+iszZgSpEstXxwYiy+lwehAGBopcQXST43K5DEJRj
         j7ODahKXSd3SbZDLqkBEyD6eeznlPzavdlwDN9dXbWJM9UGPP4NmIgbUmkbFYEl+GlrO
         C0SP8bpe9fH08HYJ2ru4GjeRE9rqrSauEizR+SsDbHFxbsrQgG688OxCY2cijUj9yera
         Q4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678303039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knMVR65U9SghfqZv2uXd6rShiZNASs9ZfBQZD+VIOcY=;
        b=yulPdRYeS3lKI9XvoNfA1tfBgIg0lmuE76LmYsk4XukUPsb6/OKKu14fVwvVL9lDY3
         KhXszoB/+0nSY6yxt/HTilQ4mUPiXduIGLrDpu0mo6Js7YKZ5kLx1FQRgNAf59ik7gK8
         VmrIl/ZJxMSfwDfbG9BoG+hvIeceQRz3Cdb6ylqotG1bqSQHq2rK2bvhXtgBDejAlS7p
         alWFRNl6Y+0EFTWr52AJ5TlDZnzhucFuDmY3q67mrfN1B90xGa1A024caYVxxlrwq8rd
         l72GOWDlUUh9ukIahBJB8M1aAvajRFZC/HVziZRMJh14fbX2BF742fvxFhP5H9FL4ZUn
         2Xlg==
X-Gm-Message-State: AO0yUKXEz+bXiQyRVnpOlKrRMZiDPfrh2XUWyzAli+tW/TdecXn41bpU
        Jy4wQVzjcZTjxQiQuEjXugSCN8iNwuqc7iVY0Io=
X-Google-Smtp-Source: AK7set8DS9QG3Ti9NuqnXZDmiX94MgmTlrfAN4JSkGp04xhrDA4blMjrZrRvHQTW/jgxo90sAlqy8YyaxRB11ShMpIA=
X-Received: by 2002:a50:a69d:0:b0:4c0:b7b8:13e1 with SMTP id
 e29-20020a50a69d000000b004c0b7b813e1mr10900698edc.1.1678303039231; Wed, 08
 Mar 2023 11:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20230308103713.1681200-1-roberto.sassu@huaweicloud.com> <efd569cdf6bba1ee80686f73a64bc636975dd899.camel@huaweicloud.com>
In-Reply-To: <efd569cdf6bba1ee80686f73a64bc636975dd899.camel@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Mar 2023 11:17:07 -0800
Message-ID: <CAEf4BzaQTcDgvH5a9E3crkJENxQnOOjR=TdTmFwUGk4g3=oF_w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix IMA test
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, mattbobrowski@google.com,
        zohar@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 8, 2023 at 2:41=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Wed, 2023-03-08 at 11:37 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
>
> The title should have been selftests/bpf: ...
>
> Will send a new version once I get the test result.

I fixed up prefix and Reported-by tag, pushed to bpf-next. Thanks for the f=
ix!

>
> Roberto
>
> > Commit 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLEC=
TED
> > flag is set") caused bpf_ima_inode_hash() to refuse to give non-fresh
> > digests. IMA test #3 assumed the old behavior, that bpf_ima_inode_hash(=
)
> > still returned also non-fresh digests.
> >
> > Correct the test by accepting both cases. If the samples returned are 1=
,
> > assume that the commit above is applied and that the returned digest is
> > fresh. If the samples returned are 2, assume that the commit above is n=
ot
> > applied, and check both the non-fresh and fresh digest.
> >
> > Fixes: 62622dab0a28 ("ima: return IMA digest value only when IMA_COLLEC=
TED flag is set")
> > Reported by: David Vernet <void@manifault.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  .../selftests/bpf/prog_tests/test_ima.c       | 29 ++++++++++++++-----
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_ima.c b/tools/=
testing/selftests/bpf/prog_tests/test_ima.c
> > index b13feceb38f..810b14981c2 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_ima.c
> > @@ -70,7 +70,7 @@ void test_test_ima(void)
> >       u64 bin_true_sample;
> >       char cmd[256];
> >
> > -     int err, duration =3D 0;
> > +     int err, duration =3D 0, fresh_digest_idx =3D 0;
> >       struct ima *skel =3D NULL;
> >
> >       skel =3D ima__open_and_load();
> > @@ -129,7 +129,15 @@ void test_test_ima(void)
> >       /*
> >        * Test #3
> >        * - Goal: confirm that bpf_ima_inode_hash() returns a non-fresh =
digest
> > -      * - Expected result: 2 samples (/bin/true: non-fresh, fresh)
> > +      * - Expected result:
> > +      *   1 sample (/bin/true: fresh) if commit 62622dab0a28 applied
> > +      *   2 samples (/bin/true: non-fresh, fresh) if commit 62622dab0a=
28 is
> > +      *     not applied
> > +      *
> > +      * If commit 62622dab0a28 ("ima: return IMA digest value only whe=
n
> > +      * IMA_COLLECTED flag is set") is applied, bpf_ima_inode_hash() r=
efuses
> > +      * to give a non-fresh digest, hence the correct result is 1 inst=
ead of
> > +      * 2.
> >        */
> >       test_init(skel->bss);
> >
> > @@ -144,13 +152,18 @@ void test_test_ima(void)
> >               goto close_clean;
> >
> >       err =3D ring_buffer__consume(ringbuf);
> > -     ASSERT_EQ(err, 2, "num_samples_or_err");
> > -     ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> > -     ASSERT_NEQ(ima_hash_from_bpf[1], 0, "ima_hash");
> > -     ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample, "sample_equal_or=
_err");
> > +     ASSERT_GE(err, 1, "num_samples_or_err");
> > +     if (err =3D=3D 2) {
> > +             ASSERT_NEQ(ima_hash_from_bpf[0], 0, "ima_hash");
> > +             ASSERT_EQ(ima_hash_from_bpf[0], bin_true_sample,
> > +                       "sample_equal_or_err");
> > +             fresh_digest_idx =3D 1;
> > +     }
> > +
> > +     ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], 0, "ima_hash");
> >       /* IMA refreshed the digest. */
> > -     ASSERT_NEQ(ima_hash_from_bpf[1], bin_true_sample,
> > -                "sample_different_or_err");
> > +     ASSERT_NEQ(ima_hash_from_bpf[fresh_digest_idx], bin_true_sample,
> > +                "sample_equal_or_err");
> >
> >       /*
> >        * Test #4
>
