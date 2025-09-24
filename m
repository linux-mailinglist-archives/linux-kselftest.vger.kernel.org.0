Return-Path: <linux-kselftest+bounces-42171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4685AB99110
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C362A8166
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04262D6E60;
	Wed, 24 Sep 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baZi6Ey4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829E2367AD;
	Wed, 24 Sep 2025 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705646; cv=fail; b=CeO1LR8pa9WW1VnEl25V3YqYEwvv0Q7lVn1ryubvnu3RSMfyQU+pnb9kIvqFXu3XHVcBesU6w2bGlHn6mtVtHghyx2tCCAffJq07eCQTw1+Pud1HeLZO0Ed7hPaC8y2ORn4/Z3inh+cB+yx3IpUCckh7e3UXpbJmmJYI0zG6qQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705646; c=relaxed/simple;
	bh=aiNlBz+1Pb4rqU4cad72x6lXvMoWipVLR8MhY9laCQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C0DcrKq2eIVL0vlUDIiaPqpByJFXMVitec1fppPdTpA5C9X2CdPN5eTdeq6ES0wuXxCUsVnwjsztchhzYo2KZWsgLAnQF9EVwTWoCt0xYihwMuI5W4QR6E+xjA0R1uGYsjK/PCTe8y1tGYrE/UF6AYgGzmIS/Ymjbw7xgVRw3p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baZi6Ey4; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758705641; x=1790241641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aiNlBz+1Pb4rqU4cad72x6lXvMoWipVLR8MhY9laCQ8=;
  b=baZi6Ey4mswCxEzMYWpv8cmzYXVmv/mTgKIcztsq81C66I3Fc5o7aUQA
   Si09oguuandq28RPhy5DnYvrlW4EjnyRlmXInRjZh7nF3yB/2nwaP36tQ
   8K40Ua9xKrsk5MjwcYT1me8h0w2mJPBsTFGAt2B24bnGQVr+plsscE1ML
   MN+HnlN1xHcDcEUSBUMMqkzzsKkClxi4HlEzHNywCb9RiH+GKPjBW36uY
   gIP43Ipj/oZ5hZgucc/7iglH2zHotAbFjirk8IBlGN7HtrQTfPhuvAlM0
   poFizm9LDPHYXf3Uzox2BKzegDhzjPhehCZgsFNw844g7feqE47Q7e99W
   A==;
X-CSE-ConnectionGUID: cj8hgEdDTDib4xJK09Txag==
X-CSE-MsgGUID: vBeElND2QsKRAQ532/GzLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60912348"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60912348"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:20:40 -0700
X-CSE-ConnectionGUID: PqWBsYXrTE+tBRbJPhc7QA==
X-CSE-MsgGUID: +RIm7nj7QC2XgssdSvByrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176113226"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 02:20:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 24 Sep 2025 02:20:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 24 Sep 2025 02:20:39 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 02:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZuZ8h+eYpdZhejY72VuvudUE4xbA69SENEudXBfIbzMwKik6oaHJzbctkssjrBNQzfd1XZoIErsMjq/ND8+YO0LZ4OWOlr1FTWlqKIgDm30hQQJWmQ01I5QZZM/pXEYXqR1hHMFMwKt+DLtPxT7KerPxFP3PHv9RjuS2DS0swEYNNJTt91zXXcbG9VhO4Z1WQO0bUDwHzF2X9o1zACPg+YTxvmyuU5c0kLXtlM/iB9zL+NYb7JhTt5I9MNhClKOyLC0pf5qi1NTCJwZzKy5rhIveh7lIpQbrbPcjLxHk/sCrZpOKpooPbj7qsSMqnHdD5eqcP7c8QTZ4WkdX/+bKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sb/Zz3JfmDtffjSBy29zjnYHmPpVLmhZQjd8p6yA++8=;
 b=QusWuLgQs1fcQof26fB4tMOYq9o40k8MsDnXEfWJQ7sEhmvNDyAE6VrEHtrR/TrvuXxpMCPGQlZagn8DXb92QB5vHxCh6ARLl5Fj+PujMeoyW8mARQgNrRO8W//QJ5ZltY/SxKfIVCnCBdYquf/ExsLurXJHB1V1ZBczVYdtYuKEjSWFmK1trubHotJwUl131cy2LJDUIX+bNGd4oPT8Jk4rqtwlPxOqwICWIhsBROOqKklyII+MUBaF5qi2EnGyFYoZtyUFaSKmf52xcCVc1KY54IHVQ4/YOIRMJUbS8DvfK+2TVY0JAK6Z8cPDiEJMmq0l/ukNU8wE62nFVb1k2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7899.namprd11.prod.outlook.com (2603:10b6:930:7e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 09:20:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 09:20:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Justin Stitt
	<justinstitt@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 01/15] genpt: Generic Page Table base API
