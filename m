Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00FE7D0569
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjJSXfm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 19:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjJSXfl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 19:35:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449B6115;
        Thu, 19 Oct 2023 16:35:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA90C433C7;
        Thu, 19 Oct 2023 23:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697758539;
        bh=huNP5U6EPqqbROVxlGZgReWTYrbRuolKWR47ZxmhBIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yo2k6V+98u95BGWzaF84FVl5TI+LhK+j5J8ta01nJ/syTl/PXJUbDwEKhqvH2X3Q5
         4m77ga+6qMwHqerLHVLfV0c0jvm3Y+gp7ISiUdC/SXJc/+UfD2fDx1s/ymf7jaR8T3
         wuXMYa7wmwFAlk2bTtUEqIXfTV+f0fyT9HS7mTJs=
Date:   Thu, 19 Oct 2023 16:35:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/clone3: Skip new time namespace test when
 unsupported
Message-Id: <20231019163538.69d494a0af0560a492b5ffb4@linux-foundation.org>
In-Reply-To: <20231020-kselftest-clone3-time-ns-v1-1-31a17e072a05@kernel.org>
References: <20231020-kselftest-clone3-time-ns-v1-1-31a17e072a05@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 20 Oct 2023 00:08:12 +0100 Mark Brown <broonie@kernel.org> wrote:

> Use a filter function to skip the time namespace test on systems with
> !CONFIG_TIME_NS. This reworks a fix originally done by Tiezhu Yang prior
> to the refactoring in 34dce23f7e40 ("selftests/clone3: Report descriptive
> test names"). The changelog from their fix explains the issue very clearly:

I was about to send Tiezhu Yang's fix to Linus.   I'll rebase mm-hotfixes-stable
to drop that patch, so you own it now!

Please note that your version lacks an explicit cc:stable, but I suppose the
stablebots will scoop it up anyway.

> Original-fix-from: Tiezhu Yang <yangtiezhu@loongson.cn>

"Original-fix-from" isn't a thing.  In fact it seems to be the first
time this has been used.  Grepping for  "Original-.*:" shows
all sorts of innovations, including "Based-on-the-original-screenplay-by:".

I guess Documentation/process/submitting-patches.rst and checkpatch
lost this fight a long time ago.
