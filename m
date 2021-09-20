Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62346411475
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Sep 2021 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhITMbt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Sep 2021 08:31:49 -0400
Received: from foss.arm.com ([217.140.110.172]:46778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238240AbhITMbs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Sep 2021 08:31:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10A4111B3;
        Mon, 20 Sep 2021 05:30:22 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AEDA3F719;
        Mon, 20 Sep 2021 05:30:20 -0700 (PDT)
Date:   Mon, 20 Sep 2021 13:30:14 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] kselftest/arm64: signal: Skip tests if required features
 are missing
Message-ID: <20210920123014.GA6510@e120937-lin>
References: <20210920121228.35368-1-cristian.marussi@arm.com>
 <20210920122240.GE4192@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920122240.GE4192@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 20, 2021 at 01:22:40PM +0100, Mark Brown wrote:
> On Mon, Sep 20, 2021 at 01:12:28PM +0100, Cristian Marussi wrote:
> > During initialization of a signal testcase, features declared as required
> > are properly checked against the running system but no action is then taken
> > to effectively skip such a testcase.
> 
> Reviwed-by: Mark Brown <broonie@kernel.org>
> 
> I have a version of this locally which I thought I'd sent out already
> among all the in flight patches I've got for kseltest but it looks like
> it didn't make it.

Ah ok sorry, I did not know. Pick either as you wish.

Thanks,
Cristian

