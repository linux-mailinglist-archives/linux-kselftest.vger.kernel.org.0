Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF54263E712
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 02:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLAB3O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 20:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLAB3N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 20:29:13 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F1698038;
        Wed, 30 Nov 2022 17:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669858152; x=1701394152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XIQxjt8Pl7YJKJPZZojunj7tRI42RjZF0kRPBdaVO2I=;
  b=TvOx+D2lC28RliOpm2N8TRsjqXTCiCWoOxqMqwdimzrbPwZU4HAzQeT+
   GA3P3Jxu4cv0qvN66IWjtc3lFP13Xr35ArYByGYG2wqBwJU5qjV8O7mBB
   CbfheGazDsrgBKBE8wQfBEXlvmNUABlWNQ2Ppu4iaTnGW8FiOpCnuPhF9
   ah0owBecmnKCcUoL8DChEblvZU5i3KcONMwzy/Vnd1Cask6pLlPnF4+v2
   R9flRMiVx92E/Jx5Ip61tncL3NnQWplHd7vJYGwE7iwRa7zMgnVMoV0gm
   T+RQUjNk0KWx3nq6uj4PVUa3ZeQ8dWBn7nhOmYCIa0OCBb/oc6GPHWaV9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="401832062"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="401832062"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 17:28:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="677033799"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="677033799"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 30 Nov 2022 17:28:56 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 30 Nov 2022 17:28:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 30 Nov 2022 17:28:55 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 30 Nov 2022 17:28:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2QCUGacT0QoC64nbasgwwPe92cH7DmaZudTQ0j6syJpYeiVVP4u7pMIEuSceN7Y1xpNFcLrj1BUCMyEm9peTdVn318EDwQVq8Rs0DZmZK/KG1uzdYG3gC/et0OqdRod9yrxcmLLF5sqL+hkDLaVak8mqItlMIxyWgKvaOTrs9jynOEgJ3c01GVIpIAz2nFgoU1BOTGvIVfttMui12+bccIwa15RfoDY92l6D9cWE5b6iV4hBV6DAcDiN4PHDr0AcA91NUOmRgVEXv5atW33fVhp4p6PxqjgcBIr7iEgr9Y/9BXcedJpgWuYC4Gh1KXVMzpYRGqabys8ZW/ImYEa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFM7Gtw86AHJvUUffo9UMx0x4A9aNeHCFp/rSn8AUqc=;
 b=TBmd8FEzdQvhE3kQegKS1Q2mSptbj9nhuZLMTdnYOLguTjO3fpy9T4nlAT01do5RNVkoRAtK/dZMPf4v+BmQfcmjDqmKhn8fq8HA5cxp0wxK4j8ZIatMumOVhMpvEHIabW6ICx1oFOzh5l6Rw9jxbfWiNB6uB/b4vsTLo9SW/sjCVF7wDjVM4T7oFVGnH4P67N3dwWKKUN4zKTWnED++oBbWWeU4Pz5Fp9Zu0T/D7Woh79/2Zy0I6AWGhprb5x+iGoWBXLr1c5gV3YdKSGDTp3g+BW+X3Ue1Iv+uvnbgjpP7JjjavOf1238g2Rt3rImqrQdCRI8t2D8h2X2RbVgRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by CY8PR11MB7266.namprd11.prod.outlook.com (2603:10b6:930:99::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 01:28:54 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437%11]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 01:28:54 +0000
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
Thread-Index: AQHZA5lIOHIFr50OcUq4S5sLOYsQua5VjYWAgAFsaHyAAMJuAIAAd7cVgAAD/YCAAAUgCA==
Date:   Thu, 1 Dec 2022 01:28:53 +0000
Message-ID: <CY4PR11MB13206A6918FFDEB5B3D3794BC5149@CY4PR11MB1320.namprd11.prod.outlook.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
 <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
 <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
 <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <217b7959-facc-1028-19be-1040898a705c@intel.com>
