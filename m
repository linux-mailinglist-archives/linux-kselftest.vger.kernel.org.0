Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECF7E6EAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjKIQ2q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 11:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjKIQ2p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 11:28:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7E43272;
        Thu,  9 Nov 2023 08:28:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE14CC433C7;
        Thu,  9 Nov 2023 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699547323;
        bh=2ej6mGjDMSJGUXL9s2KwN9tBdFx+2Nd1K6+qxrnI9Mc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g91OtSYsJcOUUWvtpL34juNc8Bu+FSPxzgJWNafES+x3QbZ4q7ovXFegtVHV2hC41
         MhfVCpo28098R8NPo+9aQa5aIMGWvl3SDsA1VC64lmubQXV1YZxnXRo+orGUZ2N2Q7
         HSttEhOEuk3wbkC5HG2QhfeKMbpRHI96Wp+8t/iQ=
Date:   Thu, 9 Nov 2023 11:28:41 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: run-user improvements
Message-ID: <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 15, 2077 at 02:13:51AM +0200, Thomas Weißschuh wrote:
        ^^^^^^^^^^^^

I'm curious how this happened, especially since this was sent with b4.

-K
