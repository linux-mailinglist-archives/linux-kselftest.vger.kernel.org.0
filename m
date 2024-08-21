Return-Path: <linux-kselftest+bounces-15816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D0959477
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 08:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970431F24677
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC116D4E5;
	Wed, 21 Aug 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dY0uEmzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC611C6B5;
	Wed, 21 Aug 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221168; cv=fail; b=ciUcjHf1yyGYcdN0Ra2urfaNTMvsg4NvBG7xa8Z6Z9ECa/cEgNEAa/Yux2jAtQOzZtNOggc+Pa0w1H6jEf+hfEHi9iT/8Jl+Up74za3QKFWKktH/CQJWZFS0yaLwMy59lNyLTpal9GZtZI6Q6sm2edHUZ2OImq8ekGQFrbftjbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221168; c=relaxed/simple;
	bh=+WcLDejSZdASp1joF23vRAX1kcw0XcBkXCZpinagPdg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJBcCSYy683b2PKYqDAlkwHYLaptXeRVhfoPs9i6qWvziI4WeorglBWYXbVNWU/2Nboj8GpPgtBkquXEHHDIqD66dGF4+bGFww8K1Vk924oL6ZccpZIce1RDHPn/avlPFhehqUJPjz4pgTfF+LA0SPaVtz2nwujI3B6XAd+y29E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dY0uEmzG; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724221164; x=1755757164;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+WcLDejSZdASp1joF23vRAX1kcw0XcBkXCZpinagPdg=;
  b=dY0uEmzGC00v+m4gQQbgE01VWl9tB7awskhd9f2OaErtTW/EtYW2/Mt3
   TG/vURNhlicWWZKozZUarYYgmOFnoeQJPx/XMdBkSOgfIx+g6AInyA5B3
   K/E0iflveV7Nzo75khXQ4bHK0iASmog7Ilm6jSuTknzl1btxwiQAoX7kU
   9saJQGf0uhxN24r3HbD+GDX6nowKM2XLgjfv07/OhkdOTQmUHBgO53e18
   QqpM5W9ffxONVuhoyBH6xpCmAMcKof2bMBQDbVba8ZtAGinAhBASHXr5g
   +S2DOaniUcZBVRtLX7f8/pJR2oLTq5evuI7AifkZz4D5L0mu/pOgiaDEi
   w==;
