Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF546BB60C
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 15:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjCOObH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjCOObE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 10:31:04 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0C82B2A5
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 07:30:34 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id YeWY2900X1C8whw01eWZis; Wed, 15 Mar 2023 15:30:33 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pcS9A-00CIC9-UO;
        Wed, 15 Mar 2023 15:30:32 +0100
Date:   Wed, 15 Mar 2023 15:30:32 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Tobias Klausmann <klausman@schwarzvogel.de>
cc:     linux-kselftest@vger.kernel.org
Subject: Re: BUG in dhrystone selftest on v6.3-rc1
In-Reply-To: <4aeec948-f1b8-4d2a-b096-b2d6104946ba@skade.local>
Message-ID: <34f084bd-a4ea-aae5-8d72-de29fbb19630@linux-m68k.org>
References: <4aeec948-f1b8-4d2a-b096-b2d6104946ba@skade.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

 	Hi Tobias,

On Fri, 10 Mar 2023, Tobias Klausmann wrote:
> just ran the new Dhrystone test on one of my machines post-boot (using
> echo y > /sys/module/test_dhry/parameters/run) and:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: bash/1903

Thanks for your report!

I have posted a fix
https://lore.kernel.org/r/b0d29932bb24ad82cea7f821e295c898e9657be0.1678890070.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
