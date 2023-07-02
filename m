Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4E6745062
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Jul 2023 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjGBTeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Jul 2023 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGBTeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Jul 2023 15:34:13 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46100C2;
        Sun,  2 Jul 2023 12:34:12 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 362JY118017547;
        Sun, 2 Jul 2023 21:34:01 +0200
Date:   Sun, 2 Jul 2023 21:34:01 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 00/14] tools/nolibc: add a new syscall helper
Message-ID: <20230702193401.GL16233@1wt.eu>
References: <cover.1687187451.git.falcon@tinylab.org>
 <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 28, 2023 at 09:07:16PM +0800, Zhangjin Wu wrote:
> Willy, Thomas
> 
> This is the revision of our 'tools/nolibc: add a new syscall helper'
> series [1].
(...)

just to let you know that I've read them all and am fine with the ones
I didn't comment on.

Thanks Zhangjin!
Willy
