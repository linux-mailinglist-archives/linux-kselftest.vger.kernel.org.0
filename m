Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C246E71965F
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbjFAJHq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjFAJH3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:07:29 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013006.outbound.protection.outlook.com [52.101.54.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA7E119;
        Thu,  1 Jun 2023 02:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fen3ZWDnq3o7V3WpIvbMWyRss0Vx9ckbEIJucMvtnUHvXK5aIMZow5WZb5Ab1rbJ0JLLpbm74EDTWWwkerAn4O2VjnaBoMGtD3/pyWQ/7ENvZoIvvJ5SDZ65kJxXcWsgMJjJbBHW2H9DhhcJHqaF+YcF/neC3bh6R7R3ByD6JxlQYBuG6VsFja7RUYhEjLdMH6SJ131Qv67JNZZcL6qJYDxn2l7XX/zFB8UvnbFm5uPDG+W86xW3LrCNSnZrmZWZ5SqDOX92e/e/qMMtHyOIBhUWAXXL9U2v6uwyY376BCxRKVVNyyuRBJPRkmOkCYWk1jtPZbCmRdyd3R4DmPhyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjvdS9vBs9MdDO0gSp4VYeruSrLj48l9jEIMyZTt/3U=;
 b=lTg31ScGGOi+5703+5TVClnna3/8JCs0Jh0LTcaAKQdNH28YUtGAj9J/AnD4h4JMRxqxV/fnJk1/GJtHln9QzQbDzLujK62iAVVZxYN0BaPHLQ9TiFeBwJ8Paq8u7fEx181yh8QVfYxG7U0Dq/q4hiCiXn2Drw77IkUa5tqi8TuRF3MlWVcykwofjusSlk6qD07ZlVM5oKUHljsvgSocGY1sKKgBrkwdjr3cWenG2s9WHME1EIxkjm1nT0pMlcOg99xCa5+NMUm/c4K7HN1Gj2hhhgrzccGLcmp7Q8u85K5sVBUscz8jJaAVdjkalQjF5Z4e4ZTdZtgBs0iyTBATLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjvdS9vBs9MdDO0gSp4VYeruSrLj48l9jEIMyZTt/3U=;
 b=q6DVgJsq7rLFgq4f37NSbQXh0aqHMhhCo6g3qgD110grrLxa55WNhx9+NpSAU6xdG9W6SllaMD2bJwzzVYHeB4LHn49C8bCDiD5DqZXPgLx/uQ9yGkCbZzIIeHyC6PrQRnRKlHfZAIW8hxUfobmN56neMYopiKQzjmYkU1W/JUk=
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by IA1PR05MB10303.namprd05.prod.outlook.com (2603:10b6:208:3ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 09:07:22 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:07:22 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 00/10] tracing: introducing eventfs
Thread-Topic: [PATCH v3 00/10] tracing: introducing eventfs
Thread-Index: AQHZlGeSoCEyu7THQ0iKwxE3Uhr81a91qBaA
Date:   Thu, 1 Jun 2023 09:07:22 +0000
Message-ID: <2FE3777F-4BE0-4F77-B563-3A16BE05B988@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
In-Reply-To: <1685610013-33478-1-git-send-email-akaher@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8703:EE_|IA1PR05MB10303:EE_
x-ms-office365-filtering-correlation-id: 7299b42e-c02c-4896-fe8d-08db627f9c3b
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moWE+bH/o+0zoYSbduK9KHFvmIuf0zJDe1xZj9kBvH4MWAoVDYh1xS7KniVKKPgC3HCiziZA5cMfQb4GlfXNEi3fMpmG9T/suRD3cX31/yyQITie8tQkpCqSf7P4sXSdLVjnVoWaKGLrf1CruocZyEqaxEVvSEggiIqSo5lXQujqLEoInliQEWUSIiwqIt6NlbAj+8g2kpVY0F2ZKAv49RClb4fXNgoM7W8/cRagmG0ftG1YCoyWMQVcNMFApbhO72yiVviIy/umrz+5maenWxyFjSwD0cUFcBR06kIhvh78pL4t2+79OWCqxrWuWzRaqkTM3IKyOiq81bj7oEgd5BI5HelwYhLk1EEJgb6g05I6eALfQ1+0UvCXeatxtkFPpBIlcta3nas53GTOPPIRfsfk+gi+HQP+ZgWr7lPo871FK+SHLtcJuFpbpq95gR+/sJGUBWlb7mvjj4+XJqJlDIVd37wjV95L8be0dTukOYtg3OMd6PCqxkoDRLaOC0KAcgCR0GgcxnatA2qEb7dmX0UnzF+ZpjnyfRePo2aFOB+JJnJCYpitR+FURjELMejhw8wzgjjz4jODxDFjaypaOG0LPOzJnorcyoSIFO6KCz58TnWRsiBas0/5JGOR8FkYsdIRUuloUIk26rt2DietQtPNf2vwjFH72jtNxeNgfVwAEJaRh3ViuS0jq5uTCLOzxoldq9KdqGfvn6Hcbbk++A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(66476007)(91956017)(66446008)(4744005)(2906002)(76116006)(41300700001)(316002)(8676002)(4326008)(66556008)(66946007)(64756008)(54906003)(110136005)(8936002)(5660300002)(6486002)(53546011)(186003)(6506007)(2616005)(26005)(83380400001)(6512007)(86362001)(38070700005)(71200400001)(478600001)(33656002)(36756003)(122000001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DxSgOtJtBJ5uQroLRYNdBua+ATaitzBSysf+Ey52Q7taZ5tj4LTiRDenzC6j?=
 =?us-ascii?Q?Ha6j1tR85Mb9Or3mpdrrgs1yf2qWOf0uuchndIUTLYOFxxu/dyB4dV/Qr9e/?=
 =?us-ascii?Q?kXBd1dE1ycnItgEfv6Sa2CqhsPdIXfOV18/OJIvJoxsN+xr5X40E1d8Ed4JO?=
 =?us-ascii?Q?WLZE71XFwXyOOolWxz1DylcwL/optL6aiQp5OZBYebkUZtG0MAkvKLjTnhac?=
 =?us-ascii?Q?jI9AZu0aQG/rFx32u3LsEWiVjP3N1uPxN5UBx6UclRs9JTylaWAbHQSdD6JP?=
 =?us-ascii?Q?I4Q+s/dut7UZlwDpp+EzbylIV5rC3K/Rl09Tm9ucEl/cPYqdnnUGv1ZSicJn?=
 =?us-ascii?Q?nCZfwoxRoZRy6yaQAUhtz28Mk1gDaHUVJq3MeA5DuQMf+iO/9c+4AtHRq22U?=
 =?us-ascii?Q?hah1zTfquuTZ0BBqruQMqBN/G4ybeOtnbXo04Zw47egz20JvHfWKiBl3vTVS?=
 =?us-ascii?Q?Yw7e5c3sRCZApUErpTzMN6XK0T/UJLZtQDlgMro0heXBHXROnnsxRZ9asvFV?=
 =?us-ascii?Q?Q8kbTH6dR90S5WzfkOAwBFRIRovYCfTipk4MZwXrH7R56Tu2iFuGK15aH+IR?=
 =?us-ascii?Q?guJ4j76jUe/wPsDl0QiMbqv4kEk4JXCSG0j1FXkurlPB/ivra4L2u6NIEnTo?=
 =?us-ascii?Q?U7JFZygXDcEL1Mi2dbEfCJG6B+b17OF4lj1zu8xmJcjGaeiNHRs3MWTVAquJ?=
 =?us-ascii?Q?MZR/GTHyGAGUHt+wr8c1uhJSxxgnKulhZi/UVzCCdXgOPwCPwif5IlasY8Bj?=
 =?us-ascii?Q?TWtYzwm1qvDvisbRa90j6rQx9rUOiBKntxfywU6u+9zNXt3IK4V4OFfZjAJc?=
 =?us-ascii?Q?MXk4XXbXz6gg/HjlOqKOBiii4m2XhVbRCHSOF7UcCo3s+M8Shm/55KwivB/3?=
 =?us-ascii?Q?oU2SgK5lrslNxFArTngtfxaFFME8xBGsbtY4owHM0tVzzSB0RbwZlH/+vSmh?=
 =?us-ascii?Q?olZZJPSJRJqz2c38P6ScHIr938UWivOR4PF6BLjQ+AGe0QYTUfh1CBRp6BJB?=
 =?us-ascii?Q?mlJe3sjQMY6vR1usP0algzmYdmECvwIScs0d7ctZQcpP/ddX0M7QCeyueqee?=
 =?us-ascii?Q?0tchHP0yDtvSi3AlJxxT90mrnQVJyndk+0XNMdf8iFGZpoxRzovX5m/8/Qqx?=
 =?us-ascii?Q?cYXDwB7Ml0+4K7PTdHY41zPfdnhg6CwXDI4yNG5YXT7Qx4XMf2NnArtq0eRO?=
 =?us-ascii?Q?x4KxLJBGY02UbMfyC1x0grjDeq0lW9EOSwz+cb+I7Jc3aWZsIJ2hR1Wa5tce?=
 =?us-ascii?Q?zbAZ2yRRh/txGE8Czjrgh4N7xT2JpPMw+Ro+mUVySs052fB5SGei+oHHv1en?=
 =?us-ascii?Q?gKyXt/ClnuEd7PHy6LKKPU2SfE090WBvypTty9LeVfYAQ/cG3Z2Jq+/uUeD2?=
 =?us-ascii?Q?yZCmvn/YGvhK3rNh737GxbtKQa8MTlDateGz2QcbB3JUG7Ad6q6iBkonwxtE?=
 =?us-ascii?Q?YvxBjhTS8oV+e/0uwJhBBwXAWfCKqSKHZynLMlShtmFmIHgBDJF0DFoDSDMK?=
 =?us-ascii?Q?QyWSNRvhRh9y5VlZtuqfU+Q5gPBCP4bDOo87YqTFXiurvuX/VhTvFkhs18UC?=
 =?us-ascii?Q?ub/DnlFCLJZuJNpRPJJ+IQjGmkhynUIbOzIL9NsB?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4CDDEB0576FB4469F4F9B2EEA902423@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7299b42e-c02c-4896-fe8d-08db627f9c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 09:07:22.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcIInNHocKf441bo/9mIS8y1eDID4p+f8tH1d62XZBrbgJ2e1tjYFW/o7zU6wfKY0ZGgYj/NRvA+yvqS6gE4cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB10303
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 01-Jun-2023, at 2:30 PM, Ajay Kaher <akaher@vmware.com> wrote:
>=20
> Events Tracing infrastructure contains lot of files, directories
> (internally in terms of inodes, dentries). And ends up by consuming
> memory in MBs. We can have multiple events of Events Tracing, which
> further requires more memory.
>=20
> Instead of creating inodes/dentries, eventfs could keep meta-data and
> skip the creation of inodes/dentries. As and when require, eventfs will
> create the inodes/dentries only for required files/directories.
> Also eventfs would delete the inodes/dentries once no more requires
> but preserve the meta data.
>=20
> Tracing events took ~9MB, with this approach it took ~4.5MB
> for ~10K files/dir.
>=20

Steve, I have used nested rw-semaphore for eventfs locking (same as in cifs=
).
As per Amit Nadav, this has to be revisited/reviewed. Please have a look an=
d
share your thoughts.

-Ajay

