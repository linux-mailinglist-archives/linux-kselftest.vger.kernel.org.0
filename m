Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6985272379B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 08:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjFFGZX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 02:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjFFGY7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 02:24:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14C310CA;
        Mon,  5 Jun 2023 23:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NT9EJnjQTZcSugXOUgwO4dwAuCW/gtsUT0q99YdryZVw8jyyvLufhxla9uvFpe/54eFzZ7y/yjrkthEu3pvf3y7ELkUQkj2np0/phStTP05BEv/8MKeucl3MsgooUUMNbRdwLC5/C3A71Gzotyer5/MBi0DPRkjOj1Nu+/Qb4+jg+i0Fj4kO5Y998v4TLdbN4wgRFWAmAkHk7CdVnKaeflBQWp86J1ART6AKrwIBRRwDOLwN2BQsVoI8JKKwv2hSGo7RE1rHEwV1xm59EewZ56zlR6xJDq5WXEm148VPle22S7tDkDdZjDypq0T9mGijw1LPrcdgTTg0mEq5/3X0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj5y1DA/SACnEF2x7WH7mITQ4+L8d9VfnpTYXUTJI0s=;
 b=lIxGV81TZAT2bi64d/tDGfL9tNyQWcfqRgrZSaNM2BleodQ/hrj8QFYWR6jTtMpo7E3LUtuetoQzR8WIj689pm8pqcnurEeE/f6lQw8AHB09H+GlxBeJitlBvf0O9GzO3YZz16F9sKSK9u6EWhpIgATpFVD6mKubyfwo6fSFmXplg74QbQWJ6hzswQlX4MeXpOz8mxHxWE/PJeZEEX+zNxXHX+2mOCVzZXPEkvzEfqWx3nHJJTUTZ7XB+bPdJU3+aAgcA94XAxNR7QNsv+LK8EygoiCaKeniMq+T3kO9UqjCEhW448rA1O3m/HW7hGumz0FpxXpUeq6I0OPbPh2igw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj5y1DA/SACnEF2x7WH7mITQ4+L8d9VfnpTYXUTJI0s=;
 b=ozY8Qfgv+9mPOAzjToXDZXmfs3N1aGuEcM5yUjzW5otB3j+N9rz+4PmHdb/pYGeEULYb7vm4S4U24cjUO/q6bAKRtc+gtzalSMEGeTxmOprqCZdC+Pf2ECbP/kTRHxEHC8D1/7apl9K8Rfk0H/emi+qulGn+R3WQil/jqRAiO2J10+206cqyWgftksfJcVnNyJXypKDG8QGELnGD6UUP3GzfrxpBjHreVsFNldotci911/gjEeBH3dRSn6iErrx3AdewVGRem8CNN6UEDVNuW931YMZrXv64VqKzkhM7XMFfi2AuwLY43mK/eZZhaSrjEW2knTKqo2QvMp/a18NmOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 06:23:19 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:23:19 +0000
Message-ID: <ea3548ae-de27-fb67-5b2a-34aca006005c@nvidia.com>
Date:   Mon, 5 Jun 2023 23:23:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 2/3] selftests/mm: gup_longterm: new functional test
 for FOLL_LONGTERM
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Jan Kara <jack@suse.cz>
References: <20230519102723.185721-1-david@redhat.com>
 <20230519102723.185721-3-david@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230519102723.185721-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DM6PR12MB4973:EE_
