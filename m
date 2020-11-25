Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067282C3F6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Nov 2020 12:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgKYL6H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Nov 2020 06:58:07 -0500
Received: from ozlabs.org ([203.11.71.1]:49073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgKYL6H (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Nov 2020 06:58:07 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsw4TNYz9sVx; Wed, 25 Nov 2020 22:57:55 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     joe.lawrence@redhat.com, mbenes@suse.cz,
        mathieu.desnoyers@efficios.com, benh@kernel.crashing.org,
        shuah@kernel.org
In-Reply-To: <20201023024539.9512-1-po-hsu.lin@canonical.com>
References: <20201023024539.9512-1-po-hsu.lin@canonical.com>
Subject: Re: [PATCHv2] selftests/powerpc/eeh: disable kselftest timeout setting for eeh-basic
Message-Id: <160630540002.2174375.2388323036006565077.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:55 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 23 Oct 2020 10:45:39 +0800, Po-Hsu Lin wrote:
> The eeh-basic test got its own 60 seconds timeout (defined in commit
> 414f50434aa2 "selftests/eeh: Bump EEH wait time to 60s") per breakable
> device.
> 
> And we have discovered that the number of breakable devices varies
> on different hardware. The device recovery time ranges from 0 to 35
> seconds. In our test pool it will take about 30 seconds to run on a
> Power8 system that with 5 breakable devices, 60 seconds to run on a
> Power9 system that with 4 breakable devices.
> 
> [...]

Applied to powerpc/next.

[1/1] selftests/powerpc/eeh: disable kselftest timeout setting for eeh-basic
      https://git.kernel.org/powerpc/c/f5eca0b279117f25020112a2f65ec9c3ea25f3ac

cheers
