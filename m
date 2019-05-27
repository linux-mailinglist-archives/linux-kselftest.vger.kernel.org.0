Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9974C2B841
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2019 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0PTO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 May 2019 11:19:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39178 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfE0PTD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 May 2019 11:19:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so9270921pgi.6;
        Mon, 27 May 2019 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wKRYLSYKzE2k4jFHpZmRlCn5LnNbsStdg5D8PnYwlpE=;
        b=q7Xd8Lebsp1l3HocpLrwjIl0tM4rnRkL6po/MBApZ5k16ZVpXwa4aXsP2VNvOuIuXC
         Je4JosdBHlyx8uMt4k0yidbWD72peNmSMiPm4ioIz7N3PqL2WyXC6FdfhfzpNsoELPOi
         rdwNK8SSP0FYy2TMNgByTWF2eOkEeRYpCuTuvQi1llZE/XWNVqi2piTU6d3ySUaozZQI
         2phU5bXOWeGHfHexudFhebBo5tMjRtaVpjsH7kQSNI/U5n2IVU6+/kriyR2M2qnFRYdw
         y0qXo387I9QuTRjr0s4eQkSkYkCBCffEdn7iXisSGENViN37J+bJB2FuHkMrP1gT4U96
         v/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wKRYLSYKzE2k4jFHpZmRlCn5LnNbsStdg5D8PnYwlpE=;
        b=RJk9070P9764wT5R6f23J9cyT/k4sAtkCyGJFMlACfogUoQVr5tSQ43v2y01duSW+Z
         HMwaif20dIhT7lYEeG89LDCCWd2n6T4ZscehOE3/BzbQ8IQSvDxjaseKIicaWOlvXxuI
         sNdOm+gt7h0ibbTUNP0eHd/6gvjHCjdnEKH1WdHE6dTVWwgFF6eOfHksR2EFE42x2exx
         j1fou4k4dhEnBVl/21nmKV3Aa9Mf4n0+5OLgrfPbF58qeYdLk9g+nF5gUDohOB95wee/
         /9ZaU2wOsJ92HZnXBPmUWeVcg7Xzk9M1A9pq6fO0wgzEfSZc/Vyil/406AIpk90HLze6
         GVYA==
X-Gm-Message-State: APjAAAUdRZSP/GloaIKjJtiUBxZKdiCJ0Fnb18u5D+8HGZG3ut1e8JJ+
        FS459EaY4hrWqbqqEXP/GSeEOrLP
X-Google-Smtp-Source: APXvYqxMehS8QCzhcyqJ0WLGpmftug/4/G3fWnhju+fhqevVuE4AIJsX7qwJq+1QrO00UWRwmm2wMw==
X-Received: by 2002:a17:90b:14e:: with SMTP id em14mr32106670pjb.19.1558970341885;
        Mon, 27 May 2019 08:19:01 -0700 (PDT)
Received: from ip-172-31-44-144.us-west-2.compute.internal (ec2-54-186-128-88.us-west-2.compute.amazonaws.com. [54.186.128.88])
        by smtp.gmail.com with ESMTPSA id f20sm93168pgf.59.2019.05.27.08.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 08:19:00 -0700 (PDT)
Date:   Mon, 27 May 2019 15:18:59 +0000
From:   Alakesh Haloi <alakesh.haloi@gmail.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH] userfaultfd: selftest: fix compiler warning
Message-ID: <20190527151859.GA3217@ip-172-31-44-144.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fixes following compiler warning

userfaultfd.c: In function ‘usage’:
userfaultfd.c:126:2: warning: format not a string literal and no format
	arguments [-Wformat-security]
  fprintf(stderr, examples);

Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 5d1db824f73a..b3e6497b080c 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -123,7 +123,7 @@ static void usage(void)
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
 		"hugetlb_shared, shmem\n\n");
 	fprintf(stderr, "Examples:\n\n");
-	fprintf(stderr, examples);
+	fprintf(stderr, "%s", examples);
 	exit(1);
 }
 
-- 
2.17.1

