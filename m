Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A2724BDD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 20:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjFFSxh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 14:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbjFFSxe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 14:53:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A165B10FA;
        Tue,  6 Jun 2023 11:53:30 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id D34FB20BE490;
        Tue,  6 Jun 2023 11:53:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D34FB20BE490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686077610;
        bh=KyenbPXmihAvbpfjDuLbp/6mMOtj/AGfe8T4xRgkpoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+/n9Q1FTBT2G549Gke3wzZtakJkEehgn6BnaU13nD4PgzA+1GN/J4dxQHcXziVg4
         Va/vYbqSCCZOwmWBpRaF8M+8U2yAZMfAPELSMxvA6Cjc55DB/VVt3vj+t5q6Bx013W
         DaWNlCQ/7mLYKpJlCEuV+fsBuNl30FYAJs+v8H1I=
Date:   Tue, 6 Jun 2023 11:53:22 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kelulanainsley@gmail.com
Subject: Re: [PATCH v3 0/4] tracing/user_events: Add empty arguments events
Message-ID: <20230606185322.GA86@W11-BEAU-MD.localdomain>
References: <20230606062027.1008398-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606062027.1008398-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 06, 2023 at 02:20:23PM +0800, sunliming wrote:
> This series patches fix the incorrect trace record for empty arguments
> events and add correspondent selftests.
> 
> V3:
>   Improve modification descriptions to maintain consistent formatting
> 
> v2:
>   Change "i->count" to "i->count !=0 " to prevent compiler optimization
>   Add correspondent selftests
> 
> sunliming (4):
>   tracing/user_events: Fix the incorrect trace record for empty
>     arguments events
>   selftests/user_events: Add ftrace self-test for empty arguments events
>   selftests/user_events: Clear the events after perf self-test
>   selftests/user_events: Add perf self-test for empty arguments events
> 
>  kernel/trace/trace_events_user.c              |  4 +-
>  .../selftests/user_events/ftrace_test.c       | 33 ++++++++
>  .../testing/selftests/user_events/perf_test.c | 82 +++++++++++++++++++
>  3 files changed, 117 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1

Thank you, this series looks good to me.

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau
