Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A9C764150
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 23:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGZVj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 17:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGZVj1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 17:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3F268B;
        Wed, 26 Jul 2023 14:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A28A61CCD;
        Wed, 26 Jul 2023 21:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D242DC433C7;
        Wed, 26 Jul 2023 21:39:21 +0000 (UTC)
Date:   Wed, 26 Jul 2023 17:39:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Ching-lin Yu <chinglinyu@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>, Nadav Amit <namit@vmware.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        Alexey Makhalov <amakhalov@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>
Subject: Re: [PATCH v5 02/10] eventfs: Implement tracefs_inode_cache
Message-ID: <20230726173918.107908a3@rorschach.local.home>
In-Reply-To: <0FE7065F-6536-4311-AF41-4ABBD8E3ECF8@vmware.com>
References: <1690054625-31939-1-git-send-email-akaher@vmware.com>
        <1690054625-31939-3-git-send-email-akaher@vmware.com>
        <20230725190617.14c85997@rorschach.local.home>
        <0FE7065F-6536-4311-AF41-4ABBD8E3ECF8@vmware.com>
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

On Wed, 26 Jul 2023 18:45:34 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> Ok, I will move this to v6 04/10.
> Let me know once you will complete the review of v5.

OK, I finished my review. Mostly more nits. Hopefully v6 will be what I
pull into linux-next.

-- Steve
