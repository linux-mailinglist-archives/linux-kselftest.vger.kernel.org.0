Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBC6EE3F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 16:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjDYOck (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 10:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDYOcj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 10:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A22D4EC0;
        Tue, 25 Apr 2023 07:32:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B1262E53;
        Tue, 25 Apr 2023 14:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACECEC4339B;
        Tue, 25 Apr 2023 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682433157;
        bh=7RpIH8pPGjDhRtE9/Kdc51ixqRzPM/NZxvw0ejyXGV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WS1zZ3CS2VXAufJewBP0pT3wmeUdW+sboDNdHxucQDaMg+JS0MOGO0iXkjlHVlkcl
         4tSTKKdsKZPLywKPG/tSx+bna6F2HO4rE+LwNrE4dFqrXC/Dnxj2icYa4Qw2wl1f46
         q3xCGYjCg9RhCF4aKhb6kQ/tnNwFd6Jjhb4aN7Zoj2eqMmCfxVQZZYM2TrAlCMsK+l
         +3qRdkCkY3wxnpTqBb9b3g7HLpWZSt5qLRDzUor8wcq4xUqHaHZv9ryiG/Hd2zBhSb
         vcUOUY809sMdwYeBAN6oHSO4DM75SaL6ebdOmcZrjwUEmxs19ipcre9kJCZccvuqKO
         u3XFkrgTgeRDg==
Date:   Tue, 25 Apr 2023 23:32:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     rostedt@goodmis.org, corbet@lwn.net, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH tracing 0/3] tracing: support > 8 byte filter predicates
Message-Id: <20230425233233.2ad5168c630b4c1349ab3398@kernel.org>
In-Reply-To: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 25 Apr 2023 10:16:34 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> For cases like IPv6 addresses, having a means to supply tracing
> predicates for fields with more than 8 bytes would be convenient.
> This series provides a simple way to support this by allowing
> simple ==, != memory comparison with the predicate supplied when
> the size of the field exceeds 8 bytes.  For example, to trace
> ::1, the predicate
> 
> 	"dst == 0x00000000000000000000000000000001"
> 
> ..could be used.

Nice!
And I also would like to use something like "dst == ipv6(::1)" because
it seems easy to make a mistake on the number of zeros.

Can we add such type casting feature to the filter?

Thank you,

> 
> Patch 1 provides the support for > 8 byte fields via a memcmp()-style
> predicate. Patch 2 adds tests for filter predicates, and patch 3
> documents the fact that for > 8 bytes. only == and != are supported.
> 
> Changes since RFC [1]:
> 
> - originally a fix was intermixed with the new functionality as
>   patch 1 in series [1]; the fix landed separately
> - small tweaks to how filter predicates are defined via fn_num as
>   opposed to via fn directly
> 
> [1] https://lore.kernel.org/lkml/1659910883-18223-1-git-send-email-alan.maguire@oracle.com/
> 
> Alan Maguire (3):
>   tracing: support > 8 byte array filter predicates
>   selftests/ftrace: add test coverage for filter predicates
>   tracing: document > 8 byte numeric filtering support
> 
>  Documentation/trace/events.rst                |  9 +++
>  kernel/trace/trace_events_filter.c            | 55 +++++++++++++++-
>  .../selftests/ftrace/test.d/event/filter.tc   | 62 +++++++++++++++++++
>  3 files changed, 125 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/event/filter.tc
> 
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
