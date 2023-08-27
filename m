Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DD278A2AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjH0W1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjH0W1j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 18:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A980E1;
        Sun, 27 Aug 2023 15:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8642661F5B;
        Sun, 27 Aug 2023 22:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53025C433C8;
        Sun, 27 Aug 2023 22:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693175256;
        bh=nO90eIbJU3OjsDzA0eYKuSOLi+CWO6HezawtwvzjjlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbxunygoKA1HS2v5q8NUC0lotMH9+IzWVHw7P4442DnKHF7M4t6m0w0dTIXBNXn7Y
         fLFI+dem3wOh00iXPwg9tkTdGThiJ7tp8jIEncdr4QthSbDRaHAOqQ1A28mSgJX4HV
         BMJhYbPOVIPlXFWrULh6yi0+3Uxq2jKKITGhw0wU=
Date:   Mon, 28 Aug 2023 00:27:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15 1/2] torture: Avoid torture-test reboot loops
Message-ID: <2023082812-pampers-uptown-69a2@gregkh>
References: <20230827215741.246948-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827215741.246948-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 09:57:39PM +0000, Joel Fernandes (Google) wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> [ Upstream commit 10f84c2cfb5045e37d78cb5d4c8e8321e06ae18f ]

I don't see this commit in Linus's tree, am I just missing it somewhere?

thanks,

greg k-h
