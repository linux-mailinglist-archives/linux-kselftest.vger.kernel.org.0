Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C17D57CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjJXQR2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 12:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjJXQR1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 12:17:27 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C7AF;
        Tue, 24 Oct 2023 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1698164242; bh=xMerMwIRbX/BQGxUkjEFes54aHCoVW+4DDPVS38Dwms=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=oVxZaOjWKwAGFLkFEzeXZ4MhPTf7YbBG4oZsHpNoqgwM9A43hm1pnn+0bMICMcbkY
         s+jkihVxCSly1ChuG67OqcrdkIjs8Ci0r5FwK1iX336umpLUsGamJPy0RuTVkTW+jq
         Mq4Nj9spjcW8CYz4ZWXuZ56R+SPt2hRZg9p63Cx8=
Date:   Tue, 24 Oct 2023 18:17:06 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>,
        Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <4b1a25de-f405-4267-8720-d611acc4f134@t-8ch.de>
In-Reply-To: <20231022093651.GF2669@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net> <20231010-nolibc-out-of-tree-v1-5-b6a263859596@weissschuh.net> <20231022093651.GF2669@1wt.eu>
Subject: Re: [PATCH 5/5] selftests/nolibc: generate config automatically
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <4b1a25de-f405-4267-8720-d611acc4f134@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Oct 22, 2023 11:37:05 Willy Tarreau <w@1wt.eu>:

> On Tue, Oct 10, 2023 at 02:34:00PM +0200, Thomas Wei=C3=9Fschuh wrote:
>> This new target generates a .config if none exists yet.
>>
>> Also drop the defconfig target with its hidden call to 'mrproper' which
>> is fairly invasive.
>> If users want to overwrite their kernel existing kernel configuration
>> they can do so easily from the toplevel directory.
>
> Hmmm I'm not sure about that one, I pretty much remember seeing failing
> arm64 builds when mrproper and prepare were missing.
>
> I would argue that someone starting "make defconfig" does expect the
> config to be dropped, hence mrproper to be called as well.
>
> What specific issue did you face with it ? Maybe we can restrict it to
> only a few cases ?

It was mostly a quality improvement for my testscript, where the config was=
 generated
automatically.

And then I dropped the combined defconfig target
because it seemed unnecessary.

Let's drop this patch.

Thomas
