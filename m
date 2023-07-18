Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6955757564
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 09:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGRHbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 03:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjGRHbQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 03:31:16 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066381722;
        Tue, 18 Jul 2023 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1689665466; bh=kJctb5ztbgsw2RiDo1dH2gTWrFCAh3bUkwZf/e7KypM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYB1DGR6PNYW0upGLudBLi/cKArgBTGIl9aZ3lVh2+qBkBvpM6d9XzagjzkQk3wb9
         CoYx1SFxWzovxjwM7I/nfcWumJ4yv6QlZ2ts5btwkPhMsanU/NUIo0m4KxOtq7+8L4
         udTnzcagJobdKpG7DPC9cZMvSicwbUt7uYV/EukM=
Date:   Tue, 18 Jul 2023 09:31:06 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: nolibc: KTAP output and test reports
Message-ID: <c6d3cabb-84f9-4f00-bfdd-de6810ed4c99@t-8ch.de>
References: <cc03380f-594f-431b-941d-aea879a0c084@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc03380f-594f-431b-941d-aea879a0c084@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy,

On 2023-06-08 00:15:27+0200, Thomas Weißschuh wrote:
> after your recent discussions about the test output and report I
> wondered if it would make sense to switch nolibc-test to KTAP output
> format [0].
> 
> With this it would be possible to have a wrapper script run each
> architecture test as its own test subcomponent.
> A (K)TAP parser/runner could then directly recognize and report failing
> testcases, making it easier to validate.
> 
> Also maybe we can hook it up into the regular kselftests setup and have
> the bots run it as part of that.
> 
> The kernel even includes a header-only library to implement the format [1].
> It also should be fairly easy to emit the format without a library.

Did you have a chance to look at this?

If you are not categorically opposed I would create a proof of concept
for further discussion.

> [0] Documentation/dev-tools/ktap.rst
> [1] Documentation/dev-tools/kselftest.rst (Test harness)
