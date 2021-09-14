Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC19740A6C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Sep 2021 08:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhINGmS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Sep 2021 02:42:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:29468 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhINGmS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Sep 2021 02:42:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221569687"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="221569687"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 23:40:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="543808160"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.176])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 23:40:55 -0700
Date:   Tue, 14 Sep 2021 14:46:49 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
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
Message-ID: <20210914064649.GA79693@chenyu-desktop>
References: <cover.1631025237.git.yu.c.chen@intel.com>
 <1cef405de3484eef108251562fbf461bad4294c7.1631025237.git.yu.c.chen@intel.com>
 <82889db2-1927-582d-c27f-b1f0927ca903@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82889db2-1927-582d-c27f-b1f0927ca903@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah, thank you for taking a look at this,
On Tue, Sep 07, 2021 at 03:28:52PM -0600, Shuah Khan wrote:
> On 9/7/21 9:40 AM, Chen Yu wrote:
> > Introduce a simple test for Platform Firmware Runtime Update and Telemetry
> > drivers. It is based on ioctl to either update firmware driver or code injection,
> > and read corresponding PFRU Telemetry log into user space.
> > 
> 
> A few things to consider and add handling for them in the
> test.
> 
> What happens when non-root user runs this test?
Currently the code does not distinguish between root and non-root. The
next version will terminate if the user is non-root.
> What happens when the pfru device doesn't exist?
> 
Currently the code terminates if either pfru_update or pfru_telemetry
device was not found.
> 
> [snip]
> 
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int fd_update, fd_log, fd_capsule;
> > +	struct telem_data_info data_info;
> > +	struct telem_info info;
> > +	struct update_cap_info cap;
> > +	void *addr_map_capsule;
> > +	struct stat st;
> > +	char *log_buf;
> > +	int ret = 0;
> > +
> > +	parse_options(argc, argv);
> > +
> > +	fd_log = open("/dev/pfru/telemetry", O_RDWR);
> > +	if (fd_log < 0) {
> > +		perror("Cannot open telemetry device...");
> > +		return 1;
> > +	}
> 
> Is this considered an error or unsupported?
> 
> > +	fd_update = open("/dev/pfru/update", O_RDWR);
> > +	if (fd_update < 0) {
> > +		perror("Cannot open code injection device...");
> > +		return 1;
> > +	}
> > +
> 
> Same here. If test is run on platform with pfru test should skip
> instead of reporting failure/error.
> 
Okay, got it. The next version will do the following to fix this:
1. If the pfru_update device is not found, the test will terminate.
   This is because the pfru_update driver is the fundamental driver.
   If this driver is not detected, there would be no information at all.
2. If the pfru_telemetry device is not found, the test will skip
   the log setting/retrieving. Since the pfru_telemetry driver
   is optional, the user can still update the firmware without
   checking the telemetry log.

Thanks,
Chenyu 
