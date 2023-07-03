Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE419745E8C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGCOgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCOga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 10:36:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993794;
        Mon,  3 Jul 2023 07:36:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AEC2C31A;
        Mon,  3 Jul 2023 14:36:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AEC2C31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1688394987; bh=RhCEIGtxJGVeV91EVDUY0yOhsp0I7Oxy2bLYCQ2RLRs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i8En8lM+1Y6yKeeV2T7+Cf25m0U1/2TX4sskHWsT08HjQSaB7IKSbJzPq4RP6qf8M
         pUfthZR6CBMFOazfPm4Niv0ZnLz5wrp1AR9519CEvBPg0Fk/Ytxl4rF4pEb3ITcgZ0
         lCAwUQtFcckZGWEMKnrUOmVWgXwHqd1VqSK4jGUA2QKjKMtrAk3K03zGl2DcIM2FoZ
         FLvHnP5rIPYBUpydER5JJoVEJHulntKYNlDj0Yw68hhAZA+S5dhjeGBjaLirzXV+sW
         g6fGO5sND7+ECIzodWiUFmug2slV0W1fKlr7AkkrvZVzOSXkgJPUaE2RNGSmH3skCZ
         hshplsxiqQ77g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Olaf Hering <olaf@aepfle.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Prarit Bhargava <prarit@redhat.com>,
        Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1] Fix documentation of panic_on_warn
In-Reply-To: <20230630145307.25865-1-olaf@aepfle.de>
References: <20230630145307.25865-1-olaf@aepfle.de>
Date:   Mon, 03 Jul 2023 08:36:27 -0600
Message-ID: <87ilb1jc44.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> The kernel cmdline option panic_on_warn expects an integer, it is not a
> plain option as documented. A number of uses in the tree figured this
> already, and use panic_on_warn=1 for their purpose.
>
> Adjust a comment which otherwise may mislead people in the future.
>
> Fixes: 9e3961a097 ("kernel: add panic_on_warn")
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  tools/testing/selftests/rcutorture/bin/kvm.sh   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e5bab29685f..15196f84df49 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4049,7 +4049,7 @@
>  			extra details on the taint flags that users can pick
>  			to compose the bitmask to assign to panic_on_taint.
>  
> -	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
> +	panic_on_warn=1	panic() instead of WARN().  Useful to cause kdump
>  			on a WARN().

Applied, thanks.

jon
