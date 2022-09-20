Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154965BDC77
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Sep 2022 07:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiITFbK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Sep 2022 01:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiITFbI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Sep 2022 01:31:08 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA835A893;
        Mon, 19 Sep 2022 22:31:05 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsvJo012260;
        Mon, 19 Sep 2022 22:30:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=x5PGXpUilcldjZvsngst7QiKrckZZijBWQ4OK/dib+g=;
 b=Oyzhdo4Jo9w5FegCNkfP5eXzog5000d3JWJldKnWcI+urnN8PB05myKW6ksPevIFGeJx
 9SCijserjlTE3ZSKm5gAOBpBvD/3+5qPk+TSoI7+m3P6PkIo/95/BX6X4rzG01uqoMg+
 mre7wxZTHzIL9FWy16KuGpf9AYEpP0N1Ww4= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jpkp3r94q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 22:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLUc8YSJezNA+Zos71IQ0zpQT8ld/YqTdcaiIhgHiOiPT/kDjmKGiv0rq4tSo4QRg9snxW71jvdc6NScsY/WweeWwHed5jbfCvo8NiL5uEYwqN+PW7+wWbYfKsbQkX1anjDorjt3d8egkAEGWk30h06eFj/n4rBxQzucgonnVCN+6AV44s9caJXltBXcqHDHZ30WsOwqTf0au9zxOEcJXft7FjPRBD7vtbyr2RhtfkfmG3z+cOnBN08oOIKpY9WV05j3QZ0lZ4HRjLrAR+E4Nl7OSNEC3yC01Sf8IMYyok66x2D3ISbi6z5rC9s2cd5YCWr8rigz20XiOU7Wmg1BGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5PGXpUilcldjZvsngst7QiKrckZZijBWQ4OK/dib+g=;
 b=HdrLOuHKXBjTi+z5uz3b2bgt9kkbop+YZvUEjVX+NFcrBQcXn/UE4a83YQOmJcavqkeuNgj00nVR8TXyrCk787ii4LeWwfRG5JY1lT3La74plYmVyG11cgDJQ5No8uhEMlPDHx97JHv0b1+QqdAvRQCaiXPzQJHK1MAbeZz92SVzyVOyqJ54OLZ1Qb2+fA0ot//TugFmh/aMnY6NhSu1HscNW+g5U/WbulzbUBtTSJQzs2LdI276/2skz3AppepVe2orc35G7vnJzRsqE7gwbwcSx5y4e57EdohQGj4nZOgDg2Mf+HEZl47BDyS4Wx57fW+MXg8RgA26lr0RqjI06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR1501MB1959.namprd15.prod.outlook.com (2603:10b6:4:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 05:30:22 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 05:30:22 +0000
Message-ID: <1e8f3fb4-a014-8146-70ba-65e451a64e18@fb.com>
Date:   Mon, 19 Sep 2022 22:30:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v18 02/13] btf: Export bpf_dynptr definition
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jarkko@kernel.org, jmorris@namei.org,
        joannelkoong@gmail.com, john.fastabend@gmail.com, jolsa@kernel.org,
        keyrings@vger.kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, mingo@redhat.com, mykolal@fb.com,
        paul@paul-moore.com, roberto.sassu@huawei.com, rostedt@goodmis.org,
        sdf@google.com, serge@hallyn.com, shuah@kernel.org, song@kernel.org
