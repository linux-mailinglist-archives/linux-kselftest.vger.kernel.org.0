Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6486E8765
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2019 12:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfJ2Lp6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Oct 2019 07:45:58 -0400
Received: from mga09.intel.com ([134.134.136.24]:46882 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731885AbfJ2Lp5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Oct 2019 07:45:57 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 04:45:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="193579197"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.122])
  by orsmga008.jf.intel.com with ESMTP; 29 Oct 2019 04:45:36 -0700
Date:   Tue, 29 Oct 2019 13:45:35 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>, Petr Vorel <pvorel@suse.cz>,
        shuah <shuah@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftest/trustedkeys: TPM 1.2 trusted keys test
Message-ID: <20191029114535.GA12272@linux.intel.com>
References: <1571944467-13097-1-git-send-email-zohar@linux.ibm.com>
 <20191028203014.GA8279@linux.intel.com>
 <1572295513.4532.270.camel@linux.ibm.com>
 <20191029091535.GB9896@linux.intel.com>
 <20191029092516.GA13848@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029092516.GA13848@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 29, 2019 at 11:25:16AM +0200, Jarkko Sakkinen wrote:
> I'll anyway try to setup user space with TrouSerS so that I can try
> it out. BuildRoot has recipe for that but not for IBM TSS 2.0 so I'll
> skip that and use my own test script for TPM2 trusted keys.

Busybox version of mktemp gives this error message:

  mktemp: Invalid argument

I get that three times.

Then I get non-existent directory error from line 65 but it is probably
consequence of the previous errors.

This the help for mktemp:

"
Usage: mktemp [-dt] [-p DIR] [TEMPLATE]

Create a temporary file with name based on TEMPLATE and print its name.
TEMPLATE must end with XXXXXX (e.g. [/dir/]nameXXXXXX).
Without TEMPLATE, -t tmp.XXXXXX is assumed.

	-d	Make directory, not file
	-q	Fail silently on errors
	-t	Prepend base directory name to TEMPLATE
	-p DIR	Use DIR as a base directory (implies -t)
	-u	Do not create anything; print a name

Base directory is: -p DIR, else $TMPDIR, else /tmp
"

Use total six X's seems to fix the problem.

/Jarkko
