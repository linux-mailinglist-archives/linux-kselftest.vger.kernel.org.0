Return-Path: <linux-kselftest+bounces-20906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0AF9B4421
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE94E1C2182E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14176202F85;
	Tue, 29 Oct 2024 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMouG/XE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183961DFD96;
	Tue, 29 Oct 2024 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190333; cv=fail; b=Ph1PpbsgqeNcsCoqBEH7OmxEnp0DvSd0eIhTniZOqyzp8pZRxdhuA9xDwwqXYHiN7TmJmBPdFa6DitQktsyjG8QCgVh22Dtxz8iTdJE6DgMmwrSU7MbINOjGmcP6iy+7Lgfe38ttEl5qVAue59G86b3skeCmo7V7NtKR0E9wWLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190333; c=relaxed/simple;
	bh=lOIie6K2OGpFlwO6rJkKaI1/RknZTABcRsHHyOVXoDo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTXMe2Ahoy/2A6z2L/KZdwmE3YTr2QEfNvhYKBRnXBcA+MqIBRxZa4UlnSNSiUBI4SL9qqUaPtsNv2onFPeYSSwtEJc/Usp40HGe/47KB/NiddyYVKsols6xxh/Asix/AT9RGhCF79BY9y38DpldJUbfjTuQj8k3P0m6UuuTlz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMouG/XE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730190331; x=1761726331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lOIie6K2OGpFlwO6rJkKaI1/RknZTABcRsHHyOVXoDo=;
  b=cMouG/XE/myzBwbFmlpek8XJzBKxGVtTbu1SqQMmawqpI01RA6F36Ota
   M8zslIfD+8YB+hfPGzUVPpioIPYD6u8VBv9cVvaYw3VtHmHQCqYSdHR0E
   G/wsKMsvBWCwD1QTSx0zRwpLcz+/166exEsJaa2xZHwqswim1jN+qaB3q
   oWQ/HJyEK1lJy22ywgd8h0CweWhkwlMH3iXvkaLpgHKyodXiwduO1sml0
   oEO7DnSlx2zOb0+wpw7BSWSWFpAxC++LTNy/XTE4K2X1WTHEUFK8qYzzS
   xuZpu8CGvV67EFNhVSOeL4qZq3LrfXSg+TBPIY8vb58viVv/0RNS1rcM9
   w==;
X-CSE-ConnectionGUID: 7sCcgVkATWu2PqvMmmU/7g==
X-CSE-MsgGUID: P4Bsl6qQRvWIJxi6G/o41Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29923823"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="29923823"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:25:28 -0700
X-CSE-ConnectionGUID: fAmfrjHuTUGsr3PKMRJx5g==
X-CSE-MsgGUID: yP9DrkgfTv60ecSzKU2Xgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="86637363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Oct 2024 01:25:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 01:25:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 29 Oct 2024 01:25:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Oct 2024 01:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMcbOS/74SeW2PAMq4IAqylVj/n3vEt/F93ETKBYyScrVY9h1VU0MmFWWS8ZTLrssxXX44hvfRgv1JNGbXC3/Zu4zXg1ybwdObdAo3STZaPl1us2DChwudTM6eybB2aG3Bg6rMmLvgc40vbxNj18IG6UAOFvg8y5nkG//XVDsb1RKCRF1mPm0OvwT3Z/lgTZ0jKkXdge5davC750p5O7r6mgvt3UvAWvWYxdScYquLnm5UR3sIrh0/v67ODec+Wk/8YuTl2CfarvBDfJMcv9jOHvjjFwTx0XX96y+buT9iLbC6grPSeh88zjuqaPanneiIcJv00G0Q+ANEpNC1Z7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW7t702ad7HeXADKF/c6PXrkSDBLYo0jv2Qwg+Yt1vc=;
 b=y+Pf7Qy3WAFado4XGwaVmnApR2hlTZNQeZXDwMc4Q6RTnsd3pTbWoGwOhS9/rc7Hij31xKJ57pMIp1yYzO6/SVKu1CuGaUFQqKLok9lAja6ZYxNS8j22fXgD0lIRY32lpcsmNrDKV1Ua4EmSR6CXYTkkx9Qfm5gfuC8f+s9fjFdACgbc5O9IXeGCQul+sOYrKsxwq4sOqFIPAkUm/kg/3wuaP6T96KDQnKcC9lGCbWV0wCRh/cWPIyKyjUhYBBYAHobDumeFgqAm7XgT/YYHlAUYSXBU253vX41mg1x+/5xe4QkDeaWssPJ7aCpcOMSjM23jaPKqY6U1QqDJTMGF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5133.namprd11.prod.outlook.com (2603:10b6:a03:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:25:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.025; Tue, 29 Oct 2024
 08:25:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "aik@amd.com"
	<aik@amd.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 07/13] iommufd/viommu: Add iommufd_viommu_find_dev
 helper
