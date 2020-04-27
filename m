Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718FF1BADD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Apr 2020 21:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgD0TYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Apr 2020 15:24:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726023AbgD0TYS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Apr 2020 15:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588015457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X+c2BXWc/diAQluG3KYrA6jLj0svlh/di0gVx6xf4/0=;
        b=PhbN6Oj6yhRC37jdOlJJnW30xsbOX37l6R0TFt84mqd9HeTIKkklq6VjUkeqlyUBsWzQ62
        cdj639gKPZB8KTIKES5N0rn8abZYe84JX7IQ2exUbSz/zLTJtLpAvrI8aFvjSNKWnxy5vY
        7YwQggeZ0XDHqlfi5EByrWf8eHpYgig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-YWwO-EaLO2Sc8PzwcLMkDg-1; Mon, 27 Apr 2020 15:24:13 -0400
X-MC-Unique: YWwO-EaLO2Sc8PzwcLMkDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62AE6100A68D;
        Mon, 27 Apr 2020 19:24:12 +0000 (UTC)
Received: from localhost (unknown [10.36.110.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E67BF5C1B2;
        Mon, 27 Apr 2020 19:24:10 +0000 (UTC)
Date:   Mon, 27 Apr 2020 21:24:05 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: introduce gen_tar Makefile target
Message-ID: <20200427212405.2747394d@redhat.com>
In-Reply-To: <20200427192141.2926018-1-vkabatov@redhat.com>
References: <20200427192141.2926018-1-vkabatov@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 27 Apr 2020 21:21:41 +0200
Veronika Kabatova <vkabatov@redhat.com> wrote:

> The gen_kselftest_tar.sh always packages *all* selftests and doesn't
> pass along any variables to `make install` to influence what should be
> built. This can result in an early error on the command line ("Unknown
> tarball format TARGETS=XXX"), or unexpected test failures as the
> tarball contains tests people wanted to skip on purpose.
> 
> Since the makefile already contains all the logic, we can add a target
> for packaging. Keep the default .gz target the script uses, and actually
> extend the supported formats by using tar's autodetection.
> 
> To not break current workflows, keep the gen_kselftest_tar.sh script as
> it is, with an added suggestion to use the makefile target instead.
> 
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

