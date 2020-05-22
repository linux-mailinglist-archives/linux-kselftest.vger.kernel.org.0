Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7CC1DF048
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgEVUAk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 16:00:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:57415 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730893AbgEVUAk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 16:00:40 -0400
IronPort-SDR: XtHVxYyAf5vEH49cUWyYQ0PD1nBHlna6PIBolyMBl7EkaS22LNt9ZXGsmjWwldcBaK/HC1JOT/
 3JcgFNZpndZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 13:00:31 -0700
IronPort-SDR: Bn+s5kEeq3xJ/DxUaKFS56sEC5ThKILViF5ryIBv8HF8o4U+Pd6FqEFkCsxFQFXiXuboE64Tfx
 YkRHJDkDDurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="300771018"
Received: from rpurrx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.58.10])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2020 13:00:28 -0700
Date:   Fri, 22 May 2020 23:00:29 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     shuah <shuah@kernel.org>
Cc:     Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        linux-kselftest@vger.kernel.org,
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
Message-ID: <20200522200029.GA150221@linux.intel.com>
References: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
 <20200522163714.GA10319@linux.intel.com>
 <20200522163745.GB10319@linux.intel.com>
 <b433d7c7-38a2-098a-55c9-6f8cc13f7230@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b433d7c7-38a2-098a-55c9-6f8cc13f7230@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 22, 2020 at 01:23:26PM -0600, shuah wrote:
> On 5/22/20 10:37 AM, Jarkko Sakkinen wrote:
> > On Fri, May 22, 2020 at 07:37:17PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, May 21, 2020 at 05:43:44PM +0300, Nikita Sobolev wrote:
> > > > TPM2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> > > > are available. In case, when these devices are not available test
> > > > fails, but expected behaviour is skipped test.
> > > > 
> > > > Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Shuah, can you pick this up?
> > 
> > /Jarkko
> > 
> 
> Done. Applied to linux-kselftest next for Linux 5.8-rc1.
> 
> thanks,
> -- Shuah

Thank you.

/Jarkko
