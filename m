Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73ECF7E70A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 18:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbjKIRpB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 12:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344788AbjKIRpA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 12:45:00 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7071268D;
        Thu,  9 Nov 2023 09:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699551895; bh=G4BQPo4OLerjxGzK1/suIJzFmddkLLxY0cdc5cZUl9o=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=H8Zr0bzPBS3n3HZJfU5CVY/BU4lI2V+s4ZVOg/Fj+pKg5lyqaphldGTpsjdeEASBy
         J69Hf0jZKH0GfA9GUsZ08r0wHJa+BZBC3El4nIKSTtomWKcgFSdK62NzuVR0Q69aWB
         DRlsjOCLncd0aEZLdJgGdn0WkrWwUfIyL29OUIa4=
Date:   Thu, 9 Nov 2023 18:44:44 +0100 (GMT+01:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <49861e61-72b6-4133-a72a-3dded276d4df@t-8ch.de>
In-Reply-To: <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net> <zvzacp6mqu6xhg4dx56kh67ucl6wmtnydm677tull2bx74i2zz@ebj4juspkjfw>
Subject: Re: [PATCH 0/2] selftests/nolibc: run-user improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <49861e61-72b6-4133-a72a-3dded276d4df@t-8ch.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nov 9, 2023 17:28:45 Konstantin Ryabitsev <konstantin@linuxfoundation.org>:

> On Wed, Sep 15, 2077 at 02:13:51AM +0200, Thomas Wei=C3=9Fschuh wrote:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^
>
> I'm curious how this happened, especially since this was sent with b4.

My system time was messed up.
I blame systemd-timesyncd.

