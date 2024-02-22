Return-Path: <linux-kselftest+bounces-5261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4410685F0A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 06:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7593D1C2160D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73929522F;
	Thu, 22 Feb 2024 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HscJMXyD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C506D39;
	Thu, 22 Feb 2024 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578326; cv=fail; b=kaZIAEJI28Mx5KdkaqurF99Okf6EinKGzLw1sSPCn8DZdl9zJ3YtPieNqJ8LBF0ykoQEGzWEgtTb6bZd8eM0PGMi6rofYJN20YxeAObICZNmgMGzwnYqJWlOMqIqp9N6KR33P12DV0g3/sJ8IqHlSvShZIgaAWFqBzfP4QdaFJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578326; c=relaxed/simple;
	bh=IoPGGQh9Rz8gUvCICEqjjA+c04zxVA8YItC20r7/z/A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h4QX9qkGo5ZE499hrFQgfnQxQZBFFOg5VXDNrPDqAGpmBxGeOLl9kwdMgCXIcZoqo7JW8gRRPpmzGqAcP2uPSUVPK/cFVYYFUykutDPg1ExcS6Li0cWxUf4i8hMEF2hmJER+DOY2V6Sdia2zcBhGNklOZ2FVeqJ0L04g6BdU6/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HscJMXyD; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708578322; x=1740114322;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IoPGGQh9Rz8gUvCICEqjjA+c04zxVA8YItC20r7/z/A=;
  b=HscJMXyDVS5ITyXc7/kv+i2YWXr73C6g0mJSW7eZaFxJk+l9GhiruH6R
   iT4S362fmehuNn/xOngwQfnmI/eSZdRRAN7d0ZWdv2EfiDfyGDOVjh/LK
   woxJOn9oKmGtj9AkrJJnbYTdwOcyYv17u+vGBu9Wh13QfwLLRX1hna0ER
   4zfRYa/CGOx9faVE8KSoM5072qjVTY188sgAhzrTxP45ZxoKDvDUvvD34
   jP06UZVyFECLhY6JQlZk7HJLjSF4GV1QZ13EowiZZoplLMWEheq1N9mQO
   5EA8HGBZG9/5n6lI5aIGnCyY5Fh4St42p8LOjQkYTPExkhNjv8lZPBhL2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2654367"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2654367"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 21:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5267840"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 21:05:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 21:05:20 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 21:05:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 21:05:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGjSmQQUL42bXBXp8BMl9gt9Nvft3FuJT31OeQHZ03m9CioB7UTuAyQEAmXgXawIQUkgvILoO2ccJ5ukvuceOt/t1W+XlaF+iIZQRWUWreDzy8WfJWVI81wx7a9dtALN3LHu4oPEoEXpBfHK6M10lBi5XDSFj6ZZMQvaIDzwUM0ZMJM/bUdoveARpm4eA4mhhjIVGQBKZxREJ9thjQsWHze/Qte6AKdbst3gVE5OdJRbWhz4/rOKKQCMlhtV9STkvYFMnGDUUy1ZQKKK7weq8upYyuLJwL5h8Ujh29FTUjv0quZhlR+ko9vY75Qkbvplq106fDSb7fXCDW6Vh4vaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHlRqdQiTqR7F+XR75aLasfpkBCll2WsfLbHVB9jqxg=;
 b=etsoeQmwFkv6VXwGP57eFQCICv0+Iktw2bdbPT3Wto/q5UTImA0g+W1nRm0ocEGUnradLBhWk/LA8a5yb02+e4wSxPn2Nj+o/BIPJVfvKmcIIZzElA9zFh1r3u9RCUo/wPZptDvsRKDOQR4qwhjBPKYgpAbiQOkDhzEMxL0N1S4B7Kq3Ic2/jS0bOyPsfovTBnisz0zpwrxEETraz9NMaxmFIXb2jL/YEBsY8Oss7uhJKKQvVE/zk/vCwH10RUo+DKmky7ykWLUmJR4xAN4kaI/STeTuAnqfY3gwyOhGv6ynFE7V1gzKqco8Nm43gIFis1OBYlUUtFh/iCRwf6/uDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BN9PR11MB5419.namprd11.prod.outlook.com (2603:10b6:408:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 05:05:18 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 05:05:18 +0000
Date: Wed, 21 Feb 2024 23:05:05 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: David Gow <davidgow@google.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan
	<skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Rae Moar
	<rmoar@google.com>, Matthew Auld <matthew.auld@intel.com>, "Arunpravin Paneer
 Selvam" <arunpravin.paneerselvam@amd.com>, Christian =?utf-8?B?S8O2bmln?=
	<christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, "Willem de
 Bruijn" <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri
	<cassio.neri@gmail.com>, Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>, Brendan Higgins
	<brendan.higgins@linux.dev>, Daniel Latypov <dlatypov@google.com>, "Stephen
 Boyd" <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, Maxime Ripard
	<mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, <linux-rtc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
	<linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 8/9] drm/xe/tests: Fix printf format specifiers in
 xe_migrate test
