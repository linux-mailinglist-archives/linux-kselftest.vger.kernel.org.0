Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A576200492
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 11:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgFSJGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 05:06:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbgFSJGp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 05:06:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BD493AF84;
        Fri, 19 Jun 2020 09:06:42 +0000 (UTC)
Date:   Fri, 19 Jun 2020 11:06:42 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Yannick Cote <ycote@redhat.com>
Subject: Re: [PATCH v3 0/3] selftests/livepatch: small script cleanups
Message-ID: <20200619090641.GI3617@alley>
References: <20200618181040.21132-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618181040.21132-1-joe.lawrence@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-06-18 14:10:37, Joe Lawrence wrote:
> Hi Petr,
> 
> Given the realization about kernel log timestamps and partial log
> comparison with v2, I respun a final version dropping the dmesg --notime
> patch, fixed any rebase conflicts, and added a comment per your
> suggestion.
> 
> I copied all the ack and review tags from v2 since the patchset is
> unchanged otherwise.  Hopefully this v3 minimizes any maintainer
> fiddling on your end.

Ah, I just waited a bit for eventual reaction and was going to push
the rebased version today.

Anyway, you made it easier from me. Also it is great the you
added the comment.

This patchset is commited in livepatching.git,
branch for-5.9/selftests-cleanup now.

Best Reagrds,
Petr
