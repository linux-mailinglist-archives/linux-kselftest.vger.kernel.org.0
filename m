Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEE240DE3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Sep 2021 17:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbhIPPi7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Sep 2021 11:38:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:59465 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237149AbhIPPi6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Sep 2021 11:38:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209683335"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="209683335"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 08:37:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="433822027"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 16 Sep 2021 08:37:37 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 16 Sep 2021 08:37:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 16 Sep 2021 08:37:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 16 Sep 2021 08:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNX3HjjmJd+fzsuSMputUARqPiYWQdwUHPKirB8Yoh7hE/rdsFwXEzn7eb8fWvopmbAyE6TOrxtjIMrIOVVfAM0Zs9ysJSA7mlSKDNJgPrzMHPBgICCn2LHCCLRYSqaFbXRDRwx+3EVLrxqKZ4TQxR4QvApw9YX1PhVB+NeHTohNqhSXRAIh17JVU8C5ujCTAlCFp4xjrwa2xokxLOc3yy3El/xVH7BhE1zwwO9Fcal67NXSZIpVvBnH6ruboRXxAaGcyyuXVlb/zx0j6InzPHqZ4dvh6h0JYTVhWvv5d/FkNg+YAwRDXi8AFKgxy2so2ZwdlOn0WUMGm6Xmd7nJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rxa9w8kdEzhL6G3CVh0sGmlttkwGEjMpUdc6Mvlt+0c=;
 b=K43Qn50/Is35dwO+IC4oXO6RN67HgDQH28lZMbBcUhr7X8CwSrjkeQ+QHOfmmzrqXgKK5CTgPqYecQXvyCX5miV2/UmOURHQFM1gnKNq/GD6j/6mIx6CKLwKfEGy1TJ1C7QX6k38cGoZr2iOuV7TYGsJ6lV6V4m1Lb7A2Wjsb/BfQKdhMUZM6R6EYF/izogXjTaLTYfESKbVP2RznlTGDU5p7NAtTRIxEixPC8WT28vHa6PXc9apfRXiLSMIBNxlGIxGQp0/jU2nXIzhHnbkFG8PBEuhuVrkL6nhrtEwk8ND92KmsppkPwzQO+mVrp+ZnIFdqsg7UrGh/BbSEKp8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxa9w8kdEzhL6G3CVh0sGmlttkwGEjMpUdc6Mvlt+0c=;
 b=jILB9dgV6rjb2CX2L3ZrgUIb4wLrKCvrdZWuEFCTxJArB5qamakXdgmEb5IacAr3nQv40gQABCKOlFafDC9YQWiF3KcB7YUqE+kPGgQeXO8plmpdZYK16AfuQY1T4TxPZI0txc56sheDg/4JsQS6/Le3hBk7XW29xOLlLbDavJg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB0034.namprd11.prod.outlook.com (2603:10b6:405:6b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 16 Sep
 2021 15:37:35 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::d47c:525:2aef:f6a%3]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 15:37:35 +0000
Subject: Re: [PATCH 12/14] selftests/sgx: Add page permission and exception
 test
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>,
        <shuah@kernel.org>
CC:     <seanjc@google.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1631731214.git.reinette.chatre@intel.com>
 <a6e69ea22a2694d252302af283ee3e3f023d3577.1631731214.git.reinette.chatre@intel.com>
 <d04d83a679f026ae2aa28535bdc826b8cf95e887.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <131cf7e2-3743-a83e-98cf-5a00c836af16@intel.com>
