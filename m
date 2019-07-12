Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6FC674CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2019 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGLR6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Jul 2019 13:58:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfGLR6P (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Jul 2019 13:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 525413091D67;
        Fri, 12 Jul 2019 17:58:15 +0000 (UTC)
Received: from redhat.com (ovpn-122-246.rdu2.redhat.com [10.10.122.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E8660A9A;
        Fri, 12 Jul 2019 17:58:14 +0000 (UTC)
Date:   Fri, 12 Jul 2019 13:58:12 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     shuah <shuah@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH] selftests/livepatch: only consider supported arches
Message-ID: <20190712175812.GB15872@redhat.com>
References: <20190712171402.15930-1-joe.lawrence@redhat.com>
 <20190712172517.GA15872@redhat.com>
 <eec9376b-8c0d-8f09-59cb-e38839b13368@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eec9376b-8c0d-8f09-59cb-e38839b13368@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 12 Jul 2019 17:58:15 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 12, 2019 at 11:43:02AM -0600, shuah wrote:
> Hi Joe,
> 
> [ ... snip ... ]
> 
> The one thing I am not seeing is Skip handling. Without that users will
> complain livepatch test is failing as opposed to that the test can't
> run due to unmet dependencies and skipped.
> 
> Maybe that is all you need? I would recommend going in that direction
> instead of Arch check.
> 

Okay, I see that kselftest/runner.sh compares test return code with
skip_rc=4 to determine SKIP status... so perhaps our scripts could
perform a simple "modinfo" on their test modules to determine if they
have been built and installed?  If not found, just SKIP to the next
test.

Thanks, 

-- Joe
