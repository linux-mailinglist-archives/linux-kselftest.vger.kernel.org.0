Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD4597350
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiHQPqm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 11:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiHQPqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 11:46:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD080EAA;
        Wed, 17 Aug 2022 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660751198; x=1692287198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=30DcTU5PqArP5ckW9SBmfio4pm/gt4cCf7vpx+qst0w=;
  b=mJW8fvfqhozfpsBIfXSYww3FBQO2gi04W3lz1YIaUH8/pPUw41DM+TsQ
   xnl+xDX1GNIcIqrdKXMJEd51iSjxlg+5xL1R/T7fzNbGZFTuUqJvYwXEK
   zOI3F2zFYX73sSxMSWDJer6ffq5XUxeMEITKY6UNwcYfPebbb33iGkK12
   YaqWTErEXQCDwCCs57TfOR1aa760r77yHIKDbibJYNrtLNaA56q7oPiYZ
   FthzNmbkmE+WXp6qso/f87W9Epxt2zjtA0uYUjAF0zkz2jIalml6W7Ww3
   j9Uo3iDCdO1Sa6WV8hknIvoMzKj+9N3gDCCBUgrY0ACCOl2PjQ/bvOAiY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293320881"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="293320881"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 08:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="783454818"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2022 08:39:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 08:39:38 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 17 Aug 2022 08:39:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 17 Aug 2022 08:39:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 17 Aug 2022 08:39:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETL/Q4S28VWgh+buAB/CSBI7ewvVa//jsuw5u2IG9Hel6jfLAwG+NPPjpF86+4GleJ5DO28JDxIMipEx6jdX+VutVi7x7SPfdhNJC2d5VKCKRCMCmha7EGfdLrxwk8ZsVKoxstX4F2ldnlKLjyTAFGb80PwfOsOyOR1e+mlolweRv8/GTreYRY6kjeMNpgbeMPLuHZzmeFYuKhtuZ2stoVdfSsTkf4EmxPyo2hi1tny9y48ORvpuqC4C52G1Klbm/iiyGTN3+WE5wRotfMG9Vgyfv9BvRRdsWJleri9EqfVPTkLtCB0zODEx2a4x1OamP/YrHdJi67LLQmg4jeqkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a0+Ka4AWpfHRsQ8EgIxX26M5LQ06UlMd7FJlELPO3s=;
 b=hn1pEbL5gWCoKA1WutwHqzkvW4CaGBr9EOHleaASA1ZsjvLjHRPewlc9bVawvPI6U0/p49V42X2neQ1DjwMvNpyutIYK/vM92j86UWt0yeBpDEfDrrVL+5qndHH8w1xai9/d6lTNdus0gGZvOnAAxaNn0euYtQCs5VwKrhro4UppbXxJSOUsMJbzN6Jxx6Ll4rq1y0fSdtzBaqq4uBB3VPJQbMmqqc23qTCA7sIHj3hlb21n2ebe/+6OoHFVpHK+azN29cNQptnoOHR+O+fVAAtw3qX1skaye6wZZY4Y13wmidLuw4xAC+FqVtwLZPycHBJCz3qYw1SvJgHBy106+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 SJ1PR11MB6299.namprd11.prod.outlook.com (2603:10b6:a03:456::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.17; Wed, 17 Aug
 2022 15:39:36 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::21ea:5b3b:c98a:d2ee]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::21ea:5b3b:c98a:d2ee%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 15:39:36 +0000
