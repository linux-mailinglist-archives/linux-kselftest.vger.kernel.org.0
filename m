Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E179525AEC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgIBPZ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 11:25:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:10435 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgIBPZs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 11:25:48 -0400
IronPort-SDR: CmAeaSXKEuI2EX3CGO99S4RiPWEK8rouML4cKz2J2P5WbP12Orp0MPN/3cCSe55zZ2Qr5U6uHo
 5PqNXGDO+2DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="154808921"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="154808921"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 08:25:28 -0700
IronPort-SDR: L67woUpoVuqgVtgy6pkvyyzRjvNctYT8LWivC1LtOEmUFWlgEn3YgaVHpkdyYY9cehcrxZ7c+N
 uMZlBfRn1XBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="325821419"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2020 08:25:28 -0700
Received: from abityuts-desk1.ger.corp.intel.com (abityuts-desk1.ger.corp.intel.com [10.237.72.186])
        by linux.intel.com (Postfix) with ESMTP id 341F158041C;
        Wed,  2 Sep 2020 08:25:25 -0700 (PDT)
Message-ID: <b59481655c29d081eea4f34c00166517738000e5.camel@gmail.com>
Subject: Re: [RFC v4 1/1] selftests/cpuidle: Add support for cpuidle latency
 measurement
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>, rjw@rjwysocki.net,
        daniel.lezcano@linaro.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com
Date:   Wed, 02 Sep 2020 18:25:24 +0300
In-Reply-To: <20200902114506.45809-2-psampat@linux.ibm.com>
References: <20200902114506.45809-1-psampat@linux.ibm.com>
         <20200902114506.45809-2-psampat@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2020-09-02 at 17:15 +0530, Pratik Rajesh Sampat wrote:
> Measure cpuidle latencies on wakeup to determine and compare with the
> advertsied wakeup latencies for each idle state.

It looks like the measurements include more than just C-state wake,
they also include the overhead of waking up the proces, context switch,
and potentially any interrupts that happen on that CPU. I am not saying
this is not interesting data, it surely is, but it is going to be
larger than you see in cpuidle latency tables. Potentially
significantly larger.

Therefore, I am not sure this program should be advertised as "cpuidle
measurement". It really measures the "IPI latency" in case of the IPI
method.

> A baseline measurement for each case of IPI and timers is taken at
> 100 percent CPU usage to quantify for the kernel-userpsace overhead
> during execution.

At least on Intel platforms, this will mean that the IPI method won't
cover deep C-states like, say, PC6, because one CPU is busy. Again, not
saying this is not interesting, just pointing out the limitation.

I was working on a somewhat similar stuff for x86 platforms, and I am
almost ready to publish that on github. I can notify you when I do so
if you are interested. But here is a small presentation of the approach
that I did on Plumbers last year:

https://youtu.be/Opk92aQyvt0?t=8266

(the link points to the start of my talk)

