Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C8E1DED65
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 18:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgEVQhs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 12:37:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:60820 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgEVQhs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 12:37:48 -0400
IronPort-SDR: A6xOwgnm8fsVRqJeTKB4oTGBEA1J+1oaUgBFoGan33pidojR9cC3D2zflf2z9MDHTxHsQsmByh
 l7aCa0oMgruw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 09:37:48 -0700
IronPort-SDR: v05CruEDS/sQbJcCpXJ4yZigvNIF5MkdrMEIhvH0Vnxdhv3UvesWPTo5bJH61nOfyMZ3RcOolH
 wA9fTpvH3d3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="254318997"
Received: from omillerx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.59])
  by fmsmga007.fm.intel.com with ESMTP; 22 May 2020 09:37:45 -0700
Date:   Fri, 22 May 2020 19:37:45 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v3] Kernel selftests: Add check if TPM devices are
 supported
Message-ID: <20200522163745.GB10319@linux.intel.com>
References: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
 <20200522163714.GA10319@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522163714.GA10319@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 22, 2020 at 07:37:17PM +0300, Jarkko Sakkinen wrote:
> On Thu, May 21, 2020 at 05:43:44PM +0300, Nikita Sobolev wrote:
> > TPM2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> > are available. In case, when these devices are not available test
> > fails, but expected behaviour is skipped test.
> > 
> > Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Shuah, can you pick this up?

/Jarkko
