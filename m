Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B937987D6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 15:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbjIHN3M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbjIHN3M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 09:29:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C11BF4;
        Fri,  8 Sep 2023 06:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Su6vpBpZs72kzi34K7jBSnLd/tcZ/SFt4/dlVSkVFw=; b=K5PZdHmlnGTpKNg+y7jVbukJcH
        uQO1OK0E8cQ5n+0RVG+hmRDy6fc355K2oLNozEhbRgWA5b2Lz5VQ6bdtAnhES9aw1wf7B/NOYX9Nb
        vX97GLanY3hskCFL3Eb9/HmDMUR0QGecCYZ2OQUBIF7biwYG+0ZknHV8QMc+L48Pqp+xOY+yW3gJr
        CGHU9EsUtXM2keujz1Nz68bt4zPlk8jcVxAt6dQpXo6tg5zk4uUQE8yKBZKrr//qKllX/ZmCWekTM
        SAeHUhR+ZipNVRQJVq20HBSJdYqWwgIdU/zJ+tQ9JLNCdbvyngP/GKROCZ0PwPakE/ooBYN9Pj+kG
        DNiBgmMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qebXI-002Xef-2Z;
        Fri, 08 Sep 2023 13:28:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB248300472; Fri,  8 Sep 2023 15:28:37 +0200 (CEST)
Date:   Fri, 8 Sep 2023 15:28:37 +0200
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
        Borislav Petkov <bp@alien8.de>, Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH V5 5/7] cpufreq: amd-pstate: Update amd-pstate preferred
 core ranking dynamically
Message-ID: <20230908132837.GJ19320@noisy.programming.kicks-ass.net>
References: <20230905015116.2268926-1-li.meng@amd.com>
 <20230905015116.2268926-6-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905015116.2268926-6-li.meng@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 05, 2023 at 09:51:14AM +0800, Meng Li wrote:

> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> index 446394f84606..2159fd5693fe 100644
> --- a/include/linux/amd-pstate.h
> +++ b/include/linux/amd-pstate.h
> @@ -31,6 +31,11 @@ struct amd_aperf_mperf {
>  	u64 mperf;
>  	u64 tsc;
>  };
> +	/* For platforms that do not support the preferred core feature, the
> +	 * highest_pef may be configured with 166 or 255, to avoid max frequency
> +	 * calculated wrongly. we take the AMD_CPPC_HIGHEST_PERF(cap1) value as
> +	 * the default max perf.
> +	 */

Invalid comment style, also seems randomly (mis)placed.
