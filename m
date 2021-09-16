Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A97640DC72
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbhIPOLG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 10:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236328AbhIPOLG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 10:11:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59E9160238;
        Thu, 16 Sep 2021 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631801385;
        bh=JSVAyZlj7EFaNRDNJV5SQUCEv0kAxzwlmnzQyh2xd00=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HvrpYOLJC2Li+zPYNRshCCf9T6Q72DMytidkaG2MJOQgRmlqCuwKjHVGOHfPpeJlH
         px1pxbidskVQey0HE2pQLslzZwKrXAC9cmD9+Gn5u6hGRUm6ui2HmnSsXPOEvipfX0
         QrsDpA8OXqScfjtYF9bgfXtQ0SJq3hv66KKPYMUZtqcfFT5n+5mGyV3rnyiB9+Lafo
         ZGgTwnCohPIn/a2AFuTgnlZPf2ZctZrHM+5WJeJWF8jmUG1xayo8Ut8vhyq8QImVnW
         NXMpCd0G6GEqrH+R2HulZYSWoqYkRWx2l1sCDT8C1YeE3/SQlRGKNB0J1y35q4ULo8
         9/PPjBcI2Uq2g==
Message-ID: <6f3cc681e10877e639b882eaabf1a5e21bd2fc94.camel@kernel.org>
Subject: Re: [PATCH 02/14] x86/sgx: Add /sys/kernel/debug/x86/sgx_total_mem
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     seanjc@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 16 Sep 2021 17:09:43 +0300
In-Reply-To: <086aa5a16faf0d9b47ba9e0ebd2213713d0e76ff.1631731214.git.reinette.chatre@intel.com>
References: <cover.1631731214.git.reinette.chatre@intel.com>
         <086aa5a16faf0d9b47ba9e0ebd2213713d0e76ff.1631731214.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2021-09-15 at 13:30 -0700, Reinette Chatre wrote:
> From: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> Just like normal memory, SGX memory can be overcommitted.  SGX has its
> own reclaim mechanism which kicks in when physical SGX memory (Enclave
> Page Cache / EPC) is exhausted.  That reclaim mechanism is relatively
> rarely exercised and needs selftests to poke at it.
>=20
> The amount of EPC on the system is determined by the BIOS and it varies
> wildly between systems.  It can be dozens of MB on desktops, or many GB
> on servers.
>=20
> To run in a reasonable amount of time, the selftest needs to know how
> much EPC there is in the system.
>=20
> Introduce a new debugfs file to export that information.
>=20
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> [reinette: Use as placeholder patch until other discussions complete]
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

This could be replaced with the following two patches:

https://lore.kernel.org/linux-sgx/20210914030422.377601-1-jarkko@kernel.org=
/T/#t

I forgot to CC this to you when I sent it, sorry about that.

/Jarkko

