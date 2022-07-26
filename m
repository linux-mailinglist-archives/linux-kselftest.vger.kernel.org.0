Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1D5819F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239639AbiGZSsc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 14:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbiGZSsa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 14:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9533A0A;
        Tue, 26 Jul 2022 11:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32052614D7;
        Tue, 26 Jul 2022 18:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CA8C433D6;
        Tue, 26 Jul 2022 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658861307;
        bh=YvJxG1/fVVolNPtSRFsAMPTdcWSGkZ8+KXAyXor4524=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g0dsTBVS4F9Q4nTcXdcjAogXo2bZlw+hkyXVi5U6dlLefmN66sCTPIdJ4oudJ3xDU
         01L3ZCjLAluqU1YH3PbFHGANCsnxyuUwawkDShNp+CAq1do9pVQ4xo/8AvV+W6yFVc
         uI4PcfiHJVkB26Zjujz77g9wH/uHPturxzDfwWec=
Date:   Tue, 26 Jul 2022 11:48:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] selftests/vm: enable running select groups of tests
Message-Id: <20220726114826.5dad09d9b1c8b8e4ed7a8051@linux-foundation.org>
In-Reply-To: <CAA1CXcAQpO+T67RheV5Hv6BZ8n-xEUEwztVzkGe+Z2fEL+uJ2Q@mail.gmail.com>
References: <20220706205451.4133254-1-jsavitz@redhat.com>
        <CAA1CXcCHp+zt=34wyFrif+7QtAs9TBOLaL3Nqitz8f_tnR7u9g@mail.gmail.com>
        <CAL1p7m5pLQcvkGajOL8CQiunvye4-8QrDS8oWMShOHmOUFsB-w@mail.gmail.com>
        <CAA1CXcAQpO+T67RheV5Hv6BZ8n-xEUEwztVzkGe+Z2fEL+uJ2Q@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 26 Jul 2022 06:31:29 -0400 Nico Pache <npache@redhat.com> wrote:

> Ok thanks for pointing that out!
> 
> Andrew, would it be possible to modify the patch and make the variable
> name VM_SELFTEST_ITEMS?

Sure.  Please send a new patch against linux-next late this week.
