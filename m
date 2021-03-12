Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC08339974
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 23:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhCLWJl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 17:09:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:1029 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235308AbhCLWJW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 17:09:22 -0500
IronPort-SDR: eHGodOyMK3GZhXWVaz7k6iTuYTkzv1hYayqI1tPZZ6GOG8/GCvDsxk84R4SEHfb4M/OBtV7/zl
 Zg8JgwtvDLSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176023026"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="176023026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 14:09:17 -0800
IronPort-SDR: eRra4IuVxIDZ5yWYYZKPaGF/3+AzVch2zRTcTIEXCTCFKlK+QQjJ537AMySI8vDd0118ghpIPx
 L0k0iQsEdG4w==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="510463891"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 14:09:15 -0800
Date:   Fri, 12 Mar 2021 22:09:08 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/21] selftests/resctrl: Call kselftest APIs to log
 test results
Message-ID: <YEvmhPIQjt7Wd6N9@otcwcpicx3.sc.intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <20210307145502.2916364-9-fenghua.yu@intel.com>
 <d902468d-644f-65e4-1043-81c90fdf4da8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d902468d-644f-65e4-1043-81c90fdf4da8@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Babu,

On Fri, Mar 12, 2021 at 01:12:35PM -0600, Babu Moger wrote:
> > -			printf("# dmesg: %s", line);
> > +			ksft_print_msg("dmesg: %s", line);
> >  		if (strstr(line, "resctrl:"))
> > -			printf("# dmesg: %s", line);
> > +			ksft_print_msg("dmesg: %s", line);
> 
> In general, this patch has some minor nits. When displaying the messages,
>  normally the first character should be capitalized.
> ksft_print_msg("checking for pass/fail\n");
> should be
>  ksft_print_msg("Checking for pass/fail\n");
> 
> And
> ksft_print_msg("Please Enter value in range 1 to %d\n",count_of_bits);
> Should be
> 
> ksft_print_msg("Please enter value in range 1 to %d\n", count_of_bits);
> 
> I am not too concerned about this. You can improve it if you like it.
> 
Ok. Will fix them.

Thanks.

-Fenghua
