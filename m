Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9268A796EA2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Sep 2023 03:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjIGBoB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 21:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjIGBoB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 21:44:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC1A13E;
        Wed,  6 Sep 2023 18:43:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D47C433C7;
        Thu,  7 Sep 2023 01:43:55 +0000 (UTC)
Date:   Wed, 6 Sep 2023 21:44:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, <akaher@vmware.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <shuah@kernel.org>, <skhan@linuxfoundation.org>,
        <yeweihua4@huawei.com>
Subject: Re: "[PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc"
Message-ID: <20230906214406.06233b55@gandalf.local.home>
In-Reply-To: <6b0fc12d-e6c5-4a05-a6e6-46e5e5c9ae7b@huawei.com>
References: <b62e6539-7b25-c8ab-6b6c-47e723023297@huawei.com>
        <20230906142652.191866-1-naresh.kamboju@linaro.org>
        <20230906145000.29291a1b@gandalf.local.home>
        <20230906184650.074dfdcf@gandalf.local.home>
        <6b0fc12d-e6c5-4a05-a6e6-46e5e5c9ae7b@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 7 Sep 2023 09:39:56 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Hi, Steve
> 
> Only apply this new patch, the kasan issue seems gone.

I believe the other patch is required too, as the KASAN I hit pointed
directly at that.

-- Steve
