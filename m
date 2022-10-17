Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F198D601094
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Oct 2022 15:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJQNzy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Oct 2022 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiJQNzx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Oct 2022 09:55:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B313554192
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Oct 2022 06:55:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0FDDF2C0;
        Mon, 17 Oct 2022 13:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0FDDF2C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666014950; bh=ni6U8G+QmQhAjHliaAr49l5NZ9JoBMlkY5v4Rk3jxCA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PKSsJvV+F2XU4UBMkXG4uXdPFyhiHTd41wOWJUcCcffqVA6HTWjw+s5zKXPZdcVoJ
         K4bxcf7v8Bo/Yfv+bTeuV9mbiuPOoIbELUWIoGugrkJlIUcpffeaoqx40cvoFmrZ4C
         b75q/vnrDw1hJRmKKQJ9EkYTCpaPi8MpSkz6vG3D7yiCr07KOdgLY0gWZuytoM5fF0
         vykoESqk/61q3+KISdkClMQt8jyRbmD7C6PXcTn8gwBGpNzS/DGqdCI0GoTH4k5CiY
         +idG4ubZdyUnKYhrRcesBH6mk0/g7zhwy5nM0UPXmgyth4UPXGAFgrg1UIWmDc175V
         7nYyGUwuRnBOg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: Kunit: Update architecture.rst for
 minor fixes
In-Reply-To: <Y00im2gq9/c5NzVt@debian.me>
References: <20221017070820.2253501-1-sadiyakazi@google.com>
 <Y00im2gq9/c5NzVt@debian.me>
Date:   Mon, 17 Oct 2022 07:55:49 -0600
Message-ID: <87lepeftay.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Seems like you ignore my requested changes from v1 and v2 review (code
> location link and redundant kunit_tool summary), hence NAK until you
> have addressed them.

Bagas, you are not a maintainer of or contributor to this work; you are
in no position to "NAK" anything.  I will ask you, yet again, to please
focus on doing useful work yourself rather than on adding friction for
others.

jon
