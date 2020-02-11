Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9524F159D12
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 00:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBKXTH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 18:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbgBKXTH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 18:19:07 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1ABE206DB;
        Tue, 11 Feb 2020 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581463147;
        bh=0TVKSVRJRv/z3S7kxpkrJCMjT/X+SvLuGM2qOdND2sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cu3jAtewRRDlmCAw+wkXwFQAflXIRX/nRaeTMPRBLFRtS7HfQmFogOcd+JSX1pXmr
         o4zDJhRMBWqCseqvBTHft9sdTDjPjqye7WP/eoKKRudXmhnqi/G3pDQuYo4BuRJ3eq
         VIyVuHqInOEuCzLbUH7F3jI64oVXTL59gXIYLT3s=
Date:   Tue, 11 Feb 2020 15:19:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     mike.kravetz@oracle.com, shuah@kernel.org, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation
 counter
Message-Id: <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
In-Reply-To: <20200211213128.73302-1-almasrymina@google.com>
References: <20200211213128.73302-1-almasrymina@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:

> These counters will track hugetlb reservations rather than hugetlb
> memory faulted in. This patch only adds the counter, following patches
> add the charging and uncharging of the counter.

We're still pretty thin on review here, but as it's v12 and Mike
appears to be signed up to look at this work, I'll add them to -next to
help move things forward.

