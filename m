Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B94793F09
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 16:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjIFOhE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjIFOhD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 10:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893E01736;
        Wed,  6 Sep 2023 07:36:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8C7C433C8;
        Wed,  6 Sep 2023 14:36:57 +0000 (UTC)
Date:   Wed, 6 Sep 2023 10:37:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     zhengyejian1@huawei.com, akaher@vmware.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        shuah@kernel.org, skhan@linuxfoundation.org, yeweihua4@huawei.com
Subject: Re: "[PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc"
Message-ID: <20230906103718.0405ccb4@gandalf.local.home>
In-Reply-To: <20230906142652.191866-1-naresh.kamboju@linaro.org>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
        <20230906142652.191866-1-naresh.kamboju@linaro.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed,  6 Sep 2023 19:56:52 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> [my two cents]
> 
> I do see similar kernel panic while running ftrace testing on today's
> Linux next-20230906 tag. This crash is from qemu-arm64.
> 
> Here I am providing steps to reproduced link and scripts by using tuxrun tool.
>   - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2V0OqxEZUXIPNqWhQnnsuFOGYxR/reproducer
>   

[..]

> Log details,
> -------------
> # ok 45 ftrace - test tracing error log support
> <47>[ 1373.662292] systemd-journald[90]: Sent WATCHDOG=1 notification.
> # ok 46 Test creation and deletion of trace instances while setting an event

It's definitely a race with the creation and deletion of instances.

I'm going to run it on my laptop VM and see if that reproduces it. My other
VM is on a pretty powerful machine, and perhaps that's keeping it from
hitting the race.

-- Steve


> <1>[ 1382.873224] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> <1>[ 1382.873223] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
> <1>[ 1382.873426] Mem abort info:
