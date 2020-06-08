Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6D1F16A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jun 2020 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgFHK1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Jun 2020 06:27:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgFHK1F (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Jun 2020 06:27:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DADCDB181;
        Mon,  8 Jun 2020 10:27:07 +0000 (UTC)
Date:   Mon, 8 Jun 2020 12:27:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Yannick Cote <ycote@redhat.com>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/4] selftests/livepatch: simplify test-klp-callbacks
 busy target tests
Message-ID: <20200608102703.GA3728@linux-b0ei>
References: <20200603182058.109470-1-ycote@redhat.com>
 <20200603182058.109470-2-ycote@redhat.com>
 <alpine.LSU.2.21.2006051505230.23532@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2006051505230.23532@pobox.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2020-06-05 15:05:55, Miroslav Benes wrote:
> On Wed, 3 Jun 2020, Yannick Cote wrote:
> 
> > From: Joe Lawrence <joe.lawrence@redhat.com>
> > 
> > The test-klp-callbacks script includes a few tests which rely on kernel
> > task timings that may not always execute as expected under system load.
> > These may generate out of sequence kernel log messages that result in
> > test failure.
> > 
> > Instead of using sleep timing windows to orchestrate these tests, add a
> > block_transition module parameter to communicate the test purpose and
> > utilize flush_queue() to serialize the test module's task output.
> > 
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Acked-by: Miroslav Benes <mbenes@suse.cz>

JFYI, this patchset is committed in livepatching.git, branch
for-5.9/selftests-cleanup.

Best Regards,
Petr
