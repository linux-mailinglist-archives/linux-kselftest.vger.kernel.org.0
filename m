Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D311C9D23
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 May 2020 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEGVU7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 17:20:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:45901 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEGVU7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 17:20:59 -0400
IronPort-SDR: cXd3lu1vyf3JlKwZtCbxdU0v3ZBCogVKH0d84JxX0dRqOtXjfuLqG4BPVvrzRhhSyYGAqeK+Hm
 MRZnfl3zknXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 14:20:53 -0700
IronPort-SDR: 0kTJmYL0Gfq5mjKxjJU2VO/yIYMWAQbdEuo9ogvmNUVvsbwNilNKkyj0X1vnZPFCrmpWp1aXsG
 kYgXgvuVMHaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,365,1583222400"; 
   d="scan'208";a="295858558"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga002.fm.intel.com with ESMTP; 07 May 2020 14:20:53 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.97]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.15]) with mapi id 14.03.0439.000;
 Thu, 7 May 2020 14:20:53 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [bug report] selftests/resctrl: Add callback to start a
 benchmark
Thread-Topic: [bug report] selftests/resctrl: Add callback to start a
 benchmark
Thread-Index: AQHWJGYSrYgwPG1cd0mIi3zfq7xYEqicw3Fg
Date:   Thu, 7 May 2020 21:20:52 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F5738E47D@ORSMSX114.amr.corp.intel.com>
References: <20200507115056.GA252660@mwanda>
In-Reply-To: <20200507115056.GA252660@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dan,

Thanks for reporting the issues. They look legitimate to me.
I will send a fix.

> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Thursday, May 7, 2020 4:51 AM
> To: Prakhya, Sai Praneeth <sai.praneeth.prakhya@intel.com>
> Cc: linux-kselftest@vger.kernel.org
> Subject: [bug report] selftests/resctrl: Add callback to start a benchmark
> 
> Hello Sai Praneeth Prakhya,
> 
> The patch 7f4d257e3a2a: "selftests/resctrl: Add callback to start a benchmark"
> from Jan 16, 2020, leads to the following static checker
> warning:
> 
> 	tools/testing/selftests/resctrl/resctrl_val.c:545 measure_vals()
> 	warn: 'bw_imc' unsigned <= 0
> 
> 	tools/testing/selftests/resctrl/resctrl_val.c:549 measure_vals()
> 	warn: 'bw_resc_end' unsigned <= 0
> 

I agree. There is no point checking for < 0 for unsigned values.

> tools/testing/selftests/resctrl/resctrl_val.c
>    531  static int
>    532  measure_vals(struct resctrl_val_param *param, unsigned long
> *bw_resc_start)
>    533  {
>    534          unsigned long bw_imc, bw_resc, bw_resc_end;
>    535          int ret;
>    536
>    537          /*
>    538           * Measure memory bandwidth from resctrl and from
>    539           * another source which is perf imc value or could
>    540           * be something else if perf imc event is not available.
>    541           * Compare the two values to validate resctrl value.
>    542           * It takes 1sec to measure the data.
>    543           */
>    544          bw_imc = get_mem_bw_imc(param->cpu_no, param->bw_report);
>    545          if (bw_imc <= 0)
>                     ^^^^^^^^^^^
> Unsigned.  Also the comments for get_mem_bw_imc() says that zero is success.

The comment is wrong. It should have been < 0 failure and > 0 as success.

>    546                  return bw_imc;
>    547
>    548          bw_resc_end = get_mem_bw_resctrl();
>    549          if (bw_resc_end <= 0)
>                     ^^^^^^^^^^^^^^^^
> Unsigned
> 
>    550                  return bw_resc_end;
>    551
>    552          bw_resc = (bw_resc_end - *bw_resc_start) / MB;
>    553          ret = print_results_bw(param->filename, bm_pid, bw_imc, bw_resc);
>    554          if (ret)
>    555                  return ret;
>    556
>    557          *bw_resc_start = bw_resc_end;
>    558
>    559          return 0;
>    560  }
> 
> regards,
> dan carpenter
