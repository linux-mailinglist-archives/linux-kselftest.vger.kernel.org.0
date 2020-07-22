Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470EC22A0E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jul 2020 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgGVUtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 16:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVUtT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 16:49:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F4D7207BB;
        Wed, 22 Jul 2020 20:49:16 +0000 (UTC)
Date:   Wed, 22 Jul 2020 16:49:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Tal Gilboa <talgi@mellanox.com>, kunit-dev@googlegroups.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, live-patching@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kbuild: trace functions in subdirectories of
 lib/
Message-ID: <20200722164915.29be42d9@oasis.local.home>
In-Reply-To: <CAK7LNASdytWgqQWux1cyBrGJb_FvS7Ur5UqgHaA2Xf5cwfL85A@mail.gmail.com>
References: <20200707092117.963394-1-masahiroy@kernel.org>
        <20200707092117.963394-2-masahiroy@kernel.org>
        <20200707120212.7010fa4f@oasis.local.home>
        <CAK7LNASdytWgqQWux1cyBrGJb_FvS7Ur5UqgHaA2Xf5cwfL85A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 22 Jul 2020 11:08:51 +0900
Masahiro Yamada <masahiroy@kernel.org> wrote:

> That's why I split this into two commits
> so that we can do git-bisect and
> revert the second one in case of a regression.
> 
> Anyway, we have some more time to test this in linux-next
> (and somebody reports an issue, if any).
> 

You can add my

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

and take it through your tree.

-- Steve
