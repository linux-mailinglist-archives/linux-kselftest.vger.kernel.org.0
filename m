Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7744CE7A2E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2019 21:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfJ1UfH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Oct 2019 16:35:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:11429 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfJ1UfG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Oct 2019 16:35:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 13:35:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,241,1569308400"; 
   d="scan'208";a="205275826"
Received: from shrehore-mobl1.ti.intel.com (HELO localhost) ([10.251.82.5])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 13:35:01 -0700
Date:   Mon, 28 Oct 2019 22:35:00 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        shuah <shuah@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v1] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191028203500.GB8279@linux.intel.com>
References: <1571944467-13097-1-git-send-email-zohar@linux.ibm.com>
 <1571945046.11756.5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1571945046.11756.5.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 24, 2019 at 03:24:06PM -0400, Mimi Zohar wrote:
> Hi Jarkko,
> 
> Please note that I'm seeing "add_key: Timer expired" frequently.  This
> is something new.  I have no idea if this is a new TPM or keys
> regression.

Is it possible to bisect this? I cannot run the test script that you
made at the moment because of dependencies.

I'll try to work on image with BuildRoot that would have TrouSerS.
I recall it had recipe for it. So probably late this week or early
next week I'll be able to help finding the root cause.

/Jarkko
