Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8068A34AF7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Mar 2021 20:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZTpk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Mar 2021 15:45:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:5896 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhCZTpd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Mar 2021 15:45:33 -0400
IronPort-SDR: T/02Zudpl04iAdTaYZTZ8nxI+ViKInJ0qsUtw+Hj3A3qoA/RYFtQ3fdYObrxxYASMePRKtgcWh
 Hqu7lFfWncsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="211377897"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="211377897"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:45:33 -0700
IronPort-SDR: Pyx8Iq8Afv8THn27V1eav8kq4TRtbY2s3Tj5D/6WnjwsYptWNdy+FTzgArUipQFKvYEG0DSrhn
 AmhqAQnnlfjg==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="410036391"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:45:33 -0700
Date:   Fri, 26 Mar 2021 19:45:26 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/21] Miscellaneous fixes for resctrl selftests
Message-ID: <YF451jic7QNyUCVD@otcwcpicx3.sc.intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Shuah,

On Wed, Mar 17, 2021 at 02:22:34AM +0000, Fenghua Yu wrote:
> This patch set has several miscellaneous fixes to resctrl selftest tool
> that are easily visible to user. V1 had fixes to CAT test and CMT test
> but they were dropped in V2 because having them here made the patchset
> humongous. So, changes to CAT test and CMT test will be posted in another
> patchset.
> 
> Change Log:
> v6:
> - Add Tested-by: Babu Moger <babu.moger@amd.com>.
> - Replace "cat" by CAT_STR etc (Babu).
> - Capitalize the first letter of printed message (Babu).

Any comment on this series? Will you push it into linux-kselftest.git?

Thanks.

-Fenghua
