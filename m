Return-Path: <linux-kselftest+bounces-6294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D587A3E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 09:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42B9283032
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 08:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C717588;
	Wed, 13 Mar 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZeVVmO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10404171C1;
	Wed, 13 Mar 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317319; cv=fail; b=WauE8NtLv/KZIjI/uXdBq9tCiUcrf7HcavcpQAnX/OPYCP9AEBzvABtmYtPEt6HJyEfwh8EPQdQBoLCW5/SSTAR+J4NIgAOdlYnH02NSS2GMLuFMNUDYFnmrgh7kk6lwjab+4br418GAWMGG+uvySyu0v6M9sjAw5PDJQ6bAkqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317319; c=relaxed/simple;
	bh=WYkq5rYGTQQqOlGLk8NEvjwOBawDqtP8Wjw+xFt+P9U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LC9K2x261/i1TM0W6raCuW4/Wjw7bKNBKOnxWa37ZG8i/H9dC6kHy83+LgHhuvJiO//imSvflJBa563m3kiRLs6Q2BPlPYWasREMbY9rWTbuBcUm3+FG0HP1HDofMrfk/7DvgSuaYtajDHIlmcGLN6GZ/Lj5TEs5Phz5iq7a+nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZeVVmO9; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710317317; x=1741853317;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WYkq5rYGTQQqOlGLk8NEvjwOBawDqtP8Wjw+xFt+P9U=;
  b=YZeVVmO9Y7R8LnHwb6Leh4Jx6fwhdWd4a0CPHNgC8YyAbqTiNbh1uaVG
   qkTJYzdFtSujuUjwOmFs7iJL4YShJuA9VFX1gOsmVEOoYi6x75I8Gmlmb
   1OveFCAEhrLUHzuABEg+5w9An8jl7Zj33CY7hgAIBkpoRADJ44vJvP/tu
   x9ixRwZ05TVeWLNTwtnQWVZzJqxAmG+db1MLrHjFqhVHnGO7ELq4ZRRzM
   QQ09/5oY+hLbhnFDcEEw4NgMz0pOjzy8oglDBnyTJVRpIquYScda52rNv
   r91wzEnjzuzrkKOmGvNCpVNLf4Iku4+4REZlGSQauczaBg/evotBzZJKA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8876571"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8876571"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 01:08:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="49272882"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 01:08:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 01:08:34 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 01:08:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 01:08:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 01:08:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7qnnch5peQRYHYanWptJyWTSzdcNXpjJ19rWQZYy6PENuKPpm79T0v6l2Nwetj78cmb0vj5fhniZNTDTMFG5VIuYmaWeLLTeQ9j1lOSIQlRn9f5LiQzY+Rii4sqpB+O+LUDyn1oRkL3M28YHZxsad1wc6oe8snAFOawd6iyNt+Tc1ZSXFlM8PjbrUDYE31vMr/UmBP74KYOGnPP7jqvFmEXH4j5cmCX5AEisLJ409m0vXcr1ou5yU2EZ8pNPX/PiXNB3Jc/p+E8spyPI/7HcKhGx7vc2dlMuwggrcSMfDRGIk2Z68nFTjVZmBXf/bAw0AdMgZgAN0j5f+SbIiHauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+KJnGFdzJo07m6w3oXaqNld81/ddD5u767YzMjo9GI=;
 b=MqBqJ9pLH5Rq7DOmIHOGEnnxsaqeScAauzkw21BXropL37ksegKO/a7PkVDJoBwYFnCxb+D6j2NN36rswJNiHqNxyiSD0UjT/38nCUmnoPRWeg12UK7w9N65v8AXowHOYRq5efgsaZOMTlK+G/mbmafO9MCwLd3LCLjH+k2uVEURVoNREAec/HfZkwwtaNv07cU5Yb9mAmMpCtijLK/h31XT3aS36N8qrsZNx5cOEKqVgg8m6uD1wQi6TfM0s5HjFnkQz3/daPyioTCZvDg10NWpE3WOtQznMz2kWKFCAErUJfRBsqS6oS1cz5P+WKSche1g9nADeRKn2WQmStyjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 08:08:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b1f5:9d1f:f510:d54c%3]) with mapi id 15.20.7386.015; Wed, 13 Mar 2024
 08:08:22 +0000
