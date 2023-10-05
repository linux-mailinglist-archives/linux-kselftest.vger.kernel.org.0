Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D204D7BA85D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJERq3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJERpR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 13:45:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABF710F;
        Thu,  5 Oct 2023 10:44:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D7EC433C8;
        Thu,  5 Oct 2023 17:44:51 +0000 (UTC)
Date:   Thu, 5 Oct 2023 13:46:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        cleger@rivosinc.com, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231005134600.0b309226@gandalf.local.home>
In-Reply-To: <20231005165230.GA1247-beaub@linux.microsoft.com>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
        <20230925230829.341-3-beaub@linux.microsoft.com>
        <20231003205908.391d17f5@gandalf.local.home>
        <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
        <20231004111437.47c80c81@gandalf.local.home>
        <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
        <c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
        <20231005110816.4b68453d@gandalf.local.home>
        <20231005165230.GA1247-beaub@linux.microsoft.com>
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

On Thu, 5 Oct 2023 09:52:30 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:


> It was based on tracing/for-next.
> 
> I'll get a v2 out rebased upon linux-kselftest, does that work?

Hmm, then it should have applied to my tree. I didn't look too deep.

Can you see if it applies to:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git

    trace/for-next ?

Thanks,

-- Steve
