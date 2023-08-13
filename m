Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA777A5C3
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Aug 2023 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjHMJQa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 13 Aug 2023 05:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMJQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 13 Aug 2023 05:16:30 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38DC0BE;
        Sun, 13 Aug 2023 02:16:31 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 37D9GPeh008678;
        Sun, 13 Aug 2023 11:16:25 +0200
Date:   Sun, 13 Aug 2023 11:16:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: Re: [PATCH v2 5/7] selftests/nolibc: customize CROSS_COMPILE for all
 architectures
Message-ID: <20230813091625.GG8237@1wt.eu>
References: <cover.1691783604.git.falcon@tinylab.org>
 <a5deb231269cff5225be8331888fbea19337d5f9.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5deb231269cff5225be8331888fbea19337d5f9.1691783604.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 12, 2023 at 04:32:41AM +0800, Zhangjin Wu wrote:
> +CROSS_COMPILE_i386      ?= x86_64-linux-
> +CROSS_COMPILE_x86_64    ?= x86_64-linux-
> +CROSS_COMPILE_x86       ?= x86_64-linux-
> +CROSS_COMPILE_arm64     ?= aarch64-linux-
> +CROSS_COMPILE_arm       ?= arm-linux-gnueabi-
> +CROSS_COMPILE_mips      ?= mips64-linux-

Given that we don't support mips64, I'd suggest to ust mips-linux-
instead here for now. That doesn't seem right to ask users to
download a toolchain for a different architecture than the one
supported just because we can adapt to it.

Willy