Message-ID: <anz6qjyb2oqkz6wdy4ehnlpoujy4rz2itohpglgfqzadtonxtj@ljakgnqmfxxh>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-9-davidgow@google.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-9-davidgow@google.com>
X-ClientProxiedBy: BYAPR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::21) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|BN9PR11MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: fab4a941-b3ab-473e-537c-08dc3363dd04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYFf0ApW0adRAZcscDVNyhHYLR/ziquy/CTtTJ8Q6GvRbI197nwWqa2EZLg+nKkcxS1yhPvgARDT478O6qy5IZIHKPA4grZURUPV/AGwqUh2QUJLPHeMnW0H8bf2nF3HvXpJJ25I1Kl0SLHl2AxtMwvbyP6rt95xn75TsDC6aai0tfWUdIwpl038Jnw6CMBjtrEt1JGbK1kiJOl077g/sOrqIYaod9qiRcROMDfllytr4FvJ1mwPka1QlhyrZkpA7ZFXYQ2uaLidy1BvwgfJL4LO8lt/Mejg7mY8crQy7CCfsxUqNuiU7PyqGeFfQA6Se+epYTc1sKLnrqSuHpLbyx3E5vTbRAr6bePJKV7+y4v5pwi8Xh8j1DtCvBa9bLCiRcs5L7vH5Eb/EC3zMB7g2StTzKCn+0rLi70oS5V+WUqkXDPVsfBY5eUZbIb0uy92v2aQkqPIhfWGLXoqBAbJkvyZJDYht4U570OQ/oeOjO2nJcIk3+nh0148jXtTFmCXgNKYWo134H7CY0flXPNCyAzbP7ST15VIMnXKfphshjQ6mBRNBISVqNwzP10XqFzwQkS005cRkoRthR4B3F+SOcab+9xNrRF2NZ7pT7gOVS/Mom23I4eKTF3GjR0VC/uR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SfbAQ0gMQxEEfDI9iZ+EAxYYWX/0NDm27nDBi9yi4lPaY9JbKi5LFlWPOKQA?=
 =?us-ascii?Q?UBcRI4n04FJJlG6qm4uYm4pxi5cKc1RDDbgSELNpmhsKrJ3SCTRmZj/nleGf?=
 =?us-ascii?Q?EZr8Yc4E1svg3x8eyB2saI6Y6IIL4shhBMRYly3zGNpS1Gar+n2d4D3XBgeg?=
 =?us-ascii?Q?SvD7mQq6RligappaPpuFruW2ooPDZ9vf6VcDB6xvOlUyi/1Q7klKU5Z7I0uo?=
 =?us-ascii?Q?FcYXB2DGAi9GZyPxe0khUR/JJX43MoiHJoy31dnGtEXy+uKIGWynuozlLvBo?=
 =?us-ascii?Q?qL8Mw/QrSUq8DT7VczQluCUu1qnfP9lYOrOpyQP8PjgX2avZrLTRjWmZf+tZ?=
 =?us-ascii?Q?koUANh/Z2RW/YV4Z4skwtIY06YmD5ZxDidNKcBHFrHlYr4Hjoyi2RDax6sZo?=
 =?us-ascii?Q?DFr+Zkhpq0LckVMQ/gtMM4kh53C62Mq5xy1Yu8cu9WPGuCujUOSIkC3/oNsK?=
 =?us-ascii?Q?3DVCGuMelYdBuYHSmH6PdrXxUbf2PY9Qtht4Dwnig7ZWdCQ5HV2Zqnv7K5CN?=
 =?us-ascii?Q?lFlOvAJWm8SHP5FlNFdaFgx5LsAR2/hdI5yvvYgnVD3IH3ACNV8+GcrDzoLd?=
 =?us-ascii?Q?VzJJqA/DUipGyb36wef2+BK9nhciVgVTHYE50sLL9qRZDXRmtd1hM/ibBjUe?=
 =?us-ascii?Q?s/4/GgN+GeVT8a5zSb/QUcugO9i/J6NaXk0hRW+Xkq9uCuJY3gbX/k8++TQF?=
 =?us-ascii?Q?33yabsrplHZHEBbtFeoPSe6cCOZIWCA+ZCe1fE9KIe22PdYsbqIvgzRbT5s4?=
 =?us-ascii?Q?piuLbsrWcJdId9MaCckS4o4hv4EbQsh7DTdo/sMtSFNk5577G0rud4J8ugzZ?=
 =?us-ascii?Q?rWUTJcw7jBa/GNx0Tjm8pwnDhGqPzF4OBAwMKdAu1TgtqHUW6jVxDNn79wGl?=
 =?us-ascii?Q?jAOukAzOh0RQCopBlievon7iJf6gXKNzgSX5ITljV1U2wQZ6A91tLLGsb7hL?=
 =?us-ascii?Q?FtzMh0spAE1EawguD8s7eyZmaYrCPWN3M5l/019qRzpKAiLlDrHcjIa3lgWo?=
 =?us-ascii?Q?yGN5uTMKW+wCrgi8hLIVNq240oSX2tUc+IFlV0K7NH2gCCrvNsOPspGWOWgk?=
 =?us-ascii?Q?VogF57olEeXSfj+95zF9tRVZzrRMeYHPxGSu5aUcdqm8rsMj4mH6dvGX5sDH?=
 =?us-ascii?Q?BfqHAfH3RmtxT/1Tcm2XSKJU5KTj/D/Y2QKE8ft3FbxY6w4a5hfGcUEifpNd?=
 =?us-ascii?Q?d43ZfliwqepXFAYWiNsbQSuouAuIXy7e6WD3HcnSDfzpCTdI30Qa90qkFlyz?=
 =?us-ascii?Q?cq/mtbNNzFzflCjZ+tcH48CAYVHAe1XFjz6TvuWl9DImjc4FDmzxxdvITC9G?=
 =?us-ascii?Q?I+/CqVq6zOxfaQYCrvn5dJ0JG7f+CUFWXsqCtZJOMD22CjX4XTrfoEY0alJr?=
 =?us-ascii?Q?HajnPwpj36uSAFZxd8RmzdsFJJm7h83RwdQXH8YlOx6hYPeM9IrECUQydjjj?=
 =?us-ascii?Q?JRIYiGMgWCDeV8UrTHs5TQ/cTpEYPHP6KiMKy34roTOSV4ow43tRrdq9DRC8?=
 =?us-ascii?Q?HbA/xqmEiX6LaNOsz17USkhxHESGy2D4Jbd0ojdD8ybXNZEvHA5cra8Vq3C7?=
 =?us-ascii?Q?Dx0vD/+dV8UFq3Fh8b6VeewAhzOpXgpupV3gJdnvTk8YNpmdGNSFdmuQnihy?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fab4a941-b3ab-473e-537c-08dc3363dd04
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 05:05:18.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C12XjWMX5obVKQmI6T3a62ZR2WWHq0x5T39fYc0e2lRUCigEunA1C6uYcRwqDSmprnyixFBvIF3/8Dh+Zn+J6Pc62FCCkx6oZXCRevyhMCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5419
X-OriginatorOrg: intel.com

