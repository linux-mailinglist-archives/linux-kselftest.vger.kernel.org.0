Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72143640019
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 07:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiLBGCJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 01:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLBGCI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 01:02:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD15C1BF7;
        Thu,  1 Dec 2022 22:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669960927; x=1701496927;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7R5XTBxAypfuuhmaMqIFrNZ1roe+Dhm9J2HNjmsy15Q=;
  b=mzADClbEzukZhSigOvrlQnYblaWdSUTXwnmbF3xG+OfmHfl/IDmIj707
   aFSzHAoCdtHJvTM2HcYlse98j7EdWGKz7l6+ojDk8tlTbdTUokKiliSMS
   fphs0E49IhAvuMT60gBE+ezfYs3z0lCxI2Ea2gucYkp22ERdURB29gIgJ
   OCRb3IJD2JI+y95FsoEuejTLK6bpE/R6EPDuuD/VfK7nSd/6IMQ1VJXrM
   RTjC/haETGxHrFlrlvzgs5ZTqSeLQPkPIwZzEwuu24kN4/nTZCsdLd1ZT
   j41Cp8gYQ/C5XAW6veIh8bZbU/XeoaLi1UPKV8oVO9YKQScNzv/VY1Xlf
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="296233915"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="296233915"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:02:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="647042505"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="647042505"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2022 22:02:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 1 Dec 2022 22:02:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 1 Dec 2022 22:02:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 1 Dec 2022 22:02:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiCrFQG2a/1XS0NIpsIjEpWaiJ/HPgoUTD6lPL5rK/4r+kAUQ4QM7fBa8RMsHLDC58kcE/5MgeFOMY/HMFZPGCW/i5EpJXBf9Vc/+LobKMQmIKs17Bo6LIwAqlEVbumOYe8SrNmyVMp5zcdYB5RPWw+AJYJr1NRUAYFFaRjxkEyrWF0Q1e79cL+T7gu7aWYkorkzCj/4z1jwgcIoRa2SMEi2VUmJbQGhjyeVL0hehydw3i1Ibw7DY+xnMHkeYprJTSJy2asTp4HHUh/Ll2NGRHmIp8zpTKoH7kvgTurlqZODk5sxisaLl8Kb7e/0puwd79wxwWHgHMYtQ3rSCIPNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wzIpH4VpqBvYZ+VPhZu/tZHFIgXyFQLIgbkE0IcmY4=;
 b=hu0+GV118LbJL84Kb/utUXyqjx+UDpZ8Q2N0C3j1ArzD4H0HVtSiAe9o7l+2DD4jovKZrXJorrp1PaGn1ISjoFhZmFF7jYZJR+2TT4cxMDc7GlScN6e1CWWjDu7MO9eSaOxymINu6xEVWyjFh6aM7IVjcULMnRO09HkELWuPSAXzqfwQy/63JNVvTZ2Y5jiTPILcWwCnzbC59NLtHJbMNPiRIrh/kuRxfyGiEVGZFxw6y0jZ93p1eeyfVgPXXbb0KlVkGvpZwsrt97QHmxJjDfsz9aWEct2C/61q85Y3GmoXIGicavchOO884snvKehxLHzrobf0x2/Uj3MXZRmDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by DM6PR11MB4690.namprd11.prod.outlook.com (2603:10b6:5:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 06:02:03 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437%11]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 06:02:02 +0000
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
Thread-Index: AQHZA5lIOHIFr50OcUq4S5sLOYsQua5VjYWAgAFsaHyAAMJuAIAAd7cVgAAD/YCAAAUgCIAAF3IAgAHKUkU=
Date:   Fri, 2 Dec 2022 06:02:02 +0000
Message-ID: <CY4PR11MB132068A19AF9704D1B14814FC5179@CY4PR11MB1320.namprd11.prod.outlook.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
 <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
 <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
 <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <217b7959-facc-1028-19be-1040898a705c@intel.com>
 <CY4PR11MB13206A6918FFDEB5B3D3794BC5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <57b8f45b-da8c-e9ae-6b3f-ba82f936c9b2@intel.com>
