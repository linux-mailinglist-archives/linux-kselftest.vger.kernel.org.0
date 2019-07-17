Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322656B8FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 11:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfGQJNG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jul 2019 05:13:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQJNG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jul 2019 05:13:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 09DDAAF8C;
        Wed, 17 Jul 2019 09:13:05 +0000 (UTC)
Date:   Wed, 17 Jul 2019 11:12:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Joe Lawrence <joe.lawrence@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2] selftests/livepatch: add test skip handling
In-Reply-To: <20190716133414.20196-1-joe.lawrence@redhat.com>
Message-ID: <alpine.LSU.2.21.1907171103470.4492@pobox.suse.cz>
References: <20190716133414.20196-1-joe.lawrence@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 16 Jul 2019, Joe Lawrence wrote:

> Add a skip() message function that stops the test, logs an explanation,
> and sets the "skip" return code (4).
> 
> Before loading a livepatch self-test kernel module, first verify that
> we've built and installed it by running a 'modprobe --dry-run'.  This
> should catch a few environment issues, including !CONFIG_LIVEPATCH and
> !CONFIG_TEST_LIVEPATCH.  In these cases, exit gracefully with the new
> skip() function.
> 
> Reported-by: Jiri Benc <jbenc@redhat.com>
> Suggested-by: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

Miroslav
