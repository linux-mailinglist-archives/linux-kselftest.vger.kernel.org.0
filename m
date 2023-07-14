Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14198754278
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 20:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjGNST2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjGNSTY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 14:19:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014AF1FEE;
        Fri, 14 Jul 2023 11:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L78a3TaSrlhLXii86tr19VQE1BvbWa/Xd5aLuvG7zq3A+8iKBArOc5viTpczvawFpoLz38nrFQvmb4gc9gim7uzoZos6cXObO49TeZIS/e82/hbstRJjf9by2q43Im1RJpED9bVUnYxo/sF1I8dEXqWktSFfhTBgtb12dC+HNV6TfGT4vKfn4wZRMM5cwvebhks7359s9qqnHOVGP95gOPjpemkuKgI8mu4oqy5JOkDgDW1NIfE/5d7dI9zAUHUTr+TnRA4Xy5ZgDa0nYJd+BlT1m6YWyQRXU7sxmVmfwJZssPmB8LWdUMedV/j94qgl7WoSTnPg1lea0uBVJg6aLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClALFPQh7yHJuoYdQSRYtYVEjCB/xQjXEzSZRNmOqe8=;
 b=jZ36H0pkm2VCDTEoDcaX2y1w5jdgVn5qX4+sEverXK2vE5BLaca/AQdDw6jO40IEGZFBfeXB8VnYwRGpV0XKvLX5AqgmkUqXrstmwdBox4k68+n9hKTUs+6ci6mhJtH39cf3upI6dLaezSF+tZm3SAYkXWHCSe+rgfoMv5JAdZ0X9tZXNK+uDGI50hzXsXuvelU2V+Cz+aOC/R8YrU7UeassiwL6BblgwqzAXzFeNP3lp1TP+ipSeVMEg4XNcjdM81UnDNEOv3zCgZ3oWtjjSMtg2GA5/Xtr+vTAG80xzYxePbkkX8dQcuIOonZtEP8qrk591zcGC+8mIuKVwcMjRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClALFPQh7yHJuoYdQSRYtYVEjCB/xQjXEzSZRNmOqe8=;
 b=s684RsagF9ULPHnMVH9tnDTDQx+BrCcgadQ4fJZ+Yp52la41UC4hX5nuaS6ijzy6Ik+w6LWBw7cMd7qGJGtT31Gd/p4Ni1SVJsyY75h8GH8/2Dw//hbpLs/QxqzWEFS3gBpt4P6hGFgu0SY/7kbjh6Sajsp8GRkPBC3cLVSNNghEdujcQ5X7ymc/64RCdJszIts1fEtupKbzpPFlpbrWvXBLLFMQ5PSRzyXXIyeNuT6oTXhI0KL9UhrsWpVyQG0ELbC3NhtjHDSP0ozRvnQEzImxyWHBqBNm2iybOTT5CswjlKVe/btRGnlscIsnToAvfD+kWOyPbHSKkUzSu2iNDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 18:19:14 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::a8da:fee3:b3db:432c]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::a8da:fee3:b3db:432c%6]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 18:19:14 +0000
