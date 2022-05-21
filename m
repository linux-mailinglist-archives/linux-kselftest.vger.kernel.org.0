Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8752F7A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 04:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354367AbiEUCki (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 May 2022 22:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiEUCkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 May 2022 22:40:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44A41900C0;
        Fri, 20 May 2022 19:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        Subject:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qyf/zwUprsQMdEvfmj9FeIk1Jd9GfDCSYtZB2ONQMLY=; b=dXFjCihoY61BXVzES0IK9PU3fq
        VWU8C0i6nZNC4QiC719pzzq4vfhJIwKmrd8rGV1V9ptz4UJ7/7pKaWz93IP5+2Kmyp+QzpxwDLB5H
        81sFQ/ginhwYSMkq961wEqs6Unt5qbWTIWzNchgfVBQl/nPTgQPGHhwshM1LsXW/g+IRtsNd/c65G
        JaOmqzqms+NZ73h1c5zB3z1fJESSa4VqomKCKukHUs9v2zDWA8qy5Ra0PCRP/DCFpYRhAGeNKPcdF
        XtzKy/M/pgRjME0ig89lEOz1fS4fedJjs6k2Z2wBj2pQyDusXzt1e0DO/K8egJgzBsu1N1Zd1lg4W
        71M784ag==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsF2d-00EJbS-Qk; Sat, 21 May 2022 02:40:32 +0000
Message-ID: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
Date:   Fri, 20 May 2022 19:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in
 drivers/iio/afe/iio-rescale.o
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

In March I reported that a randconfig build complained:

ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o

(https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)

I am still seeing this problem so I tried to dig into it a bit.
However, I don't see why get_next_modinfo() and friends don't find the
MODULE_LICENSE() since it is in the iio-rescale.o file.

(BTW, I see this build error on many different $ARCH [around 15 tested]
and with 2 different versions of GCC.)

Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
strings?

It looks like it is, because it appears (?) that modpost is looking at
drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
loadable module).

Is this confusing modpost?
I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
Makefile entry accordingly and the MODULE_LICENSE error goes away.

Is this a modpost error or is kunit messing things up?

thanks for looking.
-- 
~Randy
