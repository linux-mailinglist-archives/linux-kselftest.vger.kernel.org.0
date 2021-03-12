Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1D833997C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 23:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhCLWMV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 17:12:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:62814 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235438AbhCLWLs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 17:11:48 -0500
IronPort-SDR: faR52Zr4v5YxaaIKBiq3qiDprnyK6W47IOP4odJEKnnYlZOCp7VB/JiZISV12C49cZ5TJ6H8DV
 8zrpVayW+ziQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="252913793"
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="252913793"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 14:11:38 -0800
IronPort-SDR: 3SkjhvNFitGXxEzOcDZlOINkRLNmTfRz76imRwlaYH4UFjDZROB1Jil65I9KmTXXysZ24r1ti9
 sU8IZbQKF+kA==
X-IronPort-AV: E=Sophos;i="5.81,244,1610438400"; 
   d="scan'208";a="448754751"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 14:11:38 -0800
Date:   Fri, 12 Mar 2021 22:11:37 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/21] Miscellaneous fixes for resctrl selftests
Message-ID: <YEvnGQ0W1IlOMjOf@otcwcpicx3.sc.intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
 <652bfb1c-91d4-13b1-b9be-be8a4147d304@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652bfb1c-91d4-13b1-b9be-be8a4147d304@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Babu,

On Fri, Mar 12, 2021 at 01:08:11PM -0600, Babu Moger wrote:
> Hi Fenghua, Thanks for the patches.
> Sanity tested them on AMD systems. Appears to work fine.
> Few minor comments in few patches.
> Tested-by: Babu Moger <babu.moger@amd.com>

I will add Tested-by: Babu Moger in the series and address your
comments.

Thank you for your review!

-Fenghua
