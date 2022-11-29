Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AAB63B80B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 03:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiK2CgB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 21:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiK2Cfh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 21:35:37 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43046674;
        Mon, 28 Nov 2022 18:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669689317; x=1701225317;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=izSIgoXjUxHTluXy2pHi9YcXQpXtZU4vRWttBQQfWMM=;
  b=YVtRKjqxguA4TLMNpB1jhlZB8u5s81bZJ+prz9EsOipYpHLc4fUWbtdR
   DQw4OZiCxYcUNJdFk+CNdaAW1D/idQVjhDlkEHJBypy9tKa1fD9iRPoZ8
   0E5tq6FFJldI5y3f4W5GYzbyJfIoM2aXcQFWt/zrTYP/x0Gftsoro3T/L
   goEM1fc9mekRmuagj7//fhTOQBBxVMXFJ2BhHijHoAf69X+/NCCwgdWUZ
   8UPHPyvxAi7DE7KvU3h9uBgi7wsxA8Osvy7Xsj9JsohsxIoVYUUjt2Ugs
   rWlkkTmIgSh+65peKNcW9dQHwdwltph7bwgtwKPQ/lsYa5mHZT/GdvqdH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="379265845"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="379265845"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 18:35:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="972501610"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="972501610"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2022 18:35:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 28 Nov 2022 18:35:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 28 Nov 2022 18:35:14 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 28 Nov 2022 18:35:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+oQz2q9kf4KH3Wgf78yyxpYULvo5gusFl1TzhMQ/Vk/it6XpA1gYVYZVQtneNvacOy3vzGOQpuKKPTPk5lbIPWFkZNwURNrIH9e4xXKZwE9fRo3frHYGFDzDM8GkGW+wFs4b+2K/ptaZCb+cpk1iIwh3zXnA8H0CmuvfXr6iazq0E11DWas+wYl+z0UfHqfYt3KYjgvUdzrhAAAqLUSZxuKd/FeIiPTKA+O6NTBY0VLYg/SK58uq6kuJFR4xb3Pwwc/lSXWqMUIYvqX5L9sAZPzwMfMx1/u5pxDPtlMdyJLAR5rvtmK8BRgX26ht18LEmEsbjvPhA65NZGXf6tq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SstFRS59urPBLHGN+1RBuqZXDr8FEKNpvMG8wpXp+6o=;
 b=R/U14WmZl4u0NGl5Dp6WMtNNKz6upnF76+YMwJRioT8FTPg8eqIGuRaJovL7YtGu9QfC+RGJSqF8WgtzP6bG/8r7egqrDZ0oiJaExCoGyeiFdet1JJ41xXKG8X4TkJ/sisucsZvwjnmmvg0DNOdFKk+sNYPl+weNZ8Zi0ocll3QveY0qsRIHvI9BmDGscAfYzry7D0dR8Mzyf5lLP1WdNUpCXVgjfVRTMojLuJCegX+5l3UmTm7TQwwBrldD+9EdCfBuepOTTQwIyGYG1t3WEEOhOC3i4AWpJ6CGDLRKzRqn0+dp2tKHMzP/qCdjvPvLElX5u+C+6P6hQZ2W3bkJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB1320.namprd11.prod.outlook.com (2603:10b6:903:2b::21)
 by PH7PR11MB6835.namprd11.prod.outlook.com (2603:10b6:510:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 02:35:12 +0000
Received: from CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437]) by CY4PR11MB1320.namprd11.prod.outlook.com
 ([fe80::7c2b:3507:c308:2437%11]) with mapi id 15.20.5857.022; Tue, 29 Nov
 2022 02:35:12 +0000
