Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A472DFCFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 15:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgLUOns (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 09:43:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:28138 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgLUOns (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 09:43:48 -0500
IronPort-SDR: Sy5rUBB5p+XmauxJ2hR2+33pzyV4O4w9HDg4r1oJehdz22ANp7UccAUxVrzINyTEU+G4qGu3qj
 p3ytz1NegYzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9841"; a="175833451"
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="175833451"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 06:42:02 -0800
IronPort-SDR: c7pJYjrFM6xw20I0yqVotUzsdPji7s3EAaxtUmM9cD9zoPnv36KaZPETiACCGhy+E9EJo7sFu/
 lwC70ocrhVig==
X-IronPort-AV: E=Sophos;i="5.78,436,1599548400"; 
   d="scan'208";a="343062769"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 06:42:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1krMOs-00GLgo-QD; Mon, 21 Dec 2020 16:43:02 +0200
Date:   Mon, 21 Dec 2020 16:43:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: kunit stopped working
Message-ID: <20201221144302.GR4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

For last few weeks KUnit stopped working. Any insight?

P.S. I guess no need to tell that my kernel on which I run tests has not been
changed as well as command line for wrapper:

	tools/testing/kunit/kunit.py run --build_dir ~/$OUT_DIR

-- 
With Best Regards,
Andy Shevchenko


