Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D40599AFE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbiHSL2q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348241AbiHSL2p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 07:28:45 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFB5B514B;
        Fri, 19 Aug 2022 04:28:44 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M8KJW631TzDrR3;
        Fri, 19 Aug 2022 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660908524; bh=HtTFlUxYhMXKADnhF9mXs30RyZIzn/W5VJYsvu6FAWY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oNE1KfuQvtHc6iPUUoq7FSpjOkKEPrc/+RR6cYSgcJxHZ9z8/8ccbHuB+sKb98nqQ
         aoYWA88GUFWtbXCLjG4psT0qZVNooAuaAOMK4D4UxqvFwhz1DbNC0wRWgEhZKObksV
         TxaV7riL7BmM91aLXMkes37L28oiNzpYdwxIrnpw=
X-Riseup-User-ID: 0F8265F3B5B153B0BB085616B6910490B77EA1389FDF561D07126609569FEFE3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M8KJR1sMPz5vQt;
        Fri, 19 Aug 2022 11:28:38 +0000 (UTC)
Message-ID: <ff728926-22e4-e65b-ee94-2ed958c92993@riseup.net>
Date:   Fri, 19 Aug 2022 08:28:36 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 5/8] Documentation: KUnit: add intro to the
 getting-started page
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
 <20220819053234.241501-6-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220819053234.241501-6-tales.aparecida@gmail.com>
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
> Describe the objective of the Getting Started page, which should be a
> brief and beginner-friendly walkthrough for running and writing tests,
> showing the reader where to find detailed instructions in other pages.
> 
> Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> ---
>  Documentation/dev-tools/kunit/start.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index f0ec64207bd3..3855402a5b3e 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -4,6 +4,11 @@
>  Getting Started
>  ===============
>  
> +This page contains an overview about the kunit_tool and Kunit framework,
> +teaching how to run existent tests and then how to write a simple test-case,
> +and covering common problems users face when using Kunit for the first time.
> +It is recommended that the reader had compiled the Kernel at least once before.

Some grammar nits:
- s/an overview about/an overview of
- s/Kunit/KUnit for consistency
- s/existent/existing
- s/covering/covers

Other than this small nits,

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> +
>  Installing Dependencies
>  =======================
>  KUnit has the same dependencies as the Linux kernel. As long as you can
