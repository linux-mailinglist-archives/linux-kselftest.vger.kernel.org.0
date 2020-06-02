Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021761EC5E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 01:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFBXvS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 19:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFBXvS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 19:51:18 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E987E2054F;
        Tue,  2 Jun 2020 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591141877;
        bh=3vjqIi9Xm2nN/Fplf6rLRIeLwjNNvcIEKMZ7aNSrABo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BNMXwY5NHwZe5KOee4mT/NVlnrsS4g256c8dJpAkWk0CcUM8R85PGDJI6O/cqPSRt
         ljlzF0x3cIkERUDgweVIuPuz7x8NH7d3GzO0qWskhnex7KOZbPLyFQX2Ek+IH9fCV3
         Zbg6uhzmitlubpzoTZDOpF8ajWc+wW6EiEcSHUyE=
Date:   Wed, 3 Jun 2020 08:51:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v2 3/7] selftests/ftrace: Add "requires:" list support
Message-Id: <20200603085113.67d6cdd16acdece4f167cab4@kernel.org>
In-Reply-To: <20200602092145.06afaf72@gandalf.local.home>
References: <159108888259.42416.547252366885528860.stgit@devnote2>
        <159108891139.42416.16735397217311780715.stgit@devnote2>
        <20200602092145.06afaf72@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2 Jun 2020 09:21:45 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  2 Jun 2020 18:08:31 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > +++ b/tools/testing/selftests/ftrace/test.d/template
> > @@ -1,6 +1,7 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0
> >  # description: %HERE DESCRIBE WHAT THIS DOES%
> > +# requires: %HERE LIST UP REQUIRED FILES%
> 
> Not sure what you mean by "LIST UP". Perhaps you mean "LIST OF"?

Ah, perhups we don't need UP. "list the required files" will be OK?

Thank you,

> 
> -- Steve
> 
> 
> >  # you have to add ".tc" extention for your testcase file
> >  # Note that all tests are run with "errexit" option.


-- 
Masami Hiramatsu <mhiramat@kernel.org>
