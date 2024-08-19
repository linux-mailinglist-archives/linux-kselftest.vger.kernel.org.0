Return-Path: <linux-kselftest+bounces-15601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E62C9560EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 03:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C686DB21BC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3918E0E;
	Mon, 19 Aug 2024 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eE6U2CUC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112E241E7;
	Mon, 19 Aug 2024 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724031527; cv=fail; b=VA9duu8IOioIcUWAqCf16tOrqGJKcHM2qX1EtyFz5U01oqhSY++lFSfWZLkSJ4ZXFmNi4b7NNxNN6aBpIVOuyphRQiraIiUCfQ+Zk34gVfF1BS26uJSrjpktXR4xjqAZR5S6pGcY6kMRyikCZj/2+VLbZIDzL91EGaecF0gW3Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724031527; c=relaxed/simple;
	bh=L3QzGeR0hFujAhlviEC4asPjABDIhnMf3t0aQVS3wDU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oiJPoEREsvlkxKh+eRZzTzH7JzxFzv9O04KwRV0ILUijzlJ3RR47m83fQsYZFqcO73Gf2JAlyjBm0qGOZt/zhUuw4sqPscmy14Q1EoeM4uLg3YhExxPIAyGCxUX8qRSGQGZyjzhyGB7oX+qecX/ruzEO/Ycm66wPdo76gvk8tDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eE6U2CUC; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724031526; x=1755567526;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=L3QzGeR0hFujAhlviEC4asPjABDIhnMf3t0aQVS3wDU=;
  b=eE6U2CUCf2j5dpBB9nzPUpFYlyJmZ/1OM8XM1blxk+TEqJWmLIYwmhyr
   U050pCVnNUE1I/NczVKEgUJkm4vZLLiT4mHx9CQQ2Mrlbt6vh/9Cmy7tt
   llsmIR2DnvyESWd1g3oogc7AUECp4JdhphfZgsd7OofmQ3loN0iIv3nJC
   3qllUMJSo4bjWyrOf86B3JXEqHflRZvaf5zRmwMuOeXI32zLDtMuozGto
   pk+DdvpBu/ZxM0ghb7Y1c894YYOirSxCasCpexowu7b6Rjca5V7dvZ7xH
   Z9vaJ3JKiFJ1AjYQrFqquzEvOuCRNdLSObRvcFrgmtXjjTp+ufOnVQHgl
   A==;
X-CSE-ConnectionGUID: fFx1IUQ7QsKylotz5H32hQ==
X-CSE-MsgGUID: vXEL2uH2QkSLC8WEyxO3qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22426719"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22426719"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 18:38:45 -0700
X-CSE-ConnectionGUID: GfHZqJ5vSzGqEAaLvTaOrA==
X-CSE-MsgGUID: JTlF3wAVSy69wSDgMiqnyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60213928"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 18:38:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 18:38:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 18:38:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 18:38:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 18:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W66qj4GY5MIoE+3jDckt+pA7S6ql1ldsJU3QzLyLhZi1d1m/M5IcGOLAVBU1gXOAmVocYjMi4BS4BypqbgNK62edQQpc+SCdEgcz4y9JgtI8G2OI2F1Wc50Uu9KU9RSXZ7uCsE5jO2+mbT9qMq7kjhb4yjNeQ9qv5qCOhHkRgzbz/eE1tbU0GJ1s1OqpymNMn+Sq7wnKc2Aimyw+ScTdS1kWCQCBJ+ZTh62iBHNAaOdsX2SiEfvKtkUCWacIFxqpmsQfK+4lXRBvmHhvRZQSSZX+t1MTbb5a/Enq1/Jc/HdXDrbMiKo05nToM/RhbuxHqvJoSkjgkKtsM+kWJcvivQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96dNUBhgBAGyJA8DVm7+drTP2QyyOA3oDI0giJlaVYk=;
 b=jPVocgK0Imli2Z1sQYYnqXnbrziBowJkJattX1/Ltp8+mT0tte+H9jYDJPxAYF5gwGt5p6Xq3z5oNS34ls3vbnZf5G6VwB5xAovADJTDb8UykKVfL0ywdOvJOxnfxtViDpMBHygorU5Hp4WxBC95PgLh2nQopv8PabNavvQD3tWhUng764kyrioUxShwYjE/BkCgT3fIlYuDaEVFNEVYX0B8yOpriypLSE+8aOQXhnfX/nQabb8QRJhqaRbXy14P7prGY8iVsoUxdOKUzUlPKDPmk3mEi7Zi3D1cDLZcNUoJOSVkcr4N3WbXhi4yOe3uodJXxilF64VYfa2vpxzlrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 01:38:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 01:38:31 +0000