Message-ID: <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
Date:   Fri, 14 Jul 2023 11:19:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::16) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f20d8ae-5873-4243-f65b-08db8496d406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5P0IneTIq1vCLDk/ETDYP0hvDZjj0H2S0t0m47iBQ7jlAZ9Wtutk+DdVdnrnW7LGBkBhRSw28RBjxrij9/P79B7rMnjqEmSTO0M+l0VzG/zJg3E7D0wEKjISBet7HWo7vYwTR97z6xTa34Ehw0n0Cu8l3p3jQqLZcg1wjWoOUKRwrVHCZuYvCG4EsS+fBlYR63nMMKTj9YDBX9abP9xb8x83mEwXAKXFhjHNfvdVoQj6Fye8hSRtVCviU3Uv0dQuACN414jVUX594LuljZdIbuzppInURRXFE8DzDaz+cXDXP6W+LF3Hkj+O3HZ6PYCFh9cIFV0mJRyEefVTW8Rc0G/hFSU4xDe7+fdtrdVEPc5tjsjVGjl1tuTuq1jZeXje09LofI590C1M+zv0qfEanQdwN/SebblI590t+qVfe/uPHna+qyHulMxpQqOx41lMiG6IOfhx7ktj6EzDcfjeJD/FZz9ErY4LWTjA1BVKZy3paGLaHcQ/VpVSunV+O0tupUf8BMvsjgxTVEpuGjl+mxhlPgJEdRXGXPDCB8GQP7E4KgRkOGP2Sja6mY2n/SD7TkklIyGmfiK52iU0ey+CfLKbeZY+BEiOenHDnHWwdak8DpltOzOwc6aWIvI/hVWdC033ep6yVagIHA7lCSC4l+1ZzJbquA9yAp1CrfSY2+bGkrhc3wS/60nGUKNIPptZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(6506007)(6486002)(26005)(186003)(53546011)(41300700001)(966005)(6512007)(31686004)(2616005)(478600001)(54906003)(110136005)(6666004)(66476007)(4326008)(66556008)(38100700002)(66946007)(316002)(8936002)(7416002)(5660300002)(8676002)(31696002)(86362001)(4744005)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNlSTFWYlhnQlhKS1dScnZYVVkzdWpCOHNVcC9CaHUxNkVxZGd1VDBYYlRI?=
 =?utf-8?B?RU8wVVp4SS9nb1J1eDIzWTdUNTdoWEhNaXVNVDFjYnlFcVBHcmtCZEVQZStW?=
 =?utf-8?B?TC9zR1dTZlBaM3BuMUhsSlIvYnIyMTdjUUJoblZacUFFMG14L3JPRzIvRXdF?=
 =?utf-8?B?aWo1cmQ3K1kzb2JmbHF2Y2Q0Si9xbTZqdFFQRk1hdUFJZ05xT1Z5dzRBdWwy?=
 =?utf-8?B?SmszT0FZWkdwOE5OZ2x3dENyamNUVmxqMk11VDhzdDllWUJLUW1mYmpnTFIx?=
 =?utf-8?B?OW02OXJ5MWk0WjFLREhodGt4REhVK0hxY1pNM0Rac1NZcCtVRGVEN0hMQVBy?=
 =?utf-8?B?S3Nnd0RGaHRMa3dCSzBCcWNsamF0UUxRbWp5Q3Q0TXdlTWpGSGlJTzFSZ2lK?=
 =?utf-8?B?NFZNOVowTTBENHJPdnA4Z1hITDRwZC9xQnhqckY3cmh4SERQd0NGMWJPVllM?=
 =?utf-8?B?SEtSYWwybjQwOVVLdzhLUTQ3ZFp4NW0yUUs1dmNXb3JOVGVqT0NrNzZ4ZDBX?=
 =?utf-8?B?bzFDTmpJbFVGVTYxYlBqU2MxNG5TL1ZYWE9zSzFKUytJcDhYQVFoR28rMzBZ?=
 =?utf-8?B?RGx4T1p5bnAxUDU2WVM1SXNieFRBOWI2Zit5QWhHb3NmWTJIVEsxMjIwcnBT?=
 =?utf-8?B?UDNVRC9SenJFQ1NUd0k2Y1RiaVVXNnp1MnBSVjBnVzRhWHpYaWh3M21SYjFK?=
 =?utf-8?B?L29OQTd5TUlYZ0o5TUtldWhZM0gwZHdENktSZUxQMXZxSFhpc1VLVjJlNW5i?=
 =?utf-8?B?eTk4Q0FtSDhGcDdTTGk1TVdKUy9NRjV1RGVIcG1oSzlrdzFlQkUxclpHK3Bv?=
 =?utf-8?B?NnB1NHdwTGptdG9nUk9WV0xTbWVoYmNFNGJWZE9UVzA1dWZleDRpTWFtbTNh?=
 =?utf-8?B?Q09IZzl1Y3FZR1ZBemVUY3dkVTJZNXdzUDRMU3VQaElhTkQzcEtQMXRxZG55?=
 =?utf-8?B?Z0JTMlk1RTRWNkhscTI1aW1KV1ZKaEp3bEZQcEN6Nm5LVUNvR2JGYk1kRHNG?=
 =?utf-8?B?OThIWkdzR3N5U2k5ZTFWdHJkV0J5eDZCZGFkSGphTU5FcXlHYlBMQzdpU1VU?=
 =?utf-8?B?cTRmY2s1SUNaeGpUVXIzdTZHa2orTER2VUhoWXFYTytoV2t2cXJ6K3M5elRN?=
 =?utf-8?B?Q210WVJQMTZSZHUvWHV1SlJic09MZWRleDc4V081clgwSkNoK3dQQzhGYk5S?=
 =?utf-8?B?Nmhxdy9BVzl0Sk9maTNBM3UvcDI2bEh6VlFTRytxY1Nua0o5UkxrNmkzeWxT?=
 =?utf-8?B?OFRmVjQ0NUtDUFVIR3VjcC9IdlpFUzZuenBzRC9hK0djbHJKc0VwUlA5UzJk?=
 =?utf-8?B?RmRjYWI1UWJlbm44OGlBWkxDTDRhVzQwbmFoQ1o3ak9mVnRpS3VPUDl5Q2d3?=
 =?utf-8?B?ZW1XTmFueU51cTBnRXk0bVNtbjlmcllwYzNlUXNmSC9pLzFiYTlSNjh3NTc4?=
 =?utf-8?B?b3RucGs1dHVSY3d6eXRJL3JHZDdMUjNGKzJXTmUvMjV0d1JiUHdYOER3UldY?=
 =?utf-8?B?aldqZmRPZmlNVDFLeEZXWjdMVEVJVzJwK0puakZzVE43ckdESlNwYk14Nlhh?=
 =?utf-8?B?NlYzUFZqQ1huQi9FNzNHTWZtaCtmSDlnZHB6SVQxenVXTWFXVnlieVZYdG81?=
 =?utf-8?B?QktmL0w0Vk5HUXcyY2ZHWWVmQXhUdm5RaUxyVWdjRlBCei9VbW96VEJVKzZQ?=
 =?utf-8?B?algxRkxxYkc5T1BOS3BVd08yNysvZktkS3RYOUp0bi9ZbDZyamFVZklRVGNp?=
 =?utf-8?B?K3BOYXplYk9oNjdYbGhIMnlmU1E1dWZKa0NwcUtRWXdIRnNjSU1xSzdvY0ha?=
 =?utf-8?B?OWFvRzhQQ3Noa0VCZjZjTFVjem40K25QSVlWNmN5Si9TZmtON2gzd1hZOWN0?=
 =?utf-8?B?c0FkU2JhSXMvRkxqQ1VybC8vR1AwS053Z0cvdzFHR0w5QS9uMGxNWWM3UWwr?=
 =?utf-8?B?RUo5NFMrcVVCd0dnR1EvancrQXZvUENiSkM4NFd2enlzdDgrL2dJOUhLWlZU?=
 =?utf-8?B?SzZIbjNucmdxaUZtR21kWVNKS2dFb2JxT0ZScE9XeHcvUmpIcVlKQUFLSVNs?=
 =?utf-8?B?N2wyUWpGTTNVTzltRC9GbkgwSThhVXB1d0lzUFE2NVRHc1ZPdDNJRWdBY29P?=
 =?utf-8?Q?d1lPrf16++93wkDfIaiEiLSUn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f20d8ae-5873-4243-f65b-08db8496d406
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 18:19:14.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcf4VR6xWNv8IjazmCN3QB4vOjDuwqptWEk/yUpdqHEgcJPIv6PZF344NJeRHxr/oE0bBXr4YqYADKFXTobR4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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

On 7/14/23 11:09, Mark Brown wrote:
> On Fri, Jul 14, 2023 at 11:48:51AM -0600, Shuah Khan wrote:
>> On 7/13/23 14:16, John Hubbard wrote:
> 
>>> Actually, I was hoping that my two fixes [1], [2] could be used, instead
>>> of reverting the feature.
> 
>> Mark! Are you good with taking these two - do these fix the
>> problems you are seeing?
> 
> I reviewed the one that's relevant to me already, the arm64 one, I'd not
> seen or tested the RISC-V one but that looks fine too.  I'm pretty sure

That riscv patch already has a Tested-by from Alexandre Ghiti:

https://lore.kernel.org/f903634d-851f-af64-8d9a-6b13d813587c@ghiti.fr


> Andrew queued it already though ICBW.  Either way it'd be good to get
> this into -rc2, this is seriously disrupting arm64 CI and I'm guessing
> the RISC-V CI too.

thanks,
-- 
John Hubbard
NVIDIA

