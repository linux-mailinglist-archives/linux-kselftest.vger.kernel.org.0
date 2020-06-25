Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792ED20A24C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jun 2020 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbgFYPp1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jun 2020 11:45:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:53141 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390568AbgFYPp0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jun 2020 11:45:26 -0400
IronPort-SDR: qYM168mb7fqzNYiSlT3cOIGSlkCblynsq86kQ60LwPF5PbrDwg/tCM1sJa9RLvyVNsx0xk9nOX
 MO63iSvpl86Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="125186036"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="125186036"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 08:45:26 -0700
IronPort-SDR: 6hat3QxzCrHAtzvAqC+30YG3+TG0IfZV1giYLmqQzMcnJRDab2zndHQQZYp/ICUVmSEMrriBa6
 eSemNFRiEtUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="297570162"
Received: from xpf-desktop.sh.intel.com ([10.239.13.107])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2020 08:45:24 -0700
Date:   Thu, 25 Jun 2020 23:55:16 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Heng Su <heng.su@intel.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kai Svahn <kai.svahn@intel.com>
Subject: Re: [PATCH v2] Kernel selftests: TPM2: upgrade TPM2 tests from
 Python 2 to Python 3
Message-ID: <20200625155516.GA4415@xpf-desktop.sh.intel.com>
References: <20200618081502.15302-1-pengfei.xu@intel.com>
 <20200622214613.GA22727@linux.intel.com>
 <20200622214739.GB22727@linux.intel.com>
 <20200623114155.GA15561@xpf-desktop.sh.intel.com>
 <20200624231457.GB21758@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624231457.GB21758@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2020-06-25 at 02:14:57 +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 23, 2020 at 07:41:55PM +0800, Pengfei Xu wrote:
> >   I tried to use bytes(parm, encoding='UTF-8') way, it met the situation
> >   that sometimes parm is string, sometimes parm is bytes.
> 
> We need to do right things right, i.e. you should fix in the call site,
> not in the implementation.

  Ok, I agree, I will have a try. :)
  Thanks!

> 
> /Jarkko
