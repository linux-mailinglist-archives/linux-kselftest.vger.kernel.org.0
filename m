Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBABA73700A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jun 2023 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjFTPOH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 11:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjFTPNv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 11:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C321996;
        Tue, 20 Jun 2023 08:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA39612DF;
        Tue, 20 Jun 2023 15:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F06AC433C8;
        Tue, 20 Jun 2023 15:13:41 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:13:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     sunliming <kelulanainsley@gmail.com>, mhiramat@kernel.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/3] tracing/user_events: Fix incorrect return value
 for writing operation when events are disabled
Message-ID: <20230620111339.44c84a83@gandalf.local.home>
In-Reply-To: <20230619184044.GA88@W11-BEAU-MD.localdomain>
References: <20230609030302.1278716-1-sunliming@kylinos.cn>
        <20230609030302.1278716-2-sunliming@kylinos.cn>
        <20230616160845.GA88@W11-BEAU-MD.localdomain>
        <CAJncD7Sfasoe4-hKZP4c3bPZ892S2Kk5JaMo-aca6eBDwLjLNQ@mail.gmail.com>
        <20230619184044.GA88@W11-BEAU-MD.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 19 Jun 2023 11:40:44 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > Now，when the event is disabled, the trace record appears to be lost.  
> 
> I'm taking this to mean, if in between the time of the bit check and the
> actual write() /writev() syscall the event becomes disabled, the event
> won't write to the buffer. Yes, that is expected.
> 
> > In some situations
> > where data timing is sensitive, it may cause confusion. In this case,
> > not returning an
> > error (as mentioned in your reply, it is not considered this case an
> > actual error) and
> > returning 0 ( meaning that the number of data to be written is 0) may
> > be a good way
> > to handle it?  
> 
> This is where I get a little lost. What would a user process do with a
> return of 0 bytes? It shouldn't retry, since it just hit that small
> timing window. In reality, it just incurred a temporary excessive
> syscall cost, but no real data loss (the operator/admin turned the event
> off).

Note, this is similar to the race in the kernel with several tracing
activities. If a disable happens and the buffer is now off, but the trace
is still attempted, zero or NULL (depending on the function) is returned.
This just means that tracing is off, and the event should just be dropped.

-- Steve
