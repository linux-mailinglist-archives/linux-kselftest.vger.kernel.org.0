Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D9877A51B
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 08:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjHMG2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMG2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 02:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41992170D;
        Sat, 12 Aug 2023 23:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8CBE61CBF;
        Sun, 13 Aug 2023 06:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C8C433C8;
        Sun, 13 Aug 2023 06:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691908114;
        bh=+Td5TSxpsLZeeOtzGetm2J7r6OwLX9oUn6NqsBIeitE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NUgE58XS7bpLT8FdPA/9AtPFUgE2XWgb9VZ0y2eeH3FpeRUz7CPOoAU7UTAzqjk6e
         AErqTxfVPuU5xkQSlGjYAPYnRdOkso38EpeKXHRQJgN89t/RKbqZqPUTFgrdlkkYFH
         o+3rw25ZotCTbRRygLurr1CJwyxYrzd6XIcqgGFU=
Date:   Sun, 13 Aug 2023 08:28:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Copy out ftrace into its own console file
Message-ID: <2023081317-engine-pauper-2a6a@gregkh>
References: <20230813033737.3731290-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813033737.3731290-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 13, 2023 at 03:37:36AM +0000, Joel Fernandes (Google) wrote:
> From: Joel <agnel.joel@gmail.com>
> 
> Often times it is difficult to jump to the ftrace buffers and treat it
> independently during debugging. Copy the contents of the buffers into
> its own file.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

"From:" doesn't match the signed-off-by :(

