Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC26EDB65
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 07:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjDYF4m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 01:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjDYF4l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 01:56:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A59AD2A
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Apr 2023 22:56:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5208be24dcbso4115455a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Apr 2023 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682402200; x=1684994200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNTCPwELmejGyX0PHoDzgEHBOGMtopWJi8WSu8WZm6Y=;
        b=tid6VhavUBckO1Th/UH6CvlgJfZnJpvGasl2MY3m0mjt77Y8IMoPKvvzndHIotQ6xx
         QwYCjtGWzKWFUO2zJ5xE57BQOJg+WPcf9HfCiW3QFud9cWAiRiVTwmi/yIoyAlmDeCx1
         SlIMeztzMLZaE1K2rGWTC1YLt8YRHLa+p7j00whfQ6Xw8XdNFkC6f8cmFn+JqGYQLLJ0
         uOQi85ZiONgxcya6s3D+Wp9/as7i13UhgICTCvzMi+bF0ocYTh++gmHU3NjYVRn8o9/C
         iCLXOJBoG+4DRuvIB476dpSoxJkNlYDDBBLnfVXw8NdYBMr8K0ohC13ujEibQa4iTmwe
         e9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682402200; x=1684994200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNTCPwELmejGyX0PHoDzgEHBOGMtopWJi8WSu8WZm6Y=;
        b=SdevY2TzKjMtwa8yFpjzAnlvMRo2aDqsGW7+E6FfcRdRfgZpixz0c2IZsluNLO8PIO
         w7dCr9e5vmcTKNuQ8bSwZv3FkpJpF3kCE0xPFrYZFxFx9cuAFDWZz/Mo2SEP6KWtUzGY
         SJd7jVmOzS5GR8OHsBHGEhNnbi7Vg0pBhN15i8xh+LCrOR8axe7f9CGHuyiYHBtwruxZ
         n2pJIIK6AIWpd2D4gE8UPH8scWso9e1WXh3uKJ6DWNalYerCqoFZIBLcoALk/XvwMA0A
         79o1qszaKsUrlWMR81aQbJCVTC9AEzK6i40M9/viFSQGDFdljWjsLnVgCPPt2YSKB6y6
         Bo3A==
X-Gm-Message-State: AC+VfDzB0eXpbsbY6WEcOq7ZNiO3yb6+V3xvDOHwqNwvZNtzDl7Euali
        WWhwdWm3/mlbdvipI9tbc7zxZ8j7nZiLYTHmJIl5oA==
X-Google-Smtp-Source: ACHHUZ6UCw1EAMLHhUsMA8U2M802a+lvUb5c39XTGdVo9Us5K0ME1bq92Vb9syYkY2B3SVVs4p+rd6C/tMid5t5ZVrQ=
X-Received: by 2002:a17:902:e5c1:b0:1a9:8ab1:9f3b with SMTP id
 u1-20020a170902e5c100b001a98ab19f3bmr1853997plf.14.1682402199701; Mon, 24 Apr
 2023 22:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230421040218.2156548-1-davidgow@google.com> <20230421040218.2156548-2-davidgow@google.com>
In-Reply-To: <20230421040218.2156548-2-davidgow@google.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Tue, 25 Apr 2023 11:26:28 +0530
Message-ID: <CAO2JNKXE4fevipABRLsp=UkfL3tt9rbpoT8D4MeokyLndG3SCQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] Documentation: kunit: Note that assertions should
 not be used in cleanup
To:     David Gow <davidgow@google.com>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 21, 2023 at 9:32=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> As assertions abort the test cleanup process, they should be avoided
> from within a suite's exit function, or from within resource 'free'
> functions. Unlike with initialisation or main test execution, no further
> cleanup will be performed after a failed assertion, potentially causing
> a leak of resources.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---

Thank you, David. The note looks fine to me.
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

Regards,
Sadiya
>
> No changes since v2:
> https://lore.kernel.org/linux-kselftest/20230419085426.1671703-2-davidgow=
@google.com/
>
> This patch was introduced in v2.
>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-=
tools/kunit/usage.rst
> index 9faf2b4153fc..9f720f1317d3 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -121,6 +121,12 @@ there's an allocation error.
>     ``return`` so they only work from the test function. In KUnit, we sto=
p the
>     current kthread on failure, so you can call them from anywhere.
>
> +.. note::
> +   Warning: There is an exception to the above rule. You shouldn't use a=
ssertions
> +   in the suite's exit() function, or in the free function for a resourc=
e. These
> +   run when a test is shutting down, and an assertion here prevents furt=
her
> +   cleanup code from running, potentially leading to a memory leak.
> +
>  Customizing error messages
>  --------------------------
>
> --
> 2.40.0.634.g4ca3ef3211-goog
>
