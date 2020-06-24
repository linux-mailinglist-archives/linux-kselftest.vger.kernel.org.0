Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961FE2096FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 01:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbgFXXPE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 19:15:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:33013 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgFXXPE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 19:15:04 -0400
IronPort-SDR: Igrz60McNYelS8ECcDNXWDxK6PPyxO4WPA34mjhr0+LAnF2nozEzTZpKsFqWdW1OhnRH1PCJZN
 EuOED+XIGXwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142890502"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="142890502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 16:15:03 -0700
IronPort-SDR: LBfHFzhA65pQlKAiBwy+Ot3pBHnQvNTj4Ck45kesN3ePh/6sOu5Ua9om7lyq01P2nqmITY3CC2
 onI2W+u3FVRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="319589948"
Received: from hluxenbu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.36.218])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2020 16:14:58 -0700
Date:   Thu, 25 Jun 2020 02:14:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Heng Su <heng.su@intel.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v2] Kernel selftests: TPM2: upgrade TPM2 tests from
 Python 2 to Python 3
Message-ID: <20200624231457.GB21758@linux.intel.com>
References: <20200618081502.15302-1-pengfei.xu@intel.com>
 <20200622214613.GA22727@linux.intel.com>
 <20200622214739.GB22727@linux.intel.com>
 <20200623114155.GA15561@xpf-desktop.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623114155.GA15561@xpf-desktop.sh.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 23, 2020 at 07:41:55PM +0800, Pengfei Xu wrote:
>   I tried to use bytes(parm, encoding='UTF-8') way, it met the situation
>   that sometimes parm is string, sometimes parm is bytes.

We need to do right things right, i.e. you should fix in the call site,
not in the implementation.

/Jarkko