X-MS-Office365-Filtering-Correlation-Id: aa142a1b-0981-4b55-87e0-08db66568529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8l6iaCBxOkd7jKIvObhIinGkhUymU3baQ2erzfpBFeEUKI2OTOe1bypp+x10VqqNQv7TlFB7KQYzwQb7641As6AxtG+wzEiskPNAzICyjjmCeIrEjxjYl5kKWTw6mX/AcMqtCPFeYU0fMhQ9WThIttho0pwZgmIgIGmy0zC8wFc4decVRtvJlGqJNew4Nhp6EuQ21R+q8AiznEFAkKxrO9jAta6sbu7dx0u84ZGpN6m3yKk+RKyVP3wQHxW2OCr7GA48MBsmjjhINc0IH41ePHrPEi4AivGdmxrxl3TLCeUpKk3zYUHizBfNnRAH7L0ZAvsFvcZmnTtnQAGlRXF6hxDj3wA6N47+X3ZSV4ko6HY20LSLbMuRZOSgHXeA6ftB9hBCo1X5BV4zRvKutp6HEW2X5FAUtgPp1kLSORodqNfGySoLjkxPwMcwf6JGvCsnIB8vl2DBf18rc/v8v2OywK/zk/3zJYkrd851ELGlaaP4Q9fVlNPsxrY/CxGf61eR+/GaFrqAQjKG2JjPcvBdF7I+3wkUQgpbgTyOQeptRTv3TFsVitmQo+CEO5VyVcCh9QwZdJsCrc1nOgdZlHSlFPn0TVkGPfIjOASr70J0628pXmBkONiGSUYfXHPuhHnhTQNUy1SetkGNz+ZSVgq5g1E8QxnKYchXo9S7gCL2/Xy1wvQTMebPlzbMuHzDwEEt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(6506007)(186003)(26005)(6512007)(53546011)(2616005)(31686004)(966005)(7416002)(6486002)(6666004)(36756003)(4744005)(2906002)(8936002)(8676002)(478600001)(5660300002)(38100700002)(86362001)(4326008)(31696002)(54906003)(41300700001)(316002)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1VUKzlqS3VVU0VDUnRWVVdvbXVjdGtYTHR3Q1ZTcEhxUVQvaHYrMnNYU0dx?=
 =?utf-8?B?aFBjdHdYNisvc3RIWGUxMFZMOFd6OHFjVXZ1ZDIyRGN1V3JBSDd2VG91cHVn?=
 =?utf-8?B?R2kxNldVN0JlcFMxZVppRGczUEhaTENFMVlmUDZGdEgxNGcwa2wzdngrMVNS?=
 =?utf-8?B?d3lwVnNJdmk1L1pPbktBY2RRVnpRR3RRTHhnTSsyNE4vV1RaMXFNcW5XVFN4?=
 =?utf-8?B?SWQ2TDh6TC9HRlB0OVd0eWZKWFFidGZVblpxMjNYQ3E2OEh1QzB2dHBTN2Ix?=
 =?utf-8?B?bGJIMFNMcVUzSmVKc1JCSXV4Yi9qRU9mVDY1KzArSVZtUUkxODZyNDNiWEFJ?=
 =?utf-8?B?a29YOCt4ZmRDUkpUaFRuMEdtR0pwWEJsUlhld1VKeit3bXRlRmRGUmlHUU90?=
 =?utf-8?B?cVE2SVkwb3U5S1ZaMVlBOTNSeEVzN1ExNWZ1dktQdFdXZGFBa2dhTHVwRUdZ?=
 =?utf-8?B?U3BRVFMyQklLR3BSNUZFUlVBbmRwNXQyUHd0UHBqbHVlSUR2dlQvSU5JcTRZ?=
 =?utf-8?B?ZFUwenQ3eDU4ZU1oVDFVWXZMWXZodVIxMGRER1BlZ2FMUGpmamdlMXlxVTdQ?=
 =?utf-8?B?NUhqdllET2dldFMyQ2hFQUJhbDhHNHhvcmE2WGN4VU1oZ3kwdVFTdEtHWVl0?=
 =?utf-8?B?WVhkVEVPWmtuRFdwKzcxR0FiYjNudU1PT2Vqa2Vsa2ZmRXJ2Q2RVYnl3MTFW?=
 =?utf-8?B?aEw1eGRJMG5FaFRNSHZNenYwODZHd3ZyYktmVlBKb2RhNndtMlFqcFVMb0xT?=
 =?utf-8?B?b2JzNFFUVFQwK3RBV3d4ODlKR1NsRTJVTm9qMHR3RW8rWFphOUZvNHRMZDgx?=
 =?utf-8?B?M3J6UkJYVjJVakJIQlR6V0l5RkhyNjB1eDFrMzVpYnI3eGNTbXg2aWtCYVNK?=
 =?utf-8?B?RSt4ZEM1bXY5NlMrTlBjT3BxZDQwbW9FUExXdUZnLzg0NGJrZGhzem1FNkQz?=
 =?utf-8?B?UXVBcGV2UGRTU3NUQUFTUDBOQnpJU0FnWktLMDU0dkVLM0wzYkcwVTVPNHdR?=
 =?utf-8?B?Ri8zMThIWUN4WUovbHZIVUsvcEhaN1FKL0g3NUM5Z0I0KzFNeEpyQ05NUm9n?=
 =?utf-8?B?RU5QRytEQzd1K3ZReE9HUzJmc09XYnZ4N2JwUFoyYTNqS2pUTnd5VnM1ZHNE?=
 =?utf-8?B?aEV1bnJQbW4zSitDTkZJUUFadHBNcVJyMTFoVGN0ZTBldlpyOFNoRDdqODNH?=
 =?utf-8?B?dWVLcnJuSjdYRTBReTQwYTRwUGdHUzN3ano0SXhZTCs3TEZ3dmZiNFE3NXJ2?=
 =?utf-8?B?T3QvMzVSem04bS8vbXdtWjNHVHY3YnlST214NUhDZnJ5QzV2Mk9MSnhJVld4?=
 =?utf-8?B?RTZZd2FrUFgrSDBGZkt3OFNDd2c0clZTSkZLdkc4dldjazJGd2xLM1hJbkhL?=
 =?utf-8?B?ekhlWjVvNHpYRDZRYTBteWJRMkZqTWIvTUlocmtNVDNEenNiNk5ZZmRtMTJl?=
 =?utf-8?B?bGlUeWsvaGI3MWRWd3k0bUVLd2w3VGRKS1JIUGprRzJ1aGplTWFxdG4wTjM2?=
 =?utf-8?B?NEJVSWppQk1QdFAyZnBMSzlxV21UTlFWYzM2Q014UFEyWXdybTFKUXZxYm9a?=
 =?utf-8?B?VlJNNTBBM0J1Y1orTHF1THBzcTc3QXZhQWNCalozWGFWdjVmZXczdjZ0empn?=
 =?utf-8?B?a0drc0RRdE4rd04zbVBtMitwMENZTSthYjhnMzhRZkFvcHZJRW53Tmw0MVJW?=
 =?utf-8?B?QUN5ZW9hSEU4K3lFYTBjeDA3TDdNMzFxL1R0dEo3Q0lmRVlpNHMxOWh1RkJl?=
 =?utf-8?B?a1JJVXBqRjM4eWt3emV3REVtWGZramY1VE92KzJtTTlpcmgvdXZzWEtUYnI3?=
 =?utf-8?B?T0E4Q25ndjFPbzIvaDFrN3lxWDRQZlBNV0k4a2N3N3E5dnM1eWhYLzNxeUpm?=
 =?utf-8?B?dm94S2w0QXc2cXJTdm1hcmE1WWxEUHB0SnZvMy9TcWpDZDdFZ3FSZWp1VWlF?=
 =?utf-8?B?eHdjc3E2dHpwbjBXSkZsWjN1akxKYWFpSHBLajFmc055SDVRM0NxN1pqbWow?=
 =?utf-8?B?OHIvdXF3SjA2UlM1RGlxVnRxTXppbTl5c2RGNnEwVGE2dFBXQ3RKUC9POU04?=
 =?utf-8?B?Y0NUWUVtSTZpTHk3MU15Q2FGbkVxNFZqYzdEbno0NWkvamlKL1puODdCdHAx?=
 =?utf-8?Q?F0wYjHrgXCvGv6Eb0rR4LnfLP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa142a1b-0981-4b55-87e0-08db66568529
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:23:19.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPoT5gzM5XSgth2rlMR5P3Hvm3EOlpGOYPk1JDiy6CpAovrPHlIHN1eDPJOq+orrQXqHW3+/eA87+c3YbcCS8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4973
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/19/23 03:27, David Hildenbrand wrote:
...
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 23af4633f0f4..95acb099315e 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -34,6 +34,7 @@ LDLIBS = -lrt -lpthread
>  
>  TEST_GEN_PROGS = cow
>  TEST_GEN_PROGS += compaction_test
> +TEST_GEN_PROGS += gup_longterm

Hi David,

Peter Xu just pointed out that we need a .gitignore entry for
gup_longterm [1]. That logically belongs in this patch, I think.


[1] https://lore.kernel.org/all/ZH4FFa4FV9KGwBZo@x1n

thanks,
-- 
John Hubbard
NVIDIA

