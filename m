Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7512278A972
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjH1J5P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjH1J4v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 05:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F1010C;
        Mon, 28 Aug 2023 02:56:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B156362B;
        Mon, 28 Aug 2023 09:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7562C433C7;
        Mon, 28 Aug 2023 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693216608;
        bh=n3ZveLCRiywPM51R3UgAxLkq2oP2wEOsDu10F1AptNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNLHP+peq8UXHf72xcyBxH4HegIk/sP6rv57/7Opan+gvE4Or3ydfBSwPLVxN0Zf8
         Rt0CCHHaW0aZsoHKtXJVIOsjzuZaTyRGXEiDYltL/WzfGxRPrQ7Hm149KkGX57uDDn
         +lkKhnNOL4TdS3hKKD4gg7Tq+9FpzZUpRAIR1c1M=
Date:   Mon, 28 Aug 2023 11:56:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15 1/2] torture: Avoid torture-test reboot loops
Message-ID: <2023082815-job-hull-9b54@gregkh>
References: <20230827215741.246948-1-joel@joelfernandes.org>
 <2023082812-pampers-uptown-69a2@gregkh>
 <CAEXW_YTP9mm2f5YEL=Dbr399KomN6jd8Rwx+N1MXOuefs-vzoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTP9mm2f5YEL=Dbr399KomN6jd8Rwx+N1MXOuefs-vzoA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 27, 2023 at 06:31:55PM -0400, Joel Fernandes wrote:
> On Sun, Aug 27, 2023 at 6:27 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Aug 27, 2023 at 09:57:39PM +0000, Joel Fernandes (Google) wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > >
> > > [ Upstream commit 10f84c2cfb5045e37d78cb5d4c8e8321e06ae18f ]
> >
> > I don't see this commit in Linus's tree, am I just missing it somewhere?
> >
> 
> Ah, this particular patch might not be in Linus's tree yet. It is in
> Paul's tree. Feel free to ignore it for now if you want and I'll
> resend it later (and likewise for the 5.10 one).

Yeah, please just send it later, once it has landed in a -rc release
otherwise there's nothing we can do with it now, sorry.

thanks,

greg k-h
