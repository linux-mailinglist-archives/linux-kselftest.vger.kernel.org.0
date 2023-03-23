Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81D6C60D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 08:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjCWHcY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjCWHcT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 03:32:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F6918B3B;
        Thu, 23 Mar 2023 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679556738; x=1711092738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=773tNWodRdGm8We6Ud2YRszkkZ+mdL7hzm6O6hNHTIU=;
  b=b5ZzmZIDaBuis9dWbY7paj19kUS3R3yk2zAyUdL+MTdNBxlMySGZ08Cf
   aZyi3G72wP+fxF9+a4dBCD/6oJC6rctfvSduMO7O6oUdZjkdKgt/7ollq
   iPHD8HggZwJ3lVRV/h6D/Iz3C1j3CtUK/pW1mlOv8ZYcYOwh+wgneAGMs
   lTUXjUAf9qOmcTUmRGZcuNlAu0SrnJWFzkueSOU89eDm0z5S0maP/Q0g2
   PjZ9nG6YqfNqe2OjcScMbsx13MV4pTqRFWG/z7ZeNheYvMuvOHFq37o12
   Sl/QlIlLRE6tFq1nwhmyjF9gSEblGgJfJrssvSLNFtJ2xhRudKmRNFJMc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="401987652"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="401987652"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 00:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="1011682150"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="1011682150"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2023 00:31:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 00:31:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 00:31:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 00:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doZAZMVecH28JFyfmL0plT8qRIe44ZVaLEg1cJi1pyXs6zBWbnQ4b20M/9UQadJ+tzb4vJPL39BSUqHRCbEgYm8IhT1s8IIijtJ5o45xIELDVA+G/uqU/piEPHcli08D64zzKYa6N7UYeo+iry56OBITfZjAwHVtJAgtSlI29M/MliuQ0sbb1MxZum3OhSMXSzBVbBCqeus8Cqb1YgvrRwQZyTttlrM4uvu56Vh4iVoFFGH+by/g53xj20wyCqzJjpxkQrUyN0aOpzwR7svkll/3cCOauYY4lzHwqAV0aIulftPiEqdWkHgTJh4Ek5wzEGWOUNoedDWvpAYn2mZveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQ8gqYdiJ0Ed/XnXIN/H/EFSCpUfXLnAgr19MgorNZg=;
 b=TbWudOEu1IA3HBOrgEqhxbYtqFJkwCXklbNH98LNNavCEsM09AwCJGPa3CaxdtFu+X9OnMxzWCJZzt9hcGzL3eAtGRowyuDjuOQ4BEEtr/ny2J4G+Qxfjgdm4BEm905s7Gz+xykSblb8XPCwSE4BYSqVrIy//l1dQ2KI5GfAqNl+uLp4vbGYj4WIEWQGZyi38NotKjj+By3MKBaAPmk6djPAibtDEmpQ28R8QIZzmZcOOjlK9OeR4vSefKNmbsffmg1AC3cTkWukwW8TfgzZn0UamXJK/Ld6uNi0XhQ9WlJLbIuT5wTYbq84seE7c3wGxUUgVa03Rgw99KFcaScZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5017.namprd11.prod.outlook.com (2603:10b6:806:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 07:31:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 07:31:03 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 12/17] iommufd: Add iommufd_device_replace()
