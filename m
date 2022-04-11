Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94054FBB8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 14:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbiDKMEG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345722AbiDKMEE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 08:04:04 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F49C37AA3;
        Mon, 11 Apr 2022 05:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLnzCVET9i/+Q/FV/TaHodH/NA3KdXBxSHPEemRs9RUPWZfUDECegCP905AgSXrZlkq5ANAKmMF7uxuLcdzmaND/pKr8mh22mCqJU3sTzIrvLccwzBbqbg87yqpAkO7p6cgDJBOXS42Q0/ih6I5ueoKpusJd5q7C+8GYFpFLm2CNQS66n3y5vO+UX2nO0QB2OOVi9MFfeE9EdN3/qXVtoN0XCn3V5x0RsyiYSjHfhrN9zGT378HO1TpEAfBlwa2uRzslLcWlUNCYqB+NyaRBtFXz8bElY4Qs1Nm0YbCBnR3pA/5IRbqsvUWYaNMrcBoKotXhsbJ386lK1M1Y9vZVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TnPsOE7/1eMle8tq/6yXwbE3koGfFNxfSGwCBdKxRM=;
 b=ZUJBU96Hq2HLA1j7ERtb+YxWqfNrXdDauK/Xn25/kO9nm/77/yS/Jd7MmOxY0WSiHsraGW762QZ0S9XgjiOgCy/tpM2INVQ33v7m0C74yltgnKA3MDL0KKKR7khzh5wzJs04gxsfmCEVv1KvyKZ1dY3eEu5adCAbMNwdN7x79IEIs5y0A/ORaiMp/ICZfX/7/2UvjDSbUa61mn9YJEcDC81BqCwIuLuL1xb02GjpvsaiTs9m1PIqdVYYkBqmkUunOgm+OpS4pZcWFltyUm6AahqJ1RACxbfre4Ott+3bt4u5ClkVZ242RBpOKSarhmOZVbIjopsmzAC3pXhQr0Ft9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TnPsOE7/1eMle8tq/6yXwbE3koGfFNxfSGwCBdKxRM=;
 b=MsrPoYMTIjBHF6gI2xxwViLGQiE+FeqOOYqMSMBlbrb5NR5i3FjW32/zfPuzAVgoD1DGHCZ4SXGOkdw/7eebFV+bBMZkQ+Fw+sAvE1XxgBFLGA0lW13q6MHonDKnCF+l7QFaTf+cjeTcMbgU5E7ezxelEKHaXCQJNbrG8/byy2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) by
 BN6PR12MB1844.namprd12.prod.outlook.com (2603:10b6:404:fc::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 12:01:46 +0000
Received: from DM5PR12MB2470.namprd12.prod.outlook.com
 ([fe80::61a5:5647:ecef:4bd2]) by DM5PR12MB2470.namprd12.prod.outlook.com
 ([fe80::61a5:5647:ecef:4bd2%5]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 12:01:45 +0000
Message-ID: <0790131c-95af-676f-c475-addd1191eacd@amd.com>
Date:   Mon, 11 Apr 2022 17:31:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shauh@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, seanjc@google.com, diviness@google.com
Subject: Re: [RFC V1 PATCH 0/5] selftests: KVM: selftests for fd-based
 approach of supporting private memory
Content-Language: en-US
To:     Vishal Annapurve <vannapurve@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20220408210545.3915712-1-vannapurve@google.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20220408210545.3915712-1-vannapurve@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::13) To DM5PR12MB2470.namprd12.prod.outlook.com
 (2603:10b6:4:b4::39)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb220a0-3729-477e-b6eb-08da1bb30c96
X-MS-TrafficTypeDiagnostic: BN6PR12MB1844:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1844E3DC362D74632287D37BE2EA9@BN6PR12MB1844.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXl9VzHJhXEs0020MDOpNhH9V6cT1RwnLljY5dP5H3q7v8612+kswJAN1Cr8J37yLDOxjnv1asPbF0+f+NLB9ERvaIONaT20GAaR6AmTg0dlaxnJnUdCfQT+pESB6ztgB9aQB6TdbkDeKGIialgQBvYpVbSSbieiJPdAUwENe4J0HOtSWUNdYuC5wpdqYms2ihVJCH4h5xGPtgkOuNEH2zetR1XrSpFJ60k1ww29hTqoRgFGv/zmmzfHsAtS9ZvDVyAzZtLXRQt7Ucv36kD+Nqzo+/9qQb34v8WO+wtb+frzKcfB/AgTddbGyTPpf5mVy73U2XTJGrATJAcJbIpXDC+lzo4L3eu//DiOBDhtgjWI1PByt9VckSJicLP8OWtzAOmMGgPrLuolSxUK9EVo0iLhJ/UFW46EnsX/hgbzx0ITGKypOZ6rA9KaVOZkgDBot6eA9rO1S1uf/q3L0MC7MiyZTWjuvqxEtMHaXOyF/NAdsk81oUS5+CFNDifpHYUhL1eTrTe0UJ/xsFpwyEdSo8N5zYLNGViMf2OAhQu9mH7PzYFJAVEDTaHfQ72YPuxUIGW+lqcvi2JoYeqRh6v9F4TAiv7go+2jDgA9VI6B3Tt1LD9U1lsOE0OZYiDTCcOppe/xlp0koVHHASRSpdZnhQa6Gfv6fXOxb2X7fNMANw9AlRARmiLx9jsYNtAHrjD1090/ZUnHHJWqAkKpnP+0Yao8yfM1E94NWWjvxfhSUQYSTH1KvHfQvC2u32rSF3quwmlBRtHUdfqRQtEPPnj/3DzvqGJhvbzmIDXSaDM+2ToxvCxonBbYE4eG3w5wPArJgObVi2io/EWEPoo33ObnELNUzlEWwcHAY9AERNa2NPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2470.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(966005)(508600001)(36756003)(2906002)(66476007)(316002)(31696002)(4326008)(8676002)(6486002)(66946007)(38100700002)(8936002)(5660300002)(7406005)(7416002)(66556008)(6506007)(186003)(53546011)(26005)(6666004)(2616005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxIa3J0WUtBTzVBZVJoUDJtS25kV1BuMFFLdlhmVGxUOW9oOVo3cWJUYUQ0?=
 =?utf-8?B?NkRLS01Mdm93aXJBSGZOQWpDUXo2L29wc2NjRGRGbmY1NU5OaEdhWkVGUGFi?=
 =?utf-8?B?UFhaa2JaNm9QK1c3djcwS3IwdEFJcmJyWnNOK2NlYm4zQVhiWCthWlo3b3Bm?=
 =?utf-8?B?QXJnTEpNR08rM1BZYkMwMVNXT3JyOEhsQkZvM2p0ZWM0dVlMQ3hpRmp2QUJG?=
 =?utf-8?B?N0lQSUgwTjgzZWFCb1gzeHdiT0xibkNwdDRRRnZuUmdSeW4xSllDN2svUVM1?=
 =?utf-8?B?MEw0MDBVdzI5SUVRQVVsd0x3K3FDT0ZEcy9XeFFUb3pHa1pPejkzbHV3RXpa?=
 =?utf-8?B?NGJmWnd2VmRhTlNacEVMMFB2dW55T1VITjZFbzdOR0ZXTklZeVVqREtvYnQy?=
 =?utf-8?B?dHhkcDFFQURRSCtGTStNVHJ3S3RWbmcvMys2K3lZTTd3VGk3Q3JPcTE0TEFz?=
 =?utf-8?B?ZTh4RlNlQVBFUTYydVRvRlMxODIvR2ovSTRWejJlTld2RFVJbjhZZUlxdEQz?=
 =?utf-8?B?SG8veWt2Y29PdVhNYmc3ejV4RFBQODhUOFVFcEJEb2JISENzZ0c2anQ2MDgw?=
 =?utf-8?B?NGdsdDg4eS80ZHl2dkEyM0p2ZkFSS0NvR1BCc0hIS1N3WXdxdFVNYmxoMlFP?=
 =?utf-8?B?TmN3QUkzSk4zQ2RnTHZDTWZ4bmtVNGR6b1BjOEYwaUVVcjFpaDNvVlYyVVgy?=
 =?utf-8?B?eG5uaExEZzZHWkR5ZndGeGZEV0JVUnBUSmZQT3RkdTF4cHlRSWZNNDNCOUtC?=
 =?utf-8?B?Y0dEMGg3R0Jub3ZKd1BXcndBSFZ0K0VkbEQ0eWFhZzBCT1hpenlKeTlVMlR0?=
 =?utf-8?B?S2FqZ1JQNXpPSDk4cjRKekRqczFYOTdoWWVqNVdYandQZnE1YWRiRUl5UDFR?=
 =?utf-8?B?bFpRdGVOYUpublFabSsxRnF1QlBCQWJ3RzVEYTVpeE5oUjB2ZHJ1SHFCY1dJ?=
 =?utf-8?B?c2NwUFluYU1KMytPY3RSR3NSclhjMTVoMysxbHl2enlPdlZSaVMva0x6c3Jv?=
 =?utf-8?B?MVpXV0F5VFFFTUpBbjRCQXA3Qmc5dklKeEtFTUxzZllQTEs0em9rdkFVVHVJ?=
 =?utf-8?B?UkEvVHdHNVI5VDJQV3VIdWYwSXhEZ1g4TG9lRWZmbTJ1NHVaZWZXaGprR29n?=
 =?utf-8?B?U2lQYlRVMndCMEFqM3cyUUpwNUluYVRla0tkeEc5UFJiYTA2UCtBK2lNU0lR?=
 =?utf-8?B?NG15R0NTVnVGS1pIMzZIOGE5U3ZoMngzbGI1Rlc1WTlwRC9adFJ5NXpIb1Iy?=
 =?utf-8?B?OWpaT0VmeUxCeEtSbnZQRVlZcHI5cGpBWWtDQjNOZ2twTzVDSDdzVGtMWUg5?=
 =?utf-8?B?S29GZlNwa2pROFpTVUJzQjdRUkVpOFFqbW5sMThFNHFtUTFsZFRMZENXWWNN?=
 =?utf-8?B?alVQTWJlRHNTVGdlMW1PR0FFcFBwRUw5Q0dZR2tHMkRjMUdLN3lYdHRxQXBO?=
 =?utf-8?B?MEVCZlVzQjB0Nnc2bHErc0RmYnhDbGJ2NFFRVHJxTkxLWWlRN1FqVFl6S3ND?=
 =?utf-8?B?RTdSKzZLeEpzNGYzYTJPTFRwZ0RmVWROajI0ZTdmREUvRTNqVGh0TzZJUStE?=
 =?utf-8?B?VTJIY3E0WHFPa2M0eEdmUUpsOC85eHNMcHNwaDlLbDd0V1UvWFFydWtUbHZJ?=
 =?utf-8?B?aHVZcGVac25lK3FuQTlFMkpVNXBQY1l2UUhuaFkzK2xFYW9oOEhmUmsxWkl2?=
 =?utf-8?B?Z0NlSEd5bVByek0zc2NoaFhpeFRtNlNsa3JEMGc4NmdoUVhGbmFKalpwQ0xF?=
 =?utf-8?B?Zkx5cDFGajBQNUh6aHRleCtKQVBnZ2tvcko4RkxHaDN1SFExUHFCR1BLUGNU?=
 =?utf-8?B?TU02WkdQNk1NVjhJL0lPSHZFWlUvWEZFS2NrOU9KRjBnQWI5Ri8vZnZuWGhn?=
 =?utf-8?B?Uk1DMzhocUhoeWI3TFNhKytlbmRIS2lEVTNMdlBmNzJoZ2tmR2FCU2c4OWhS?=
 =?utf-8?B?aHRkcDdNZ1lQYUtsUmV0dVdSSTUyUUhrbzV6YXZhN0hGclRZakJzdnU1alJL?=
 =?utf-8?B?ems3bW1xVm1BSEZRWE55UnFQS2kwaVFQcU5rQVMzV2d6ckxtNnN1aVY1NUYv?=
 =?utf-8?B?MHZ1WU5EeGpscWFFYzJpUFBqWHNrRDVZWWRnWktLalcyWS81UjRGR3RPTmsx?=
 =?utf-8?B?eGFxKzM4clNBZ1c4cmVLRFdJNExGMHQ5OXZMeDh3UUFVeDN6UllSbEFCKzJw?=
 =?utf-8?B?MDVSVlBDNjRzakNaM3VRelVZNFBiTHN4bFBXRXlSemNvaEFwQ1hiNnB4SjBu?=
 =?utf-8?B?bFdBYmRtcWhWTVpIS0tzRm5LcW5kaXN5aDlBOFI4Q2xSTElySlo3VXZPOWJD?=
 =?utf-8?B?R2xrZTBwY1VEWnEwQ0tleTFHNENjT1I2QzhObmM4WW5nOTdqU2lQQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb220a0-3729-477e-b6eb-08da1bb30c96
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:01:45.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30oiMyxoNGXZLxwbGkIpJMpKD3KFhx6rKqyQMJozjz/Da1LppfsDXpHnGG0PfK5xSlyx+92K2LnXPzjsPpOHgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1844
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/9/2022 2:35 AM, Vishal Annapurve wrote:
> This series implements selftests targeting the feature floated by Chao
> via:
> https://lore.kernel.org/linux-mm/20220310140911.50924-1-chao.p.peng@linux.intel.com/
> 

Thanks for working on this.

> Below changes aim to test the fd based approach for guest private memory
> in context of normal (non-confidential) VMs executing on non-confidential
> platforms.
> 
> Confidential platforms along with the confidentiality aware software
> stack support a notion of private/shared accesses from the confidential
> VMs.
> Generally, a bit in the GPA conveys the shared/private-ness of the
> access. Non-confidential platforms don't have a notion of private or
> shared accesses from the guest VMs. To support this notion,
> KVM_HC_MAP_GPA_RANGE
> is modified to allow marking an access from a VM within a GPA range as
> always shared or private. Any suggestions regarding implementing this ioctl
> alternatively/cleanly are appreciated.
> 
> priv_memfd_test.c file adds a suite of two basic selftests to access private
> memory from the guest via private/shared access and checking if the contents
> can be leaked to/accessed by vmm via shared memory view.
> 
> Test results:
> 1) PMPAT - PrivateMemoryPrivateAccess test passes
> 2) PMSAT - PrivateMemorySharedAccess test fails currently and needs more
> analysis to understand the reason of failure.

That could be because of the return code (*r = -1) from the KVM_EXIT_MEMORY_ERROR. 
This gets interpreted as -EPERM in the VMM when the vcpu_run exits.

	+	vcpu->run->exit_reason = KVM_EXIT_MEMORY_ERROR;
	+	vcpu->run->memory.flags = flags;
	+	vcpu->run->memory.padding = 0;
	+	vcpu->run->memory.gpa = fault->gfn << PAGE_SHIFT;
	+	vcpu->run->memory.size = PAGE_SIZE;
	+	fault->pfn = -1;
	+	*r = -1;
	+	return true;


Regards
Nikunj

[1] https://lore.kernel.org/all/20220310140911.50924-10-chao.p.peng@linux.intel.com/#t
