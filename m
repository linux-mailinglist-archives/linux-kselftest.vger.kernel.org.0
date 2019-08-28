Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED3A0101
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfH1Luw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 07:50:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfH1Luv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 07:50:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C28BAF77;
        Wed, 28 Aug 2019 11:50:50 +0000 (UTC)
Date:   Wed, 28 Aug 2019 13:50:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        frowand.list@gmail.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, kunit-dev@googlegroups.com,
        Randy Dunlap <rdunlap@infradead.org>, sboyd@kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] kunit: fix failure to build without printk
Message-ID: <20190828115048.b4per6j3rw53oc5u@pathway.suse.cz>
References: <20190828093143.163302-1-brendanhiggins@google.com>
 <20190828094929.GA14038@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828094929.GA14038@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2019-08-28 18:49:29, Sergey Senozhatsky wrote:
> On (08/28/19 02:31), Brendan Higgins wrote:
> [..]
> > Previously KUnit assumed that printk would always be present, which is
> > not a valid assumption to make. Fix that by removing call to
> > vprintk_emit, and calling printk directly.
> > 
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Link: https://lore.kernel.org/linux-kselftest/0352fae9-564f-4a97-715a-fabe016259df@kernel.org/T/#t
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> 
> [..]
> 
> > -static void kunit_vprintk(const struct kunit *test,
> > -			  const char *level,
> > -			  struct va_format *vaf)
> > -{
> > -	kunit_printk_emit(level[1] - '0', "\t# %s: %pV", test->name, vaf);
> > -}
> 
> This patch looks good to me. I like the removal of recursive
> vsprintf() (%pV).

Same here. And I am happy that we did not add more external
vprintk_emit() callers. It would be great to rework dev_printk()
as well.

Best Regards,
Petr
