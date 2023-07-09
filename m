Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DD074C19A
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jul 2023 10:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGIIzC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 9 Jul 2023 04:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGIIzB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 9 Jul 2023 04:55:01 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1587198;
        Sun,  9 Jul 2023 01:55:00 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3698srOf009406;
        Sun, 9 Jul 2023 10:54:53 +0200
Date:   Sun, 9 Jul 2023 10:54:53 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v1 4/5] selftests/nolibc: report: extrude the test status
 line
Message-ID: <20230709085453.GB9321@1wt.eu>
References: <cover.1688633188.git.falcon@tinylab.org>
 <89f3668f48d01fdac847bdfa085867cb641bad27.1688633188.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f3668f48d01fdac847bdfa085867cb641bad27.1688633188.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 06, 2023 at 05:11:17PM +0800, Zhangjin Wu wrote:
> two newlines are added around the test summary line to extrude the test
> status.

But then we're back to making it annoying to check, having to figure
if we need to grep -A or grep -B etc. With grep 'status:' we would get
a synthetic status and the counters together. Why do you think it's
not convenient ? Or am I the only one considering it useful to just
run grep "status:" on all output files and figure a global status at
once ?

Willy
