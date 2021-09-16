Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFD040E7A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244494AbhIPRfh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 13:35:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:16281 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349368AbhIPRdU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 13:33:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202778789"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="202778789"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 10:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="516848629"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2021 10:31:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 10:31:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 10:31:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 10:31:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 10:31:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4hqkzQSbtrZvxd0/ORFQoipAYncY47xnwD0F9JpBWPZtMh4Xlk1spERCE5qQou5mje+544Ow1hePa6vgEIRYLezJIlcYRGtBskVq7Ez1WCYYhktROnqCc7b4Od8GsHzftmhAE1I3RQIGx6+omTIsRmjTVZh8e+T8DxCOk5f5k+wvSTyl/jIen4dM8uiN6IJ+FUnjmnAN01HrRqa1/EfqqiAJOa8TIpkkhLFazXET0sHhRAeTRxNV+2O7VzD1FSv/jFXDsC4khCnYdPPbcPTIo7ASZzLZlLk1cSkBy7zxbhqIjr3Hlo1co+THacXHTQIK4jbmtBZVthLS1ovQiHEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=l6o++BpE15BSf+owshhGyx6/r0lXSqSOqnGKIDByw9k=;
 b=RktkirZwK2LW66WIAfS2JRihDC12mFIlZQWQ7Od9AXU5Q/SO/phdyaUHAnVH0bOZ5QVqcT9DPyMbZS7+vQytXguYR9BZP3O7BOfoFwf7Ushvw9OcjEyX39gcc5eG5U/zxF851RK06409Wj2v4qedj+dNMV1+SCF672ROGi5LWdIIm0tni/BKg6mjWaoAWKgsMzMorgy+/e1wkmy8SLJcvcRT2Bn4y3fYmFGSgH0dooq2PUAxnGUYa42jEkx89PfpAPRRCjwYCNTucK8YJSZz/hK5NY1ukd0IvMWs6FEf6L5tlkRgyCg+ae1+KeSjmChUYWdvaLQICiJnDnbveOSjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6o++BpE15BSf+owshhGyx6/r0lXSqSOqnGKIDByw9k=;
 b=DaxrrAMH2P0v5X7DKIIm8D8gNLGdhXRAdWFZfwEk8bc2j/3VqiZ7Z4m8l/bkiYrk24PY38Oo0pywyuItqAgCWWR72yiC7GC1Z2AT+XSdCXkBVkTcKIW0RMEqj/Ue+jNCEnaugl7JZdh0Jh4tS0EzwP1F1PijaP23j2FTGCWr6i0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1972.namprd11.prod.outlook.com (2603:10b6:404:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 17:31:51 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 17:31:51 +0000
Subject: Re: [PATCH 01/14] selftests/x86/sgx: Fix a benign linker warning
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <seanjc@google.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1631731214.git.reinette.chatre@intel.com>
 <84b02b56d45792971cabf8ba832a9862fb20990e.1631731214.git.reinette.chatre@intel.com>
 <dda727c928867ec5194703ab59c1dcfdcb4f6220.camel@kernel.org>
 <21d412838f96f4b59b6e4a3aa6aaba1dd9f64044.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a0335d59-0bfd-71a5-4908-9dbfecd6f430@intel.com>
Date:   Thu, 16 Sep 2021 10:31:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <21d412838f96f4b59b6e4a3aa6aaba1dd9f64044.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41)
 To BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 17:31:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7314d35-136a-4f67-ae1e-08d97937de50
