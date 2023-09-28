Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2454A7B17D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjI1Jtk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjI1Jti (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 05:49:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0D122;
        Thu, 28 Sep 2023 02:49:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695894576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwnfLlNEFXntJd663pl0BMeaT9w2sLT/CHutGXpU3Nw=;
        b=2gcSdO9WC57MnMIy+RBiWphp569I6Uh8vvVSAyG2kDwkr5oRWKE/2X/kXBhpvxsualMGjX
        oKxYedwMRWId7Z5v6pIB5mglz7JD4VETLU6q1/OFw6GVyzUbGsX+0g/TTs44yxAB8IbL0a
        DpKq+0s/rMjgWVkq03fr0jvZjgKIIhE1kvQGTiMSG5pdMGx1u0uVAW0NmvrGsRGCwVQABg
        IUr85WUvBe3n7/D5LZfLhaawdheJE5rRiKaDG+KAnyBhYPL86glUgr1rypUYzlsSGXVDk7
        qlNds8fajtVMmjPFaOBGDEiLZYJK1j0uA1vE7b1hQo6TTuY4kfNWR1pK2uRcVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695894576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cwnfLlNEFXntJd663pl0BMeaT9w2sLT/CHutGXpU3Nw=;
        b=IN6NhWgQxgvkaS0koremfj2dASj7Hj37MXvle3TsZwgQp2E+2aNLCSOA7lCaLdhHFEW6q+
        0YwQERzGTxkjhPCw==
To:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] selftests: timers: Convert some more of the timers
 tests to KTAP
In-Reply-To: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
References: <20230927-ktap-posix-timers-v1-0-399de1cbfbea@kernel.org>
Date:   Thu, 28 Sep 2023 11:49:35 +0200
Message-ID: <8734yyfx00.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 27 2023 at 12:18, Mark Brown wrote:

> KTAP is the standard output format for selftests, providing a method for
> systems running the selftests to get results from individual tests
> rather than just a pass/fail for the test program as a whole.  While
> many of the timers tests use KTAP some have custom output formats, let's
> convert a few more to KTAP to make them work better in automation.
>
> The posix_timers test made use of perror(), I've added a generic helper
> to kselftest.h for that since it seems like it'll be useful elsewhere.
>
> There are more tests that don't use KTAP, several of them just run a
> single test so don't really benefit from KTAP and there were a couple
> where the conversion was a bit more complex so I've left them for now.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