In-Reply-To: <57b8f45b-da8c-e9ae-6b3f-ba82f936c9b2@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|DM6PR11MB4690:EE_
x-ms-office365-filtering-correlation-id: 4a622655-0afb-4ffd-789c-08dad42abb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: za1PUc/n8MN+b1nzWBpOAO1L5zqJn5bD/Hv8X16kB+C4U6hPiY+UVLgQ8zw857ZJ/8bmfd2rAl5HLAuAdQtoGAw7ymiJeF+SQGb4TvoPDkd9vyZphk8YJEdzpFkNgqm7y6RMxpx8jWSpDtGClbu+qln9t377rgldWbqbHiRnuDWEkpwgn5nXS0i4k+nd+/TPa01mEtAVLbh4w4zSse96LrXtJvEPeKq4vCTbNVxB/QlpPA5a9gaKSv25AuClS4DyvHgrI1aV7SqaCg9pRAIIKWHpiEzbNsZowxRUhdsFQYl1Ju6yds+9lfOGWTTgkLHBnzwir1s8iPBEnGO3yFjjWkybLiPbJx21mYFEkw0+g+KQmdtIvhS65j7n6n+QT0Vo2GUoMAiIOb3ERcY2m2qGtDTGgQnShi/ZLBCVyR22djAy5k3uuUWdhIgzmrH94huQxiSYEzHV6ald6xAUqEM1Qn2LJBaBWQX+vXkjrmc8XMvyqhadBHy0o8d1U+5LY18SgBEj1Yqqq/q7gJrSMqiqTfah6yRNxwdp8qDDe2JF/mjBN8K2pPCAhUszFwHHS4gRvckKDh5pFtDnRXbmfDBilqZP3DtrsKMeG1kQUvLFDCM5E00VZFd6ndNPgfKGGR264JmuF/OPBSguC8XbIHIjRrldMEczr+05Srq2IS5P7OAhBabZ0evB4wltYs6MHfgilnmorUNoTgvB6KtMGwhJxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(83380400001)(2906002)(5660300002)(41300700001)(52536014)(8936002)(186003)(33656002)(86362001)(55016003)(38100700002)(82960400001)(122000001)(38070700005)(54906003)(110136005)(66946007)(53546011)(316002)(7696005)(6506007)(26005)(478600001)(107886003)(71200400001)(76116006)(9686003)(8676002)(66476007)(91956017)(4326008)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1MMGqZunROrySZoSmHnynwrJ4IcmI0ZrmdJ9Xb2xEiDWcoFwxl41KIS+9gCC?=
 =?us-ascii?Q?WfrrxqqKDC0h5NURtFwrPkMUUN0d+r6tFjpomLJ0MALL+d3YT7SZaLg8Vea7?=
 =?us-ascii?Q?P9tSQxNykimTbbma/8LXbz/32fG2v1srw0Pw5WmMJ8K9ZJOfsFA1gGMjYmxN?=
 =?us-ascii?Q?opPA+NglqwYcfgaNusuq64bKY9dGrS4X0vB8BA6P3QibWZZDDeW038iyvJt/?=
 =?us-ascii?Q?2VPa9RyApT4oCWZwhwOtWlIMSz80f/cn/MsUeY/yrekrnmWc2Stoz/uUBCsH?=
 =?us-ascii?Q?TyMXVNMotRHROVQvwRE6cshsa2+XSylgFyDVEfgrzd1dIwGP2AhElOoXEPFf?=
 =?us-ascii?Q?uPfoCip9aF/iqgpWhborblWvye95rXdULZldY9E9/PMy2GSaBMk+JvYTjFYi?=
 =?us-ascii?Q?FNrTgINJUQ91dxaBX/dunixIwTQy289ZPKsN9XaseMe7XwXslQjThHyq6xbX?=
 =?us-ascii?Q?qu2IUnOak4ieIXzlgJwZP7pB2qXm+gIPsrIxz/gv5OXjg9/YccgNNL0OZqfZ?=
 =?us-ascii?Q?VlmemF5fUKsnw4ieESyTn1bw00XPWYTsUTh5abiQ9CYgRhEkG8YVpt/Xgb0y?=
 =?us-ascii?Q?xkGsOhJ2y+NdLDV+rOx5fkDC2pr35LM9qLu6NKWM/S3+1xw7Kacxmf99wdQl?=
 =?us-ascii?Q?fjE2ChhojMjooMCodS7eJTGQE7Qf+Uve6XqYoZDgaVmHtZ7UlYa259eNCouf?=
 =?us-ascii?Q?VyxVrQeKOfhs2S5/zH7p7+vmFIRFLpV+SUXugBnbsNLwoVI6UJl0QEmZFMhQ?=
 =?us-ascii?Q?RM+RCoYf3A+mSzUR6CdGGThIzjyM9JFxgJpOVpFeNmy2eizozkJxfq+nNM/9?=
 =?us-ascii?Q?itgyZL7gAXEw3sa8zW2T5A0cRP+YODRZdLGwhjZdMGSzt3+s6lI0aNi76l3p?=
 =?us-ascii?Q?aIrfovGarKqH7oB9i3L/yaQR68hhRR28sIAgjwUQZux40s3ulO2lML5eRWAn?=
 =?us-ascii?Q?61aqFdcZbyByrOM8Vn90Q/k/BQ3xXE2KXSgAA4T4M+1SmYFJjTCHhbYArIBI?=
 =?us-ascii?Q?WVdyNVfGaigrDRxJiM0gXvEz7xGRIBmJz6u0kDBGIsR4OWJaccW7uuyGELQh?=
 =?us-ascii?Q?O+zXOJlPruSgUlFHxbVyestxIPwVKpfugS+CHeSKpxbLJ4fzS2n4VhcoEo23?=
 =?us-ascii?Q?e1nJeDg+MVwNRuTwfGDqgVycjHajSxG4inzb8icX41EM9vjy3t33pdKiqeQJ?=
 =?us-ascii?Q?H+J4bcvAHdAzh5k9o5XbRAy/kWEtv3AvSnsQowYqO53wShnRKFKTg11OlRjy?=
 =?us-ascii?Q?6TZZtdZkW23JEGiGQs3j6BWktATPfsTSYyNWAf6jPmqgfM4sETDTP6hJOsI/?=
 =?us-ascii?Q?Kf961NTmeLpdOAP2XtbdCyCLMVIjnDJkgLdixlxLX79s/wwpwnriTbvpJH8i?=
 =?us-ascii?Q?C1PXcHgUBZj8kl25EhgAhNsXhcVVX11HKXJ2edK9iyzwkyE1ZmCFno7o9lB+?=
 =?us-ascii?Q?cFEM77mONNpFrhUvLoAjwp7D4PAfGwk5qbcxsMB1Wo+anmdHBb/2cML/UOVl?=
 =?us-ascii?Q?qdU7ceb9N++v/QdlBTYi+g4eflCX5WApIhtxpm6Erh/WjXPUIUO4YaoGvt3C?=
 =?us-ascii?Q?a8U66qH9GZGwwXoPmkX007GnrmWTJ1Up9Ncy9ymB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a622655-0afb-4ffd-789c-08dad42abb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 06:02:02.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3igObhn+X0G2aBDngQgbh30T13l/wO1zC1YpdPSb8Cfh/kX9JaqT1UGaHNqhZMg0YdO5dNdkfR27vGQHWCM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>The above message looks like the problem. Firmware sysfs fallback has been=
 turned off
