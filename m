Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6857BA466
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Oct 2023 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbjJEQF0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Oct 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbjJEQEG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB69B54;
        Thu,  5 Oct 2023 08:07:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA98C433C8;
        Thu,  5 Oct 2023 15:07:08 +0000 (UTC)
Date:   Thu, 5 Oct 2023 11:08:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        cleger@rivosinc.com, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231005110816.4b68453d@gandalf.local.home>
In-Reply-To: <c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
        <20230925230829.341-3-beaub@linux.microsoft.com>
        <20231003205908.391d17f5@gandalf.local.home>
        <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
        <20231004111437.47c80c81@gandalf.local.home>
        <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
        <c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
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

On Thu, 5 Oct 2023 08:48:14 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Hmm. Which tree is this patch based on? This doesn't apply to
> linux-kselftest fixes - I thought this was based on top of fixes
> since I sent in a fix for Linux 6.6-rc4 for user_events
> 
> Beau, Please rebase to the correct tree/branch and send v2 for
> this patch.

Hmm, so this didn't apply to my tree nor yours.

Beau, can you verify which tree this goes to?

-- Steve