Thread-Topic: [PATCH v5 07/13] iommufd/viommu: Add iommufd_viommu_find_dev
 helper
Thread-Index: AQHbJzjNOzBtqpw3OUiCv/cSXiWC7LKatAyAgACCcgCAAjMiEA==
Date: Tue, 29 Oct 2024 08:25:18 +0000
Message-ID: <BN9PR11MB52760A2D907B5FEA7618522A8C4B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1729897278.git.nicolinc@nvidia.com>
 <384f7b4333a1f75da09e390902b8f82be21a0dd3.1729897278.git.nicolinc@nvidia.com>
 <CABQgh9EpGPwdQhv7mepiMGVgR-8NMx5dcXyJ2A92W8ZzQt3bJw@mail.gmail.com>
 <Zx7DdPmEF/9aU70W@Asurada-Nvidia>
In-Reply-To: <Zx7DdPmEF/9aU70W@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5133:EE_
x-ms-office365-filtering-correlation-id: 8b47f19e-0eec-43c8-3975-08dcf7f3393f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/q0y/NCXUC6/0TIMTky8/WWGWul+JKbRw04ZChgFVUDoOC92pXkZGs8zKUuH?=
 =?us-ascii?Q?rklMxqGCC/zC4Ik9EZCDZ0ho0T7jzgmhItbv/Ds/yz7QyRR+6JNP9pfeNOjn?=
 =?us-ascii?Q?pAnUiQ4vtWIHeg1OLMMLHl1NE6u7l0ki4suFFwPFHu+LxIR8PCYGIy/WW5/N?=
 =?us-ascii?Q?+pTkObQgRhN/3eX9T0AYzkto5NjtPIxLfWnm8G4trsSBz5hvPbhbffsze50n?=
 =?us-ascii?Q?iLEIY/DVqurIbSp71dICaSrsFnEDaF5WTGppLM1ZEss+bSK9/7JUYv7gKnbK?=
 =?us-ascii?Q?vZP4tGn+IX+Y2rKWoBjvPU10t37Hs45QCH8Z5mnKW1K6VqiKLg3o6od4alAK?=
 =?us-ascii?Q?lfYb2nx83pxqgKjmoWVJk1+/I3saS5o7XKHKLW59LO803bQ0zaPXkZh/GHWr?=
 =?us-ascii?Q?ldu3J1mIucqWgvEwJUFO91Ss+vMNeEU3aIxS8Y+yvXVBUcLv4v4pRfnmt1UY?=
 =?us-ascii?Q?ceQPv9jDrjNzENv2iLmJN77A9D14DWuW5ebWpYrACyN1xb5rxCdG5gIqe/zb?=
 =?us-ascii?Q?9sIQ7XNXe4TUxakpp3eSpw3ioSVYudPzoOeaVe/a85UMBuVFt6ksFoXqjwN6?=
 =?us-ascii?Q?IO18EdRuUVLoqc3ogakvuLjRXQ5DN2OgzGSU7evJ6+FJzcK25yqcLcLk1leT?=
 =?us-ascii?Q?F1P2zvaNd2cO24uT9SX9VohbRqyy3mQnidF8XfvnhKwfvugId/0cmdLyDpXZ?=
 =?us-ascii?Q?naS2HJf66HrNCmM6yzFuiYy6kNk99x6CFD3wbgwXEpJcwy+7NGbRDS1L6h6W?=
 =?us-ascii?Q?WU+iTLiT2LEMPidkFjfpmPg72sbBPfEoHZuyg5IvvFPBE6QRXx9opuwfIhUZ?=
 =?us-ascii?Q?0dbVkfAR5r3vn4cvOk/0MvB4ZNEpPQ/DUAdwTRN12UBjpI7qBFQGgXnJLvm8?=
 =?us-ascii?Q?28QiG+a/0EgDmfq/DRCay3LpvLl3+ePpoUlVA7Dvs4tGd8fhA6Hl0+sy0qPg?=
 =?us-ascii?Q?pftkvVZ1J5xn0NwQdMxWRALBkdyzoiISnxbmb814afJudo5DcLHr5TCjKkQM?=
 =?us-ascii?Q?PqK3tfMdCQpFPDBJ+JC4X4zuwR9+NmcuKuSLqjZv44LbgIT8Ua+50cToYCQs?=
 =?us-ascii?Q?TiHdLEf7bv8CjNA+mlMWNH+aybjlTNYYkfd4CB3Q5HswxkCMzrySCJFcT0pI?=
 =?us-ascii?Q?ZZb2OS9mqEt3JCfo1wOYLj+ivAPPbA51RjHO9XThsrZ2delkwoUpskVidqM7?=
 =?us-ascii?Q?3Jk4wT740pwzf2/4hL+Jvxa6edZfFe3P7YjVdVFbyFFLQ3KV7jc9Thp/fE3N?=
 =?us-ascii?Q?6osG8nMM4p0igueWZxY2BzbEk0y17XVlB0UjyTlUAy5IxQBUORC7YWabwBr7?=
 =?us-ascii?Q?Huz7lhxVbYuDyAJONi4VfwXM8YVhE/Bpzozn3R8Vl647mVrwUmBEw3fB7Sz7?=
 =?us-ascii?Q?mi9WN0A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PkAikJuxuPRnLJwCvInDIHtTSGVoh4ITiFdBwCiVUKINTsCzI8QKGUAF1BvN?=
 =?us-ascii?Q?+rOcKjX+jXSZuesWAT7wY4i5W1SiEHmiGcXWxsyhJSTB0h337mH2It2/AN4f?=
 =?us-ascii?Q?/+HebTS/p0YbYR9rX8bLcW5S/IxTW0s8idYvQswzASGfFNUDoVQ+xRxHEKYR?=
 =?us-ascii?Q?mB5lW6D1fOUWIX2Fx93P0BvJeHT0bJk+PFMGByYj9xDP5lhhRfisZPW+Z/NE?=
 =?us-ascii?Q?to79ozXguaPECvuTDMhndd2klTnApuXsa+0CKYioBVq2k7vylHB1fyYcex4R?=
 =?us-ascii?Q?cLe1xA/rom5KPUqzNC0rctAzkeyzXSeA/srR+UiHhwymSL99vaDM5Ib+JGRP?=
 =?us-ascii?Q?EpbhuJEypui69iYdc2aq7wh194f7G8g9WqjXh1QhKC8TzjynDJYryEoBX0P7?=
 =?us-ascii?Q?guNdX+kCoyzist/KRU+gr2JJxtMza7xtjTBeBQevcI/ykk+VO4r98T7C1XVw?=
 =?us-ascii?Q?5meBf2MAnzDTwi8avjEqnPAAaifxXqvIxqp86rGESMTM3tx6pICbKMLklD69?=
 =?us-ascii?Q?avM/qsS8UabUC8jLn16HgLGH+tkquG/nKmY7+GZGoYbeoKSoODmGYyoFMjX+?=
 =?us-ascii?Q?dSyygUoptpzJLEkC2bDs0OZPF8+FGGnI3RI/lZUeuuomgvF6FvBZrZqDfZ8P?=
 =?us-ascii?Q?l0lzRcvDsrT0+EFTzudXgkIuK0miWKYfpjwYVKwnRRePPXlrrw6elELpeB4n?=
 =?us-ascii?Q?Gf8AIj+3jpjhy439boJb6eeikFm6B9zupT4dYJzSseQn8RxieOH8unAZhnjA?=
 =?us-ascii?Q?mI7sOl8/MapPZ/vya8fDRBA8Dth7oigXKo2BcWLKMPUJ8PH1rwb6xAA4opkd?=
 =?us-ascii?Q?X942MDNFxP9TcCCDtjdw7dMRvh4p2Hx9ljlyooURum70ngLYubKWSxZYo0X3?=
 =?us-ascii?Q?HX6qUV44wpI7MFdzGaIVl9EUG02LRwMUUEAjX4FuMaNoUnFlZMWdwqYmFw0G?=
 =?us-ascii?Q?fGrKyYu+o2WLpMXbPEDIjKkdXLm2ifaokipjA1JL5hlMnrvITntYQLtjzhf0?=
 =?us-ascii?Q?KlMc+cpKSBlVDQl8u0aibwRBIPMgW5QgGid1wFsMkG5F9QevlhNEv5RvjAmH?=
 =?us-ascii?Q?7BrcNnQBHCGTnIc2nyXu/eYkdzoVphSVsNJ02Ycvw72i3O0Xpp3QewEnovL9?=
 =?us-ascii?Q?UsFg4h4LfSeuXZhCcSONkHHT+ccfBzCiuMbK6oVei96M58cGKaTpOvYvAplf?=
 =?us-ascii?Q?0w+EsKu0rbJQl2rtkFUSOgt2UuX/pTHR97PXab+yWncZ6wTDIMszLXsTXeWk?=
 =?us-ascii?Q?a4J0Hc0Zm+bnnCoZua/RkzTl+x+iXxn2oQXZvVuhY56YdqA/ZCnZc2XBFQ/3?=
 =?us-ascii?Q?T3molz6S8FH+etuDia19i6E2CvI6ORhqF5vF+S8P/LTHHl2IRItW5GVubIJm?=
 =?us-ascii?Q?LM6ecHG/fcyT7cixRQnYQTbCb0yTycVsz7vCFquieYm6q3mC4UBE2G7w3xHA?=
 =?us-ascii?Q?a+/b0gt+tC0DE7wY0dwFN8bbpN3dDRqQYocSN9imlVFfGUHKWXAKiPwbuzHj?=
 =?us-ascii?Q?RoAtJJHrqqT5/tJlKrR8N0sq1J2kcbrV0xEBOJFBGjmJ+CRou8uE/Ymq/9bN?=
 =?us-ascii?Q?fl/TVRYBqzr9uJu6BVLvoCrg6l04ObMRoHYucvJs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b47f19e-0eec-43c8-3975-08dcf7f3393f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:25:18.9051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMPm3UzONYQySd7Ms+lgvRHv7PfIrbiCkMpqR1CHU4FKFGfjJ/gmCBDy08ZYjKfAyw1syUk8l9DM0PRXeRikQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5133
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, October 28, 2024 6:49 AM
>=20
> On Sun, Oct 27, 2024 at 11:02:31PM +0800, Zhangfei Gao wrote:
> > On Sat, 26 Oct 2024 at 07:51, Nicolin Chen <nicolinc@nvidia.com> wrote:
> > > +/* Caller should xa_lock(&viommu->vdevs) to protect the return value
> */
> > > +struct device *iommufd_viommu_find_dev(struct iommufd_viommu
> *viommu,
> > > +                                      unsigned long vdev_id)
> > > +{
> > > +       struct iommufd_vdevice *vdev;
> > > +
> > > +       lockdep_is_held(&viommu->vdevs.xa_lock);
> > > +
> > > +       vdev =3D xa_load(&viommu->vdevs, vdev_id);
> > > +       return vdev ? vdev->idev->dev : NULL;
> > > +}
> >
> > Got this error?
> >
> > ld: Unexpected GOT/PLT entries detected!
> > ld: Unexpected run-time procedure linkages detected!
> > ld: drivers/iommu/iommufd/driver.o: in function
> `iommufd_viommu_find_dev':
> > linux/drivers/iommu/iommufd/driver.c:47: undefined reference to
> > `lockdep_is_held'
> > make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > make[1]: *** [/home/linaro/iommufd/linux/Makefile:1166: vmlinux] Error
> 2
> > make: *** [Makefile:224: __sub-make] Error 2
>=20
> Should fix it with:
> -	lockdep_is_held(&viommu->vdevs.xa_lock);
> +	lockdep_assert_held(&viommu->vdevs.xa_lock);
>=20

with that,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

