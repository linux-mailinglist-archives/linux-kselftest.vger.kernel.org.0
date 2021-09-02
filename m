Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FEF3FEB8E
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 11:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245753AbhIBJtU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 05:49:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:20905 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343716AbhIBJtT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 05:49:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="199282799"
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="199282799"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 02:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,371,1620716400"; 
   d="scan'208";a="467317751"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2021 02:48:18 -0700
Date:   Thu, 2 Sep 2021 17:40:06 +0800
From:   Philip Li <philip.li@intel.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     bamv2005@gmail.com, shuah@kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests/gpio: Fix gpio compiling error
Message-ID: <20210902094006.GA411314@pl-dbox>
References: <20210902084635.103622-1-lizhijian@cn.fujitsu.com>
 <20210902093918.GA411030@pl-dbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210902093918.GA411030@pl-dbox>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 02, 2021 at 05:39:18PM +0800, Philip Li wrote:
> applied
sorry, reply the wrong mail, kindly ignore

> On Thu, Sep 02, 2021 at 04:46:35PM +0800, Li Zhijian wrote:
> > [root@iaas-rpma gpio]# make
> > gcc     gpio-mockup-cdev.c  -o /home/lizhijian/linux/tools/testing/selftests/gpio/gpio-mockup-cdev
> > gpio-mockup-cdev.c: In function ‘request_line_v2’:
> > gpio-mockup-cdev.c:24:30: error: storage size of ‘req’ isn’t known
> >    24 |  struct gpio_v2_line_request req;
> >       |                              ^~~
> > gpio-mockup-cdev.c:32:14: error: ‘GPIO_V2_LINE_FLAG_OUTPUT’ undeclared (first use in this function); did you mean ‘GPIOLINE_FLAG_IS_OUT’?
> >    32 |  if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
> >       |              ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Search headers from linux tree like others, such as sched
> > 
> > CC: Philip Li <philip.li@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > ---
> >  tools/testing/selftests/gpio/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
> > index 39f2bbe8dd3d..42ea7d2aa844 100644
> > --- a/tools/testing/selftests/gpio/Makefile
> > +++ b/tools/testing/selftests/gpio/Makefile
> > @@ -3,5 +3,6 @@
> >  TEST_PROGS := gpio-mockup.sh
> >  TEST_FILES := gpio-mockup-sysfs.sh
> >  TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
> > +CFLAGS += -I../../../../usr/include
> >  
> >  include ../lib.mk
> > -- 
> > 2.31.1
> > 
> > 
> > 
