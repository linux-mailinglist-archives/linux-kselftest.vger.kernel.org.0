Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EF61D1FC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 21:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390613AbgEMT5M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 15:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390158AbgEMT5K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 15:57:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A782DC061A0C
        for <linux-kselftest@vger.kernel.org>; Wed, 13 May 2020 12:57:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EAE45127F6DC8;
        Wed, 13 May 2020 12:57:09 -0700 (PDT)
Date:   Wed, 13 May 2020 12:57:09 -0700 (PDT)
Message-Id: <20200513.125709.1574810036252704473.davem@davemloft.net>
To:     vladbu@mellanox.com
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        xiyou.wangcong@gmail.com, jhs@mojatatu.com, dcaratti@redhat.com,
        marcelo.leitner@gmail.com
Subject: Re: [PATCH net-next] selftests: fix flower parent qdisc
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200513175746.7294-1-vladbu@mellanox.com>
References: <20200513175746.7294-1-vladbu@mellanox.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 13 May 2020 12:57:10 -0700 (PDT)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


You put "net-next" in your subject line but failed to include
netdev in the CC: list.