From:   "Zhou, Jie2X" <jie2x.zhou@intel.com>
To:     "shuah@kernel.org" <shuah@kernel.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
Subject: fw_fallback.sh test failed in Debian 11
Thread-Topic: fw_fallback.sh test failed in Debian 11
Thread-Index: AQHZA5lIOHIFr50OcUq4S5sLOYsQuQ==
Date:   Tue, 29 Nov 2022 02:35:12 +0000
Message-ID: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB1320:EE_|PH7PR11MB6835:EE_
x-ms-office365-filtering-correlation-id: ff9547eb-5781-4a5d-ba5d-08dad1b25776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8IcTOEo+U8ENlqAlUD2jnZ7g6MUS5VwklOdZDKeK0ulAOZmKrRFOqcnEAnbq3Dza0Puw+8f2s7Q+HdPBQcoStYbgt+caqqbFRYUpU9PvoxrporVNMHoYlvqVd6Hcyj35G0d9/1N8WifxxVtshxmltQJxx0UraTrG0Nt+9dqRCK8EscHRs4fkNQqg+ggCR7UUSiT/YR2/UtAo3a9nIJERNJyeP9Pvol/zVhOKidN2Xap7PQgQiDg6o2mw1b7kILzwFV1q1kZ0DtDD/cwP77wvXh1roORr2yovVZZY1GqSz06sX+zw4R8iOPnOTWT2DOTXqgyTGCWIShGA0CpopNusf1rJzn/oha/8fO332f7Y/W8PBcWmDM46Onp/y2QJyAMESso73DTY1OgKc3U2O8PNPOihGG317XJ5vDw6yBjd6tcZKlIXbTfnoszHvFdyK+jVXAOV6yiUyNTmc/7pexwnTg05F8l8/wOdeqdfsNXchBcs2uylHBSaGGOGwm4XMxl+Qrop0fXgox/scl1MViiEdLfkmRv2x9AtV0pJ4w8luYIYJHSYUXY3NnfoqQ9N5V+1nfWlUv9fMfJWRCCG5HQc0eUSd+DAV0UtrRxX2Bxy808q9vDQD3kYLB9+ZwuCEMUr2qer6coynz7HfRAytqA67MLct9P2xNe6umHuKMDd2RRkHY/lLZrd/moKhwIi+iGJJPVssA+hknuBhC8tt75rrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199015)(2906002)(71200400001)(6636002)(91956017)(38100700002)(82960400001)(110136005)(41300700001)(86362001)(316002)(54906003)(5660300002)(76116006)(66476007)(33656002)(66556008)(64756008)(52536014)(66446008)(66946007)(8676002)(8936002)(4326008)(478600001)(6506007)(7696005)(55016003)(9686003)(26005)(107886003)(38070700005)(122000001)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vg70mUoBPYUlXjImH0qkI+FwTt1YSvxrnBB9l5Y4FP/Cdr/yGuk4bz+tfF?=
 =?iso-8859-1?Q?eCMiJxf0HiZq40Zc7XoWXQxLcSgFjn+jaZ5cNrQ+SAqgVRt5WhCbBicV5D?=
 =?iso-8859-1?Q?0j5mJZIY2xeccFyXuF3NTZwcX4qKnRrh/iialU6kClwxAEUq+p9haY0OpS?=
 =?iso-8859-1?Q?bu3aHt8hbEfto+mMNUzKF2I0uwk9r26yMnRC09LCByfJorEzmmE4mjerYg?=
 =?iso-8859-1?Q?U2y5+qRlIBpGZLDYQcTOYRZgy0TfwdJlLVul57MH2wKqyGqorghh/YC5MN?=
 =?iso-8859-1?Q?+3TMgJSm90XnJtmd+6YzNfswqpWxfCBP2xtThch9AFg6Ti8hBsTgxvX9lG?=
 =?iso-8859-1?Q?vdRaEq731j6Ml6orsyocgvG5WAk8oyKr20GrXRVf+X1qwYzZyHigNwjQxu?=
 =?iso-8859-1?Q?LdEAbOa2IZsm2gwKuAe/SRek7vY2bnIGUlayvZWhBtHLBycaxHDoJWVnkv?=
 =?iso-8859-1?Q?LaJCKyDp4mM4l+T+Wa0PpPOEF949SUF6y2tZH83lILfuFt+Lh5LRuMVnIz?=
 =?iso-8859-1?Q?6FTd9ssumpPZbMuBh2ZKCldTCUQYDjWpdILDKA1KdKmfo3uY625Yk/RzA7?=
 =?iso-8859-1?Q?l8dLU+FCjrlCHY+gqhRdWNUgCRtwIkA7Bg7nK6Sp0Cxrz1hyK1jKiFq6yd?=
 =?iso-8859-1?Q?k+J8/E5wD+c5NCCtQRFyeFTA2aHV9JjXknbm8P9ySiljkkPfqq60wmq0KZ?=
 =?iso-8859-1?Q?MgT6NsCQ+Igefa1b5/47BNK0bFD9MKSVfIokxTCJ3/perawLWfKjuhz1V0?=
 =?iso-8859-1?Q?pjKtVCaphO5zcvE1XrhCcM6d+tas6nC463rqpXELWYSJa0gD1+FfYcdJzb?=
 =?iso-8859-1?Q?7BzsV47k2+VM77tBky4OJU8mggf91LMtc9y9LMgEeJ+fB5A8Iin1HEK2dt?=
 =?iso-8859-1?Q?/EdwVMuP31rR945hPnDE6h/PAlSMppRWy0oFoFKNc0OWtryYLcCtVcoj77?=
 =?iso-8859-1?Q?wAtNbq7C838XH2PDzT0H+iCKg9OnVXjHMZMNpK2b6JAJWe4auH1NYSmIIa?=
 =?iso-8859-1?Q?jcL1Eylg8pZ0HnJ/jeqQHMe9ejzPUNjTtRrjK0ho3qv/vxcpUEfscJ16oc?=
 =?iso-8859-1?Q?YT0e3Q56cb3P3Lg0TBymzT6hg0pNGFsp5uqe0u1tO86OgfjhFHrvqD2Jt7?=
 =?iso-8859-1?Q?ciwbIrOvDBwl1lOrmmnBWYRa2KRsexgs2srpY9v+lukfB5y9RSxu5g3gL2?=
 =?iso-8859-1?Q?XKV/yhIKrYQyiM6Ggue5kq0SX57xh/jM4sGafXizySOfgE9au709WdRAGe?=
 =?iso-8859-1?Q?ospf/ZFzFXETBfrSehN7dIiXE3a45YYaHtXN8p7/N9CREEqyvCvz7mcMSs?=
 =?iso-8859-1?Q?opzMvZYVLpgmLFDqyR7KVoNuY31zVeKSQoLi+WYczg97dNqZL44kOiFm6K?=
 =?iso-8859-1?Q?JmcPYRueGCUXFyfQMTqYIeORiNG0mCInpekQX4a3d2VVsNVIChLzi/HMFq?=
 =?iso-8859-1?Q?suUGrohBpo5ZH2dWfvFkX2WxsAn5JxoLtM9PbKd1PvNdR7orky200nsonB?=
 =?iso-8859-1?Q?RKNSpgMAziScjY9+t50CQ3+Zpvh2eMBjcuko5fxkGzKkwfIW9R7n4lpKSU?=
 =?iso-8859-1?Q?jLOz+hmWK052T+uubXLfGcEvfQFFctoLgO/L4JWhWMts6hded4yO5rIZx9?=
 =?iso-8859-1?Q?1M2uBGgWWwWEEGjlWb/j2Bdzq/ilYCIk9+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9547eb-5781-4a5d-ba5d-08dad1b25776
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 02:35:12.7972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kejxlQJ/xbWn+7YCKDFpzXnmYahakxyvrlEE1+OCMOQb5JzxN4O6ymI6ryt76YMSzWUaXw2zgmp9dhK2usWSmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6835
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

