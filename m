Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0011C957C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 17:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEGPwH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 11:52:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbgEGPwH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 11:52:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8681420659;
        Thu,  7 May 2020 15:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588866726;
        bh=mlvS0oh7kj4TmZBTpYgoFJD7r3X4hwbv2okMwAawp8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XkWD3pD6+MGrhYvmBVy2mHoVgjB6msb46prlZvstna19R2ybX869eo1ERqXuivXwd
         zE5Qj+x3t5lDsUi7VxW9JIQsbm5T2nQcOS8aExAUo2V4ChD04HuX0TPksr+uZBVexx
         7VKSFUhrDhoTldio0yZauOv2oKPki7TUI8bFsh2A=
Date:   Fri, 8 May 2020 00:52:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Li Philip <philip.li@intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Subject: Re: [PATCH 3/3] selftests/ftrace: Use /bin/echo instead of built-in
 echo
Message-Id: <20200508005202.fb39efc3fae84924878f36f4@kernel.org>
In-Reply-To: <87eerwkskr.fsf@igel.home>
References: <158834025077.28357.15141584656220094821.stgit@devnote2>
        <158834028054.28357.398159034694277189.stgit@devnote2>
        <87eerwkskr.fsf@igel.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 07 May 2020 11:22:28 +0200
Andreas Schwab <schwab@linux-m68k.org> wrote:

> On Mai 01 2020, Masami Hiramatsu wrote:
> 
> > Since the built-in echo has different behavior in POSIX shell
> > (dash) and bash, we forcibly use /bin/echo -E (not interpret
> > backslash escapes) by default.
> 
> How about using printf instead (at least where it matters)?

Hmm, I think replacing all echos with printf in the testcase might be
much harder than this...

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
