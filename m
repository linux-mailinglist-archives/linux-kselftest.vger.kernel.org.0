Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1810B74E002
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 23:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGJVJK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 17:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjGJVJJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 17:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84EFB;
        Mon, 10 Jul 2023 14:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F238D61202;
        Mon, 10 Jul 2023 21:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5A9C433C7;
        Mon, 10 Jul 2023 21:09:05 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:09:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Message-ID: <20230710170903.4fd4239c@gandalf.local.home>
In-Reply-To: <285B9992-4DFB-4343-BD64-DAE9CCEFEE6B@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-4-git-send-email-akaher@vmware.com>
        <20230701095417.3de5baab@rorschach.local.home>
        <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
        <20230703110857.2d051af5@rorschach.local.home>
        <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
        <20230703155226.1ab27bc1@gandalf.local.home>
        <20230709215447.536defa6@rorschach.local.home>
        <285B9992-4DFB-4343-BD64-DAE9CCEFEE6B@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 10 Jul 2023 18:53:53 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> Something was broken in your mail (I guess cc list) and couldn’t reach to lkml or
> ignored by lkml. I just wanted to track the auto test results from linux-kselftest.

Anyway, I pushed your series plus this as a commit to:

  https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/log/?h=trace/rfc/eventfs

Which should trigger some of the zero-day bots.

I also ran all my testing with lockdep enabled and nothing triggered.

-- Steve
