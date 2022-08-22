Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CBB59B8FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 08:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiHVGHe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 02:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiHVGHd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 02:07:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63626571
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 23:07:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z6so13807569lfu.9
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Aug 2022 23:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Is0hM/+ncd90j/HZw6R2Zz4oafx/I4TmNetkvSlqTEU=;
        b=h+kb7A/AAPK6LxaM9yKMjfR/avf/vbsRYvKZkaEBeHRoGzl+bQueKc0dgMDjCBnbW2
         6ZIkOkEB1bz2uGqSrtYSZqa+4fN0Vyk3PV6QNpqy7dRNE74eskpcoMGSMOqyH7KaVBCC
         fw/AmRpsrI8qEZnLe56EkROrrUjpCZvKZlFEQWvfzxKgm38xD259/5hUZ/1+dQC5Zi+8
         24/mGa1VehoWY8Dwl8RSyKFPbTX4HO0bJbrRL6do+51WvnWCB1COcKiJO5sAvc2kEwdV
         s/DVZTAUV6N4ZeHjCqoK2CCK/CUZkU8QKplTyncobMF90Be+x8Wla8bFxTTEumyXx/Jf
         LHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Is0hM/+ncd90j/HZw6R2Zz4oafx/I4TmNetkvSlqTEU=;
        b=PpMscICoD9ZdX1OSFaOc+rF6gIynfTjBsMxDRLKv7K0417HQyx01qGnMRq4oPtodkX
         cHaJCqgpIGvM0mBqAgwgwsfNxf9oCzR6lI3t9MR+CTkjwYcIeb24ZkN0fBnYwe5p8dcl
         na0t0LF0EqmMy1xSHqu6BEifMl8XBuDe1YY6O6dlSRabQrf8yO3KDOz4yMC4W+D9bhwB
         /qhM7DQT3q3yI3PLk1HuAydszC7QLXKbPo1Z9Ihyl0VLOMvhdJe6ZkEeikTQx6hoC3RY
         dnnrcwYHODW92IHQgpOAuQxQwOr2VlXC2iDQcQrobk/QWP+RwL+qUvN/xX9sXP8s4FSr
         +x+w==
X-Gm-Message-State: ACgBeo2SZPIOJpF+7V0tRNm31nUqnsxQd90CVQ2NcJOp0Tm0D0/KcVVe
        URDq+2Zg4ZJO6HfZP5KxgzzOKfOFcHVhPVMBN9HACA==
X-Google-Smtp-Source: AA6agR4fHgqnNbF1t+71uokxtDqKRtkJn+kWIzC2jGSxzKnMFcHdbdvl8kJ6H8Xme/DO8k/+Tas8u3ufwuue83ouH18=
X-Received: by 2002:a05:6512:3090:b0:48b:6e1:1b55 with SMTP id
 z16-20020a056512309000b0048b06e11b55mr7196691lfd.535.1661148450002; Sun, 21
 Aug 2022 23:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220822022646.98581-1-tales.aparecida@gmail.com> <20220822022646.98581-5-tales.aparecida@gmail.com>
In-Reply-To: <20220822022646.98581-5-tales.aparecida@gmail.com>
From:   Sadiya Kazi <sadiyakazi@google.com>
Date:   Mon, 22 Aug 2022 11:37:18 +0530
Message-ID: <CAO2JNKWv3AoFr+g2r4Z_2e5jcVB0c0_UVbE9N87EB-pfvROfqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] Documentation: KUnit: Reword start guide for
 selecting tests
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

Hello Tales,
I have a few suggestions listed below. Please see my comments inline.
Apart from that it looks fine to me.

Regards,
Sadiya

On Mon, Aug 22, 2022 at 8:00 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Reword "Creating a ``.kunitconfig``" into "Selecting which tests to run"
> covering the current alternatives for editing configs and glob-filtering
>
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> Reviewed-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
>
> ---
> Notes:
>     Avoid hyphen in "test case" and "test suite"
>     Fix nit: "any test case that match" -> "...matches"
> ---




>  Documentation/dev-tools/kunit/start.rst | 90 +++++++++++++++++--------
>  1 file changed, 63 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-=
tools/kunit/start.rst
> index 9beec7d6ac4b..adf782507999 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -52,27 +52,20 @@ The tests will pass or fail.
>  For detailed information on this wrapper, see:
>  Documentation/dev-tools/kunit/run_wrapper.rst.
>


You can add the new heading and the intro content given below:

Running selected unit tests
----------------------------
The kunit_tool runs a set of default unit tests as listed in the KUnit
``defconfig``. To run a specific set of tests (rather than the default
tests), you can create a ``.kunitconfig``
file with kernel config options that enable only a specific set of
tests and their dependencies.
The .kunitconfig also contains any other test specific config options,
such as test dependencies.
You can select which tests to run by: <Add the new content you added>

Reviewed-by:Sadiya Kazi <Sadiyakazi@google.com>

> -Creating a ``.kunitconfig``
> ----------------------------
> -
> -By default, kunit_tool runs a selection of tests. However, you can speci=
fy which
> -unit tests to run by creating a ``.kunitconfig`` file with kernel config=
 options
