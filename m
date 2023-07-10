Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD18474CA16
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 04:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGJCxd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 22:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGJCxd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 22:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A492FB;
        Sun,  9 Jul 2023 19:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD45A60DBC;
        Mon, 10 Jul 2023 02:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C7DC433C7;
        Mon, 10 Jul 2023 02:53:29 +0000 (UTC)
Date:   Sun, 9 Jul 2023 22:53:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ajay Kaher <akaher@vmware.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "sri\"" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Message-ID: <20230709225327.777ea466@rorschach.local.home>
In-Reply-To: <1C0CB205-B56F-44AE-B9B4-3668E06C840E@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-4-git-send-email-akaher@vmware.com>
        <20230701095417.3de5baab@rorschach.local.home>
        <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
        <20230703110857.2d051af5@rorschach.local.home>
        <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
        <20230703155226.1ab27bc1@gandalf.local.home>
        <20230709215447.536defa6@rorschach.local.home>
        <1C0CB205-B56F-44AE-B9B4-3668E06C840E@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 10 Jul 2023 02:17:01 +0000
Nadav Amit <namit@vmware.com> wrote:

> > On Jul 9, 2023, at 6:54 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > +       union {
> > +               struct rcu_head         rcu;
> > +               struct llist_node       llist;  /* For freeing after RCU */
> > +       };  
> 
> The memory savings from using a union might not be worth the potential impact
> of type confusion and bugs.

It's also documentation. The two are related, as one is the hand off to
the other. It's not a random union, and I'd like to leave it that way.

-- Steve
