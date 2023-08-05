Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A97710A7
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjHEQzQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 12:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjHEQzP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 12:55:15 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF5AFE6A;
        Sat,  5 Aug 2023 09:55:13 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 375GssGA025616;
        Sat, 5 Aug 2023 18:54:54 +0200
Date:   Sat, 5 Aug 2023 18:54:54 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: Re: [PATCH v3 00/14] tools/nolibc: enable compiler warnings
Message-ID: <20230805165454.GE15284@1wt.eu>
References: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803-nolibc-warnings-v3-0-bcc1a096ae02@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 09:28:44AM +0200, Thomas Weißschuh wrote:
> To help the developers to avoid mistakes and keep the code smaller let's
> enable compiler warnings.

All the series looks good, I've now queued it, thanks!

> I stuck with __attribute__((unused)) over __maybe_unused in
> nolibc-test.c for consistency with nolibc proper.
> If we want to add a define it needs to be added twice once for nolibc
> proper and once for nolibc-test otherwise libc-test wouldn't build
> anymore.

I tend to prefer to avoid spreading macros in nolibc itself unless
strictly necessary as we'd need to put them under a "nolibc" namespace
to avoid a risk of clash, and it becomes less interesting in terms of
number of characters saved per line when everything is prefixed with
"nolibc_" or so. It's convenient however when there are multiple
choices to be replicated at multiple places. So let's keep it like
this for now.

Cheers,
Willy
