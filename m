Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB66E477
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2019 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfGSKq1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jul 2019 06:46:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:47440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbfGSKq1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jul 2019 06:46:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F381AFF0;
        Fri, 19 Jul 2019 10:46:26 +0000 (UTC)
Date:   Fri, 19 Jul 2019 12:46:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: push and pop dynamic debug config
Message-ID: <20190719104625.5aigkzsm5wh3d5kn@pathway.suse.cz>
References: <20190718202948.3404-1-joe.lawrence@redhat.com>
 <e5027867-88db-fa45-6767-286f3b7b86ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5027867-88db-fa45-6767-286f3b7b86ad@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2019-07-18 16:42:25, Joe Lawrence wrote:
> On 7/18/19 4:29 PM, Joe Lawrence wrote:
> > The livepatching self-tests tweak the dynamic debug config to verify
> > the kernel log during the tests.  Enhance set_dynamic_debug() so that
> > the config changes are restored when the script exits.
> > 
> > diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> > index de5a504ffdbc..860f27665ebd 100644
> > --- a/tools/testing/selftests/livepatch/functions.sh
> > +++ b/tools/testing/selftests/livepatch/functions.sh
> > @@ -29,13 +29,27 @@ function die() {
> >   	exit 1
> >   }
> > -# set_dynamic_debug() - setup kernel dynamic debug
> > -#	TODO - push and pop this config?
> > +function push_dynamic_debug() {
> > +        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
> > +                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
> > +}
> 
> It works for me, though I feel that the
> /sys/kernel/debug/dynamic_debug/control output to input translation is
> brittle.  It would be nice to have some kind of mass export/import
> capability for that interface.

I believe that the format is pretty stable. We could always reconsider
it when it breaks.

I could confirm that it restores the original state, so:

Tested-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
