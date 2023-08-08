Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC5D7741D5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjHHR3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjHHR2i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:28:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B5121271;
        Tue,  8 Aug 2023 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sVOpQeHQbYuQD4XI26KPaEpE0Ea50S0OE5ZKW/Qlwrk=; b=vBY1RJPhnM/HaHosbTPNbA0y+k
        roLU7f2LM1KWTAdAPeqZkAlhJ5Ab8Re7s0iwaZwqSZprpCBxXCMEWquufSVGSbn0jTaeOOJi9GALc
        aL58KPV029NgS2NJcA1srEgzDTITQm2Y0zStY4InWwRK1L3x55bSR2UMgRfp6tYP4egf9saBEs105
        pgsZlVmaxnJCiU0TqSY1IV+Gv0P9TcJ380PGW+kbQFiKsGqnUJjn8VhsDpDx9o6NUCbWY8ka4ka7l
        dvyV3Hz16nCucR6dJTvjYIrQ3jzL2LkFW1eNkWspLGQdY93oj+Rf118Vry0KT8dX668jIw93Wa2ii
        vW0mj53Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qTIlN-00Gbn4-GF; Tue, 08 Aug 2023 09:12:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FF0A30003A;
        Tue,  8 Aug 2023 11:12:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0748227E4826F; Tue,  8 Aug 2023 11:12:25 +0200 (CEST)
Date:   Tue, 8 Aug 2023 11:12:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Meng Li <li.meng@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH V1 3/6] cpufreq: Add a notification message that the
 highest perf has changed
Message-ID: <20230808091224.GW212435@hirez.programming.kicks-ass.net>
References: <20230808081001.2215240-1-li.meng@amd.com>
 <20230808081001.2215240-4-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808081001.2215240-4-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 08, 2023 at 04:09:58PM +0800, Meng Li wrote:
> Please refer to the ACPI_Spec for details on the highest
> performance and notify events of CPPC.

Please summarise so that we don't get to click random links on the
interweb just to try and make sense of things.

> Signed-off-by: Meng Li <li.meng@amd.com>
> Link: https://uefi.org/htmlspecs/AddCPI_Spec_6_4_html/08_Processor_Configuration_and_Control/declaring-processors.html?highlight=0x85#highest-performance
> ---
>  drivers/acpi/processor_driver.c |  6 ++++++
>  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
>  include/linux/cpufreq.h         |  4 ++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 4bd16b3f0781..29b2fb68a35d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -27,6 +27,7 @@
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER	0x81
>  #define ACPI_PROCESSOR_NOTIFY_THROTTLING	0x82
> +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED	0x85

Isn't that spelled: 'highest' ?
                        ^

