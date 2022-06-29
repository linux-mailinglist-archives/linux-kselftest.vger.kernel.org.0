Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7E5605CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jun 2022 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiF2QZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jun 2022 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiF2QZs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jun 2022 12:25:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F03E313BA;
        Wed, 29 Jun 2022 09:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3794CE2819;
        Wed, 29 Jun 2022 16:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C294C34114;
        Wed, 29 Jun 2022 16:25:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pcAWGf38"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656519940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68juHfv4ygcIaahoO6PbfPTLidvNwti4IiRxQ+0kt6w=;
        b=pcAWGf38OzIMgyPi4OUE3lxDPN67fDsAwjtmVY65jBcFJHVgSvrOJLrXxTDJgzjglyzQ1u
        2CSO9+yCjfBazL0tv1CtSmUtDTr4aCsE3ZzVZ02CULsAB0CdMri+FLuqwPNnCRQgJS+/oB
        YOKOC2ccbkhGrCi051exLIABSKZ8eyM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1fb02a60 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 29 Jun 2022 16:25:40 +0000 (UTC)
Date:   Wed, 29 Jun 2022 18:25:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] remove CONFIG_ANDROID
Message-ID: <Yrx8/Fyx15CTi2zq@zx2c4.com>
References: <20220629150102.1582425-1-hch@lst.de>
 <20220629150102.1582425-2-hch@lst.de>
 <Yrx5Lt7jrk5BiHXx@zx2c4.com>
 <20220629161020.GA24891@lst.de>
 <Yrx6EVHtroXeEZGp@zx2c4.com>
 <20220629161527.GA24978@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629161527.GA24978@lst.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 29, 2022 at 06:15:27PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 29, 2022 at 06:13:05PM +0200, Jason A. Donenfeld wrote:
> > Good! It sounds like you're starting to develop opinions on the matter.
> 
> No, I provide facts.

Lol.

> Look at both the definition of the symbol, and
> various distribution kernel that enabled it and think hard if they run
> on "Android" hardware.  Not just primarily, but at all.

There are two failure modes:

1) Key clearing code is skipped when it shouldn't be.
2) Key clearing code is run when it shouldn't be.

You've identified (well, Alex in the other thread I think?) a case of
(1). I was sort of thinking the fix to that would be that distros
shouldn't enable that option, but it doesn't really matter to me.

However, what I'm pointing out is the potential for (2). A (2)-style
regression means that WireGuard basically doesn't work, because, for
example, qcacld's packet-triggered wakeups tend to be too short to
renegotiate a handshake.

Anyway, instead of the slow drip of "facts" and ≤three sentence emails,
can you just write up a paragraph that indicates this is safe to do (for
both (1) and (2)) in your v+1?

I don't really want to argue about it, because I don't have anything to
argue about. Your change is probably fine. I'd just like it to be
spelled out why this is safe to do from somebody who has looked into it.
I have not looked into it, but it sounds like you have or are in the
process of doing so. Just write down what you find, please.

Jason
