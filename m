Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99AC636010
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 14:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiKWNhZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 08:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbiKWNhI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 08:37:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC270A13;
        Wed, 23 Nov 2022 05:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDJbICxQ8w8BzgKCSrv072ecorp7bTH6fBfbQ05/UHIQmX59Aapzh8jDBCaS7VZdeylJL+i/hvMHXVHp8Bw18m+iXgj5wW+uT769cH6waVGpj4rVyb1+IaSVk5Gc8jkG+jn4G0IKUheAeAjsE+r11mZMi5KNPlxxbx5RqUzZvH5HdV83PnZVvidmpLfoEY53XWMLR+baaho1jWJ5lMKXQX4Njs2/7YBAph/Rxy+h5hZ6kdtSV81K5wXvWspJfQy/Se18oo3cihDOkAHSDnmPno68WTXlIdtsrcC1Ag3lgAHb0TwrA1+9md7XVyrpil3ln0mJVN+Uhb0/GJlMTCd6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGYTjg0iV6GcZu0muAsvUY3GwRcH250ChKEIu4CmGsc=;
 b=fV7otKsWxlcDwtnka+46zGl06U+MY4siKMXvgzxFnAutj14gjWI45FCt9BU4vhL6miLd17JDB2IVSHwDVhUWezlgCra8sM5FaxbcrrZ7ilNBVa1L0oHM2uK88MdO4Z4u1QtgyQB2+LjT2EAx9RGnDR9DufeVub5KTwzIAb4NESF3sxSYl7+yZBvtuwPJyq0wz5BrLRC03nyOZC27MFEOWo6QW17OyjAT05IusIo62nbhoEBtpVnMB7+kb08N7TOiPDdEH228ZELxDayqPeqWslzUo1J69f4VpbCXuLlLnvwAPCrQsAakl52MR2wdyn4znuu3ArHDhGw3DxPvoTVABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGYTjg0iV6GcZu0muAsvUY3GwRcH250ChKEIu4CmGsc=;
 b=I5ggdLnzpJE+qiPgHTFCDDhWxp3AgMXE15Q7luQP3SWn9plDwxXQxXhRU98XEmCwZ/fsVEIGMbJX6ZMewOphMdJMsNBqaHg5yuUAQ3+IgQIQEOKUFe1ENdyY19cGK5Oeu5FXkyX0Evw0pVoAcXKzllg9ImB99HaV6fRbqG6VyftFlE1U2IkM/sDzEq5aGXm69FGD0IkP+0sjoRzsL/YTbw6Inx8vmrWGhgAIX025Z5X2dpuJWjnC/cpsL6WUxi7XKhZ21Nd1RUTVLxHdsMD600+eV+0YG5Vjyrj27tEAYIdJ7UKrEEQOXM7fOtVsvc8faoVwf1XDsFamB4TRsY01bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Wed, 23 Nov 2022 13:25:11 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::8edd:6269:6f31:779e%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 13:25:11 +0000
