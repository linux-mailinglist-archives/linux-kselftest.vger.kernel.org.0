Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A709D7213CD
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jun 2023 01:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjFCXsS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 19:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFCXsQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 19:48:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF82180;
        Sat,  3 Jun 2023 16:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrbVE2zT/30BzcG6KBA4NDR8Aj9fTb0JTl7FTYH7jGq70bqZVYRtvRMvFPiR26daFtUNAFPpGYFBaH6RZeqZBpjcpfNb5rMnuWJ4evBlhaJ1QhqmaypDXbejvHZygQ5vL8QM+FMPMVZXHsDWzYrbZryLC59I+Lv1eTlVsU4Y/54z1P0dmo/HErCqbPBzNua3uLU7xy6fZBs2ieusEyajlkML7O7VweUXlVdylv0MeNS91RGDausnNrVh+yasIJ/eQW6YjmsrX5c3FLYYzvXcfjdOwVGrtVQejfTKupifJNEX4NSPlBNY/Bu2tW8owj1WRpBxaso4Uljfvp8tYrL0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NuBTcNyla7IsWEMFzrrnO8ZavMIOU96D6BXSpSIsR8=;
 b=i8Tbkn8Nu/viyM+fpQwAWkf8SHlBrl7EJHWTRxKhgptCx4zu+2Tb8mW9uiAn94Feg0Ofo3M4TG2bmStdAhboKXYUu3wBoZB02JnF+nZsQB2MA+OCCdprzs5O8jtCXUsmtD06B1hbDgN43rQlIbn+d+c/7NSPsFIAN1cH8K/OJzZ7LqxY480WEHkSceu6vGjkKBDMTbAGRdwiy8yPa+Y7VJndSVzZY+ClP5GcVQYD5m7VlsradOLKLfb4AmH9TaUyavkgl0jBVr/g3YLtfwvmPhItlY2Bbwsx/nBVqk3unsxeu+s7Jd70ubffW5pgnHZUdPe6g+SnJ/6NXIIqJ3WHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NuBTcNyla7IsWEMFzrrnO8ZavMIOU96D6BXSpSIsR8=;
 b=L9Uq4aW3AK1IbDj0vUihg9235RruMFXmOHiO5gZww2T7AlxQW8tutwiduSK29NtBRpO1+jJnswMIgVUwrMn2MhXmJw18gF3nZbBzaH8w7pqDlVxlGCniBpin/1O8RVuXUEovT1tTAAEB2atCuPsbQKrlWeeUFnx88WkpBxAtFWeOLTMW60AYTYjZ1v9tvOjEdj9Il+7A3Bjxbi48nDFL8JhD8dI0Bvk3aYZ3VyIA7MMug90zHSHWpxeCpkJgX5zAdD+zv80SW83JkP1P550gYAvXerk4HMNRpv8Si1vyaTPpLwPjt+ip3WnvtkkHP9yyLDSt9Ztn15YOLmv9T99j+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH3PR12MB8460.namprd12.prod.outlook.com (2603:10b6:610:156::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Sat, 3 Jun
 2023 23:48:13 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::e01a:d41e:80b4:7cef%7]) with mapi id 15.20.6455.030; Sat, 3 Jun 2023
 23:48:13 +0000
