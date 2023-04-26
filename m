Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DAD6EF601
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 16:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbjDZOIr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 10:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjDZOIp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 10:08:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD9659E;
        Wed, 26 Apr 2023 07:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43FF663539;
        Wed, 26 Apr 2023 14:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5484C433EF;
        Wed, 26 Apr 2023 14:08:42 +0000 (UTC)
Date:   Wed, 26 Apr 2023 10:08:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, corbet@lwn.net,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH tracing 0/3] tracing: support > 8 byte filter predicates
Message-ID: <20230426100840.69d29b68@gandalf.local.home>
In-Reply-To: <57d8f27c-7737-8af9-490b-a33b2783fc9f@oracle.com>
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
        <20230425233233.2ad5168c630b4c1349ab3398@kernel.org>
        <9c4cebb7-514c-f7fd-1f95-50837460eb66@oracle.com>
        <20230425132028.7d16e04c@gandalf.local.home>
        <57d8f27c-7737-8af9-490b-a33b2783fc9f@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 26 Apr 2023 09:51:00 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> - 16 byte field with ':'; convert from IPv6 address before memcmp()ing
> - 6 byte field with ':'; convert from MAC address before memcmp()ing
> - 4 byte field with '.'; convert from IPv4 address before memcmp()ing
> - 0x prefix, any other size; basic memcmp

Sure.

-- Steve
