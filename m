Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D27357804
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 00:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhDGWzF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 18:55:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:51762 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhDGWzD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 18:55:03 -0400
IronPort-SDR: dtY8tk0NAsUUDfTygFN0j5NvbBhzMRSd4JaxJ339nmC6e7rGyihq1tIptdWIvt/UmX+dPUazF1
 EWs/DBySzw7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180955838"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="180955838"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:54:52 -0700
IronPort-SDR: ebqtshAfC6rJrYpIB5ut3KOCQS5XWGOkEguXRhQRwMrMAAzA/m7rFAKvSSRUSjcc8eY+0BIa9e
 JkT2YPhpYhcw==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="421923121"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:54:52 -0700
Date:   Wed, 7 Apr 2021 22:54:46 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests/resctrl: Change a few printed messages
Message-ID: <YG44NgogMXnge8+O@otcwcpicx3.sc.intel.com>
References: <20210407195728.1436270-1-fenghua.yu@intel.com>
 <bc53f24b-7ec9-992f-6013-d40459e2b360@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc53f24b-7ec9-992f-6013-d40459e2b360@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Shuah,

On Wed, Apr 07, 2021 at 04:46:38PM -0600, Shuah Khan wrote:
> On 4/7/21 1:57 PM, Fenghua Yu wrote:
> > Change a few printed messages to report test progress more clearly.
> Thank you. Applied to linux-kseftest next branch for 5.13-rc1

Great! I pull the next patch and test the patch. It works fine.

BTW, as said in the cover patch in the series, there will be two
new patch sets to fix a few other resctrl selftest issues on top of
this series. I will send out them in the next weeks. Hopefully
you will push them to 5.14:)

Thank you very much for your help!

-Fenghua
