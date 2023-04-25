Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433356EE685
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjDYRUf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 13:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjDYRUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 13:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D1E5F;
        Tue, 25 Apr 2023 10:20:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EE0662647;
        Tue, 25 Apr 2023 17:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA29C433D2;
        Tue, 25 Apr 2023 17:20:31 +0000 (UTC)
Date:   Tue, 25 Apr 2023 13:20:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, corbet@lwn.net,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH tracing 0/3] tracing: support > 8 byte filter predicates
Message-ID: <20230425132028.7d16e04c@gandalf.local.home>
In-Reply-To: <9c4cebb7-514c-f7fd-1f95-50837460eb66@oracle.com>
References: <1682414197-13173-1-git-send-email-alan.maguire@oracle.com>
        <20230425233233.2ad5168c630b4c1349ab3398@kernel.org>
        <9c4cebb7-514c-f7fd-1f95-50837460eb66@oracle.com>
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

On Tue, 25 Apr 2023 18:15:03 +0100
Alan Maguire <alan.maguire@oracle.com> wrote:

> that's a great idea; what would be the most consistent ftrace syntax
> for this do you think? I noticed that hist triggers append a modifier
> to the field name so would something like
> 
> "dst.ipv6 == ::1"

Yeah, I think just having ":" in the name without quotes can help the filter
know that it's a ipv6 id.

Hmm, although we may want to do the same for mac addresses. But we can
determine the difference by the field size. If it's 6 bytes, it's a mac, if
it's 128 bits, then ipv6.

-- Steve
