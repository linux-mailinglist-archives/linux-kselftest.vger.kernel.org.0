Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051BA315513
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 18:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhBIR1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 12:27:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53940 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhBIR12 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 12:27:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119GxdGu046979;
        Tue, 9 Feb 2021 17:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=eVFHw+5NwiCyjIm4PHgjfIS7DF68CJwTbevtLdbaXU4=;
 b=kUYWeVV/xxOTre8OI+X7s4Y6+keDco1r05+0UuVGQLS7264bk2hHlefPKOTILO5akjnc
 rNbXqtxzgDDyrfkYApjMw6ZYsxDx13SjUDvG6MjymFoz89GqVe0piK6LK67NK6fh2BIO
 7rU1QnHyemh3wcP6tvtMGHie/QutLDqpp+sufcD//B4/LmlisHExDjMhHx37WYpfjQzT
 1Bg4hzaKtbZ7OFv25sbLwLX4Xvy/lnc7o17AVXmMRu0zZSLGbzXZWUNMcmIkkxzyA0U4
 c1RQRvk1mYpfCLke/atqKQziaJmrxo5CVPl9K0qs0HDPK1DwKVjmr4jLINzyK6FV9Ovu NA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36hk2kgbj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 17:26:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119GtRPf054912;
        Tue, 9 Feb 2021 17:26:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3020.oracle.com with ESMTP id 36j511gwcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 17:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc7EpBDkjrBCdwmuc8VAHdgpporGvljSAQnpBT3DZ/t9xamq9TlIVkDfizT0vnhwG4ti9YiaM0+Hnl16x5MOZRvWukw8zId5YTK8k8BkWeG1CUmot6ZFTgpMhSrDmPJSjSgvFr0MDt//AKi/+GEhtDPygKxXzqJZKU2mX5VoFbCDLp48w5dpj73jYFhykqiqZdL7hBLrLp6e9ZCc7pzCmlo4yRazFONrFSeeB9RDhb1ABW54QGmEmUitMkAvcmuY5sgaZD2Ajw2PfChkHd3UK3/xB0njF2DkLJ+oBb1T95FAT4HQdoEyGc/XjujbboAvjJN6TZq9ECO2/LfElwjlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVFHw+5NwiCyjIm4PHgjfIS7DF68CJwTbevtLdbaXU4=;
 b=RItRb1XaM1Cm+Bs/kEU+9lSv2s+nf/PDOWAmB2pcM6q1vvPqYW+xRbdQl9dEBIXhQPlKZEWYwWkbVSt1AnXP7JTn2n13FwnPynZ76BJKLhWwdeikmjK04AH+A8lHtraucSY6hbzJwQgaDAU4v73iANLYgOgmWWmVUwmrEi2rSGRTyNKNxdnOfGjDE1gcyQKMuuu1cgX4MDhb/Yr5/JdYOn1VrfADd/CVrDISEOnUE2OyeLr2S6LgA8n2JB+0PZ685bBvbIJDB7DO9E/9Ebe3u4TClFrEU8E/9nZ1w90LfgY7vLOqrvrouo1Ia5uPUo7EWxmiixpkfFpl1/P6+voyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVFHw+5NwiCyjIm4PHgjfIS7DF68CJwTbevtLdbaXU4=;
 b=lrwgGJhQK7HyWJjVm/WHX82fXIcAnEgH6tQAcStNIoq29Cz5LoZHXGTHyGed4QLHyX+dAQZDBtvkKbuLr4fW3v0IRx6b8A8wSAtQwKw8DIdnoDyv4k2jq1QFodXSBUAJ9zjj9Ba6oAZWVyNgma98RKloYdOefBmpeebHzbPVIEE=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4516.namprd10.prod.outlook.com (2603:10b6:303:6e::19)
 by MWHPR1001MB2303.namprd10.prod.outlook.com (2603:10b6:301:2c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Tue, 9 Feb
 2021 17:26:30 +0000
Received: from CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714]) by CO1PR10MB4516.namprd10.prod.outlook.com
 ([fe80::c922:e8a7:1a09:e714%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 17:26:30 +0000
Date:   Tue, 9 Feb 2021 17:25:55 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@localhost
To:     Daniel Latypov <dlatypov@google.com>
cc:     brendanhiggins@google.com, davidgow@google.com,
        alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org,
        Uriel Guajardo <urielguajardo@google.com>
Subject: Re: [PATCH v2 1/2] kunit: support failure from dynamic analysis
 tools
In-Reply-To: <20210205235302.2022784-2-dlatypov@google.com>
Message-ID: <alpine.LRH.2.23.451.2102091717001.1783@localhost>
References: <20210205235302.2022784-1-dlatypov@google.com> <20210205235302.2022784-2-dlatypov@google.com>
Content-Type: text/plain; charset=US-ASCII
X-Originating-IP: [2a02:6900:8208:1848::16ae]
X-ClientProxiedBy: LO2P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::23) To CO1PR10MB4516.namprd10.prod.outlook.com
 (2603:10b6:303:6e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by LO2P265CA0275.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Tue, 9 Feb 2021 17:26:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9f9d323-bcbb-48f6-04a0-08d8cd1fd673
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23032B94B63665750C8106F5EF8E9@MWHPR1001MB2303.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGJgMRasDSB0R46GdrZxKo56XOronaUwq386B4MauB+pDfHEsuCxD44RNvsMiHM2s5o2G4WcrER0+3FquKOTjJFq7fwrJcSZNls0V9dDFE3mXK+aeMmOtxGeKHVXuZfz9EBFfbTvD9MZ8gaa1eHUovCYQauwHo/ZrZ5E1ZnRKSFwHpb73dKwfHCILWpf9lv30OMxpMTKeT5Q6VD7qKBSsVAkrtjrndqNatyzsJu8hgge4fekS//7WDHH0FfWpqOTwalOmhYo7yoE3DGftY2NuTL8philqJPUTvGZTeTKdox0Tr26/1IstSVNsJ6iuZjJkfgV3BEay3vzdGFGiwMTz/dSu26Ovpt9t2Kd4izb25nFxe46nL7VwGYfSvdrp8bRgDR1aT4wW3q0lffEtfNo8wI/33U/8gJPiWuMO4C4A2qSx+UIUCNC92pnRwgCf+jqH/SGqkJ0kdGd8WsnsYQ1lGiRDOTc4UOWa3iLXBlmnWTcU6yuGDVl7cdu3sSX8BYHdXhr3N/qoaG9gBqptc4XVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4516.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(396003)(136003)(6512007)(86362001)(33716001)(44832011)(9686003)(6916009)(8936002)(6486002)(9576002)(316002)(6666004)(2906002)(66556008)(478600001)(4326008)(66946007)(6506007)(8676002)(186003)(52116002)(66476007)(16526019)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h9/x4BO+aTK1799Blf4M7d5gNmqz7F/5VZcI2WC46fIKHjMiOn1I9xD/YwwQ?=
 =?us-ascii?Q?q8w0x7aboZWWQWwPTZupGZFaeEfj3O/4bnbnm9fOrDU0EGSNTpT8YtwH8asE?=
 =?us-ascii?Q?DxYVyXGI44VwTo5JXs9FQcQ8jzf4H3BYjqEeYl7I3EDwj/gsynh8GU2vNW/2?=
 =?us-ascii?Q?XR+ZQRDVHf0KBBKpk6DePRVW5No5I2cfkb1BpyZNUwCka7aRYRLf6Al+B7r2?=
 =?us-ascii?Q?7uBjKAyF2Zo8c9VRJzyE9WXxolo3fDi5IN6cbAWkgAg45LnYiQM3kghDPR8l?=
 =?us-ascii?Q?gNQSzlODcQcYXbkw7RHA0rcAeMEJloVE280EqGVpNEovZZm68lKeUutz6IWl?=
 =?us-ascii?Q?j+vX4NgjR/btV9ya1Q0YYwSmTINW9O0M+ZESeQPoSPNiyz4j4wO7D3HOpJhR?=
 =?us-ascii?Q?uhbDfdFBHcZRLuV2j79YITgzY53FJU1+MOnf1hY80qbkFVwnrk2iznK3Lnkk?=
 =?us-ascii?Q?WclLNqpGhI9SQlEjUHq81kQ2HraaceC3U8m2vykiWQle7nWk8KykixnK2Yp3?=
 =?us-ascii?Q?0QCyc+2VWHlgCBaUH1dcgFNmYdeVS5nZD4RUO483rbUVGaaKMSol87iercY/?=
 =?us-ascii?Q?E26nXd1XyoOsDHcuj6+DttJJ3CPp9AQ4pR/vDlYR3qpVA4BZUj/Mg5k7Kjsh?=
 =?us-ascii?Q?ZLnhfVc6laoC8U9Pqj+vAgF5LkRSWQkgc9VuE9/ojoQzKL85cFIzId3XXI5j?=
 =?us-ascii?Q?PNKTV4IET04yS9sD9tdRNE777SfTgBz3LGlkcAG9h3Z4vnfpNt2LGUDIWm7O?=
 =?us-ascii?Q?l7Kh3okkmqqwU2h54znm37tBq7NUKLJwBARisY7DNWIddYfq8xQsLXqYPlk6?=
 =?us-ascii?Q?Bw0YrhLDoblEQFvG/N3r19d6Vaa8NdbplPCry778M54ayJLN8DpvvuoSdlVx?=
 =?us-ascii?Q?EC+mjB/HcFUOE2w7T5KYsWdFyoT2QTCA/VPKVESq30YRMZ01CrlkidqFjphG?=
 =?us-ascii?Q?QCKCgR12R3Uidi0gzNw9meVDSRjeFOqeKPNTALzGZVuwHW39E9kJBhU6yj2H?=
 =?us-ascii?Q?sabv+DSyNkK1egX/3Ux1Jo4z4w+nxawWni9h2X4pKlXjT8+2eEp9iNH9UZLn?=
 =?us-ascii?Q?YYZeQfWXvkKD8B9UIu1/tIBpSmftCWAI59hPV5qAbUx9M9d5B9wWG8NaSwja?=
 =?us-ascii?Q?Vi91Squ0cM6bCZGd5LAdIAil8JTH24yqiqNgZjmlcHVViScfKoaXZbETMhfv?=
 =?us-ascii?Q?IZcS7HuF+Iu0DNvI3y0kBUoV6RhBEk/tBlJUmMSXKxD8vQYVDcxG8E/5QB8K?=
 =?us-ascii?Q?N5YK6o5oOmeXRzincfRCdSz6PhnYDAfIndC+XRZmxIBIvySPBcyQQV39cJII?=
 =?us-ascii?Q?xVEMiCgmLl9j+1cAYEjjrtOEDDxKwqxuTt56gKWf3gWcO0cempUUQFJZTD7q?=
 =?us-ascii?Q?/BDidIk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f9d323-bcbb-48f6-04a0-08d8cd1fd673
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4516.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 17:26:30.0349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHTpyo+XwRZtQPRw/Yh+pHVwCAU0Obx51M4YFpeB365p+Ceyz39wMAUmTM5NOUdPT+RJ+gNTaGi76i+HrMQDcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2303
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090083
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 5 Feb 2021, Daniel Latypov wrote:

> From: Uriel Guajardo <urielguajardo@google.com>
> 
> Add a kunit_fail_current_test() function to fail the currently running
> test, if any, with an error message.
> 
> This is largely intended for dynamic analysis tools like UBSAN and for
> fakes.
> E.g. say I had a fake ops struct for testing and I wanted my `free`
> function to complain if it was called with an invalid argument, or
> caught a double-free. Most return void and have no normal means of
> signalling failure (e.g. super_operations, iommu_ops, etc.).
> 
> Key points:
> * Always update current->kunit_test so anyone can use it.
>   * commit 83c4e7a0363b ("KUnit: KASAN Integration") only updated it for
>   CONFIG_KASAN=y
> 
> * Create a new header <kunit/test-bug.h> so non-test code doesn't have
> to include all of <kunit/test.h> (e.g. lib/ubsan.c)
> 
> * Forward the file and line number to make it easier to track down
> failures
> 

Thanks for doing this!

> * Declare it as a function for nice __printf() warnings about mismatched
> format strings even when KUnit is not enabled.
>

One thing I _think_ this assumes is that KUnit is builtin;
don't we need an

EXPORT_SYMBOL_GPL(_kunit_fail_current_test);

?

Without it, if an analysis tool (or indeed if KUnit) is built
as a module, it won't be possible to use this functionality.

> Example output from kunit_fail_current_test("message"):
> [15:19:34] [FAILED] example_simple_test
> [15:19:34]     # example_simple_test: initializing
> [15:19:34]     # example_simple_test: lib/kunit/kunit-example-test.c:24: message
> [15:19:34]     not ok 1 - example_simple_test
> 
> Co-developed-by: Daniel Latypov <dlatypov@google.com>
> Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
>  include/kunit/test-bug.h | 30 ++++++++++++++++++++++++++++++
>  lib/kunit/test.c         | 36 ++++++++++++++++++++++++++++++++----
>  2 files changed, 62 insertions(+), 4 deletions(-)
>  create mode 100644 include/kunit/test-bug.h
> 
> diff --git a/include/kunit/test-bug.h b/include/kunit/test-bug.h
> new file mode 100644
> index 000000000000..4963ed52c2df
> --- /dev/null
> +++ b/include/kunit/test-bug.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KUnit API allowing dynamic analysis tools to interact with KUnit tests
> + *
> + * Copyright (C) 2020, Google LLC.

nit; might want to update copyright year.

> + * Author: Uriel Guajardo <urielguajardo@google.com>
> + */
> +
> +#ifndef _KUNIT_TEST_BUG_H
> +#define _KUNIT_TEST_BUG_H
> +
> +#define kunit_fail_current_test(fmt, ...) \
> +	_kunit_fail_current_test(__FILE__, __LINE__, fmt, ##__VA_ARGS__)
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +
> +extern __printf(3, 4) void _kunit_fail_current_test(const char *file, int line,
> +						    const char *fmt, ...);
> +
> +#else
> +
> +static __printf(3, 4) void _kunit_fail_current_test(const char *file, int line,
> +						    const char *fmt, ...)
> +{
> +}
> +
> +#endif
> +
> +
> +#endif /* _KUNIT_TEST_BUG_H */
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index ec9494e914ef..7b16aae0ccae 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
>  #include <linux/sched/debug.h>
> @@ -16,6 +17,37 @@
>  #include "string-stream.h"
>  #include "try-catch-impl.h"
>  
> +/*
> + * Fail the current test and print an error message to the log.
> + */
> +void _kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
> +{
> +	va_list args;
> +	int len;
> +	char *buffer;
> +
> +	if (!current->kunit_test)
> +		return;
> +
> +	kunit_set_failure(current->kunit_test);
> +
> +	/* kunit_err() only accepts literals, so evaluate the args first. */
> +	va_start(args, fmt);
> +	len = vsnprintf(NULL, 0, fmt, args) + 1;
> +	va_end(args);
> +
> +	buffer = kunit_kmalloc(current->kunit_test, len, GFP_KERNEL);
> +	if (!buffer)
> +		return;
> +
> +	va_start(args, fmt);
> +	vsnprintf(buffer, len, fmt, args);
> +	va_end(args);
> +
> +	kunit_err(current->kunit_test, "%s:%d: %s", file, line, buffer);
> +	kunit_kfree(current->kunit_test, buffer);
> +}
> +
>  /*
>   * Append formatted message to log, size of which is limited to
>   * KUNIT_LOG_SIZE bytes (including null terminating byte).
> @@ -273,9 +305,7 @@ static void kunit_try_run_case(void *data)
>  	struct kunit_suite *suite = ctx->suite;
>  	struct kunit_case *test_case = ctx->test_case;
>  
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>  	current->kunit_test = test;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT) */
>  
>  	/*
>  	 * kunit_run_case_internal may encounter a fatal error; if it does,
> @@ -624,9 +654,7 @@ void kunit_cleanup(struct kunit *test)
>  		spin_unlock(&test->lock);
>  		kunit_remove_resource(test, res);
>  	}
> -#if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT))
>  	current->kunit_test = NULL;
> -#endif /* IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_KUNIT)*/
>  }
>  EXPORT_SYMBOL_GPL(kunit_cleanup);
>  
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 
> 
