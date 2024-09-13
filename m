Return-Path: <linux-kselftest+bounces-17938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC2977F3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 14:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72341F2210E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233F51D88D0;
	Fri, 13 Sep 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OdB3+4tF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999FB1C2DB8
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229237; cv=fail; b=HrVjfvuDBAp6cTT6iGPsRQ3b1PedI7HeDSEhN24IPBiRYpWpKWQvWaYpg7/C9fw5DuAtoCVClg00vBBD7ssRjMgPHDDfTFL6HQCEXv+7GZ0q2WtMBWYMWw8rC+F6eDC4ghBAHVvj0mtG/Suq8PqWq0T76eOgl5zpGVF+W92Qv+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229237; c=relaxed/simple;
	bh=XeN62jmbq6BGSQ0Srqb5JRCA5l4PMLk7KwWQ5jU2cGw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JMyZkem8GNHIHmOVZsbX7FBf4RP+gV5ePnEa09E6HxEIJ3/7yfrVtmITjB5Rp8wlFiKWYS+VAY69bcKWGFqfe4NwmmHs0KKyFBfKvHEiDlJiFlTdgquiRbTU2hyxh5rw7XVHSo6gMXPZwAah3Mbx/fVPwzCOPmfOFsespUS8rJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OdB3+4tF; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726229235; x=1757765235;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XeN62jmbq6BGSQ0Srqb5JRCA5l4PMLk7KwWQ5jU2cGw=;
  b=OdB3+4tFVX3mZE+WpxzdE0GAquhYfdtDIDSKLQSUcCDFURLHb/wOOt3z
   PgTabzmUoPyaI9e8HPo37RDvwhX3hWlU/3gqe0vpRMHeeca3/y/EzHhFc
   9fgOWERaEDqo7BoOJIOtiIXyV/hMg9dZSycbDkiHNxOjCyw/oKhRlCSTu
   ZAubXm73jWRDjCun1s3JKSWtnTU4UAQQhAJ7m1v4DqeX8UihO8xcnZ2wy
   HV1L7PfAggoIZ0RuQWijiMLFBUiaFLrZNp3GBlL6Ppex4S/83ZtUQ12pd
   azLlClQFtfWfql9q+MU2VEGmVXus40JVBEy8EtiKgwIppfcqpwB88cqwA
   A==;
