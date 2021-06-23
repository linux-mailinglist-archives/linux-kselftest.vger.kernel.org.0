Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55F33B1B52
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 15:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWNl1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 09:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230061AbhFWNl1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 09:41:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA2161026;
        Wed, 23 Jun 2021 13:39:09 +0000 (UTC)
Date:   Wed, 23 Jun 2021 09:39:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: fix event-no-pid on 1-core machine
Message-ID: <20210623093907.168e6c6f@gandalf.local.home>
In-Reply-To: <02d3ed4d-1814-b16d-1885-e6b173e071d0@canonical.com>
References: <20210623070431.16592-1-krzysztof.kozlowski@canonical.com>
        <20210623085217.036b7e8d@gandalf.local.home>
        <02d3ed4d-1814-b16d-1885-e6b173e071d0@canonical.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 23 Jun 2021 15:36:20 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:

> s/recorder/recorded/
> 
> I can also send a v2 with fixed msg.

Yes, please send a v2, and include my Acked-by (exactly as I wrote it).

Thanks!

-- Steve
