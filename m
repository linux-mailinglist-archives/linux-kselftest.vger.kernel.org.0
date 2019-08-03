Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6959880353
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2019 02:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbfHCADV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Aug 2019 20:03:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388777AbfHCADV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Aug 2019 20:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rSdr3ohR1mrAnHT9V8mrn3l5fZYOti2z+Aql37lDCYw=; b=Qg9wMncRcgDW6iYDaN50W/leb
        wdFG8qDooiLIC2zark2Kf7JY1EEbP3fCK5mpQd546WqJ3AfsJONKQ4lEAw2zFuc0pSMF/PAZ9u1za
        dWj9tN9eNisf/gMlnePPUQQD7xZoVez0wjxSrJzgAiIPe6JR/IMbbLoaD+rBcrqx8CyTIxUmF9hkX
        rpNxorD4FJsnNCfphk00Nq3w0UUupwlkSu7+rEpYrHTlqSr7A1w0aStkPlQRry/GV83n9uCz8BGx/
        VjWpu4YkDhZpuIWRxPz53d05Iu3mgKU08LgVxdGHbp6hx/qko422JNe35BmYgjt2rtDYyabB1AaA5
        09r4GegAg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hthW4-0003zb-2p; Sat, 03 Aug 2019 00:03:20 +0000
Subject: Re: [PATCH] selftest/ftrace: Fix typo in trigger-snapshot.tc
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com,
        linux-kselftest@vger.kernel.org
References: <20190803000126.23200-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02ca1f97-ca23-c855-1dc0-a45b243b22f0@infradead.org>
Date:   Fri, 2 Aug 2019 17:03:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190803000126.23200-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/2/19 5:01 PM, Masanari Iida wrote:
> This patch fixes a spelling typo in tigger-snapshot.tc

typo:)                                trigger-


> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  .../testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
> index 7717c0a09686..ac738500d17f 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/trigger-snapshot.tc
> @@ -28,7 +28,7 @@ if [ -z "$FEATURE" ]; then
>      exit_unsupported
>  fi
>  
> -echo "Test snapshot tigger"
> +echo "Test snapshot trigger"
>  echo 0 > snapshot
>  echo 1 > events/sched/sched_process_fork/enable
>  ( echo "forked")
> 


-- 
~Randy
