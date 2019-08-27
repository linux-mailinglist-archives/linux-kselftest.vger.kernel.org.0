Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B99F57C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2019 23:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfH0VqO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 17:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfH0VqO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 17:46:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B896206E0;
        Tue, 27 Aug 2019 21:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566942373;
        bh=tki3pfge5Pp8AufwUnQHdHUzx+DqU3jb8sqUx2BxjZU=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=evLRI2DAOjd4yQdU9EyASSDdxXR6qBh3AxV0bRvwPYIa0EKsNZebexWIJvC+sUN10
         /HeAgxhEf/DTnhB/OK/I+vvkukfE34VLXFKj6PxkHmNhE6t7kYCzEZE+M+jqOy4ow7
         hoZ5aV0F9y9eDJdQ5AcvcaBmQHJCav/7VnyVQd+g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190827174932.44177-1-brendanhiggins@google.com>
References: <20190827174932.44177-1-brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, frowand.list@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] kunit: fix failure to build without printk
To:     Brendan Higgins <brendanhiggins@google.com>, shuah@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 14:46:12 -0700
Message-Id: <20190827214613.9B896206E0@mail.kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Quoting Brendan Higgins (2019-08-27 10:49:32)
> Previously KUnit assumed that printk would always be present, which is
> not a valid assumption to make. Fix that by ifdefing out functions which
> directly depend on printk core functions similar to what dev_printk
> does.
>=20
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fab=
e016259df@kernel.org/T/#t
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---

Does kunit itself have any meaning if printk doesn't work? Why not just
depend on CONFIG_PRINTK for now?