> -that enable only a specific set of tests and their dependencies.
> -The ``.kunitconfig`` file contains a list of kconfig options which are r=
equired
> -to run the desired targets. The ``.kunitconfig`` also contains any other=
 test
> -specific config options, such as test dependencies. For example: the
> -``FAT_FS`` tests - ``FAT_KUNIT_TEST``, depends on
> -``FAT_FS``. ``FAT_FS`` can be enabled by selecting either ``MSDOS_FS``
> -or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
> +Selecting which tests to run
> +----------------------------
>
> -.. code-block:: none
> +By default, kunit_tool runs all tests reachable with minimal configurati=
on,
> +that is, using default values for most of the kconfig options.  However,
> +you can select which tests to run by:
>
> -       CONFIG_KUNIT=3Dy
> -       CONFIG_MSDOS_FS=3Dy
> -       CONFIG_FAT_KUNIT_TEST=3Dy
> +- `Customizing Kconfig`_ used to compile the kernel, or
> +- `Filtering tests by name`_ to select specifically which compiled tests=
 to run.
>
> -1. A good starting point for the ``.kunitconfig`` is the KUnit default c=
onfig.
> -   You can generate it by running:
> +Customizing Kconfig
> +~~~~~~~~~~~~~~~~~~~
> +A good starting point for the ``.kunitconfig`` is the KUnit default conf=
ig.
> +If you didn't run ``kunit.py run`` yet, you can generate it by running:
>
>  .. code-block:: bash
>
> @@ -84,27 +77,70 @@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kun=
itconfig`` has:
>     ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which=
 is
>     ``.kunit`` by default.
>
> -.. note ::
> +Before running the tests, kunit_tool ensures that all config options
> +set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> +you if you have not included dependencies for the options used.
> +
> +There are many ways to customize the configurations:
> +
> +a. Edit ``.kunit/.kunitconfig``. The file should contain the list of kco=
nfig
> +   options required to run the desired tests, including their dependenci=
es.
>     You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig=
`` as
>     it will enable a number of additional tests that you may not want.
> +   If you need to run on an architecture other than UML see :ref:`kunit-=
on-qemu`.
>
> -2. You can then add any other Kconfig options, for example:
> +b. Enable additional kconfig options on top of ``.kunit/.kunitconfig``.
> +   For example, to include the kernel's linked-list test you can run::
>
> -.. code-block:: none
> +       ./tools/testing/kunit/kunit.py run \
> +               --kconfig_add CONFIG_LIST_KUNIT_TEST=3Dy
>
> -       CONFIG_LIST_KUNIT_TEST=3Dy
> +c. Provide the path of one or more .kunitconfig files from the tree.
> +   For example, to run only ``FAT_FS`` and ``EXT4`` tests you can run::
>
> -Before running the tests, kunit_tool ensures that all config options
> -set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> -you if you have not included dependencies for the options used.
> +       ./tools/testing/kunit/kunit.py run \
> +               --kunitconfig ./fs/fat/.kunitconfig \
> +               --kunitconfig ./fs/ext4/.kunitconfig
>
> -.. note ::
> -   If you change the ``.kunitconfig``, kunit.py will trigger a rebuild o=
f the
> +d. If you change the ``.kunitconfig``, kunit.py will trigger a rebuild o=
f the
>     ``.config`` file. But you can edit the ``.config`` file directly or w=
ith
>     tools like ``make menuconfig O=3D.kunit``. As long as its a superset =
of
>     ``.kunitconfig``, kunit.py won't overwrite your changes.
>
>
> +.. note ::
> +
> +       To save a .kunitconfig after finding a satisfactory configuration=
::
> +
> +               make savedefconfig O=3D.kunit
> +               cp .kunit/defconfig .kunit/.kunitconfig
> +
> +Filtering tests by name
> +~~~~~~~~~~~~~~~~~~~~~~~
> +If you want to be more specific than Kconfig can provide, it is also pos=
sible
> +to select which tests to execute at boot-time by passing a glob filter
> +(read instructions regarding the pattern in the manpage :manpage:`glob(7=
)`).
> +If there is a ``"."`` (period) in the filter, it will be interpreted as =
a
> +separator between the name of the test suite and the test case,
> +otherwise, it will be interpreted as the name of the test suite.
> +For example, let's assume we are using the default config:
> +
> +a. inform the name of a test suite, like ``"kunit_executor_test"``,
> +   to run every test case it contains::
> +
> +       ./tools/testing/kunit/kunit.py run "kunit_executor_test"
> +
> +b. inform the name of a test case prefixed by its test suite,
> +   like ``"example.example_simple_test"``, to run specifically that test=
 case::
> +
> +       ./tools/testing/kunit/kunit.py run "example.example_simple_test"
> +
> +c. use wildcard characters (``*?[``) to run any test case that matches t=
he pattern,
> +   like ``"*.*64*"`` to run test cases containing ``"64"`` in the name i=
nside
> +   any test suite::
> +
> +       ./tools/testing/kunit/kunit.py run "*.*64*"
> +
>  Running Tests without the KUnit Wrapper
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  If you do not want to use the KUnit Wrapper (for example: you want code
> --
> 2.37.2
>