Message-ID: <3842dfc1-70ce-4568-a29d-31450d4c9861@nvidia.com>
Date:   Sat, 3 Jun 2023 16:48:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP
 and similar build failures
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-12-jhubbard@nvidia.com>
 <7a999b80-e266-2b7e-f198-869b1ac7cde7@redhat.com>
 <993773ab-7f5b-241f-b532-ee79a03b371f@nvidia.com>
 <a4fbc191-9acb-5db8-a375-96c0c1ba3fcd@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <a4fbc191-9acb-5db8-a375-96c0c1ba3fcd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH3PR12MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: efea11cd-c1d9-4f58-a025-08db648cfe47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seprN+BX7YlpawL6aTDttSVcI6BbKgz8aKih1mvIaHrM3yoxFna5w9/+4XlFh66PCTVRoZB0eSPlep9G5B37oJWVARG/fSydztlkWh4+8UyQmhDXs0IKxGoZTWcl0uI7iyCs5/vr+dZvMXb3p1lqDAQ1IzHyyRZiX+shjvFxUUROWcrDrCG1rfSc4an674A1bsAKRgVFSCb304dIMlkORBZLD0lWOyhrKFRw6V1RkWUzPeC0qbmiae/rd+Rlb7ppxcmRSlvJGSxgVE8ahFdsaQ1FwHkrpNumODvnAE8be/NeqaztoVRDHqJP/nRc0H7hudaZ16xw34ipOtI4aU2JSTiinJ/7aV87lyT6kXxcu645XtW5IcPbyKoJAHGBKmT6k5gVF6+wq825JTikJCEvR86pgyDR6RUbf167Pd5AI3Os2ETLfMU2C+6TWSKiqLhB2MuvIYK+64QZrE5sUGHP8P5K3O3ib4/cgx1lYeyBgmTXjV9aukeEDGDd9pKKRQAwxAefckO4n8GnykWghIeG2AQl4ka7iTOz2itt0L9GjAfkznZr/2obtyquposYaUByJDJRw08AJgaB1QH9bwVbFO58Xbzj7YEqqW9oULibeyPc7gKneSCWKfascXIMHPiwFbyxB9C1UMgnowCS9bYVkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199021)(478600001)(31696002)(2616005)(86362001)(36756003)(186003)(26005)(6512007)(53546011)(6506007)(6486002)(2906002)(38100700002)(41300700001)(83380400001)(66946007)(66556008)(31686004)(66476007)(8936002)(8676002)(4326008)(316002)(5660300002)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVlMjlqbXpWeTJWSlpsR0hKQlMyaWZCMFE4d01IOERybnZNNExWVS9VRTNM?=
 =?utf-8?B?Sjl4VktXTURBK3gyZytzZlB2R2VSZ0FjQ0haTUw0bEdFNXVQdHhoNzhIR3kz?=
 =?utf-8?B?bzRGRW03aGFXQ1IzMGtiQVd3VUJoVTd0NTRXcEZlaXpZVEIvTkllS2pyOFF2?=
 =?utf-8?B?WHBjU0VFa3o0N2tUeEE1eTFRNlFCSGdBWkFnV3JCOU0xZXR1WGd1cWl6WXBm?=
 =?utf-8?B?MHJHaDJ4N3ZCanFRZ05meTVxZURGYlIxb2VYa2Y3RytZUnlObkNZbDQ3K1Rq?=
 =?utf-8?B?aHQ1a2pPTjQrb3lrZ3hTWkMrL29naEZOVlBhMWp6Ym9hUjBZREU5ZFo3VGht?=
 =?utf-8?B?eVpEaUpxUTlqWDBhaXBEeVhIL1BYTmptVXNlVk9ETkFGTWV0cWlSY2srMGFy?=
 =?utf-8?B?WVFTdTRtbXVjZ2ZyWElBUXhoT1RMalR5YnlRUjNoZE5vY2R2dlVPeE1hY0tP?=
 =?utf-8?B?ODMyVXBOR1VNeGpGamlQNStPdEZQMFlwSzREeTA5NXhzMFkvRis1ZHZRb1Zy?=
 =?utf-8?B?VGdpblNVbGc5cXFjL1VrMU85S2dLb3VUaUF4bUhxOVdjanZsSFVDOW1xOFRE?=
 =?utf-8?B?enI4a3pCb1VScG1SczhOelZKd2hYMURKY2xDQ29ScnBzRlNVQys3WVcxUHA0?=
 =?utf-8?B?eEhmaFVDdEkrTmRyMWh2RWsrVUdzZElFNE1IVWJXbGxNQ0pqU2tRQzFDbmdR?=
 =?utf-8?B?R2RJclZXbzg3N25jMWtPdkVTTXpBWGRjN0QxQVU2VjNNWkM0bDBMV2JTdHZJ?=
 =?utf-8?B?d3dqcnJoRGlEYjNTWllLUmd6WmNpVjJvWlRPZGppS0tyOVEvN2d4VjBZWVdr?=
 =?utf-8?B?NldsQUUzN1RCYlp5dUF0blJrRXhvWStCUmRPZUFsUitkRWQrbzdjWTJwNnBE?=
 =?utf-8?B?MGxYaURRMGU3cmk0aWhtZXM4MldjWktNaHZlUVl3ZTBFNVFQOVdjTURiVWxW?=
 =?utf-8?B?eEVGN1MrVzNpbDNFRnEwNkc4SDJXMEcwbDhjYndQWHI5azQ1dzMwMWNMNm12?=
 =?utf-8?B?NVNpUFhCUHZUZ0kvN2dybHhvaGd1a05qUjlBcDIyUEtOTDBDcjZxTFRLVCtY?=
 =?utf-8?B?SW5Gaks1RU9WYVZGNXphVkhHNjlRbjRtN242RHBwY243YzYrR3pjd20xVTR3?=
 =?utf-8?B?dFo2YWlyYk5xOTNBNkdWWjJIbElDUnBUd1h2N1JTQ01ncUdCL2Q3cXVJcFp0?=
 =?utf-8?B?eVFhZzRWd3NpWHdJdll6ekp0bUNqTjg2VWZlbkhkRnc1UWtqNU5JT211ZTlK?=
 =?utf-8?B?TzkzdlVCdUVQSHU0clROWnRRakNYeFVzc0EyNUZZVDJDcnd4RE5pTE5LL09x?=
 =?utf-8?B?R1pYNzg4ZzQ1VzJ3ZWx4b1BtaFg0MmEvek5Rdy8wWmtOS1pWdmsrVUxmVjJv?=
 =?utf-8?B?cUNwVjJqNHJBVUxXbmJraU1MaUVnL0xQdlJKNmxhWHkvL1hMd2NEdnk0dWgz?=
 =?utf-8?B?M3FHSmtob05WSXRxZWtZeVR5ZWVQb2Z1MlFKSks2eVhEcFFhc2M5N085Z2dD?=
 =?utf-8?B?TUxRWjdHWStVNDlSeHFuZkNhT3hjK3h5dWkyZ0ZTVkFsd2RPazVBeDJjdGxS?=
 =?utf-8?B?WThUT1cxN0VQUmhMdnlKU2tMS092N2dUSFdIelowVjRSZ2prMGhjN3hGdW5j?=
 =?utf-8?B?TEUzbmNVdEp0a3NsWWlDMmw2b3IvL0w1N2VhU1RlVzdGWmpkaUIzRTBwZWxl?=
 =?utf-8?B?RzFPVG92SDBTbnUzVkZidGxrMkNlRFNLWnBFMlM0YVQrcEplOE54Y285YVBy?=
 =?utf-8?B?KzJEQW5HekQ2RzlvcWRZVm94Vkg0amRWWHVlVTllRFdFcnZtdmtYekFtNytk?=
 =?utf-8?B?Z2ExMXhoWnFQVHp0a0E2VnduK24xVks3ZmxhUjI1bGQzdWxDd0UvT2RhalRX?=
 =?utf-8?B?dG9hblBZRzAvYWo4c3RDbG0wR2tmRzZnUEh6OTRlNUlZK1NQcFJMZ2t4Rk4v?=
 =?utf-8?B?bGpKK0lEWElMd0NraHB4Y1lYQm9CZEk0a0s5cmZvUTVEZkFsTDFXRUxjMW85?=
 =?utf-8?B?dmNINlE2MjFwVG1aVC9vNndpVjZKeHUzYlNISlJnZU85ZkFKeDZQR2NxdzI4?=
 =?utf-8?B?RG52OXZUaE5hT0dSUk5yaFNKUEN6V1hBV3EwSzlmK21tY2dGZHFZZk00N2ZG?=
 =?utf-8?Q?cI+I8sctzucTPuDiI6KR+4aQU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efea11cd-c1d9-4f58-a025-08db648cfe47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 23:48:12.9695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQb76J9xQdkx59WQaKefNuRKqSnfdqq1+Z5AutLabZO92e0aFWGPfLm7kp0eN8MrrpP+OPWigTHeoi0NzEIEeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8460
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/3/23 01:27, David Hildenbrand wrote:
> On 03.06.23 00:20, John Hubbard wrote:
>> On 6/2/23 03:23, David Hildenbrand wrote:
>> ...
>>> Unfortunately, that seems to be the ugly way to handle this because
>>> including the in-tree headers seems to not work and I yet haven't
>>> figured out why (there were some changes back and forth so I lost track).
>>
>> Yes, ugly, and based on Muhammad's response, I plan on dropping this patch
>> entirely, in fact.
> 
> Ah, finally I know why it sometimes worked and sometimes didn't ... yes, 
> let's document that somehow.
> 
> Maybe we can even warn from the Makefile when the in-tree headers are 
> not installed yet?
> 

Yes. And in fact, after some fooling around getting reacquainted with
selftest Makefiles, it turns out that fussy part was setting up to
detect the missing header files. And that seems to be working reliably
now.

So from there, it's just as easy to automatically build any missing
header files and continue as it is to warn about it.

I'll post a patch.


thanks,
-- 
John Hubbard
NVIDIA

