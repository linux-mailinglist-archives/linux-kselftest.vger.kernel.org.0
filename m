Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04956B216E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2019 15:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbfIMNxI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Sep 2019 09:53:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:38524 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388813AbfIMNxH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Sep 2019 09:53:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 06:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="179680756"
Received: from ltudorx-wtg.ger.corp.intel.com (HELO localhost) ([10.252.37.39])
  by orsmga008.jf.intel.com with ESMTP; 13 Sep 2019 06:53:01 -0700
Date:   Fri, 13 Sep 2019 14:52:58 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] selftests/tpm2: Add log and *.pyc to .gitignore
Message-ID: <20190913135258.GI7412@linux.intel.com>
References: <20190911093442.13412-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911093442.13412-1-pvorel@suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 11, 2019 at 11:34:42AM +0200, Petr Vorel wrote:
> Fixes: 6ea3dfe1e073 ("selftests: add TPM 2.0 tests")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by:  <jarkko.sakkinen@linux.intel.com>

I applied this to my tpmdd tree. I'll put the both fixes to my next PR.

/Jarkko