X-MS-TrafficTypeDiagnostic: BN6PR11MB1972:
X-Microsoft-Antispam-PRVS: <BN6PR11MB1972809B9165A91E61BF9C65F8DC9@BN6PR11MB1972.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJoVIgwSUWdCEyHcoeVvgeO0Xdx9/J2UoegNBjSvvOM6tAsXVa9eRomAoPo7OrX99yCtENP3a/n4zVtKw+6XgS9Wp9WTSYLvIDZpGE21P4YSPqDM12KPGav+xUk3yJufEpbiD0Yi7KrMLFjN4dd+FgbvarFsMHAjDNaBD9QCZ3rdses8mUBm677dTwn39XVHiHvN1mgWecJ8zWrpjyHcr5r1ZMnGIuIBxE5/ocGisqfX2xX+rY4xiG/n28LGdAPNbKX69rCPNn/LknQilt4PV2UC4B0J0h7AaJDOeDuQzlCoA1QjGMVlMvtbP68uATnPJm/CqRk+IAi9dTzwdHRTJAPY9aCEyJzzXzoWACxKUbKqFFd9W3mWVwMTC0GQstwRbocVS0lNj/M8J5DRou5/bDnmfa6PxEuXZhYcpSiM+pzzXB5ZqX3yISKDt4BxH1wSUJpYILF3375r5ksi6D6wxK6OTevlYIM8I3RHxCjgUKO2p6p/l3RjzV72lUpgS3U+B9pXVrsSPTHofi/+WKgq3sKT/7Sz5PuF21GrpxZgX8alKgSBSUgbfRJCOIJH0b+7wq8gUwr3Fa2MZ0goFQ38zAdRpTdKFVX1b90c7jt2U1kr2EKx7QwyB8wg+yo1JkMNPda91ppuaFdqc8fR70XERcVzeJZ/iNgAOKromr6fCKmEeQWl/9VEizUSe7TZ5ZPHgwCTrimodEc2svHOGq6DcBOWV/zEgRbwd1ys5bksvywU6Rbo56uGWSvgPIWg4rtNZxuu87zv8hriRYs6EzmC7hByzfv8/FZBRum1lzzanPzSBBDRqbwQsUY/MmxDmHn0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(316002)(83380400001)(2616005)(4326008)(66946007)(36756003)(6666004)(8676002)(38100700002)(8936002)(956004)(16576012)(966005)(31686004)(5660300002)(186003)(86362001)(478600001)(44832011)(66476007)(66556008)(31696002)(53546011)(2906002)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFEcTg3WXBSOThzLzVkRlExSURFVXhWcVVJMzVPUlBWeDVxaGV6RmdMdnN1?=
 =?utf-8?B?N09vWmlGNXQrclFSSk95V1MrRlAyazdveTkzaXZ0eUtIcXBKZHlweXlKVHU1?=
 =?utf-8?B?d0FLWmcwM2hPdE9jcUVvcGh0TEd0K29jQ1JDMlBwUDl3K0UzaDBJdzN3SGhI?=
 =?utf-8?B?bFdEUHd4aU1sM2RPWWMvUjJSNDA1SVh1Y3NEYjNkK0g2dFJlWjA1anMwRE9y?=
 =?utf-8?B?NCszUWFPWksvWHNTbmFXWEZ3bTcvSWFsWitjb1pPZDVZaUtINDBEcWliUU1B?=
 =?utf-8?B?R2NkbXRQK1E2N1FRM05aSlBKNFdMYTBHWmZFS3VPQWQ2SEZVSUkxQUdlQmo3?=
 =?utf-8?B?WlVkeWRoMkpMUnJiUERkRWs2Mm1HMmtvM2paNG8yaUUwcDliV2RYSmVuendx?=
 =?utf-8?B?YWp4RU1xSloyczI3aUo4d3N0KzRCQy9QYlBWcmtjRTRFbE1LZUIyLzFpMDlz?=
 =?utf-8?B?Q0o5L1RGZXM0QTVaWlFSdGR3Q2UySzRURWJXMVBrVXVwaEpNMjV4M3lHSWd2?=
 =?utf-8?B?SUh2dnZpTnd6Z1BmMVNDUXI2NnpPdWZYd1YxWUJhUHRjeGx4aDRkcE9BWnQ5?=
 =?utf-8?B?MkdvbGhpUnNmSmIwY3I2RVRBZ2JnS0QvNkdWdG5wTXpsQmU0ZHZZZUJveldT?=
 =?utf-8?B?eGE0RjJsUy84dHhnSVMrZ21SQWQwWlJLK1Y5N0N6MkZIRXZld1pkYld1blQz?=
 =?utf-8?B?NFo4TGxib0NPdE9kTklDUmFFaHZrcWIwOUxVOUppeHExeTdBK0U3NUNHOFov?=
 =?utf-8?B?aVhJOFhLTjNKdUFNRVR4bmhjRXdIZENUVUQrQ2RqN0VQMGpMT3dQL2J5d3BY?=
 =?utf-8?B?NzB3QUJ4RUlJUzFOZ3JIQkpnVGV5Y29OeEhQSXBuZnNCR1VPTE5DOCtMQ1BM?=
 =?utf-8?B?aTNqaGt1QU1mWEVXRHZOai9CSmNJZ2FNWjdzQlFqSk5IbGk5M3N1Ym5ONnNi?=
 =?utf-8?B?RlljUXdwQnQ0dmFhSDNFTlNJSDRyZDF6VGtJblh5WkZWTnVoalRKQnBWRUNr?=
 =?utf-8?B?TGVWQTRpZ2dIcnFHU2lJQ0tQOG91aHJiWEpIRURkd0NRSm92dnU3MTZEazUw?=
 =?utf-8?B?dy96MHJTL2llTG1Za3p1L1pmYTNUV0psaUV0WnpKVGhDS2szalIwU25vUjNB?=
 =?utf-8?B?THBjTlhUYUM1KzlKTnNIZmVyRnBqdVlGQlU4Q1FjeDdkdkl4cWdYZUNTODVy?=
 =?utf-8?B?ekdPajZEcFpQcTNoZWFnM0xLeDJ6SjBGUG1ZN2ZIeEhKalZFYWkwOENROTFD?=
 =?utf-8?B?M2pYdHBZMytHZ3U5MWN4YjI1UjEyZW5MdUFyRTE0MktjZmt1R3YvbmM3Vkh6?=
 =?utf-8?B?WUFmc1ZJaVk2MGs5ZnFnbXMvYUdLNmVnYWJKQVdrdi84Tk4zMGZ4d2tyUFlk?=
 =?utf-8?B?ZTN2bTlST2VxY3EzdktXdUlMZWh5anAwWmVOYzczekJTdlMzZXQrRXBKdTRU?=
 =?utf-8?B?N1I3ZStUWmNaSWRyQ1Z1bm1XV25nT25QdVM4aFpSZDFabEdUL0dwUjYxYStJ?=
 =?utf-8?B?Z3k3b0hKVWdCUFRQUWl6cFJwUTlWNjd6YTRzbWVIWlU0RjhzZFNwTWd3dExk?=
 =?utf-8?B?VkVBbStmbHE0RWZoK3FaZWtUcFUyblpVaFJTaThSYkJianlQcm0rT0tSd21J?=
 =?utf-8?B?QnpQUktDU3MrZkFYMDRwTWRjeGRMVlNSWFZ5T0o4aTg4M0lFMGpERzFVRm9V?=
 =?utf-8?B?Y0lTaXFzSXQ2RjdyaDZCcTk1dVBzeWI4YVBhaVVqLzZtUEtId3MyaWFvR1ox?=
 =?utf-8?Q?RL/SyWSC8+O8NA9kZ/0ufwsd/R7IqsB7YvxoZa0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7314d35-136a-4f67-ae1e-08d97937de50
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 17:31:51.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzGnPtpmep0OdpBqEcL/BxPfzhRV3GJSTvAHhfEDaAYxyOAVk+bi9o0ogUtrhfT7PTLjA3Tzy23uRhLrEsUpxSEUCzH4Vn0lkor2FUuGKnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1972
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 9/16/2021 7:39 AM, Jarkko Sakkinen wrote:
> On Thu, 2021-09-16 at 17:38 +0300, Jarkko Sakkinen wrote:
>> On Wed, 2021-09-15 at 13:30 -0700, Reinette Chatre wrote:
>>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>>
>>> Pass a build id of "none" to the linker to suppress a warning about the
>>> build id being ignored:
>>>
>>>    /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id
>>>    ignored.
>>>
>>> Link: https://lore.kernel.org/linux-sgx/20191017030340.18301-2-sean.j.christopherson@intel.com/
>>> Co-developed-by: Cedric Xing <cedric.xing@intel.com>
>>> Signed-off-by: Cedric Xing <cedric.xing@intel.com>
>>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> ... but I don't get the use "co-developed-by" tag in this. I mean
> it's one line change. Maybe it should be "suggested-by"?

I checked in with Cedric and he is ok with changing it to "Suggested-by".

At this time I have the following signatures planned for this patch in 
the next version:

Suggested-by: Cedric Xing <cedric.xing@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
