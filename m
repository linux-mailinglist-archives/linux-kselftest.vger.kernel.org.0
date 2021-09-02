Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3FE3FEB89
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 11:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbhIBJsb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 05:48:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:27018 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241297AbhIBJsb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 05:48:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="206273283"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="206273283"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 02:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="532969607"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2021 02:47:30 -0700
Date:   Thu, 2 Sep 2021 17:39:18 +0800
From:   Philip Li <philip.li@intel.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     bamv2005@gmail.com, shuah@kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests/gpio: Fix gpio compiling error
Message-ID: <20210902093918.GA411030@pl-dbox>
References: <20210902084635.103622-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210902084635.103622-1-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

applied
On Thu, Sep 02, 2021 at 04:46:35PM +0800, Li Zhijian wrote:
> [root@iaas-rpma gpio]# make
> gcc     gpio-mockup-cdev.c  -o /home/lizhijian/linux/tools/testing/selftests/gpio/gpio-mockup-cdev
> gpio-mockup-cdev.c: In function ‘request_line_v2’:
> gpio-mockup-cdev.c:24:30: error: storage size of ‘req’ isn’t known
>    24 |  struct gpio_v2_line_request req;
>       |                              ^~~
> gpio-mockup-cdev.c:32:14: error: ‘GPIO_V2_LINE_FLAG_OUTPUT’ undeclared (first use in this function); did you mean ‘GPIOLINE_FLAG_IS_OUT’?
>    32 |  if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
>       |              ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Search headers from linux tree like others, such as sched
> 
> CC: Philip Li <philip.li@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  tools/testing/selftests/gpio/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
> index 39f2bbe8dd3d..42ea7d2aa844 100644
> --- a/tools/testing/selftests/gpio/Makefile
> +++ b/tools/testing/selftests/gpio/Makefile
> @@ -3,5 +3,6 @@
>  TEST_PROGS := gpio-mockup.sh
>  TEST_FILES := gpio-mockup-sysfs.sh
>  TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
> +CFLAGS += -I../../../../usr/include
>  
>  include ../lib.mk
> -- 
> 2.31.1
> 
> 
> 
