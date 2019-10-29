Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4413CE8401
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2019 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfJ2JPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 05:15:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:57692 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfJ2JPj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 05:15:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="401085508"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.122])
  by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 02:15:35 -0700
Date:   Tue, 29 Oct 2019 11:15:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        shuah <shuah@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191029091535.GB9896@linux.intel.com>
References: <1571944467-13097-1-git-send-email-zohar@linux.ibm.com>
 <20191028203014.GA8279@linux.intel.com>
 <1572295513.4532.270.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572295513.4532.270.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 28, 2019 at 04:45:13PM -0400, Mimi Zohar wrote:
> On Mon, 2019-10-28 at 22:30 +0200, Jarkko Sakkinen wrote:
> > On Thu, Oct 24, 2019 at 03:14:27PM -0400, Mimi Zohar wrote:
> > > Create, save and load trusted keys test
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > 
> > > Change log v1:
> > > - Replace the directions for using Trousers to take ownership of the TPM
> > > with directions for using the IBM TSS.
> > > - Differentiate between different types of errors.  Recent bug is causing
> > > "add_key: Timer expired".
> > > ---
> > 
> > Is not really usable as a selftest because of 3rd party dependencies.
> 
> As part of diagnosing trusted keys failure, there is some
> hints/directions as to how to take TPM 1.2 ownership, but it does not
> take ownership.  The previous version included directions for using
> Trousers.  This version provides directions for using the IBM TSS.
>  Feel free to include additional hints/directions.

You must write your own minimal user space that can be included
to the kernel. Otherwise, we cannot take it.

/Jarkko
