Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D163E6A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 01:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLAAnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 19:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLAAnJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 19:43:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192DB20BCE;
        Wed, 30 Nov 2022 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669855388; x=1701391388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E5cHnLCGd0+Q+kpKhpyiHQkB578yaV3W3SqX+iZm194=;
  b=HFG+HimCMYA5ixjior1oR7x7DfMVZqdqa1SCY8O7JQ7bW07qR28QuRyX
   goMa+2kbMt7deBa9tKv0MMplJk7A2Hq0kd0W3//yHww5al7GjV4lnjRN4
   UXZR8SpL+3L7VCmvFRwdn/ZBzgDToJk+tgyOjsNQ0KvI2sFoJvQTJEkpe
   JdpLS0Rqbuk+RibqiD5HWlxROMjhDeJ6ceoKtuL4uLsc1JnxEcDpD6Hzo
   BXLquhuhKZlB/zEreDZNDGB9s4Hj9vJxXk5XD5fRr01/wvC+5fAW1hAr6
   gDz2VhNT44hMBwnB4lZd6lyNNVhA5zUrpceB+glQgYOkbNIZ6hptVJSe6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="342476256"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="342476256"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:42:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733197310"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733197310"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2022 16:42:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 16:42:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 16:42:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 16:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvOwrMRpIXxzHhezqogXb24vUzkBXzcxgyB5gLpGjlRbt5yXI1w3ZLa4Y7TW65STphvt72s9TrxhCtnyAsEep3XXIzebVZUMyIcFuyl1tgxJG07DZ2l8tQ8A25BotAxZBjc1wzHojzpB4RMyduxfZ0DVh0jfPpdL8zGE1zHWOCZgWTRfOWmC5uuJPXvyyTAqvVRC7cyFgfFi9LtYgeNGTqbOyHxoM6GhkvW5elNUvNQoNrjtF8xz1C6kV9QzYYbif0yV2juirjdKp+5yahT10wIN7rzudOYHG7rRZju5OydNCHHy0p9ichvz3FKkwHqZOlz5SFgYCbl/m41Cu1dAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVVkhgXOAkwnPiZJsCDee8XnP+qS+RPOw+BtUYMBEnE=;
 b=LLKKS1RyPAD3ybfXjU4Y5/qZv4QvPzcazJWw6tVJ4gjZY4zCK8fl/2LhcBPmEnjks2EeXoVP7tZP9LVMxodOcHQeAvrHC3shdiTuwbV/2IayjlkgR/2nVm4b34mKx9GME0x6k2mFH/UBmCB18W+pzveh/gYVHIAsNFYsJY2mJ71Ul14g+f33CUfA5LBACUIXPBebtRxtuHowFTy43NsbbEcBlyp+Tc+TSGcdrUGBpHClF8kGBmRAg4A1O51fLhIqnVEWac7tx2tsCsm+NGj5VbiU0I+TQUEsEYOhea5ecoLAW7WECf41O/9X3jY6ILfenFQYuZg9BWDBqVnrLr28XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Thu, 1 Dec
 2022 00:42:54 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437%11]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 00:42:54 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: Re: fw_fallback.sh test failed in Debian 11
Thread-Topic: fw_fallback.sh test failed in Debian 11
Thread-Index: AQHZA5lIOHIFr50OcUq4S5sLOYsQua5VjYWAgAFsaHyAAMJuAIAAd7cV
Date:   Thu, 1 Dec 2022 00:42:54 +0000
Message-ID: <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
 <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
 <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
