Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97079ADF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 01:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbjIKVUb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbjIKPCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 11:02:33 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65975125;
        Mon, 11 Sep 2023 08:02:29 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 38BF2FsM017336;
        Mon, 11 Sep 2023 17:02:15 +0200
Date:   Mon, 11 Sep 2023 17:02:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: libc-test: avoid -Wstringop-overflow
 warnings
Message-ID: <ZP8r97kYS6lT4xNq@1wt.eu>
References: <20230910-nolibc-poll-fault-v1-1-2b7a16f48259@weissschuh.net>
 <ZP6uAT0jmseRHkzG@1wt.eu>
 <cf5a2308-e241-4146-85c6-67ad924fb67c@t-8ch.de>
 <ZP8kgXhP/UjsMoD4@1wt.eu>
 <96597a87-89f2-4ec0-bf89-d1d8920f0d29@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96597a87-89f2-4ec0-bf89-d1d8920f0d29@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 11, 2023 at 04:47:12PM +0200, Thomas Weißschuh wrote:
> I used "git rebase --signoff" and dropped the duplicate signoffs it
> generated on my own commits.
> 
> It's also pushed to git.kernel.org, could you double-check it?

Looks good to me, thank you!

Willy
