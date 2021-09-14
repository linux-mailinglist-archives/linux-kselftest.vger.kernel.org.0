Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFD40A706
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 09:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhINHEX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 03:04:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:43416 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240327AbhINHEN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 03:04:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="244234463"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="244234463"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 00:02:56 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="543817039"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.176])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 00:02:53 -0700
Date:   Tue, 14 Sep 2021 15:08:46 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Dou Shengnan <shengnanx.dou@intel.com>
Subject: Re: [PATCH 5/5][RFC] selftests/pfru: add test for Platform Firmware
 Runtime Update and Telemetry
Message-ID: <20210914070846.GA80235@chenyu-desktop>
References: <cover.1631025237.git.yu.c.chen@intel.com>
 <1cef405de3484eef108251562fbf461bad4294c7.1631025237.git.yu.c.chen@intel.com>
 <YTh9mEjm7EI1dmu7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTh9mEjm7EI1dmu7@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mike,
On Wed, Sep 08, 2021 at 12:08:40PM +0300, Mike Rapoport wrote:
> On Tue, Sep 07, 2021 at 11:40:30PM +0800, Chen Yu wrote:
> > Introduce a simple test for Platform Firmware Runtime Update and Telemetry
> > drivers. It is based on ioctl to either update firmware driver or code injection,
> > and read corresponding PFRU Telemetry log into user space.
> >
[snip.. 
> > +struct updated_result {
> > +	enum dsm_status status;
> > +	enum dsm_status ext_status;
> > +	unsigned long low_auth_time;
> > +	unsigned long high_auth_time;
> > +	unsigned long low_exec_time;
> > +	unsigned long high_exec_time;
> > +};
> 
> Most of these types and constants seem to be a copy of uapu/linux/pfru.h.
> Shouldn't the test get them from there?
>
Yes they have shared structures. The next version will reuse the uapi header.

thanks,
Chenyu 