Message-ID: <ff1a0b34-71f2-cebe-a6ef-675936b276eb@nvidia.com>
Date:   Wed, 23 Nov 2022 13:25:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH hid v12 03/15] HID: initial BPF implementation
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20221103155756.687789-1-benjamin.tissoires@redhat.com>
 <20221103155756.687789-4-benjamin.tissoires@redhat.com>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221103155756.687789-4-benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f2c350-e92f-47ea-9d67-08dacd5625e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zS1NqGZQvGFP4YKyYrg2PariLmcZLwS73fc7FM0GXHBPuFgfgw2Dh7xj0dwJ4Ru+cjtapO/TmEpPTbafo6V0jV+fqi6T8I1uCUkIMR2tVCq/jHHXHFRJVIZZLkNXi0YedQ55+pCm2SETJV+CUX9m4+q3SUsL0rma+iPQWsYxfno85nc5iTpFGZcCTVDpJ/smDR0rosUOmwNESRIFkjKB1E5PjbECG2bArqOr5gF8Cor6nw9foAusBo/xKMWu7aziL78rYZbRDcWANcPR9ypg2izg9Hdq43DIcAp9vpytI+FJEIHqrQCf4v9oLSzw0VErTmjRXYpblJef4/OvJnpE8S9YFvC2xBo8JGzV6fuqMCd6CmnwYDJaFLxL2SWFf0Tdx+jL4I536zTS+g5MuF73eg7mX0r7queOU55iyW9V1voxFPAWjcJ2MAmvbI2VuiDMpGTvXV/SoRqtSTa29ufIcQP5hJXK8njUSA0er+ekbVbAWwSVmWNBUrZiYrvtIeBo1NYAActXsZN7lPuW3VPUU4g8y/erPtPpbX1YDqZorijzfisofE1lbsRYdePWTTC7pqRLWkgDolUO93zFBmdVPh+++g7fs0L8uofarFMXBMWL+1Fo3iSXVaWFYp2vZwv9nzPcsSKj6oQCgNIZ2HUrMmH9xPWGhuhf0hAqHbqkXL1Bh9ITZdxyC4Yr79QfR/4yeWSzJc4l8viab8USSnmuvsetYju58D4rh16HRW9yekI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(66899015)(2906002)(38100700002)(31686004)(5660300002)(83380400001)(8676002)(41300700001)(86362001)(31696002)(66476007)(8936002)(66946007)(66556008)(7416002)(4326008)(36756003)(53546011)(316002)(54906003)(2616005)(110136005)(6486002)(26005)(478600001)(6506007)(55236004)(186003)(6666004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3IvZlR4bWVpTm1UQ1NJSFhHNWd3OFoyK3VYL25jeUVsb0R6VFFJWEpaSFF1?=
 =?utf-8?B?QmtaQUt0Rk1sb3NzV20rZ2xVOUNCWDZBMldCSXIwWlYzYUNNTXkvcW1rMlFy?=
 =?utf-8?B?c1pTVmN4cEJtbUtZaW9oM0xlQlpHM2MwQ0dzck1RMy9oQ0o0R2IzQ2hFTkJD?=
 =?utf-8?B?MWM2VHpWRGtzRUsyMEpDdE9mQUpJS0swbjZFVXpVT1RFeXJaSWRqWUtpTytQ?=
 =?utf-8?B?ZzQ5OWN3RSt1YnNRWGRxSEo5STVMZWNhS1BWTVFFOHJFK05tTjMra3pFenBD?=
 =?utf-8?B?NjhHZlgwRE5DYjlsVllGRnc3ZFZjSk9CZFBWaDU2ZTJ5RjROUU9oNTFTdW1m?=
 =?utf-8?B?SmJTZnR4RmlQR1AzYlMyYnd4T2cvODdFM2NFT1JHVGIxSHFNZkZVUkd0bnF1?=
 =?utf-8?B?cWdVWGNoQ05LSlRjc3B3R0FpTTdDbittTm9zcUFaZ29mb3JPeDduNXpBYUJ2?=
 =?utf-8?B?OGpjc2lBL0RDMzNrWGpVUDNoOVErZ0taUTdUdkV4VUlwa3FabjJKdVNteDJH?=
 =?utf-8?B?QVorbk5JeFdRRHo5WS8xdnUrSEp2ZkpESmJVU1k0bkdZUVVGbXRqZ3F2eTBx?=
 =?utf-8?B?SDhZdkJqNnBDMjhsM3JCaUtFdndYQlh3bDVNeUMzTnBlV05vWVlVcHRheGFP?=
 =?utf-8?B?bFk1RmtUVC9mK2kxcHIvSXZSbC9lbmFYTnpiVnNZOU1rdTZhUlhJT2lFZnRk?=
 =?utf-8?B?Um0zS2hnSWdSSHRqY1F6bXZxMzF0bWRORkhqck9ld09ldExuWlMzRXREdzVp?=
 =?utf-8?B?UkRBVzVmT2RqUGZVWEhVYUlENzdoVUs2OU1XSlNPUUw0clFqWitpTHZMYUQ2?=
 =?utf-8?B?cTEvQU5kaWtDbXVLZC9BenZaTHBFd1QxcVYvOTg4WmtZMno2R1FwaFdmcERL?=
 =?utf-8?B?WEd4VHo5VnEwSHFGcGJCZkFJRG16Y2xJYXNwcWdtZUd1dUJINmM0SnUwZnlB?=
 =?utf-8?B?bFJtRFJ3MExQK0RuS0h1MERWY1NHWGJiYXZqMG4raGtJWmRmRGM4QWtGQ1hJ?=
 =?utf-8?B?cnBHd09pUGd5SlVyWk1za0VtQ09RbEE0RjRRVkJ0VUtDbk9EL20way9sTXZJ?=
 =?utf-8?B?MENFQXVwZ0FFeDhVWEFVVVZmaXJqTFFGUEtCcVlOODY2TS8rN1MxZHRQMGtB?=
 =?utf-8?B?Si9jNkhIZitnSk9MaGxTdVU4bllRcWxvR0poc0J3OWZXSFRiN2J5cVUrZXRK?=
 =?utf-8?B?R3hOS0orVitrditDdXdQb1pCSUE2Q21jMVF4dE0zRUpORHFpendwTkxnam1t?=
 =?utf-8?B?TVBiK0dhMVFzQ0p3dUd4VmY3aEgzakdmakc5dHQreUpIbzNDMHhLODVsN09P?=
 =?utf-8?B?QVpjbncxMDJtZHE1SnhaZXdPalZKMGVRM1haNUh6ZE5oL1BqeFR1anpwcnI1?=
 =?utf-8?B?QUdiU2VmTENsQnE1K29TMElXd0w5Sy9lalRlUHBCU0xpS3FXN3VRMncvcDVi?=
 =?utf-8?B?SVM1Rmg2c2oydVBuUkViUTlUUDlBbi9Vb1EwT0g0R2Qvb2ZwZGR1RmJVbFIy?=
 =?utf-8?B?WDFIWEt5N2gwTS9xMVFIcTBaOUJ4MjlyZC96ZnhOcEpKZWJLcWpIOE1WZlA5?=
 =?utf-8?B?Tm1nejRLUHhtNUtEeGhWclJIUEpoM1A4dUl5RWkxVXFaaXpZYm1JQ1NRcEZj?=
 =?utf-8?B?eHRnc1M1VHppZGtLVFVMZVg5OFQ3ak9uNnc4T1ljdGprMW9ielBuTTg0K2VK?=
 =?utf-8?B?VEhTTlM3aG1LVlh2QzdUTFJRR2NhbGRWeHBORFY1ejhJQ2YrUGl5aytTQWNz?=
 =?utf-8?B?NFFXR3R2ek5oRy9XR0xZWHo5RGFNSGY4K2NmZlFveldESWdIb0d2cGZ4eFgv?=
 =?utf-8?B?WTlKUy93TmJPWDJpRFdkY2h4MExjWmI1cGVobVJ3enkrN3o0eUZlSWdDRkFm?=
 =?utf-8?B?NTNmWnFQWmN5enNSMGwwUWZGMVY5cjJuNXoxeTBLM0ovaUFBYUY3RGxoTDk0?=
 =?utf-8?B?ZGExN21lMC9KZFpVY25hVyt6QVZTZnVlbXd4VElCc3JyblkrVWxVZFUrbERI?=
 =?utf-8?B?OC8raWNMdExWSGxwRGJwejVvSHBFVmJJUHMrWTYzRVVJSEF6eHZkL1lpRWcr?=
 =?utf-8?B?Q1RkN2VOb1lzazY5SitMeWlCamIyMWxyM1BYZmxkT2xFbGJsK1NoeDcwdG9R?=
 =?utf-8?Q?FW3ZVwX5+bRmjKTlNiT0n46lP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f2c350-e92f-47ea-9d67-08dacd5625e2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 13:25:11.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+5yDZ0QzH6rtJgL5gkgHWrxi8RrTJ89ioa1QPSFoiB6MulrtO6QNKfCIEnHB/FWavFagQxn/LCdu2nb8eswOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 03/11/2022 15:57, Benjamin Tissoires wrote:
> Declare an entry point that can use fmod_ret BPF programs, and
> also an API to access and change the incoming data.
> 
> A simpler implementation would consist in just calling
> hid_bpf_device_event() for any incoming event and let users deal
> with the fact that they will be called for any event of any device.
> 
> The goal of HID-BPF is to partially replace drivers, so this situation
> can be problematic because we might have programs which will step on
> each other toes.
> 
> For that, we add a new API hid_bpf_attach_prog() that can be called
> from a syscall and we manually deal with a jump table in hid-bpf.
> 
> Whenever we add a program to the jump table (in other words, when we
> attach a program to a HID device), we keep the number of time we added
> this program in the jump table so we can release it whenever there are
> no other users.
> 
> HID devices have an RCU protected list of available programs in the
> jump table, and those programs are called one after the other thanks
> to bpf_tail_call().
> 
> To achieve the detection of users losing their fds on the programs we
> attached, we add 2 tracing facilities on bpf_prog_release() (for when
> a fd is closed) and bpf_free_inode() (for when a pinned program gets
> unpinned).
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

...

> +static int __init hid_bpf_init(void)
> +{
> +	int err;
> +
> +	/* Note: if we exit with an error any time here, we would entirely break HID, which
> +	 * is probably not something we want. So we log an error and return success.
> +	 *
> +	 * This is not a big deal: the syscall allowing to attach a BPF program to a HID device
> +	 * will not be available, so nobody will be able to use the functionality.
> +	 */
> +
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &hid_bpf_kfunc_set);
> +	if (err) {
> +		pr_warn("error while setting HID BPF tracing kfuncs: %d", err);
> +		return 0;
> +	}
> +
> +	err = hid_bpf_preload_skel();
> +	if (err) {
> +		pr_warn("error while preloading HID BPF dispatcher: %d", err);
> +		return 0;
> +	}
> +
> +	/* register syscalls after we are sure we can load our preloaded bpf program */
> +	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &hid_bpf_syscall_kfunc_set);
> +	if (err) {
> +		pr_warn("error while setting HID BPF syscall kfuncs: %d", err);
> +		return 0;
> +	}
> +
> +	return 0;
> +}


We have a kernel test that checks for new warning and error messages on 
boot and with this change I am now seeing the following error message on 
our Tegra platforms ...

  WARNING KERN hid_bpf: error while preloading HID BPF dispatcher: -13

I have a quick look at the code, but I can't say I am familiar with 
this. So I wanted to ask if a way to fix this or avoid this? I see the 
code returns 0, so one option would be to make this an informational or 
debug print.

Thanks
Jon

-- 
nvpublic
