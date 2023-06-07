Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E772715D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 00:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFGWPl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjFGWPk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 18:15:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FD52119;
        Wed,  7 Jun 2023 15:15:39 -0700 (PDT)
Date:   Thu, 8 Jun 2023 00:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1686176138; bh=pQ9vvxki5YLy1NsCzvkhpdugXedCaJ81g7oe9b6lLqQ=;
        h=Date:From:To:Cc:Subject:From;
        b=krsgNIC+PDmePAlT5yaqB8FqM26sR1ktyu5vo8ZKFISmrxo23SKTna31AkAJYDJoZ
         GJsPcJL34RRM3itkxsQLSL/dQnEmHWqbCbWSiy0AMJf+XNiMtPbefL4JQ91PMWPWEg
         aUZCJsrFYlDKyOZ2wL/1Ad9frz66XtoSM5gWRWWk=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: nolibc: KTAP output and test reports
Message-ID: <cc03380f-594f-431b-941d-aea879a0c084@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Willy, Zhangjin,

after your recent discussions about the test output and report I
wondered if it would make sense to switch nolibc-test to KTAP output
format [0].

With this it would be possible to have a wrapper script run each
architecture test as its own test subcomponent.
A (K)TAP parser/runner could then directly recognize and report failing
testcases, making it easier to validate.

Also maybe we can hook it up into the regular kselftests setup and have
the bots run it as part of that.

The kernel even includes a header-only library to implement the format [1].
It also should be fairly easy to emit the format without a library.

Thomas

[0] Documentation/dev-tools/ktap.rst
[1] Documentation/dev-tools/kselftest.rst (Test harness)
