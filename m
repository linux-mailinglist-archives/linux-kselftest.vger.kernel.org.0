Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173E8269B1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 03:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIOB3S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Sep 2020 21:29:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10927 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIOB3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Sep 2020 21:29:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6018520001>; Mon, 14 Sep 2020 18:26:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 18:29:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 14 Sep 2020 18:29:03 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 01:29:02 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 15 Sep 2020 01:29:02 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.52.22]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f6018de0004>; Mon, 14 Sep 2020 18:29:02 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/2] selftests/vm: fix some minor aggravating factors in the Makefile
Date:   Mon, 14 Sep 2020 18:28:59 -0700
Message-ID: <20200915012901.1655280-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600133202; bh=0djzV/LDjmQc0EmERcsWRX2BdMhvHYwhbZYf6UboQaU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=mtdtXYcEh9CMQkeKkVZq4XA41wpSDBcY3Z827QcXQumR8D/AqUL6PHSPJgvcc7fIH
         2j/wUnEvAlvHN7Pp5UoLGKmm0FT8gBTt2d1jJ0S8hScn7AfxXHiOPJLmh+4zKa6Pq3
         VOkaWFC24RjCCZ1NrMbMByPbav7MofKO6Y3jxt4oDvsw3e3fDF7qJlCdbqQXR+KzUU
         YF9/+VRnfV4rpiWrZz7E0ljfXSLebhiXtTdHfwGAxvhEj8mKB8OB8jyMoaeXTh1TDh
         uZm+5Jv0cSWsz/4G4AjF4hJCthkLILW9YInzmYAMImioVifKKD8k38i/6Xsd961h47
         B6cEArXKhsyyA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This fixes a couple of minor aggravating factors that I ran across while
trying to do some changes in selftests/vm. These are simple things, but
like most things with GNU Make, it's rarely obvious what's wrong until
you understand *the entire Makefile and all of its includes*.

So while there is, of course, joy in learning those details, I thought I'd
fix these little things, so as to allow others to skip out on the Joy if
they so choose. :)

First of all, if you have an item (let's choose userfaultfd for an
example) that fails to build, you might do this:

$ make -j32

    # ...you observe a failed item in the threaded output

# OK, let's get a closer look

$ make
    # ...but now the build quietly "succeeds".

That's what Patch 0001 fixes.

Second, if you instead attempt this approach for your closer look (a casual
mistake, as it's not supported):

$ make userfaultfd

    # ...userfaultfd fails to link, due to incomplete LDLIBS

That's what Patch 0002 fixes.

John Hubbard (2):
  selftests/vm: fix false build success on the second and later attempts
  selftests/vm: fix incorrect gcc invocation in some cases

 tools/testing/selftests/vm/Makefile | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--=20
2.28.0

