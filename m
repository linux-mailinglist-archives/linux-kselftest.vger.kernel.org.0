Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDD84B7DD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Feb 2022 03:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbiBPCjv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Feb 2022 21:39:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiBPCjv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Feb 2022 21:39:51 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 18:39:38 PST
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4172F7458;
        Tue, 15 Feb 2022 18:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1644979180; x=1676515180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8mYg1XaHP4DacjXN8sDiQGRTWRSeesSAz2TdUwyV9g0=;
  b=hRi40QwGTjd6LB4n6n5+mw5ykwguB6yxC2chek3IQbFK4ewGzBAzgJpG
   /ftPXb0AhTZQyhnDsnRYy3NBIWRkUvtt5NfzXqObQWX8v/eKTINg6hpF5
   mEf8dV1NZZ32ajbwrEr1fHIRuZScFfiUEaPKZYAR5LWmeMmjUoGRlpryd
   iKOH0oqzd2eHfzEq8PelpEqFWq8eSpU4Gj7u4qJyRHq5XZt+EWjwyj4SY
   YCPwYHOP7y1dm+KbglqAY/MdM6DmrJjCPLnWqzoCt5ttE7XJn3y9RLN7f
   3bDw/WUpMq2hkQSNkO7dLG+2UAmSB1Pf5bmIliord8nOrf4ckCYtLIYqx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="49734701"
