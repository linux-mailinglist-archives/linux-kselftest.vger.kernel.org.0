Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D171DA032
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 21:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgESTAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 May 2020 15:00:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:62691 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgESTAp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 May 2020 15:00:45 -0400
IronPort-SDR: vwky50IiyfCMFHsyjHNDpyQF6ffQBzJJo3cGzp8HGLJAQqSg8h/cNVvxzd85wObH2EjGclJMeB
 Y/XGOHHkqB+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 12:00:44 -0700
IronPort-SDR: DPcoO8JWQyzvNdTE+i+NjsSRehFDDEuS8LYC9YUWq1IQeAtof4lmJM2bG07+MnU58PZIh1qInD
 p/nEVByMNVFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="264407484"
Received: from joelin3-mobl.gar.corp.intel.com (HELO localhost) ([10.249.42.57])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 12:00:40 -0700
Date:   Tue, 19 May 2020 22:00:36 +0300
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
Subject: Re: [PATCH v2] Kernel selftests: Add check if tpm devices are
 supported
Message-ID: <20200519190023.GA22852@linux.intel.com>
References: <20200519120743.41358-1-Nikita.Sobolev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519120743.41358-1-Nikita.Sobolev@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 19, 2020 at 03:07:43PM +0300, Nikita Sobolev wrote:
> tpm2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> are available. In case, when these devices are not available test
> fails, but expected behaviour is skipped test.
> 
> Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>

See

https://lore.kernel.org/linux-kselftest/20200519134838.GA17129@linux.intel.com/T/#mf762512a67f0b23db5663d6d67746cb94b812931

The comments about the fixes tag and acronym spelling were not
addressed. The code change looks great tho now, thanks.

/Jarkko
