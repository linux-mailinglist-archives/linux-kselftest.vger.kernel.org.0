Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D21481916
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 04:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhL3Dvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 22:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhL3Dvl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 22:51:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E4DC061574;
        Wed, 29 Dec 2021 19:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38C37B81A71;
        Thu, 30 Dec 2021 03:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1020C36AE7;
        Thu, 30 Dec 2021 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1640836298;
        bh=6iM3TbYQjPiJGvmGiMsr01LD0T/mxawhZBX2nGQf1VE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KQeEpUIB4mWIryweMs8qNcZQw55aoYzboRGBsojth6PBbhtKiJcs7DP/3PKEGzirx
         1xzkSIoMtu9WCJZB+W0nfBEyiO/oWcQJajiPzaFq5i4/l0RfcXcDZOArWAhIdZDmqo
         HitRcb5t2UG/R5pQ1QeN56kKXOfmW5m32S7B2+bA=
Date:   Wed, 29 Dec 2021 19:51:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Cai <ycaibb@gmail.com>
Cc:     <shuah@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Resource Leak] Missing closing files in
 testing/selftests/vm/mlock2
Message-Id: <20211229195135.959b3730c54652de497e932b@linux-foundation.org>
In-Reply-To: <C8980E43-5BED-45C6-B3F8-7BC3D58DF21A@gmail.com>
References: <C8980E43-5BED-45C6-B3F8-7BC3D58DF21A@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 30 Dec 2021 11:17:37 +0800 Ryan Cai <ycaibb@gmail.com> wrote:

> Dear Kernel maintainers,
>              =A01. In testing/selftests/vm/mlock2, the file opened at Lin=
e 39 may not closed when going to Line 65.
>               Location: https://github.com/torvalds/linux/blob/5bfc75d92e=
fd494db37f5c4c173d3639d4772966/tools/testing/selftests/vm/mlock2.h#L37-L49

That's what exit() does.  I don't think we really care unless the leak
is inside a loop.

That being said, it's untidy and is setting a poor example so I guess
we should fix it.

>               Can I send I a patch?

It would be better to just send the patch rather than preceding it
with "can I send a patch".  Everyone can send a patch and they are
encouraged to do so!

