Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A7F3E5E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 04:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfKHDZa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 22:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:38220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHDZ3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 22:25:29 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C222084D;
        Fri,  8 Nov 2019 03:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573183529;
        bh=OQWLutCvyBNF31F7nVyat1ronJZrpce2IWGhQEDJklg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EL2vfDt6Mw43aU8kaHTYInmtABbFRAMAOtsu/cUlsSL+yYrhw0c5kItTFOXfkIjl8
         Y0b/qWgeolc6lq72oqbSsaPu3G7EN0ptlwK005z41DkQtbsDfU/HxzMGK8hKMkguIH
         SfXE8gnrqWFYUWlSvy6ewTwdns60UlSGCNDkbslM=
Date:   Thu, 7 Nov 2019 19:25:28 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-Id: <20191107192528.0c22e8e122a04d4f8d29c5eb@linux-foundation.org>
In-Reply-To: <20191108020614.GA99567@google.com>
References: <20191107195355.80608-1-joel@joelfernandes.org>
        <20191107170023.0695732bb67eb80acd4caee5@linux-foundation.org>
        <20191108020614.GA99567@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 7 Nov 2019 21:06:14 -0500 Joel Fernandes <joel@joelfernandes.org> wrote:

> On Thu, Nov 07, 2019 at 05:00:23PM -0800, Andrew Morton wrote:
> > On Thu,  7 Nov 2019 14:53:54 -0500 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > 
> > > F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
> > > A private mapping created after the memfd file that gets sealed with
> > > F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
> > > children and parent share the same memory, even though the mapping is
> > > private.
> > 
> > That sounds fairly serious.  Should this be backported into -stable kernels?
> 
> Yes, it should be.

I added

Fixes: ab3948f58ff84 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")
Cc: <stable@vger.kernel.org>

> The F_SEAL_FUTURE_WRITE feature was introduced in v5.1 so
> v5.3.x stable kernels would need a backport. I can submit a backport tomorrow
> unless we are Ok with stable automatically picking it up (I believe the
> stable folks "auto select" fixes which should detect this is a fix since I
> have said it is a fix in the subject line).

The Cc:stable tag should trigger the appropriate actions, assisted by
the Fixes:.  I doubt if "fix" in the Subject has much effect.

