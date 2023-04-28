Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD846F19BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjD1NgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346324AbjD1NgU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 09:36:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1A210B;
        Fri, 28 Apr 2023 06:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CE8643D9;
        Fri, 28 Apr 2023 13:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B72C433EF;
        Fri, 28 Apr 2023 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682688965;
        bh=Yh1psEtwTeQqxt+8prdTbNCjGoBo0VMN5gPaj2vUUFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtRU1lA+E+FKgFtSy4SAwEs+EwSZM07t+HlJmS5nUiISAYUlgykiAng0vFjUQ0xm5
         QL8npv0gS1F0p9zjcxfcvHFi96O3w2q8OZChTr3Zaev3vQeHpx8oYi+2Xwkp+gPuZ2
         nsOm3k//2Or59o5wTVuDk5TXrUuNSk6CSpQky2mgZ4CXpyTashL+j9XwE8CKvNy882
         TjvqaG37Y8IyTglrLtBoiuNTlxn4iEsxG8G5Lzjy+d84Mi27Lqpo4Ees7aODrm8xq/
         GI/oYOEAlvz+rAzarYI3XWWqDfSmql6oSfef4ylxTnd5o5b72df92hGtNm7TQBA2Qy
         OZB2Q0MjGi+oA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Apr 2023 16:35:58 +0300
Message-Id: <CS8FGC0JMPLC.1NN4BR2TTOVMW@wks-101042-mac.ad.tuni.fi>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Muhammad Usama Anjum" <usama.anjum@collabora.com>,
        "Yi Lai" <yi1.lai@intel.com>, <dave.hansen@linux.intel.com>,
        <shuah@kernel.org>, <jethro@fortanix.com>, <bp@suse.de>
Cc:     <linux-sgx@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <heng.su@intel.com>, <pengfei.xu@intel.com>
Subject: Re: [RESEND PATCH] selftests/sgx: Add "test_encl.elf" to TEST_FILES
X-Mailer: aerc 0.14.0
References: <20230421033123.445883-1-yi1.lai@intel.com>
 <9005b73c-85c5-8296-e329-5bb87bc8c3ec@collabora.com>
In-Reply-To: <9005b73c-85c5-8296-e329-5bb87bc8c3ec@collabora.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri Apr 28, 2023 at 3:31 PM EEST, Muhammad Usama Anjum wrote:
> On 4/21/23 8:31=E2=80=AFAM, Yi Lai wrote:
> > The "test_encl.elf" file used by test_sgx is not installed in
> > INSTALL_PATH. Attempting to execute test_sgx causes false negative:
> I've ran the following on next-20230427:
> make -C tools/testing/selftests O=3Dbuild2 -j `nproc`
>
> find | grep test_encl.elf
> ./build2/kselftest/sgx/test_encl.elf
>
> test_encl.elf is being copied already. Am i missing something?

I don't have access right to apply this to tip/x86/sgx.

BR, Jarkko
