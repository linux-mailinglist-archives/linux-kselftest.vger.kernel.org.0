Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C011EF871
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jun 2020 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgFEM6e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Jun 2020 08:58:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:58142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgFEM6e (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Jun 2020 08:58:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 23DA2AB8F;
        Fri,  5 Jun 2020 12:58:36 +0000 (UTC)
Date:   Fri, 5 Jun 2020 14:58:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yannick Cote <ycote@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com, linux-kernel@vger.kernel.org,
        mbenes@suse.cz, kamalesh@linux.vnet.ibm.com
Subject: Re: [PATCH v2 1/4] selftests/livepatch: simplify test-klp-callbacks
 busy target tests
Message-ID: <20200605125832.GA5099@linux-b0ei>
References: <20200603182058.109470-1-ycote@redhat.com>
 <20200603182058.109470-2-ycote@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603182058.109470-2-ycote@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2020-06-03 14:20:55, Yannick Cote wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> The test-klp-callbacks script includes a few tests which rely on kernel
> task timings that may not always execute as expected under system load.
> These may generate out of sequence kernel log messages that result in
> test failure.
> 
> Instead of using sleep timing windows to orchestrate these tests, add a
> block_transition module parameter to communicate the test purpose and
> utilize flush_queue() to serialize the test module's task output.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>

I am not sure if I deserve this. I suggested only few implementation details.

> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Looks good now:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
