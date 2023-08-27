Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ACE789BB7
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjH0HQ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 03:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0HQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 03:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA155123;
        Sun, 27 Aug 2023 00:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 793E061FA9;
        Sun, 27 Aug 2023 07:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61333C433C8;
        Sun, 27 Aug 2023 07:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693120586;
        bh=HAJvTUoS9SuyCicHEbnAk7Ecn+ThZtFqVswyUPuqpro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etxzV+Yr30qiLNLM5dWELx1azOncPMyE1zjdh9eBwNqTc4jaDqxhl4hGSyWi+asN7
         yMIhzZ0cfxanUkUN3FrQ7ehPsHAF0+CgU/aVZoPnKE88F7TIoG058lcsRZNp3xAHrs
         8HVskqym3z6P8gDnWWymkSJX5uOIXtVczyCm+cCI=
Date:   Sun, 27 Aug 2023 09:16:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hardik Garg <hargar@linux.microsoft.com>
Cc:     stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bjorn@kernel.org
Subject: Re: [PATCH 6.1] selftests/net: mv bpf/nat6to4.c to net folder
Message-ID: <2023082703-plenty-colonial-5540@gregkh>
References: <20230822220710.3992-1-hargar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822220710.3992-1-hargar@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 10:07:10PM +0000, Hardik Garg wrote:
> From: Hangbin Liu <liuhangbin@gmail.com>
> 
> commit 3c107f36db06 ("selftests/net: mv bpf/nat6to4.c to net folder")
> backport this v6.4 commit to v6.1 to fix this error:
> error: unable to open output file 'linux/kselftest/net/bpf/nat6to4.o':
> 'No such file or directory'

Note, this is a 6.3 commit, not 6.4 :)

Now queued up, thanks.

greg k-h
