Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AFC4C8595
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Mar 2022 08:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiCAHyD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Mar 2022 02:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiCAHxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Mar 2022 02:53:55 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 23:53:11 PST
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35574ECF4;
        Mon, 28 Feb 2022 23:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1646121192; x=1677657192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NQ1WfT+Ug1olONi4vG8JO7wqrKKa86SJVeTkQ21snv4=;
  b=uk7KXrc0zN5KkJbTfHW9aoMiREVUNJf724c4QyVPeFxVni5W0gWdaNTZ
   0jNqO9BrjLbLNkicZGU5TO3wZvLkpAVHPnNrNnBvxDJKt+/3mQw8PPg8Q
   IxqbR0lHh4o0ilfq6mTX0ZU7HoOWsiiByxW36mWQPMWcRnHr4+G4oGBOD
   1508uATlDaSkuXuIo5M1xHqlUAzlo98y9EYNrusLdYiYgn4cYl5uXCnZi
   r7MWOsG5QNYIzRGWo7K+28BmOwLlZ3Vfy5dMrOfFMPYAkwnVC5AbzJCaM
   xysIGYSSr5ElNhimZ2Mt+N+SI66tQf4+t8wQm+BbWvbDOH+OwfHCmhDC1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="58782886"
X-IronPort-AV: E=Sophos;i="5.90,145,1643641200"; 
   d="scan'208";a="58782886"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 16:52:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q76z4IzW/3uD9mQh/q4xzxcy04GKpp/tW1FOm+EWan5FbRSVesOP46CPbR18nA9NLtOQycyMderjwgyem+Fk3hWvej5uEOM5lqBy3wvBk8SNhi1J7fI0+MIZ7RZWSFmECANvzoIpHEOCB35qDcDRdII3omigKBxwsboCqCViGKOpDy4NCYm43Mx3LkxMXo+mhYqndYwwPFuT4tuSR40UJrSZNCoD04lTAlLOEh74WPQkdoQ9UFBigzD10SN3+jLxjcBkVRaCrJmISRrHMW4KRtaHbSfJpxUroXj2dSfP9b0fMetBHEop5kLtx7s6CKXkJW5fr+RiH8/Fp1Cqfu+SqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8feBRcSWkZ6BDJxEWTw3HItnd4+yjrIjlwaoOuQZlk=;
 b=kznOwgL/4wXCrqNinfgg+0IOpJsG+be9DjiQCZXyYX4ZwQx3P+wEU9QfX3WEaV9mDOJCEtruLK7WPQeiDtD/hwB4uEKP8m307xiBSiuVlHBNu6BYH04LfnkE+VicDxIK5D7hbP8b80YkcJJWY9eYbdWVgvZz1j46akYfWbse1muuNqT/MYrTQbukrkUcltS8qM9JlTOo0LZGLxQS/BzivE3WPf+PZvijrlGr9e7swCVA4zQwnp6k2e+gWiLAXwJSk4fb3TyIScR8JX7QqYLrvBKLHqZ5H38sVN9k8rnuR01aIWctYO7G7KOB8cLqOKtS5zLq0FvFp5+E0InVo39g0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8feBRcSWkZ6BDJxEWTw3HItnd4+yjrIjlwaoOuQZlk=;
 b=RKgCKpu5GDmVj63bwsxWQ1lbkLjlTZK4HUEHsBCLgoziVTQY4LIpOeuGN4Prq3cZJ9rODIXOC9dxGNEe3LCXSaiEh04ViKHDL1TojdQzzQunkuZqdRdTrDpaCv4YS4EH4v6iIGp5/bynJBlWqC4LAB7ANOt9WSxmfUVJN9NuWE4=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OSBPR01MB2888.jpnprd01.prod.outlook.com (2603:1096:604:1f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 07:51:56 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::bddf:b81c:fc55:3bbb%8]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 07:51:56 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Shuah Khan' <skhan@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Topic: [PATCH v3 2/5] selftests/resctrl: Make resctrl_tests run using
 kselftest framework
