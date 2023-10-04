Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68587B8345
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Oct 2023 17:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243035AbjJDPNg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Oct 2023 11:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjJDPNg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Oct 2023 11:13:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E5DCE;
        Wed,  4 Oct 2023 08:13:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1261BC433C8;
        Wed,  4 Oct 2023 15:13:30 +0000 (UTC)
Date:   Wed, 4 Oct 2023 11:14:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        cleger@rivosinc.com, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231004111437.47c80c81@gandalf.local.home>
In-Reply-To: <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
        <20230925230829.341-3-beaub@linux.microsoft.com>
        <20231003205908.391d17f5@gandalf.local.home>
        <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
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

On Wed, 4 Oct 2023 09:10:52 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 10/3/23 18:59, Steven Rostedt wrote:
> > 
> > Note, this doesn't seem to apply to my tree so I only added the first
> > patch. I think this needs to go through Shuah's tree.
> > 
> > -- Steve
> > 
> >   
> 
> Yes. I sent a fix up for rc4 - I can pull these two patches into
> linux-kselftest next
> 
> Steve! Does that work for you?
> 

I applied the first patch to my tree, I think the second patch is fine to go
separately through your tree.

-- Steve
