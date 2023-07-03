Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D8C746389
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGCTwd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 15:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCTwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 15:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2479E5F;
        Mon,  3 Jul 2023 12:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408D361027;
        Mon,  3 Jul 2023 19:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495FDC433C7;
        Mon,  3 Jul 2023 19:52:28 +0000 (UTC)
Date:   Mon, 3 Jul 2023 15:52:26 -0400
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
Message-ID: <20230703155226.1ab27bc1@gandalf.local.home>
In-Reply-To: <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
        <1685610013-33478-4-git-send-email-akaher@vmware.com>
        <20230701095417.3de5baab@rorschach.local.home>
        <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
        <20230703110857.2d051af5@rorschach.local.home>
        <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
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

On Mon, 3 Jul 2023 18:51:22 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> > 
> > We can also look to see if we can implement this with RCU. What exactly
> > is this rwsem protecting?
> >   
> 
> - struct eventfs_file holds the meta-data for file or dir.
> https://github.com/intel-lab-lkp/linux/blob/dfe0dc15a73261ed83cdc728e43f4b3d4e315aae/include/linux/tracefs.h#L28
> - eventfs_rwsem is supposed to protect the 'link-list which is made of struct eventfs_file
> ' and elements of struct eventfs_file.

RCU is usually the perfect solution for protecting link lists though. I'll
take a look at this when I get back to work.

-- Steve
