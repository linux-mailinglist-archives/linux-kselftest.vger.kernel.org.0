Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E177A5C8
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHMJTt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 05:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJTs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 05:19:48 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6AEA2170C;
        Sun, 13 Aug 2023 02:19:51 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37D9Jins008746;
        Sun, 13 Aug 2023 11:19:44 +0200
Date:   Sun, 13 Aug 2023 11:19:44 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 3/7] selftests/nolibc: libc-test: use HOSTCC instead
 of CC
Message-ID: <20230813091944.GH8237@1wt.eu>
References: <cover.1691783604.git.falcon@tinylab.org>
 <e82f5bc54c59f831df652403b2d5b13a93d1d2c5.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e82f5bc54c59f831df652403b2d5b13a93d1d2c5.1691783604.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 12, 2023 at 04:30:25AM +0800, Zhangjin Wu wrote:
> libc-test is mainly added to compare the behavior of nolibc to the
> system libc, it is meaningless and error-prone with cross compiling.
> 
> Let's use HOSTCC instead of CC to avoid wrongly use cross compiler when
> CROSS_COMPILE is passed or customized.

Indeed. This one is actually a fix for this one, I'll pick it separately
as it's independent on this series:

    85a0b029a1ce ("selftests/nolibc: add run-libc-test target")

Thanks,
Willy
