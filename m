Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8B280E71
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJBIGY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 04:06:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5864 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBIGY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 04:06:24 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f76df180001>; Fri, 02 Oct 2020 01:04:40 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 08:06:24 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 2 Oct 2020 08:06:24 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] selftests/vm: 8x compaction_test speedup
Date:   Fri, 2 Oct 2020 01:06:20 -0700
Message-ID: <20201002080621.551044-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601625881; bh=vUXAAb8HavehIjFccK2mjuy0/N7DBaFYiPYNqXuk2Ec=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=eaAJEDYHeLpHg+VyuGqjO1gSSpyXTgzp2JSOjhnlE0EuB1CI0hs++kjw3CMK8TkFO
         cnq3xu7e3lo+aFJknfyL4vkpSmfbQ/NsaewiQesdiYBXfY2Uq6d1Vs5VlKWtlCfBSx
         3DNRFXXI4TrI5mwB6HdWVnc7nIC8vTT71eIrdefBiX3bbxy/Oovxybbj0dWtOCA9vA
         GNyvIeOJ7wuRtpAj1N9G1GalpY+Ifgm4Wzg3X4soZbS2Lxfm69tV7f15N4hxQsyFpt
         eLiXWYxyeSW51qh+89BorlD82dI/Mssm/ICgMHSMDYYtOAwZ+icj3ciyFU2olSr2jY
         zdyCmyF1j+Y9Q==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

Maybe this should really be an RFC, given that I don't fully understand
why the compaction_test.c program was mmap'ing 1 MB at a time. So
apologies in advance if I've mucked up something important, but if so,
maybe we can still find a way to get this fixed up to something better.

Anyway: there are 20+ tests in tools/testing/selftests/vm/. The entire
running time for these (via run_vmtest.sh) is about 56 seconds, of which
over half is due to just one test: compaction_test, which takes 27 sec!
(A runner-up is HMM, at 11 sec, so it's up for a look next.) The other
tests mostly take a few ms, and a few take 1.0 sec.

This drops the compaction_test run time from 27, to 3.3 sec. Enjoy. :)

thanks,
John Hubbard
NVIDIA

John Hubbard (1):
  selftests/vm: 8x compaction_test speedup

 tools/testing/selftests/vm/compaction_test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--=20
2.28.0

