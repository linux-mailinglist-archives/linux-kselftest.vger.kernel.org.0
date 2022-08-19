Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F625599A90
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 13:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348546AbiHSLFi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348538AbiHSLEy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 07:04:54 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDE8FBA4E;
        Fri, 19 Aug 2022 04:04:50 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M8Jmx2M9YzDqk5;
        Fri, 19 Aug 2022 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660907089; bh=VgOwRaOafAKxvvihQoE/8VDW5Esy6FtftczhQnuuQ1A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TtWBCbEYHbFsL3Di1OQMTocjrUJrb7sOaMwMUTYo/5Nbvq0+Jvs/zYa5Vmk6KOWGf
         XJJ62VD5tcs6AXsGMg4lOYUvqAAjSU/mzNlgjse1kUgs5AkyZQQl8xAydj28O+OGnX
         e6vTm/aqZ3zSD0MPDvKdBdtQmnZVZHlkCXEEY9lY=
X-Riseup-User-ID: 8A77544D1EBCD6A7168097DB83EDE48ACD5A381A6AE8078A5709A25E3121680F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M8Jmr4Qt5z5vcM;
        Fri, 19 Aug 2022 11:04:44 +0000 (UTC)
Message-ID: <f0c491f2-39fd-b778-bc63-99b3338c6d8a@riseup.net>
Date:   Fri, 19 Aug 2022 08:04:41 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] Documentation: KUnit: avoid repeating "kunit.py run"
 in start.rst
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
 <20220819053234.241501-3-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220819053234.241501-3-tales.aparecida@gmail.com>
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
> Combine two sections mentioning "kunit.py run" to streamline the
> getting-started guide.
> 
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---
>  Documentation/dev-tools/kunit/start.rst | 38 ++++++++++---------------
>  1 file changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index e730df1f468e..165d7964aa13 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -19,7 +19,21 @@ can run kunit_tool:
>  
>  	./tools/testing/kunit/kunit.py run
>  
> -For more information on this wrapper, see:
> +If everything worked correctly, you should see the following:
> +
> +.. code-block::
> +
> +	Generating .config ...

When I run ./tools/testing/kunit/kunit.py run, I usually see
"Configuring KUnit Kernel ..." instead of "Generating .config ...".
Maybe there was a change in the code that didn't reflect on the docs.

> +	Building KUnit Kernel ...
> +	Starting KUnit Kernel ...
> +
> +The tests will pass or fail.
> +
> +.. note ::
> +   Because it is building a lot of sources for the first time, the
> +   ``Building KUnit kernel`` may take a while.

Minor nit: s/``Building KUnit kernel``/``Building KUnit Kernel``

Best Regards,
- Maíra Canal

> +
> +For detailed information on this wrapper, see:
>  Documentation/dev-tools/kunit/run_wrapper.rst.
>  
>  Creating a ``.kunitconfig``
> @@ -74,28 +88,6 @@ you if you have not included dependencies for the options used.
>     tools like ``make menuconfig O=.kunit``. As long as its a superset of
>     ``.kunitconfig``, kunit.py won't overwrite your changes.
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
>  Running Tests without the KUnit Wrapper
>  =======================================
