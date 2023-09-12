Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD7679C379
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 04:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbjILC7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 22:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbjILC7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 22:59:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4A11E162;
        Mon, 11 Sep 2023 18:24:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B1AC116AE;
        Tue, 12 Sep 2023 01:24:37 +0000 (UTC)
Date:   Mon, 11 Sep 2023 21:24:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [FIX PATCH v2] selftests: tracing: Fix to unmount tracefs for
 recovering environment
Message-ID: <20230911212453.58b9082a@gandalf.local.home>
In-Reply-To: <169448103881.242465.4589561134225171701.stgit@devnote2>
References: <169448103881.242465.4589561134225171701.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 12 Sep 2023 10:10:39 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to unmount the tracefs if the ftracetest mounted it for recovering
> system environment. If the tracefs is already mounted, this does nothing.
> 
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/all/29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk/
> Fixes: cbd965bde74c ("ftrace/selftests: Return the skip code when tracing directory not configured in kernel")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>    - use -n option explictly for testing the string is non-zero.
> ---
>  tool

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
