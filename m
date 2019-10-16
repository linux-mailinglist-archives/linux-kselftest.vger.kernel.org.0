Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30C0D950F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfJPPIl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 11:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:50494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726244AbfJPPIk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 11:08:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9BB0B3C5;
        Wed, 16 Oct 2019 15:08:38 +0000 (UTC)
Date:   Wed, 16 Oct 2019 17:08:38 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     rostedt@goodmis.org, jikos@kernel.org, joe.lawrence@redhat.com,
        jpoimboe@redhat.com, mingo@redhat.com, shuah@kernel.org,
        kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 2/3] selftests/livepatch: Make dynamic debug setup and
 restore generic
Message-ID: <20191016150838.jd2bxb3yzyhap6m4@pathway.suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz>
 <20191016113316.13415-3-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016113316.13415-3-mbenes@suse.cz>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed 2019-10-16 13:33:14, Miroslav Benes wrote:
> From: Joe Lawrence <joe.lawrence@redhat.com>
> 
> Livepatch selftests currently save the current dynamic debug config and
> tweak it for the selftests. The config is restored at the end. Make the
> infrastructure generic, so that more variables can be saved and
> restored.
> 
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