Thread-Index: AQHYItzk2ZSlsGQE1kGaxUOyn+5ZpayZxhMAgAV2X6CAAqR9gIACFABAgACuKQCABZjKwA==
Date:   Tue, 1 Mar 2022 07:51:56 +0000
Message-ID: <TYAPR01MB6330BC6417D2DC139B62916A8B029@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-3-tan.shaopeng@jp.fujitsu.com>
 <1bbc4049-2c08-39be-d82b-9d98ee663e72@linuxfoundation.org>
 <TYAPR01MB63302321D2A50D9A690993AF8B3B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <5200cb0b-6417-d97b-7f17-eae4bf4b0901@linuxfoundation.org>
 <TYAPR01MB6330E0C641FC7F0EEE0DCA688B3E9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <04c4e4b1-b499-8d35-2eb6-9914cc579c0b@linuxfoundation.org>
In-Reply-To: <04c4e4b1-b499-8d35-2eb6-9914cc579c0b@linuxfoundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-03-01T07:48:57Z;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=230bda17-cc0f-4fe9-8942-ea4d618f6e9a;
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9e39268-5c10-4b30-8098-08d9fb585b8d
x-ms-traffictypediagnostic: OSBPR01MB2888:EE_
x-microsoft-antispam-prvs: <OSBPR01MB2888A7D77AACC903D8454C5B8B029@OSBPR01MB2888.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stdbsAYm9pkSs2fNslxCEn2KXXpSSG5ns4oraTQXieJwpuBwh3OIvGQs73e2MJxuJEGbYQpLneX12k7V1jPlrX7KuxrBmyghRf5e4cQUbmerNl0sKJ3uK/SLagXG08vYK7Og1jilZlZ5rR+YnT5B7GjqGiPvJ9fbi6dFi4NR4MxZNlByGmxRDm+v5gkXOK1BncbY+i7Z4Ew4qzZaKcQNwyJuKP25eQgsD7tKkPWCZSpRK4B3RG73XH/XpcO7PLvsiM7TMBW0Rs2ldtGrnGcmmZfLsU8HeOaA8fCcBWr0TwG2TzizjAOVVo+3Mna7sLyJUGRH3TMh1zsSZyOjLCZklB0dCs69XcFCE7Arkym3pOs+vbyoIhitIyi8ymUG2ZqIj9bAKLKh9m40DFuVZpLVv2YkXjJJvQx+7usqXhv3HBgxrGP8/UvSSm9kwUfSGnsAicXo9cMonlRnldQVa99A7cJORkxVcwxAtfqY5q1p0wgbXuM+IQfpdqhvjDMC16eL5SnkjQ2noHcj+n0EE5m3kBGv+a3if2GPyY0dxgUlckJV2r86B2ho6dtKjjrn14VO4Kxo8X0kbP787+4vI25dSlbHH8hOKBwIUAOel37NqP21S3CjxsbDIYILCTL00NMyZbWRx2PLQlEOYP/zPVbVV3MBLrVhZFV8UtViuEvaVpJBaGEuZJbKHKZ5Nhs49Ig3ngTQ+OuBsonQfQW7ChLsfGJ/6WKvRgx56HQZPza2lW7F6s4RGhy/ZnT/WBYUaJIiWhR9Aq4KI6Gn5WTulyDQbiLqw/5uyd+IFp5fZkwLD/zWe/YT/zCChrFYQ+qmOzPoaH6i2GwNyn3uMzxaFKB9fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(9686003)(6506007)(7696005)(2906002)(64756008)(33656002)(66476007)(76116006)(8676002)(66446008)(4326008)(66556008)(53546011)(110136005)(966005)(122000001)(38070700005)(82960400001)(508600001)(54906003)(38100700002)(86362001)(316002)(8936002)(71200400001)(186003)(26005)(5660300002)(83380400001)(52536014)(55016003)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TEhPVk5xdmE4enJZcElHUEQ4eUhvQW1iQm9rTmJZeXY1cUtVNzk4OWpZ?=
 =?iso-2022-jp?B?VzVPUWxLUXNXWllycTZ5eDJMOEZtaGJGWlZ0SzhnK0FiVVZJckVTUWJG?=
 =?iso-2022-jp?B?SGRqNjdCb0N3eGM4dHlvQ2lUYURQRkdzNmllcDBBY3F5V0dsdEN0L3VN?=
 =?iso-2022-jp?B?aUJucXYyM1V6Tk9SUS9TYXpZMFAxMmgvQ1pPMnV3Qkkxc3dNRW0xb2RH?=
 =?iso-2022-jp?B?NFkwczBqUFBaMVlkVTkvM2g4VmtJWlRlWE4xQ2w3RDJCa25tSEpYZDdq?=
 =?iso-2022-jp?B?RXVoeFJ0eTJHTXRNMGNTRnR6ZnJqajlBWG8xakdnTnAyRlZTQmVHZG5k?=
 =?iso-2022-jp?B?YVNNc1VQSEJVYitnY3FoZFR4SThsUVZYREJBa3poS3AzKzhWdllvMFFy?=
 =?iso-2022-jp?B?aWE5L1liOGE0TzZFZmZ2WG5XMjAxT1JtbmFzVkdjNERtZUF6ajlJOFg2?=
 =?iso-2022-jp?B?R2xYaEp0ZmE5YTFXdEV3KzhSN1FqNXJHakFGb0YvSEtWZSs2R2RYNGk0?=
 =?iso-2022-jp?B?TEQwL0liMmt0Mk9ucG03MGNwcnFZbWNTZDdOVEs1VzRTdWM3M29TK1lG?=
 =?iso-2022-jp?B?MjNjZkJ2ZmN5ODM5d2JSeUhWZEV6SmgzanRsbHJmQTJBWGY1L29Qd1hZ?=
 =?iso-2022-jp?B?L3Uzd1FpdGV5ejdGZFZhcEJ4bFMxdlRaQ2dwNHMrVGU2YU1tZGE5RUhJ?=
 =?iso-2022-jp?B?T1ZIVTh3YUI2RTJONU1GbzJkTnQ4ckQzMmpyeFY4SS9mRWZJZ0d6RkxD?=
 =?iso-2022-jp?B?MVgrT3RPMkNhenFaZitSOFpGNTVYMno5MSsvUVRPWWJzYUh1MTdIMzhF?=
 =?iso-2022-jp?B?UUN5Z080b0htY0Rrb3hBK0NyUGlXVnl4YVNhZUYzUUdjMWR2RVRQZ2RW?=
 =?iso-2022-jp?B?eGs2VXpJdmdGTTU1UitJWDZ1Y3dwL3BycjV6SzJTN1hVdzdJT0Ftck1S?=
 =?iso-2022-jp?B?Nm1zWWJnbENMZUg3a29qbHlqRkZIYlZuZ2VwQ2J0OEg4eWlqSVBCVWZu?=
 =?iso-2022-jp?B?c2JrWjZQczkyVjB0b1dNYldpYUpmbmJDSk5tUHVQU1UzakltQ1hZUmNm?=
 =?iso-2022-jp?B?TXcvdml3aXpCMkxQNEd0NEtDRGJrMjBDdTJpYnBVZzlXN3NLZGljQ1NL?=
 =?iso-2022-jp?B?b1ZZaysySTFPTjdXMFJETXp6QWpVaHlCWlQwRjJ5TkNXTXZIYmNBRmNi?=
 =?iso-2022-jp?B?bXJWc2VKOFV1eTErVnEwb0JHajBIM21VS3h4NThyZ2Rnc1ZqdmlXenht?=
 =?iso-2022-jp?B?TDFrbG5RY0JwTHdrY0prSjZYdVFHQUJaU0RjQkFvdzZqL25DQU03OXh3?=
 =?iso-2022-jp?B?WURYc3p3TU01RGY0eWVkZFFGYmNZdjFyZk5ITTFsbXRqZFJ4NU9BVTk3?=
 =?iso-2022-jp?B?ZER4SnkwQnNkUXU2enJCOUNUald1ZEJ6eDl5cCtmUmlZTi95dVFtMUZ5?=
 =?iso-2022-jp?B?WUhWa1IyQzJwbGIyL1RLQS9IWHM0bkFGRGFwczhSd1NJbFJiRDhQTVFo?=
 =?iso-2022-jp?B?bmR5Rm5wYTFhUHhUVW82Y2dBcUhHeDRhNFcwNHBHaEE2Y3dvcGNuS2xK?=
 =?iso-2022-jp?B?UGg0SHRscXl1VDc4R2hFYzhhd1BrdkFzc25BQWdSVGh6NFR5RStFbTJq?=
 =?iso-2022-jp?B?UVU3ZmFZSVpYbFlJZDFQQVp2TjlXbTNQOHRWcHFTMkRPcUpEdjVqS2lO?=
 =?iso-2022-jp?B?alhRMStDbHFlcXR0VUx2eXlqRFpKTTdmREJHTVBtbHZGUUQzR3U4UVgz?=
 =?iso-2022-jp?B?QUVNUGNURE0xcXY5cXYxSUEvdjJWZ3hJanJ6VFEybzMzcDM0eXNhcmpQ?=
 =?iso-2022-jp?B?UlRkbU9haWdWMktDMlcwK3ptOVVoOGNqb0thMWM5V3R5S0R6RU1qMUtG?=
 =?iso-2022-jp?B?Z3JIR0tOcG1ZVFdPbzNGejlpQUlNcHRFck1vL0lxNnBTKzI1N2E5cmZk?=
 =?iso-2022-jp?B?cmt6d1ZqaEN4dmhOSHdDeStmcG1oT09zeGh1eGN6MHc4R2hweDBjbENP?=
 =?iso-2022-jp?B?WldXTkUzUVRnZVZGOCtsMXhkL25RbUFNb0hUY2tObGFsVnVzMjJPVWIr?=
 =?iso-2022-jp?B?U3NkRGlKTXpDUHJlb3VDSGhmR21idXFDZDZCdDdZemR4ejNzK1M2MzFL?=
 =?iso-2022-jp?B?L3drKzB2M1VMbU51V09hb0RnQmNQcGxrUFkwdGNjb21IWHZ3aXVtSDJL?=
 =?iso-2022-jp?B?a1dDMUI2cDhMMDUyQXRFMTRwS0sxalhtNW9BYThJTDVtMWsxSHZNWS9D?=
 =?iso-2022-jp?B?RTdaUkVHdVY0SGdxYkloNThGdWk5VFBZbmRxd3AvTFp5T3FkRkNnemQr?=
 =?iso-2022-jp?B?bXA1em40czZYZGdGMHd6SUZZM2EwcjVVczliZTB3ZGhzOHlEMkx1VGxV?=
 =?iso-2022-jp?B?UHdVVHNwTE9VQ3RJektZUFQyWU5FcTN2dU8xSC9DdkpFNnVSeElJcElq?=
 =?iso-2022-jp?B?V0xYRkVBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e39268-5c10-4b30-8098-08d9fb585b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:51:56.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8kw6RnvAtH3wEmjislgr5jQtfRPkpljnH99J8S6PP7IR/2aQDh862igI/0lf6kt/ps6uTIYf1PbXpTwHj23kXtyoGD18pUaGUl4LWPjSoPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2888
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

