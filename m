Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A41A9616
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 10:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635797AbgDOITK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 04:19:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:54840 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635665AbgDOITH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 04:19:07 -0400
IronPort-SDR: AtVmOkZ5iXQkulkiLuQaNN09IgcEwdxYvhHiOGnEC9xsMiW9nq5POlz1HNutXIQnFpMndVp6s1
 1PN6aDCjAtew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:19:03 -0700
IronPort-SDR: 2HJ65msdaHbVcW7xthFam/nHvITp0InhlO/LPzyA+dy5DfmBfX6e7VfeLJrA35jpx1qr/iMXgP
 fnKryLT8SEyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="363610060"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Apr 2020 01:18:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 15 Apr 2020 11:18:58 +0300
Date:   Wed, 15 Apr 2020 11:18:58 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
        sakari.ailus@linux.intel.com, andy.shevchenko@gmail.com,
        hdegoede@redhat.com, rafael.j.wysocki@intel.com,
        linux-kselftest@vger.kernel.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        shuah@kernel.org, anders.roxell@linaro.org,
        lkft-triage@lists.linaro.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH v1] kobject: make sure parent is not released before
 children
Message-ID: <20200415081858.GL2828150@kuha.fi.intel.com>
References: <20200414204240.186377-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414204240.186377-1-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 01:42:40PM -0700, Brendan Higgins wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This patch isn't from me. You can use a tag like "Proposed-by:
Heikki..." or "Co-developed-by: Heikki..." in cases like this.

> Previously, kobjects were released before the associated kobj_types;
> this can cause a kobject deallocation to fail when the kobject has
> children; an example of this is in software_node_unregister_nodes(); it
> calls release on the parent before children meaning that children can be
> released after the parent, which may be needed for removal.

That makes it sound like it's software_node_unregister_nodes() that is
releasing the parent, which isn't the case.

> So, take a reference to the parent before we delete a node to ensure
> that the parent is not released before the children.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Link: https://lore.kernel.org/linux-kselftest/CAFd5g44s5NQvT8TG_x4rwbqoa7zWzkV0TX+ETZoQdOB7OwXCPQ@mail.gmail.com/T/#m71f37f3985f2abd7209c8ca8e0fa4edc45e171d6
> Co-developed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> 
> This patch is based on the diff written by Heikki linked above.
> 
> Heikki, can you either reply with a Signed-off-by?

No, I can't sign a patch that didn't actually pass trough my hands:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

So in this case this patch is coming from _you_, not me, and there
can't also be a "Signed-off-by: Heikki..." tag.

You can use another tag to tell everybody that the change was
originally proposed by me (I guess it's "Co-developed-by:
Heikki..."?). Or just explain it in the commit message.


thanks,

-- 
heikki
