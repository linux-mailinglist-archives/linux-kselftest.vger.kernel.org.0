Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE2467298
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 08:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbhLCHcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 02:32:24 -0500
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:29724 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243592AbhLCHcX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 02:32:23 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2021 02:32:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1638516540; x=1670052540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eVYRderidpO2jroQMZoVukj3rjU1PTBox5pVzkRccRk=;
  b=hQQsfs0Z1j18zvHce4yljkicCUl7cONMITbQcaW+8byLwEXp5ZQZS1QB
   xB98e6ZV1TOxW2x3/OCgjrAfyKWg6M42dqI63Y87riGszIc12dEQSEtuy
   sj+wVgl6v7LhHXk8/Rk3li1hQ/zl6pxN4PUM6QhGeHj7s+1WufL+4RvoJ
   6T7AFgwt5djHZB2dJTD8HFn7hPol/HOtUMqA0FEqPvtJ9TL5sTmQ4pVe9
   3IdZfjLhK2aFs80tnfAs9sflXSvkf/xAi5wm85CE13syPpMcajji8N7OA
   urh4jtP6Gfi81GgQ900OaCNCkjhfW/sFs/wDP3sR8vW9kD1NELpwWFnSn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="53330904"
X-IronPort-AV: E=Sophos;i="5.87,283,1631545200"; 
   d="scan'208";a="53330904"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 16:21:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHJAjvUh2FxHz3MztqNhKePxZOR1XfmRo+3xzpRePgeoAXmgN4zchAsCo/z++uQq6/WzjJ5sulc9K21rbYBbmIOgeJQmHcPUBApEDmZLLvK7HaogqHWs+6P2n0K6MVjPJShRzNB/TO93rnlYw5WUGErY1GdM2gsarv1mlV2l5IKq2vQAksrG17K376b+W/FjCzQLzFBgtXq8hzJbKMw0BCwTB9dsZmtl9OVuSBq7UfUrsh2zDIIgzDvA1Ib8r+ySi79uaf7RHCBtTHYPGAGzw3qeRCaFFS3851Qp35nJX/1Zs/D9++6nLUfmYb+lCTKEMXOddLbyz1dSp3cVeefwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVYRderidpO2jroQMZoVukj3rjU1PTBox5pVzkRccRk=;
 b=SDh07WofIfRP4t9aUZxogMPdkZuBjhoOVtRgtbbhLnI1MIY6dzpabR6ghQ7AVoCWb+VkVo83KFnYH41NwLCZFpYldRVIpNk+fU8V5OIUPAO55mjei9BCE55H85M067kkRIVLhr0dlnHQ6azSeR5FzQEN1iQlSYrQp+NLPb/TX/A/apCM9knWoSu9Z3f9tJnt62fp8YrMKGE9uufouh8CvWkEvijHTs+l4TflkllqGfdRm5mfJQ9LK7iUx09FoFuYvLNJ/dCpwTxldjJ5SR8HalrYdj0pCKuKbYDQ7cciWeoaX2/7uADzVQ+2LGUhwTkCfvEjtUGNoDgqH4TFVMYs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVYRderidpO2jroQMZoVukj3rjU1PTBox5pVzkRccRk=;
 b=h8ag9Sew0xqvqYuCuCANJTHg6KJ64GYl1wbji8T8F8I9ej8rCdT6h7oEgwk9Qv1R57SeIaA+xXTe/m26h0iyY2ca6EmrQCxrZZTYPLv1BiH0QhUfQa/YqT8Z1pz4un4gY5aSIqgZ6fUvNBQsiP7cb0b53QPn1T83BagnDAK/1JM=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYBPR01MB5456.jpnprd01.prod.outlook.com (2603:1096:404:8029::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 07:21:41 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::b839:7029:4084:48dd%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 07:21:41 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Topic: [PATCH 1/3] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Index: AQHX1hYQoRVeRbEkHEuvqUlW5Aw+wawbAh2AgAIEFrCAAXH5gIABl/cQ
Date:   Fri, 3 Dec 2021 07:21:41 +0000
Message-ID: <TYAPR01MB63304F1E1A04D48CA7632C658B6A9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211110093315.3219191-1-tan.shaopeng@jp.fujitsu.com>
 <20211110093315.3219191-2-tan.shaopeng@jp.fujitsu.com>
 <08708d7a-4d34-3817-032f-25698a30551c@intel.com>
 <TYAPR01MB633090B5A9DE4480D12CC9268B689@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <6d4eb508-f551-4c12-2e15-34ab9b1dc49f@intel.com>
In-Reply-To: <6d4eb508-f551-4c12-2e15-34ab9b1dc49f@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZWJkNDc0NGQtOGU0Yy00ZjkzLTg2OWQtYzBiMmI3N2Vj?=
 =?utf-8?B?Y2M2O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMS0xMi0wM1QwMDozODo1Nlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95e5380a-dcd2-490c-47ff-08d9b62d8d80
x-ms-traffictypediagnostic: TYBPR01MB5456:
x-microsoft-antispam-prvs: <TYBPR01MB5456AFB14D9B7A262B5F6DBA8B6A9@TYBPR01MB5456.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bM16m4CfZ3J8itdZ+X/JLozmUHP7jKQk3PB6b2mupubZzL2P9jvOqdWoueY/5uT/oebsCXC2CqbEPjpoy4jUAYfxbGjvxsfMvUDpl7wKhDvaYC2w01Oa037ptv6F7yuPxyvi8Vk90ASt1KYJRxXiZOQpQolUQwOYK+W+HZ/6MOzgUHYfjCsk1f4MQike3ysBcSS+6ZRos1HVZNyURlAMT5/rOtTyig6bEsupz/AdD9hN5mwpXtnOG27blN5CuEHZa0975OBxUi+Lfg9324p0mopOMdXkpJdZr9dVj+3NGpevMgaw2Z4Ofn2f+4lK0efx8BudEcklhPJKQpPS/UBhWH+Is/kk2Jmo7uH4ZEsgWtjMhx22CYInUWSbD1unluiNC1mD8o3u+zWw2DVGGSUaQozWLgOEB32gSrtCE1rZ2YV2LLNKnds+roO7EBKXa6J5lh+2VmGtjjE1P9krUndpuPEFGO7Prw3m/dexMvmc9fuiDdsE/QIay1tL3nQewcA5lMH9ZcMpQUaMkBh/aNLqgwpqxK3a6/wPZtAKQ3UoEEr1Py3txj7n1fm+g1qyQ6t4nwLBX1vXiDoyPJibJTKqkXkaKdNo4GxiAyEAREHvz6sZYiUcND5KM74vU04Z/Sn+OozUIoPnk/bjIF4Mx0j3wv9ayzQZEx5FcV0H1+jS198hDS/aDKer42kk+n5F9sreA9tbLjHliqlOTpMCJizo8EedN70R9Ig033MEXSZv0LNQiOpwiP4CGWwHQjKcEvq/FI8EqJYpAy57vdvY0IoWLsTxlR5YfZg/q1ruxXUqTbuCEgdIqR/aAzKlBq9qVTUDT+nP3Xhf4eFxjWmWMx385Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(82960400001)(122000001)(316002)(86362001)(83380400001)(8676002)(54906003)(26005)(966005)(2906002)(508600001)(6916009)(38100700002)(33656002)(85182001)(6506007)(7696005)(4326008)(186003)(53546011)(38070700005)(5660300002)(9686003)(66446008)(66476007)(52536014)(8936002)(76116006)(64756008)(66946007)(66556008)(55016003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXcxL29ncVBEeXptc2dTK3VKRSs0YUJtYVlHWmR4cFVnK2pOUzRzdEp1dXg0?=
 =?utf-8?B?U2E5ekV0emdJcDhURURNWDdrNnR1VW1uc0wxaGl2YkpZaWEySS9lN0FvS3du?=
 =?utf-8?B?bHdZd1Jkbi9xTXdjWUE1UUxHVjRSN1JVUERielJTTEcyT09mUXJWTldMWjRz?=
 =?utf-8?B?dkw1KzRKYnh0UWNZSXp2VmxyMDBrWGxYWkN4d0ZtbVluc1hEU3FOSDIrblZR?=
 =?utf-8?B?RjZZUlk3OXJ5RFdSaGluTXJlcFdVMEZGWmxrQW5DY3BlekJZdnBPTVJKWm1l?=
 =?utf-8?B?cnhYWnhtOE9xcFhnQ3hEUmhkRnliYmVKVy9rRktSQTNwZmttQjBWUzNJdGFB?=
 =?utf-8?B?dVBXQkxHOHZRWFdsK0liMkRqRm1SYTk0QW1vZU1ZaW9GMnlEL0NaNkhZVitK?=
 =?utf-8?B?L0MvM09pTGVCYW5HVGZoVGplazhNbHkwNGFYZHVwZGYwYnBlVlZKQS9Rcmth?=
 =?utf-8?B?OWVUMEkzVXFzVXpPNVB2R25EcmdOYWFLR2RLWjV4d01RNHIyTVRpM0ZDM0M2?=
 =?utf-8?B?Mm1qWlhTbmNNNlk4Rjlma3JoZDNuS05aa25uVG1aWHpnZGg2eDRmaWFLZ0VU?=
 =?utf-8?B?NVh2NGNUWFlTRW5WWUIrNUhTdjNWMlpmZHNRVElRdTBubGFTSWNaWVR0Vks2?=
 =?utf-8?B?RTlpMzNqQnA5VytQOStnSUROdm9MOWVzQVNrK1dFbnFIbUFHNGIyUWIrM3cy?=
 =?utf-8?B?U1F3UWVvYkFJMnhDcE9RdU1kOEJidUVEcmtEbFcwdTlYODJvOVVFTUVJTExj?=
 =?utf-8?B?M3dxalRNYkZqQ2cva1FaUEd0Nk9BYUhMTG1QbjhIQnk3aFBQOXp1aW5ESjI2?=
 =?utf-8?B?dURXOFBnMzM0NHorbFpxTkRGakttZ3JPUlAvb2VGZnJURU8vMWdHV0Riam8w?=
 =?utf-8?B?MWNvQUdhRXYyTEovbWZzK0pSWXNZY3JzTEFVUzVCQVFCaTVZNENsZk9sa3lK?=
 =?utf-8?B?NVVkY3VEQjhvSEdPcldJMTNNcVVCY1ZZMmh4NVhHd1RwbERJL3BMR2R3R3FB?=
 =?utf-8?B?REd6d3RLbytwU2dsdlVZaHVOdld6UTdJSlB3NVJnZDV4Z1BSNzd1VEpHaWZ5?=
 =?utf-8?B?R3FGbk0wY0U0YldkZTRnMzRDOHBnQjF6dU1DYlA1Q2Y5ZWwxeERDcG9LcXda?=
 =?utf-8?B?MkZYcG5peWlrSEhINXFHYUV4ZXZOVFI1SmlkSXlPNXdpSW0vakRMWnBoZ2xZ?=
 =?utf-8?B?NHBwRVlDOENmWlphbnNvNEZ5UDZwdWZ6Smx1OFF4WTFUTEg0U0Q3cElPaTBm?=
 =?utf-8?B?eVpxZ1cvTnVhT205OGpBeURNMnpiWkdmMTZRc2Z6V05hV25xRWR4QURONUJq?=
 =?utf-8?B?b0J3R1ZLVHFFRjNkWm5KWTEzYnNEMzFIUE1UOWpYd2lTZTY1THNoSExSTlFp?=
 =?utf-8?B?OWFYc1dzN0Z6Z0M2RHExT3A0TWlPRXpGd2o0WVRiRXhMUlpVUWNYSWkvS1Nm?=
 =?utf-8?B?ZmFMRmZ4dGtGOUJpZzdFL2ZjVVdiaXgxeXhSWEo1ay9iRy9XVGFQdkIwcmZ3?=
 =?utf-8?B?WEx1TTZIWVFUWEVSSnZkZ0FmbnlFUUFObmRkMkRKa1VJK3FYNGlYRG5HYWZm?=
 =?utf-8?B?WUF5dVNPc2ZBV1BCM3VHVC9OeVZ1dXRJeWxQZlZBVHd6OEk5cGVuZmZOallY?=
 =?utf-8?B?WTRhQll4eVVOVkNkK0w4LzVTMStYQkpnMlVDNy9FTEJlazZSbEtnalpoTEN6?=
 =?utf-8?B?N29WcERqK2Zvc0NSNitXazljWE02K2ZhU3F4Zko2Ylo5Y3E0VFBaUXhSNGl2?=
 =?utf-8?B?ekVvMklQUndRMGUwTVk0NUFpNzVQWUI4a2plcDBqRFo2SHBvRDFXa0UrcmpW?=
 =?utf-8?B?TFJzUncraFBuSXZFR0toeHFGbENmQ2szcnh0c25HamZtbUtLcmZ5UXR1VHV3?=
 =?utf-8?B?ZGFSa2N4RnBibTBzd2U2N3RIMWI2TS82WjJDR2I5WW5uSEsybnRFd1h0emdW?=
 =?utf-8?B?MnV6c0pDNkJGM0Z0akhWUW5UcXZrUzhXQ1hleW1qWDVSS2tqWm4rQUVzQWFJ?=
 =?utf-8?B?ak95OThnV3lsM0pyV1FCTkJmQlpIZ1FlczA1Z3dWQXVYRElXaFAxT2ZIZGxJ?=
 =?utf-8?B?eEp1WjdTZGpjRi9MczdrckRBcXFnTHdsM2pTeFlnZC9LbjFrRVA1c1U0YWVi?=
 =?utf-8?B?anB4R2NjTU50RVl3SE51Y0JqenFrNXVTR2YwSXE4SVp5a3E5ekZqUEgvNU51?=
 =?utf-8?B?WGVDRWhKdHB2SmlNRGNaeXE2MC9PRHVyQUpTWE9oa3AxdEEwRENtQy9BQnJp?=
 =?utf-8?B?aUdaQS9mUkRxZzlLN2VEMnFSWHhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e5380a-dcd2-490c-47ff-08d9b62d8d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 07:21:41.2916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmRUGQQ1tgGeN+fvUctSLPHXsT/tUjPjPXqnjXyYgC7zJacOblcntpOvQUti5dLuCk155TfRYOBDKbuihRGAjjkpQCw16fzCnDHA9NMQo4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5456
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgUmVpbmV0dGUsDQogDQo+IE9uIDExLzMwLzIwMjEgNjozNiBQTSwgdGFuLnNoYW9wZW5nQGZ1
aml0c3UuY29tIHdyb3RlOg0KPiA+IEhpIFJlaW5ldHRlDQo+ID4NCj4gPj4gT24gMTEvMTAvMjAy
MSAxOjMzIEFNLCBTaGFvcGVuZyBUYW4gd3JvdGU6DQo+ID4+PiBGcm9tOiAiVGFuLCBTaGFvcGVu
ZyIgPHRhbi5zaGFvcGVuZ0BqcC5mdWppdHN1LmNvbT4NCj4gPj4+DQo+ID4+PiBUaGlzIGNvbW1p
dCBlbmFibGVzIGtzZWxmdGVzdCB0byBiZSBidWlsdC9ydW4gaW4gcmVzY3RybCBmcmFtZXdvcmsu
DQo+ID4+PiBCdWlsZC9ydW4gcmVzY3RybF90ZXN0cyBieSBidWlsZC9ydW4gYWxsIHRlc3RzIG9m
IGtzZWxmdGVzdCwgb3IgYnkNCj4gPj4+IHVzaW5nIHRoZSAiVEFSR0VUUyIgdmFyaWFibGUgb24g
dGhlIG1ha2UgY29tbWFuZCBsaW5lIHRvIHNwZWNpZnkNCj4gPj4gcmVzY3RybF90ZXN0cy4NCj4g
Pj4+IFRvIG1ha2UgcmVzY3RybF90ZXN0cyBydW4gdXNpbmcga3NlbGZ0ZXN0IGZyYW1ld29yaywg
dGhpcyBjb21taXQNCj4gPj4+IG1vZGlmaWVkIHRoZSBNYWtlZmlsZSBvZiBrZXJuZWwga3NlbGZ0
ZXN0IHNldCBhbmQgdGhlIE1ha2VmaWxlIG9mDQo+ID4+IHJlc2N0cmxfdGVzdHMuDQo+ID4+DQo+
ID4+IFRoZSBhYm92ZSBzZW50ZW5jZSBtZW50aW9ucyB0aGF0IGNoYW5nZXMgd2VyZSBtYWRlIHRv
IHRoZSByZXNjdHJsDQo+ID4+IHNlbGZ0ZXN0IE1ha2VmaWxlIGJ1dCBpdCBkb2VzIG5vdCBkZXNj
cmliZSB3aGF0IHRoZSBjaGFuZ2UgYWNjb21wbGlzaA0KPiA+PiBvciB3aHkgdGhleSBhcmUgbmVl
ZGVkLiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZT8NCj4gPg0KPiA+IEJlZm9yZSB0aGVzZSBj
aGFuZ2VzIG9mIE1ha2VmaWxlLCB3aGVuIHdlIHJ1biByZXNjdHJsIHRlc3QsIHdlIG5lZWQgdG8N
Cj4gPiBnb3RvIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Jlc2N0cmwvIGRpcmVjdG9yeSwgcnVu
ICJtYWtlIiB0byBidWlsZA0KPiA+IGV4ZWN1dGFibGUgZmlsZSAicmVzY3RybF90ZXN0cyIsIGFu
ZCBydW4gInN1ZG8gLi9yZXNjdHJsX3Rlc3RzIiB0bw0KPiA+IGV4ZWN1dGUgdGhlIHRlc3QuDQo+
ID4NCj4gPiBXaXRoIHRoaXMgcGF0Y2gsIHdlIGNhbiByZXNjdHJsIHRlc3QgaW4gc2VsZnRlc3Qg
ZnJhbXdvcmsgYXMgZm9sbG93Lg0KPiA+IFJ1biBhbGwgdGVzdHMgaW5jbHVkZSByZXNjdHJsOg0K
PiA+ICAgJCBtYWtlIC1DIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzIHJ1bl90ZXN0cyBSdW4gYSBz
dWJzZXQocmVzY3RybCkgb2YNCj4gPiBzZWxmdGVzdHM6DQo+ID4gICAkIG1ha2UgLUMgdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMgVEFSR0VUUz1yZXNjdHJsIHJ1bl90ZXN0cw0KPiA+DQo+ID4gTGlu
dXggS2VybmVsIFNlbGZ0ZXN0cyA6DQo+ID4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRt
bC9sYXRlc3QvZGV2LXRvb2xzL2tzZWxmdGVzdC5odG1sDQo+IA0KPiBVbmRlcnN0b29kIGFuZCB0
aGlzIGlzIGEgcmVhc29uYWJsZSBjaGFuZ2UuIFdoYXQgeW91IHdyb3RlIGFib3ZlIHdvdWxkIGJl
IGENCj4gZ3JlYXQgYWRkaXRpb24gdG8gdGhlIGNoYW5nZWxvZy4gSSB0aGluayBpdCBpcyBhbHNv
IGltcG9ydGFudCB0byBhZGQgdG8gdGhlDQo+IGNoYW5nZWxvZyB0aGF0IHRoZSBjaGFuZ2VzIGRv
IG5vdCBjaGFuZ2UgdGhlIGV4aXN0aW5nIGJlaGF2aW9yIGFuZCB1c2VycyBjYW4NCj4gY29udGlu
dWUgdG8gYnVpbGQgYW5kIHJ1biB0aGUgdGVzdHMgYXMgYmVmb3JlLg0KDQpUaGFua3MgZm9yIHlv
dXIgYWR2aWNlLg0KDQo+IEFsc28sIHBsZWFzZSBmb2xsb3cgdGhlIGd1aWRhbmNlIGZvdW5kIGlu
ICJTZXBhcmF0ZSB5b3VyIGNoYW5nZXMiIGluDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJt
aXR0aW5nLXBhdGNoZXMucnN0OiBMb2dpY2FsIGNoYW5nZXMgc2hvdWxkIGJlDQo+IGluIHNlcGFy
YXRlIHBhdGNoZXMuIFRoaXMgcGF0Y2ggZG9lcyB0b28gbWFueSB0aGluZ3MuIFBsZWFzZSBjb25z
aWRlcjoNCj4gMSkgdGhlIGxpY2Vuc2UgYWRkaXRpb24gaXMgbm90IHJlbGV2YW50IHRvIHRoaXMg
d29yaw0KPiAyKSB0aGUgbmV3IGNvbW1lbnQgc2VlbXMgdW5uZWNlc3NhcnkgYXMgaXQgc3RhdGVz
IHRoZSBvYnZpb3VzDQo+IDMpIHdoZXJlIGlzIHRoZSAiTERMSUJTICs9IC1sbnVtYSIgY2hhbmdl
IGNvbWluZyBmcm9tIGFuZCB3aHkgaXMgaXQNCj4gbmVlZGVkPw0KDQpJJ20gc29ycnksIEkgbWFk
ZSBhIG1pc3Rha2UuDQoiTERMSUJzICs9IC1sbnVtYSIgaXMgZGVwZW5kZW50IG9uIHRoZSBmb2xs
b3dpbmcgcGF0Y2guDQpJIHdpbGwgcmVvcmdhbml6ZSBwYXRjaCBzZXJpZXMgdG8gaW5jbHVkZSB0
aGUgZm9sbG93aW5nIHBhdGNoIGFuZA0Kc2VwYXJhdGUgTWFrZWZpbGUgY2hhbmdlcyBhcHByb3By
aWF0ZWx5Lg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjExMTEwMDgyNzM0LjMx
ODQ5ODUtMS10YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20vDQpbUEFUQ0hdIHNlbGZ0ZXN0cy9y
ZXNjdHJsOiBTa2lwIE1CTSZDTVQgdGVzdHMgd2hlbiBJbnRlbCBTdWItTlVNQQ0KDQo+IFdoZW4g
bG9naWNhbCBjaGFuZ2VzIGFyZSBpc29sYXRlZCBpbnRvIHNlcGFyYXRlIHBhdGNoZXMgaXQgcmVh
bGx5IG1ha2VzIHRoZQ0KPiBwYXRjaGVzIGVhc2llciB0byB1bmRlcnN0YW5kLg0KDQpUaGFua3Mg
Zm9yIHlvdXIgYWR2aWNlLCBJIHdpbGwgc2VwYXJhdGUgcGF0Y2hlcy4NCg0KPiA+Pj4gVG8gZW5z
dXJlIHRoZSByZXNjdHJsX3Rlc3RzIGZpbmlzaCBpbiBsaW1pdGVkIHRpbWUsIHRoaXMgY29tbWl0
DQo+ID4+PiBjaGFuZ2VkIHRoZSBkZWZhdWx0IGxpbWl0ZWQgdGltZSg0NXMpIHRvIDEyMCBzZWNv
bmRzIGZvcg0KPiA+Pj4gcmVzY3RybF90ZXN0cyBieSBhZGRpbmcgInNldHRpbmciIGZpbGUuDQo+
ID4+DQo+ID4+IEhvdyBpcyBjaGFuZ2luZyB0aGUgdGltZW91dCByZWxhdGVkIHRvIHRoZSByZXNj
dHJsIGZyYW1ld29yayBjaGFuZ2VzPw0KPiA+PiBJcyBpdCBub3QgYSBzZXBhcmF0ZSBjaGFuZ2U/
DQo+ID4NCj4gPiBJbiBzZWxmdGVzdCBmcmFtd29yaywgdGhlIGRlZmF1bHQgbGltaXRlZCB0aW1l
IG9mIGFsbCB0ZXN0cyBpcyA0NQ0KPiA+IHNlY29uZHMgd2hpY2ggaXMgc3BlY2lmaWVkIGJ5IGNv
bW1vbiBmaWxlDQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2tzZWxmdGVzdC9ydW5uZXIuc2gu
DQo+ID4gRWFjaCB0ZXN0IGNhbiBjaGFuZ2UgdGhlIGxpbWl0ZWQgdGltZSBpbmRpdmlkdWFsbHkg
YnkgYWRkaW5nIGEgInNldHRpbmciDQo+ID4gZmlsZSBpbnRvIGl0cyBvd24gZGlyZWN0b3J5LiBJ
IGNoYW5nZWQgdGhlIGxpbWl0ZWQgdGltZSBvZiByZXNjdHJsDQo+ID4gdG8xMjBzIGJlY2F1c2Ug
NDVzIHdhcyBub3QgZW5vdWdoIGluIG15IGVudmlyb25tZW50Lg0KPiANCj4gVW5kZXJzdG9vZC4g
TXkgcXVlc3Rpb24gd2FzIGlmIHRoaXMgY2FuIGJlIGEgc2VwYXJhdGUgY2hhbmdlIHdpdGggaXRz
IG93bg0KPiBwYXRjaD8gSXQgc2VlbXMgdG8gbWUgdGhhdCB0aGlzIGRlc2VydmVzIGl0cyBvd24g
cGF0Y2ggLi4uIGJ1dCBhY3R1YWxseSBpdCBhbHNvDQo+IHJhaXNlcyBhbiBpbXBvcnRhbnQgaXNz
dWUgdGhhdCB0aGUgcmVzY3RybCB0ZXN0cyBhcmUgdGFraW5nIGEgbG9uZyB0aW1lLg0KPiANCj4g
SSBkbyBzZWUgYSBydWxlIGZvciB0ZXN0cyBpbiBEb2N1bWVudGF0aW9uL2Rldi10b29scy9rc2Vs
ZnRlc3QucnN0Og0KPiAiRG9uJ3QgdGFrZSB0b28gbG9uZyIuIFRoaXMgbWF5IGJlIGEgbW90aXZh
dGlvbiBfbm90XyB0byBpbmNsdWRlIHRoZSByZXNjdHJsIHRlc3RzDQo+IGluIHRoZSByZWd1bGFy
IGtzZWxmdGVzdCB0YXJnZXRzIGJlY2F1c2Ugd2hlbiBhIHVzZXIgd2FudHMgdG8gcnVuIGFsbCB0
ZXN0cyBvbiBhDQo+IHN5c3RlbSBpdCBuZWVkcyB0byBiZSBxdWljayBhbmQgdGhlIHJlc2N0cmwg
dGVzdHMgYXJlIG5vdCBxdWljay4NCg0KSSB0aGluayAxMjBzIGlzIG5vdCBsb25nLCB0aGVyZSBh
cmUgNiB0ZXN0cyB3aXRoIGEgbGltaXRlZCB0aW1lIG92ZXIgMTIwcywgDQpmb3IgZXhhbXBsZSwg
dGhlIGxpbWl0ZWQgdGltZSBvZiBuZXQgdGVzdCBpcyBzZXQgMzAwcy4gDQoNCg0KUmVnYXJkcywN
ClNoYW9wZW5nIFRhbg0K