Message-ID: <749b23c7-ab0e-42b4-9992-e1867fc7d4d7@intel.com>
Date: Wed, 13 Mar 2024 16:11:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] iommu: Introduce a replace API for device pasid
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-2-yi.l.liu@intel.com>
 <20240115171950.GL734935@nvidia.com>
 <c831bf5e-f623-402d-9347-8718987d1610@intel.com>
 <BN9PR11MB52766161477C2540969C83568C242@BN9PR11MB5276.namprd11.prod.outlook.com>
 <585423de-9173-4c97-b596-71e1564d8b4e@intel.com>
 <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <87a2be0d-6a24-4ca8-be30-35287072dda4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdc7f66-1536-42db-d0a9-08dc4334c000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWi7ZyLEw49vhjKFQGualGccOZ4zvhO+Ooc7MoZOX0IoPtOmgWgbF8nTlxli4MiJ8bx21e1mgCbf1TJpPl4oUhX7lfx2tzy7qPtgrbDizjN0sitfFlNL3ei/OotQK+n8U5jMM/QlhDHnMwiaHJRKqDlmLfNoCaqCS0JeS4IVb2VwZt+cRdGjIRWCmPxGvpN15xFLADi0lR7KoH9HgceQY0dtXilHtKEGWufrMw/idu+ATx+V61LWxuwclJvXPyJv9jsvlUdOsqpYBSE7PMGn54ThMpfaXaWiH2lhxrs8QNTfNSKZuA/8QkV42cu6KzUU/1/TFlGpsakVqtlUjT90kFYE5CUpCT6VeHQ32ajUmyVAhw2knc9t05iRUdisAtS+gbZvVQ9dRzcdZq5pptw05IYXtJ9XIkTveqzKW67FROU0vLWN/GyJevGvqCwd7S+vykZsw5v1P51eWq9XYE3p8IpNyYimhYIw8ZohMXV381PpNnGc9jZwdZTEX1QJJ1gTHVjggj8OEFQCQpD5uJz0f0Y+MMhevkER5j4YxqqFkFP5zuuMSBFaO5QSvNATTtyKv3UUiGlNsQSP48f4NLqfWK6Nvoq6gL053kYP5Mx2xWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjhTT2xYc3lIVjQxTUFvZUlhUFhpaDBRTGc5cmhNWlRCendWeE55anpYVGVr?=
 =?utf-8?B?eXN5Q2JLbHBZbXRNK3hjL05PTTYrTWJlOTIxeTNIYTdON2lwUmx0SE56NEFm?=
 =?utf-8?B?QkFoUnZ3aWlFM0oxdi9DN1hqL2wyK21WV2JueHhQRS9nYUJZTU9ScU10Zmtx?=
 =?utf-8?B?czBJUkxVYmYvQVBnTEdjSFk1ai9OM1JHQ3lJU2pGTlU0dmZTeHB3eEJaT2FZ?=
 =?utf-8?B?UEhMdFd3QzFPOXk4MzRZR2FqeiszaDhkNUxFQ3grUGdYUTQ1WkN5MzkrM3lM?=
 =?utf-8?B?cFRRTTM0T3owZlFka0lkLzZXaXNEVlpma2xhdGNYbW9hejA3UFJyVlltZERt?=
 =?utf-8?B?WHNvbnlQd2tyYnQxclNxRzJqZHI1VU9mOEpDZDJPWmRzNE1rMUgyREZlR0tr?=
 =?utf-8?B?aExMK1MvemZNc0tBNk9BQkFmbEg3ME1tVDVwaldyMUpJT3lub0JoSFVYeXEr?=
 =?utf-8?B?Y21Xc0hTYUJPY0JpZTZuVnJHZ2xlZVEyS1NxMElKK1BoUjRnMjJLcXhXQjd5?=
 =?utf-8?B?MmpJSHp3SzNJTWVlcmcrcWJ5djEwenVmRzZnNUZSOWJyRDFpdGJ6cXJzMDd5?=
 =?utf-8?B?YVAyeHNWREtXc0diRkozcEFGaDhlbGtDWUsyaHBoTzJ3VDUweXIyMkZwNlNY?=
 =?utf-8?B?TUo0STY3Mzg3WHRDZkdVVCtlWHRCL3JLcU5ETmlEdTlYRTNhd0RtU2oycWZy?=
 =?utf-8?B?L28zTUFHUGlkN2NudmtVWE5qalEvSWNNSFNWZnJtR2RrTTZ5UUdVZjBTV2pP?=
 =?utf-8?B?cjlMQVRjd1BneGlBQXFaWFVid3hob0w4Z2JkbjF1cHdyN21wNllNRGZMREdE?=
 =?utf-8?B?eW4wMERxMFV5cXFJMHdrNTkyUGhDNmV5ZlkxK2U0WEZkVWdCbTNVemt6aTFD?=
 =?utf-8?B?RlZnUGowN0doWmFiTTZYcmdabTdDd1VqTFpxK0NxTkRkdDV6Ymx2WWRXSS94?=
 =?utf-8?B?NTFBRjFzM0t1YWpyMDNkVUw2Tnk4TGhmekpXempvRzlWanlLSHV5M2pweDVK?=
 =?utf-8?B?b3dqcCtENDlUS3dBK0FKaFJBZ3g2Qm9qSlJvWkJJTThZM2l4ZFZveXJiQisx?=
 =?utf-8?B?cFFFZzQ2elRUSU1IeDVKdHFLRGVOeHhpMDJMRVc5eG8rZ0s4ZkdITk5wdVZX?=
 =?utf-8?B?ekg1dXlWdTdnVHVFTWNtY01Ia2xtWk9PQzVrMW1iVElCNUk5cVh0NnlmTlFJ?=
 =?utf-8?B?ZkNsMFhnSk1lazgzbVBlR09DOFgvYTFaL3FlTFZIcFBMN1BnTi9jSEhpcUE3?=
 =?utf-8?B?ZnZjZmNIK1hpaG1WeFVMVHV2QkZwaUo2RmNJem1WWnRKaGRheVVxRUsxYXYx?=
 =?utf-8?B?STFtdFo4NVJNUjE0NTNEM2ZWUStOQjRHTjNXQ0lGQitseTVPWWVOdC9oOERP?=
 =?utf-8?B?VWt5UEk1Y0hvVjc3OUh1TFhIbVc1UE9iWkFGNWJRakdQR1RaQzh6V2RQQVdo?=
 =?utf-8?B?UUl5MTMxS2JPdDdYZHcyWHRPZTF5emovUS9pOVFKSzZVWTJreU1LT0NJSnNY?=
 =?utf-8?B?WmdTeEgyY3ZmVmtHOVRDVVFPSUE0VjE3U0hvUzQwUWZRYzNXbGNzeG1rT0lQ?=
 =?utf-8?B?Y0xnVGJxUTJ5Tld2R2kxRi9MTDgxbVRGeWdBVCtLeXIwYll5b0Z4WldOQ2NN?=
 =?utf-8?B?NUhUU2Iyc1kzdVJoTHlNc2FOeTFEV2VoVkxrS3RLb1RnZFd1dzZRbjJscnlT?=
 =?utf-8?B?YUF6MUgzUEtHUFdBVDE3a295T1k5SUdKOWRXajJZRzRTTksxakk3b3N4UW5I?=
 =?utf-8?B?Z21rUE1QMzlZUnJZVTZCVlZhempSSTNoZ1ZRSXAvYjEwKzJhUmRrRlp5TmRv?=
 =?utf-8?B?SEVFSHpPelBBYmUrRTVoUXdBb21FNncvZE51WmlDdlcvU2crRVFPcGpLQk5y?=
 =?utf-8?B?bEMydU9NTlpoZU5FUHVvaXFFbXFuMit2KzdneDVBTXlaWGRjaVhrY1hMYkFM?=
 =?utf-8?B?TGFtUmdFc3hNVkxnSlc2VzJsYUJadU1CeDZxRHJqbVR3OERCNVBjdThpdFZa?=
 =?utf-8?B?R3MzTTRQYnhibU5tV0dhRU9ZQU04Wms4U3k4WXd6RnpzQUwycTRFaGM2YThX?=
 =?utf-8?B?V1R1WHlRNHYvSFVjTWUzMzdUMTZlbFJVMzRPa3FjakdEcGk1R2hXM1ZIbm9w?=
 =?utf-8?Q?zUkj10n+9jrCGnvL2FdWQji9T?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdc7f66-1536-42db-d0a9-08dc4334c000
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 08:08:21.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mCPsh/GeM01d7uN8ZV9qkdyE7gn/AB2PGV/iHtNR+inY/KVjVu4pSOUufNWftZpBouvQXoKd4ai9LgLUV2BOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com

