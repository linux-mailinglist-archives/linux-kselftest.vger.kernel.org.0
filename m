Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1D6D997E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjDFOVQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 10:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjDFOVP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 10:21:15 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49F6B86AC;
        Thu,  6 Apr 2023 07:21:12 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 336EKT7g003156;
        Thu, 6 Apr 2023 16:20:29 +0200
Date:   Thu, 6 Apr 2023 16:20:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest: Support nolibc
Message-ID: <ZC7VLXGpB8PRdj12@1wt.eu>
References: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

On Thu, Apr 06, 2023 at 02:56:28PM +0100, Mark Brown wrote:
> At present the kselftest header can't be used with nolibc since it makes
> use of vprintf() which is not available in nolibc and seems like it would
> be inappropriate to implement given the minimal system requirements and
> environment intended for nolibc.

In fact we already have vfprintf(), and printf() is based on it, so
wouldn't it just be a matter of adding vprintf() that calls vfprintf()
for your case ? Maybe just something like this :

  static int vprintf(const char *fmt, va_list args)
  {
	return vfprintf(stdout, fmt, args);
  }

It's possible I'm missing something, but it's also possible you didn't
find vfprintf() which is why I prefer to raise my hand ;-)

> This has resulted in some open coded
> kselftests which use nolibc to test features that are supposed to be
> controlled via libc and therefore better exercised in an environment with
> no libc.

Yeah that's ugly. In nolibc-test we now have two build targets so that
we can more easily verify the compatibility between the default libc and
nolibc, so my recommendation would be to stick to a common subset of both
libcs, but not to rely on nolibc-specific stuff that could make tests
harder to debug.

Regards,
Willy
