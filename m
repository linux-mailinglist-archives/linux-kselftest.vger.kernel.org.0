Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3D88BE89
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 18:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfHMQ2J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 12:28:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfHMQ2J (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 12:28:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C99A337;
        Tue, 13 Aug 2019 09:28:09 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A68513F706;
        Tue, 13 Aug 2019 09:28:08 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:28:06 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 11/11] kselftest: arm64: fake_sigreturn_misaligned_sp
Message-ID: <20190813162806.GJ10425@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-12-cristian.marussi@arm.com>
 <8811be0d-efb3-b6da-9f6b-acaeb3edce7d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8811be0d-efb3-b6da-9f6b-acaeb3edce7d@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 07, 2019 at 05:04:13PM +0100, Cristian Marussi wrote:
> On 02/08/2019 18:03, Cristian Marussi wrote:
> > Added a simple fake_sigreturn testcase which places a valid
> > sigframe on a non-16 bytes aligned SP.
> > fake_sigretrun() helper function has been patched accordingly
> > to support placing a sigframe on a non-16 bytes aligned address.
> > Expects a SIGSEGV on test PASS.
> > 
> > Adds also a test TODO lists holding some further test ideas.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > Re-added this text after fixing the forced misaglinment procedure in
> > fake_sigreturn() itself: require a ZERO alignment and you'll get
> > your sigframe placed on a misaligned SP (2-bytes off the 16-align)
> > ---
> >  .../testing/selftests/arm64/signal/signals.S  | 21 +++++++++----
> >  .../arm64/signal/testcases/TODO.readme        |  8 +++++
> >  .../testcases/fake_sigreturn_misaligned_sp.c  | 30 +++++++++++++++++++
> >  3 files changed, 53 insertions(+), 6 deletions(-)
> >  create mode 100644 tools/testing/selftests/arm64/signal/testcases/TODO.readme
> >  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_misaligned_sp.c
> > 
> 
> When this test was re-added in V3, the related .gitignore was missed.
> It will go in V4

Ack, or otherwise try switching to using wildcards in .gitignore as
suggested in my reply to patch 4.

[...]

Cheers
---Dave