Date:   Thu, 16 Sep 2021 08:37:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <d04d83a679f026ae2aa28535bdc826b8cf95e887.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:300:13d::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
Received: from [192.168.1.221] (71.238.111.198) by MWHPR20CA0016.namprd20.prod.outlook.com (2603:10b6:300:13d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 15:37:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7571b6f7-f6c0-4a8d-eb9f-08d97927e834
X-MS-TrafficTypeDiagnostic: BN6PR11MB0034:
X-Microsoft-Antispam-PRVS: <BN6PR11MB0034FE8D560536B5E474C4F1F8DC9@BN6PR11MB0034.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujkcJ0iNWma9kmgYoLTYw0gxiX8txikspmXjBmCFCxyadlbD0R1oDC9xboHezSaEtYzhqVEm0oCwZwizEV49bRRXcTY6vi1ENNHWc42H2XM6eyzbN6igziHL0cT2ZtaiXkI99dFRDyrKf75l2c1EF8iKDIcwMbzUssZd126VZDvVB+CtgdejXIby5K1DmRjtdg+olVGnYLfSJueFcEHB16kJbp2qXOKSnrs4ewlDuv1OuLWXl9uvao1DFsKUmPZ1PWd31GAS0fwy0RgMLEQe6JFLqTiaWNLTHC+KTlxQd7stMQc6jHWrX2YDvgGfI3m/ju2rQ/kK2KRuCSJ91uyf7eVxzLVp+WWjzUI96q5GTqDbiuAEH/LwyQ6G0HVBtXoFey79aVJmGeLE2qMLKqBLtqJ1EgMUY7Hh+0L1grIP2TJD5s5lq8DsyJSzE5vQtV99CCWlACoCMqjiWSvYeuEXWtI9eUvpZahbMcgMlbrFcNeZRVvinhwVZ6xH6QgTsWDyxcWxNVy7QCNsoLs9fjpQNPE8y6hsL+GwEHHeENTCBChINXZ0axMrBr476EsLxbCc52T2mxKYbY06OlD2HNmih1TfGeAS9UPo4yCMU5qiAzxzJhoK57wof2XZxO8vT6hSod2LJvNPMSa35p4gisns4j8nibRorFAmygsKe6XkR+ZmLIhZcU5Ruhfjr1zg/GKJrNBU9AeD8nKGHWKXAYSrSvc/h0565Wax/uQF7+O1pf8PgcxB89Qr3L8LckpVmNmV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(4326008)(16576012)(6666004)(38100700002)(31686004)(2616005)(26005)(6486002)(86362001)(53546011)(8676002)(66946007)(956004)(478600001)(66476007)(5660300002)(186003)(66556008)(31696002)(36756003)(8936002)(316002)(4744005)(2906002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STlnNVFiZHFLL3JTUWRnUHJLdTRnZnZPMFJ6RTRNVUhlei8xc3FNdjBhN0lK?=
 =?utf-8?B?SDV6bkd4SE9zNHFRQy9Fc0laeFpLVkphamxuWTQ1Rjk5SzlVbEcwcHBnak5X?=
 =?utf-8?B?V0JMZ1grTTQ4VXJJTDAwUFJ6SzBGRzRUTitWS1MrcGFkemRWZWRFNUtQNzEw?=
 =?utf-8?B?Vk1GdUVvQ2xTVEQ5dXkzRjN0dWdlREczSVhZbHl5UGZTK01EWUs4bUdsM29y?=
 =?utf-8?B?MkFFMVJ5cjlTTFV4cFRGZktCTjlZZ1RKT002MUZKaVZWNGRBTUlGR1BEMWRO?=
 =?utf-8?B?eFNYdjUrd2pjaUlGRldtUkJuRldNdCtVaEZWd3VrcEtKaHV3czBXTzRRZW8r?=
 =?utf-8?B?MG80Y3FENEhQTTlLWVJTRXRDcXB2M3grSWNoUDViU1ZBMHJOaXh1dmZlNks4?=
 =?utf-8?B?RTNCM01IUnJtWnA4V3FxeDN4ZEYyb2xscVZmTWVVY2NrTlhVQWQ4Zm9FSWYr?=
 =?utf-8?B?blAyUzRBYjVrSjdUN0Y1UzROT25reDBSbkttYWwxbVJ5cWk0a1dxbldsUWZi?=
 =?utf-8?B?TnlRZngybFJpclVIOW1jWVliRWplaHMvOTZIVGVFWDU1Z0JHOGJaVVBmbCt6?=
 =?utf-8?B?L2tvamtGY2RFVERJaTFpQ2RsZkpzcEsxdk1veVdCeFR0QzF4TjlMUjlicGRv?=
 =?utf-8?B?V1RoKzFFZjBkTnFqbXF0R3d6VUZPRTJ5RWY1T1FhYTBpMXFuOXpwUHRtNGJu?=
 =?utf-8?B?eWJKQkhTUTB3VHdXclBHTUM0Z3hJOUFJOFpiQlNjN1BpTHN5dmcwcnZuTFQr?=
 =?utf-8?B?YTgzYjJUbXNJWm9sdkpuYnRONFU0Q0RYNFJub1hwdEtaTHlIcmVLa2N5d2Nh?=
 =?utf-8?B?aFBLMm9LbkZLdnZhNk85d0VpZ0pOSWoxVjlYWnFyN3gxL2Y1bDZ5cGFGcUpX?=
 =?utf-8?B?Y0M5NXl4VXF6ckExb0crVXNWZ0ZlODJDTUpiNXhHcHpOQ21Fd2lRMWRxcEc3?=
 =?utf-8?B?WmtjMjI2eUpFYlVEMWhNMUVmdEhaYWJVeGw0S3dWTE0zTnF3b04yTzhub0Qr?=
 =?utf-8?B?N0Q3Qm9OWEdpb3JTRVpaRkkwdkxGSk1PMVRFUzkyejFZZTJIQzdJcmxDcXho?=
 =?utf-8?B?RWtFeTFUaGd4T3lGRnRkKzZCWDFBR3RzdFBweEFjN0kzUis5aGk4bitGS3Vh?=
 =?utf-8?B?SFY5dEJ4bmQzczJSanZyOC9ydzFVVzVvZGZESENPTWtEMEFwaXc5VDIyTHpL?=
 =?utf-8?B?SHdDMWIwbVpTbjNYRCsxQm9YT0lySkkrNFpBWkU4TXhoYlVGUTMvQ3JETnVp?=
 =?utf-8?B?d05OVTc4Y0s2WmFRbjJ6cjBZRnR1azkwS0FNMkpvUDJSaWlySHQvY0FSK0ZU?=
 =?utf-8?B?U3RlcHJ4MldETFNRZ3RxUHIyR1Y5VW5uQVd0UDF2NWpCS2tKQ2grZ2JrVlFZ?=
 =?utf-8?B?UUtHcmN2UlBWaGY0MEYxM1UrQnh3L1RsZnFJSFVJNm0yWGhhblFsTDlQby92?=
 =?utf-8?B?b1R1TnhBTnJTbjVRMWlrVG9vRy9PdFJnS1FYUU1CWVJ0YkRZMkZBbmVBc2Vz?=
 =?utf-8?B?ai82c0phWkkxOWdqSURmRzZ0dXRCcXFyVHdvUVdKclVobEh2bC9OM2EvWEh3?=
 =?utf-8?B?Ym9ibHRabUxuaVlqcWZhSjIxTGNXMUErbVFzKzBoclBZWHpHZlFmT0gwY2VI?=
 =?utf-8?B?UGtlOWN4ekFLbnpjV3Ezb2JPN2VaSHhnWDE3OEx6aWtBbXJWcEc0YTMvemtm?=
 =?utf-8?B?ci92UWRxem1WeXh0WFBBMHZ6MWxKcnJIUzV1eDNla21iY1U1TGFaaDZCWWR1?=
 =?utf-8?Q?2VNO+gyVpV1w7pvtqxvJAZ5pC/C9X4eADaBhPos?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7571b6f7-f6c0-4a8d-eb9f-08d97927e834
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 15:37:35.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9b+tEBkrrnI8yjzw00t9bq+bpWJ4VNX+PNef9E4HK4rot2Uhl6ds+3bDyIBPo1damozP0l9cDA30tv8zFtk+gLrPW+SpT0S+tSIuaOv6ZnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0034
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 9/16/2021 8:21 AM, Jarkko Sakkinen wrote:
> On Wed, 2021-09-15 at 13:31 -0700, Reinette Chatre wrote:

...

>> +/*
>> + * Return the offset in the enclave where the data segment can be found.
>> + * The first RW segment loaded is the TCS, skip that to get info on the
>> + * data segment.
>> + */
>> +static off_t encl_get_data_offset(struct encl *encl)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < encl->nr_segments; i++) {
>> +		struct encl_segment *seg = &encl->segment_tbl[i];
>> +
>> +		if (i != 0 && seg->prot == (PROT_READ | PROT_WRITE))
>> +			return seg->offset;
> 
> So, why not
> 
> 	for (i = 1; i < encl->nr_segments; i++)
> 
> ?

Thank you for catching this. Will do.

Reinette
