Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481E28BE57
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2019 18:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfHMQW6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Aug 2019 12:22:58 -0400
Received: from foss.arm.com ([217.140.110.172]:39878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbfHMQW6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Aug 2019 12:22:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D329337;
        Tue, 13 Aug 2019 09:22:57 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFD1B3F706;
        Tue, 13 Aug 2019 09:22:56 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:22:54 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH v3 00/11] Add arm64/signal initial kselftest support
Message-ID: <20190813162254.GX10425@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802170300.20662-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 02, 2019 at 06:02:49PM +0100, Cristian Marussi wrote:
> Hi
> 
> this patchset aims to add the initial arch-specific arm64 support to
> kselftest starting with signals-related test-cases.
> A common internal test-case layout is proposed which then it is anyway
> wired-up to the toplevel kselftest Makefile, so that it should be possible
> at the end to run it on an arm64 target in the usual way with KSFT.

The tests look like a reasonable base overall and something that we can
extend later as needed.

There are various minor things that need attention -- see my comments on
the individual patches.  Apart for some things that can be factored out,
I don't think any of it involves redesign.


A few general comments:

 * Please wrap all commit messages to <= 75 chars, and follow the other
   guidelines about commit messages in
   Documentation/process/submitting-patches.rst).

 * Remember to run scripts/checkpatch.pl on your patches.  Currently
   various issues are reported: they should mostly be trivial to fix.
   checkpatch does report some false positives, but most of the warnings
   I see look relevant.

 * If you like, you can add an Author: line alongside the copyright
   notice in new files that you create.  (You'll see this elsewhere in
   the kernel if you grep.)

One general stylistic issue (IMHO):

 * Try to avoid inventing names for things that have no established
   name (for example "magic0" to mean "magic number 0").

   The risk is that the reader wastes time grepping for the definition,
   when really the text should be read at face value.  It's best to use
   all caps just for #define names, abbreviations, and other things
   that are customarily capitalised (like "CPU" etc.).  Other words
   containing underscores may resemble variable / function names, and
   may cause confusion of there is no actual variable or function with
   that name.

   I don't think it's worth heavily reworking the patches for this, but
   it's something to bear in mind.

[...]

Cheers
---Dave
