Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95D61FECA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgFRHlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 03:41:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:30544 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgFRHlS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 03:41:18 -0400
IronPort-SDR: PyS9QxPx83GJgTqRV7LCLEh7+rPwFyVZaET4ecpfgwIrZRrG3Q7iFXbvT14ziAF+QqbU3Lo3oz
 KVs8LCD9VKkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="227179317"
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="227179317"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 00:41:17 -0700
IronPort-SDR: hmPEk8+Ta8XZa7xBYxEquUcTyXFqmonbmopCvD6mlJZ0KmkMLQKFIJmdXqmGJTbcsfu2+EL2DP
 PudKsxxBIExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,525,1583222400"; 
   d="scan'208";a="273776057"
Received: from xpf-desktop.sh.intel.com ([10.239.13.107])
  by orsmga003.jf.intel.com with ESMTP; 18 Jun 2020 00:41:10 -0700
Date:   Thu, 18 Jun 2020 15:51:04 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Shuah Khan <shuah@kernel.org>, Heng Su <heng.su@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai Svahn <kai.svahn@intel.com>
Subject: Re: [Linux] [PATCH] Kernel selftests: tpm2: upgrade tpm2 tests from
 python2 to python3
Message-ID: <20200618075104.GA13935@xpf-desktop.sh.intel.com>
References: <20200618030245.7153-1-pengfei.xu@intel.com>
 <20200618071858.GD6560@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618071858.GD6560@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,
  Thanks for your advice.
  My feedback is as below.

  BR.
  Thanks!

On 2020-06-18 at 10:18:58 +0300, Jarkko Sakkinen wrote:
> On Thu, Jun 18, 2020 at 11:02:45AM +0800, Pengfei Xu wrote:
> > Some Linux OS will never support python2 anymore, so upgrade tpm2 selftests
> > to python3.
> > 
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> 
> Linux is a kernel, not a full operating system. Perhaps you mean Linux
> distributions?
> 

  Will remove [Linux], thanks!

> Please capitalize abbrevations correctly (TPM2, not tpm2). Please write
> 'Python 2' instead of python2.
> 

  Will do, thanks!

> With that said the commit message is inaccurate. The root reason for
> moving to Python 3 is that Python 2 is no longer supported by the Python
> upstream project. Nothing to do with Linux or Linux distributions for
> that matter.
> 
  Will do, thanks!

> /Jarkko
