Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F81377D8DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 05:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbjHPDNL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 23:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241504AbjHPDMo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 23:12:44 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBAF5E6B;
        Tue, 15 Aug 2023 20:12:42 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37G3CKl5018070;
        Wed, 16 Aug 2023 05:12:20 +0200
Date:   Wed, 16 Aug 2023 05:12:20 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
Message-ID: <20230816031220.GA18057@1wt.eu>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
 <20230815143540.GA15075@1wt.eu>
 <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
 <9950607c-cafe-c011-7d5f-76a8a971beb0@linuxfoundation.org>
 <ZNvIkD1oxZENVkoe@1wt.eu>
 <85a03aa3-3d6e-3b16-d113-7d7f5a84bfb4@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a03aa3-3d6e-3b16-d113-7d7f5a84bfb4@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 03:06:39PM -0600, Shuah Khan wrote:
> Pull worked fine and my verify_fixes script failed on the following patches.
> 
> Commit: 6c931bf0c732 ("selftests/nolibc: avoid buffer underrun in space printing")
> 	Fixes tag: Fixes: 8a27526f49f9 ("selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> Commit: 40f12898b479 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
> 	Fixes tag: Fixes: ecb7fe2cd610 ("selftests: line buffer test program's stdout")
> 	Has these problem(s):
> 		- Target SHA1 does not exist
> 
> 
> Will you be able to add the right commit IDs and resend the pull, so there
> are no mistakes if I guess it wrong.

Will do, many thanks for the check!
Willy
