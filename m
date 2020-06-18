Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9881FEC4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 09:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgFRHTD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 03:19:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:28607 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgFRHTC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 03:19:02 -0400
IronPort-SDR: EBKiGKD/+cdhWfV+oM4kqYP334Sh1SzSaXswuqAyztzGQ2/Gx/eAx3cyF54EsvQZkzqeH/ndry
 VxAyv0UjHzuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="227172834"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="227172834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 00:19:02 -0700
IronPort-SDR: 840Kcw7kByyuzIETV9JRIw3EBbk7P7xpBdTh4/wrRbXhA9I+SGJHNS4VJN9Cj/KF2HJc4qgTd3
 1y4XDw0TNlvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="263517438"
Received: from jkalinox-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.49.234])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2020 00:18:59 -0700
Date:   Thu, 18 Jun 2020 10:18:58 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>
Subject: Re: [Linux] [PATCH] Kernel selftests: tpm2: upgrade tpm2 tests from
 python2 to python3
Message-ID: <20200618071858.GD6560@linux.intel.com>
References: <20200618030245.7153-1-pengfei.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618030245.7153-1-pengfei.xu@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 11:02:45AM +0800, Pengfei Xu wrote:
> Some Linux OS will never support python2 anymore, so upgrade tpm2 selftests
> to python3.
> 
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>

Linux is a kernel, not a full operating system. Perhaps you mean Linux
distributions?

Please capitalize abbrevations correctly (TPM2, not tpm2). Please write
'Python 2' instead of python2.

With that said the commit message is inaccurate. The root reason for
moving to Python 3 is that Python 2 is no longer supported by the Python
upstream project. Nothing to do with Linux or Linux distributions for
that matter.

/Jarkko
