Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668F8597990
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 00:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbiHQWP2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242179AbiHQWP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 18:15:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB2AA98D5;
        Wed, 17 Aug 2022 15:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLbtjsSSnhFhQ+gIo20W9kBqg5pHBJ5270ZnXIFpRsujJeu6XKyQDqE5kweirJBIslmywEDmvagCTWmCSbQZllaWlEZJ6Nd6jo+KsOnBQb9wLPnz3Bg/nWCcuCwCqR8oq6DK3VKy5+kHnj4iFXdxIxd2MjTcVWQ/Uq9P/UwQcodXjh28l9vtbRNkGx1ltF3jpc57Khj96WVKIOeScuxXZnmBK0hpJXzz+FNklzIEWgQUzaQo1rvqnVaB7dSyIHhDQNnKZsDongAwxvIk+OYsyNR+TIqj3YTkASzz/sXlLqEG7w2VREHyiZ0tH0y+U/dhd2Kuzyt5K0Z02HcwEanHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqRyi/vCUC+sRPTFSSX0a1p+jvtjzQL/ztKZPCKdHRQ=;
 b=WiPQ+dL5Oajzz/is8zOilBduKov8JHEOLjJ08r8l/MSl/JuTeFCgD9JM4Vhep31Y8D0+ddYd6k+iGYf1PSlpvWh2f6xeNmGPP5tvEoDBdD/NLCmh3+LHzeMCGBh9axCVpZcAiKi5dG005YInrVJAN9CRbUqqagTFPCqoDqq6NOw7uW9AI5ylsSNPIpNqvk3CeeVPX1y7QbY/SQ4tt2BgSYOrNhpwK+tVFfHXcoDGEUQx+oDsuoM3OjDdER1L3EKnQvoKr3qCVEznucC3vOvsECWqW5Pz8R+4mPzCgHI7QrKOVbutDCTu6TkrcxJ1FEHQ8eStox2jItxHswfb2hNMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqRyi/vCUC+sRPTFSSX0a1p+jvtjzQL/ztKZPCKdHRQ=;
 b=FLBrDX1rj1jkAqnJbr6PmKN3UP97Ath9CMLAQbW7p+OBZaCurKO/B9WJIGTiJg1NOHJPoyv0dmq6vDfXLegGTX8Xg9/8swbu48t8Blx34EjhaIn51B9BgCrMvGhXHdwyy67MwOhAQulCuqdiR3vhM2kE31GewAkkSoVQEMY2LDXLNi3LVahIEFUK2eptWAh2j32rMWW9QGXkp5AshhRLV2vn34SZS9F26iUl3uRCiJdnj21zAL5MFxmJmt5pTXiTbjbATkoz+sNxJ/CLnGd698QDdmTlXFCBHjo7eAhrOs8IAuxOvD82U2Zh6YTy6MrwrJMOWm1wDvijK4rIzgXCvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB5644.namprd12.prod.outlook.com (2603:10b6:303:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 22:15:22 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 22:15:22 +0000
Message-ID: <190edda8-1f37-0fa5-1cc1-ada97518698a@nvidia.com>
Date:   Wed, 17 Aug 2022 15:15:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] selftests/vm: fix inability to build any vm tests
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220817211356.273019-1-axelrasmussen@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220817211356.273019-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1f6373-6bbd-4489-12eb-08da809dfa78
X-MS-TrafficTypeDiagnostic: MW4PR12MB5644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G0ZaT5eIvbPYDj9HXO6L7USxjyhdaiwh6h66qRV6DeY0APBs+noP0oAM/WvsjAgBM6ctkcTbMuL7xcr89ySPf20a/2wYBHzpM3S2ZLO231MtXnYMiyP6zypNjl7p8Y22cO4oSs3/83QMMeSqxFjIlL0lyhg89aLVSjXFlS4WMWs+Vlu6cC9OtRVagrDrIw6kqBX8IlpG4DUtYyXoUCEu1T5XLYGi9NYDBj0urd3NalFKgQMXM5Qw2eeqGds8nz1Fh2I+XapDp1lX41MP+6A0XeZC2p+v+N3b+4NJhjvnRq+71cpvPbdeTJj2CEzTJroFrACCw03MaF3Ms6VMsoZseYIxIIRMHFWT1FxTh6E2nPoUTECFZcVfM0XcoNIONY928cGpi9XdPxKzFfWFOVMvlVoR2yOjyQpNpCRsBXV059OJuIuAY4dhOSxiTJn4hT6hNjaG+avlid0aP3P+4N8MMu5XAG96Ax/hryJ3T69/17OhQiKQZb+pCdK4Z2a96chE87wm7x1VmK9tzhukRuX4d+gwRVFlHXpllVjhsqM9uR/bTqvqDjCLJBYYxUiliHih6hFUYf7Y6BUKa35S8fByrBybX1pSyhY6uMmaEzMtpGOhTsun6Efk2L/C3xhVOhvwvO91BKhTbqfmgtl9VIRxAU2VmccUR9KwSyz1uW7gXN25NIDhudbNaCQGoRG9oUu6zJWVAEZu214J1DctWvp5mcNwBrPv7WBLzYKRtgJDB8JA8B/8rp0gfcUiViaZ1sVtKgnqLXk2P4qmPsjlDHfCCaPi8Q3Y1UDcE+672/wWqio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(53546011)(478600001)(41300700001)(2906002)(86362001)(6506007)(5660300002)(186003)(2616005)(31696002)(26005)(6512007)(38100700002)(8676002)(8936002)(6486002)(36756003)(31686004)(83380400001)(110136005)(66946007)(66556008)(4326008)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFMzYmJrM1g3a3hSOWY5ckJSVGxnVnJmUjFCSVFJOXg0d2Y5MXFxOGc0ZDgv?=
 =?utf-8?B?Qm5HY0ZDMU5WbGhqbFgzQmF6RG5pUzZtSWZEWTMvK2M3QTREN2xneWFNejUw?=
 =?utf-8?B?OFNnU0VIS1g4L3QvaHVNS3V1bVRFN3JkL0xWUkM0TzJxTzlqQUo0c2lnSlZW?=
 =?utf-8?B?bEJUNDh6S0xPSUhUWmdWSVdrclN1Myt4Qlp4ak9JdTR1WFoyYU9DSXVDV2RW?=
 =?utf-8?B?SXRCd3BMaThGNGk3OXZ3Wkd6YVFZaEhpMjB0eTlDYVdZUzJhbHlwMXJBNGxZ?=
 =?utf-8?B?OS9uZFNQNDM2RGtiU2IyYndPNjBtYmYwVUd2d05mYkg5Q1h3MkFIQUkyK3k3?=
 =?utf-8?B?NXhaY3NtM20rVHQyK3ZsK2NjZnhGenZEaG9oZTNPd0R0VGlEYmRXOFd5Q3Vy?=
 =?utf-8?B?MWY5RWZheWJuYkpVMERSamFvbDRseFlmUnMvdUZQL3RYYmdiWVVqa1JXVG53?=
 =?utf-8?B?L01NazVZZWJPMkdrWFNRSVh1bC9IUEM2RGNzaVhXSjRzVUVlNTRmaTNKcDdL?=
 =?utf-8?B?VXdaTUhoSHd0N1RsN3N1VU1KL3NUMHRVYWRjTnM2VlM3eGJrQWplN0REREZn?=
 =?utf-8?B?VXNkYkFSMnIwV0V3Q3MyOGtXdU51bGFtMW9hZ0ZVMVVKbGZlblI1K05nTzBj?=
 =?utf-8?B?c2NiWjAxcEI5WHlOdEp5M2xMOG5PSDF2c3J3NFBwWlVMdDE0dWpCS2VUTzYz?=
 =?utf-8?B?REJrcFZTanhCQWVmbjJITmtSSVRoRzFDMEpKNE9XRmc5dmJtYlc4QzVacVhS?=
 =?utf-8?B?VUNZaHFtR3lNSWZ5blczaGlJSU9BcTEyL0J5U25rZVp4Y0N1cUNFeHFySGxM?=
 =?utf-8?B?VlFjT1Q2a3hrT0dYdzJUNE80b0tmZEl6ZWhnaWRhNWlWemNqL2hnMzhMc3B2?=
 =?utf-8?B?eWZiWmlNSkYwU3NHUGJzSFR4SmhLK3dKOTJmSHlaamwwMWpYUnRaZGErNXlk?=
 =?utf-8?B?U2F6Z3A1NUVyTXdDemVXWDJ2ZmNidzNTSUYxY1pkZ0Vlb3lVUDRRTFJiblly?=
 =?utf-8?B?VURvTlorNDd4bXcxNnNheVA0OEIxa2YxY0Z3Z21tZ1ZrN005Mk84L05rc1JZ?=
 =?utf-8?B?T2xJS094cTEyR3pFMnhhb25RcXhzU052R2tFZnE0UytwWmtJUGNtY1N5eVNZ?=
 =?utf-8?B?YWN2WmdRRDRCT2REMzBSY1oreVl1KzB4NkE2NHFOSnJUTHY0R0VIZlpVTlpF?=
 =?utf-8?B?Qml0bjRUS2EyT1lmZHBGdm9VdWFYZGROZTRDM3phRUVVNmZVMmlkbDlXTFYy?=
 =?utf-8?B?THdYVUJVNjNXbDE3VTcxNzJZU2RLZy9PRXZxK1Q1Um8ydWNKYVRkNFRZRlVF?=
 =?utf-8?B?TGxBalN1WEJsWE9wbjlIVlkwRWl1bGhCMGVQc1lWbVIxWjI2d3dKWHNLSkxX?=
 =?utf-8?B?ajNWdy8xWHluRHUxdEV4d04zbFlWemp3Vk5SRXdWVzBTOFgvbFhLQ29vQU83?=
 =?utf-8?B?VVZEV3FIUng3L0FmdkRQSTJ4Z2hmU2k5N3dwN2t2ZXV4OWhDWEtSOU9QTmJS?=
 =?utf-8?B?d0kxNlQ2eXFzV0ZKcFV2ZG9nSCtxZ2diMjA4WFRMUGtDdXJnVHZldG1YY2xp?=
 =?utf-8?B?NUpqRGwzN044S0dlRll6dHlWdWJEVGJBK0dMM01HNGxkeVE0dHZFQ3pxY09M?=
 =?utf-8?B?RjE3RnVuUHlUWGF3aThpVkliZTdrUG51TFdTck1qL2s3ZGgxOTZ5NmhOU2Zt?=
 =?utf-8?B?SUthUVdOOTVlZTJhNHRWZkdPQksvZFhVVHI5eXBhSHllOGpmcGJteWJBUElL?=
 =?utf-8?B?QUc2bFdjLy9LS3d1aFd5YjlhbnhkblpzLzhhcW55WVpPaGJkcWVtZlRLQ0sx?=
 =?utf-8?B?TTZzUEFBZmhWbE81UytoVllPSTJQR1JyRmxNaWRHVm54Rmhxa3JPSW5pMC9Q?=
 =?utf-8?B?aWFkYTg3YXNLVGc5bGRkQ09BeUhHdEt0dnNRTDdZYlN6Myt1K1FOU1ZGUkhJ?=
 =?utf-8?B?RjZiVkZZOGJKcHZsZDZ3a2RBNGNVeXdINjk2ZEErRHVRMFhGeGUxYk1QY3dI?=
 =?utf-8?B?N3drb0ZMWVdUZ0xacllqYUJPdHV5KzVOc2dRTHg1Vk5WWlRpMWNJdkgxTU83?=
 =?utf-8?B?MXJlbmpDQWNiYmZ1VmVMNitmRk1heTlqd0JoSVdVQVhINUJLYjJrbE9YUmU0?=
 =?utf-8?Q?FWqWQN8+ggTa8vdFZyoK7WD6x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1f6373-6bbd-4489-12eb-08da809dfa78
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 22:15:22.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiC+pYUh92vAbC6yYSJ+7lIVamvVIgxXPwJWs5TZ8IaPdL+5x1YXQ//xtZKNESwKlSpcp/Oca2bdEsRpUwDHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/17/22 14:13, Axel Rasmussen wrote:
> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/vm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index d9fa6a9ea584..f2a12494f2d8 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   # Makefile for vm selftests
>   
> -LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
> +LOCAL_HDRS += $(selfdir)/vm/local_config.h $(selfdir)/../../../mm/gup_test.h

