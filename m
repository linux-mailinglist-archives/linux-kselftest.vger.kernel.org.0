Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAF59C514
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiHVRgo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 13:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiHVRgn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 13:36:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDAD40BC9
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 10:36:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a16so7991221lfs.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 10:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=l2rPagMbz8Ll9r+EAEfWnyCiHgWknUSiBzGwF24uJk0=;
        b=rkm3YncQHWPEopQMVxS6CGvBPR0tQWz1GP1xmn9k+eDL0IppgfyOTC7LFzIQUcrjt/
         rpkYHV5mlBbtH82wFj59Ah71pgPkb0kwl6QDEKROEG4HZ9yeE/nJzIRRevz9AmvWtPnM
         mBZQSq1WAcMDV9CGrIhL3G7w2LRi0y4FRw7Hb9tybs5tzWqIyWaGglRttLrnLGPmN5ED
         3Y83W5xGK9vrmBrufO1ZCvdFQXNntYKSB3JdypcQ53BYYhjvvtzDkYdlNUf1v9PXsZZJ
         3FkafOGnCDzGQzK6lzeyXu9sZReH2MPRNYto/edeoww6G3xNm+MNaBN2Cd44A8fnmfsI
         T0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=l2rPagMbz8Ll9r+EAEfWnyCiHgWknUSiBzGwF24uJk0=;
        b=57hxxPg0JkdLzp/2B/nN7HAF57FKcohPG7rV23ldST0YLgE1ufzD/WVjkQ41Gq3nx0
         jh1iFiHywUacb1x9kG+W46dD0JuJ1qurW4uT322bnyKd4Mj47dawGs0+UHJLpYzASQFH
         f7MMBXYykYUR+IBBnmVzigzoUkQFlm9wKNYDxv9pILe9O64EL5zTATUUOheSTpZL1hVm
         JmKbakJ4PJ0YxcbhTN1PiRK37knpGdhhdkignMZd1LFcWluYTg2N3WxOs4V+qGkOigDU
         t2qOgFBgHIJw2ggfubKf7zLG2sigZA1gUNnduQrfpsO3kvK2jwuwOOAFa0dAHrrPyVPV
         Ds2g==
X-Gm-Message-State: ACgBeo3reW+q8fJP+R5iAo4rv1LTyslVAjQ0NEnAjF4/FUqf/6dfOmav
        M0m1TNhVSXI7ZaElOagW0kirJnDvVZn6O/JDr8sWGQ==
X-Google-Smtp-Source: AA6agR78MoVIqPrV/wcpSd+Kmiw5aVyZviq+7uMPr6m3nZUVOJIPLZCv8B6ZgvDJI6DTtrUc+qo0Qyb+h7GKwBJxF+I=
X-Received: by 2002:a05:6512:3090:b0:48b:6e1:1b55 with SMTP id
 z16-20020a056512309000b0048b06e11b55mr8155377lfd.535.1661189800517; Mon, 22
 Aug 2022 10:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022646.98581-1-tales.aparecida@gmail.com> <20220822022646.98581-3-tales.aparecida@gmail.com>
In-Reply-To: <20220822022646.98581-3-tales.aparecida@gmail.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Mon, 22 Aug 2022 23:06:29 +0530
Message-ID: <CAO2JNKWbL+=j1Kk+hKpM=7AKi_BYxyQmiQvjNMCN7GJtFHtnyg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] Documentation: KUnit: avoid repeating "kunit.py
 run" in start.rst
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>, corbet@lwn.net,
        brendan.higgins@linux.dev, Trevor Woerner <twoerner@gmail.com>,
        siqueirajordao@riseup.net, mwen@igalia.com, andrealmeid@riseup.net,
        mairacanal@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 22, 2022 at 8:00 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Combine two sections mentioning "kunit.py run" to streamline the
> getting-started guide. Update "kunit.py run" expected output in
> the guide and run_wrapper.
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
>
> ---
> Notes:
>     Update the expected output and the note that follows it (Ma=C3=ADra C=
anal and
>     Sadiya Kazi). The output was updated on the commit: 45ba7a893ad8
>     ("kunit: kunit_tool: Separate out config/build/exec/parse")
>     Add word "step" to note and fix the case of "kernel".
> ---

Thanks, Tales. This looks good to me.

Reviewed-by: Sadiya Kazi<sadiyakazi@google.com>

Cheers,
Sadiya

>  Documentation/dev-tools/kunit/run_wrapper.rst |  2 +-
>  Documentation/dev-tools/kunit/start.rst       | 38 ++++++++-----------
>  2 files changed, 16 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentatio=
n/dev-tools/kunit/run_wrapper.rst
> index 518cf87ea732..6b33caf6c8ab 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -22,7 +22,7 @@ We should see the following:
>
>  .. code-block::
>
> -       Generating .config...
> +       Configuring KUnit Kernel ...
>         Building KUnit kernel...
>         Starting KUnit kernel...
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index e730df1f468e..2e31350a85e1 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -19,7 +19,21 @@ can run kunit_tool:
>
>         ./tools/testing/kunit/kunit.py run
>
> -For more information on this wrapper, see:
> +If everything worked correctly, you should see the following:
> +
> +.. code-block::
> +
> +       Configuring KUnit Kernel ...
> +       Building KUnit Kernel ...
> +       Starting KUnit Kernel ...
> +
> +The tests will pass or fail.
> +
> +.. note ::
> +   Because it is building a lot of sources for the first time,
> +   the ``Building KUnit Kernel`` step may take a while.
> +
> +For detailed information on this wrapper, see:
>  Documentation/dev-tools/kunit/run_wrapper.rst.
>
>  Creating a ``.kunitconfig``
> @@ -74,28 +88,6 @@ you if you have not included dependencies for the opti=
ons used.
>     tools like ``make menuconfig O=3D.kunit``. As long as its a superset =
of
>     ``.kunitconfig``, kunit.py won't overwrite your changes.
>
> -Running Tests (KUnit Wrapper)
> ------------------------------
> -1. To make sure that everything is set up correctly, invoke the Python
> -   wrapper from your kernel repository:
> -
> -.. code-block:: bash
> -
> -       ./tools/testing/kunit/kunit.py run
> -
> -If everything worked correctly, you should see the following:
> -
> -.. code-block::
> -
> -       Generating .config ...
> -       Building KUnit Kernel ...
> -       Starting KUnit Kernel ...
> -
> -The tests will pass or fail.
> -
> -.. note ::
> -   Because it is building a lot of sources for the first time, the
> -   ``Building KUnit kernel`` may take a while.
>
>  Running Tests without the KUnit Wrapper
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --
> 2.37.2
>
