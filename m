Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E0F6EF608
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbjDZOMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZOMV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 10:12:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E46A52;
        Wed, 26 Apr 2023 07:12:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33F2063672;
        Wed, 26 Apr 2023 14:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A7C433D2;
        Wed, 26 Apr 2023 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682518339;
        bh=akfknqOJ7XH7SYpGWnDMom1hlgSbj88cifnxq0fhJDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U4cWFC/bf1VepzDUnpGDkW7avfmVShX30/zd3LOKgXfOBXumOZtcHl8HFKff8X0TU
         Amh64TRRXRhOJWfq79pKvjePzFKnRTysRSg+o//4xuJ1gmYs3ITNdOejxiUzabmodn
         2aUqfTtmxUOjAXCUt0lwDrJnFrE4PuJm14Pg4nnrah85TcEYeZXNrir2e2JDW+C8qW
         fKxOUMLx8UTCaqfoGIijbg5l6ykdEUxsTO8++zjyh33ypea2U3KpyhsSsDJDZFv7zU
         JIreusfMEbHLZda6rBhs6NztY6K1SmtZ8XJB6WA6ZoaU00yJDq3aKz0RxygEI3FvoP
         o230hz2dF3vyw==
Date:   Wed, 26 Apr 2023 23:12:15 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, corbet@lwn.net,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH tracing 0/3] tracing: support > 8 byte filter predicates
Message-Id: <20230426231215.9f3c43a345fc0b7f047988a9@kernel.org>
In-Reply-To: <57d8f27c-7737-8af9-490b-a33b2783fc9f@oracle.com>
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
        <20230425233233.2ad5168c630b4c1349ab3398@kernel.org>
        <9c4cebb7-514c-f7fd-1f95-50837460eb66@oracle.com>
        <20230425132028.7d16e04c@gandalf.local.home>
        <57d8f27c-7737-8af9-490b-a33b2783fc9f@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 26 Apr 2023 09:51:00 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> On 25/04/2023 18:20, Steven Rostedt wrote:
> > On Tue, 25 Apr 2023 18:15:03 +0100
> > Alan Maguire <alan.maguire@oracle.com> wrote:
> > 
> >> that's a great idea; what would be the most consistent ftrace syntax
> >> for this do you think? I noticed that hist triggers append a modifier
> >> to the field name so would something like
> >>
> >> "dst.ipv6 == ::1"
> > 
> > Yeah, I think just having ":" in the name without quotes can help the filter
> > know that it's a ipv6 id.
> > 
> > Hmm, although we may want to do the same for mac addresses. But we can
> > determine the difference by the field size. If it's 6 bytes, it's a mac, if
> > it's 128 bits, then ipv6.
> >
> 
> good idea! so what about the following
> 
> - 16 byte field with ':'; convert from IPv6 address before memcmp()ing
> - 6 byte field with ':'; convert from MAC address before memcmp()ing
> - 4 byte field with '.'; convert from IPv4 address before memcmp()ing
> - 0x prefix, any other size; basic memcmp

This looks good to me :)

Thanks!

> 
> ? Thanks!
> 
> Alan
>  
> > -- Steve
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