Date: Mon, 19 Aug 2024 09:38:19 +0800
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
Message-ID: <ZsKiC+MSWbAOxxDA@xsang-OptiPlex-9020>
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
 <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
 <Zr670gX13gKJOtG9@xsang-OptiPlex-9020>
 <CALmYWFvEaYZHBDy74V4gmEExTuMpYg3G+qGUvjL5WtpSVrVqRg@mail.gmail.com>
 <ZsG+yfTDCQSd1Lh7@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZsG+yfTDCQSd1Lh7@xsang-OptiPlex-9020>
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 285ea546-f265-451e-8fcc-08dcbfefa190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kwI6jWPTq0ODY9foGuwNdL0vzlfxEYFcgU7F9t0uDfVyPI+DT6y0qltXzKqu?=
 =?us-ascii?Q?rKLg+38niLSNfu4QKFZdnDVajgpitquxLDn7kRdKgMW65LGy/WE3aQEe/ILi?=
 =?us-ascii?Q?lFHdABqdZTFXyRo2vNRhpcU+rYWLPl5ajsa2snAhQV/GID2qloPbgYVIK0eV?=
 =?us-ascii?Q?mkcaGS5QN0jtA46D/rAt2GiK0sJ1/GS4jrJKEBoCol3cBNol/CS3/5DS7QTe?=
 =?us-ascii?Q?K7awLio+R5tCeD+E99IyHzYW5vWLggVFXbD4stkBiCG7YnKDOuVIeoJwTdwn?=
 =?us-ascii?Q?36fRQX3y/I8MZG8ENQO6/HnJAN9tsTSs811yjuk7i521T2hrVNooXnpYPcAC?=
 =?us-ascii?Q?CHg0qy19LTi7dqGWYw+bS3t94ZfM/Uk8vZG7GcadVn7UEHd07UzSa6Awie7j?=
 =?us-ascii?Q?PH05ix1ELEKvqBljolHu3LjJ3FQ+V+QJktSbms5i0zG+owH+y8WmFRMlgyhe?=
 =?us-ascii?Q?pV3REKf1m1e8AFyzLmTm+npoJGWji7SO8QH+Nc5QH9JgI6uJqL4rB/v6HCdp?=
 =?us-ascii?Q?WPc4u9ldRhBK8qClxPtkzIMz1dpyw0O+gBaIHtGvAPGAq8gzrKvgQBRcmFFl?=
 =?us-ascii?Q?dNLDo0/l4Vq3nDZtCmo5eiWO1jApwpAnabEjtkgvz6Qic1C3z6obrNtrRZ6F?=
 =?us-ascii?Q?cq7clCFDCQlymgZ1icDM1cMn7eJIPpqGqpMkW8ac4KFTd46MR10iNO36dNoI?=
 =?us-ascii?Q?8tjgnwA7vrGXF0QMOr61y3B7ByU94JtWe/Qi1Dov+g6yJ+OhsRf+7FrjluvS?=
 =?us-ascii?Q?zjk1j1KlWwdW5mZx48xfvEBom/6KV1tPbWxcChXLJg6zOE67x8GOhtJYRSnX?=
 =?us-ascii?Q?YUy1KwJXcfGmG2oCnsei15x2fcTjaUKid5xeQeekeH2KEHGyGHQ8g823+wEW?=
 =?us-ascii?Q?K6D/6ZRgk5GP+8w7EaVRKwCMbikzBQSRAy2JkvvIxWpj1Qh1a/MlCCmXSglA?=
 =?us-ascii?Q?miBNxlgyjCq05rVJEfmxk+UxJTebHko1AXBBBWRx6xLsZdEgb8PdrEfbHnVq?=
 =?us-ascii?Q?1awJELux7KBqLdpW2FVQI5kLEL9C20KhRjU8EaqyDCTznVn/RJy4RTiYHvJe?=
 =?us-ascii?Q?y6QIs2/itMqdKDt3+b6DOkZeYVRpPQZvp3FafT39mUdL7Q7Bw0tiNvE+pr9F?=
 =?us-ascii?Q?fvncfRSgCcn4CvxsW3IYLlXg6yHL5Kaq7AJ7Siw7n5a/3X/ChPoV76ESxo4t?=
 =?us-ascii?Q?MrgNVxEHGnkX4RM4wyfyGeRZiyTQ3OQcxTcwVtkNoa1zNmGcnn1rcn7Wqlh3?=
 =?us-ascii?Q?Ik8xDIjPKQI2GSs/+59m24yA01XegwLQVsN8M9y/840iL8/m5nEZpN2o7V09?=
 =?us-ascii?Q?kLajScLmU82uT3grW16FEukt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vLGDwFHWSw3ao7cQEWBA6W1ee9gjwkLJLFyAYoXuHEibdsIO9yLYEQB2t83m?=
 =?us-ascii?Q?M6nQt9skmjScea6Q/9e8Qz0/nMebv8fKjvn7IOzxS5VMLpHzam/JMn9Dqym1?=
 =?us-ascii?Q?8T5iOOTFAjPRMKsy5Y1ffeiQuDeIcArxDEL/iFt30ItIvwgJuI0uxsGXTjU3?=
 =?us-ascii?Q?ow8Z7ufJePE1xeFIFLobAH+Vadm0+fdz3Qbliy2yN9JFATFrTanol3NuXf4q?=
 =?us-ascii?Q?kUj02ZRFN1kAgA2uQ0dwMhC7Fy7boBIUINP7i2gB4gbWZLSTZq6S1JRP3nwr?=
 =?us-ascii?Q?Y8iPMLm4JxJxtdtk284Dr0doNTXFjPAIsFZxOCWBmLWWbb+sfxwy+80mbOut?=
 =?us-ascii?Q?hX7sDc+bvdckVPz89Bsob0VcnHzRehFPdH7uOcna4g80PCOYKyckXelRzgcw?=
 =?us-ascii?Q?Iy6QkdYxheyYCAw7NkTlAyvNSIbWl1lBtUN0xtnj1Y5/axiXSrq3Fpvlm5Ln?=
 =?us-ascii?Q?KcX+yOlrkeujuA9xMWlYC7Rp9pMekmT7S14pX9ItrHKQU3fBbzTIp2LTpX5A?=
 =?us-ascii?Q?T2qSTQ+GPS0q3L7tbz1Yn9uldSDkCCokeyWBW8yl6zMh8/ZzTCZcSCP9L014?=
 =?us-ascii?Q?LvrektR+ppcwhlwu/iUV3CXN/DtH2N795NsT40T/mTC76XlA1D6UC7G6CvBU?=
 =?us-ascii?Q?ZITMW11qEpXAP0oy59JxDj5ansHu6gqs/IsnXYGPA3AE8Rk7cbLFjuqyMXwM?=
 =?us-ascii?Q?gKTOIl+8wdYBOQBPkAUCtd6cQ/TsEP7AxtkSRQrE1OwGg5nJ6k1M8ZYzTJsf?=
 =?us-ascii?Q?+1iOaneqRjMsovFw/XxRpp+xR6LuU194b1HygWLnj7Y1eG+IyYxDiGtxTt0A?=
 =?us-ascii?Q?30BJ+OU8tzS0UwvWAQsjhEw9oVkuH9hua+BvjdjlvksTpvV1eB8VG7N0dQI8?=
 =?us-ascii?Q?s5qfsl/TU4ex8Qqs3UcRF5k5xSDRUEoUU6z+/YlelLdVOPkTlpwP8yjqEhjf?=
 =?us-ascii?Q?XZ4cl7eNABL+Vx4i1+4ohR4yq4+nQ9wQmpGdjF5d8sfBVbX2JRb5KLtEoR0+?=
 =?us-ascii?Q?qjjHJZCuxVArkPiotgES2JcJtudTgXs4AIAqSEkvvS8spDAM2+4H8eXSF4dn?=
 =?us-ascii?Q?Jqdctqa9RIk+C8AfXtSeTrhISYJpaAF7Rb0j4fm0DozpwEqs70vYqO7JWete?=
 =?us-ascii?Q?3V6DCVOhUeBdwgCWBjJksCStZSkuyi2OoAxAWq5jScFNOIJ+jRKOq4xr0YIY?=
 =?us-ascii?Q?Ich5MjRWa3tRkPjyI2ciDIT7CF4LzIFwC4jey1KifHA+vm1zWPnP0q6FqCVy?=
 =?us-ascii?Q?TL9ZBBW5hbZkxx9DegdqiRJkwpjZj3QlP5m+IR1l6DX8ICTT+R98GBSf/NmU?=
 =?us-ascii?Q?aFbktcmxKbj2UAp2hVktFgVcbtKkV9ZgNmvsgKyQ1TolTznf9EE1aTuwSCTj?=
 =?us-ascii?Q?IHWSX3qSVfEzm3mMCjiZGvAGsHzWZrmIQNqgsn0bj6skIfP7k+M3xcbSmgj5?=
 =?us-ascii?Q?9378FUMXhhA6zj+0eNxYIt79ZKtgNKuArSseLZUVE/YDbymPRaIM9gfYPmy6?=
 =?us-ascii?Q?xcj8spQ0w3V60ezxa0JVfiR7J9FTrhJpMFH+JoRig3LjAmUc7+gGEXLYvVoq?=
 =?us-ascii?Q?ytilKVpWMSophrwRNRQtGYMA4PdKrIU7XTk+p6FB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 285ea546-f265-451e-8fcc-08dcbfefa190
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 01:38:31.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TfRC66JOlo2MmR2hxVwSO6qMeNM580eECR3OvgvT5dSxJHWlBkj12bIN+dn0IYGBgdABbs3StnCglre7k7nbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com