On Wed, Feb 21, 2024 at 05:27:21PM +0800, David Gow wrote:
>KUNIT_FAIL() is used to fail the xe_migrate test when an error occurs.
>However, there's a mismatch in the format specifier: '%li' is used to
>log 'err', which is an 'int'.
>
>Use '%i' instead of '%li', and for the case where we're printing an
>error pointer, just use '%pe', instead of extracting the error code
>manually with PTR_ERR(). (This also results in a nicer output when the
>error code is known.)
>
>Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
>Signed-off-by: David Gow <davidgow@google.com>


Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

this has a potential to cause conflicts with upcoming work, so I think
it's better to apply this through drm-xe-next. Let me know if you agree.

thanks
Lucas De Marchi

>---
> drivers/gpu/drm/xe/tests/xe_migrate.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
>index a6523df0f1d3..c347e2c29f81 100644
>--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
>+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
>@@ -114,21 +114,21 @@ static void test_copy(struct xe_migrate *m, struct xe_bo *bo,
> 						   region |
> 						   XE_BO_NEEDS_CPU_ACCESS);
> 	if (IS_ERR(remote)) {
>-		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %li\n",
>-			   str, PTR_ERR(remote));
>+		KUNIT_FAIL(test, "Failed to allocate remote bo for %s: %pe\n",
>+			   str, remote);
> 		return;
> 	}
>
> 	err = xe_bo_validate(remote, NULL, false);
> 	if (err) {
>-		KUNIT_FAIL(test, "Failed to validate system bo for %s: %li\n",
>+		KUNIT_FAIL(test, "Failed to validate system bo for %s: %i\n",
> 			   str, err);
> 		goto out_unlock;
> 	}
>
> 	err = xe_bo_vmap(remote);
> 	if (err) {
>-		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %li\n",
>+		KUNIT_FAIL(test, "Failed to vmap system bo for %s: %i\n",
> 			   str, err);
> 		goto out_unlock;
> 	}
>-- 
>2.44.0.rc0.258.g7320e95886-goog
>