On 2024/3/13 11:13, Baolu Lu wrote:
> On 2024/3/12 11:07, Yi Liu wrote:
>> On 2024/3/11 17:26, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Sunday, March 10, 2024 9:06 PM
>>>>
>>>> On 2024/1/16 01:19, Jason Gunthorpe wrote:
>>>>> On Sun, Nov 26, 2023 at 10:34:21PM -0800, Yi Liu wrote:
>>>>>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>>>>>> +                   struct device *dev, ioasid_t pasid)
>>>>>> +{
>>>>>> +    struct iommu_group *group = dev->iommu_group;
>>>>>> +    struct iommu_domain *old_domain;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    if (!domain)
>>>>>> +        return -EINVAL;
>>>>>> +
>>>>>> +    if (!group)
>>>>>> +        return -ENODEV;
>>>>>> +
>>>>>> +    mutex_lock(&group->mutex);
>>>>>> +    __iommu_remove_group_pasid(group, pasid);
>>>>>
>>>>> It is not replace if you do remove first.
>>>>>
>>>>> Replace must just call set_dev_pasid and nothing much else..
>>>>
>>>> Seems uneasy to do it so far. The VT-d driver needs to get the old domain
>>>> first in order to do replacement. However, VT-d driver does not track the
>>>> attached domains of pasids. It gets domain of a pasid
>>>> by iommu_get_domain_for_dev_pasid(). Like
>>>> intel_iommu_remove_dev_pasid)
>>>> in link [1]. While the iommu layer exchanges the domain in the
>>>> group->pasid_array before calling into VT-d driver. So when calling into
>>>> VT-d driver, the domain got by iommu_get_domain_for_dev_pasid() is
>>>> already
>>>> the new domain. To solve it, we may need to let VT-d driver have its
>>>> own tracking on the domains. How about your thoughts? @Jason, @Kevin,
>>>> @Baoplu?
>>>>
>>>> [1]
>>>> https://github.com/torvalds/linux/blob/master/drivers/iommu/intel/iommu
>>>> .c#L4621C19-L4621C20
>>>>
>>>
>>> Jason's point was that the core helper should directly call set_dev_pasid
>>> and underlying iommu driver decides whether atomic replacement
>>> can be implemented inside the callback. If you first remove in the core
>>> then one can never implement a replace semantics.
>>
>> yeah, I got Jason's point. I'm raising an open to make the set_dev_pasid
>> callback to handle domain replacement. The existing intel iommu driver
>> does not track attached domains for pasid. But it's needed to know the
>> attached domain of a pasid and find the dev_pasid under the domain, hence
>> be able to clean up the old attachment and do the new attachment. Existing
>> code cannot work as I mentioned above. The group->pasid_xarray is updated
>> before calling set_dev_pasid callback. This means the underlying iommu
>> driver cannot get the old domain in the set_dev_pasid callback by the
>> iommu_get_domain_for_dev_pasid() helper.
>>
>> As above, I'm considering the possibility to track attached domains for
>> pasid by an xarray in the struct device_domain_info. Hence, intel iommu
>> driver could store/retrieve attached domain for pasids. If it's
>> replacement, the set_dev_pasid callback could find the attached domain and
>> the dev_pasid instance in the domain. Then be able to do detach and clean
>> up the tracking structures (e.g. dev_pasid).
> 
> Maintaining the same data structure in both core and individual iommu
> drivers seems to be duplicate effort. It appears that what you want here
> is just to get the currently used domain in the set_dev_pasid path. Is
> it possible to adjust the core code so that the pasid array is updated
> after the driver's set_dev_pasid callback returns success?

yes. how about your opinion? @Jason. I noticed the set_dev_pasid callback 
and pasid_array update is under the group->lock, so update it should be
fine to adjust the order to update pasid_array after set_dev_pasid returns.

-- 
Regards,
Yi Liu

