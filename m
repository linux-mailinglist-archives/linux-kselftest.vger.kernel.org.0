Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871D027B688
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgI1Up6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:45:58 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6258 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgI1Up6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:45:58 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f724b220000>; Mon, 28 Sep 2020 13:44:18 -0700
Received: from [10.2.53.30] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Sep
 2020 20:45:57 +0000
Subject: Re: [PATCH 8/8] selftests/vm: hmm-tests: remove the libhugetlbfs
 dependency
From:   John Hubbard <jhubbard@nvidia.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
References: <20200928062159.923212-1-jhubbard@nvidia.com>
 <20200928062159.923212-9-jhubbard@nvidia.com>
 <20200928130245.GQ9916@ziepe.ca>
 <982fd9bf-64cb-00e9-f092-13849c7cf7d9@nvidia.com>
Message-ID: <de7ddfb6-e0f8-f70c-f38b-127ec6b54591@nvidia.com>
Date:   Mon, 28 Sep 2020 13:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <982fd9bf-64cb-00e9-f092-13849c7cf7d9@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601325858; bh=ZNzUuJga0yAMPUYJp+Mbsk5gWocHn8PGlFF35AeQU6M=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=m5IQA3iWGf+mZlD+saPKKaP+GSN4PkecL44skN/WMfHCWeNk37hDn5PMtercS3tK6
         Lp2QQuHA9Xj/xMMew2SGfA2kmICe2T0+C2xOut+GVKNp7iBo9QVJ+B6ZTiCBWwct88
         T8nBnsGvpfQ0Tv2rc+csXV/eiQOABg6g4J0ThvAIFFQIAE/Gs9RyB7niQarYyAe+HZ
         QUn0TG+3k8nyf5xQHK59lujZJH/Y3S5qtFqWhA6+9CnsqRq0d9y3dntQbiaKDZ7p1n
         uq8HRKBsBnaiNvulGdhSjuQVJLSLijDk44AC0NT7oB/9lsTgiZ52taQi/N8J9UtfH5
         WACzwgevzothA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/20 1:18 PM, John Hubbard wrote:
> On 9/28/20 6:02 AM, Jason Gunthorpe wrote:
>> On Sun, Sep 27, 2020 at 11:21:59PM -0700, John Hubbard wrote:
> ...
>>> +gcc -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
>>
>> This gcc has to come from some makefile variable
  I plan on posting a v2 with this additional change, to fix the above point:

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 986a90fa9653..019cbb7f3cf8 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -138,7 +138,7 @@ $(OUTPUT)/hmm-tests: local_config.h
  $(OUTPUT)/hmm-tests: LDLIBS += $(HMM_EXTRA_LIBS)

  local_config.mk local_config.h: check_config.sh
-	./check_config.sh
+	./check_config.sh $(CC)

  EXTRA_CLEAN += local_config.mk local_config.h

diff --git a/tools/testing/selftests/vm/check_config.sh b/tools/testing/selftests/vm/check_config.sh
index 651a4b192479..079c8a40b85d 100755
--- a/tools/testing/selftests/vm/check_config.sh
+++ b/tools/testing/selftests/vm/check_config.sh
@@ -16,7 +16,8 @@ echo "#include <sys/types.h>"        > $tmpfile_c
  echo "#include <hugetlbfs.h>"       >> $tmpfile_c
  echo "int func(void) { return 0; }" >> $tmpfile_c

-gcc -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1
+CC=${1:?"Usage: $0 <compiler> # example compiler: gcc"}
+$CC -c $tmpfile_c -o $tmpfile_o >/dev/null 2>&1

  if [ -f $tmpfile_o ]; then
      echo "#define LOCAL_CONFIG_HAVE_LIBHUGETLBFS 1" > $OUTPUT_H_FILE



thanks,
-- 
John Hubbard
NVIDIA
