Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251D641FC00
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Oct 2021 15:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhJBNDq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 2 Oct 2021 09:03:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52286 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbhJBNDp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 2 Oct 2021 09:03:45 -0400
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 91B9E4F804CBE;
        Sat,  2 Oct 2021 06:01:57 -0700 (PDT)
Date:   Sat, 02 Oct 2021 14:01:52 +0100 (BST)
Message-Id: <20211002.140152.1798934215442988990.davem@davemloft.net>
To:     jk@codeconstruct.com.au
Cc:     netdev@vger.kernel.org, kuba@kernel.org, matt@codeconstruct.com.au,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] mctp: test: disallow MCTP_TEST when
 building as a module
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20211002022656.1681956-1-jk@codeconstruct.com.au>
References: <20211002022656.1681956-1-jk@codeconstruct.com.au>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Sat, 02 Oct 2021 06:01:59 -0700 (PDT)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Sat,  2 Oct 2021 10:26:55 +0800

> The current kunit infrastructure defines its own module_init() when
> built as a module, which conflicts with the mctp core's own.
> 
> So, only allow MCTP_TEST when both MCTP and KUNIT are built-in.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Jeremy I had to revert your entire series because of this.

You will need rseubmit the entire series with this build failure fixed.

Thasnk you.