X-CSE-ConnectionGUID: UdwMPQnjRIqtHqqo60tP6Q==
X-CSE-MsgGUID: Li0RocJCQBaixtgj2q8IQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22442825"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22442825"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 23:19:22 -0700
X-CSE-ConnectionGUID: jh+czjs8QhuqRr2bjVh9sA==
X-CSE-MsgGUID: EboPEWygQbioFsBw6jodJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60706342"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 23:19:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:19:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 23:19:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 23:19:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 23:19:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZMZ7EJwjAdhAlFR7ggecrJ65vutnX3ytkZcOdq8tHiFHObyIdkxuA+S5FuXgoSUH3XiyIPAyKMp7coXCajbahvPiwrQW5TjkG7r329TMGMEx81EbNxc79JXN+vrWoTHHsbFrkcQ3O9C04kX3Ehi/IAm2nc5VIz5tVHYQFsGvjAXzrw6iGsPUqzAKn4kOfuTUK2um37S1f+YGvNJM4wj+CcP389JzIjxyDVRDaQfbbMkIxI7CTPBZRX2sIrnUl+IQWNEVB+B4b4RdbYvmaBL2A08MAbLq6l3i1keXLob8QRZHFkDzpI80gLoNvXKb5lV43OsTr+4lwfEb17kRRYLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oThCV5924hU8cLA/oyHhncLl1gc7ooJX3S4pekT1wzQ=;
 b=e7HWYBfgeIokaPp69ccWr/L5M7ISYh18fRnY7ihs0bffBw/gY+3EmO83/S4b3HHKfGH1422Sns4qNo77ZW2GuBaEcvV1Q5peTdrN7asJzHbE6S3n1vv0qc6PHYOP1B4+348PGCLNAcvLsTnluVRDQWJIyZYpN5Zg79KMbBKhxC6CSG+7zy1eDT0c5uBEsRPO4WylF4imQA8oTyCW7h9gPJMbwOx6EcoFTv1fmX1FUo3zMOukDrJFWrfZZsFuWrlZbQCXgXRl/xp5+CU143W1uo9h82QYmhwmtwugq0Vnv2xTuF8FlytQSwC9bysdBR1cpePPH17i6UAnB+7NVcBy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB6029.namprd11.prod.outlook.com (2603:10b6:510:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 06:19:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 06:19:16 +0000
Date: Wed, 21 Aug 2024 14:19:03 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jeff Xu <jeffxu@google.com>
CC: Jeff Xu <jeffxu@chromium.org>, <akpm@linux-foundation.org>,
	<willy@infradead.org>, <torvalds@linux-foundation.org>,
	<Liam.Howlett@oracle.com>, <pedro.falcato@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
	<lorenzo.stoakes@oracle.com>, <mpe@ellerman.id.au>, <vbabka@suse.cz>,
	<keescook@chromium.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <ZsWG1yqQmrYrvkym@xsang-OptiPlex-9020>
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
 <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
 <Zr670gX13gKJOtG9@xsang-OptiPlex-9020>
 <CALmYWFvEaYZHBDy74V4gmEExTuMpYg3G+qGUvjL5WtpSVrVqRg@mail.gmail.com>
 <ZsG+yfTDCQSd1Lh7@xsang-OptiPlex-9020>
 <ZsKiC+MSWbAOxxDA@xsang-OptiPlex-9020>
 <ZsLnvO2lWwCZsD6V@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsLnvO2lWwCZsD6V@xsang-OptiPlex-9020>
X-ClientProxiedBy: SG2PR02CA0092.apcprd02.prod.outlook.com
 (2603:1096:4:90::32) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: 444a20bd-b06a-44c1-2e21-08dcc1a92eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZDgnSW+haYollS7dAAhmMbPmbNI+1cub6gBCF+EZpG/Kj1jrNo+MtNslf8?=
 =?iso-8859-1?Q?3FZfx7ku0KinMW5w0EL0p05sugnYm2F6NrJsRyKaLePYHDxQhn66P5hNEA?=
 =?iso-8859-1?Q?F7xqMM5rO3elUcZbnm4z9XtDSaeVOnnnjEi6ZzWGSUaRurOnDl5NsQ11b7?=
 =?iso-8859-1?Q?dIz4VwldpYh4cY4/6/My3etZTyyLRNi7CAjI497T1VJWNWolQGOSh7oLNL?=
 =?iso-8859-1?Q?coKT9smbXoYzIfT+YBTScWddoVBKqfIlRGLeyRInrQx5w6uaHcVteK033i?=
 =?iso-8859-1?Q?Qn3pDqomlnT1+gFLEX5//ZEdcRYs0URVE+Eci7vh+/Nx6qI8Ptd1wNcAHJ?=
 =?iso-8859-1?Q?mxopNR/4dvArr7PQpR1mXbZ9f4rZuW58q1TI2K3fc+symVXJKxq0BoQfZA?=
 =?iso-8859-1?Q?/b66SPP/1gEf371P4XE6vvYaZqvIX1ZZHPJEMbGuRzs9iSzMdKqE/VcQxg?=
 =?iso-8859-1?Q?XBZ8wi2U9WYEMHVOXgcH2P+Eh8cZwi0zqNZvgCOipaxiQf0f5F6oKiRYoS?=
 =?iso-8859-1?Q?/9Jh5AlbzRDgn2u8gbH9wjx5MQ5Y2NB0bYw2IVbXce9/dubsy+crrxdnM5?=
 =?iso-8859-1?Q?2wuM3o744ZQIoV+/JATAwcooPZZpBAhCVHo4c0WMj0AYBjCnfChBow7oaf?=
 =?iso-8859-1?Q?eEopJ9lYCBs/A5/5bK3Hpg8BTe+jR8kKBq1sE4G5cBq2wKqF9R72QMM5Hb?=
 =?iso-8859-1?Q?nPrkP9PgvdthnFjm57Mx5xf/d6FJivrq0vz+MXxkPtG+lUDRejTuOtCLSR?=
 =?iso-8859-1?Q?qoOVdDyRI0RIDGEJAU1bxE5RryCEVc3qvQeO7Q0KDfAG2Z7Nr7OWSdU1pm?=
 =?iso-8859-1?Q?x7+P0ja+QCNzshVNfaddwz8HbCtVnLoSEOdjVXHl9V+xZo2jFln+MQ2ndV?=
 =?iso-8859-1?Q?59cDU+XXCiyTPq+NaMh4jRBoMQlctvUWtPEOvA47rvlL6CAnVY8HZiEaET?=
 =?iso-8859-1?Q?23hYYe5Kps94fb5wtee82FR47xji/0cBrPB0aJtbiRxTVp1ZchspHg5o+y?=
 =?iso-8859-1?Q?TZ48ZZZ2VHbjJbhjoa76yeEhLBCObeFCmg9ssG/fS8372H934iMOqSL98V?=
 =?iso-8859-1?Q?fSwkF7So6+EaBJ8l0JzjqP59/72lOEjVjj6qzI9eUKfKModv30EVtkrmuM?=
 =?iso-8859-1?Q?5lfvgXqgLpbnPUTKBadgf1eg72l2FbysV4LPP5hHl/GFwlG8DeQgfpm28g?=
 =?iso-8859-1?Q?JbuGm1yKaZ8ERqCkYxsBC1v95MqsiESiiuOAE3ZhwwP5SBTy/t2+H5S//w?=
 =?iso-8859-1?Q?0PrDSKFwEsEnkrp4twE+/eJuYCTqYhLg8m4zBQoS+FHzV14ZUd+vdC03Am?=
 =?iso-8859-1?Q?K1Ob8fJa1Uxuc8dlxoBniOUHPCi6+cEGhtrMddNZ0092NDf3+lgfqOYTDT?=
 =?iso-8859-1?Q?zYIFAZ8dLf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M+/bV9bw0h6pfuGcsudMiQhKKy7stpb7QebNwhU4v1V7kn/0RZEHF5lbL+?=
 =?iso-8859-1?Q?Xj1DgaInwK40a3Zp/9RhXxojhOKUEBs8wsTh3tIJnv7yZDv16zasWwgeve?=
 =?iso-8859-1?Q?bqhkVaZSLEuy+v7lH3FfK/D0gwQ16S9TPswrdeHuvOlyqY8ArA1R/CKnl4?=
 =?iso-8859-1?Q?VcfyOVFAT9XjFDrPtIBhxNOZ3117KS6jvqMNQnOTG+tkCgAyEekhI1c0uJ?=
 =?iso-8859-1?Q?k/9fv8NfgUFlncAxgaIA4QXBFZ9+Gbt4TYzo2nyv4kSRulux5/vpkvZ0GA?=
 =?iso-8859-1?Q?Kyg9G1g9b9xzDZ7VqgymnAHhMfhGeQL5jC8wH1WLhp38ZFtI1UJikCNYrD?=
 =?iso-8859-1?Q?wDDRhr5kTE2R2DvmV4nPGLQesRmz8dpFSEpzbdt+nR/UQcg5an3aupKKon?=
 =?iso-8859-1?Q?suRHY2olWQu7eg7TPRc1ZgeWzHU8O5fo0d/o1arHeOItOQY4zSvrJuQ/wS?=
 =?iso-8859-1?Q?RH2j8wx401GZE/JXaj6CGhgzlb1HYEYC/uv0fXZ5ZQ273RjVi525nAD1Q1?=
 =?iso-8859-1?Q?jBopbp2xE78PTxz4p+AZoI6/OozUgL+sV8QmOtYRNRgG37cmeYwvr7YkLJ?=
 =?iso-8859-1?Q?Xb7YCwR4U5fFLpKZtgwEv5VEkzWfJXUoXEVfR90WG794btqVFwdtuVANKE?=
 =?iso-8859-1?Q?3jKM+TIWSDVx2FfJDoiVtLw8idnis9krPOfTGcNbMBByJLL4qiYWqocxRT?=
 =?iso-8859-1?Q?2Ym4jTq6Rk81XJBkIo5zEvfdhokNX6zn6P++2+G1ze0RrT+nwktr1LbYh/?=
 =?iso-8859-1?Q?MqdYi0fH3QBcJJUYarYl5MBBDnnX+k2p3l5PNq10GSWthKbs5OW7AAvNQG?=
 =?iso-8859-1?Q?gnjfKWHFFL84lNnvIHb1fP3CFsaU/DSueZ/wKG1yms+5cgb8nnLJ7v8NsG?=
 =?iso-8859-1?Q?/SiF/6PJRGqxuS+9K7knXtI7Yy1ie7GDG1dnVa9KZ6SZM/TXAGQ/jyrSW6?=
 =?iso-8859-1?Q?ZtnUW4C3hJVnI5t7ISHaAy5vfHlne4fphEEQSIWN2ayP13/YRRNVSXcIYe?=
 =?iso-8859-1?Q?HiG+z1/lMQ8KZjuOdtQZbVCyocM+BqeomhZ9tQx99qMyjMDJMInbvKyqXD?=
 =?iso-8859-1?Q?y0KTggqdor8M0FDrKosImktxwwxrujYk92+YhDdnZvggOrh5dxDsQdXH6q?=
 =?iso-8859-1?Q?bFbljyZHlHFYJ8GZsfZVAFbIu4pL0UXE1obgM3AXS4eop4u2lTQ23+Rw4M?=
 =?iso-8859-1?Q?RzFsYHCajObKWG12AG0B8bAusoXk6JDPKWfT0Jr0qBQ63stECfHJJ0DZu4?=
 =?iso-8859-1?Q?6c9KTUM3xZgmozbaxabjz1HWnArva+Lbvd8EfEdFeMJCKtWu8muYiRAOXJ?=
 =?iso-8859-1?Q?ZaY4W9bBLKNW6nY8YI+/rKCQZvIEgxhD0WmJDSYbCf5YuQZEX2vSASchuP?=
 =?iso-8859-1?Q?JdPBF+OewQ6U/uP0WMviv2UDdamYVT+gImjtR2s4vBHawWlKgTIS/xlKiD?=
 =?iso-8859-1?Q?EPxcK71jhWW1KrfeR9rxP7LMHBrvqKOWlq7+Kg9WwVqJbiBAK30P2Z/P8O?=
 =?iso-8859-1?Q?EAie7u6rwDLw3EsYEU1urL4aQlbzeuAFAOs+pnnzTnw1NHrcprbTLk5Vy3?=
 =?iso-8859-1?Q?G5hoAwNXOqiwu1EzVYrzyp1QB9zlYXnQ0rXU8ccl34T9T/1ItIpbP/qV2W?=
 =?iso-8859-1?Q?H4dfHWTXuUNrc2UBdMPCG/zdQWVDpl/OMFYAf6p6I+e7p8kckkmKP2/Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 444a20bd-b06a-44c1-2e21-08dcc1a92eb2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 06:19:16.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiLE4kp4/jgN/yryYpDnddpgeqxY0lYqKh0+fpKwyY59zA1Eh9G3b68yCBc53XjfnVQtnOm5287TmOnEO8L8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6029
X-OriginatorOrg: intel.com

hi, Jeff,

here is a update per your test request.

we extented the runtime to 600 seconds, and run 10 times for each commit.

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/***600s***

commit:
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")
  2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm"

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
 1.886e+08 ±  0%      -5.0%  1.792e+08 ±  0%      -3.4%  1.821e+08 ±  0%  stress-ng.pagemove.ops
    314345 ±  0%      -5.0%     298656 ±  0%      -3.4%     303565 ±  0%  stress-ng.pagemove.ops_per_sec


the score of stress-ng.pagemove.ops_per_sec has some difference with 60s
run (list as below for comparison). but the trend is similar.

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/***60s***

commit:
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")
  2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm"

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
  18386219 ±  0%      -5.0%   17474214 ±  0%      -2.9%   17850959 ±  0%  stress-ng.pagemove.ops
    306421 ±  0%      -5.0%     291207 ±  0%      -2.9%     297490 ±  0%  stress-ng.pagemove.ops_per_sec


since the data is stable, %stddev shows as "±  0%" in both above tables.
let me give out the detail data for 600s runs.

for
ff388fe5c4 ("mseal: wire up mseal syscall")

  "stress-ng.pagemove.ops": [
    188545955,
    188681834,
    188907282,
    188345009,
    188729465,
    188312187,
    188897283,
    188209713,
    188425965,
    189026136
  ],
  "stress-ng.pagemove.ops_per_sec": [
    314242.1,
    314467.13,
    314841.5,
    313907.19,
    314548.11,
    313852.5,
    314827.84,
    313680.74,
    314042.14,
    315042.79
  ],

for
8be7258aad ("mseal: add mseal syscall")

  "stress-ng.pagemove.ops": [
    179127848,
    179401350,
    179350278,
    179023817,
    179106624,
    179535213,
    178936504,
    178870141,
    179462171,
    179136065
  ],
  "stress-ng.pagemove.ops_per_sec": [
    298545.54,
    299000.95,
    298915.62,
    298371.45,
    298509.15,
    299223.65,
    298226.74,
    298115.08,
    299101.23,
    298558.74
  ],

for
2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm"

  "stress-ng.pagemove.ops": [
    182188207,
    182288813,
    182483678,
    181980233,
    182249440,
    181837961,
    182155893,
    181699445,
    182347580,
    182174597
  ],
  "stress-ng.pagemove.ops_per_sec": [
    303643.28,
    303814.05,
    304138.38,
    303298.9,
    303747.33,
    303060.84,
    303592.48,
    302831.56,
    303909.81,
    303622.07
  ],


for 600s run, below is the full comparion.

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/***600s***

commit:
  ff388fe5c4 ("mseal: wire up mseal syscall")
  8be7258aad ("mseal: add mseal syscall")
  2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm"

ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
      4667 ±  0%      -2.4%       4553 ±  0%      -1.6%       4593 ±  0%  vmstat.system.cs
 4.192e+08 ±  0%      -4.3%  4.012e+08 ±  0%      -2.8%  4.075e+08 ±  0%  proc-vmstat.numa_hit
 4.192e+08 ±  0%      -4.3%  4.011e+08 ±  0%      -2.8%  4.074e+08 ±  0%  proc-vmstat.numa_local
 7.843e+08 ±  0%      -4.3%  7.504e+08 ±  0%      -2.8%  7.623e+08 ±  0%  proc-vmstat.pgalloc_normal
 7.836e+08 ±  0%      -4.3%  7.498e+08 ±  0%      -2.8%  7.616e+08 ±  0%  proc-vmstat.pgfree
   1174825 ±  0%      -2.6%    1143891 ±  0%      -1.7%    1155336 ±  0%  time.involuntary_context_switches
      5082 ±  0%      +1.3%       5147 ±  0%      +0.9%       5126 ±  0%  time.percent_of_cpu_this_job_got
     29840 ±  0%      +1.4%      30267 ±  0%      +1.0%      30133 ±  0%  time.system_time
    663.58 ±  1%      -5.7%     625.54 ±  1%      -4.3%     635.17 ±  0%  time.user_time
 1.886e+08 ±  0%      -5.0%  1.792e+08 ±  0%      -3.4%  1.821e+08 ±  0%  stress-ng.pagemove.ops
    314345 ±  0%      -5.0%     298656 ±  0%      -3.4%     303565 ±  0%  stress-ng.pagemove.ops_per_sec
    212508 ±  0%      -4.3%     203280 ±  0%      -3.1%     205831 ±  0%  stress-ng.pagemove.page_remaps_per_sec
   1174825 ±  0%      -2.6%    1143891 ±  0%      -1.7%    1155336 ±  0%  stress-ng.time.involuntary_context_switches
      5082 ±  0%      +1.3%       5147 ±  0%      +0.9%       5126 ±  0%  stress-ng.time.percent_of_cpu_this_job_got
     29840 ±  0%      +1.4%      30267 ±  0%      +1.0%      30133 ±  0%  stress-ng.time.system_time
    663.58 ±  1%      -5.7%     625.54 ±  1%      -4.3%     635.17 ±  0%  stress-ng.time.user_time
      1.00 ±  0%      -7.1%       0.93 ±  0%      -4.9%       0.95 ±  0%  perf-stat.i.MPKI
 3.487e+10 ±  0%      +3.5%  3.607e+10 ±  0%      +2.4%   3.57e+10 ±  0%  perf-stat.i.branch-instructions
      0.21 ±  0%      -0.0        0.19 ±  3%      -0.0        0.20 ±  0%  perf-stat.i.branch-miss-rate%
 1.763e+08 ±  0%      -5.0%  1.675e+08 ±  0%      -3.4%  1.704e+08 ±  0%  perf-stat.i.cache-misses
 2.342e+08 ±  0%      -4.9%  2.228e+08 ±  0%      -3.3%  2.264e+08 ±  0%  perf-stat.i.cache-references
      4650 ±  0%      -2.4%       4537 ±  0%      -1.5%       4578 ±  0%  perf-stat.i.context-switches
      1.11 ±  0%      -2.2%       1.09 ±  0%      -1.6%       1.10 ±  0%  perf-stat.i.cpi
    172.66 ±  0%      -2.8%     167.77 ±  0%      -1.8%     169.52 ±  0%  perf-stat.i.cpu-migrations
      1121 ±  0%      +5.2%       1180 ±  0%      +3.5%       1160 ±  0%  perf-stat.i.cycles-between-cache-misses
 1.772e+11 ±  0%      +2.2%  1.812e+11 ±  0%      +1.6%  1.801e+11 ±  0%  perf-stat.i.instructions
      0.90 ±  0%      +2.3%       0.92 ±  0%      +1.6%       0.91 ±  0%  perf-stat.i.ipc
      0.99 ±  0%      -7.1%       0.92 ±  0%      -4.9%       0.95 ±  0%  perf-stat.overall.MPKI
      0.21 ±  0%      -0.0        0.19 ±  3%      -0.0        0.20 ±  0%  perf-stat.overall.branch-miss-rate%
      1.11 ±  0%      -2.2%       1.09 ±  0%      -1.6%       1.10 ±  0%  perf-stat.overall.cpi
      1120 ±  0%      +5.2%       1179 ±  0%      +3.5%       1159 ±  0%  perf-stat.overall.cycles-between-cache-misses
      0.90 ±  0%      +2.3%       0.92 ±  0%      +1.6%       0.91 ±  0%  perf-stat.overall.ipc
  3.48e+10 ±  0%      +3.5%    3.6e+10 ±  0%      +2.4%  3.563e+10 ±  0%  perf-stat.ps.branch-instructions
 1.759e+08 ±  0%      -5.0%  1.672e+08 ±  0%      -3.4%    1.7e+08 ±  0%  perf-stat.ps.cache-misses
 2.338e+08 ±  0%      -4.9%  2.224e+08 ±  0%      -3.3%   2.26e+08 ±  0%  perf-stat.ps.cache-references
      4642 ±  0%      -2.4%       4529 ±  0%      -1.5%       4570 ±  0%  perf-stat.ps.context-switches
    172.30 ±  0%      -2.8%     167.43 ±  0%      -1.8%     169.17 ±  0%  perf-stat.ps.cpu-migrations
 1.769e+11 ±  0%      +2.3%  1.808e+11 ±  0%      +1.6%  1.797e+11 ±  0%  perf-stat.ps.instructions
 1.063e+14 ±  0%      +2.3%  1.087e+14 ±  0%      +1.7%  1.081e+14 ±  0%  perf-stat.total.instructions
     74.86 ±  0%      -2.1       72.76 ±  0%      -0.8       74.06 ±  0%  perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     36.72 ±  0%      -1.7       35.04 ±  0%      -1.2       35.54 ±  0%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
     24.93 ±  0%      -1.4       23.54 ±  0%      -0.8       24.12 ±  0%  perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     19.91 ±  0%      -1.1       18.79 ±  0%      -0.7       19.17 ±  0%  perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
     14.71 ±  0%      -0.8       13.90 ±  0%      -0.4       14.30 ±  0%  perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
     10.82 ±  2%      -0.6       10.22 ±  2%      -0.6       10.25 ±  2%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.81 ±  2%      -0.6       10.21 ±  2%      -0.6       10.24 ±  2%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10.81 ±  2%      -0.6       10.21 ±  2%      -0.6       10.24 ±  2%  perf-profile.calltrace.cycles-pp.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
     10.80 ±  2%      -0.6       10.21 ±  2%      -0.6       10.23 ±  2%  perf-profile.calltrace.cycles-pp.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn.kthread
     10.85 ±  2%      -0.6       10.26 ±  2%      -0.6       10.28 ±  2%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     10.85 ±  2%      -0.6       10.26 ±  2%      -0.6       10.28 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     10.85 ±  2%      -0.6       10.26 ±  2%      -0.6       10.28 ±  2%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     10.76 ±  2%      -0.6       10.17 ±  2%      -0.6       10.20 ±  2%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd.smpboot_thread_fn
      1.49 ±  1%      -0.5        0.98 ±  0%      -0.5        1.00 ±  0%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      7.86 ±  0%      -0.4        7.48 ±  0%      -0.3        7.59 ±  0%  perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.72 ±  0%      -0.4        6.37 ±  0%      -0.2        6.49 ±  0%  perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.06 ±  2%      -0.3        5.71 ±  2%      -0.3        5.73 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs.run_ksoftirqd
      6.11 ±  0%      -0.3        5.77 ±  0%      -0.2        5.90 ±  0%  perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      6.11 ±  0%      -0.3        5.78 ±  1%      -0.2        5.90 ±  0%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.50 ±  0%      -0.3        5.19 ±  0%      -0.2        5.31 ±  0%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      5.52 ±  0%      -0.3        5.22 ±  0%      -0.2        5.35 ±  0%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
      5.15 ±  0%      -0.3        4.86 ±  0%      -0.2        4.97 ±  0%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
      5.77 ±  0%      -0.3        5.48 ±  0%      -0.2        5.58 ±  0%  perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      5.16 ±  0%      -0.3        4.88 ±  0%      -0.1        5.01 ±  0%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
      4.72 ±  2%      -0.3        4.44 ±  2%      -0.3        4.45 ±  2%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.handle_softirqs
      4.64 ±  0%      -0.3        4.38 ±  0%      -0.1        4.51 ±  1%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma
      4.07 ±  0%      -0.2        3.84 ±  0%      -0.2        3.92 ±  0%  perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      3.96 ±  1%      -0.2        3.76 ±  1%      -0.1        3.88 ±  1%  perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
      3.54 ±  0%      -0.2        3.34 ±  0%      -0.1        3.41 ±  1%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
     38.68 ±  0%      -0.2       38.49 ±  0%      +0.4       39.05 ±  0%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.55 ±  1%      -0.2        0.36 ± 65%      -0.0        0.52 ±  1%  perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      3.41 ±  0%      -0.2        3.22 ±  0%      -0.1        3.28 ±  0%  perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
      1.35 ±  0%      -0.2        1.17 ±  0%      -0.1        1.23 ±  0%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      2.22 ±  0%      -0.2        2.05 ±  0%      -0.1        2.12 ±  0%  perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      2.27 ±  0%      -0.2        2.10 ±  0%      -0.1        2.15 ±  0%  perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      3.25 ±  0%      -0.2        3.08 ±  0%      -0.1        3.14 ±  0%  perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      3.12 ±  2%      -0.2        2.97 ±  2%      -0.1        3.04 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.96 ±  0%      -0.1        0.82 ±  1%      -0.1        0.87 ±  1%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
      2.98 ±  1%      -0.1        2.84 ±  1%      -0.1        2.89 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
      8.19 ±  0%      -0.1        8.05 ±  0%      -0.1        8.04 ±  0%  perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      3.13 ±  0%      -0.1        3.00 ±  0%      -0.1        3.06 ±  0%  perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.53 ±  1%      -0.1        0.41 ± 50%      -0.2        0.30 ± 81%  perf-profile.calltrace.cycles-pp.arch_get_unmapped_area_topdown_vmflags.thp_get_unmapped_area_vmflags.__get_unmapped_area.mremap_to.__do_sys_mremap
      1.73 ±  2%      -0.1        1.61 ±  2%      -0.0        1.70 ±  3%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
      2.14 ±  2%      -0.1        2.02 ±  2%      -0.0        2.09 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      2.46 ±  0%      -0.1        2.34 ±  0%      -0.1        2.38 ±  0%  perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
      2.04 ±  0%      -0.1        1.93 ±  0%      -0.1        1.96 ±  0%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
      1.85 ±  0%      -0.1        1.74 ±  0%      -0.1        1.78 ±  0%  perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
      2.22 ±  0%      -0.1        2.12 ±  0%      -0.1        2.15 ±  0%  perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
      1.40 ±  0%      -0.1        1.30 ±  0%      -0.1        1.33 ±  0%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
      0.56 ±  1%      -0.1        0.46 ± 33%      -0.0        0.54 ±  2%  perf-profile.calltrace.cycles-pp.mas_walk.mas_prev_setup.mas_prev.vma_merge.copy_vma
      1.80 ±  2%      -0.1        1.70 ±  2%      -0.1        1.74 ±  2%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      2.43 ±  0%      -0.1        2.33 ±  0%      -0.1        2.37 ±  0%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
      1.25 ±  0%      -0.1        1.15 ±  1%      -0.1        1.19 ±  0%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
      0.94 ±  1%      -0.1        0.86 ±  0%      -0.1        0.87 ±  0%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
      1.38 ±  0%      -0.1        1.30 ±  0%      -0.1        1.33 ±  1%  perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
      1.22 ±  0%      -0.1        1.14 ±  0%      -0.1        1.17 ±  1%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma
      1.28 ±  0%      -0.1        1.21 ±  0%      -0.0        1.23 ±  0%  perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      1.54 ±  1%      -0.1        1.46 ±  0%      -0.0        1.49 ±  0%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
      1.15 ±  0%      -0.1        1.08 ±  1%      -0.1        1.09 ±  0%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
      0.73 ±  1%      -0.1        0.67 ±  1%      -0.0        0.69 ±  1%  perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
      0.72 ±  0%      -0.1        0.66 ±  1%      -0.0        0.69 ±  1%  perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
      1.64 ±  1%      -0.1        1.58 ±  0%      -0.1        1.58 ±  0%  perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.78 ±  1%      -0.1        0.72 ±  1%      -0.0        0.75 ±  1%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
      0.63 ±  1%      -0.1        0.57 ±  1%      -0.0        0.60 ±  1%  perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
      0.69 ±  2%      -0.1        0.63 ±  4%      -0.0        0.66 ±  2%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
      0.60 ±  1%      -0.1        0.54 ±  1%      -0.0        0.58 ±  1%  perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      0.79 ±  2%      -0.1        0.74 ±  3%      -0.0        0.75 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
      1.12 ±  0%      -0.0        1.08 ±  0%      -0.0        1.09 ±  1%  perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
      0.67 ±  1%      -0.0        0.62 ±  1%      -0.0        0.63 ±  1%  perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.77 ±  1%      -0.0        0.72 ±  1%      -0.0        0.73 ±  1%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
      1.01 ±  1%      -0.0        0.96 ±  0%      -0.0        0.98 ±  0%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
      0.86 ±  0%      -0.0        0.81 ±  1%      -0.0        0.83 ±  1%  perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
      0.82 ±  1%      -0.0        0.78 ±  1%      -0.0        0.79 ±  1%  perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      1.01 ±  0%      -0.0        0.97 ±  0%      -0.0        0.98 ±  0%  perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.98 ±  1%      -0.0        0.94 ±  0%      -0.0        0.94 ±  1%  perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.78 ±  0%      -0.0        0.74 ±  1%      -0.0        0.75 ±  1%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.68 ±  0%      -0.0        0.64 ±  1%      -0.0        0.65 ±  0%  perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
      0.68 ±  1%      -0.0        0.64 ±  1%      -0.0        0.64 ±  1%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
      0.89 ±  1%      -0.0        0.85 ±  1%      -0.0        0.86 ±  1%  perf-profile.calltrace.cycles-pp.mtree_load.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.62 ±  1%      -0.0        0.58 ±  2%      -0.0        0.59 ±  1%  perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
      0.62 ±  1%      -0.0        0.58 ±  1%      -0.0        0.59 ±  1%  perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.76 ±  1%      -0.0        0.72 ±  1%      -0.0        0.73 ±  1%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
      1.01 ±  0%      -0.0        0.97 ±  1%      -0.0        0.98 ±  1%  perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
      0.64 ±  1%      -0.0        0.60 ±  1%      -0.0        0.61 ±  1%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
      0.88 ±  1%      -0.0        0.85 ±  0%      -0.0        0.85 ±  0%  perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.69 ±  1%      -0.0        0.66 ±  1%      -0.0        0.67 ±  0%  perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
      0.59 ±  1%      -0.0        0.56 ±  1%      -0.0        0.56 ±  0%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
      0.82 ±  1%      -0.0        0.82 ±  1%      -0.0        0.79 ±  1%  perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
      0.76 ±  1%      +0.1        0.83 ±  0%      +0.1        0.84 ±  0%  perf-profile.calltrace.cycles-pp.__madvise
      0.67 ±  1%      +0.1        0.73 ±  1%      +0.1        0.75 ±  1%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
      0.63 ±  1%      +0.1        0.70 ±  1%      +0.1        0.71 ±  0%  perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.62 ±  1%      +0.1        0.69 ±  1%      +0.1        0.71 ±  0%  perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
      0.66 ±  1%      +0.1        0.73 ±  1%      +0.1        0.74 ±  0%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
     87.57 ±  0%      +0.6       88.14 ±  0%      +0.5       88.09 ±  0%  perf-profile.calltrace.cycles-pp.mremap
     84.74 ±  0%      +0.7       85.47 ±  0%      +0.6       85.37 ±  0%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.mremap
     84.58 ±  0%      +0.7       85.32 ±  0%      +0.6       85.22 ±  0%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     83.64 ±  0%      +0.8       84.41 ±  0%      +0.7       84.30 ±  0%  perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
      0.00 ± -1%      +0.9        0.86 ±  0%      +0.9        0.92 ±  0%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
      0.00 ± -1%      +0.9        0.87 ±  0%      +0.0        0.00 ± -1%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
      0.00 ± -1%      +0.9        0.91 ±  2%      +0.9        0.92 ±  1%  perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
      0.00 ± -1%      +1.1        1.09 ±  0%      +0.0        0.00 ± -1%  perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
      0.00 ± -1%      +1.2        1.21 ±  0%      +1.3        1.29 ±  0%  perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
      2.10 ±  0%      +1.5        3.61 ±  0%      +1.7        3.79 ±  0%  perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ± -1%      +1.5        1.51 ±  1%      +1.5        1.52 ±  0%  perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
      1.60 ±  0%      +1.5        3.13 ±  0%      +1.7        3.31 ±  0%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
      0.00 ± -1%      +1.6        1.60 ±  0%      +0.0        0.00 ± -1%  perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ± -1%      +1.7        1.73 ±  0%      +1.8        1.84 ±  0%  perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
      0.00 ± -1%      +2.0        2.00 ±  1%      +2.0        2.04 ±  0%  perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
      5.35 ±  0%      +3.0        8.37 ±  0%      +1.6        6.92 ±  0%  perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
     75.03 ±  0%      -2.1       72.92 ±  0%      -0.8       74.22 ±  0%  perf-profile.children.cycles-pp.move_vma
     36.94 ±  0%      -1.7       35.25 ±  0%      -1.2       35.75 ±  0%  perf-profile.children.cycles-pp.do_vmi_align_munmap
     25.01 ±  0%      -1.4       23.61 ±  0%      -0.8       24.19 ±  0%  perf-profile.children.cycles-pp.copy_vma
     20.00 ±  0%      -1.1       18.88 ±  0%      -0.7       19.26 ±  0%  perf-profile.children.cycles-pp.__split_vma
     19.92 ±  0%      -1.1       18.84 ±  0%      -0.8       19.14 ±  0%  perf-profile.children.cycles-pp.handle_softirqs
     19.90 ±  0%      -1.1       18.82 ±  0%      -0.8       19.12 ±  0%  perf-profile.children.cycles-pp.rcu_core
     19.88 ±  0%      -1.1       18.80 ±  0%      -0.8       19.10 ±  0%  perf-profile.children.cycles-pp.rcu_do_batch
     17.57 ±  0%      -0.9       16.66 ±  0%      -0.6       16.94 ±  0%  perf-profile.children.cycles-pp.kmem_cache_free
     15.29 ±  0%      -0.9       14.43 ±  0%      -0.5       14.75 ±  0%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
     15.11 ±  0%      -0.8       14.27 ±  0%      -0.4       14.68 ±  0%  perf-profile.children.cycles-pp.vma_merge
     12.15 ±  0%      -0.7       11.46 ±  0%      -0.5       11.65 ±  0%  perf-profile.children.cycles-pp.__slab_free
     12.11 ±  0%      -0.7       11.43 ±  0%      -0.4       11.71 ±  0%  perf-profile.children.cycles-pp.mas_wr_store_entry
     11.90 ±  0%      -0.7       11.24 ±  0%      -0.4       11.50 ±  0%  perf-profile.children.cycles-pp.mas_store_prealloc
     10.82 ±  2%      -0.6       10.22 ±  2%      -0.6       10.25 ±  2%  perf-profile.children.cycles-pp.smpboot_thread_fn
     10.81 ±  2%      -0.6       10.21 ±  2%      -0.6       10.24 ±  2%  perf-profile.children.cycles-pp.run_ksoftirqd
     10.85 ±  2%      -0.6       10.26 ±  2%      -0.6       10.28 ±  2%  perf-profile.children.cycles-pp.kthread
     10.85 ±  2%      -0.6       10.26 ±  2%      -0.6       10.28 ±  2%  perf-profile.children.cycles-pp.ret_from_fork
     10.85 ±  2%      -0.6       10.26 ±  2%      -0.6       10.28 ±  2%  perf-profile.children.cycles-pp.ret_from_fork_asm
     10.85 ±  0%      -0.6       10.26 ±  0%      -0.4       10.47 ±  0%  perf-profile.children.cycles-pp.vm_area_dup
      9.81 ±  0%      -0.5        9.28 ±  0%      -0.3        9.52 ±  0%  perf-profile.children.cycles-pp.mas_wr_node_store
      8.38 ±  1%      -0.5        7.90 ±  1%      -0.2        8.13 ±  1%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      7.98 ±  0%      -0.4        7.58 ±  0%      -0.3        7.70 ±  0%  perf-profile.children.cycles-pp.move_page_tables
      6.66 ±  0%      -0.4        6.29 ±  0%      -0.2        6.43 ±  0%  perf-profile.children.cycles-pp.vma_complete
      5.12 ±  0%      -0.3        4.79 ±  0%      -0.2        4.88 ±  0%  perf-profile.children.cycles-pp.mas_preallocate
      6.05 ±  0%      -0.3        5.72 ±  0%      -0.2        5.82 ±  0%  perf-profile.children.cycles-pp.vm_area_free_rcu_cb
      5.85 ±  0%      -0.3        5.56 ±  0%      -0.2        5.66 ±  0%  perf-profile.children.cycles-pp.move_ptes
      3.51 ±  1%      -0.2        3.28 ±  2%      -0.1        3.37 ±  1%  perf-profile.children.cycles-pp.mod_objcg_state
      3.45 ±  0%      -0.2        3.24 ±  0%      -0.2        3.30 ±  0%  perf-profile.children.cycles-pp.___slab_alloc
      2.91 ±  0%      -0.2        2.71 ±  0%      -0.1        2.78 ±  0%  perf-profile.children.cycles-pp.mas_alloc_nodes
      3.47 ±  0%      -0.2        3.27 ±  0%      -0.1        3.34 ±  0%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      3.43 ±  1%      -0.2        3.24 ±  1%      -0.1        3.35 ±  2%  perf-profile.children.cycles-pp.down_write
      2.44 ±  0%      -0.2        2.25 ±  0%      -0.1        2.32 ±  0%  perf-profile.children.cycles-pp.find_vma_prev
      4.24 ±  1%      -0.2        4.06 ±  1%      -0.1        4.11 ±  1%  perf-profile.children.cycles-pp.anon_vma_clone
      3.35 ±  0%      -0.2        3.18 ±  0%      -0.1        3.24 ±  0%  perf-profile.children.cycles-pp.mas_store_gfp
      2.21 ±  1%      -0.2        2.05 ±  0%      -0.1        2.10 ±  0%  perf-profile.children.cycles-pp.__cond_resched
      3.32 ±  0%      -0.2        3.17 ±  1%      -0.1        3.24 ±  0%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      8.26 ±  0%      -0.1        8.12 ±  0%      -0.1        8.11 ±  0%  perf-profile.children.cycles-pp.unmap_region
      2.22 ±  1%      -0.1        2.08 ±  1%      -0.1        2.16 ±  3%  perf-profile.children.cycles-pp.vma_prepare
      2.67 ±  0%      -0.1        2.54 ±  0%      -0.1        2.58 ±  0%  perf-profile.children.cycles-pp.mtree_load
      3.18 ±  0%      -0.1        3.05 ±  0%      -0.1        3.11 ±  0%  perf-profile.children.cycles-pp.unmap_vmas
      2.46 ±  0%      -0.1        2.34 ±  0%      -0.1        2.38 ±  0%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      2.50 ±  0%      -0.1        2.39 ±  0%      -0.1        2.43 ±  0%  perf-profile.children.cycles-pp.flush_tlb_func
      2.11 ±  1%      -0.1        2.00 ±  1%      -0.1        2.02 ±  1%  perf-profile.children.cycles-pp.__call_rcu_common
      2.04 ±  1%      -0.1        1.93 ±  1%      -0.1        1.95 ±  1%  perf-profile.children.cycles-pp.allocate_slab
      1.77 ±  1%      -0.1        1.66 ±  0%      -0.1        1.69 ±  1%  perf-profile.children.cycles-pp.mas_wr_walk
      1.87 ±  0%      -0.1        1.77 ±  0%      -0.1        1.80 ±  0%  perf-profile.children.cycles-pp.vma_link
      2.24 ±  0%      -0.1        2.13 ±  0%      -0.1        2.17 ±  0%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      1.85 ±  1%      -0.1        1.74 ±  0%      -0.1        1.79 ±  2%  perf-profile.children.cycles-pp.up_write
      2.48 ±  0%      -0.1        2.38 ±  0%      -0.1        2.42 ±  0%  perf-profile.children.cycles-pp.unmap_page_range
      0.97 ±  2%      -0.1        0.88 ±  1%      -0.1        0.90 ±  1%  perf-profile.children.cycles-pp.rcu_all_qs
      1.04 ±  0%      -0.1        0.95 ±  1%      -0.0        0.99 ±  1%  perf-profile.children.cycles-pp.mas_prev
      1.24 ±  0%      -0.1        1.16 ±  0%      -0.1        1.19 ±  0%  perf-profile.children.cycles-pp.mas_prev_slot
      0.93 ±  0%      -0.1        0.85 ±  1%      -0.0        0.88 ±  1%  perf-profile.children.cycles-pp.mas_prev_setup
      1.39 ±  1%      -0.1        1.31 ±  1%      -0.1        1.33 ±  1%  perf-profile.children.cycles-pp.shuffle_freelist
      1.52 ±  0%      -0.1        1.45 ±  0%      -0.0        1.48 ±  0%  perf-profile.children.cycles-pp.mas_update_gap
      1.58 ±  1%      -0.1        1.50 ±  0%      -0.0        1.53 ±  0%  perf-profile.children.cycles-pp.zap_pmd_range
      0.87 ±  1%      -0.1        0.80 ±  0%      -0.1        0.82 ±  1%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.68 ±  1%      -0.1        1.62 ±  0%      -0.1        1.62 ±  0%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.90 ±  1%      -0.1        0.84 ±  0%      -0.0        0.86 ±  1%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.62 ±  1%      -0.1        0.56 ±  1%      -0.0        0.60 ±  1%  perf-profile.children.cycles-pp.security_mmap_addr
      0.49 ±  1%      -0.1        0.44 ±  1%      -0.1        0.44 ±  1%  perf-profile.children.cycles-pp.setup_object
      1.02 ±  0%      -0.1        0.97 ±  1%      -0.0        0.99 ±  0%  perf-profile.children.cycles-pp.mas_leaf_max_gap
      0.98 ±  1%      -0.0        0.93 ±  1%      -0.0        0.94 ±  1%  perf-profile.children.cycles-pp.mas_pop_node
      1.22 ±  1%      -0.0        1.18 ±  1%      -0.0        1.19 ±  1%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.45 ±  2%      -0.0        0.40 ±  2%      -0.0        0.41 ±  1%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.18 ±  0%      -0.0        1.13 ±  0%      -0.0        1.15 ±  1%  perf-profile.children.cycles-pp.clear_bhb_loop
      1.08 ±  1%      -0.0        1.03 ±  0%      -0.0        1.05 ±  0%  perf-profile.children.cycles-pp.zap_pte_range
      1.04 ±  0%      -0.0        1.00 ±  0%      -0.0        1.01 ±  0%  perf-profile.children.cycles-pp.vma_to_resize
      0.58 ±  1%      -0.0        0.53 ±  1%      -0.0        0.54 ±  1%  perf-profile.children.cycles-pp.mas_wr_end_piv
      0.34 ±  2%      -0.0        0.30 ±  5%      -0.0        0.31 ±  4%  perf-profile.children.cycles-pp.get_partial_node
      0.64 ±  1%      -0.0        0.61 ±  2%      -0.0        0.61 ±  1%  perf-profile.children.cycles-pp.get_old_pud
      0.62 ±  0%      -0.0        0.59 ±  0%      -0.0        0.59 ±  1%  perf-profile.children.cycles-pp.__put_partials
      1.14 ±  0%      -0.0        1.10 ±  1%      -0.0        1.12 ±  1%  perf-profile.children.cycles-pp.mt_find
      0.90 ±  0%      -0.0        0.87 ±  0%      -0.0        0.87 ±  0%  perf-profile.children.cycles-pp.userfaultfd_unmap_complete
      0.61 ±  1%      -0.0        0.58 ±  1%      -0.0        0.59 ±  0%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.32 ±  2%      -0.0        0.29 ±  3%      -0.0        0.30 ±  4%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.54 ±  1%      -0.0        0.52 ±  1%      -0.0        0.52 ±  1%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.55 ±  1%      -0.0        0.52 ±  1%      -0.0        0.54 ±  1%  perf-profile.children.cycles-pp.refill_obj_stock
      0.45 ±  1%      -0.0        0.43 ±  2%      -0.0        0.43 ±  2%  perf-profile.children.cycles-pp.__alloc_pages_noprof
      0.43 ±  1%      -0.0        0.41 ±  2%      -0.0        0.41 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.17 ±  1%      -0.0        0.15 ±  3%      -0.0        0.16 ±  1%  perf-profile.children.cycles-pp.get_any_partial
      0.32 ±  1%      -0.0        0.30 ±  1%      -0.0        0.30 ±  1%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.40 ±  0%      -0.0        0.38 ±  1%      -0.0        0.39 ±  1%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.28 ±  2%      -0.0        0.26 ±  2%      -0.0        0.27 ±  1%  perf-profile.children.cycles-pp.khugepaged_enter_vma
      0.32 ±  1%      -0.0        0.30 ±  1%      -0.0        0.30 ±  2%  perf-profile.children.cycles-pp.mas_wr_store_setup
      0.19 ±  4%      -0.0        0.17 ±  4%      -0.0        0.18 ±  6%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.29 ±  1%      -0.0        0.27 ±  2%      -0.0        0.28 ±  3%  perf-profile.children.cycles-pp.tlb_gather_mmu
      0.09 ±  4%      -0.0        0.07 ±  6%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.vma_dup_policy
      0.16 ±  3%      -0.0        0.14 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.mas_wr_append
      0.22 ±  2%      -0.0        0.20 ±  3%      -0.0        0.20 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.20 ±  2%      -0.0        0.18 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.__thp_vma_allowable_orders
      0.24 ±  2%      -0.0        0.23 ±  2%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.44 ±  1%      +0.0        0.45 ±  1%      +0.0        0.46 ±  1%  perf-profile.children.cycles-pp.mremap_userfaultfd_prep
      0.85 ±  1%      +0.0        0.85 ±  1%      -0.0        0.81 ±  1%  perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
      0.13 ±  3%      +0.0        0.14 ±  3%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.free_pgd_range
      0.08 ±  8%      +0.0        0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflags
      0.78 ±  1%      +0.1        0.84 ±  0%      +0.1        0.86 ±  0%  perf-profile.children.cycles-pp.__madvise
      0.63 ±  1%      +0.1        0.70 ±  1%      +0.1        0.72 ±  0%  perf-profile.children.cycles-pp.__x64_sys_madvise
      0.63 ±  1%      +0.1        0.70 ±  0%      +0.1        0.71 ±  0%  perf-profile.children.cycles-pp.do_madvise
      0.00 ± -1%      +0.1        0.09 ±  0%      +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.can_modify_mm_madv
      1.32 ±  1%      +0.1        1.46 ±  0%      +0.2        1.50 ±  0%  perf-profile.children.cycles-pp.mas_next_slot
     87.96 ±  0%      +0.6       88.52 ±  0%      +0.5       88.48 ±  0%  perf-profile.children.cycles-pp.mremap
     85.91 ±  0%      +0.8       86.69 ±  0%      +0.7       86.61 ±  0%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     83.74 ±  0%      +0.8       84.52 ±  0%      +0.7       84.40 ±  0%  perf-profile.children.cycles-pp.__do_sys_mremap
     85.42 ±  0%      +0.8       86.23 ±  0%      +0.7       86.14 ±  0%  perf-profile.children.cycles-pp.do_syscall_64
     40.36 ±  0%      +1.4       41.74 ±  0%      +2.1       42.49 ±  0%  perf-profile.children.cycles-pp.do_vmi_munmap
      2.12 ±  0%      +1.5        3.63 ±  0%      +1.7        3.81 ±  0%  perf-profile.children.cycles-pp.do_munmap
      3.62 ±  0%      +2.3        5.97 ±  0%      +1.7        5.29 ±  0%  perf-profile.children.cycles-pp.mas_walk
      5.41 ±  0%      +3.0        8.44 ±  0%      +1.6        6.98 ±  0%  perf-profile.children.cycles-pp.mremap_to
      5.28 ±  0%      +3.2        8.48 ±  0%      +2.3        7.56 ±  0%  perf-profile.children.cycles-pp.mas_find
      0.00 ± -1%      +5.4        5.45 ±  0%      +3.9        3.94 ±  0%  perf-profile.children.cycles-pp.can_modify_mm
     11.51 ±  0%      -0.6       10.86 ±  0%      -0.5       11.04 ±  0%  perf-profile.self.cycles-pp.__slab_free
      4.23 ±  2%      -0.2        4.00 ±  2%      -0.1        4.13 ±  2%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      2.34 ±  1%      -0.1        2.21 ±  1%      -0.0        2.30 ±  3%  perf-profile.self.cycles-pp.down_write
      2.43 ±  0%      -0.1        2.31 ±  0%      -0.1        2.34 ±  0%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      2.34 ±  0%      -0.1        2.24 ±  0%      -0.1        2.27 ±  0%  perf-profile.self.cycles-pp.mtree_load
      2.21 ±  0%      -0.1        2.11 ±  0%      -0.1        2.14 ±  0%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      1.75 ±  0%      -0.1        1.67 ±  0%      -0.0        1.70 ±  0%  perf-profile.self.cycles-pp.mod_objcg_state
      1.54 ±  1%      -0.1        1.46 ±  0%      -0.0        1.50 ±  1%  perf-profile.self.cycles-pp.up_write
      1.52 ±  0%      -0.1        1.44 ±  0%      -0.1        1.46 ±  0%  perf-profile.self.cycles-pp.mas_wr_walk
      0.70 ±  3%      -0.1        0.63 ±  1%      -0.1        0.64 ±  1%  perf-profile.self.cycles-pp.rcu_all_qs
      1.43 ±  1%      -0.1        1.36 ±  1%      -0.1        1.36 ±  1%  perf-profile.self.cycles-pp.__call_rcu_common
      1.01 ±  0%      -0.1        0.95 ±  0%      -0.0        0.96 ±  0%  perf-profile.self.cycles-pp.mas_preallocate
      1.40 ±  1%      -0.1        1.33 ±  1%      -0.0        1.35 ±  0%  perf-profile.self.cycles-pp.do_vmi_align_munmap
      1.00 ±  0%      -0.1        0.94 ±  0%      -0.0        0.96 ±  0%  perf-profile.self.cycles-pp.mas_prev_slot
      1.14 ±  1%      -0.1        1.08 ±  1%      -0.0        1.10 ±  1%  perf-profile.self.cycles-pp.shuffle_freelist
      1.18 ±  0%      -0.1        1.13 ±  0%      -0.0        1.16 ±  0%  perf-profile.self.cycles-pp.vma_merge
      0.94 ±  1%      -0.1        0.89 ±  2%      -0.0        0.91 ±  1%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
      0.88 ±  0%      -0.1        0.83 ±  1%      -0.0        0.84 ±  0%  perf-profile.self.cycles-pp.___slab_alloc
      0.50 ±  1%      -0.0        0.45 ±  2%      -0.0        0.50 ±  1%  perf-profile.self.cycles-pp.security_mmap_addr
      0.77 ±  1%      -0.0        0.72 ±  1%      -0.0        0.74 ±  1%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.45 ±  2%      -0.0        0.40 ±  2%      -0.0        0.41 ±  1%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.17 ±  0%      -0.0        1.12 ±  0%      -0.0        1.14 ±  1%  perf-profile.self.cycles-pp.clear_bhb_loop
      1.08 ±  1%      -0.0        1.04 ±  1%      -0.0        1.06 ±  1%  perf-profile.self.cycles-pp.__cond_resched
      1.50 ±  2%      -0.0        1.46 ±  0%      -0.0        1.48 ±  0%  perf-profile.self.cycles-pp.kmem_cache_free
      1.23 ±  0%      -0.0        1.18 ±  0%      -0.1        1.18 ±  0%  perf-profile.self.cycles-pp.move_vma
      0.68 ±  1%      -0.0        0.64 ±  0%      -0.0        0.65 ±  1%  perf-profile.self.cycles-pp.__split_vma
      0.80 ±  0%      -0.0        0.76 ±  1%      -0.0        0.77 ±  0%  perf-profile.self.cycles-pp.mas_wr_store_entry
      0.61 ±  2%      -0.0        0.57 ±  2%      -0.0        0.57 ±  6%  perf-profile.self.cycles-pp.mremap
      0.85 ±  1%      -0.0        0.80 ±  1%      -0.0        0.81 ±  1%  perf-profile.self.cycles-pp.mas_pop_node
      0.44 ±  0%      -0.0        0.40 ±  1%      -0.0        0.40 ±  1%  perf-profile.self.cycles-pp.do_munmap
      0.98 ±  0%      -0.0        0.94 ±  1%      -0.0        0.95 ±  0%  perf-profile.self.cycles-pp.move_ptes
      0.89 ±  0%      -0.0        0.86 ±  0%      -0.0        0.87 ±  0%  perf-profile.self.cycles-pp.mas_leaf_max_gap
      0.46 ±  1%      -0.0        0.42 ±  1%      -0.0        0.43 ±  1%  perf-profile.self.cycles-pp.mas_wr_end_piv
      0.89 ±  0%      -0.0        0.86 ±  0%      -0.0        0.87 ±  0%  perf-profile.self.cycles-pp.mas_store_gfp
      0.79 ±  0%      -0.0        0.76 ±  1%      -0.0        0.76 ±  0%  perf-profile.self.cycles-pp.userfaultfd_unmap_complete
      0.99 ±  0%      -0.0        0.97 ±  0%      -0.0        0.98 ±  0%  perf-profile.self.cycles-pp.mt_find
      0.87 ±  0%      -0.0        0.84 ±  0%      -0.0        0.84 ±  0%  perf-profile.self.cycles-pp.move_page_tables
      0.55 ±  2%      -0.0        0.52 ±  1%      -0.0        0.52 ±  1%  perf-profile.self.cycles-pp.get_old_pud
      0.50 ±  0%      -0.0        0.47 ±  1%      -0.0        0.48 ±  0%  perf-profile.self.cycles-pp.find_vma_prev
      0.61 ±  0%      -0.0        0.58 ±  1%      -0.0        0.59 ±  0%  perf-profile.self.cycles-pp.unmap_region
      0.66 ±  0%      -0.0        0.63 ±  1%      -0.0        0.64 ±  0%  perf-profile.self.cycles-pp.mas_store_prealloc
      0.27 ±  1%      -0.0        0.25 ±  1%      -0.0        0.26 ±  1%  perf-profile.self.cycles-pp.mas_prev_setup
      0.61 ±  1%      -0.0        0.59 ±  1%      -0.0        0.60 ±  1%  perf-profile.self.cycles-pp.copy_vma
      0.48 ±  0%      -0.0        0.45 ±  1%      -0.0        0.46 ±  1%  perf-profile.self.cycles-pp.flush_tlb_mm_range
      0.41 ±  1%      -0.0        0.39 ±  1%      -0.0        0.40 ±  1%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.48 ±  1%      -0.0        0.46 ±  1%      -0.0        0.47 ±  0%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.50 ±  1%      -0.0        0.48 ±  1%      -0.0        0.48 ±  1%  perf-profile.self.cycles-pp.refill_obj_stock
      0.47 ±  1%      -0.0        0.46 ±  1%      -0.0        0.45 ±  1%  perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
      0.71 ±  0%      -0.0        0.69 ±  1%      -0.0        0.69 ±  1%  perf-profile.self.cycles-pp.unmap_page_range
      0.17 ±  4%      -0.0        0.15 ±  4%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.get_partial_node
      0.24 ±  1%      -0.0        0.22 ±  1%      -0.0        0.23 ±  0%  perf-profile.self.cycles-pp.mas_prev
      0.45 ±  1%      -0.0        0.43 ±  0%      -0.0        0.44 ±  1%  perf-profile.self.cycles-pp.mas_update_gap
      0.53 ±  1%      -0.0        0.51 ±  0%      -0.0        0.51 ±  1%  perf-profile.self.cycles-pp.mremap_to
      0.21 ±  2%      -0.0        0.19 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__get_unmapped_area
      0.27 ±  1%      -0.0        0.26 ±  1%      -0.0        0.25 ±  1%  perf-profile.self.cycles-pp.tlb_finish_mmu
      0.18 ±  2%      -0.0        0.17 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.rcu_do_batch
      0.06 ±  0%      -0.0        0.05 ±  0%      -0.0        0.05 ±  0%  perf-profile.self.cycles-pp.vma_dup_policy
      0.12 ±  0%      -0.0        0.11 ±  0%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.mas_wr_append
      0.14 ±  3%      -0.0        0.13 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.x64_sys_call
      0.11 ±  0%      +0.0        0.12 ±  0%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.free_pgd_range
      0.06 ±  5%      +0.0        0.07 ±  0%      +0.0        0.06 ±  5%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
      0.21 ±  0%      +0.0        0.22 ±  2%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
      0.45 ±  1%      +0.0        0.48 ±  2%      +0.0        0.50 ±  1%  perf-profile.self.cycles-pp.do_vmi_munmap
      0.27 ±  1%      +0.0        0.32 ±  2%      -0.0        0.26 ±  1%  perf-profile.self.cycles-pp.free_pgtables
      0.36 ±  2%      +0.1        0.44 ±  1%      -0.0        0.35 ±  4%  perf-profile.self.cycles-pp.unlink_anon_vmas
      1.07 ±  1%      +0.1        1.19 ±  0%      +0.1        1.22 ±  0%  perf-profile.self.cycles-pp.mas_next_slot
      1.50 ±  0%      +0.5        2.02 ±  0%      +0.4        1.85 ±  0%  perf-profile.self.cycles-pp.mas_find
      0.00 ± -1%      +1.4        1.38 ±  0%      +0.9        0.92 ±  0%  perf-profile.self.cycles-pp.can_modify_mm
      3.15 ±  0%      +2.1        5.26 ±  0%      +1.5        4.62 ±  0%  perf-profile.self.cycles-pp.mas_walk


On Mon, Aug 19, 2024 at 02:35:40PM +0800, Oliver Sang wrote:
> hi, Jeff,
> 
> On Mon, Aug 19, 2024 at 09:38:19AM +0800, Oliver Sang wrote:
> > hi, Jeff,
> > 
> > On Sun, Aug 18, 2024 at 05:28:41PM +0800, Oliver Sang wrote:
> > > hi, Jeff,
> > > 
> > > On Thu, Aug 15, 2024 at 07:58:57PM -0700, Jeff Xu wrote:
> > > > Hi Oliver
> > > 
> > > [...]
> > > 
> > > > > could you exlictly point to two commit-id?
> > > > sure
> > > > 
> > > > this patch
> > > > 8be7258a: mseal: add mseal syscall
> > > > ff388fe5c: mseal: wire up mseal syscall
> > > 
> > > I failed to apply this patch set to "8be7258a: mseal: add mseal syscall"
> > 
> > look your patch set again
> > [PATCH v1 1/2] mseal:selftest mremap across VMA boundaries
> > just for kselftests
> > 
> > and I can apply
> > [PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm
> > upon "8be7258a: mseal: add mseal syscall" cleanly
> > 
> > so I will start test for this [PATCH v1 2/2]
> > 
> > BTW, I will firstly use our default setting - "60s testtime; reboot between each
> > run; run 10 times", since we've already have the data for 8be7258a and ff388fe5c
> > then we could give you an update kind of quickly.
> > 
> > as some private mail discussed, you want some special run method, could you
> > elaborate them here? thanks
> 
> here is a quick update before you give us more details about special run method.
> 
> by our default run method (60s testtime; reboot between each run; run 10 times),
> your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm" could
> resolve regression partically.
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/pagemove/stress-ng/60s
> 
> commit:
>   ff388fe5c4 ("mseal: wire up mseal syscall")
>   8be7258aad ("mseal: add mseal syscall")
>   2a78ece39f  <-- your "[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm"
> 
> ff388fe5c481d39c 8be7258aad44b5e25977a98db13 2a78ece39f13ea6f3f9679a6c66
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       4957            +1.3%       5023            +1.0%       5008        time.percent_of_cpu_this_job_got
>       2915            +1.5%       2959            +1.2%       2949        time.system_time
>      65.96            -7.3%      61.16            -5.5%      62.30        time.user_time
>   41535878            -4.0%   39873501            -2.6%   40452264        proc-vmstat.numa_hit
>   41466104            -4.0%   39806121            -2.6%   40384854        proc-vmstat.numa_local
>   77297398            -4.1%   74165258            -2.6%   75286134        proc-vmstat.pgalloc_normal
>   77016866            -4.1%   73886027            -2.6%   75012630        proc-vmstat.pgfree
>   18386219            -5.0%   17474214            -2.9%   17850959        stress-ng.pagemove.ops
>     306421            -5.0%     291207            -2.9%     297490        stress-ng.pagemove.ops_per_sec
>       4957            +1.3%       5023            +1.0%       5008        stress-ng.time.percent_of_cpu_this_job_got
>       2915            +1.5%       2959            +1.2%       2949        stress-ng.time.system_time
>  3.349e+10 ±  4%      +3.0%  3.447e+10 ±  2%      +4.1%  3.484e+10        perf-stat.i.branch-instructions
>       1.13            -2.1%       1.10            -2.2%       1.10        perf-stat.i.cpi
>       0.89            +2.2%       0.91            +2.0%       0.91        perf-stat.i.ipc
>       1.04            -6.9%       0.97            -4.9%       0.99        perf-stat.overall.MPKI
>       1.13            -2.3%       1.10            -2.0%       1.10        perf-stat.overall.cpi
>       1081            +5.0%       1136            +3.0%       1114        perf-stat.overall.cycles-between-cache-misses
>       0.89            +2.3%       0.91            +2.0%       0.91        perf-stat.overall.ipc
>  3.295e+10 ±  3%      +2.9%  3.392e+10 ±  2%      +4.0%  3.427e+10        perf-stat.ps.branch-instructions
>  1.674e+11 ±  3%      +1.8%  1.704e+11 ±  2%      +3.3%   1.73e+11        perf-stat.ps.instructions
>  1.046e+13            +2.7%  1.074e+13            +1.7%  1.064e+13        perf-stat.total.instructions
>      75.05            -2.0       73.02            -0.9       74.18        perf-profile.calltrace.cycles-pp.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>      36.83            -1.6       35.19            -1.2       35.62        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
>      25.02            -1.4       23.65            -0.9       24.12        perf-profile.calltrace.cycles-pp.copy_vma.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      19.94            -1.1       18.87            -0.8       19.19        perf-profile.calltrace.cycles-pp.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>      14.78            -0.8       14.01            -0.5       14.28        perf-profile.calltrace.cycles-pp.vma_merge.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       1.48            -0.5        0.99            -0.5        1.00        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
>       7.88            -0.4        7.47            -0.3        7.62        perf-profile.calltrace.cycles-pp.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       6.73            -0.4        6.37            -0.2        6.51        perf-profile.calltrace.cycles-pp.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       6.16            -0.3        5.82            -0.3        5.90        perf-profile.calltrace.cycles-pp.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       6.12            -0.3        5.79            -0.2        5.93        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       5.79            -0.3        5.48            -0.2        5.59        perf-profile.calltrace.cycles-pp.move_ptes.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
>       5.54            -0.3        5.25            -0.2        5.32        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       5.56            -0.3        5.28            -0.2        5.36        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       5.19            -0.3        4.92            -0.2        4.98        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma.do_vmi_align_munmap
>       5.21            -0.3        4.95            -0.2        5.02        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma.move_vma
>       4.09            -0.2        3.85            -0.2        3.93        perf-profile.calltrace.cycles-pp.vm_area_dup.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       4.69            -0.2        4.46            -0.2        4.51        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge.copy_vma
>       3.56            -0.2        3.36            -0.1        3.43        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma.__do_sys_mremap
>       3.40            -0.2        3.22            -0.1        3.29        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma.__do_sys_mremap
>       1.35            -0.2        1.16            -0.1        1.24        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
>       4.00            -0.2        3.82            -0.1        3.86        perf-profile.calltrace.cycles-pp.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_complete.__split_vma
>       2.23            -0.2        2.05            -0.1        2.12        perf-profile.calltrace.cycles-pp.find_vma_prev.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       8.26            -0.2        8.10            -0.2        8.06        perf-profile.calltrace.cycles-pp.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       1.97 ±  3%      -0.2        1.81 ±  3%      -0.1        1.88 ±  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
>       3.11 ±  2%      -0.2        2.96            -0.1        3.05        perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
>       0.97            -0.2        0.81            -0.1        0.87        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.do_munmap.mremap_to
>       2.27            -0.2        2.11            -0.1        2.16        perf-profile.calltrace.cycles-pp.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       3.25            -0.1        3.10            -0.1        3.17        perf-profile.calltrace.cycles-pp.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       3.14            -0.1        3.00            -0.1        3.06        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       2.98            -0.1        2.85            -0.1        2.87 ±  2%  perf-profile.calltrace.cycles-pp.anon_vma_clone.__split_vma.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       1.27 ±  2%      -0.1        1.15 ±  4%      -0.1        1.19 ±  6%  perf-profile.calltrace.cycles-pp.__memcpy.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
>       2.45            -0.1        2.34            -0.1        2.38        perf-profile.calltrace.cycles-pp.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables.move_vma
>       2.05            -0.1        1.94            -0.1        1.97        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       2.44            -0.1        2.33            -0.1        2.38        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
>       2.22            -0.1        2.11            -0.1        2.15        perf-profile.calltrace.cycles-pp.native_flush_tlb_one_user.flush_tlb_func.flush_tlb_mm_range.move_ptes.move_page_tables
>       1.76 ±  2%      -0.1        1.65 ±  2%      -0.1        1.66 ±  4%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       1.86            -0.1        1.75            -0.1        1.78        perf-profile.calltrace.cycles-pp.vma_link.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       1.40            -0.1        1.30            -0.1        1.34        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap.do_vmi_munmap
>       1.39            -0.1        1.30            -0.1        1.33        perf-profile.calltrace.cycles-pp.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma.move_vma
>       0.55            -0.1        0.46 ± 30%      -0.0        0.52        perf-profile.calltrace.cycles-pp.mas_find.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
>       1.25            -0.1        1.16            -0.1        1.20        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma.do_vmi_align_munmap
>       0.94            -0.1        0.86            -0.1        0.87        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.do_vmi_munmap.move_vma.__do_sys_mremap
>       1.23            -0.1        1.15            -0.1        1.17        perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge.copy_vma
>       1.54            -0.1        1.47            -0.0        1.49        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.do_vmi_align_munmap
>       0.73            -0.1        0.66            -0.0        0.69        perf-profile.calltrace.cycles-pp.mas_walk.find_vma_prev.copy_vma.move_vma.__do_sys_mremap
>       1.15            -0.1        1.09            -0.1        1.10        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma.do_vmi_align_munmap
>       0.60 ±  2%      -0.1        0.54            -0.0        0.58        perf-profile.calltrace.cycles-pp.security_mmap_addr.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
>       1.27            -0.1        1.21            -0.0        1.24        perf-profile.calltrace.cycles-pp.mas_wr_store_entry.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       0.80 ±  2%      -0.1        0.74 ±  2%      -0.0        0.76 ±  2%  perf-profile.calltrace.cycles-pp.__call_rcu_common.mas_wr_node_store.mas_wr_store_entry.mas_store_prealloc.vma_merge
>       0.72            -0.1        0.66            -0.0        0.69        perf-profile.calltrace.cycles-pp.mas_prev.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       0.78            -0.1        0.73            -0.0        0.75        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.__split_vma
>       0.69 ±  2%      -0.1        0.64 ±  3%      -0.0        0.66 ±  4%  perf-profile.calltrace.cycles-pp.mod_objcg_state.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.vm_area_dup.copy_vma
>       1.63            -0.1        1.58            -0.1        1.57        perf-profile.calltrace.cycles-pp.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       1.02            -0.1        0.97            -0.0        0.98        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
>       0.77            -0.0        0.72            -0.0        0.74        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.mas_alloc_nodes.mas_preallocate.vma_merge
>       0.62            -0.0        0.57            -0.0        0.60        perf-profile.calltrace.cycles-pp.mas_prev_setup.mas_prev.vma_merge.copy_vma.move_vma
>       0.67            -0.0        0.62            -0.0        0.64        perf-profile.calltrace.cycles-pp.percpu_counter_add_batch.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.86            -0.0        0.81            -0.0        0.83        perf-profile.calltrace.cycles-pp.mtree_load.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64
>       1.12            -0.0        1.08            -0.0        1.09        perf-profile.calltrace.cycles-pp.clear_bhb_loop.mremap
>       0.56            -0.0        0.51            -0.0        0.53        perf-profile.calltrace.cycles-pp.mas_walk.mas_prev_setup.mas_prev.vma_merge.copy_vma
>       0.68 ±  2%      -0.0        0.63            -0.0        0.65        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.mremap
>       0.81            -0.0        0.77            -0.0        0.80        perf-profile.calltrace.cycles-pp.mtree_load.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>       1.02            -0.0        0.97            -0.0        0.98        perf-profile.calltrace.cycles-pp.vma_to_resize.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.95 ±  2%      -0.0        0.90 ±  2%      -0.0        0.93        perf-profile.calltrace.cycles-pp.__memcg_slab_free_hook.kmem_cache_free.unlink_anon_vmas.free_pgtables.unmap_region
>       0.98            -0.0        0.94            -0.0        0.95        perf-profile.calltrace.cycles-pp.mas_find.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.78            -0.0        0.74            -0.0        0.75        perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_link.copy_vma.move_vma.__do_sys_mremap
>       0.70            -0.0        0.66            -0.0        0.67        perf-profile.calltrace.cycles-pp.__call_rcu_common.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       0.69            -0.0        0.65            -0.0        0.66        perf-profile.calltrace.cycles-pp.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.copy_vma.move_vma
>       0.69            -0.0        0.65            -0.0        0.65        perf-profile.calltrace.cycles-pp.mas_preallocate.vma_link.copy_vma.move_vma.__do_sys_mremap
>       0.62            -0.0        0.59            -0.0        0.60        perf-profile.calltrace.cycles-pp.mas_prev_slot.do_vmi_align_munmap.do_vmi_munmap.move_vma.__do_sys_mremap
>       1.16            -0.0        1.12            -0.0        1.13        perf-profile.calltrace.cycles-pp.anon_vma_clone.copy_vma.move_vma.__do_sys_mremap.do_syscall_64
>       0.76 ±  2%      -0.0        0.72            -0.0        0.72 ±  2%  perf-profile.calltrace.cycles-pp.allocate_slab.___slab_alloc.kmem_cache_alloc_noprof.vm_area_dup.__split_vma
>       1.01            -0.0        0.97            -0.0        0.99        perf-profile.calltrace.cycles-pp.mt_find.vma_merge.copy_vma.move_vma.__do_sys_mremap
>       0.60            -0.0        0.57            -0.0        0.58        perf-profile.calltrace.cycles-pp.__pte_offset_map_lock.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
>       0.88            -0.0        0.85            -0.0        0.85        perf-profile.calltrace.cycles-pp.userfaultfd_unmap_complete.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>       0.62 ±  2%      -0.0        0.59 ±  2%      -0.0        0.60        perf-profile.calltrace.cycles-pp.get_old_pud.move_page_tables.move_vma.__do_sys_mremap.do_syscall_64
>       0.59            -0.0        0.56            -0.0        0.56        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.mremap
>       0.65            -0.0        0.62 ±  2%      -0.0        0.63        perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_gfp.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       0.81            +0.0        0.82            -0.0        0.79        perf-profile.calltrace.cycles-pp.thp_get_unmapped_area_vmflags.__get_unmapped_area.mremap_to.__do_sys_mremap.do_syscall_64
>       2.76            +0.0        2.78 ±  2%      -0.1        2.67        perf-profile.calltrace.cycles-pp.unlink_anon_vmas.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap
>       3.47            +0.0        3.51            -0.1        3.37        perf-profile.calltrace.cycles-pp.free_pgtables.unmap_region.do_vmi_align_munmap.do_vmi_munmap.move_vma
>       0.76            +0.1        0.83            +0.1        0.85        perf-profile.calltrace.cycles-pp.__madvise
>       0.66            +0.1        0.73            +0.1        0.75        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>       0.67            +0.1        0.74            +0.1        0.76        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__madvise
>       0.63            +0.1        0.70            +0.1        0.72        perf-profile.calltrace.cycles-pp.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>       0.62            +0.1        0.70            +0.1        0.71        perf-profile.calltrace.cycles-pp.do_madvise.__x64_sys_madvise.do_syscall_64.entry_SYSCALL_64_after_hwframe.__madvise
>       0.00            +0.9        0.86            +0.9        0.92        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.do_munmap
>       0.00            +0.9        0.88            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.mremap_to.__do_sys_mremap
>      83.81            +0.9       84.69            +0.6       84.44        perf-profile.calltrace.cycles-pp.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>       0.00            +0.9        0.90 ±  2%      +0.9        0.91        perf-profile.calltrace.cycles-pp.mas_walk.mas_find.can_modify_mm.do_vmi_munmap.move_vma
>       0.00            +1.1        1.10            +0.0        0.00        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64
>       0.00            +1.2        1.21            +1.3        1.28        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to
>       2.10            +1.5        3.60            +1.7        3.79        perf-profile.calltrace.cycles-pp.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +1.5        1.52            +1.5        1.52        perf-profile.calltrace.cycles-pp.mas_find.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap
>       1.59            +1.5        3.12            +1.7        3.31        perf-profile.calltrace.cycles-pp.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap.do_syscall_64
>       0.00            +1.6        1.61            +0.0        0.00        perf-profile.calltrace.cycles-pp.can_modify_mm.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +1.7        1.73            +1.8        1.83        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.do_munmap.mremap_to.__do_sys_mremap
>       0.00            +2.0        2.01            +2.0        2.04        perf-profile.calltrace.cycles-pp.can_modify_mm.do_vmi_munmap.move_vma.__do_sys_mremap.do_syscall_64
>       5.34            +3.0        8.38            +1.6        6.92        perf-profile.calltrace.cycles-pp.mremap_to.__do_sys_mremap.do_syscall_64.entry_SYSCALL_64_after_hwframe.mremap
>      75.22            -2.0       73.18            -0.9       74.34        perf-profile.children.cycles-pp.move_vma
>      37.04            -1.6       35.40            -1.2       35.83        perf-profile.children.cycles-pp.do_vmi_align_munmap
>      25.09            -1.4       23.72            -0.9       24.20        perf-profile.children.cycles-pp.copy_vma
>      20.04            -1.1       18.96            -0.8       19.28        perf-profile.children.cycles-pp.__split_vma
>      19.87            -1.0       18.84            -0.6       19.24        perf-profile.children.cycles-pp.rcu_core
>      19.85            -1.0       18.82            -0.6       19.22        perf-profile.children.cycles-pp.rcu_do_batch
>      19.89            -1.0       18.86            -0.6       19.26        perf-profile.children.cycles-pp.handle_softirqs
>      17.55            -0.9       16.67            -0.5       17.02        perf-profile.children.cycles-pp.kmem_cache_free
>      15.32            -0.8       14.49            -0.5       14.78        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
>      15.17            -0.8       14.39            -0.5       14.66        perf-profile.children.cycles-pp.vma_merge
>      12.12            -0.6       11.48            -0.4       11.70        perf-profile.children.cycles-pp.__slab_free
>      12.19            -0.6       11.56            -0.5       11.73        perf-profile.children.cycles-pp.mas_wr_store_entry
>      11.99            -0.6       11.36            -0.5       11.53        perf-profile.children.cycles-pp.mas_store_prealloc
>      10.88            -0.6       10.28            -0.4       10.50        perf-profile.children.cycles-pp.vm_area_dup
>       9.90            -0.5        9.41            -0.4        9.53        perf-profile.children.cycles-pp.mas_wr_node_store
>       8.39            -0.5        7.92            -0.3        8.13        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
>       7.99            -0.4        7.58            -0.3        7.73        perf-profile.children.cycles-pp.move_page_tables
>       6.70            -0.4        6.33            -0.3        6.43        perf-profile.children.cycles-pp.vma_complete
>       5.87            -0.3        5.55            -0.2        5.66        perf-profile.children.cycles-pp.move_ptes
>       5.12            -0.3        4.81            -0.2        4.90        perf-profile.children.cycles-pp.mas_preallocate
>       6.05            -0.3        5.74            -0.2        5.85        perf-profile.children.cycles-pp.vm_area_free_rcu_cb
>       2.98            -0.3        2.69 ±  4%      -0.2        2.80 ±  6%  perf-profile.children.cycles-pp.__memcpy
>       3.46 ±  2%      -0.2        3.25            -0.1        3.36 ±  3%  perf-profile.children.cycles-pp.mod_objcg_state
>       3.47            -0.2        3.26            -0.2        3.32        perf-profile.children.cycles-pp.___slab_alloc
>       2.44            -0.2        2.25            -0.1        2.33        perf-profile.children.cycles-pp.find_vma_prev
>       2.92            -0.2        2.73            -0.1        2.79        perf-profile.children.cycles-pp.mas_alloc_nodes
>       3.46            -0.2        3.27            -0.1        3.34        perf-profile.children.cycles-pp.flush_tlb_mm_range
>       3.47            -0.2        3.29            -0.2        3.32 ±  2%  perf-profile.children.cycles-pp.down_write
>       3.33            -0.2        3.16            -0.1        3.25        perf-profile.children.cycles-pp.__memcg_slab_free_hook
>       4.23            -0.2        4.07            -0.1        4.08 ±  2%  perf-profile.children.cycles-pp.anon_vma_clone
>       8.33            -0.2        8.17            -0.2        8.13        perf-profile.children.cycles-pp.unmap_region
>       3.35            -0.1        3.20            -0.1        3.26        perf-profile.children.cycles-pp.mas_store_gfp
>       2.21            -0.1        2.07            -0.1        2.10        perf-profile.children.cycles-pp.__cond_resched
>       3.19            -0.1        3.05            -0.1        3.11        perf-profile.children.cycles-pp.unmap_vmas
>       2.12            -0.1        1.99            -0.1        2.04        perf-profile.children.cycles-pp.__call_rcu_common
>       2.66            -0.1        2.54            -0.1        2.60        perf-profile.children.cycles-pp.mtree_load
>       2.24            -0.1        2.12 ±  2%      -0.1        2.13 ±  3%  perf-profile.children.cycles-pp.vma_prepare
>       2.50            -0.1        2.38            -0.1        2.42        perf-profile.children.cycles-pp.flush_tlb_func
>       2.04 ±  2%      -0.1        1.93            -0.1        1.96 ±  2%  perf-profile.children.cycles-pp.allocate_slab
>       2.46            -0.1        2.35            -0.1        2.41        perf-profile.children.cycles-pp.rcu_cblist_dequeue
>       2.48            -0.1        2.38            -0.1        2.42        perf-profile.children.cycles-pp.unmap_page_range
>       2.23            -0.1        2.12            -0.1        2.16        perf-profile.children.cycles-pp.native_flush_tlb_one_user
>       1.77            -0.1        1.67            -0.1        1.70        perf-profile.children.cycles-pp.mas_wr_walk
>       1.88            -0.1        1.78            -0.1        1.80        perf-profile.children.cycles-pp.vma_link
>       1.84            -0.1        1.75            -0.1        1.77        perf-profile.children.cycles-pp.up_write
>       0.97 ±  2%      -0.1        0.88            -0.1        0.89        perf-profile.children.cycles-pp.rcu_all_qs
>       1.40            -0.1        1.32            -0.1        1.34 ±  2%  perf-profile.children.cycles-pp.shuffle_freelist
>       1.03            -0.1        0.95            -0.0        0.99        perf-profile.children.cycles-pp.mas_prev
>       0.92            -0.1        0.85            -0.0        0.88        perf-profile.children.cycles-pp.mas_prev_setup
>       1.58            -0.1        1.51            -0.1        1.53        perf-profile.children.cycles-pp.zap_pmd_range
>       1.24            -0.1        1.17            -0.0        1.20        perf-profile.children.cycles-pp.mas_prev_slot
>       1.57            -0.1        1.49            -0.1        1.49        perf-profile.children.cycles-pp.mas_update_gap
>       0.62            -0.1        0.56            -0.0        0.60        perf-profile.children.cycles-pp.security_mmap_addr
>       0.90            -0.1        0.84            -0.0        0.86        perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.86            -0.1        0.80            -0.0        0.81        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.98            -0.1        0.92            -0.0        0.95        perf-profile.children.cycles-pp.mas_pop_node
>       1.68            -0.1        1.62            -0.1        1.62        perf-profile.children.cycles-pp.__get_unmapped_area
>       1.23            -0.1        1.18            -0.0        1.20        perf-profile.children.cycles-pp.__pte_offset_map_lock
>       0.49 ±  2%      -0.1        0.43            -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.setup_object
>       1.09            -0.1        1.03            -0.0        1.05        perf-profile.children.cycles-pp.zap_pte_range
>       1.07 ±  2%      -0.1        1.02 ±  2%      -0.1        1.00        perf-profile.children.cycles-pp.mas_leaf_max_gap
>       0.70 ±  2%      -0.0        0.65            -0.0        0.67        perf-profile.children.cycles-pp.syscall_return_via_sysret
>       1.18            -0.0        1.14            -0.0        1.15        perf-profile.children.cycles-pp.clear_bhb_loop
>       0.51 ±  3%      -0.0        0.47            -0.0        0.49 ±  3%  perf-profile.children.cycles-pp.anon_vma_interval_tree_insert
>       1.04            -0.0        1.00            -0.0        1.01        perf-profile.children.cycles-pp.vma_to_resize
>       0.57            -0.0        0.53            -0.0        0.54        perf-profile.children.cycles-pp.mas_wr_end_piv
>       0.44 ±  2%      -0.0        0.40 ±  2%      -0.0        0.40        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       1.14            -0.0        1.10            -0.0        1.12        perf-profile.children.cycles-pp.mt_find
>       0.90            -0.0        0.87            -0.0        0.87        perf-profile.children.cycles-pp.userfaultfd_unmap_complete
>       0.62            -0.0        0.59            -0.0        0.60        perf-profile.children.cycles-pp.__put_partials
>       0.45 ±  6%      -0.0        0.42            -0.0        0.43        perf-profile.children.cycles-pp._raw_spin_lock
>       0.48            -0.0        0.45 ±  2%      -0.0        0.46        perf-profile.children.cycles-pp.mas_prev_range
>       0.61            -0.0        0.58            -0.0        0.59        perf-profile.children.cycles-pp.entry_SYSCALL_64
>       0.31 ±  3%      -0.0        0.28 ±  3%      -0.0        0.31        perf-profile.children.cycles-pp.security_vm_enough_memory_mm
>       0.33 ±  3%      -0.0        0.30 ±  2%      -0.0        0.31 ±  4%  perf-profile.children.cycles-pp.mas_put_in_tree
>       0.32 ±  2%      -0.0        0.29 ±  2%      -0.0        0.30        perf-profile.children.cycles-pp.tlb_finish_mmu
>       0.46            -0.0        0.44 ±  2%      -0.0        0.46        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
>       0.33            -0.0        0.31            -0.0        0.32        perf-profile.children.cycles-pp.mas_destroy
>       0.36            -0.0        0.34            -0.0        0.34        perf-profile.children.cycles-pp.__rb_insert_augmented
>       0.39            -0.0        0.37            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.down_write_killable
>       0.29            -0.0        0.27 ±  2%      -0.0        0.28        perf-profile.children.cycles-pp.tlb_gather_mmu
>       0.26            -0.0        0.24 ±  2%      -0.0        0.25 ±  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.16 ±  2%      -0.0        0.14 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.mas_wr_append
>       0.30 ±  2%      -0.0        0.28 ±  2%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.__vm_enough_memory
>       0.32            -0.0        0.30 ±  2%      -0.0        0.31        perf-profile.children.cycles-pp.pte_offset_map_nolock
>       2.83            +0.0        2.85 ±  2%      -0.1        2.74        perf-profile.children.cycles-pp.unlink_anon_vmas
>       0.84            +0.0        0.86            -0.0        0.81        perf-profile.children.cycles-pp.thp_get_unmapped_area_vmflags
>       0.08 ±  5%      +0.0        0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.mm_get_unmapped_area_vmflags
>       3.52            +0.0        3.56            -0.1        3.42        perf-profile.children.cycles-pp.free_pgtables
>       0.78            +0.1        0.85            +0.1        0.86        perf-profile.children.cycles-pp.__madvise
>       0.63            +0.1        0.70            +0.1        0.72        perf-profile.children.cycles-pp.__x64_sys_madvise
>       0.63            +0.1        0.70            +0.1        0.71        perf-profile.children.cycles-pp.do_madvise
>       0.00            +0.1        0.09 ±  3%      +0.1        0.10 ±  5%  perf-profile.children.cycles-pp.can_modify_mm_madv
>       1.31            +0.2        1.46            +0.2        1.50        perf-profile.children.cycles-pp.mas_next_slot
>      83.90            +0.9       84.79            +0.6       84.53        perf-profile.children.cycles-pp.__do_sys_mremap
>      40.45            +1.4       41.90            +2.1       42.57        perf-profile.children.cycles-pp.do_vmi_munmap
>       2.12            +1.5        3.62            +1.7        3.82        perf-profile.children.cycles-pp.do_munmap
>       3.63            +2.4        5.98            +1.7        5.29        perf-profile.children.cycles-pp.mas_walk
>       5.40            +3.0        8.44            +1.6        6.97        perf-profile.children.cycles-pp.mremap_to
>       5.26            +3.2        8.48            +2.3        7.58        perf-profile.children.cycles-pp.mas_find
>       0.00            +5.5        5.46            +3.9        3.93        perf-profile.children.cycles-pp.can_modify_mm
>      11.49            -0.6       10.89            -0.4       11.10        perf-profile.self.cycles-pp.__slab_free
>       4.32            -0.3        4.06            -0.2        4.16        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
>       1.96            -0.2        1.77 ±  4%      -0.1        1.84 ±  6%  perf-profile.self.cycles-pp.__memcpy
>       2.36            -0.1        2.25 ±  2%      -0.1        2.25 ±  3%  perf-profile.self.cycles-pp.down_write
>       2.42            -0.1        2.31            -0.0        2.38        perf-profile.self.cycles-pp.rcu_cblist_dequeue
>       2.33            -0.1        2.23            -0.1        2.28        perf-profile.self.cycles-pp.mtree_load
>       2.21            -0.1        2.10            -0.1        2.14        perf-profile.self.cycles-pp.native_flush_tlb_one_user
>       1.62            -0.1        1.54            -0.0        1.57        perf-profile.self.cycles-pp.__memcg_slab_free_hook
>       1.52            -0.1        1.44            -0.1        1.46        perf-profile.self.cycles-pp.mas_wr_walk
>       1.44            -0.1        1.36            -0.1        1.38 ±  2%  perf-profile.self.cycles-pp.__call_rcu_common
>       1.53            -0.1        1.45            -0.0        1.48        perf-profile.self.cycles-pp.up_write
>       1.72            -0.1        1.65            -0.0        1.70        perf-profile.self.cycles-pp.mod_objcg_state
>       0.69 ±  2%      -0.1        0.63            -0.1        0.63        perf-profile.self.cycles-pp.rcu_all_qs
>       1.14 ±  2%      -0.1        1.08            -0.0        1.09 ±  2%  perf-profile.self.cycles-pp.shuffle_freelist
>       1.18            -0.1        1.12            -0.0        1.17        perf-profile.self.cycles-pp.vma_merge
>       1.38            -0.1        1.33            -0.0        1.35        perf-profile.self.cycles-pp.do_vmi_align_munmap
>       0.51 ±  2%      -0.1        0.45            -0.0        0.49        perf-profile.self.cycles-pp.security_mmap_addr
>       0.62            -0.1        0.56 ±  2%      -0.1        0.56        perf-profile.self.cycles-pp.mremap
>       0.89            -0.1        0.83            -0.0        0.85        perf-profile.self.cycles-pp.___slab_alloc
>       0.99            -0.1        0.94            -0.0        0.96        perf-profile.self.cycles-pp.mas_prev_slot
>       1.00            -0.0        0.95            -0.0        0.96        perf-profile.self.cycles-pp.mas_preallocate
>       0.98            -0.0        0.93            -0.0        0.95        perf-profile.self.cycles-pp.move_ptes
>       0.85            -0.0        0.80            -0.0        0.82        perf-profile.self.cycles-pp.mas_pop_node
>       0.94            -0.0        0.90            -0.0        0.91 ±  2%  perf-profile.self.cycles-pp.vm_area_free_rcu_cb
>       1.09            -0.0        1.04            -0.0        1.06        perf-profile.self.cycles-pp.__cond_resched
>       0.77            -0.0        0.72            -0.0        0.74        perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.94 ±  2%      -0.0        0.89 ±  2%      -0.1        0.87        perf-profile.self.cycles-pp.mas_leaf_max_gap
>       1.17            -0.0        1.12            -0.0        1.14        perf-profile.self.cycles-pp.clear_bhb_loop
>       0.68            -0.0        0.63            -0.0        0.65        perf-profile.self.cycles-pp.__split_vma
>       0.79            -0.0        0.75            -0.0        0.77        perf-profile.self.cycles-pp.mas_wr_store_entry
>       1.22            -0.0        1.18            -0.0        1.18        perf-profile.self.cycles-pp.move_vma
>       0.43 ±  2%      -0.0        0.40 ±  2%      -0.0        0.40        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       1.49            -0.0        1.45            +0.0        1.49        perf-profile.self.cycles-pp.kmem_cache_free
>       0.44            -0.0        0.40            -0.0        0.40        perf-profile.self.cycles-pp.do_munmap
>       0.45            -0.0        0.42            -0.0        0.43        perf-profile.self.cycles-pp.mas_wr_end_piv
>       0.89            -0.0        0.86            -0.0        0.88        perf-profile.self.cycles-pp.mas_store_gfp
>       0.78            -0.0        0.75            -0.0        0.76        perf-profile.self.cycles-pp.userfaultfd_unmap_complete
>       0.66            -0.0        0.62            -0.0        0.64        perf-profile.self.cycles-pp.mas_store_prealloc
>       0.60            -0.0        0.58            -0.0        0.59        perf-profile.self.cycles-pp.unmap_region
>       0.36 ±  4%      -0.0        0.33 ±  3%      -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.syscall_return_via_sysret
>       0.55            -0.0        0.52            -0.0        0.53        perf-profile.self.cycles-pp.get_old_pud
>       0.99            -0.0        0.97            -0.0        0.98        perf-profile.self.cycles-pp.mt_find
>       0.61            -0.0        0.58            -0.0        0.60        perf-profile.self.cycles-pp.copy_vma
>       0.43 ±  3%      -0.0        0.40            -0.0        0.41 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
>       0.49            -0.0        0.47            -0.0        0.48        perf-profile.self.cycles-pp.find_vma_prev
>       0.71            -0.0        0.68            -0.0        0.70        perf-profile.self.cycles-pp.unmap_page_range
>       0.27            -0.0        0.25            -0.0        0.26        perf-profile.self.cycles-pp.mas_prev_setup
>       0.47            -0.0        0.45            -0.0        0.46 ±  2%  perf-profile.self.cycles-pp.flush_tlb_mm_range
>       0.37 ±  6%      -0.0        0.35            -0.0        0.35        perf-profile.self.cycles-pp._raw_spin_lock
>       0.41            -0.0        0.39            -0.0        0.40        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.40            -0.0        0.37            -0.0        0.38        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.27            -0.0        0.25 ±  2%      -0.0        0.25 ±  3%  perf-profile.self.cycles-pp.mas_put_in_tree
>       0.49            -0.0        0.47            -0.0        0.49        perf-profile.self.cycles-pp.refill_obj_stock
>       0.48            -0.0        0.46            -0.0        0.47        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.27 ±  2%      -0.0        0.25            -0.0        0.26        perf-profile.self.cycles-pp.tlb_finish_mmu
>       0.24 ±  2%      -0.0        0.22            -0.0        0.23        perf-profile.self.cycles-pp.mas_prev
>       0.28            -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.mas_alloc_nodes
>       0.40            -0.0        0.39            -0.0        0.40        perf-profile.self.cycles-pp.__pte_offset_map_lock
>       0.14 ±  3%      -0.0        0.12 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
>       0.26            -0.0        0.24 ±  2%      -0.0        0.25        perf-profile.self.cycles-pp.__rb_insert_augmented
>       0.28            -0.0        0.26            -0.0        0.27        perf-profile.self.cycles-pp.alloc_new_pud
>       0.28            -0.0        0.26            -0.0        0.27 ±  2%  perf-profile.self.cycles-pp.flush_tlb_func
>       0.20 ±  2%      -0.0        0.19            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__get_unmapped_area
>       0.47            -0.0        0.46            -0.0        0.45        perf-profile.self.cycles-pp.arch_get_unmapped_area_topdown_vmflags
>       0.06            -0.0        0.05 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.vma_dup_policy
>       0.06 ±  6%      +0.0        0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.mm_get_unmapped_area_vmflags
>       0.11 ±  4%      +0.0        0.12 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.free_pgd_range
>       0.21            +0.0        0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.thp_get_unmapped_area_vmflags
>       0.45            +0.0        0.48            +0.0        0.50        perf-profile.self.cycles-pp.do_vmi_munmap
>       0.27            +0.0        0.32            -0.0        0.26        perf-profile.self.cycles-pp.free_pgtables
>       0.36 ±  2%      +0.1        0.44            -0.0        0.35        perf-profile.self.cycles-pp.unlink_anon_vmas
>       1.07            +0.1        1.19            +0.2        1.22        perf-profile.self.cycles-pp.mas_next_slot
>       1.49            +0.5        2.01            +0.4        1.86        perf-profile.self.cycles-pp.mas_find
>       0.00            +1.4        1.37            +0.9        0.93        perf-profile.self.cycles-pp.can_modify_mm
>       3.14            +2.1        5.23            +1.5        4.60        perf-profile.self.cycles-pp.mas_walk
> 
> 
> > 
> > 
> > > 
> > > to avoid the impact of other changes, better to apply the patch upon 8be7258a
> > > directly.
> > > 
> > > if you prefer other base for this patch, please let us know. then we will
> > > supply the results for 4 commits in fact:
> > > 
> > > this patch
> > > the base of this patch
> > > 8be7258a: mseal: add mseal syscall
> > > ff388fe5c: mseal: wire up mseal syscall
> > > 
> > > > 
> > > > > >
> > > > > > Thank you for your time and assistance in helping me on understanding
> > > > > > this issue.
> > > > >
> > > > > due to resource constraint, please expect that we need several days to finish
> > > > > this test request.
> > > > No problem.
> > > > 
> > > > Thanks for your help!
> > > > -Jeff
> > > > 
> > > > > >
> > > > > > Best regards,
> > > > > > -Jeff
> > > > > >
> > > > > > > -Jeff
> > > > > > >
> > > > > > > > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.com/
> > > > > > > > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> > > > > > > >
> > > > > > > >
> > > > > > > > Jeff Xu (2):
> > > > > > > >   mseal:selftest mremap across VMA boundaries.
> > > > > > > >   mseal: refactor mremap to remove can_modify_mm
> > > > > > > >
> > > > > > > >  mm/internal.h                           |  24 ++
> > > > > > > >  mm/mremap.c                             |  77 +++----
> > > > > > > >  mm/mseal.c                              |  17 --
> > > > > > > >  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
> > > > > > > >  4 files changed, 353 insertions(+), 58 deletions(-)
> > > > > > > >
> > > > > > > > --
> > > > > > > > 2.46.0.76.ge559c4bf1a-goog
> > > > > > > >