References: <64e8ef59363bcd0f314d4e1eb7483f4dd2b7dbcf.camel@huaweicloud.com>
 <20220919142754.626564-1-roberto.sassu@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220919142754.626564-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0086.namprd02.prod.outlook.com
 (2603:10b6:208:51::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR1501MB1959:EE_
X-MS-Office365-Filtering-Correlation-Id: c730eb52-fd04-411c-a921-08da9ac936b7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJamjkMNQmF98CgrZkZ71rdA2CSwKC7ma0Sq6Yy9u/13/1KUBWDLRLHnTsU0lqnMLcHwyNcsoJ5HyGo+MwHwV+6nM9dI+boQ4zb2hqczv92XLxzUtvP2uDqfHbYofQ2uLsXtT+ZhthsA+/OyERvvK9PTK33dcwodMWn7M4MxLiHunBakGPYI9oYWc5sjQLhcFG920hg4gxxMj6lTgOkDAcBIPGCgBlUR4z6Qzt7sWhb1XcNfg0Y3laq2lTIYqpQlrGIbcXvp6QvAUuMAtDytFiJFCyLOj2kUxSSzC8hQJLVweVajFIAzkbvAVH+PZPPPOPpkOhFsPTMKUss6rEy4vkNr03iiwDjsqPKwRlMtHyLmerVCs3laLxwRx/W1Q226LmG4K6IoLmUJM4TTj0xDP3cMrlotCxyYnE862zZ1toZQy4LAZUiEHrYv64ipwGXghSD7kGxy1CqyIBQI1+PLj/WMPBYyPB+59IkRa7FDvAIlqL7/iCM37QpedS9c1RsxoiDEdzixWkWy0UEVqSK3q86I8EfXrfVPCCIbaPvRxCmpvVBOzydxwDlsjQEwwWFfi5n7bN6V+nuvKfb0C8/TW2SIbBKpydB87HCOPhkPJ1661omyajVzfjoAfOyULwL9qYIYnikv37BZJy0BhKYH/kXDH2FlTmXTVdQ5SirMUZ7rbqRuy2NFMKzcga6bFtKEzFq7TLhUltzIUqRvCHeVwZzALiFsODcNsuYhViYUqer+2MWzV6G3VAI9eyjnOL4lAQZFdQhlV6VRjdw0yWiPbBjL+OFNi3o314rZ42KR9NI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(8676002)(2616005)(186003)(83380400001)(31696002)(86362001)(38100700002)(41300700001)(7416002)(8936002)(66476007)(66556008)(66946007)(4326008)(2906002)(6512007)(5660300002)(6666004)(6506007)(53546011)(6486002)(316002)(478600001)(36756003)(31686004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2t5OFQvS3BHb3ZPdjdHNFQxR2FuNGV5MndGSHFRVGVYb1hpa1JJalRQRGlq?=
 =?utf-8?B?SlRZUjU3SitwbE14bXp1Wm9SL01Ra0hNeE9ETGdMWmZta0oveGtWK3JFTG80?=
 =?utf-8?B?eHJGTEUzdE8vTUFjNExzalk2ZkVKdmNWcHU3MElFSXdRWXlFMFgxM201M0Y1?=
 =?utf-8?B?OHBxTnJFdDJCUER2d1djZUtjZmJrcjlvc0ExK1E1U2JwRkNFMmhhVzNkcHJN?=
 =?utf-8?B?aFdnSlkwR3J4ZkIrRWZjSCtuRDYrS3ZsMUdrdDlwaVZKWklGSkNMZUdEUjNQ?=
 =?utf-8?B?U0hsVmNpL2hScXhLajV1SXVCNEVGekFUYW82M2MrY3ZFTk50cUJ3dWpITWhD?=
 =?utf-8?B?VVFuLzJURDRoOFc0aWt1emR5L1FNTlZHM3l3NnYzT1d2cklQVzlCRGR3a1RG?=
 =?utf-8?B?My9ocVJsUk50dUlGYjNPYm5kUS9TTEViV2h1K25Vd3VqTnRIV0JaYlZCN0ZL?=
 =?utf-8?B?SGlyWklZWndRZTk4VHJ3U3ZPMmUrTjdrSUtMbE5NZm4yS1FXcEV6VHB1TkVl?=
 =?utf-8?B?VXVkTmVJUE9sQVVVWGVkTi9ld2crNVpsbi83emVBNC9zV1BlQXppckxRdmYw?=
 =?utf-8?B?V1BKM3QwQXhtSmY1VmpxYUxnUmJwN0g1MTUwM2tqOS8yTDdTRFdRenYwb0x4?=
 =?utf-8?B?REo1NTNPK05HMkErYjJsOTVTZDFudEhjZUthNDF0MEE0SzRiNEdvczJibEtZ?=
 =?utf-8?B?Sm4xR0NybnByMFJrcE5DSXZpd3BnQmxXUnhnSjZmOTc3dS91N3VVaGsyNTN0?=
 =?utf-8?B?V2ZvMVphMTEzQXVlL2Z0aVpiMVhwUjdEUzZYWmFjNllneU9jZ0dOcy8xZ3NB?=
 =?utf-8?B?Nnh0dmNrdEZLZW5FMnRRY2dMUjBpTnJWWHhwaTJaVExIVWRjNXk3Nk5zUVdz?=
 =?utf-8?B?SThrMDh1STdqeWY1aEtXbHFKYXVRdVNoVFZndE5RNkRxZGRjSloxdEthRlE4?=
 =?utf-8?B?S0xvbGYxelJNZ2ZyeHEydFlTYjFUdGlkNzZUbjdMaUxXWU83OUMzcEJtNlBk?=
 =?utf-8?B?dlJQb1hJWW4xWTZsMjNkcWZSMjM1Skk5UXNFeEs0NGEzVmw1WnA2ZkZHeloy?=
 =?utf-8?B?ZHV3eFluQmxrZ09GbkJ2TlA3c3Fha1ROSDBvcTJtb0xDNDhja2RoZjZ5RkUy?=
 =?utf-8?B?T1NYVzkvOFJxYStIUXo1aWZ3MjlIWkQxb09GRHJ5M1pTZ2pvNGJUbmFKTkMx?=
 =?utf-8?B?WnRQbjBFQlRLZUsyalA4Q3NRejBjOStyQzVHQ1h2WW1aK0NCWUo5UG0zcENp?=
 =?utf-8?B?VENVRjg2OFQ4MjFNSHBVZVBKMXc1cXVpbTZqeTVPQ1JCV3pCRGw2MEdyWUd1?=
 =?utf-8?B?TmxxVTBDRXU3ZVFpVjgzbkx6Z254NWh2TFJZeUJvSWY4SDdUdS9KYm4wMFpO?=
 =?utf-8?B?NUt3elF2THJHTnBrUy9kbk1JTk8reXN3SGhHZlFiSCs3d2JpL2Z4dkZjK2dW?=
 =?utf-8?B?ZG51ZUtQZHBWdzNTSkxibk9PNHhMZkpsMjVtOW8rZmRGZ3IxY2NGbWEzaWcx?=
 =?utf-8?B?cEphT1lmOG5IaVk5YytaNVBSSjh0bXUyM3lJaHdwVmd5RWJiVzNsTG5iMlU1?=
 =?utf-8?B?dUd6VVVVNUplRmFUNVd2QlBSZVRTMmMyN0Z1Vng3YzlVM0xXL3JQT1p3cHZG?=
 =?utf-8?B?RU5oaTFROW56MUdmMVN3QVY2RGU2ZXN1MXBrV0V0eFhWUlVWT1lMWDRjbExh?=
 =?utf-8?B?N3BTUmRlTWRtUjFKaGE3VjBCMHVLVmdadHc5MnZZWUJhM3ZwekY1d2prU01V?=
 =?utf-8?B?bXNlMnNCMWVIc085VXRvdTFIL0FmZVd3dG5hWEtCUkR6cWNMb2lSRTg1M0NU?=
 =?utf-8?B?NGEvL3JZQVF5VjNkRXBRTVJlS2hUN0Q2OUZPQTJIUlducmNhSmROMnJkWlRw?=
 =?utf-8?B?TUdzMk1kWEJZT01WVVgvOUhMQUQ4SVVDYVJrTkszdW1iaWJXamRCZ2hBUWYv?=
 =?utf-8?B?SCtVcEMvMy96dTZwUGw5WDhWTmIyL2dKSjcvWmhOeU1Ic3EzT2Vkd0M2S0px?=
 =?utf-8?B?clp0VVJmZEJ6ZlUwZVYrS3pVZzQwVFBBYTE1OVI2L0NRanhtcWhIeFVFdUN4?=
 =?utf-8?B?bmlSdHFvWmE0K2hEOEdLNUI0NjN6aW9tODRDc05WWlFOQTA2YmlsZyt4SmJZ?=
 =?utf-8?B?WGdabTNQL2VwZ0dIb21QRXVDV1VJUWw4K2tSNC9OdXFtSzM5ajNUdnkrTFZs?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c730eb52-fd04-411c-a921-08da9ac936b7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 05:30:22.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlquMyKssCg5BHQZt/3p51ZckTeGkX6qseShunZXUXpsjqZVti8posbV/ZxLMIy5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB1959
X-Proofpoint-ORIG-GUID: yBE7FvSA1P7sBt2KxXgWMBXjmwCyE2Jf
X-Proofpoint-GUID: yBE7FvSA1P7sBt2KxXgWMBXjmwCyE2Jf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/19/22 7:27 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> eBPF dynamic pointers is a new feature recently added to upstream. It binds
> together a pointer to a memory area and its size. The internal kernel
> structure bpf_dynptr_kern is not accessible by eBPF programs in user space.
> They instead see bpf_dynptr, which is then translated to the internal
> kernel structure by the eBPF verifier.
> 
> The problem is that it is not possible to include at the same time the uapi
> include linux/bpf.h and the vmlinux BTF vmlinux.h, as they both contain the
> definition of some structures/enums. The compiler complains saying that the
> structures/enums are redefined.
> 
> As bpf_dynptr is defined in the uapi include linux/bpf.h, this makes it
> impossible to include vmlinux.h. However, in some cases, e.g. when using
> kfuncs, vmlinux.h has to be included. The only option until now was to
> include vmlinux.h and add the definition of bpf_dynptr directly in the eBPF
> program source code from linux/bpf.h.
> 
> Solve the problem by using the same approach as for bpf_timer (which also
> follows the same scheme with the _kern suffix for the internal kernel
> structure).
> 
> Add the following line in one of the dynamic pointer helpers,
> bpf_dynptr_from_mem():
> 
> BTF_TYPE_EMIT(struct bpf_dynptr);
> 
> Cc: stable@vger.kernel.org
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 97e03f521050c ("bpf: Add verifier support for dynptrs")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
