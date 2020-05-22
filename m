Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB42E1DED60
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 May 2020 18:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgEVQhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 May 2020 12:37:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:10483 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEVQhR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 May 2020 12:37:17 -0400
IronPort-SDR: 1QtKuzXxy09gjlss3IrGdLLb8GCyZSlFpWrR0I3rvOBijZmSoBCNwKJ2wJL2ONhMdVDOFybskA
 7bz7gIStYOZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 09:37:16 -0700
IronPort-SDR: JEidF67PYSgBq5aX5xATp9ya5JSrCiRO+JzkEuIQOb6UmY6yIawRJ1h3RwT9Xv4uv4rOtOTBEX
 sbadxAt4klzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="300722038"
Received: from omillerx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.59])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2020 09:37:12 -0700
Date:   Fri, 22 May 2020 19:37:14 +0300
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
Message-ID: <20200522163714.GA10319@linux.intel.com>
References: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 21, 2020 at 05:43:44PM +0300, Nikita Sobolev wrote:
> TPM2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
> are available. In case, when these devices are not available test
> fails, but expected behaviour is skipped test.
> 
> Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Thank you.

/Jarkko