X-IronPort-AV: E=Sophos;i="5.88,371,1635174000"; 
   d="scan'208";a="49734701"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 11:38:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARbRZXbU3YsaW1LweIhb9Ghm2/uP4UH7Con98Eh/h99mBfztg5oVUgrqN/J+VGsIvkyOLfUheDsZFaLgooXFMlIHDWQUr7ufpUQy2DHlK87X5Vz0ifpqNR/ZBQ9VLszzRybDgvMY4xLZ7Gk/ifP0eu8DHV50+FtgABZaUlekr3invjB3Mmd22LiyH7yRmdLZe1PKzZFB+CvAvMax6g887zszdcRCC0eMy+VG22wos9ty/fiSRjN7TXOIxgNMYjWxmxDC4wgM0cvhfwBUPY1lPB2HBRheGWfGBKHi5aN/3xKpgHyl5LARseZJfhFojOtV4oOKG3TwZ317RV/eUtxPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMYJGudOmatjsqcv+x/jBrfKYB6PkhZ8o/yt2fvihow=;
 b=JNSZUlSM0U6BkhLUjZ75ofn1ym9SYfTxqjvhtZId29gzjXm0iPaOuL9namJYi37bBL/Kiit6zp6dgku8zMpIxkCAvNaLjdKY2kMcXnefydRK5SZ6LBRBVaHdsvnZjW28AMyV4qzKkGSjls8YFcnA+BJyMfqzsc5B5Ww6UymOvXq7kXvqtbcRoGUfDwBwwKAPye/YUsRA0UPetM1UUck8uO+85U3ye6R/1frV37aXXJMIdugJWWJIsDGQ+RHF6esvp2E8yQMTh/wQL74FYZ1gdDgiNK8zIKuQ87xDayokXj+rY20YL/3cBP5GPVb2d5VxR3VY8mydkfqS84L8Rf3oxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMYJGudOmatjsqcv+x/jBrfKYB6PkhZ8o/yt2fvihow=;
 b=Y8zpI8vKZz90x3VbJdC6pynUAORVJZHfazGrYBp1PVX9TuJpLsWcOYkUU+J6oZkKdiZZcT6NajfZXfCetPWh9/QaF/s7A/bqBKBNMTDrJUsYugGwRAGfsWIdkykG8aCnz+mfGU9WNpwkgHR2C9rvJ8Ib0idpPs2mGTj9AtP8fTE=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSBPR01MB1878.jpnprd01.prod.outlook.com (2603:1096:603:1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 16 Feb
 2022 02:38:28 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 02:38:28 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Thread-Topic: [PATCH v2] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed when Intel Sub-NUMA is enabled
Thread-Index: AQHX8Ajkoh1qZfqmsUSkznAFwBN9i6xW1zkAgBaAhyCABuZtgIAhnUHg
Date:   Wed, 16 Feb 2022 02:38:27 +0000
Message-ID: <TYAPR01MB633058880DD824512B9230458B359@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20211213100321.181408-1-tan.shaopeng@jp.fujitsu.com>
 <b05d487e-bb8b-56df-8304-6e91323e9d83@intel.com>
 <TYAPR01MB633065A420048BC4A2161ADB8B5B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <4705cb4d-e1e7-cd95-4119-0d27255168b0@intel.com>
In-Reply-To: <4705cb4d-e1e7-cd95-4119-0d27255168b0@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-02-16T02:34:42Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=d1deff69-fb14-4527-afb3-508b20369537;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 134a1e95-696d-4cd3-eda5-08d9f0f569b8
x-ms-traffictypediagnostic: OSBPR01MB1878:EE_
x-microsoft-antispam-prvs: <OSBPR01MB187867FBA20BED2774FC94158B359@OSBPR01MB1878.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4NGRi3KpQl0HcoYPuGy0K8Ci/GoHQVj+UmvMT7shjElcSZtiM7EN0IdPaQ7C430F1nQLYQSaV9IEPctxdHjKroICHJZehhUPYhZNTsIhjTUhVCKbbllJF8beO6vPx1E/vszGuT5fFL7XMtcCpFghp/jUZEYM3iTUEu9Sf79r45QpsJmUFcOBKTdpjCJt3ytdskbrmC2cpU0pnuWOl7J1dx15uolRojNBHj1SEDWEXnTlWV6RaucF4zeXQAmrK+fB/P6zcKlMJDtdZxqQjnsNGqJAcm+aPDqO6KBfi0hiqhsGsDgFwUpynpJwQSDDTcTNiFERDqDkp7Sita7j02P0H9wBB2pgENOvbXATrGl90TpHDn/jFcQ/7UN9LEZhh5KQlGpnS2L8Q65h9Gfdl6aYHViw8iFZa9MgJJVXGO5MCQ3xwHpLeH7ECvQxj8+gTEhz4ITqghQFA4t++o3qjhassw4n7CtkDJyOcVeg8qZn+wXDNQohdMmKotUx71E2drGCcpNnXxFrWOM5LhhKK7MA0QVujsTfwJecdjXiwIzcCbYk4JYYMT8hdNSl9q3xEIsa6KNjo8cw8NcFtHF/uwYSsn5+TFJeRb5zQmdQHbTQ3KnJGOy7E6AW5zlYhPqrfjTXs24UbFQRSeM+6Ot7lZAgl8WzD5FAFDR/oIOOzetv9vDS4byt8hTNv6Qg6PTU5k55tIsgsDMqLAp2tHkxv5K/6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(82960400001)(52536014)(86362001)(8936002)(64756008)(76116006)(83380400001)(66446008)(53546011)(6506007)(7696005)(9686003)(110136005)(66476007)(508600001)(54906003)(71200400001)(66946007)(4326008)(8676002)(66556008)(186003)(2906002)(122000001)(15650500001)(316002)(38070700005)(33656002)(55016003)(26005)(85182001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MXQyK2NIak1oMmZBNytqY3NFT2VVMnlYSmI4OWFmNi9nTnQ4RStpNjJP?=
 =?iso-2022-jp?B?UXNyQW4wbi9XYUswVGQrN0ZMbUlYaER6MHpyQjU0K0d0YmgvaTdaMXll?=
 =?iso-2022-jp?B?WWFNRlhSUnBwaHFLUWVpcElNUWFGaFlPRCtITWs1MTlPczJkSTlXYmdR?=
 =?iso-2022-jp?B?STR5UXV6UTdvZzMyUWxVa3NHdWk2UFJvNEN4WFEydHJ6Y011cVJ1V3M2?=
 =?iso-2022-jp?B?L04renZGanorVGlOR1ZIejdLU2RpL015dFVDNFlOTmxiTi9QK0xReG1T?=
 =?iso-2022-jp?B?Q3hrbnRWMnp3QUJGbEplSU45R3NFc0ZVWStSN2tZejQwVWVtWmk4SzJm?=
 =?iso-2022-jp?B?dTU0enlGd25pYVlYMWt0bWUwMzdmNWN0YWhBL1IrSGxJZlk4S2FBTzBw?=
 =?iso-2022-jp?B?djhPejg2MjdvSndkWk8wV2lzZEllMCtnVkFoMldjTWxtcG12Y3hPbkhE?=
 =?iso-2022-jp?B?cVhLbEhDeUYzcDdhWlQ3bHJacDE3bDJKdk1EU2JCMlhycTI3WWRmS2x0?=
 =?iso-2022-jp?B?NlpVMXlxSWVzL1BOSzRBNUZZclc5UlFDRFRhN3l6d0d6em1lNmFvWXdK?=
 =?iso-2022-jp?B?bUc2Vk1Ia00vRWs2WVBacWFwRzdVYWtzRjBmb3BlS0ZzUkNrc213VXZW?=
 =?iso-2022-jp?B?bC90aUs5enJaV1QxOVNPcndpczB1N0JMU2ZWejQ2MXhNZTJRbHFacGJX?=
 =?iso-2022-jp?B?c09NUkhoc0FCNG95RVRQVzRKRVpDTWRNMmtFYmRYR3JUbnVCV3dKRmQ4?=
 =?iso-2022-jp?B?Y1phYjU1UGYwM3h2ZUtuUkxoL0dhZ3JSODRvSWkvTTVHVzgvdHNBaW5E?=
 =?iso-2022-jp?B?dy83anNjT3F5WWxvZ3VsLzJTbEZGNGorUUFNY1BaTlZrTUVhZm5INkxm?=
 =?iso-2022-jp?B?K3R0cXpMbXF6M0YrNHRwcW1lUTM5MTVrcnQxWkxuMEwrNnBKZ1FzTHpH?=
 =?iso-2022-jp?B?RjBtd1M2Wk9KcE16SmRPeTdQT0piemNudkwrWmRHREhhU201a0dxOE95?=
 =?iso-2022-jp?B?Uy94My9tbXpIbUhpOEVkbDFiNzJoUG1jVnIzeHI3OUl0R3hid3FJcTJF?=
 =?iso-2022-jp?B?eHRrbXYvNGNLeFRycUpVb1V3Sm9QWWV0N1IzcHBOM3ZZK1pyNzVLSTVE?=
 =?iso-2022-jp?B?b2UxTVk2VWpsMTU1UXJ6WVduYisyR3p6cGUzcWZybktqU0UvZktYaDZP?=
 =?iso-2022-jp?B?UHBzVm40bUx1bFR4ZmVEUmRPTjNXZkFxbHJ2aDBBOWwvUFBEQ3A4R2Fj?=
 =?iso-2022-jp?B?MDR6YUZEZTZXUU9TNEl4ajBySDlNQ2JVM2czZTBEcXF6T2N5SHVCSnJh?=
 =?iso-2022-jp?B?L3hUN3dxMDFSampBMGJaRnJLWE1yb0RmdjBxVDJISHpDMnlBSUdXNGFJ?=
 =?iso-2022-jp?B?T0hrNGI5Q0x1dExBYjJXWHllTVhXRnI5Z09ROHBNTUFyUjRLc1E5SDZC?=
 =?iso-2022-jp?B?NmlYM2ZHekRIRGZKMW84VjBwM1Vic1RQNDdLbURPRGlHcUo0RXZCY282?=
 =?iso-2022-jp?B?QVM5UVpXTGNKSjZDdU1SSUhRT1Q1WkN4MmRCUDZocnR5dS9XUlpoeHdj?=
 =?iso-2022-jp?B?NHZDeUR2N3FPcFpWL1J1OTdLSTlmTld5eUYxQ2liMmtiUkRlMTNabDlV?=
 =?iso-2022-jp?B?cnY0Zm5Hamx0KzBuaitMUmhiWWxhYkJ5SjlKcVhCSzlIbVU3cEM1Z1Yx?=
 =?iso-2022-jp?B?MW4wTUtZOUVGWkJKV1o3WndqYng4YjFLNjdTR2tHUFlvbkRoSTY1dkxZ?=
 =?iso-2022-jp?B?N09zRFB4bXJnSGJYU3NSblNXM3FiZTh4UmlVSzR6SGNjQU9nT3JVQ1FV?=
 =?iso-2022-jp?B?MFdPV3hvMWVOYzdSN2ozbUlhVWhWbmdIOHNKd0xLOHhGWHAvS2dYZTZn?=
 =?iso-2022-jp?B?NDUwVzExN0pIQUVNdUUwU3ZUVENtTjFEMWUrdUdjUzlwOGsrQStNUkxV?=
 =?iso-2022-jp?B?ZHY1T2xEZzNoWEZRbXFyV3NkaFRyR0RXdUdnamFHd3laY01lejFJZ25P?=
 =?iso-2022-jp?B?Q090R2JxK1lsVi92aWFia2VTdHhoKzVGajJPUWpjT3BmbDdiNVBFTTcr?=
 =?iso-2022-jp?B?ZVNXalYrMDVDVzIxYkFkOUZjU2hDSThyTVRicVVGVmpZaEY2NVBMZ3JB?=
 =?iso-2022-jp?B?RHNydlBHSGJKTEUrY3JjRUk1SlNRRGFUaUNkeXRxZ0FFWVFQT3g0REpr?=
 =?iso-2022-jp?B?RlBKZU9UR3hGMnA1RFBCNldmbEY2eU5OUmVUVk9QdjJ4ejBJYjR2cHFC?=
 =?iso-2022-jp?B?QlNKc05rKzhiZHR2R3l4UGFMRE9VUm81a1Q2VHRPNHV4OEdFR0NPNWVj?=
 =?iso-2022-jp?B?TmttOTdNOWdoU2lnOGZJVG00SEZCRFlhMnByR3MxYXhOaGdReUVjVEhN?=
 =?iso-2022-jp?B?aHY3QjZtL3FOOTh2b1JwWnU1ZXR1czNBUmVYeXY5cmZsMUt1N3dVTEJT?=
 =?iso-2022-jp?B?d2E3aUdBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134a1e95-696d-4cd3-eda5-08d9f0f569b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 02:38:28.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwbrxbehrDF2BQjKB09sBPipYnxnqdvAZxEs+eua5cMMJP+vmFXwQ4apaJtZnmy/nNLcOG5NZsh+oXMug0ZVOsTpoCyKpRAF8vj4c0NWmnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1878
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

> On 1/21/2022 12:00 AM, tan.shaopeng@fujitsu.com wrote:
> > Hi Reinette,
> >
> >> On 12/13/2021 2:03 AM, Shaopeng Tan wrote:
> >>> If the result of MBM&CMT tests is failed when Intel Sub-NUMA is
> >>> enabled, print a possible causes of failure.
> >>> Since when the Intel Sub-NUMA Clustering(SNC) feature is enabled,
> >>> the CMT and MBM counters may not be accurate.
> >>>
> >>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> >>> ---
> >>> Hello,
> >>>
> >>> According to the Intel RDT reference Manual, when the sub-numa
> >>> clustering feature is enabled, the CMT and MBM counters may not be
> >>> accurate.
> >>> When running CMT tests and MBM tests on 2nd Generation Intel Xeon
> >>> Scalable Processor, the result may be "not ok".
> >>> If result of MBM&CMT tests is failed when Intel Sub-NUMA is enabled,
> >>> fix it to print a possible cause of failure, instead of SKIP these
> >>> tests in v1.
> >>>
> >>> Thanks,
> >>>
> >>>  tools/testing/selftests/resctrl/Makefile      |  1 +
> >>>  tools/testing/selftests/resctrl/cmt_test.c    |  5 ++-
> >>>  tools/testing/selftests/resctrl/mbm_test.c    |  5 ++-
> >>>  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
> >>>  .../testing/selftests/resctrl/resctrl_tests.c | 36
> >> +++++++++++++++++++
> >>>  tools/testing/selftests/resctrl/resctrlfs.c   | 26 ++++++++++++++
> >>>  6 files changed, 73 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/Makefile
> >>> b/tools/testing/selftests/resctrl/Makefile
> >>> index adfd92145e12..6d257f40e6ac 100644
> >>> --- a/tools/testing/selftests/resctrl/Makefile
> >>> +++ b/tools/testing/selftests/resctrl/Makefile
> >>> @@ -1,6 +1,7 @@
> >>>  #SPDX-License-Identifier: GPL-2.0
> >>>
> >>>  CFLAGS +=3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2
> >>> +LDLIBS +=3D -lnuma
> >>>
> >>>  TEST_GEN_PROGS :=3D resctrl_tests
> >>>  EXTRA_SOURCES :=3D $(wildcard *.c)
> >>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c
> >>> b/tools/testing/selftests/resctrl/cmt_test.c
> >>> index 8968e36db99d..c5a49444c5a0 100644
> >>> --- a/tools/testing/selftests/resctrl/cmt_test.c
> >>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> >>> @@ -136,8 +136,11 @@ int cmt_resctrl_val(int cpu_no, int n, char
> >> **benchmark_cmd)
> >>>  		return ret;
> >>>
> >>>  	ret =3D check_results(&param, n);
> >>> -	if (ret)
> >>> +	if (ret) {
> >>> +		if (sub_numa_cluster_enable)
> >>> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
> >> is enabled, the
> >>> +CMT counters may not be accurate.\n");
> >>>  		return ret;
> >>> +	}
> >>>
> >>>  	cmt_test_cleanup();
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c
> >>> b/tools/testing/selftests/resctrl/mbm_test.c
> >>> index 8392e5c55ed0..7dc1bdf2d0b8 100644
> >>> --- a/tools/testing/selftests/resctrl/mbm_test.c
> >>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> >>> @@ -136,8 +136,11 @@ int mbm_bw_change(int span, int cpu_no, char
> >> *bw_report, char **benchmark_cmd)
> >>>  		return ret;
> >>>
> >>>  	ret =3D check_results(span);
> >>> -	if (ret)
> >>> +	if (ret) {
> >>> +		if (sub_numa_cluster_enable)
> >>> +			ksft_print_msg("Sub-NUMA Clustering(SNC) feature
> >> is enabled, the
> >>> +MBM counters may not be accurate.\n");
> >>>  		return ret;
> >>> +	}
> >>>
> >>>  	mbm_test_cleanup();
> >>>
> >>> diff --git a/tools/testing/selftests/resctrl/resctrl.h
> >>> b/tools/testing/selftests/resctrl/resctrl.h
> >>> index 1ad10c47e31d..4b8ad4fbd016 100644
> >>> --- a/tools/testing/selftests/resctrl/resctrl.h
> >>> +++ b/tools/testing/selftests/resctrl/resctrl.h
> >>> @@ -76,6 +76,7 @@ extern pid_t bm_pid, ppid;
> >>>
> >>>  extern char llc_occup_path[1024];
> >>>  extern bool is_amd;
> >>> +extern bool sub_numa_cluster_enable;
> >>>
> >>>  bool check_resctrlfs_support(void);  int filter_dmesg(void); @@
> >>> -85,6 +86,7 @@ int umount_resctrlfs(void);  int
> >>> validate_bw_report_request(char *bw_report);  bool
> >>> validate_resctrl_feature_request(const char *resctrl_val);  char
> >>> *fgrep(FILE *inf, const char *str);
> >>> +char *fgrep_last_match_line(FILE *inf, const char *str);
> >>>  int taskset_benchmark(pid_t bm_pid, int cpu_no);  void
> >>> run_benchmark(int signum, siginfo_t *info, void *ucontext);  int
> >>> write_schemata(char *ctrlgrp, char *schemata, int cpu_no, diff --git
> >>> a/tools/testing/selftests/resctrl/resctrl_tests.c
> >>> b/tools/testing/selftests/resctrl/resctrl_tests.c
> >>> index 3be0895c492b..bbab4a7f37ed 100644
> >>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> >>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> >>> @@ -8,12 +8,15 @@
> >>>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
> >>>   *    Fenghua Yu <fenghua.yu@intel.com>
> >>>   */
> >>> +#include <numa.h>
> >>> +#include <string.h>
> >>>  #include "resctrl.h"
> >>>
> >>>  #define BENCHMARK_ARGS		64
> >>>  #define BENCHMARK_ARG_SIZE	64
> >>>
> >>>  bool is_amd;
> >>> +bool sub_numa_cluster_enable;
> >>>
> >>>  void detect_amd(void)
> >>>  {
> >>> @@ -34,6 +37,35 @@ void detect_amd(void)
> >>>  	fclose(inf);
> >>>  }
> >>>
> >>> +void check_sub_numa_cluster(void)
> >>> +{
> >>> +	FILE *inf =3D fopen("/proc/cpuinfo", "r");
> >>> +	char *res, *s;
> >>> +	int socket_num =3D 0;
> >>> +	int numa_nodes =3D 0;
> >>> +
> >>> +	if (!inf)
> >>> +		return;
> >>> +
> >>> +	res =3D fgrep_last_match_line(inf, "physical id");
> >>> +
> >>> +	if (res) {
> >>> +		s =3D strpbrk(res, "1234567890");
> >>> +		socket_num =3D atoi(s) + 1;
> >>> +		free(res);
> >>> +	}
> >>> +	fclose(inf);
> >>> +
> >>> +	numa_nodes =3D numa_max_node() + 1;
> >>> +
> >>> +	/*
> >>> +	 * when the Sub-NUMA Clustering(SNC) feature is enabled,
> >>> +	 * the number of numa nodes is twice the number of sockets.
> >>> +	 */
> >>> +	if (numa_nodes =3D=3D (2 * socket_num))
> >>> +		sub_numa_cluster_enable =3D true;
> >>> +}
> >>
> >>
> >> Unfortunately there does not seem to be an architectural way to
> >> detect if SNC has been enabled and the above test is fragile wrt the
> >> assumptions about the topology of the system. What we need is a
> >> reliable and future-proof test but I do not know what that should be.
> >
> > I understand your concerns.
> > At least I know SNC affects on the 2nd Generation Intel Xeon.
> > So, how about just printing information when the test is running on 2nd
> Generation Intel Xeon?
> > That is, when the result of MBM&CMT test is "not ok"
> > and if running cpu model is 2nd Generation Intel Xeon, then print
> > information about the possibility of failure (SNC may be enabled).
> > How about this idea?
>=20
> I think that making this model specific would be hard to get right for al=
l systems
> and hard to maintain. Perhaps we could just print a generic message on fa=
ilure?
> Something
> like: "Intel CMT and MBM counters may be inaccurate when Sub-NUMA
> Clustering (SNC) is enabled. Ensure SNC is disabled in the BIOS if this s=
ystem
> supports SNC." I'd be the first to admit that this is not ideal and would
> appreciate suggestions for improvement. Unfortunately we seem to lack a
> reliable and future proof way to detect if SNC is enabled but I do look f=
orward to
> being corrected.

I can't think out a better idea, I am going to use your idea.
If MBM&CMT test is running on Intel cpu and the result of MBM&CMT test is "=
not ok",
then print a message:
"Intel CMT and MBM counters may be inaccurate when Sub-NUMA Clustering (SNC=
) is enabled.=20
Ensure SNC is disabled in the BIOS if this system supports SNC."


Best regards,
Tan Shaopeng

