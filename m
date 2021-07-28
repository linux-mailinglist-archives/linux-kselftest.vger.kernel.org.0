Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930103D9355
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhG1Qil (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 12:38:41 -0400
Received: from foss.arm.com ([217.140.110.172]:60614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhG1Qik (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 12:38:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E3326D;
        Wed, 28 Jul 2021 09:38:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26EE43F70D;
        Wed, 28 Jul 2021 09:38:38 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:37:17 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210728163716.GG1724@arm.com>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-4-broonie@kernel.org>
 <20210728094158.GC1724@arm.com>
 <20210728125918.GD4670@sirena.org.uk>
 <20210728134405.GF1724@arm.com>
 <20210728162953.GF4670@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728162953.GF4670@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 05:29:53PM +0100, Mark Brown wrote:
> On Wed, Jul 28, 2021 at 02:44:07PM +0100, Dave Martin wrote:
> 
> > This might be a bit clearer if the setup code was clearly separate from
> > the tests, but so long as the ordering requirements are clearly
> > documented that seems reasonably OK.
> 
> We can't really split the setup code out since the setup code would have
> to rely on one of the ABIs we're trying to test which is all fine and
> good until the tests actually help us catch something, we have to build
> up knowledge of the values as we go and hope that the cross checking we
> end up with helps us at least catch inconsistencies.

Ack.  The setup code could be defensive, but you would in effect be
doing some of the tests twice then.  Or the fact that the setup code
is "separate" from the tests might be a bit of an illusion.

Cheers
---Dave
