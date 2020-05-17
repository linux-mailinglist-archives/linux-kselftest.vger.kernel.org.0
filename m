Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0229E1D64E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 May 2020 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEQAZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 May 2020 20:25:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14895 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgEQAZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 May 2020 20:25:12 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec083dc0000>; Sat, 16 May 2020 17:22:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 16 May 2020 17:25:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 16 May 2020 17:25:11 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 17 May
 2020 00:25:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 17 May 2020 00:25:11 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec084670000>; Sat, 16 May 2020 17:25:11 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Brian Geffon <bgeffon@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] selftests/vm: .gitignore fixes for mmotm
Date:   Sat, 16 May 2020 17:25:08 -0700
Message-ID: <20200517002509.362401-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589674972; bh=qADLUQVy79HVUPxfNDQMO0S0+o9/k5PXnprzBUKhuwk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=eWarx1p3DEBxv24yk6CjiTnOR1lc3u+FrCaWRPoVR3pAQ2HEYNHQ8lzzT8I1xVLg7
         55yV+BzNNAORHJIMFOodOY/KOR+Hw9xc+YMHW0456bvTsWw+I+y21h307ZrhzNPPc/
         mAAEBzGEBRKB+IuMxUABihpsJToBgCo6WsTu/sj5ItPDMieJVEtL9MsVyQfan5mFMV
         7WmXHkgluC026bhLKwK6gwFjObv0o1g6NKkyjldZzLcO6LtXkiafkLzV4KvoRGODvS
         BIgGubAg+LCkO48E1JfKNoow14DetJOcdo+muxZoo99lcSjs/WVXxR/5QxNsvWAS/s
         xiPYFZuNPGuXw==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These apply to today's mmotm. Some merge notes:

* The missing item ("mremap_dontunmap") at the *top* of .gitignore
  for this patch will also being applied to linux.git in a separate
  patch [1].

  The other missing item ("khugepaged") is added to *bottom* of
  .gitignore. This approach allows merging to work without manual
  intervention in this case.

[1] https://lore.kernel.org/r/20200517001245.361762-3-jhubbard@nvidia.com

John Hubbard (1):
  selftests/vm/.gitignore: add khugepaged, mremap_dontunmap

 tools/testing/selftests/vm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 2bbf0589bfeb27800c730b76eacf34528eee5418
--=20
2.26.2

