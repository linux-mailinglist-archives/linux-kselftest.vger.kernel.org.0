Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E056859A9FC
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 02:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244880AbiHTAOO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 20:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244299AbiHTAON (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 20:14:13 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC04E875;
        Fri, 19 Aug 2022 17:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JihxgWR8J4QxOI3+XneqEq4N6mDfW+ekbt4JzX6wp259Lml/Edp7+RhURYovE9zPG7VEYorFc4hr0Fuq2lyQTWPK9VdKpDNJSur/DRpRYWSgNc/qXtSay68hmPI8i7q1WxduIw/CPFzKWM72OxDQ0Zkt9WT2c143lXYsclk5iY/3KN8vpR1SGxAdB2wDyPjYVvIzZtGRL4YPsYoHcuJyudmajnsdAp/HQUrMzZJBvsn5QR4HqASp9wCC3YHJy4A/bb+mQT+R96UfdPISomlVE65vPDDgd2GEyBFjpowu7S0bSt8gJmMoG2qeuN1WkUW5awDqASAegVUM8ET8S17ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWZol1S8wksbAdUAgv1sWZ2nTtSKCrOgqvGVel4v5Ak=;
 b=Y7hTsGcrrXxdSshQGlKDCnc5QHR1XS45OnrSpy09SD16LbYO/x0C/BqTsbVIdsjrN1QiezD3KWlNx20hDuHvX/dXlDc3fCOLcji3mm8Ow32GBL5MNcSBI8RZAULYH1XkoNOB4tSTgAs3dyZYo6LShh1mws84qL0NtgLmhIfkl6RJ5mcXxSmwTIJTgloiJIPlbIS2MGfabTpfTUuclMN4wGPj7Ek2GO/ieqfYIgxdZkWdiAYQSn/y6CzWqWJRGMZ4wEftgkeCIgcNsLX/rFbZElUK5cms84n1kpU33XTYtGuTvFQfANqioWePnbd57qhUWYyGlE3QYCEjx329zR5LNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWZol1S8wksbAdUAgv1sWZ2nTtSKCrOgqvGVel4v5Ak=;
 b=QxWB1C2QJRPt0/DuSCZcA3mjgWAVGE8a3gn0deii72+bOB8WFmOf+x7FeNiApA8nIhZ0bSCBLod3kmIGcirOg5l6D87o1nurE+npjdpXewrmuAzMROquH65ryJPr/PqlNs+F3H0/C1CqWi+GRQh6i+NqWfa/qMYcR3yb8C5MyXrKANWaIuZ4hFtC6mZ4pjiRQPU7KzxiItPVRuOx8/doZmJ2/A0HfxOvbA5Pw5VJfNH86A3+jBWC1LLpzsUsUsZsJhJhxMRLT5rvV799zkF9+vY4BTmTGfBA3LQl0HzkLJB2BNmSLCc9YlBBwP6cYpHubGS0YGO+5E58N+h2pKqULA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR12MB1797.namprd12.prod.outlook.com (2603:10b6:903:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sat, 20 Aug
 2022 00:14:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5546.019; Sat, 20 Aug 2022
 00:14:09 +0000
Message-ID: <ddfc77ae-eb64-79cd-ff7b-baa939cc26f2@nvidia.com>
Date:   Fri, 19 Aug 2022 17:14:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] selftests/vm: use top_srcdir instead of
 recomputing relative paths
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220819191929.480108-1-axelrasmussen@google.com>
 <20220819191929.480108-2-axelrasmussen@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220819191929.480108-2-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e93cd70-c049-4c03-8f79-08da8240e756
X-MS-TrafficTypeDiagnostic: CY4PR12MB1797:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBQW3tmSH9QeBFFer8jk8Qmqo3Pfvd8fasoYiYy2kchv++gU70+biKf7s1ZgHOyNF1aDKz9btrMX1WEdowGTfhtfPjyF5MCdSgzZlINeXTJvwBxzIkQpJriNXVPMYhmpBH+0/LQyHPUpjj3kHnqhaapGHG3oXR2dlnq7L7/D/vEUe6tiFjEYXGqavhFP3X9IymiIQbL6/EKhAd35WD8/Y31O7l3pMTvbFgQ0d9au0Jtqps02l89XOYhTVdYxmIfUgWOrDkQSvU3iHh1HewBf1C2OHEwtbnw8mIwsD7S0HSVN64mRQm5NIUqenUBrE+8e1pWGc8vpR2/teqPY67twhQ4ocrOkrjE17K26qm9wJrHL1gCQMp4LLoU7BTCFEVCCith350ZjPyj4Xn4bVbA+tNdCC9Y8mN9pGuA2AJWwF5+M8OM1/S8bcacFSRZUsTKVSOUsvSDJoUFPLPKLV4hGOgtnHxU5A62RqiR6Y2/60Uyqq4ODKqb0EEuIMPzDpLNetH4cIyb0Jbfu4Y9N8E22a31zeNjRb4Z4WRfmUV3HwY1/Xmuvhu2RPC1F1/ACN0zZ0P9cYUOpl10tRa+LfihgdUZtH35FEXDXWic1YRrW9PlZvJQvg6iJsEsTGi4X0Tctmh9a99eDxIqwk85MFy4lKNTaRMgGRGjWNeugOoE/U2Ds0PdUZb5eAW7Hm5W4Des4R0FkdXg5srpZ52rsT+cS+onwMyUOW+0NlDuTbRoBMHUIjpcocM9KYyE20lUYmk6v1N/U01Fa8bIsmxhQxtEuawNYCuZOZNeC7mRNB0P52Vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(478600001)(53546011)(6486002)(6512007)(66946007)(6506007)(8676002)(66476007)(66556008)(41300700001)(31686004)(36756003)(2906002)(86362001)(31696002)(26005)(110136005)(316002)(38100700002)(186003)(83380400001)(2616005)(5660300002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VRd1FSSEtiZ1VCSVZ4OVE3UFhYajd1VC9RVnJzKzRXc21Nd0k2UkdDYWJ5?=
 =?utf-8?B?NFYrM1hFSFJRUHlQZ1FLcVNheUFQdzlxTnY0ZXljbVJuMnBUZTFSVTloSHY2?=
 =?utf-8?B?TlcxcEMvRGNONzFIWDJoTUFpOXNvSzJkWjJweTlMUGJyRmkrZFkrV2RyVDRw?=
 =?utf-8?B?TE5qN2Q3bWtaMWVIcFBGQUJBdnBaRC8yaTJIS3JtOTJ0VEZIZW93WEIzNzRF?=
 =?utf-8?B?dFduZDYrcmZNRHFoM3hNdDRNVWtLRkdzN1ZJTW5DSWhQNGVJQlQ4SHdXQ0pH?=
 =?utf-8?B?UUQ3bkdYaFczVHpBYld1ODh6UzQ1N1UreWIwcUZ1R09LSVpKcXRiMWVSKy9O?=
 =?utf-8?B?MWtlRjhuY1Rwc2FXOUxsWjVjclJqOUJhQWY0TnlQK3lybTNXM1JKc0Q0NTBk?=
 =?utf-8?B?VkloNjBlZzlGVWlibTdTRlhIRzh4MHZYU2dMblEvNUQ2TGE5eE1EcVV4cHkx?=
 =?utf-8?B?WE9CQU5vVEpNMGZqNklNRUdkc0hIME1GMlZoM0RMc1B5a2FRODZYWXBJcG14?=
 =?utf-8?B?cVVNMURvWWNlY1d4OUU1RytyTWdWMUwyUXVUSm9PbUhoRlptYUVaemRlQkV5?=
 =?utf-8?B?ckVaRWpabDlxdm53K0VCbVBtZXBSTW5RZm1SckVzdlJFdTNZMFBsdEhvQ2Z0?=
 =?utf-8?B?dXR5TlIrYjRFNHlYdmVQMGxqZXQ3TThwWFVhK1ZubW1ES2p1bTFpTDAwdUJD?=
 =?utf-8?B?YitGa0E0cDNidkNOT2tDc3YvcGVjdElnOTVxYit3VUdOUERaYXRON3ZacnBL?=
 =?utf-8?B?Mm9hYW92YkdXUHZVVTB3c1VXa3l2Zlh5QWUrZXoweU8wOEFUSDZKK1Y2MFRw?=
 =?utf-8?B?ZUtaRzl1WDk1MGdTVUFIbUliVXlrSGQrbm9TNVRLaU10Q1FhN1dVQU1RTHdx?=
 =?utf-8?B?cS83MXlCQTFPbTc5N3drcGh6QXVJWUlQZnRDdTVNREgwdDVGVllqSzI4cVN1?=
 =?utf-8?B?eTIrelpPUEFINGNwTGpJVmtjVjNOME50YXozWUNTM3ExSktVVjdvTElIa2JZ?=
 =?utf-8?B?eHNVY0N2UjdsZGZVejd6dlJhc2kybTU3alNOcnhZRm9VZDJrbkJVUkc4dk9t?=
 =?utf-8?B?QlVMVy9xaldKWDVGd3JaVWp6SHFwR0g2c2V1ajZkck12eXJlRmlEZ0NaTC9Y?=
 =?utf-8?B?YVBwOGl4SGtXZTB0WENUUG53cStYMFoyVG1MbFVKZm5IL1FuZngvdVFjdjds?=
 =?utf-8?B?cmRpNEl1c3E3MFFESFhQMHFmTE9JZUo1ODBXMG9XVDdzT1Rvcjc2cDRXOTFK?=
 =?utf-8?B?TUZ6cW5Ma0M5cXMrL1oyUDBHT3dnOEsvKzIzSVNDVmcxVUQ2akNDem9YcDQ4?=
 =?utf-8?B?Qitqd3MrcUNEdkVUNmVwdHdjN1hOUUs4bk1jWkk1WWJ4bG9MSzhMTW5Hb0N4?=
 =?utf-8?B?UkhtRkdGU1RRa0QwMnRjdGFVUnhublhOOWVQemhETTBLT0lFYTVwc0hJZURz?=
 =?utf-8?B?eW1RcEZSVEdkeDN2cWNMamUyQmQ5aXhIVi9DSDExUGQ4K0g2WStJV21nUW1F?=
 =?utf-8?B?K1JXUWhiWHcxeDl6NU5WTkN5YWlsWTBTNXJyd2prOVlDVmo1Y2xxRzk4NFlx?=
 =?utf-8?B?MzNQNnpOMTc1ajJJdjRjVGRKRUFUcU5Jbm9tUWxEOUxER1JUOXZ3dEo1RFZy?=
 =?utf-8?B?SERvcERLcDNuVzNVb3daNkFvbHliU2dQRiszdUFXdm1FVk14QW9sSElPeUU0?=
 =?utf-8?B?VUozQXNVMXlnZmZXaFdNQzk1MGRUVVVxOG9GR2pyZlVRTndkbzBhUzBOUlZy?=
 =?utf-8?B?S3pvRWNKZDZ6ZWdCVDc3bHFlUzRJazFrKzFIN3pQRVE0V2h4SEEzRHdSWW43?=
 =?utf-8?B?ZHZmdjFlRC83TE1xazlsZkpoZXVmdVBNQ0hyM3Y1Ly91UElFcGRYKy84b1Mz?=
 =?utf-8?B?WC9kZWNHUi83NUx1REZaTFRhSjhiNjVOVkhxbTViUmkzK2xqVWdiQmwzUDNX?=
 =?utf-8?B?ZXlQd1FtTXg4TEN4Tk9UWFMyQlpBekJGeXM0K2FlNnZvV1RIN1IvQmNMSkZM?=
 =?utf-8?B?YmVvTkpHaW5IMG1BZFdrTUlkbnBNcmlOc0gya1hhL1VsdDVOdTdoZXFJRHJT?=
 =?utf-8?B?VU5FOEo0bkI5ZHJFckpST2ZySElYVERyNnZ5T2tzYzYxcWxQQ2ZtcDV5NnFz?=
 =?utf-8?Q?UGdcqZ/V/2oOkZRKWzg8Vhqtx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e93cd70-c049-4c03-8f79-08da8240e756
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 00:14:09.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aS5j1mQmnvFNtRJRRrNtggjkCSiEAAKoMQmde5d7q11T46wF8HNU4Nhe1h9EQ+667G8+h4ses5v/f0Ff6uMWcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/19/22 12:19, Axel Rasmussen wrote:
> In various places both in t/t/s/v/Makefile as well as some of the test
> sources, we were referring to headers or directories using some fairly
> long relative paths.
> 
> Since we have a working top_srcdir variable though, which refers to the
> root of the kernel tree, we can clean up all of these "up and over"
> relative paths, just relying on the single variable instead.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/vm/Makefile    | 2 +-
>   tools/testing/selftests/vm/gup_test.c  | 2 +-
>   tools/testing/selftests/vm/hmm-tests.c | 4 ++--
>   tools/testing/selftests/vm/ksm_tests.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)


Very nice, thank you for the extra cleanup here.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index d9fa6a9ea584..d516b8c38eed 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -25,7 +25,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>   # LDLIBS.
>   MAKEFLAGS += --no-builtin-rules
>   
> -CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>   LDLIBS = -lrt -lpthread
>   TEST_GEN_FILES = compaction_test
>   TEST_GEN_FILES += gup_test
> diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
> index a309876d832f..e43879291dac 100644
> --- a/tools/testing/selftests/vm/gup_test.c
> +++ b/tools/testing/selftests/vm/gup_test.c
> @@ -10,7 +10,7 @@
>   #include <sys/types.h>
>   #include <pthread.h>
>   #include <assert.h>
> -#include "../../../../mm/gup_test.h"
> +#include <mm/gup_test.h>
>   #include "../kselftest.h"
>   
>   #include "util.h"
> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
> index 529f53b40296..98b949c279be 100644
> --- a/tools/testing/selftests/vm/hmm-tests.c
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -35,8 +35,8 @@
>    * This is a private UAPI to the kernel test module so it isn't exported
>    * in the usual include/uapi/... directory.
>    */
> -#include "../../../../lib/test_hmm_uapi.h"
> -#include "../../../../mm/gup_test.h"
> +#include <lib/test_hmm_uapi.h>
> +#include <mm/gup_test.h>
>   
>   struct hmm_buffer {
>   	void		*ptr;
> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
> index f5e4e0bbd081..0d85be2350fa 100644
> --- a/tools/testing/selftests/vm/ksm_tests.c
> +++ b/tools/testing/selftests/vm/ksm_tests.c
> @@ -11,7 +11,7 @@
>   #include <err.h>
>   
>   #include "../kselftest.h"
> -#include "../../../../include/vdso/time64.h"
> +#include <include/vdso/time64.h>
>   #include "util.h"
>   
>   #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"

