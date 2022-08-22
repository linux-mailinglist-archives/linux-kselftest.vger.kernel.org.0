Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6988559BE99
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 13:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiHVLc7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 07:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbiHVLct (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 07:32:49 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69036356DC;
        Mon, 22 Aug 2022 04:32:46 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MB9Fn6Bx6zDrVf;
        Mon, 22 Aug 2022 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661167966; bh=OUMmq98oeFiEp0mE5Azg1/+y4ajDaWAKrWs37juM6GQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JBIv38YnsNub8oyAdKIUfVsmk2i07BNR/NLoePIHfxk8Di+mFkpYV8GTtIgbC12b7
         OSfgYRhRDijabcLILZXwD9Eil3tzUdkkTR7WntaisTYrIvvfDaoG09polA8ht1VDeb
         yatxb3BPdp6tPjmQLHKsg3rrJ+WCp5BM6oZSjMjY=
X-Riseup-User-ID: CA0E823BECDD724A52C6470718F8117D69D41CA1458B0CBBFEC8D433579B3E1C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MB9Fj0pvpz5vNB;
        Mon, 22 Aug 2022 11:32:40 +0000 (UTC)
Message-ID: <fcbda624-239b-af9b-3674-d1cf6087942a@riseup.net>
Date:   Mon, 22 Aug 2022 08:32:33 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/8] Documentation: KUnit: avoid repeating "kunit.py
 run" in start.rst
Content-Language: en-US
To:     Tales Aparecida <tales.aparecida@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com
References: <20220822022646.98581-1-tales.aparecida@gmail.com>
 <20220822022646.98581-3-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220822022646.98581-3-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 8/21/22 23:26, Tales Aparecida wrote:
> Combine two sections mentioning "kunit.py run" to streamline the
> getting-started guide. Update "kunit.py run" expected output in
> the guide and run_wrapper.
> 
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>

Thanks for the quick re-spin!

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> 
> ---
> Notes:
>      Update the expected output and the note that follows it (Maíra Canal and
>      Sadiya Kazi). The output was updated on the commit: 45ba7a893ad8
>      ("kunit: kunit_tool: Separate out config/build/exec/parse")
>      Add word "step" to note and fix the case of "kernel".
> ---
>   Documentation/dev-tools/kunit/run_wrapper.rst |  2 +-
>   Documentation/dev-tools/kunit/start.rst       | 38 ++++++++-----------
>   2 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
> index 518cf87ea732..6b33caf6c8ab 100644
> --- a/Documentation/dev-tools/kunit/run_wrapper.rst
> +++ b/Documentation/dev-tools/kunit/run_wrapper.rst
> @@ -22,7 +22,7 @@ We should see the following:
>   
>   .. code-block::
>   
> -	Generating .config...
> +	Configuring KUnit Kernel ...
>   	Building KUnit kernel...
>   	Starting KUnit kernel...
>   
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index e730df1f468e..2e31350a85e1 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -19,7 +19,21 @@ can run kunit_tool:
>   
>   	./tools/testing/kunit/kunit.py run
>   
> -For more information on this wrapper, see:
> +If everything worked correctly, you should see the following:
> +
> +.. code-block::
> +
> +	Configuring KUnit Kernel ...
> +	Building KUnit Kernel ...
> +	Starting KUnit Kernel ...
> +
> +The tests will pass or fail.
> +
> +.. note ::
> +   Because it is building a lot of sources for the first time,
> +   the ``Building KUnit Kernel`` step may take a while.
> +
> +For detailed information on this wrapper, see:
>   Documentation/dev-tools/kunit/run_wrapper.rst.
>   
>   Creating a ``.kunitconfig``
> @@ -74,28 +88,6 @@ you if you have not included dependencies for the options used.
>      tools like ``make menuconfig O=.kunit``. As long as its a superset of
>      ``.kunitconfig``, kunit.py won't overwrite your changes.
>   
> -Running Tests (KUnit Wrapper)
> ------------------------------
> -1. To make sure that everything is set up correctly, invoke the Python
> -   wrapper from your kernel repository:
> -
> -.. code-block:: bash
> -
> -	./tools/testing/kunit/kunit.py run
> -
> -If everything worked correctly, you should see the following:
> -
> -.. code-block::
> -
> -	Generating .config ...
> -	Building KUnit Kernel ...
> -	Starting KUnit Kernel ...
> -
> -The tests will pass or fail.
> -
> -.. note ::
> -   Because it is building a lot of sources for the first time, the
> -   ``Building KUnit kernel`` may take a while.
>   
>   Running Tests without the KUnit Wrapper
>   =======================================
