Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E8971FEBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 12:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjFBKQb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 06:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjFBKQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 06:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E30E7
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Jun 2023 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPvme/9+RDZ+9w0fYgLw3wyLzBbpYxFjL26wqZOhscw=;
        b=WEQsl9T0eIBrIHOzjFeW1b+jJ+lO5FZLNv5netpkSbEB9orxaDpEKykUe5ejjtYptG6l0R
        81gumJOSqvSqDjdY0rW/Bp0hLtjT4oJAKjySIZOGIffvxecNNFG+YWMXuI+ZUk3BxVoc4U
        gGq+LCbJFnoz16HsWQMsMBwk49yR6qk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-iFeVIj9ZPQW5ZHdtq-nVmg-1; Fri, 02 Jun 2023 06:15:46 -0400
X-MC-Unique: iFeVIj9ZPQW5ZHdtq-nVmg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4ecb00906d0so1452600e87.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jun 2023 03:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700944; x=1688292944;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPvme/9+RDZ+9w0fYgLw3wyLzBbpYxFjL26wqZOhscw=;
        b=DGSvoFtRyZltuWg45w3iYO2PDsvSVATWFg17olaKJnJQ+hOsu60s9IGUzZb115KRUL
         Pcq2jfAhjKlxNGcn5JgxwBLXLYcPS2wy6gVANQ4Y+hPRxgig03bCmTX3tyUhqj5MTdgb
         XZPP+/Ergd2wJJ85VCPembyxGGF8/DosCFnhTepNDGOnDkonAwMge1XH1Dty1Ku9ddgO
         9H0sCJpD9jcrzCH5dJJutCEZb48WyowIaWWkI5dYU+ankGaWJUv3s/Es2UxbajhL05BQ
         J0QiB5CCHxGDnnP7YwWubimaDcfrKIiocn5mtbzLJPgJ9lsB3GD1sDYAXq5N0s7X62Nd
         CJxg==
X-Gm-Message-State: AC+VfDzvFQf20LSNO+9LkQ51PXD2jBCWUHIEPOoJxEi1zEPqE1xoYaC0
        j27HKNriFGMg7yylb6PEHmixx3zpWZDzJOIgRuzZ8EDhI71G15dzvBf8B0E9My7Us0yoGCzPDQe
        G7TlEgCydwzE4cO4MY9nmOfuvdUx4
X-Received: by 2002:ac2:532d:0:b0:4ec:8a12:9e70 with SMTP id f13-20020ac2532d000000b004ec8a129e70mr1334467lfh.46.1685700944737;
        Fri, 02 Jun 2023 03:15:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IemvF/IUVgg95b8zFHrHq1WWMIhPUj3/5NhLu7ZmNjrVXcZp17cOt/tYACTTH5SJF+gqVJg==
X-Received: by 2002:ac2:532d:0:b0:4ec:8a12:9e70 with SMTP id f13-20020ac2532d000000b004ec8a129e70mr1334465lfh.46.1685700944385;
        Fri, 02 Jun 2023 03:15:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003f4e3ed98ffsm1446681wmb.35.2023.06.02.03.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:15:43 -0700 (PDT)
Message-ID: <4faf7915-761c-c471-399f-3fcdfc208fd8@redhat.com>
Date:   Fri, 2 Jun 2023 12:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/12] selftests/mm: set -Wno-format-security to avoid
 uffd build warnings
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-8-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-8-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> The uffd_test_start() is perhaps a little too elaborate about how it
> dispatches tests, leading to a clang warning that looks roughly like
> this:
> 
> "uffd-unit-tests.c:1198:20: warning: format string is not a string literal
> (potentially insecure) [-Wformat-security] ...note: treat the string as
> an argument to avoid this.
>      uffd_test_start(test_name);
> "
> 
> However, it doesn't seem worth it to rewrite the way uffd_test_start()
> works, given that these tests are already deeply unsafe to begin with.
> 
> Fix this by just disabling the compiler warning, but only for
> uffd-unit-tests.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/mm/Makefile | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 23af4633f0f4..473bf1811552 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -170,6 +170,8 @@ $(OUTPUT)/ksm_tests: LDLIBS += -lnuma
>   
>   $(OUTPUT)/migration: LDLIBS += -lnuma
>   
> +$(OUTPUT)/uffd-unit-tests: CFLAGS += -Wno-format-security
> +
>   local_config.mk local_config.h: check_config.sh
>   	/bin/sh ./check_config.sh $(CC)
>   

Maybe the following will silence the warning by removing test_name
completely:


---
  tools/testing/selftests/mm/uffd-unit-tests.c | 5 +----
  1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 269c86768a02..15c76ce972be 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1149,7 +1149,6 @@ int main(int argc, char *argv[])
  	uffd_test_case_t *test;
  	mem_type_t *mem_type;
  	uffd_test_args_t args;
-	char test_name[128];
  	const char *errmsg;
  	int has_uffd, opt;
  	int i, j;
@@ -1192,10 +1191,8 @@ int main(int argc, char *argv[])
  			mem_type = &mem_types[j];
  			if (!(test->mem_targets & mem_type->mem_flag))
  				continue;
-			snprintf(test_name, sizeof(test_name),
-				 "%s on %s", test->name, mem_type->name);
  
-			uffd_test_start(test_name);
+			uffd_test_start("%s on %s", test->name, mem_type->name);
  			if (!uffd_feature_supported(test)) {
  				uffd_test_skip("feature missing");
  				continue;


Still gives me

Testing register-ioctls on anon... done
Testing register-ioctls on shmem... done
Testing register-ioctls on shmem-private... done
Testing register-ioctls on hugetlb... skipped [reason: memory allocation failed]
Testing register-ioctls on hugetlb-private... skipped [reason: memory allocation failed]
...

-- 
Thanks,

David / dhildenb

