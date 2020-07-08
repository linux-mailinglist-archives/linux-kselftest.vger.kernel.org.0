Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E8B218377
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jul 2020 11:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGHJX2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Jul 2020 05:23:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:45972 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGHJX1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Jul 2020 05:23:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22963B118;
        Wed,  8 Jul 2020 09:23:26 +0000 (UTC)
Date:   Wed, 8 Jul 2020 11:23:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Tal Gilboa <talgi@mellanox.com>, kunit-dev@googlegroups.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kbuild: trace functions in subdirectories of lib/
Message-ID: <20200708092324.GA4751@alley>
References: <20200707092117.963394-1-masahiroy@kernel.org>
 <20200707092117.963394-2-masahiroy@kernel.org>
 <20200708065223.GA11164@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708065223.GA11164@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2020-07-08 08:52:23, Petr Mladek wrote:
>
> PS: BTW: The livepatch selftests fail in Linus's master now. But it
> seems to be for another reason. I am going to dig into it.

JFYI, the livepatch selftests are actually working. I have messed
the testing here. I am sorry for the noise.

Best Regards,
Petr
