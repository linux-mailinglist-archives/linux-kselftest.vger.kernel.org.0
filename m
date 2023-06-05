Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D600721D14
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 06:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjFEEU7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjFEEU6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 00:20:58 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F2F29C;
        Sun,  4 Jun 2023 21:20:56 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3554KmJM005449;
        Mon, 5 Jun 2023 06:20:48 +0200
Date:   Mon, 5 Jun 2023 06:20:48 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: Re: [PATCH 3/4] selftests/nolibc: always print the log file
Message-ID: <ZH1ioKUVOYGgDUj7@1wt.eu>
References: <cover.1685936428.git.falcon@tinylab.org>
 <835e118943d257b7a83066fb4fb77c0e5cf71534.1685936428.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <835e118943d257b7a83066fb4fb77c0e5cf71534.1685936428.git.falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 05, 2023 at 11:57:44AM +0800, Zhangjin Wu wrote:
> This allows to check the other issues of the output file manually even
> when all of them passed.

Till now I preferred not to see it when everything was OK since it was
useless and permitted a quick visual check in the reports. Do you
really think it's useful ? If others prefer it that way we can change
it but I purposely added this test to "improve" the output (for me at
least). I'm interested in opinions here.

Willy