In-Reply-To: <217b7959-facc-1028-19be-1040898a705c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|CY8PR11MB7266:EE_
x-ms-office365-filtering-correlation-id: fa6d7716-d5eb-4c10-af23-08dad33b68c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8hosxLh1su8lGy/fGSb5R8quIXPDaMwRKdJqkqfER+Rn26/Dsi4sbU7KAXSQDfU4OlkeYcusZ0Fv5YDXJvUDOzRO9GFc7xiYXxK+xOovMwT22XPA12LKq5tDJMOw6fLZj+wXjGjNMiVSEUxE+zL8PKBURsehZQj/APGyWJ5AKNnPTHspReItLXz2vL0DkmMsgZz1npOUxin4vyi+ykM6uDvpz9aBZIBCke857rlMYwskyNQpv5zgJf13F2Q95ck4xomzuBaZ8V2hT3KeMjE22fTySaXoUcY+HjJuU8rgzPvTXYxIx48B6uSPXaNmcvClamLvfTpJKbkRqPmFVeXk5FbuVnLMN8bhK52PlXy+FM+p4no0VnTU/mxfyPJtArxfXwfjzcnCt9RQk/G1StDqv8OM/bZNOc0FeRKYUxdVZMsj//BuZ9xPmtcJihv1OEufvYtfAD6Hx5lZf/yAuQ6ERAxEa3vgYcngRk/I7X/ATE2vdChnC3c0hmkePrdVv77lq65QIBnuLCHPN/oO0T/Jrdl0051Z1wd6P8vO9cu0lKkaijxiK21RKePv1i4VAGujpXQmVUpzQ7wGPFbg6uAWDkOcMOw7u5rdFgvQBPIdOgHXpVdtz2Y4WDRRmC9pvuNzDP9pm/t/vwQCrlppW20Oi8pLe5Nw+UuWtJXdc5AnfFApNB51LvTzLjW/q55qAK7d7hZo6/n5cJ3azAQA4wSCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(41300700001)(86362001)(33656002)(55016003)(107886003)(5660300002)(66476007)(83380400001)(8676002)(316002)(76116006)(91956017)(26005)(71200400001)(7696005)(4326008)(110136005)(66446008)(9686003)(66946007)(6506007)(64756008)(66556008)(38070700005)(186003)(478600001)(82960400001)(54906003)(52536014)(8936002)(2906002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IDBaGuIXGXxInSft0SP26gjvRfjqMehIUlUmXqgp8OQJdMDE+JT5doEXpN?=
 =?iso-8859-1?Q?+CXzV3vtuWR1qk9Mk9AYAgmAOXLjqhC5jcc5PKxBAZ3oeRTNxPbvCAhIjv?=
 =?iso-8859-1?Q?4hvzz8ML4jESaR00t8M3RTXBlw6adCwwqW5IYRCKskdoibnPFv+xm8KvjB?=
 =?iso-8859-1?Q?kM2JQ7hGIWEHCAfnhDX4HCQ8lQ685pHJgL6z2cBwWxSBYiiqOhVOvKdnxJ?=
 =?iso-8859-1?Q?1SwuU3ARO3onP2HwYIKKuTyuazPSQQEW0XdeAw0Us+/q/5NGjuJhbTICd/?=
 =?iso-8859-1?Q?nT+IWlzMSVOcD53KkVq1VXKUIpqRWLC5dORh8bUPtb4yXbUAb79n1NUIx4?=
 =?iso-8859-1?Q?RyyqjTT3uoAlnDjGNBts/UKjd0/VQhSN644wlvBHJqxBEgstkVgAejrxBA?=
 =?iso-8859-1?Q?/wTnBPCYBYw8XtYwWfSGVN98LUhblP4wZymH4T0nssSpBCbeDKwYleNYKU?=
 =?iso-8859-1?Q?quP0o4DOHPb3fZVK1uLD3HKH6cGjXh6PYyqE8VE7yzgIbAea8isnI/jUWn?=
 =?iso-8859-1?Q?qgRPdLWnesMP2ZpksWn8dXvbj3pRICWT2RJQMLDlR/J7y8eo+whZv8gkZ6?=
 =?iso-8859-1?Q?Fj0/JQX/bc0Ex6/+zPbepCmIKa2cYUCn28NWDTy2SrS2ahfSdFP788mTVR?=
 =?iso-8859-1?Q?rrF2imbzXAKC2qNBoJIQa5FBaZxcqutQHu2piGXFvO5yfjfUcpD1cxlw9z?=
 =?iso-8859-1?Q?pvf+XkS5/0pt1Npdg79dVoz8f0Sg2ArWYYnkScrzQ3ahUQVZFoZhJPjXR6?=
 =?iso-8859-1?Q?0VS4g5rYJBn/yyXA5DVdipQKAteqrioJeURxkts1VB7ZzUdZVLgPS00pYj?=
 =?iso-8859-1?Q?bhEc2gyYu1iD/2Su1v+/PE/NISxOGHSy5JMwfomzUx8CXLC7MAnuxC1fMv?=
 =?iso-8859-1?Q?irNbLnBdf71zZFIFgmUR75fOHdu9oiywBlQ0+GI2+xiCb87Qorx4gV1umv?=
 =?iso-8859-1?Q?hzh7mNndf/m0PlBQeyjntQC2ehR0JYePfTUkj5Jjskb2EuspXxPkBDL/q8?=
 =?iso-8859-1?Q?agiu/l2qRdjLuYBjopd0+UT9eV5wMxgsZa79I1jmZ6WNe+LWTudWElZMIl?=
 =?iso-8859-1?Q?HWOuh2ZocsCRrLmwjlmdw99GnEI1dAzADhxRGZ9/nso7aQDTaaohrBwARp?=
 =?iso-8859-1?Q?85PrLvE/27Cvf0aTXM/lIrcHiCm4EpV+qMtXLhHgJJcpbACw0xIzJkjaS7?=
 =?iso-8859-1?Q?3RGiz5tHDRlJxKMQ+rM2NRTXuuZzUbBNqBwDkjWmtklfo+M097sTATc6oT?=
 =?iso-8859-1?Q?X7N7ptz06Fg5MBzC+T3dU24wiLAF0K7fafnNxOoKOc8pRpHrjU3oXMgV4O?=
 =?iso-8859-1?Q?HcaufEdLlxiuVEQxVBpfy8wvEWdvIyQuXA1Fl/WqF4tRdyoBKfkeK11GB+?=
 =?iso-8859-1?Q?OAOJ0l4n0YTQf0zHMNnJe3dHExW9ygTTngE0cbLyrhxMlqfaFYp4lAz0xv?=
 =?iso-8859-1?Q?RFuNdagBn2UqFSOrzfTb/YCjPtUrW1/tTAdx+ua2OMGOvu9WaVUjs5jSGs?=
 =?iso-8859-1?Q?ydbTvGMmf9KPkSIfAQue42tePNn66G+wflX8MQlMJR8zf5VV2h+0qVs//a?=
 =?iso-8859-1?Q?gyzFz9mKFFcmKZ+Gd64MchWypmcUhA1PiAx9ObiErQpIGQ5cU1gJQr138K?=
 =?iso-8859-1?Q?seiOe8LCbf+VHwzPMBscZPeC+bT4bwmz5V?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6d7716-d5eb-4c10-af23-08dad33b68c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 01:28:53.9710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KCsdwyx1cp5Yr9Vny0NMfSu2sl8zkm6eHo65iz00QZbTfZj81bGaiL9DKCEOEnU0r8fXfx1jAMb9NOhkAkVpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7266
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>How much of this path exists on your machine?=0A=
>/sys/devices/virtual/misc/test_firmware/trigger_request=0A=
This path exists.=0A=
=0A=
>And is there anything in the dmesg output that indicates a failure associa=
ted with=0A=
>the test_firmware device?=0A=
Yes.=0A=
=0A=
kern  :info  : [   77.858068] test_firmware: loading 'test-firmware.bin'=0A=
kern  :info  : [   77.864705] test_firmware: loaded: 8=0A=
kern  :info  : [   77.874250] test_firmware: loading 'test-firmware.bin'=0A=
kern  :warn  : [   77.880672] misc test_firmware: Direct firmware load for =
test-firmware.bin failed with error -2=0A=
kern  :info  : [   77.890106] test_firmware: load of 'test-firmware.bin' fa=
iled: -2=0A=
kern  :info  : [   78.896662] test_firmware: loading ''=0A=
kern  :info  : [   78.901059] test_firmware: load of '' failed: -22=0A=
kern  :info  : [   78.907422] test_firmware: loading ''=0A=
kern  :err   : [   78.912278] test_firmware: failed to async load firmware=
=0A=
kern  :info  : [   78.918594] test_firmware: loading 'nope-test-firmware.bi=
n'=0A=
kern  :warn  : [   78.925405] misc test_firmware: Direct firmware load for =
nope-test-firmware.bin failed with error -2=0A=
kern  :info  : [   78.935260] Ignoring firmware sysfs fallback due to sysct=
l knob=0A=
kern  :info  : [   78.941934] test_firmware: load of 'nope-test-firmware.bi=
n' failed: -2=0A=
kern  :info  : [   78.962155] test_firmware: loading 'test-firmware.bin'=0A=
kern  :info  : [   78.968232] test_firmware: loaded: 9=0A=
kern  :info  : [   78.986063] test_firmware: loading 'test-firmware.bin'=0A=
kern  :info  : [   78.992269] test_firmware: loaded: 9=0A=
kern  :info  : [   79.023611] test_firmware: reset=0A=
kern  :info  : [   79.028466] test_firmware: batched sync firmware loading =
'test-firmware.bin' 4 times=0A=
=0A=
best regards,=
