Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908DF1B3066
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Apr 2020 21:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDUTdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Apr 2020 15:33:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:58212 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDUTdO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Apr 2020 15:33:14 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 41D82823;
        Tue, 21 Apr 2020 19:33:14 +0000 (UTC)
Date:   Tue, 21 Apr 2020 13:33:13 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     brendanhiggins@google.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5] Documentation: test.h - fix warnings
Message-ID: <20200421133313.5f41fcf4@lwn.net>
In-Reply-To: <20200415201653.106-1-l.rubusch@gmail.com>
References: <20200415201653.106-1-l.rubusch@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Apr 2020 20:16:53 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Fix warnings at 'make htmldocs', and formatting issues in the resulting
> documentation.
> 
> - test.h: Fix annotation in kernel-doc parameter description.
> 
> - Documentation/*.rst: Fixing formatting issues, and a duplicate label
>   issue due to usage of sphinx.ext.autosectionlabel and identical labels
>   within one document (sphinx warning)
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
> v2: Several documentation fixes
> 
> v3: Do not touch API documentation index
> 
> v4: Replace macro argument in test.h by named variadic argument
> 
> v5: Patch format fixed
> 
> NB: checkpatch.pl will complain about flow control statements (i.e. usage
>     of "return") within the macro kunit_test_suites(suites_list...).
> 
> Better? I feel I'm making you a lot of extra work. I'm really sorry for
> all this fuzz!

So I'm assuming this will go via Shuah's tree; let me know if that's
incorrect.

Thanks,

jon
