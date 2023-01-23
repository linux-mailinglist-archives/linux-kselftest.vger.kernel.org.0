Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91267835C
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjAWRfy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjAWRfc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:35:32 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4102F7A1;
        Mon, 23 Jan 2023 09:35:08 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id E42C082EE8;
        Mon, 23 Jan 2023 17:34:47 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674495290;
        bh=tOm1vusYzoWROF6CwPovquwo6GUZ4u7iZGBsY8EGoeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHwuJenfqQacbRNOAd+UiptXnhJL6wqWHtnm2iIHUvq7r8R3iYy/XSXRqOJz0JfbP
         PlbeLCQPs3o2ywKn2qgBb6iUij8KCQgDNq02fCXaaSVEelO3EVGjeAbzbE41n4Rop9
         PrW1QVvpHBg1RNDFfHzdfZ2dyVymTGaxWlTFkULj3EIrSPSOQRTMbgEwIRbRkwHvLM
         V/LIDbJ/+X8uuvaEgqPlL+6c8CkZrZKWE2jt4r0qS0vuUfwTi8H6b7C1DR87hwN3Jj
         fs7tpj4sYzsFuiDFqBX4wLJ/qoKUfMpHNpo72f8a8aYeMSTtqa9sI/gbbBQiXuPxmR
         m/k3lLi9yoW6Q==
Date:   Tue, 24 Jan 2023 00:34:43 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <Y87FM1yyZy6iOXcj@biznet-home.integral.gnuweeb.org>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 21, 2023 at 12:00:38PM -0800, Paul E. McKenney wrote:
> Nice, thank you!
> 
> I have these placed on top of the -rcu "dev" branch initially for further
> review and testing.  If things go well over the next week or so, I will
> set it up for the upcoming merge window.
> 
> One dependency is of course qemu-x86_64, so in the meantime I will figure
> out where I get that from.  ;-)

Thank you all, I'll base my work on top of the -rcu "dev" branch.

Tested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

-- 
Ammar Faizi

