Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B227E6EEE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 17:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjKIQev (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 11:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjKIQej (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 11:34:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032833A8C;
        Thu,  9 Nov 2023 08:34:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7874BC433C9;
        Thu,  9 Nov 2023 16:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699547662;
        bh=M50p1wmNfhBm5BF+PbqO/fZbycxYiFAFBggFmvofJC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmnpwJRFLNCHqj8pA5XEKCE2ErIcgdnTCnGua9skg2Rn+nnzVK1b0PGb3utaGldKM
         8qS70EMJ7fIVL7AeAG3KyuZnbIcEbvrHnLgV4JOsEXkj1dpAvLPra0d9pJvdE9dzo6
         EQMks+Ihx6cRC5UxdJWoisPh5+bPF79G9FET8Bqw=
Date:   Thu, 9 Nov 2023 11:34:21 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: run-user improvements
Message-ID: <i72zexrh7vooea266kofft7c7ree6eh7ey4fk4x4vrl346np6v@qp4gwemohxpq>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
 <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
 <ZU0Jbg6JT2Tn2n3M@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU0Jbg6JT2Tn2n3M@1wt.eu>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 09, 2023 at 05:31:42PM +0100, Willy Tarreau wrote:
> > I'm curious how this happened, especially since this was sent with b4.
> 
> We didn't want to tell you, but you slept 54 years Konstantin, the
> current kernel is version 41.8 ;-)

Dang, I see we still use email for kernel development 50 years from now!

-K
