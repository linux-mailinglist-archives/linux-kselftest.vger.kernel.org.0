Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FEA4E619
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2019 12:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfFUKem (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jun 2019 06:34:42 -0400
Received: from foss.arm.com ([217.140.110.172]:57924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFUKel (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jun 2019 06:34:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36529142F;
        Fri, 21 Jun 2019 03:34:41 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 680EF3F718;
        Fri, 21 Jun 2019 03:34:40 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:34:38 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
Subject: Re: [PATCH 00/13] Add arm64/signal initial kselftest support
Message-ID: <20190621103438.GH2790@e103592.cambridge.arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613111335.7645-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 12:13:22PM +0100, Cristian Marussi wrote:
> Hi
> 
> this patch aims to add the initial arch-specific arm64 support to
> kselftest starting with signals-related test-cases.
> A common internal test-case layout is proposed which then it is
> anyway wired-up to the toplevel kselftest Makefile, so that it
> should be possible at the end to run it on an arm64 target in the
> usual way with KSFT.
> 
> ~/linux# make TARGETS=arm64 kselftest

Looks like a good initial set of dests overall.  There are various
details that need attention, but once those are sorted out I think this
will be a decent base to build more tests on in the future.

See comments on the individual patches.

[...]

Cheers
---Dave
