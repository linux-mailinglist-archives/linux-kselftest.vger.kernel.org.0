Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69CD28034F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJAP5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Oct 2020 11:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbgJAP5B (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Oct 2020 11:57:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A48E20759;
        Thu,  1 Oct 2020 15:57:00 +0000 (UTC)
Date:   Thu, 1 Oct 2020 11:56:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: check for do_sys_openat2 in
 user-memory test
Message-ID: <20201001115658.164e28b9@gandalf.local.home>
In-Reply-To: <80cee321-d8ed-31fd-2f53-d9306b1d9545@canonical.com>
References: <20201001085641.51130-1-colin.king@canonical.com>
        <20201001104448.427a0eaa@gandalf.local.home>
        <80cee321-d8ed-31fd-2f53-d9306b1d9545@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 1 Oct 2020 16:40:33 +0100
Colin Ian King <colin.king@canonical.com> wrote:

> So this test breaks with a recent libc and support tools built against
> libc.  I believe the do_sys_open is not being detected because
> do_sys_openat2 is being called instead.
> 
> Not sure now of the correct way to fix this.

Perhaps by enabling both events?

-- Steve
