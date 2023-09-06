Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62129793B31
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Sep 2023 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjIFL2h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Sep 2023 07:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239729AbjIFL2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Sep 2023 07:28:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD97198E;
        Wed,  6 Sep 2023 04:28:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F92C433C9;
        Wed,  6 Sep 2023 11:27:39 +0000 (UTC)
Date:   Wed, 6 Sep 2023 07:27:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ye Weihua <yeweihua4@huawei.com>
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Message-ID: <20230906072759.4e8bee1c@gandalf.local.home>
In-Reply-To: <9cad73cd-1f8b-2f3f-cda4-99b89a87b931@huawei.com>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
        <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
        <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
        <20230710183741.78f04c68@gandalf.local.home>
        <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
        <20230905183638.2b539fae@gandalf.local.home>
        <9cad73cd-1f8b-2f3f-cda4-99b89a87b931@huawei.com>
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

On Wed, 6 Sep 2023 09:42:44 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> Hi, Steve, your new patch seems not fixes the KASAN issue.
> 
> I run the instance-event.tc with your patch again and get same KASAN 
> report.
> 
> My config is in:
>  
> https://lore.kernel.org/all/da5495b5-cdb5-cb82-dd9b-37e7a87ed97d@huawei.com/

I'm not able to reproduce it.

Can you send me the full dmesg.

Thanks,

-- Steve
