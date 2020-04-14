Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459571A8B09
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 21:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504942AbgDNTie (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 15:38:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:46410 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504933AbgDNThZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 15:37:25 -0400
IronPort-SDR: +R1ZdfmBgifIi0GOoG6HYiVFMrbABi0/BoRBhGK4EETQAW4GBPC0a4ccvHFI4B2yK8mlW50uuF
 oAWkvmcbDO1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:37:24 -0700
IronPort-SDR: Z8Bu/Hm/CWYBRGSA/2FfIZ19wLluWx1XaYt7V5Gmpk8QpZK5F+xJxRdITrflUyoF+1xVLfPLA+
 285rtFZrYhgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="253292254"
Received: from jclobus-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.176])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 12:37:23 -0700
Date:   Tue, 14 Apr 2020 22:37:22 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "Kernel selftests: tpm2: check for tpm support"
Message-ID: <20200414193722.GD13000@linux.intel.com>
References: <20200412142309.71807-1-jarkko.sakkinen@linux.intel.com>
 <3921a93f-120c-0201-4af5-591bf4e6a0b0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3921a93f-120c-0201-4af5-591bf4e6a0b0@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 09:12:05AM -0600, shuah wrote:
> On 4/12/20 8:23 AM, Jarkko Sakkinen wrote:
> > This reverts commit b32694cd0724d4ceca2c62cc7c3d3a8d1ffa11fc.
> > 
> > The original comment
> 
> commit I assume.
> 
>  was neither reviewed nor tested. Thus, this the
> > *only* possible action to take.
> > 
> 
> Bummer. I will apply this right away.

No worries, and fine with the change as long as I'm able to
review and try it out :-) Sorry for the dull tone!

/Jarkko