hi, Jeff,

On Sun, Aug 18, 2024 at 05:28:41PM +0800, Oliver Sang wrote:
> hi, Jeff,
> 
> On Thu, Aug 15, 2024 at 07:58:57PM -0700, Jeff Xu wrote:
> > Hi Oliver
> 
> [...]
> 
> > > could you exlictly point to two commit-id?
> > sure
> > 
> > this patch
> > 8be7258a: mseal: add mseal syscall
> > ff388fe5c: mseal: wire up mseal syscall
> 
> I failed to apply this patch set to "8be7258a: mseal: add mseal syscall"

look your patch set again
[PATCH v1 1/2] mseal:selftest mremap across VMA boundaries
just for kselftests

and I can apply
[PATCH v1 2/2] mseal: refactor mremap to remove can_modify_mm
upon "8be7258a: mseal: add mseal syscall" cleanly

so I will start test for this [PATCH v1 2/2]

BTW, I will firstly use our default setting - "60s testtime; reboot between each
run; run 10 times", since we've already have the data for 8be7258a and ff388fe5c
then we could give you an update kind of quickly.

as some private mail discussed, you want some special run method, could you
elaborate them here? thanks


> 
> to avoid the impact of other changes, better to apply the patch upon 8be7258a
> directly.
> 
> if you prefer other base for this patch, please let us know. then we will
> supply the results for 4 commits in fact:
> 
> this patch
> the base of this patch
> 8be7258a: mseal: add mseal syscall
> ff388fe5c: mseal: wire up mseal syscall
> 
> > 
> > > >
> > > > Thank you for your time and assistance in helping me on understanding
> > > > this issue.
> > >
> > > due to resource constraint, please expect that we need several days to finish
> > > this test request.
> > No problem.
> > 
> > Thanks for your help!
> > -Jeff
> > 
> > > >
> > > > Best regards,
> > > > -Jeff
> > > >
> > > > > -Jeff
> > > > >
> > > > > > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.com/
> > > > > > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> > > > > >
> > > > > >
> > > > > > Jeff Xu (2):
> > > > > >   mseal:selftest mremap across VMA boundaries.
> > > > > >   mseal: refactor mremap to remove can_modify_mm
> > > > > >
> > > > > >  mm/internal.h                           |  24 ++
> > > > > >  mm/mremap.c                             |  77 +++----
> > > > > >  mm/mseal.c                              |  17 --
> > > > > >  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
> > > > > >  4 files changed, 353 insertions(+), 58 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.46.0.76.ge559c4bf1a-goog
> > > > > >