hi,=0A=
=0A=
fw_fallback.sh test failed.=0A=
The error may caused by failed to write /sys/devices/virtual/misc/test_firm=
ware/trigger_request.=0A=
=0A=
diff firmware/fw_fallback.sh_org firmware/fw_fallback.sh=0A=
165c164,165=0A=
<       echo -n "nope-$NAME" >"$DIR"/trigger_request 2>/dev/null &=0A=
---=0A=
>       echo "echo -n \"nope-$NAME\" >\"$DIR\"/trigger_request &"=0A=
>       echo -n "nope-$NAME" >"$DIR"/trigger_request &=0A=
=0A=
# Test request_partial_firmware_into_buf() off=3D1 size=3D6 nofile: OK=0A=
# Test request_partial_firmware_into_buf() off=3D2 size=3D10 nofile: OK=0A=
# echo -n "nope-test-firmware.bin" >"/sys/devices/virtual/misc/test_firmwar=
e"/trigger_request &=0A=
# ./fw_fallback.sh: line 165: echo: write error: No such file or directory=
=0A=
# ./fw_fallback.sh: fallback mechanism immediately cancelled=0A=
=0A=
$ echo -n "nope-test-firmware.bin" >/sys/devices/virtual/misc/test_firmware=
/trigger_request =0A=
-bash: echo: write error: No such file or directory=0A=
=0A=
test OS: Debian 11=0A=
test kernel: v6.1-rc6=0A=
=0A=
test output:=0A=
# ./fw_fallback.sh: fallback mechanism immediately cancelled=0A=
# =0A=
# The file never appeared: /sys/devices/virtual/misc/test_firmware/nope-tes=
t-firmware.bin/loading=0A=
# =0A=
# This might be a distribution udev rule setup by your distribution=0A=
# to immediately cancel all fallback requests, this must be=0A=
# removed before running these tests. To confirm look for=0A=
# a firmware rule like /lib/udev/rules.d/50-firmware.rules=0A=
# and see if you have something like this:=0A=
# =0A=
# SUBSYSTEM=3D=3D"firmware", ACTION=3D=3D"add", ATTR{loading}=3D"-1"=0A=
# =0A=
# If you do remove this file or comment out this line before=0A=
# proceeding with these tests.=0A=
not ok 1 selftests: firmware: fw_run_tests.sh # exit=3D1=0A=
=0A=
There is not /lib/udev/rules.d/50-firmware.rules in Debian 11.=0A=
How can fw_run_tests.sh run successfully in Debian 11?=0A=
=0A=
best regards,=
