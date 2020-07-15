Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F7E2205BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jul 2020 09:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGOHDh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jul 2020 03:03:37 -0400
Received: from [195.135.220.15] ([195.135.220.15]:60618 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgGOHDh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jul 2020 03:03:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B84BDAD1A;
        Wed, 15 Jul 2020 07:03:38 +0000 (UTC)
Date:   Wed, 15 Jul 2020 09:03:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: adopt to newer sysctl error
 format
Message-ID: <20200715070335.GT4751@alley>
References: <20200714091030.1611-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714091030.1611-1-pmladek@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2020-07-14 11:10:30, Petr Mladek wrote:
> With procfs v3.3.16, the sysctl command doesn't print the set key and
> value on error.  This change breaks livepatch selftest test-ftrace.sh,
> that tests the interaction of sysctl ftrace_enabled:
> 
> Make it work with all sysctl versions using '-q' option.
> 
> Explicitly print the final status on success so that it can be verified
> in the log. The error message is enough on failure.
> 
> Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

The patch is commited in livepatch.git,
branch for-5.9/selftests-cleanup.

Best Regards,
Petr
