Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E8C599AFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 13:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348633AbiHSLWb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348516AbiHSLWa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 07:22:30 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC1DC6FF3;
        Fri, 19 Aug 2022 04:22:29 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M8K9J4vq6zDrR3;
        Fri, 19 Aug 2022 11:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660908148; bh=gHevZHd4MwauF+bQaKmbIYbAX/zcMUuWSuNRVfR4Jck=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qWk/NwWh2R9bLINwJ1iJZuYSVYWVljkYFI5H7Vlvcg/rJlLExlxemhZk5S9aPfez9
         vj9xKWOdRporzsGZtMznEsViydXFRwTqy6EhtHJAKbVVSv6J8XWLakF+ZdlKrlNmZT
         Nm6K3OV8DN81CNZenQQ00a/1XhPSLezH7jNmlek8=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4M8K9H3Mvcz9tKP;
        Fri, 19 Aug 2022 11:22:27 +0000 (UTC)
X-Riseup-User-ID: E29BAA7489794C54C8350D3A96F1DFE8F1AB44A83D4D17D36133215CA8957214
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M8K9B5vbfz5vTJ;
        Fri, 19 Aug 2022 11:22:22 +0000 (UTC)
Message-ID: <a248b7b5-6d3b-8bc9-a36e-58a311bb27b8@riseup.net>
Date:   Fri, 19 Aug 2022 08:22:20 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 4/8] Documentation: KUnit: Reword start guide for
 selecting tests
Content-Language: en-US
To:     Tales Aparecida <tales.aparecida@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-5-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220819053234.241501-5-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Tales

On 8/19/22 02:32, Tales Aparecida wrote:
> Reword "Creating a ``.kunitconfig``" into "Selecting which tests to run"
> covering the current alternatives for editing configs and glob-filtering
> 
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---
>  Documentation/dev-tools/kunit/start.rst | 90 +++++++++++++++++--------
>  1 file changed, 63 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index e4b73adde6d0..f0ec64207bd3 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -52,27 +52,20 @@ The tests will pass or fail.
>  For detailed information on this wrapper, see:
>  Documentation/dev-tools/kunit/run_wrapper.rst.
>  
> -Creating a ``.kunitconfig``
> ----------------------------
> -
> -By default, kunit_tool runs a selection of tests. However, you can specify which
> -unit tests to run by creating a ``.kunitconfig`` file with kernel config options
> -that enable only a specific set of tests and their dependencies.
> -The ``.kunitconfig`` file contains a list of kconfig options which are required
> -to run the desired targets. The ``.kunitconfig`` also contains any other test
> -specific config options, such as test dependencies. For example: the
> -``FAT_FS`` tests - ``FAT_KUNIT_TEST``, depends on
> -``FAT_FS``. ``FAT_FS`` can be enabled by selecting either ``MSDOS_FS``
> -or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
> +Selecting which tests to run
> +----------------------------
>  
> -.. code-block:: none
> +By default, kunit_tool runs all tests reachable with minimal configuration,
> +that is, using default values for most of the kconfig options.  However,
> +you can select which tests to run by:
>  
> -	CONFIG_KUNIT=y
> -	CONFIG_MSDOS_FS=y
> -	CONFIG_FAT_KUNIT_TEST=y
> +- `Customizing Kconfig`_ used to compile the kernel, or
> +- `Filtering tests by name`_ to select specifically which compiled tests to run.
>  
> -1. A good starting point for the ``.kunitconfig`` is the KUnit default config.
> -   You can generate it by running:
> +Customizing Kconfig
> +~~~~~~~~~~~~~~~~~~~
> +A good starting point for the ``.kunitconfig`` is the KUnit default config.
> +If you didn't run ``kunit.py run`` yet, you can generate it by running:
>  
>  .. code-block:: bash
>  
> @@ -84,27 +77,70 @@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
>     ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which is
>     ``.kunit`` by default.
>  
> -.. note ::
> +Before running the tests, kunit_tool ensures that all config options
> +set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> +you if you have not included dependencies for the options used.
> +
> +There are many ways to customize the configurations:
> +
> +a. Edit ``.kunit/.kunitconfig``. The file should contain the list of kconfig
> +   options required to run the desired tests, including their dependencies.
>     You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as
>     it will enable a number of additional tests that you may not want.
> +   If you need to run on an architecture other than UML see :ref:`kunit-on-qemu`.
>  
> -2. You can then add any other Kconfig options, for example:
> +b. Enable additional kconfig options on top of ``.kunit/.kunitconfig``.
> +   For example, to include the kernel's linked-list test you can run::
>  
> -.. code-block:: none
> +	./tools/testing/kunit/kunit.py run \
> +		--kconfig_add CONFIG_LIST_KUNIT_TEST=y
>  
> -	CONFIG_LIST_KUNIT_TEST=y
> +c. Provide the path of one or more .kunitconfig files from the tree.
> +   For example, to run only ``FAT_FS`` and ``EXT4`` tests you can run::
>  
> -Before running the tests, kunit_tool ensures that all config options
> -set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
> -you if you have not included dependencies for the options used.
> +	./tools/testing/kunit/kunit.py run \
> +		--kunitconfig ./fs/fat/.kunitconfig \
> +		--kunitconfig ./fs/ext4/.kunitconfig
>  
> -.. note ::
> -   If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
> +d. If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
>     ``.config`` file. But you can edit the ``.config`` file directly or with
>     tools like ``make menuconfig O=.kunit``. As long as its a superset of
>     ``.kunitconfig``, kunit.py won't overwrite your changes.
>  
>  
> +.. note ::
> +
> +	To save a .kunitconfig after finding a satisfactory configuration::
> +
> +		make savedefconfig O=.kunit
> +		cp .kunit/defconfig .kunit/.kunitconfig
> +
> +Filtering tests by name
> +~~~~~~~~~~~~~~~~~~~~~~~
> +If you want to be more specific than Kconfig can provide, it is also possible
> +to select which tests to execute at boot-time by passing a glob filter
> +(read instructions regarding the pattern in the manpage :manpage:`glob(7)`).
> +If there is a ``"."`` (period) in the filter, it will be interpreted as a
> +separator between the name of the test-suite and the test-case,
> +otherwise, it will be interpreted as the name of the test suite.
> +For example, let's assume we are using the default config:

Another small nit: you could keep the consistency on naming test-suite
and test-cases. Currently, you are using "test-suite" and "test suite"
(same for test-cases). I guess any of the two options are fine, but it
would be nice to keep it consistent.

> +
> +a. inform the name of a test suite, like ``"kunit_executor_test"``,
> +   to run every test case it contains::
> +
> +	./tools/testing/kunit/kunit.py run "kunit_executor_test"
> +
> +b. inform the name of a test case prefixed by its test suite,
> +   like ``"example.example_simple_test"``, to run specifically that test case::
> +
> +	./tools/testing/kunit/kunit.py run "example.example_simple_test"
> +
> +c. use wildcard characters (``*?[``) to run any test-case that match the pattern,

I guess it would be "matches" instead of "match" here.

Other than this small nits, this is a great improvement on the docs!

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> +   like ``"*.*64*"`` to run test-cases containing ``"64"`` in the name inside
> +   any test-suite::
> +
> +	./tools/testing/kunit/kunit.py run "*.*64*"
> +
>  Running Tests without the KUnit Wrapper
>  =======================================
>  If you do not want to use the KUnit Wrapper (for example: you want code
