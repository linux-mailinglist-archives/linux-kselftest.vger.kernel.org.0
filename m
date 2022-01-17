Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F649024B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jan 2022 08:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiAQHDF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jan 2022 02:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiAQHDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jan 2022 02:03:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92801C061574;
        Sun, 16 Jan 2022 23:03:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 322CD60F56;
        Mon, 17 Jan 2022 07:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B29C36AE3;
        Mon, 17 Jan 2022 07:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642402984;
        bh=EOuHMV8XxtW8D0CDysAeuHMIwRnmgp+AsOXZ2U2pwSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=st/fnT0XARZN3W7lvp3150yrMru/fIlbTOaAUhHY8Aw0/Y8axXpqR3IKS6ghT1Cj3
         nehffgdTfyt+KD4BWFwDkfA+YR0JDYm8Bfwq8du9R+L5iiFMUChzmxDIY70DQExueB
         tKlg0bSZ3GNE0w3JQz2wMCPxo9wJXYagWXtZ+nVuWzXUF1cAt0cqGDlZ5nt74k+CrY
         SKgedDV9uecOznJNZoqCt9MWe7+LAX7mC2YKmxi0qiFW7YHPXqOm/I7xaTHsvMb6/C
         jjm0BcrcvAO+e8MvaID2nXoA2v5rRzLAYvv3xsqtc9gBUg8aynAWFsr7QDNzJsGDzH
         H9dw/rEdzvtYw==
Date:   Mon, 17 Jan 2022 09:02:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tadeusz Struk <tstruk@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests: tpm: add async space test with
 noneexisting handle
Message-ID: <YeUUmaShH0/obt3A@iki.fi>
References: <20220116012627.2031-1-tstruk@gmail.com>
 <20220116012627.2031-2-tstruk@gmail.com>
 <YeQs7Fy5NaK6m6Ar@iki.fi>
 <YeR6Z9a4Z3Xz79Tp@iki.fi>
 <070044a5-5468-1095-334f-67cf98eb30b3@gmail.com>
 <YeTKG3qPxm2DJGCN@iki.fi>
 <ed1dc51a-8dfb-1179-3200-13669a25c845@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1dc51a-8dfb-1179-3200-13669a25c845@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 16, 2022 at 06:55:25PM -0800, Tadeusz Struk wrote:
> On 1/16/22 17:44, Jarkko Sakkinen wrote:
> > NP, Both are applied now.
> 
> Looking at
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/
> I can see only the 2/2 selftest applied.

It was my bad, forgot the update the remote master. Now it should be
good.

BR, Jarkko
