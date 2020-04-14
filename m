Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40E51A8B2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Apr 2020 21:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504971AbgDNTig (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 15:38:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:20368 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504935AbgDNTiE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 15:38:04 -0400
IronPort-SDR: oAKLFXDXNH+KwFraP2LPccTZHn67TF/32WTkmzsSSyYdqU3b1aESbNgCBLlClyJl5NxgEegJ7Y
 xBEDlpRenXiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:38:03 -0700
IronPort-SDR: MXSWKYs+SPkaIF67mS1eFroTQmYjl86e8bKTFoPxIT8VWh2Ghd+fSHHAzQw/i+LeAQWu51fHyG
 PAgF0hsKVy+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="253292411"
Received: from jclobus-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.176])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 12:38:01 -0700
Date:   Tue, 14 Apr 2020 22:38:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "Kernel selftests: tpm2: check for tpm support"
Message-ID: <20200414193800.GE13000@linux.intel.com>
References: <20200412142309.71807-1-jarkko.sakkinen@linux.intel.com>
 <3921a93f-120c-0201-4af5-591bf4e6a0b0@kernel.org>
 <20200414193722.GD13000@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414193722.GD13000@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 10:37:25PM +0300, Jarkko Sakkinen wrote:
> On Tue, Apr 14, 2020 at 09:12:05AM -0600, shuah wrote:
> > On 4/12/20 8:23 AM, Jarkko Sakkinen wrote:
> > > This reverts commit b32694cd0724d4ceca2c62cc7c3d3a8d1ffa11fc.
> > > 
> > > The original comment
> > 
> > commit I assume.
> > 
> >  was neither reviewed nor tested. Thus, this the
> > > *only* possible action to take.
> > > 
> > 
> > Bummer. I will apply this right away.
> 
> No worries, and fine with the change as long as I'm able to
> review and try it out :-) Sorry for the dull tone!

I mean refined change after this revert has been applied.

/Jarkko
