Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F3661581
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjAHNjN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAHNjM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:39:12 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AF5A191;
        Sun,  8 Jan 2023 05:39:12 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 23C857E427;
        Sun,  8 Jan 2023 13:39:08 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673185152;
        bh=O5kO/BuL0bjoW9iRYY9qqFTTtxFqmyIjQAJYt050F2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bCwKNWopqoQ5Bdz03D6Y+LRLjT/vv5ofwsm6BzOf8J9vpIgBf39IOadiasOKQjeGG
         phjGJCBQfmenCSojPbI+RlVku9ymbmOb8nH0Lb4EB7PTtfGvkd7HUBX1KpJPJ1N/sS
         4Wi+RjaIlC6t/T9S5NcHLHhkufUPx2f9ZJcoPQ9KqQuLZs2kft7QnI3Cd71bZDg0K1
         CZD5DRpbxI4ekUASZDR4JlqoZzpGEMmW6qk69m+jWi7kb9tlLWh7z+g1nojR+AWh2i
         Km8eDVXQ1WIHZ0za6V6XDX/BtTMYTlCdEuiF1wsRmEWdj5YUDJcARFR1d/gurq043H
         +bayXGHJKfWcg==
Date:   Sun, 8 Jan 2023 20:39:05 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] nolibc signal handling support
Message-ID: <Y7rHeRrEzlRraKTF@biznet-home.integral.gnuweeb.org>
References: <20221227184902.GA6287@1wt.eu>
 <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org>
 <20221228133513.GA7457@1wt.eu>
 <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org>
 <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com>
 <20230103035427.GA4474@1wt.eu>
 <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
 <20230108131038.841204-1-ammar.faizi@intel.com>
 <CAOG64qOZ7tw_HQjpu9S4ORpW2oVgFd5gK2YyvmA3AswSMsnO9Q@mail.gmail.com>
 <Y7rFs0KIWOtjPO2b@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7rFs0KIWOtjPO2b@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 08, 2023 at 08:31:37PM +0700, Ammar Faizi wrote:
> On Sun, Jan 08, 2023 at 08:28:33PM +0700, Alviro Iskandar Setiawan wrote:
> > The signal() self test is missing?
> 
> Ugh, yes. I didn't send the signal() selftest. Will do.

Bah, it turned out I squashed the signal() test into "selftests/nolibc:
Add `sigaction(2)` selftes" patch. It was unintentional. Will split it
properly in v3.

-- 
Ammar Faizi

