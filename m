Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7177D225F
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjJVJhF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 05:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVJhF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 05:37:05 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4F9E93;
        Sun, 22 Oct 2023 02:37:03 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 39M9ap59003563;
        Sun, 22 Oct 2023 11:36:51 +0200
Date:   Sun, 22 Oct 2023 11:36:51 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests/nolibc: generate config automatically
Message-ID: <20231022093651.GF2669@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
 <20231010-nolibc-out-of-tree-v1-5-b6a263859596@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010-nolibc-out-of-tree-v1-5-b6a263859596@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 10, 2023 at 02:34:00PM +0200, Thomas Weißschuh wrote:
> This new target generates a .config if none exists yet.
> 
> Also drop the defconfig target with its hidden call to 'mrproper' which
> is fairly invasive.
> If users want to overwrite their kernel existing kernel configuration
> they can do so easily from the toplevel directory.

Hmmm I'm not sure about that one, I pretty much remember seeing failing
arm64 builds when mrproper and prepare were missing.

I would argue that someone starting "make defconfig" does expect the
config to be dropped, hence mrproper to be called as well.

What specific issue did you face with it ? Maybe we can restrict it to
only a few cases ?

Willy
