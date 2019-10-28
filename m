Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CABE7A4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2019 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfJ1UkM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Oct 2019 16:40:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:21900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfJ1UkM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Oct 2019 16:40:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 13:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="224752421"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2019 13:40:07 -0700
Date:   Mon, 28 Oct 2019 22:40:05 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        shuah <shuah@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191028204005.GD8279@linux.intel.com>
References: <1571944467-13097-1-git-send-email-zohar@linux.ibm.com>
 <20191028203014.GA8279@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028203014.GA8279@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 28, 2019 at 10:30:14PM +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 24, 2019 at 03:14:27PM -0400, Mimi Zohar wrote:
> > Create, save and load trusted keys test
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > Change log v1:
> > - Replace the directions for using Trousers to take ownership of the TPM
> > with directions for using the IBM TSS.
> > - Differentiate between different types of errors.  Recent bug is causing
> > "add_key: Timer expired".
> > ---
> 
> Is not really usable as a selftest because of 3rd party dependencies.

For TPM 2.0 I did write a smoke test for TPM2 trusted keys:

https://github.com/jsakkine-intel/tpm2-scripts

What you need to do is to make a lightweight library for TPM 1.x e.g.
tpm1.py, and use that to implement the test.

For TPM 2.0 I would peek at the tpm2-pcr-policy and keyctl-smoke.sh on
how to implement the without 3rd party deps.

/Jarkko