Thread-Topic: [PATCH v5 01/15] genpt: Generic Page Table base API
Thread-Index: AQHcHPrLfNePWPa2q0qW7OShpmqDlbSXCZ4ggAJKd4CAAOIbQIAAc+WAgAeCtSA=
Date: Wed, 24 Sep 2025 09:20:31 +0000
Message-ID: <BN9PR11MB527626C5F81280FABAD2BAD38C1CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <1-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <BN9PR11MB527669A84AD24A550FDDD85A8C16A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250918180657.GA2132010@nvidia.com>
 <BN9PR11MB5276A9B144DE3CE042A448D48C11A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250919143101.GB2132010@nvidia.com>
In-Reply-To: <20250919143101.GB2132010@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7899:EE_
x-ms-office365-filtering-correlation-id: df709322-cea0-4f0a-6592-08ddfb4b9c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?65Qke8nMEE1KEGcOkc1saOBsiB3LmDzp/5lmqssBptZbZlzB45c2TtnSDgA4?=
 =?us-ascii?Q?Tl/1O0F/7WD/FVVR7JqKCn0bkea13N7vqhmOeibx5sml+/hzJuGMTIekEj3V?=
 =?us-ascii?Q?xp8xF5hLzgYhmT/p1guD563YV4kDT70adpc9mmoxhN/dMYRtt4lRql3Lrvlz?=
 =?us-ascii?Q?bX7wWycJ+g8uGNgo/sdiw6wruR5g6jq9XLb82PCenzXtpbcKmR/g2iSWkvYN?=
 =?us-ascii?Q?DF71BvM6itvG7WBDQUDuAc8vj86LM+4t2rLef7KfbVMrK7LIQvWwv4BBO96M?=
 =?us-ascii?Q?RgP1TqlbJ5E0bmHuzMWs+FkfGGyQiaGfGmN0p4s94xCVGvk92fFoiTwhxtdR?=
 =?us-ascii?Q?oQjlSCQ1Tc+K2GDzsxjTbon3nqzOkOqlsRzFRwMYgzTU9zelg+uRkbUgm5hY?=
 =?us-ascii?Q?V4giE//ir5Qcsfe5oNVySxGiR7dOByWTdoSj1Z/NVMp2YJhPP76GqtutQklc?=
 =?us-ascii?Q?UVX3WVn5+DJwnvNkK9JbwTPT88WjoY4UxgJ+DrLhty3l+2JzBU31KaVBgczx?=
 =?us-ascii?Q?IIQTA0s4b/cvVCJYeC1kvGbklL7NPLIvHJNuzjA9/H4kHjSwinJg+cZmCXIs?=
 =?us-ascii?Q?UbBVwcCPqyrWR7g3SVcMaQmZkzWLlCqmdATLZXjk0Zug8L4F1hZL/+jnM72t?=
 =?us-ascii?Q?tAV+JxDcns1XzZX7UeLBOTgX7L5kg30Qjfed6HgXPuIhMNser5zSJukqq1NG?=
 =?us-ascii?Q?nQbVrWq1qzprt6pLmrXEx4r5bA12K6CJHTHX9Zr3OahhKrGSwKngTYppBNFN?=
 =?us-ascii?Q?QcKiPLMduo037T/ZjnN8DFKfCFrLTZjGEHO4XBKAVEjahpDeEoL7LKWUcMdY?=
 =?us-ascii?Q?16yN79rdqH71WNkrT2f3UOwsw3tdYq52zy5js4yZTDtkzJxxyJPtY8/PVGOr?=
 =?us-ascii?Q?aVrz/IhTOmp1HR1y3qtytwypKSt8PGW2Il4w+WPbb4Zc+vg+mK/cvJLWlHbt?=
 =?us-ascii?Q?6ZUqkOhWOl7Er0ZIABsoXpvVIky7ElXl7wQFi5kEeD9KYgPC7k0jnILcZbcE?=
 =?us-ascii?Q?7ANBPsros7V+xJIPdPE5729OK6OyAJwJ00mlHequxQC7RqyY7j6iBPHB06K6?=
 =?us-ascii?Q?r5sUslbCNDa1WZUhkWtGzaOOBLK1aNSV6IYlacLGSpb1NPTblgoubU9EoFx2?=
 =?us-ascii?Q?ysVZhF8ZrE9nC3oWXtn5yRMjNBfEWR4/B2GnXgJ4beaFBCGYYwoz12bkrMyU?=
 =?us-ascii?Q?Yjhcr98KzG+89XZzlN5oTviCgiMXU7kEZLG3FWr7G313Xov3SOescigIizNl?=
 =?us-ascii?Q?+5n1Q3kRGBPioTrg5fSEVXDSG2ozX+BtlcUZ11LKUOv8ccmKwizi6HNlC379?=
 =?us-ascii?Q?rL/4zKSuOXvYEa5sG+NETyP7cakl3BqU81VcjWfm9oELk2Xbm5Br1Yp4UOHb?=
 =?us-ascii?Q?Sc4i5ZVncmmYEZ46KlNdg1hTXwtgUfgKC8qyBDHYIANbHDJ4FogA6A03ad3Z?=
 =?us-ascii?Q?roC06CYr9hIT28vmggzyY16/cGS9a1asTa3a5Vgxs1Di8qnbmIeikQdLT433?=
 =?us-ascii?Q?h7ZPJu8XPu/3bYU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sOgvRdUYyPxKMztzKh9XWcgzxjmFa4gUs1vS/lce9UudZOPg6FRWukfjf6OG?=
 =?us-ascii?Q?7GLAmdMz09BnmL/MUMh2zdXeifNJcF5gx6sWuU0Bm/tUJBBHSJIe2EpuCnd2?=
 =?us-ascii?Q?srEajGtEzj6nEHWkyE8YA2pnG6HA48Sw+s4mFIqzpY9MILxG7Z+GXQHEjUBj?=
 =?us-ascii?Q?AbHdczHR8NaLBpnHRhKXCKFgqNXdNUl7BcUzUDgAYfsgkPZseCfxrZ3G7gxg?=
 =?us-ascii?Q?LGmo9uoN4ZEsOh+7HdzuWGWSxQu3axyxiRTicvCAo9MrnuwywxW1iQFiW/u8?=
 =?us-ascii?Q?eq6bEhNyHzv4AJVl294TBoa4NJh+pWEHD6a6zfO0qXuioF0NGH0lnsUySgTq?=
 =?us-ascii?Q?jKxaxoK/tcbnSZ3n8W+3dqBBKd4DP1MHm1KuHrNsRnYNwlkyE4bliKRoHBfq?=
 =?us-ascii?Q?XT7A5R9fV/vH5QO25n22snaagP1jnoIJPtPiy4uvgz90x7Rwg8oTLHA5Gc2j?=
 =?us-ascii?Q?JSUGzS3kpq+lRkiB8HQMu+kJ7c46JLwwdCQy6t2PKg7sPv/HgDTirxLJ1VA+?=
 =?us-ascii?Q?P1LFQYrLRzAVCANYk6hNStlKHtonDVDyvwXfrKhVwgbbhECa53YEUAyrBhPP?=
 =?us-ascii?Q?q2Uq3NTJouxVo2F8PZJn0m6x5+1DYiGshEiCOZze56ffgd154Dyxi8Glde3+?=
 =?us-ascii?Q?OMnj0AkyfeUhY8YYsR081+C0SqaOYZ37gQR0ddwGBCXxsh0NCO3baG5qtwLe?=
 =?us-ascii?Q?R76EceyG0EG3H4JFt+J1cFHtzGrWy5kxuRO/6Aje7xwuJyEr01S6myfQgClg?=
 =?us-ascii?Q?bDyagAkJBUdLo3zC8r1T6SNEl8JzqtVCkVudSp1FRLvOD9QyjeO2poyeYgxq?=
 =?us-ascii?Q?s1+MU2Hr4MRduGCJPhxiTriBocGYVPwbGNFqXGsCEe6siTkvR8Yjpdkl9Cmy?=
 =?us-ascii?Q?9Exw2/LvC5muRwnzboRe+qg6CNcRYFqS749mLBZi5UOJkupcJtsjPe4KGP5v?=
 =?us-ascii?Q?5vipjzCGGxaVdl7gecaGjpZPB97nuqq1umItMjQhdw2UMihBCkt1cpQ1Mxux?=
 =?us-ascii?Q?GO8eFHqXwNLDsCLKPBKS2dCzhwxypiYMY5pkAUFWLSa66y08d2RsRUaf/uB9?=
 =?us-ascii?Q?q7k9f1gXDmnlNTtUwrh/mrHpMi4gn/z88c876HGb1WtmEmLvhHdFc12PoHLs?=
 =?us-ascii?Q?U3QC+hQORF7S9afOE5KZ3Zs2mHsbxdFfeDiXQadDhmGfVSex4X3rApJDCBQD?=
 =?us-ascii?Q?AH1kuMgfaZvI4IfHjl66ipv0HBjuF2Bs0YqgQoVyu9PxvWFdzJHTh4U4Vmzo?=
 =?us-ascii?Q?5qndl2UR/itvPbubtDTvAwT2A3ks2SaAGXBS52dJPuHu9/RzO6Xu03NowSIN?=
 =?us-ascii?Q?FYQaEQ0PEYqhypTwl5JNamadju452W972X5MJEOit2thFjvZUDkMK6QPWXaC?=
 =?us-ascii?Q?lmZyyqd2BXVEh1g7B5tJCYUOyYY/Eyt0IPA/CqPb99royv/BirpG0/w8crs4?=
 =?us-ascii?Q?UlX0t8sqrMXTEhD5aKgoQMcG4H0lYDhFxhSeBvpa0byZoRMPE0a4JmyPMJkf?=
 =?us-ascii?Q?WPKyOEVso7E3A/Ze3+xjXyt288YE+e6JRy3r+C/4I/i54kKgQ3QvRWQaVkwO?=
 =?us-ascii?Q?ACWHbliqi5z5DHkIGXqe6Rd147RylkGhCIkxBGtV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df709322-cea0-4f0a-6592-08ddfb4b9c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 09:20:31.7770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQGAXeR+SGiAKEF3nXiGU+KKJ5ko6c+sLZhtx1px0xBxarcliWZtrwcHgOLdUvga7VMbvxjl4PFOdp38WiBF3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7899
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, September 19, 2025 10:31 PM
>=20
> On Fri, Sep 19, 2025 at 08:11:11AM +0000, Tian, Kevin wrote:
> > > Oh, pt_contig_count_lg2 didn't get kdocs because they are internal
> > > helpers to build other functions..
> > >
> > > Like this:
> > >
> > > /*
> > >  * If not supplied by the format then contiguous pages are not suppor=
ted.
> > >  *
> > >  * If contiguous pages are supported then the format must also provid=
e
> > >  * pt_contig_count_lg2() if it supports a single contiguous size per =
level,
> > >  * or pt_possible_sizes() if it supports multiple sizes per level.
> >
> > could be simplified to require the format to always support
> pt_possible_sizes()
> > if contiguous sizes are supported, no matter being a single size or mul=
tiple.
>=20
> I had that once, but it is a little more boiler plate/complex for the
> formats to write.
>=20
> > hmm I didn't find ARM/RISCV defining pt_contig_count_lg2().
>=20
> static inline unsigned short
> armv7s_pt_contig_count_lg2(const struct pt_state *pts)
> {
> 	return ilog2(16);
> }
> #define pt_contig_count_lg2 armv7s_pt_contig_count_lg2
>=20
> /* Number contigous entries that ARMV8PT_FMT_CONTIG will join at this
> level */
> static inline unsigned short
> armv8pt_contig_count_lg2(const struct pt_state *pts)
> {
> 	if (PT_GRANULE_SIZE =3D=3D SZ_4K)
> 		return ilog2(16); /* 64KB, 32MB */
> 	else if (PT_GRANULE_SIZE =3D=3D SZ_16K && pts->level =3D=3D 1)
> 		return ilog2(32); /* 1GB */
> 	else if (PT_GRANULE_SIZE =3D=3D SZ_16K && pts->level =3D=3D 0)
> 		return ilog2(128); /* 2M */
> 	else if (PT_GRANULE_SIZE =3D=3D SZ_64K)
> 		return ilog2(32); /* 2M, 16G */
> 	return ilog2(1);
> }
> #define pt_contig_count_lg2 armv8pt_contig_count_lg2
>=20
> And I missed switching riscv, fixed it into:
>=20
> static inline unsigned short
> riscvpt_contig_count_lg2(const struct pt_state *pts)
> {
> 	if (pts->level =3D=3D 0 && pts_feature(pts,
> PT_FEAT_RSICV_SVNAPOT_64K))
> 		return ilog2(16);
> 	return ilog2(1);
> }
> #define pt_contig_count_lg2 riscvpt_contig_count_lg2
>=20

oh, yes. I looked at the iommu_pt_vtd branch which doesn't
include all the bits.