In-Reply-To: <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: 558c08c7-fb7a-4c90-dc4a-08dad334fc15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vcr+BtC1Ccb7pyjd0UEjyLg7Gx1cvkPq/33rOFrr114adUf8nxxNNkcQEnds76nKfUSOf8UEx+on0bVDnE+uN0norZr1UsbFhqlSlswUVRdVKG/NlN1/iD0sQZ9jodUGWkZJNSxVKk9rEsqRohGKROrEHCdtASU/YPejpToVcXJ5BhLToMgQR/j4OhZz7kmnDWPjHKSi5GRqc+DJcTacnezIYO2+Gn1W9/HB+ld1FFeZSfn6vzWsmPrmjqFmHKBgDuXworjNQTnVnU1zPe2eeKJZpyPPFqIb/Uh02SFmc1nJrHP9tE8ghJbxyUEUyzv+8cY+JCjkFj6KPB/PoX8BFLUJILiFOPkzD83IQJkXuFJXOgnS9M7Irij5kda7UQkhzSP/vZm3SF1qNK18GI+CxSOR5qdG7BU9mTakEXZhOD5oI1/VCVqaQX6BkH2Cd/Os9sRTifgMaEwbCRn6TRpJZB4GEwFikfNUYz7O7LypyqmTxRugyw8/gyQ1QsvTxlORPqeR0sUugDvZ2rGU3UFUvypsjDlVv09sIW5wfgu0sSn4S+mLsoGK+VpJotKiIgu5NexI3Go9mnSIB6pqNKLbUeLYbrNGyhKlhX1nlAvpiyqM92iITi4t2d9pVZJQTh9uOOW++txeYuFD4ZqYhL4W6EEmuq4T4wSgl4QW7kLxoMZnnOx1Tq0533tXw/vyoyg7yYv1Ll7CH7Wsv0Fv5ZCGaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199015)(66946007)(76116006)(41300700001)(66556008)(4326008)(91956017)(66446008)(4744005)(9686003)(8676002)(54906003)(64756008)(8936002)(52536014)(66476007)(110136005)(26005)(478600001)(5660300002)(2906002)(7696005)(71200400001)(6506007)(186003)(83380400001)(55016003)(86362001)(107886003)(38070700005)(82960400001)(316002)(33656002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?omTgklRKZqdeFLloBOzqBcxII/fzuPResXi6p2Uz+MbiVismX6kOK7a7fb?=
 =?iso-8859-1?Q?sRLvVTMf/q/8o5wRW1TA3I3CczMPKDDRzT3lVW3iIPzN1fnIQlf2oufD/v?=
 =?iso-8859-1?Q?PaboZcKYW69c6AAyFrs0Tytt1gMpM48gqFpf2FINgpp+45/ABtEB+p1EAn?=
 =?iso-8859-1?Q?sWPoT8OdqjlCT0iLKs3eTlFodvwM40Ds0OW9FRoGeZsyFRiOc+9kxy7vd9?=
 =?iso-8859-1?Q?VFiSeA2R95CD8tsLPzJv77rHhWeX2nAIIPsMoz5WBHx5r7c+QRVH75ezTw?=
 =?iso-8859-1?Q?s+/zxP4rY/gr9q508+u4fB04z59kKg8umUrV5mNdzT1gqeLNcNYZv1mJkI?=
 =?iso-8859-1?Q?0TJpzDk/mgS7m2hEq/JyPtRYIBhFNHxuM3FyQ/tq6qZcLBgWbqGmdO8vJ3?=
 =?iso-8859-1?Q?8nwC1pLYsiFGlfXnv3JGzw1rLMORmsJUu8muyxVRigN56v+eEr15rNB+H0?=
 =?iso-8859-1?Q?2t/FQ0Zrnhop3OtBiMyrSrtfzlar6sthONqYX1ToAbkduAeHJEA/TZMMEa?=
 =?iso-8859-1?Q?al0Tza/naR1c5Bqm0jBza4hZdfxGOJEY/UsfaX4ujhi189D/UoVtOkGDXF?=
 =?iso-8859-1?Q?sNA0b5KwgnTPXJ2MMuGWokePqyCKD4sreo4RGB+201Gw+HDLchAVLwtYNV?=
 =?iso-8859-1?Q?YBsgHwF35eSr34/CqYykvVSRIMqinSKwRn4sq5EBzcRdhfqMlaCyIfKCrH?=
 =?iso-8859-1?Q?b8wdRq2GaUbX0QvYgGt0bDFCdV7E167davmFF63SbXNNxkcwOBJa+7wBDi?=
 =?iso-8859-1?Q?MvsBWJ93JtZpk89TMVKo6jUCeWuhwKfyymPtG4rY5uUUDT7cIQxvLpAQOR?=
 =?iso-8859-1?Q?fWaikARa4Obf7kpXIQxruc7hJYytD+QeefqbPeLJ2A3obCvIBlTGzJSXAV?=
 =?iso-8859-1?Q?jB6h5plyFOB3HqlTh6TNDimo8zw+S0RbK1/Z8bp+6FjHZesqdZhuiv3Ky5?=
 =?iso-8859-1?Q?0Kv0xGYe7aSwu6pBzqfFQWTTwkPjJOdOeIPwXszgQZr5QDLmCnZMriaJzq?=
 =?iso-8859-1?Q?wZ7ef3DyEInersD/l1LhiGdg3Hq85jJdWzW0ZwbOjj8tZTQY+giUnzvLjP?=
 =?iso-8859-1?Q?cShTe3P5JoOJEJ7G1L4u0/Kw5QQMBt8aOEfhwxi0o4IAwLLT9oYUJRXC4c?=
 =?iso-8859-1?Q?YhjOZO3cKFg+DvsR4K45nAWLjn1hJ1FeMvUND6awgNX+qbDslwmZ5mDM3K?=
 =?iso-8859-1?Q?G6I6+tBAaRkOaHJ9iGXzuJrhqx7ojqJL3rkP8GH/TfK4WXqqdPl5SpT05x?=
 =?iso-8859-1?Q?lL3FpXMpZNoDzSkORYxUMW7MuLJHsdYQDG86cbHPuUUwjeXC5cbJZWD0jU?=
 =?iso-8859-1?Q?xszF2qACtNSrXOamR0qyNnWHEPsMR59QQ9qwqK6tB5gtMaGOjrALfUBhP0?=
 =?iso-8859-1?Q?68whMFVaQyf+2iCtisK2zAufZTV9BDD1hhGPADqtGUXqIkLnPkLo1spWM8?=
 =?iso-8859-1?Q?fZAKbWEeSLnDpXylK6Z7SfUX0zouUZTfqPTUmakgAjzYVTPzAGPpK+LgY9?=
 =?iso-8859-1?Q?5AZnp9BwX/nh5fr2loufclgGfhL+/wPLF2UjV5cavV5kgRtCy+FFAO+r0p?=
 =?iso-8859-1?Q?hNnf9RLM1+us0e+baE0DFX69uY7mI+Ys026Segi/hamhpI8KnnKpEK3lH4?=
 =?iso-8859-1?Q?2yXHmKoAPVgxx1gRkNkKG5xJQyU1m8Xea6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558c08c7-fb7a-4c90-dc4a-08dad334fc15
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 00:42:54.6772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9z2T1hPCruI28T3c461fd3p1lfStqlVcEZA72WVXj8n10m3lLXutkLaB5nLqm/EN21XBlkEm2Lww8wFW3GDPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hi Russ,=0A=
=0A=
>> Are you sure you have the proper kernel code loaded with the test=0A=
>> firmware code that creates this sysfs file?  Without that, this test=0A=
>> will not work.=0A=
>Nevertheless, the error message you reported in your first email indicates=
=0A=
>that the test_firmware device may not be present. Did you verify that the =
running=0A=
>system reports the expected configs? What does the following command show?=
=0A=
~# zgrep CONFIG_TEST_FIRMWARE /proc/config.gz=0A=
CONFIG_TEST_FIRMWARE=3Dy=0A=
=0A=
best regards,=