X-CSE-ConnectionGUID: rc2B9BiXRm+qgA6/O+3DTw==
X-CSE-MsgGUID: 0JWnl8C2Sfm3R0ddjvc6aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35793022"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35793022"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 05:07:15 -0700
X-CSE-ConnectionGUID: pF7zTFXARaejoCavxHoLZg==
X-CSE-MsgGUID: ts36AAFBSaSwuIHhMenR/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68805030"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2024 05:07:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 13 Sep 2024 05:07:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 13 Sep 2024 05:07:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 13 Sep 2024 05:07:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRFFENbctFZf4ZQys5nPCAT0eCMg8GFt/t9zXRCRQ+0pgEH1ixbaldfAjpHmNIhABOXIBjGjdmGhBsfhChhF0M9Tv7sfbqJwFhBFZ0uT6hnEL6tcTsZaeB6P/EdtSwodLY8VB4z0rTk8qB1j5WUKp02VIjrr2fqIRT+q2knZR+PpXUGF5UJ8TzCkZ3f1D00AWUflr+vL6mI6DihleduOMU2qhRo7F8KO7Zw0xTiG+M1x6+0cN/lLGSq2wc6ItLQV7xpqxBY0VwCb0htz+V18js4dh6gaB9TKPz7UARkO+jNIJieN+qtO4ZqoeEbkBS5yLQtmuP0DmqqgQm2hE7U2mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dkqxPGJFTOK4Ma+YvFSUPnEbOCIXHPi7A7Wpf5O83w=;
 b=nFfhXhZHKv6GQUO67MOR8rLtK6I16lh/py3yzOBBdq3Q90F7HXC+v0N+hgkW9NsngPBquk8nOcZP9nuhUxmzHLv+Aca1aXSSfaEx3h70+s3CxaT/YH3CHwg62Cqlo4aDxPkbH6jQZsOAShlExpkRMzGCSc7LAc2z2Qrc1LLzZyD1gNt1JWrvc1wAvq2etjDMIP21+YIbTu/wb3JIkZHydLtemZvEIIvSmrPpGmkgIQFKdleinUdmMN5PynnKn6wpccQll/1I39C6zYpWVVYOLWvGZbdk3OXHk/QOc11ZTlVwevfMgQKTHfqGtHSbWcgMJu7ervcqc3RO1He1a6MmkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4653.namprd11.prod.outlook.com (2603:10b6:806:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 12:07:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 12:07:10 +0000
Message-ID: <4c49e680-1d4c-4fde-b199-a2b2ebe46573@intel.com>
Date: Fri, 13 Sep 2024 20:11:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] iommu/vt-d: Move intel_drain_pasid_prq() into
 intel_pasid_tear_down_entry()
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
	<nicolinc@nvidia.com>, <chao.p.peng@linux.intel.com>,
	<iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
	<linux-kselftest@vger.kernel.org>, <vasant.hegde@amd.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-3-yi.l.liu@intel.com>
 <841a6de1-b7b1-4424-a73a-a7400db33299@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <841a6de1-b7b1-4424-a73a-a7400db33299@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 71076a67-37ca-4081-60a6-08dcd3ec983a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGNVQy96MGk3cFhZa3FPWVlSMnpvNXJXMkVjTFcvWm9PRmlUL3JTem9MQlY5?=
 =?utf-8?B?a1JFeFBFek1aUzl2QVJVNXE3cXZ3aUxlNHNWK3phcFN3ZERkZDZ1dHVsQzdM?=
 =?utf-8?B?TXRpVkJvZkswQXg4MGsxeW9wMzM0VXd6V3JiWGQ2dEM3d1NMV2srbjFKWnUw?=
 =?utf-8?B?MWROL3g2SFZZRUVWRzRTeHhkWndrdHBCZHhtSlRmekFkaEhWT1BlRXl5RFg5?=
 =?utf-8?B?QVI2dm9vZmZhU1laR0xBWDZnYVBtcDVTUHpTM3RuOC9MZC9WVThJdlU0OEk4?=
 =?utf-8?B?Wk5jbnVFM05yK2lIeDNMOFIybm9DTysxdUdtRUYwZ09CMzlNcTJYcEZhdmEv?=
 =?utf-8?B?TkdCbXVjQnovRzIrUWNDWkgxUDAwNWVEMXJzZFZhdmkxVVVBZWxJUjc0VmlG?=
 =?utf-8?B?d2VldTNkS0hJdXI2Z0h0cmpCakUxY3ZUbytVY04xT3hhR054OGFNa1NoTDVS?=
 =?utf-8?B?bUZ5RFBta1NNenZ3WDNCYVRZbE56S1lIMHJHdDNjQ1pFWlNSNXNyOVNNaXRY?=
 =?utf-8?B?NTFoTE5rY1hiVnllM28vaWhKRGJIeHFKK1NLcEF0bVhKaDdZcDI1YnFkUkZq?=
 =?utf-8?B?dkQ1K1hDOVhJMFFJNVJYVmZESzdkVStORUdOamoraWVRdmxyOFpIcndjUHQz?=
 =?utf-8?B?dkl0TkNJdjAxOUhNUmQ1aDhCUGs5R3Z2UUY5ZEZzOS9KeFpXR0t1RU9iTEtK?=
 =?utf-8?B?MGFmclg5YjN6RGFqaGhtV3gxTGFrV1IzYXl4ZFdva0pYSEVIM3NueUVaVXdS?=
 =?utf-8?B?cXhHdndRRGNjTWYxbnJaSVM3QmVRZittKzk5aDg1bkRrRnRNR21GS1Nhdllv?=
 =?utf-8?B?cUQ5VDNTRzgrSzhXT2dlL2FKV0htYytrZG81RXI5NnZ5anRhcWZIc25NeHRH?=
 =?utf-8?B?T2oydzJxQlJyWG5HbXM2bnJESFgvUTZDckd2Nks2M0tZc0J2V0V5TjVFMlVB?=
 =?utf-8?B?RGM4N1FLUE8zMThCaDR2a0JBOENUeVR6RFVpK3Q3T0VXbEFvUEcxZ3g3dHhC?=
 =?utf-8?B?ZDI3clB5VHBocHpXcWUzc1hZREEwODhpUTNlWmxKb3lrTExYdDY5NWdhbFZq?=
 =?utf-8?B?Q3FnS0Y5NTdqZXFmNXhwU01ZY3NtNWJBRGozL0dmSThyNzdEZFQ0TGF0emJ2?=
 =?utf-8?B?d0gxZHo0eXdkckk0NWs1SnQyR0RFOFdySEZPSDY0TXRqYWhJWGVHUW1CaEVj?=
 =?utf-8?B?SnpwTDRtU2cxVTVsb05YcEd2NWFvcm9tYWdERXB0L0ljVzJudTZackthSkFr?=
 =?utf-8?B?MzJuZzZDaDdGM1ZjVVlxSEpsTXQ2SHdMci8xeW10VW9FMHNVRm43bHpoczhR?=
 =?utf-8?B?Z0NHbGZTM0o4MkpIT0FhWGtjS0JHTlJrZDZySFA5Tmd5SmkrTGo0QXlPci96?=
 =?utf-8?B?a2pVd0dJMDRvTGtOM0trQm9XNFV3YVllREJBYUNYYjdsSTF3RWZrUU9vVk15?=
 =?utf-8?B?aDdhVkllcDMxdHA4QzMrQ3JKb25udUVmTFQ2WEZhTlFhMXAwdTRBOWFvYW5C?=
 =?utf-8?B?UDBCd2plZzZwT2NKSFdKc1NpakZ3TytlM2NqcERqVitWVHkxZlNDbExpUlhC?=
 =?utf-8?B?ZDhLcUV4QnJoTkRaaFcweVB6QkI5aWN2VnFhd3RvOGZFWXBxdUZKSDIzb1Ja?=
 =?utf-8?B?aFBISnRLK1Y3cjVuakhzUUhzMGQ4SVFPYmtEV21QQXhEdjZ5M1ArYXJlNnV5?=
 =?utf-8?B?b200UVhtUGN5VVB6WkhOdk1pYm43aTNLaVZadzdhckd3QlRkejlOdDk3RXg1?=
 =?utf-8?B?K0ZUTmdrUUc4cXZjSm9TcWdxMG1GSy93bXhvZFdlcnNGaEt0dFVDbEN5blRq?=
 =?utf-8?B?VDJCNmdkYW95bEFFbWVldz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2E5UzVlSjlyM3RkNVg2VmtNVUpkOTl5OVk3OU96K3lOTjVWb1g2SWFiK0E5?=
 =?utf-8?B?QlM4bkl3c1JnRkFsSE50SGg2ZnE0Z1pkVVFRUHpvRFhOU09heCs1d2E1QllD?=
 =?utf-8?B?SXVtTVQwUXFPWHN5NGZIR29KVnl2dGpXZ0xrNWxXL0VnVFoweVNkMTN6V3dZ?=
 =?utf-8?B?bjFWOTA5Nk1hM0l3eE50WURiSU1lZlFjTWtJWm00dzRLWHcrMmhWdlRnc1dx?=
 =?utf-8?B?ZEorY1I4cVFRYU1MRVFUYlU4OGpXdmdvWkJXWlRNMDQrNDNCQmdDQUJoT3M1?=
 =?utf-8?B?YXpJSC9IWU5YaHJ0bHYzN3gvMmRSMVVsMzIwU0R3K1UvK0NWd085MmN6SDZm?=
 =?utf-8?B?am5oU2ZQZE1pZFJlRk5FRnFxN3ZPeWhKMWx2bndtVkUzYkNKQ1I0WEZycjhI?=
 =?utf-8?B?NDk4UmlnRk52WXdsb1d0M2x6WkhWZUo4QS9xNGt1VVFQWjNOb2N3VGcyV0Ur?=
 =?utf-8?B?aVQ0WGZzdTd3Z3lyMnpBWmVkcDJpc1E2eVVKWDFhNWJWU0NhYlE0WTdUSHRQ?=
 =?utf-8?B?S0pzMWNmek1NQWFMK29MbGdoblZ1YkdqU2tjaEE1U3pUYy9scENiZUJyZko3?=
 =?utf-8?B?bHpobmMvMkNEdkhzclZza29SNkZiVlJMSUhzbG02MnM2eXRYYTJXcjlTUVBl?=
 =?utf-8?B?UERXSWtOWFVrYmhKLy8vTWNpTXJwWTEvdXlMUGxhcmVDRnJxeTROTlUvcG5j?=
 =?utf-8?B?MVFta21VbFdCRDB5eWtRZTY5a3BjQWkvSlNMTjZock95OHltbWZObERmZDI5?=
 =?utf-8?B?VHR2VG1DSkNSVmVjcElVdjgvd0RnRlZva3Jid3JCWnQvVXIrNlJUTFQ5WG5I?=
 =?utf-8?B?bGcweVFGazhTOTNGUTNOZXJQU2grQ25Lb09kSk1YSHRYUDR5WGFhNktyeWdv?=
 =?utf-8?B?cDMvRFQ5UWlQOEdyaXNIb1RqVVZYdHRaWVVCaEZ4N040ck5mVkRYQ2VMNmhW?=
 =?utf-8?B?MkYrUnFaelBscUpyWVFzNitBUlNTVldTNmc0ejRQTmNPUmNMV3hDWlFQdDJl?=
 =?utf-8?B?TTdoMnRxaW9XMkdDR3hmaWxuMzlBS0RiM3ZGeE1mbUdiTzRvaEJncGNtWTBu?=
 =?utf-8?B?dEdnNTVoODVRSW1WV09rbXVpb1lxdjRmb2k0YnYvTzV6dGd2Z2tpTHh4NlF6?=
 =?utf-8?B?THpCdHZzQVR0aXFKeHhmTXU1VndFSnRxOGlBU2dZN200Uk9pQVlSUFNabzBa?=
 =?utf-8?B?biszZTRwSzZCUUlxTldtVVp3bXF0aGNiVUJQVTZpTkZCUmdHcVFzdFN0WnRB?=
 =?utf-8?B?R2JZZUcyMkY5LzhGTHNaWDlIc2Y5dm9ISTdRdjRLUUY5WGtZZjhpTDc4T2lY?=
 =?utf-8?B?aFh3YUM5bkE4bGhUYnBqSDViUEhNQVFKczlDTW9VbGtKbTdMbXY5WnE3UzVL?=
 =?utf-8?B?N0NlKzlvUVFaS1g0TjZaMzJ4TXdrMm05VE93Skp5UmFxSU1KWVpNaWFqZHFI?=
 =?utf-8?B?T29xM1Y5ZkhKUXVESytacjVUUWdScVdxb0MxSXppdFFUSW9JeXU0TDJNZFlJ?=
 =?utf-8?B?ZlF4LzUweTRXZUh6aXJjRzNZQUc1a1BZdFB6TTBpTGo4OHYyU0lsSExPdlR5?=
 =?utf-8?B?dHhzbTR3NytPdkJ0dEJiYUpYdS8xamVyRzVPdW1uN1dZeFZ2M0VmaGlIeFZW?=
 =?utf-8?B?Z1dpV3o2MTBCWFhka3YzSDc3OVVOaXQzZi9sV1ZvUFZRSmdsSGNuWDh3ZEJL?=
 =?utf-8?B?eUdnSncxQldMMWRYc2pCOTZIalFpTGxpUzM5SmFJa3UyQ2RsSEg1K0VJZmw4?=
 =?utf-8?B?RnpDUUo5M0o5aDZPVHcvYlk1UzF5MUxSeVNGb2x4QXJ3K1BHdUpiTjczMFZ3?=
 =?utf-8?B?NzJocktZVUlvUTA4a3hnc1pXb1ZsaHBvbHdBNUVxb1ZwR1RRQk10QzZBbUZt?=
 =?utf-8?B?cjEyWWJEM0FUK3VLZ1FLdSswT3M0OXhMbHp3TkRnVEduOEY1YXRVL3Fva0RZ?=
 =?utf-8?B?K2VtdHg2U2E5Q1hTbWJyL2FDcHZGNXBjSG1NMnlydzZpYkhFRjkxRGRpMGNP?=
 =?utf-8?B?TnJtc1ZObWRwczVWTktCWmhaWm5FVlNqYVpNVzlmVVVFaEJwTkNGS2pDMlN6?=
 =?utf-8?B?VWlhL1RuZkxLRWVLenQwUWIwRUR4MUV5dEprZnA1STdhSGVaUEdMUmZqbEI3?=
 =?utf-8?Q?yD+6tw6UG7MEr9o9hOlwsBHM+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71076a67-37ca-4081-60a6-08dcd3ec983a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 12:07:10.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzzIsjW7w1yL5W3/P9Xlyx2WEAaXUJsYhcEtXFozmCWS0oUR5NCrmEkie/MF9bDIiADS1DH1PlqJIudYgiWEhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4653
X-OriginatorOrg: intel.com

On 2024/9/13 10:11, Baolu Lu wrote:
> On 9/12/24 9:04 PM, Yi Liu wrote:
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index b51fc268dc84..ceb9c5274a39 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -236,8 +236,13 @@ devtlb_invalidation_with_pasid(struct intel_iommu 
>> *iommu,
>>           qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 
>> - VTD_PAGE_SHIFT);
>>   }
>> +/*
>> + * Not all PASID entry destroy requires PRQ drain as it can be handled in
>> + * the remove_dev_pasid path. Caller should be clear about it and set the
>> + * @flags properly.
>> + */
>>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct 
>> device *dev,
>> -                 u32 pasid, bool fault_ignore)
>> +                 u32 pasid, u32 flags)
> 
> As a generic opt-in bit flags, why not using 'unsigned int'?

aha, I can use 'unsigned int'.

-- 
Regards,
Yi Liu