>on this system using sysctl. Can you try turning it on and rerunning the t=
est?
Sorry, I don't know how to turn on firmware sysfs fallback.
Could you tell me?

I search the firmware fallback options in kernel config.
CONFIG_FW_LOADER_USER_HELPER=3Dy
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set

best regards,

________________________________________
From: Weight, Russell H <russell.h.weight@intel.com>
Sent: Thursday, December 1, 2022 10:37 AM
To: Zhou, Jie2X; gregkh@linuxfoundation.org
Cc: shuah@kernel.org; mcgrof@kernel.org; Zhang, Tianfei; linux-kselftest@vg=
er.kernel.org; linux-kernel@vger.kernel.org; Li, Philip
Subject: Re: fw_fallback.sh test failed in Debian 11



On 11/30/22 17:28, Zhou, Jie2X wrote:
>> How much of this path exists on your machine?
>> /sys/devices/virtual/misc/test_firmware/trigger_request
> This path exists.
>
>> And is there anything in the dmesg output that indicates a failure assoc=
iated with
>> the test_firmware device?
> Yes.
>
> kern  :info  : [   77.858068] test_firmware: loading 'test-firmware.bin'
> kern  :info  : [   77.864705] test_firmware: loaded: 8
> kern  :info  : [   77.874250] test_firmware: loading 'test-firmware.bin'
> kern  :warn  : [   77.880672] misc test_firmware: Direct firmware load fo=
r test-firmware.bin failed with error -2
> kern  :info  : [   77.890106] test_firmware: load of 'test-firmware.bin' =
failed: -2
> kern  :info  : [   78.896662] test_firmware: loading ''
> kern  :info  : [   78.901059] test_firmware: load of '' failed: -22
> kern  :info  : [   78.907422] test_firmware: loading ''
> kern  :err   : [   78.912278] test_firmware: failed to async load firmwar=
e
> kern  :info  : [   78.918594] test_firmware: loading 'nope-test-firmware.=
bin'
> kern  :warn  : [   78.925405] misc test_firmware: Direct firmware load fo=
r nope-test-firmware.bin failed with error -2
> kern  :info  : [   78.935260] Ignoring firmware sysfs fallback due to sys=
ctl knob

The above message looks like the problem. Firmware sysfs fallback has been =
turned off
on this system using sysctl. Can you try turning it on and rerunning the te=
st?

Thanks,
- Russ

> kern  :info  : [   78.941934] test_firmware: load of 'nope-test-firmware.=
bin' failed: -2
> kern  :info  : [   78.962155] test_firmware: loading 'test-firmware.bin'
> kern  :info  : [   78.968232] test_firmware: loaded: 9
> kern  :info  : [   78.986063] test_firmware: loading 'test-firmware.bin'
> kern  :info  : [   78.992269] test_firmware: loaded: 9
> kern  :info  : [   79.023611] test_firmware: reset
> kern  :info  : [   79.028466] test_firmware: batched sync firmware loadin=
g 'test-firmware.bin' 4 times
>
> best regards,

