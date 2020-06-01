Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6E1EA311
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFALsX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 07:48:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:33104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALsX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 07:48:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7EFFEAD5F;
        Mon,  1 Jun 2020 11:48:23 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:48:21 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Yannick Cote <ycote@redhat.com>
cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        joe.lawrence@redhat.com
Subject: Re: [PATCH 0/4] selftests/livepatch: rework of
 test-klp-{callbacks,shadow_vars}
In-Reply-To: <20200528134849.7890-1-ycote@redhat.com>
Message-ID: <alpine.LSU.2.21.2006011347250.2043@pobox.suse.cz>
References: <20200528134849.7890-1-ycote@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1678380546-1074926875-1591012101=:2043"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678380546-1074926875-1591012101=:2043
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 28 May 2020, Yannick Cote wrote:

> The test-klp-callbacks change implement a synchronization replacement of
> initial code to use completion variables instead of delays. The
> completion variable interlocks the busy module with the concurrent
> loading of the target livepatch patches which works with the execution
> flow instead of estimated time delays.
> 
> The test-klp-shadow-vars changes first refactors the code to be more of
> a readable example as well as continuing to verify the component code.
> The patch is broken in two to display the renaming and restructuring in
> part 1 and the addition and change of logic in part 2. The last change
> frees memory before bailing in case of errors.

With the small comments, I made, fixed

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
--1678380546-1074926875-1591012101=:2043--