> On 2/25/22 1:02 AM, tan.shaopeng@fujitsu.com wrote:
> > Hi Shuah,
> >
> >> On 2/22/22 12:55 AM, tan.shaopeng@fujitsu.com wrote:
> >>> Hi Khan,
> >>>
> >>>> On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> >>>>> In kselftest framework, all tests can be build/run at a time, and
> >>>>> a sub test also can be build/run individually. As follows:
> >>>>> $ make -C tools/testing/selftests run_tests $ make -C
> >>>>> tools/testing/selftests TARGETS=3Dptrace run_tests
> >>>>>
> >>>>> However, resctrl_tests cannot be run using kselftest framework,
> >>>>> users have to change directory to
> >>>>> tools/testing/selftests/resctrl/, run "make" to build executable
> >>>>> file "resctrl_tests", and run "sudo ./resctrl_tests" to execute the=
 test.
> >>>>>
> >>>>> To build/run resctrl_tests using kselftest framework.
> >>>>> Modify tools/testing/selftests/Makefile and
> >>>>> tools/testing/selftests/resctrl/Makefile.
> >>>>>
> >>>>> Even after this change, users can still build/run resctrl_tests
> >>>>> without using framework as before.
> >>>>>
> >>>>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> >>>>> ---
> >>>>> Some important feedbacks from v1&v2 are addressed as follows:
> >>>>>
> >>>>> - The changelog mentions that changes were made to the resctrl
> >>>>>      selftest Makefile but it does not describe what the change
> >> accomplish
> >>>>>      or why they are needed.
> >>>>>      =3D> By changing the Makefile, resctrl_tests can use kselftest
> >>>>>         framework like other sub tests. I described this in changel=
og.
> >>>>>
> >>>>> - The changelog did not describe how a user may use the kselftest
> >>>>>      framework to run the resctrl tests nor the requested informati=
on
> >>>>>      on how existing workflows are impacted.
> >>>>>      =3D> I described how to build/run resctrl_tests with kselftest
> >> framework,
> >>>>>         and described the existing workflows are not impacted that
> >>>>> users
> >> can
> >>>>>         build/run resctrl_tests without using kselftest framework
> >>>>> as
> >> before.
> >>>>>
> >>>>> - tools/testing/selftests/resctrl/README should be updated.
> >>>>>      =3D> I separate the update of README to a new patch.[patch v3
> >>>>> 3/5]
> >>>>>
> >>>>> - Why is the meaning of "EXTRA_SOURCES" (i.e. what is "extra"?) and
> >>>>>      why is "SRCS" no longer sufficient?
> >>>>>      =3D> I referred to other Makefiles, and found "SRCS" is better
> >>>>>         than "EXTRA_SOURCES". So, I updated it to use "SRCS".
> >>>>>
> >>>>>     tools/testing/selftests/Makefile         |  1 +
> >>>>>     tools/testing/selftests/resctrl/Makefile | 20
> ++++++--------------
> >>>>>     2 files changed, 7 insertions(+), 14 deletions(-)
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/Makefile
> >>>>> b/tools/testing/selftests/Makefile
> >>>>> index c852eb40c4f7..7df397c6893c 100644
> >>>>> --- a/tools/testing/selftests/Makefile
> >>>>> +++ b/tools/testing/selftests/Makefile
> >>>>> @@ -51,6 +51,7 @@ TARGETS +=3D proc
> >>>>>     TARGETS +=3D pstore
> >>>>>     TARGETS +=3D ptrace
> >>>>>     TARGETS +=3D openat2
> >>>>> +TARGETS +=3D resctrl
> >>>>>     TARGETS +=3D rlimits
> >>>>>     TARGETS +=3D rseq
> >>>>>     TARGETS +=3D rtc
> >>>>> diff --git a/tools/testing/selftests/resctrl/Makefile
> >>>>> b/tools/testing/selftests/resctrl/Makefile
> >>>>> index 6bcee2ec91a9..de26638540ba 100644
> >>>>> --- a/tools/testing/selftests/resctrl/Makefile
> >>>>> +++ b/tools/testing/selftests/resctrl/Makefile
> >>>>> @@ -1,17 +1,9 @@
> >>>>> -CC =3D $(CROSS_COMPILE)gcc
> >>>>> -CFLAGS =3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2
> -SRCS=3D$(wildcard *.c)
> >>>>> -OBJS=3D$(SRCS:.c=3D.o)
> >>>>> +CFLAGS +=3D -g -Wall -O2 -D_FORTIFY_SOURCE=3D2
> >>>>>
> >>>>> -all: resctrl_tests
> >>>>> +TEST_GEN_PROGS :=3D resctrl_tests
> >>>>> +SRCS :=3D $(wildcard *.c)
> >>>>>
> >>>>> -$(OBJS): $(SRCS)
> >>>>> -	$(CC) $(CFLAGS) -c $(SRCS)
> >>>>> +all: $(TEST_GEN_PROGS)
> >>>>>
> >>>>> -resctrl_tests: $(OBJS)
> >>>>> -	$(CC) $(CFLAGS) -o $@ $^
> >>>>> -
> >>>>> -.PHONY: clean
> >>>>> -
> >>>>> -clean:
> >>>>> -	$(RM) $(OBJS) resctrl_tests
> >>>>> +$(TEST_GEN_PROGS): $(SRCS)
> >>>>
> >>>> This patch breaks the test build - the below use-cases fail
> >>>>
> >>>> make kselftest-all TARGETS=3Dresctrl
> >>>> make -C  tools/testing/selftests/ TARGETS=3Dresctrl
> >>>>
> >>>> Also a simple make in tools/testing/selftests/resctr
> >>>
> >>> Thanks for your feedbacks.
> >>> I applied these patches to the source below and built resctrl_tests
> >>> successfully using above use-cases on x86/arm machine.
> >>> (1)
> >>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>>    Tag: v5.16
> >>> (2)
> >>>    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t
> >>>    Tag: next-20220217
> >>>
> >>> Could you tell me which kernel source you used to build and what
> >>> error message you got?
> >>>
> >>
> >> I tried this on Linux 5.17-rc4
> >
> > I tried these patches on Linux 5.17-rc4 with gcc version 8.4.1 and
> > resctrl_tests is still built successfully.
> >
> > Could you tell me what error message you got when you built it?
>=20
> Here it is:
>=20
> make
> gcc   resctrl_tests.o cache.c cat_test.c cmt_test.c fill_buf.c mba_test.c
> mbm_test.c resctrlfs.c resctrl_tests.c resctrl_val.c   -o resctrl_tests
> /usr/bin/ld: /tmp/ccoarGr4.o:(.bss+0x0): multiple definition of `is_amd';
> resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl=
_tests.c
> :16: first defined here
> /usr/bin/ld: /tmp/ccoarGr4.o: in function `detect_amd':
> resctrl_tests.c:(.text+0x63b): multiple definition of `detect_amd';
> resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl=
_tests.c
> :19: first defined here
> /usr/bin/ld: /tmp/ccoarGr4.o: in function `tests_cleanup':
> resctrl_tests.c:(.text+0x780): multiple definition of `tests_cleanup';
> resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl=
_tests.c
> :50: first defined here
> /usr/bin/ld: /tmp/ccoarGr4.o: in function `main':
> resctrl_tests.c:(.text+0xadd): multiple definition of `main';
> resctrl_tests.o:/linux/linux_5.17/tools/testing/selftests/resctrl/resctrl=
_tests.c
> :129: first defined here
> collect2: error: ld returned 1 exit status
> make: *** [<builtin>: resctrl_tests] Error 1

I think resctrl_tests.o is an old file you left before applying this patch.=
=20
Please remove it before rebuilding.

Before applying this patch, the resctrl_tests.o file was generated and=20
saved in the current directory(tools/testing/selftests/resctrl/).
After applying this patch, the resctrl_tests.o file was not generated and
the compilation and linking work is done at one time by gcc.
These errors were caused by the previously left resctrl_tests.o file.

> I have gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0
>=20
> Take a look at the changes to
> tools/testing/selftests/resctrl/Makefile
>=20
> I don't think you need to make the changes you made. I would start small =
with
> including lib.mk and work from there.

Thanks for your advice.
Only the following codes can build resctrl_tests.
 + TEST_GEN_PROGS :=3D resctrl_tests
 + include ../lib.mk
 + $(OUTPUT)/resctrl_tests: $(wildcard *.c)
I will use these codes in next version(v4).

Best regards,
Tan Shaopeng
