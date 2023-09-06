Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF098794528
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 23:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjIFVg7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 17:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjIFVg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 17:36:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB8BE7C;
        Wed,  6 Sep 2023 14:36:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B28C433C7;
        Wed,  6 Sep 2023 21:36:53 +0000 (UTC)
Date:   Wed, 6 Sep 2023 17:37:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     zhengyejian1@huawei.com, akaher@vmware.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        shuah@kernel.org, skhan@linuxfoundation.org, yeweihua4@huawei.com
Subject: Re: "[PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc"
Message-ID: <20230906173706.7aeb8716@gandalf.local.home>
In-Reply-To: <20230906103718.0405ccb4@gandalf.local.home>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
        <20230906142652.191866-1-naresh.kamboju@linaro.org>
        <20230906103718.0405ccb4@gandalf.local.home>
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

On Wed, 6 Sep 2023 10:37:18 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Log details,
> > -------------
> > # ok 45 ftrace - test tracing error log support
> > <47>[ 1373.662292] systemd-journald[90]: Sent WATCHDOG=1 notification.
> > # ok 46 Test creation and deletion of trace instances while setting an event  
> 
> It's definitely a race with the creation and deletion of instances.
> 
> I'm going to run it on my laptop VM and see if that reproduces it. My other
> VM is on a pretty powerful machine, and perhaps that's keeping it from
> hitting the race.

Putting in a while loop of:

  # while :; do ./ftracetest test.d/instances/instance-event.tc ; done

eventually triggered the bug. Looks like this is really an existing bug not
related to the eventfs, but the eventfs code actually opened up the window
of this race.

Hopefully I'll have a fix shortly.

-- Steve
