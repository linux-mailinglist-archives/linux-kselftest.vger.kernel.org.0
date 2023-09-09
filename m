Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693BA7995DF
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Sep 2023 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbjIIB5s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 21:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjIIB5s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 21:57:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFA5186;
        Fri,  8 Sep 2023 18:57:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93929C433C7;
        Sat,  9 Sep 2023 01:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694224664;
        bh=hPlhWYXoxMB13Bs2dThgtL6xFZJ2Lc+eLHYA4wq5rEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SdysHumw8t+oNc3pE1kBFKyhZcAMpGGHy/USUajloff6fqBVuvTCr77rDUGEYhcZC
         kMrrlvaE61WbJRWJwf98PBuyTO9w9K+/+N66B4Qze2DfYNLK99EFI0a5Kb93tnX4bN
         ezEEdcW7Ulzmt7epZ3aWEVyiT4QY0qepi0IP3dVSRPkaW3V8/DRWwhOnEXJp2rgOcq
         vAvQrIZypdRLPJL7VZuCJQqVcZ+TYnkT8YL0zqTzLA3OdOL8nj24WcpZHgb8OL9B6M
         bL+CNUVQNj5gdtwcLBwef8S5FjH5auOkvSoylw4/r4OPkkypbSo7MFFnyu4t/KulVN
         sMXiFZqwKzbDA==
Date:   Sat, 9 Sep 2023 10:57:38 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>, rostedt@goodmis.org,
        shuah@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        naresh.kamboju@linaro.org, anders.roxell@linaro.org, arnd@arndb.de
Subject: Re: [PATCH v2] selftests/user_events: Fix failures when user_events
 is not installed
Message-Id: <20230909105738.edd1c794dc861b60ed010668@kernel.org>
In-Reply-To: <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
References: <20230908201916.562-1-beaub@linux.microsoft.com>
        <29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 9 Sep 2023 00:33:05 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Sep 08, 2023 at 08:19:16PM +0000, Beau Belgrave wrote:
> 
> > Add common methods to detect if tracefs and user_events is enabled. If
> > either is not enabled skip the test. If tracefs is enabled, but is not
> > mounted, mount tracefs and fail if there were any errors. Fail if not
> > run as root.
> 
> This will leave tracefs mounted if it was not already mounted which is a
> change to the system configuration.  While that may happen if things go
> wrong during a test we should probably avoid actively doing this and
> either only skip or try to umount at the end of the test if we mounted
> ourselves.

Oh, I didn't know that. I need to update ftracetest to unmount tracefs if
it is not mounted.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
