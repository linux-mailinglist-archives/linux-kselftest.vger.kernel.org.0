Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCE8D102DEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2019 22:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKSVG3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 16:06:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSVG3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 16:06:29 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B038F222DC;
        Tue, 19 Nov 2019 21:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574197588;
        bh=GLHxt4zej1ZH1/rgQvXs9upW/MCg07o6/Tg2ohtftT4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hRDySHNEDOoHo9A9OPN2qyQwtR3HBdbD1z7uxRW6u/S1Nd1d/09Zavv4N3DrJtQhB
         +f1K+WKVXHLtB/tg90bLkfgMW105tzYbQ3Jg7A4Vx4HeNkx/JSp+AEVQ/Vn8bkKQAr
         7WMpclCdeNXEPV+6FzryGxUw6wI/SDeCwf02xitM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573812972-10529-5-git-send-email-alan.maguire@oracle.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com> <1573812972-10529-5-git-send-email-alan.maguire@oracle.com>
Subject: Re: [PATCH v4 linux-kselftest-test 4/6] kunit: remove timeout dependence on sysctl_hung_task_timeout_seconds
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, yamada.masahiro@socionext.com,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, schowdary@nvidia.com,
        urezki@gmail.com, andriy.shevchenko@linux.intel.com,
        corbet@lwn.net, tytso@mit.edu, adilger.kernel@dilger.ca,
        mcgrof@kernel.org, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Knut Omang <knut.omang@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 13:06:28 -0800
Message-Id: <20191119210628.B038F222DC@mail.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Alan Maguire (2019-11-15 02:16:10)
> In discussion of how to handle timeouts, it was noted that if
> sysctl_hung_task_timeout_seconds is exceeded for a kunit test,
> the test task will be killed and an oops generated.  This should
> suffice as a means of debugging such timeout issues for now.
>=20
> Hence remove use of sysctl_hung_task_timeout_secs, which has the
> added benefit of avoiding the need to export that symbol from
> the core kernel.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

