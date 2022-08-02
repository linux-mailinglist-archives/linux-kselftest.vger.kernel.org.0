Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C29E588023
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 18:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiHBQTz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 12:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiHBQTy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 12:19:54 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6109BC38;
        Tue,  2 Aug 2022 09:19:53 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ly0ZK0plSzDrnq;
        Tue,  2 Aug 2022 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659457193; bh=31MhJt5fjArXpYyU6KYJb6a/trvSJzJjG6BpGBq8ddk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EaV5+pOCQ5si0XL6vFU7fHVHdVqn1ByGOTq/15dP9HDr5e35FqaO7lpCxVtngctY2
         caHn82jEKJjnnE4q2gRuFhwG9KoGcFJn6IaThQXrrYJ+vY8H+oQx9DUT0ErbZTOlyQ
         tPq0pYmAKQe1m9Fb++nptqA3ZN54wLU2kldDYjGs=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4Ly0ZC2XWGz9t2X;
        Tue,  2 Aug 2022 16:19:47 +0000 (UTC)
X-Riseup-User-ID: BD0BA3B43EF72C3702A87119B35DE3ABB262086C22E4790838CF34584D80F0C1
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly0Z64kscz5vTk;
        Tue,  2 Aug 2022 16:19:42 +0000 (UTC)
Message-ID: <5c9038fd-a247-d0d3-841c-ba1e606bc309@riseup.net>
Date:   Tue, 2 Aug 2022 13:19:41 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] kunit: add KUnit array assertions to the
 example_all_expect_macros_test
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
Cc:     melissa.srw@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        jose.exposito89@gmail.com, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, davidgow@google.com,
        davem@davemloft.net, Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, airlied@linux.ie, kuba@kernel.org
References: <20220802161206.228707-1-mairacanal@riseup.net>
 <20220802161206.228707-3-mairacanal@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20220802161206.228707-3-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Às 13:12 de 02/08/22, Maíra Canal escreveu:
> Increament the example_all_expect_macros_test with the
> KUNIT_EXPECT_ARREQ and KUNIT_EXPECT_ARRNEQ macros by creating a test
> with array assertions.
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
>  lib/kunit/kunit-example-test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index f8fe582c9e36..fc81a45d9cbc 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -86,6 +86,9 @@ static void example_mark_skipped_test(struct kunit *test)
>   */
>  static void example_all_expect_macros_test(struct kunit *test)
>  {
> +	const u32 array[] = { 0x0F, 0xFF };
> +	const u32 expected[] = { 0x1F, 0xFF };
> +
>  	/* Boolean assertions */
>  	KUNIT_EXPECT_TRUE(test, true);
>  	KUNIT_EXPECT_FALSE(test, false);
> @@ -109,6 +112,10 @@ static void example_all_expect_macros_test(struct kunit *test)
>  	KUNIT_EXPECT_STREQ(test, "hi", "hi");
>  	KUNIT_EXPECT_STRNEQ(test, "hi", "bye");
>  
> +	/* Array assertions */
> +	KUNIT_EXPECT_ARREQ(test, expected, expected, 2);
> +	KUNIT_EXPECT_ARRNEQ(test, array, expected, 2);

ARRAY_SIZE() is usually better than constants is this case.

> +
>  	/*
>  	 * There are also ASSERT variants of all of the above that abort test
>  	 * execution if they fail. Useful for memory allocations, etc.