From:   "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Thread-Topic: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Thread-Index: AQHYsQBK2Ad8oao9B0eIzoi6SNarlK2xt+wAgAB3W4CAABDRIIAA7BOAgAAQJ2A=
Date:   Wed, 17 Aug 2022 15:39:36 +0000
Message-ID: <DM8PR11MB55915BB75E3A6D266FC8D51DF66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yvz9g1dx9qbbMXJf@kernel.org>
In-Reply-To: <Yvz9g1dx9qbbMXJf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e09984f-72d7-4b85-2b27-08da8066b0e0
x-ms-traffictypediagnostic: SJ1PR11MB6299:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zKhdUXGY+DZfu+MbiAx/xYagb2yYHlYQQUKvp1f2kFsfpDRl9zke3rUby2WQzohcYTiiKGD9U1p7XWcz2rl8DyksdMmAY0ndbUPg40swCT/hzNELQXmEAS9kF3vsmCVNjibLgpRBkrspcwE43eTv0z/JW8EvMljpg9q4ZJO51PemqTcRvXYSAk3RHeexBpRHXidqfpCCUhJK6/7tPrBhGZanS59DzsFN90PIkFZWLHlp5YQetuSo5Kg6lBVWsPKO4keXPABZiw1sYv90X06Bqx3n+gi5ScvQ0kP3cUBewUj+Fq7fzjm31OyjsEot+eHZG0/UdtIyg2JZDb6g+YVjZmEaRxKWE+ezOrU5uYvAr6Z7d9izhz3Uws81prsIBApPcthgTRko5z5WOi0w8/+BTAXegHXQOHSrAzxDVlVMQQyNOHquWcYrzCZ7SisWyfGJ0oG+o6uGKk5s00NIB2N0JhK7stozk3Qk6D8cXc8rqkVm3ISakgVehl256tIsz0yg6smYD36NRZqE1J9jjwOtEjt3U2CElfISKVl1P5gZMMrffzEidYW/XjdLaveXdnuMy1rNLjMODu9CIvfTluS5lxvWYRU/d3RPY5LvA2xxIZBroh2axdQZDZlFajDjs8uxoCNfPatcGMOx3VVIXJgkVv2/c7RKh8nGDmYevNPQtoXFA1lo7VCmaxmAhlyqstkUFUK7lovLvMtTIzggFbDY0iQy99BSilgsD0xU7cRQooPKcHFgBYOxDFPixEdVql14YGzdJvujiOsUDENDcQApF0QIROY0AqF6NPwyGIVX9me7hSHNY7cFxGE+aWl561k4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5591.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(39860400002)(396003)(66476007)(64756008)(66946007)(66556008)(4326008)(66446008)(316002)(8676002)(6916009)(55016003)(76116006)(54906003)(5660300002)(52536014)(4744005)(8936002)(38100700002)(2906002)(122000001)(82960400001)(86362001)(38070700005)(478600001)(33656002)(53546011)(9686003)(6506007)(7696005)(26005)(41300700001)(71200400001)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?maEjiwh0qGY1cZ26AYNtAMaNXUlAswpMRAf0kyqN64s5G+/jPlfHGiy0IVq7?=
 =?us-ascii?Q?N4RNTjihTsXTqPr8BvGjMDp8WW5ZyWimQqIpQx48eto+oZRA2oGV7wG9vZLq?=
 =?us-ascii?Q?agcltUJxOazC5afEVtqjALldY18xkJf9vymstmlcNR3QJqz0gsZq+sO+rxxO?=
 =?us-ascii?Q?sI7vZfPI2ntalm9xZasjJoMF2rWXvLS8OiBeib/nKFxB+XEDBWJX53x/PXst?=
 =?us-ascii?Q?bQBu0WRv7kW5m6FdzeMqd5Gk5za3j0gil0m7nFr48mIm6vGKHWs1F0aGRSlc?=
 =?us-ascii?Q?t65V+DNNX5boaVxn1cEYMwS6ZJiYPUdj16SJG+nFeB+UuDwyVAHsr1ZErhgd?=
 =?us-ascii?Q?Ila+JhbIio8Ikt0y9EBrWx3APW/zLlj1ZyS3GG5ExVtSQJfzGh2e81el8iiz?=
 =?us-ascii?Q?meZVIdkA0wSb8oqvY0ElAChp46O6YeP6soG9QqzLfehnhw8xq7St2Bo/cSbY?=
 =?us-ascii?Q?bDFeC0hFx4pgpTrZ5mPn4v64S0D7PBKQkP21ko2sfgqGV/xGCuO8zVeYAF/t?=
 =?us-ascii?Q?d6+YhoVi50P+z/qNJYQggcfOmtq4SM7esgAUnIy7BQ2BQTUkx0sRXtqgBVRL?=
 =?us-ascii?Q?4SddFrxELAnfY3MCcepRgTeTC42bCpsHUijqjVdp3gZllEo7euJErjCFpR9t?=
 =?us-ascii?Q?/xhQWwsDw3LMAhNcslILs97C9hCUdQe2+BpeKSiUXDYw7yNrkcuE3pt4sUJ2?=
 =?us-ascii?Q?F/eU5rZURVDDUSIVo9OuwoCGyHFaNFrTnTrPyGQKj9CXDFO1kK/6ijzke0No?=
 =?us-ascii?Q?v9eP1rWYrIYT6QK3PUcyPBqKN/nFjn4mK0NjoHtWy4ZbD0RHEHNUFHlp5UP/?=
 =?us-ascii?Q?5QTu6pzY87m3S+CIu1azew/b2N+CICv5e1EFxW/HoJDzLgKLSkdjtfh/SSKc?=
 =?us-ascii?Q?A2+VZWPOWY4T0GKFI2JKaQ+daQTGdhmJIw9iiqfFsWOodGV2mghe8x0nA9fN?=
 =?us-ascii?Q?or0VrfalX26a0PYNNZHc+4pWl709aXjX7cRgmhv0GrBfWocVEoMdGSeWgL0S?=
 =?us-ascii?Q?3ha7hxTIxUnykMZ+SUlEIBcguS2M62kNXLghDC008F0EIJGIaNyaXtZN4urc?=
 =?us-ascii?Q?yWxyKVbrd1jwgMoTHrXMohn3pYQos0dQGQPqthA5PL+XCiGqSsHg11DfxJ1X?=
 =?us-ascii?Q?g37f8L5TUTAaclo1ypqyJiF3deTFoayLhvsCURzEgUlP6elbMoojYizV0ALU?=
 =?us-ascii?Q?MQUiYfPfIideoSwI9IQbcrNoGzhjb1LK1rRdepX0lEk6uTkmdW39RmAC2Emi?=
 =?us-ascii?Q?a4fWAJRNRK6VeOMzqfJCvJUMWN6I0WOWA+ev8nFSMWvhQv3YrY6mHZ7U8979?=
 =?us-ascii?Q?ci7UxGIMUtTPyHSyM1oGwheKBw4+z1pZyF3e9tIdCaaqqWN391Qc59gkHwVG?=
 =?us-ascii?Q?/ZozxbqOeNCwv0HJH8BkD9LfMIkRXn2auZRXN7WgzY6iWqmkutBs69DJvt/Q?=
 =?us-ascii?Q?TZN0Pz9i4Ji02Dqxb8XewuvJ/R1/DWLb7KNXbY2WVss1vPDYLWfs42uHZOeA?=
 =?us-ascii?Q?9zzW8G1+QUDngGPw9siYRa+FbW3uQD8Dig7KWgEMTFxk6MbCo1wfSpRtVuxr?=
 =?us-ascii?Q?1FG1jdcoVp48jDm/0yWYI1RyS8o9JDN1fQl3Ywz3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e09984f-72d7-4b85-2b27-08da8066b0e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 15:39:36.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBd7LlAfR5hVsp/Qa6V+yZ/mrSHyZYnTH8kUpRyNyEaZyY/Yr63ZwsmhRBAEiEV4sZUtUdgr5EVruPCaObNsIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6299
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> -----Original Message-----
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: Wednesday, August 17, 2022 7:39 AM
> To: Dhanraj, Vijay <vijay.dhanraj@intel.com>
> Cc: Chatre, Reinette <reinette.chatre@intel.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; linux-sgx@vger.kernel.org; Shuah Khan
> <shuah@kernel.org>; open list:KERNEL SELFTEST FRAMEWORK <linux-
> kselftest@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
> augment_via_eaccept_long
>=20
> On Wed, Aug 17, 2022 at 01:27:38AM +0000, Dhanraj, Vijay wrote:
> > I think changing it to "int i" will cause a buffer overflow with
> > edmm_size being 8GB.
>=20
> Hmm.. 'i' iterates segments. Amd I missing something?
>=20
> BR, Jarkko

It is also used when iterating over pages to eaccept. This might cause an i=
ssue.

	for (i =3D 0; i < edmm_size; i +=3D 4096) {
		eaccept_op.epc_addr =3D (uint64_t)(addr + i);

Regards, Vijay
