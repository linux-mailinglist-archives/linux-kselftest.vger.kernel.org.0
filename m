Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1A73E53A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFZQgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 12:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFZQgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 12:36:31 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16EF9C5;
        Mon, 26 Jun 2023 09:36:29 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 54DD421C4265;
        Mon, 26 Jun 2023 09:36:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54DD421C4265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687797388;
        bh=icVczakG28FAD0REpW+p4noUrRkMyVkU1sHsJFRQldE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAERRU2/qbqd3eHtrtZJ0S0w6V90DN8uf/0mTpwZhAM1rc1vNjIuqOS3hVg8rKras
         wcDJ7QZaiDPtjfSROw9N6sFdwx/q9av2RtWPyboqReloy+5M6b+EMbOGUiFHMwJ63i
         qhIClxJFwEwlNwpI6ZVspi6OJO0SdCq/XIR7J7/s=
Date:   Mon, 26 Jun 2023 09:36:21 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/3] tracing/user_events: Fix incorrect return value
 for writes when events are disabled and add its tests
Message-ID: <20230626163621.GA104@W11-BEAU-MD.localdomain>
References: <20230626111344.19136-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626111344.19136-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 26, 2023 at 07:13:41PM +0800, sunliming wrote:
> Now the writing operation return the count of writes regardless of whether
> events are enabled or disabled. Fix this by just return -EBADF when events
> are disabled.
> 
> v3 -> v4:
> - Change the return value from zero to -EBADF
> 

Applied these locally, ran a few tests. This looks good to me.

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau

> v2 -> v3:
> - Change the return value from -ENOENT to zero
> 
> v1 -> v2:
> - Change the return value from -EFAULT to -ENOENT
> 
> sunliming (3):
>   tracing/user_events: Fix incorrect return value for writing operation
>     when events are disabled
>   selftests/user_events: Enable the event before write_fault test in
>     ftrace self-test
>   selftests/user_events: Add test cases when event is disabled
> 
>  kernel/trace/trace_events_user.c                  | 3 ++-
>  tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> -- 
> 2.25.1
