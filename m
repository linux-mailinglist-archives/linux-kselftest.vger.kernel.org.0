Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72DC7E7113
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbjKISEh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 13:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjKISEh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 13:04:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D73A92;
        Thu,  9 Nov 2023 10:04:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4BAC433C8;
        Thu,  9 Nov 2023 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699553074;
        bh=FsRp+VuhFA+PT8BubfLxYWcSBlXXJL7Zf1gOJsFXpyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vjKwMShxqHJemOTBw2zvKj6QI8qNTmJewu+Rgb2iAMpOELRtKtzK2kWorUpTrT2mu
         JNf3yf7fmSXh86FEBtnnbtuqJwX/eStLyQImU0iTNDfaP9WZLoNgCXOTIePNH7JjEI
         8lmPY8d7S7gRVKXeORKnMnBHjWm12OtKctHB17fI=
Date:   Thu, 9 Nov 2023 13:04:31 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: run-user improvements
Message-ID: <pfzkuw4o7752mb2ksowte2cbfa2ogd2bsucbget5nsk76edcin@tueappcjnih4>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
 <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
 <49861e61-72b6-4133-a72a-3dded276d4df@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49861e61-72b6-4133-a72a-3dded276d4df@t-8ch.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 09, 2023 at 06:44:44PM +0100, Thomas Weißschuh  wrote:
> > On Wed, Sep 15, 2077 at 02:13:51AM +0200, Thomas Weißschuh wrote:
> >         ^^^^^^^^^^^^
> >
> > I'm curious how this happened, especially since this was sent with b4.
> 
> My system time was messed up.
> I blame systemd-timesyncd.

Well, at least we know b4 is Y38K compliant. ;)

Thank you!

-K
