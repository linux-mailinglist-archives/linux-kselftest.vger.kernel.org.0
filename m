Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1F1ACE36
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Apr 2020 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgDPRBO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Apr 2020 13:01:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:59583 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbgDPRBN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Apr 2020 13:01:13 -0400
IronPort-SDR: +craSK3CPgv65dn5NHFF5BSkUzcW5YwxmtXrhkK651na5NR7L/bDcF94zwlihBUTiLt2fcP3AN
 iA6uc1jFoZfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 10:01:11 -0700
IronPort-SDR: Ex3s0ieIv57jgUalA6qTy12II0DVlueLaxt/cd9TH3ihZuVMBR+zkD1RImWcSchrMlXJsuYqFc
 FyrfatnGa6EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="246044853"
Received: from otazetdi-mobl.ccr.corp.intel.com (HELO localhost) ([10.249.42.128])
  by fmsmga008.fm.intel.com with ESMTP; 16 Apr 2020 10:01:09 -0700
Date:   Thu, 16 Apr 2020 20:01:08 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "Kernel selftests: tpm2: check for tpm support"
Message-ID: <20200416170108.GB199110@linux.intel.com>
References: <20200412142309.71807-1-jarkko.sakkinen@linux.intel.com>
 <3921a93f-120c-0201-4af5-591bf4e6a0b0@kernel.org>
 <20200414193722.GD13000@linux.intel.com>
 <20200414193800.GE13000@linux.intel.com>
 <ac896427-581d-6fd0-e088-3bc519b6ed66@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac896427-581d-6fd0-e088-3bc519b6ed66@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 14, 2020 at 02:52:12PM -0600, shuah wrote:
> On 4/14/20 1:38 PM, Jarkko Sakkinen wrote:
> > On Tue, Apr 14, 2020 at 10:37:25PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Apr 14, 2020 at 09:12:05AM -0600, shuah wrote:
> > > > On 4/12/20 8:23 AM, Jarkko Sakkinen wrote:
> > > > > This reverts commit b32694cd0724d4ceca2c62cc7c3d3a8d1ffa11fc.
> > > > > 
> > > > > The original comment
> > > > 
> > > > commit I assume.
> > > > 
> > > >   was neither reviewed nor tested. Thus, this the
> > > > > *only* possible action to take.
> > > > > 
> > > > 
> > > > Bummer. I will apply this right away.
> > > 
> > > No worries, and fine with the change as long as I'm able to
> > > review and try it out :-) Sorry for the dull tone!
> > 
> 
> I usually wait for test authors to do the review. This patch
> was sent a while back and I ended up picking it up. It stayed
> in next for a while. It is fixed now.
> 
> > I mean refined change after this revert has been applied.
> > 
> Of course. I applied your revert to for my next pull request
> to linux-kselftest next
> 
> thanks,
> -- Shuah

Thanks.

/Jarkko
