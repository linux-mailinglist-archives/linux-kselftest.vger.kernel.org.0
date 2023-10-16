Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71687CB566
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjJPVoF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 17:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVoF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 17:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F90A1;
        Mon, 16 Oct 2023 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HRz8nph8WnrDrrGRrnXeWuJaQDKFZ6Yp+LYMrq9QAyg=; b=PL+aoOGi3qjK/S8aZ3+ac1TqIF
        Wo+V0SAIv0JXK0YFrYNukEBBC6zYrQtRe8vbeNXQ9KH8kCIOkdDNDOy8psYyGgUk0dzBlACVZm6Zk
        2z+TRCkksTQT9kzVUUe6e0J0utAAlWW6uBg6sz32J19975SXutB0nnlkkWZuSk7WQ0o/0yDJQRxEk
        Y4E3zA/B1VivBlWl3JsAzRiVYnFf5fJ6hDdOWtB510/2r5qcdyIpsAUnPSMDtUGYBchzQAVFUjHJJ
        R538FhCa/5JoQ2AXFJF5F0LhVWoATvlcoaDwXZ5+uT0KzJITSn6JD5hnZvbiEnfHg11ydbQ+z7LVy
        LXv31D4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsVNG-008U1l-I7; Mon, 16 Oct 2023 21:43:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39B73300513; Mon, 16 Oct 2023 23:43:42 +0200 (CEST)
Date:   Mon, 16 Oct 2023 23:43:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests: futex: remove duplicate unneeded defines
Message-ID: <20231016214342.GC36211@noisy.programming.kicks-ass.net>
References: <20231006095539.1601385-1-usama.anjum@collabora.com>
 <7f6380ca-7f4e-4080-a047-6f7d427c3501@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6380ca-7f4e-4080-a047-6f7d427c3501@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 01:21:20PM -0600, Shuah Khan wrote:
> On 10/6/23 03:55, Muhammad Usama Anjum wrote:
> > Kselftests are kernel tests and must be build with kernel headers from
> > same source version. The kernel headers are already being included
> > correctly in futex selftest Makefile with the help of KHDR_INCLUDE. In
> > this patch, only the dead code is being removed. No functional change is
> > intended.
> > 
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> 
> Applied to linux-kselftest next for Linux 6.7-rc1.

Please don't.