Hi Alex,

Thanks for fixing up this build, it's always frustrating to finally
finish working on something, only to find that the selftests build is
broken!

This looks correct, and also I've tested it locally, and it works. So
please feel free to add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


A couple of follow-up thoughts:

1) I recalled that hmm-tests.c in the same directory also needs
gup_test.h, and wondered if that was covered. And it turns out the the
relative "up and over" include path is done in hmm-tests.c itself,
instead of in the Makefile, like this:

/*
  * This is a private UAPI to the kernel test module so it isn't exported
  * in the usual include/uapi/... directory.
  */
#include "../../../../lib/test_hmm_uapi.h"
#include "../../../../mm/gup_test.h"

It would be nice (maybe follow-up polishing for someone) if this were
done once, instead of twice (or more?) via different (source code vs.
Makefile) mechanisms.

2) Commit f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
claims that it is now required to "make headers_install" before building
the selftests. However, after applying your fix (not to imply that there
is anything wrong with the fix; it's fine), I am still able to build
vm/selftests, directly after a top-level "make clean".

I believe that this is because the selftests are directly including
gup_test.h, via relative up-and-over paths. And I recall (and also did a
quick dry run, to be sure) that this internal gup_test.h header is not
part of the headers_install list. So that seems to be all working as
intended. But I wanted to say all of this out loud, in order to be sure
I fully understand these build steps.


thanks,
-- 
John Hubbard
NVIDIA
