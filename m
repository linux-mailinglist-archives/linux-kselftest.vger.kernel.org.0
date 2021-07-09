Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264043C2403
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jul 2021 15:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGINM1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jul 2021 09:12:27 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:36158
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhGINM0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jul 2021 09:12:26 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Jul 2021 09:12:26 EDT
Received: from canonical.com (1.general.ppisati.uk.vpn [10.172.193.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 201A0401BE;
        Fri,  9 Jul 2021 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1625835627;
        bh=AxMIlOmaQ4Uu2aXRanEA5LyfXIZ8Qn+vel6oh6biIdI=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=q3tfLZaSZGGU3NKlgimJLilAZHAPCZhronAZHCtRxrmgjXHnpEozeEERPe4CW7jvV
         kHi+KxtSEUZzM2wNeqByfuAs71qNWMeyGJLYCBXiYzcl5nCq0NmwjYPECjZRKFFENZ
         jBl20UfKcLVUgoKG41AxNjLzpm16IHKcfwNHAHbURO4vgmvZ1cL/3cA6vgbU3kMBjS
         KHd4U4M79eOLq3EfKZBE4A/96Yjks8PBjW9vUIF6s1XFKy2dsWT4Ix6IEZtBS1anci
         JVY9QaAWQ4EnCFNwTWxn6tv5rtRQGl1QF4f6NCJK/JXBdQn7Cb/oTdDEllut5Wiq5I
         idE1Zz7toPa5A==
Date:   Fri, 9 Jul 2021 15:00:26 +0200
From:   Paolo Pisati <paolo.pisati@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: memory-hotplug: avoid spamming logs with
 dump_page(), ratio limit hot-remove error test
Message-ID: <YOhIainrHwydNrGh@amaterasu>
References: <20210630145740.54614-1-paolo.pisati@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630145740.54614-1-paolo.pisati@canonical.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 30, 2021 at 04:57:40PM +0200, Paolo Pisati wrote:
> While the offline memory test obey ratio limit, the same test with error
> injection does not and tries to offline all the hotpluggable memory, spamming
> system logs with hundreds of thousands of dump_page() entries, slowing system
> down (to the point the test itself timeout and gets terminated) and excessive fs
> occupation:
> 
> ...

Anyone with spare cycles could review this? It got one ack already.
-- 
bye,
p.
