Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBDF706ABA
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 16:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjEQOOd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 10:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjEQOOa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 10:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA3E5C;
        Wed, 17 May 2023 07:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9AA64790;
        Wed, 17 May 2023 14:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2443EC4339C;
        Wed, 17 May 2023 14:14:20 +0000 (UTC)
Date:   Wed, 17 May 2023 10:14:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     yujie.liu@intel.com, amakhalov@vmware.com, chinglinyu@google.com,
        er.ajay.kaher@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        mhiramat@kernel.org, namit@vmware.com, oe-lkp@lists.linux.dev,
        shuah@kernel.org, srivatsa@csail.mit.edu, srivatsab@vmware.com,
        tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Message-ID: <20230517101418.1e4a347d@gandalf.local.home>
In-Reply-To: <1684327207-19817-1-git-send-email-akaher@vmware.com>
References: <202305051619.9a469a9a-yujie.liu@intel.com>
        <1684327207-19817-1-git-send-email-akaher@vmware.com>
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

On Wed, 17 May 2023 18:10:07 +0530
Ajay Kaher <akaher@vmware.com> wrote:

> Steve, locally I have reproduced this issue using:
>     lkp run job-cpu-100%-uprobe-60s.yaml
> 
> And also fixed, I will include this fix as well in v3.

Great. Thanks Ajay!

-- Steve
