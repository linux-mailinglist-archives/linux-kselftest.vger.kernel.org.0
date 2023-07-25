Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D42D761C3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGYOrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 10:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGYOrY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 10:47:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 247881BE
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jul 2023 07:47:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34BBD15BF;
        Tue, 25 Jul 2023 07:48:03 -0700 (PDT)
Received: from [10.1.36.36] (C02Z41KALVDN.cambridge.arm.com [10.1.36.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AFD63F6C4;
        Tue, 25 Jul 2023 07:47:18 -0700 (PDT)
Message-ID: <624b3b13-bf91-1f0b-ca12-c50999643d47@arm.com>
Date:   Tue, 25 Jul 2023 15:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: selftests: arm64: za-fork.c: kselftest.h:123:2: error: call to
 undeclared function 'setvbuf'; ISO C99 and later do not support implicit
 function declarations
To:     Mark Brown <broonie@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYus3Z8r2cg3zLv8uH8MRrzLFVWdnor02SNr=rCz+_WGVg@mail.gmail.com>
 <41cd365e-7757-4c93-9d36-0a258d6d59db@sirena.org.uk>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <41cd365e-7757-4c93-9d36-0a258d6d59db@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/07/2023 14:00, Mark Brown wrote:
> On Tue, Jul 25, 2023 at 06:26:34PM +0530, Naresh Kamboju wrote:
>> selftests: arm64: za-fork.c build failed with clang-16 due to below
>> warnings / errors on Linux next-20230725.
> 
> Ryan, this looks to be your setvbuf() change:

Thanks, Mark, for adding me in. Yes this is due to my change ensure that stdout
is never block buffered, since this was causing a lot of duplicated output for
mm selftests due to lots of in-test fork()ing.

It looks like these tests are using nolibc, which doesn't implement setvbuf().
I'm working on a fix, which will add setvbuf() to nolibc (which will be a nop
since nolibc never buffers).

Thanks,
Ryan


