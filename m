Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB86ED9F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 03:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjDYBnB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Apr 2023 21:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjDYBmx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Apr 2023 21:42:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F0CAF21;
        Mon, 24 Apr 2023 18:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D54262AD5;
        Tue, 25 Apr 2023 01:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52618C433D2;
        Tue, 25 Apr 2023 01:42:48 +0000 (UTC)
Date:   Mon, 24 Apr 2023 21:42:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RESEND] selftests/ftrace: Improve integration with
 kselftest runner
Message-ID: <20230424214246.3e158fb6@rorschach.local.home>
In-Reply-To: <20230302-ftrace-kselftest-ktap-v1-1-1270085b4cd5@kernel.org>
References: <20230302-ftrace-kselftest-ktap-v1-1-1270085b4cd5@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 11 Apr 2023 12:19:30 +0100
Mark Brown <broonie@kernel.org> wrote:

> The ftrace selftests do not currently produce KTAP output, they produce a
> custom format much nicer for human consumption. This means that when run in
> automated test systems we just get a single result for the suite as a whole
> rather than recording results for individual test cases, making it harder
> to look at the test data and masking things like inappropriate skips.
> 
> Address this by adding support for KTAP output to the ftracetest script and
> providing a trivial wrapper which will be invoked by the kselftest runner
> to generate output in this format by default, users using ftracetest
> directly will continue to get the existing output.
> 
> This is not the most elegant solution but it is simple and effective. I
> did consider implementing this by post processing the existing output
> format but that felt more complex and likely to result in all output being
> lost if something goes seriously wrong during the run which would not be
> helpful. I did also consider just writing a separate runner script but
> there's enough going on with things like the signal handling for that to
> seem like it would be duplicating too much.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Shuah, care to take this?

-- Steve