Thread-Topic: [PATCH v3 12/17] iommufd: Add iommufd_device_replace()
Thread-Index: AQHZXCmQLfVu+4pznkeqY9jbKuj//68H+ZjA
Date:   Thu, 23 Mar 2023 07:31:02 +0000
Message-ID: <BN9PR11MB5276B73DF56654BEA4EA51AA8C879@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <12-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <12-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5017:EE_
x-ms-office365-filtering-correlation-id: a716d7a9-f44e-4f72-6d54-08db2b708e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBqNAojsY2Zwogiy/pi3D5CJ57QHZdC5iSVKoB+cnMDzfTRw9XxsLNgCXbv1M7xkZND7ekeAcZOuL5QtYt3DCXbsZ3D20CDWjlL0vUU9YCoHv8vaCjv3xzXyXu/xr52Ob8f7WSzmkDBLzNuhlgWBCjMRK7qz8DdWiOMyaA+amqk77A+0oRfrbhx3PCHVGBG+6JzDE20Qp/gnajnHOPEGDc0HgOEBBUrZ0IlKIfy5MybDPUhy+MV7GFphyz+eclKut8cH7ykODB58sVrMjPft1Vp44owZscbn4Rj/WgOHeb/j9bArSkTTBPDhCyH+t859VWdTUfBAMsGpkQ0eVtBRKiQ/vgbHgSOS1pf71d5mwHDqfc9UzCWKEQLXHDh6Ga2gfc/uM3DTemVzyBa17zf6J4yx6HLZ7iauNL+rWAX9gvHzNefvyb2XYA/w2syt2kSbGC+vc5JoIBIP2g7Ah638iTShiAU+vDSMBqQrpc//EYmxw1hKIcNzfhYJjZcPxUp1gRh39OfLz7adGeQD7DKyd/SGGmLhTCOXjkLJYWk6HvJiytvDm66iOjjIwRxdd7dY5MC5VU1zOQ/335auUV7nNdhrzMeCaWwN9OnPH8JxZ+NL5g4W634/CopGexHyaoD9cYwSl6/wG/Xeo68kykzSZ4my5udkGcQv6tLvpyH6/uMkZCbFrwRPoWLW2J/uJjtriO8jGaqMAIXJeGPbzy1Q3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199018)(86362001)(33656002)(82960400001)(38070700005)(122000001)(38100700002)(2906002)(64756008)(4744005)(41300700001)(66476007)(4326008)(66446008)(8676002)(5660300002)(52536014)(8936002)(66556008)(55016003)(66946007)(186003)(9686003)(83380400001)(6506007)(54906003)(110136005)(76116006)(478600001)(316002)(26005)(7696005)(71200400001)(66899018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2stCqR6sGG7DKAhkHNj1wHqU90Bwz6T8NoIKOYSb6r60SwE3uljZhwl1HDrp?=
 =?us-ascii?Q?q+Psg3nXLnrLH6iWdizBkkLDGRmw2eCd55PTVSBqVF83Na0yZI5K51NATzzU?=
 =?us-ascii?Q?MB+/qkLuwevYHjtF+cW8TITWjrD9lbiYlrf1/hrZaRzBh34C9DWB5OXa1W7m?=
 =?us-ascii?Q?g3OXLUpP3F3E0F0BPbv2fvRtkIPZ94n41bbgev+hxqTIEnxPefgMt2hyl3ul?=
 =?us-ascii?Q?0ttQVPJCorIXNzGdgyJJaAzF8UPgmqRu+JPdEwmi/2hcyvtTXkrVozCzKU4D?=
 =?us-ascii?Q?n2ZUtt1Xdjj9eSM7ZXSo7+itlzW46MDKCXxK4+RjdEehXdH/NDhDID+tPX49?=
 =?us-ascii?Q?JWKurL9YeOeldpecLge8Nvj7puAFvP5TwubCNupcczcfewwPidFC/6KEVnXR?=
 =?us-ascii?Q?j2GJSY4V5aGvaf5YGl+TpMBax9sP9YSOBqDVYSjWPXXbfDqwFWak7fJXC0up?=
 =?us-ascii?Q?bciOaPCIkrccmRmNM+m9YKpF6dV2SlNNVORA9ZG4CPp62UqJIwzTMv6q3INR?=
 =?us-ascii?Q?zLRMeEjYSb/xAfnqEVPEQ0R9W11OTrLYQ1UyxqWde/9/PdDSVwm6xLcuqHHu?=
 =?us-ascii?Q?QUkk4L3uj6ilqy5GEI3+HCnQfUIeSuQobqKDJfThfVheVxwlG/RNQYRLMNXq?=
 =?us-ascii?Q?dBWS3cB8YjrD68O3KL5Q48vOZ8M519zJ23dMg9rnVwZ83oAGknO9WMJNefIh?=
 =?us-ascii?Q?RJ2w8DoVrOvBBm38pi8fHqAqM0i35lHWW6UYCxbon+oPvEdvJqW3JE4jY6Ay?=
 =?us-ascii?Q?dHNto3ByxW/mli+08Pcpg+9b7Yw1YDjhTCyslM9I6hxsfBNc/OfK3D+zajLX?=
 =?us-ascii?Q?zM2AggnGsoraumaT8QSbPy10AUHTMgSR4SeH1bJ8yaTWWxaJ6J1B9qQQt+jE?=
 =?us-ascii?Q?sizsFtAMOx6ES2q+dKFU19Vd2kgsQnlIJFJcZ33QmvVKlZBwPPtFGIZ1q1/O?=
 =?us-ascii?Q?jgyoBCtBLfUQ4QjRDHQp+SnC3FUDpyrdDd25Yehg9qMj8hyBSSpIAty4RRE0?=
 =?us-ascii?Q?pqg+RRilmu3sUHEIooqa5L4pq+66ev9s9UZ+0geFXQ30Z1qDR8zy9DcdQWZW?=
 =?us-ascii?Q?UJVjSED5XhYTnN0uY+U/X3CNWTaxTJIvNgBGkRgZ+yU576/vq2+ukLlbiWy7?=
 =?us-ascii?Q?YNJydhAw5RMIYugDA3918/iBP2P1iLm94aw+36EZ5/mEi2BjS5pIEfWsi4Sg?=
 =?us-ascii?Q?+RmxL5oa8SBsQ3mmfu5/JSaXdkQjGgtKyaQzn+k4NF6CuazvLWOWykfHv3YP?=
 =?us-ascii?Q?Yh6aYq18Qi0NA31TP4IqlL75upcvOYGPgb6uflY5wVeQ3LOF4hICyqKN3iz2?=
 =?us-ascii?Q?xMFmaPq4DvwD+S+XRrqfFbF01Ee0PAYUbdjOenPAu50UEX7YaAggRmJGjIda?=
 =?us-ascii?Q?IFkSa3VH0P2qgFbKq5ZFZq90RfkBH+ehy++RN735PF8k8BTzNEPs4Gq3cgQ1?=
 =?us-ascii?Q?1Fg5Bo9t198KfjpbhO6HH5aswkmdernI5dYljiywpg6lURsXaskg2eN+dUNg?=
 =?us-ascii?Q?v4q8uGs6EZqeDg3pekb/fQmMLCVjxKEBqOne7ayONSWBsYwnImGmeSxfnhaO?=
 =?us-ascii?Q?t9IShieOBhm9sdms4eW8zD9n7FboPkIiScbOnkh2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a716d7a9-f44e-4f72-6d54-08db2b708e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 07:31:02.8834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TW3J5kB9bNcxXovt27uCkx89zuTlp2fB3YiRxvka1ww5eOEHWS9/woWBlHQaB6GOhnNP87l4HpGEc7irCIDpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:15 AM
> +
> +	mutex_lock(&idev->igroup->lock);
> +
> +	if (igroup->hwpt =3D=3D NULL) {
> +		rc =3D -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	if (hwpt =3D=3D igroup->hwpt) {
> +		mutex_unlock(&idev->igroup->lock);
> +		return NULL;
> +	}

goto err_unlock;

> +
> +	/* Move the refcounts held by the device_list to the new hwpt */
> +	refcount_add(num_devices, &hwpt->obj.users);
> +	if (num_devices > 1)
> +		WARN_ON(refcount_sub_and_test(num_devices - 1,
> +					      &old_hwpt->obj.users));

A comment is welcomed to match "caller must destroy old_hwpt".

Otherwise looks good.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
