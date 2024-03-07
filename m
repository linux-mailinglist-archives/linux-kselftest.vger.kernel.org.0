Return-Path: <linux-kselftest+bounces-6056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D85875503
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFFAFB21C23
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36388130AD1;
	Thu,  7 Mar 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JF+cdXJt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCC91EB41;
	Thu,  7 Mar 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831924; cv=fail; b=URXMg8uN2cfDVb1Jf53ZfURsXfOp52xKGdemde4fDFj+nshrEK5qCHqfqa+my6n8MKv30AT9qjmhBYwdvw86Y4HIEC6788ukzLM44h1nr2kU63AlCN9CvANouQ5/RygJelTlZG1iHu437u69pnJSHm956iG8hECawSQDlqmbWSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831924; c=relaxed/simple;
	bh=Uoaq/sM5aa1Nou0lTfBhtc50yqkNcA4y2ePlQinqe+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FaOo4CSn1QslX6naHy29JCg5Y6zUsDM794gUAmwv4ptlpGAReiTzvN4B9oUwNdsUTOs9j3fA441/ST5CBsVPpUuO+njCQwoZ1g5OowzYvPlWC5plyeKuYnQnreTyKzOXSpbukQPMy9DUfA56+2IVk+KCtR3vyi/ur/OfgqLNq3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JF+cdXJt; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709831922; x=1741367922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uoaq/sM5aa1Nou0lTfBhtc50yqkNcA4y2ePlQinqe+E=;
  b=JF+cdXJtWyiXknUx2yi+MoHyldtY/xDjk6efj7m+wbcDfQDM7+2InZhy
   LSb1NVbDEucLZ2JigloA9Pul5jR5aZ2qv/bTkKvsBhG+qmNWqP9qfSIF2
   t2nl8lveeqoyAtLaN0te27WtfVjgY+OO9ZsXCk6SRAe7MFgLc4+iLjBKb
   PJDjty5D9mqw8JChtJoZsULQiZHDv3j4av8dmhoNu07XPR0T98ZR+DM7S
   3AQgqSUKZzNEXKqrcWfYT8A75qxFd6FqGNuxUr0C1dmVQdPvn79P7+gq0
   E1zQXn5h3UCnxqy+4+c84PagqY/83NLGH60Pj+FRK1wZWrjameLfD8klV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4384585"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="4384585"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:18:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="14739471"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 09:18:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:18:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 09:18:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 09:18:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:18:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy+dNBR6qJY+0VIJGC91JD1ljfiSZkwmVd4OJr1fJFvee5grZoIZMrh3Bz4QnMh640EgsldGURg0rtOc44aekBabj7Y+S9Sq+2qg5b9VES3Jmpo+YQx+YId4Z3g6BFPC3Y7IGNvrx/9z7h9x/47Kl00YnqhuYTto5tsLg+xAyt4N1e7lVzJ7No//QM51hI+kK/txMk67Cmb3ANnDIEUMioufcJYRPe9FvWecKAbynuzyAP2cKRGgLWA1jNIIqvymKu7wb97AUheIHqYjsUdqbQB5lxYm6xWVKpKWPJPNLkDMin4GHXyJPS/wyV4T/hdwyiBcA3wQ1oogatjHB85KvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uoaq/sM5aa1Nou0lTfBhtc50yqkNcA4y2ePlQinqe+E=;
 b=mCBcZkf0EkhYxkSDHSa/Inm63KbEA4BkW+DBX4JqXSyP9+UOEgUK8ro64suTvT+J88Q9Mc1HzaDiPzV5vgDJWCRR/JPlzlpP4dn0vLhjWUYeBh3qvjM9S9sOCw5NZsnPx7mJ8NqbnGgSuQtQu1/HU8KyHTvKiouaft4OSp9CpVZWJ3iqgiVtJ50lX+MhuqhFg+x0L4O0GngaVPMpLGCMcXHEzs2kcP298vKsJV/sLqG2x8QnlVg6hbcPbmwHlKxAlFhtZ4z5vjWoYwzEg0VmiCAyuFAIN6NwpkvasWGcae374FdiKfgsNB6bH2ltKdjoRFcLYYd2ghB2W/xQm8Qxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5074.namprd11.prod.outlook.com (2603:10b6:303:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Thu, 7 Mar
 2024 17:18:11 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 17:18:11 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Topic: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Thread-Index: AQHab7KwshA04b3b7kGAda4tCZ9C1LErPGXQgADHEoCAAIKhUA==
Date: Thu, 7 Mar 2024 17:18:11 +0000
Message-ID: <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
In-Reply-To: <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5074:EE_
x-ms-office365-filtering-correlation-id: 2be4c95c-0a24-4b7d-f075-08dc3eca90a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +4ucbxz9v7TKTa0uTEKDXYNZRfSGp9sKrcZuaBVyNT7QbDd7ZR71kdE5JkGjnqyW8pqvDRjz7WxQ+z3jPz9Vem7bnfDa44mBcM8vDrR22GVtgfUHlfYMloOmNXnxfMo5PHo+Q1oGXqeePP5qQLSGjy0v0vaGomeMCBOia3Uz/Xvoe0Q5cPbuu+Iyzw0L1MkB4b+ooUM8qamYvx4xwV3jaPg3cdo1Olu4tj6EuqwxuXyH3qCe+sJl0JLZ9aUWd7vhZIrzrGEg8B0BzazwpkmNHG0PnzwXH12uX6PGB9V7t6XpahKLYMICy9U1ZAPugrojGwJAu/ii1NeGF0BgZtePLw8vdQubNJYyJ/LwWxJrjJSm8ghDF3us1Eb1zxxbtiAW8XaLStBLosUhGSrbHyYeM8gx5u5Ey3jsp97iIo3PfE55P7AShVwWc4Xqd9UoX3QMQIUtkDHY5QIPPjByXQdsFUrdbpGbQBDsig5oEqityMdHn6UAnxYM11iDVDuZLfycd0ZXyGxnctQ4g2sWQaUiUc8cGJSKXrxWe1JB4KajmT3yIPGx6W5gx+eSYVsNbI1pBUI99dJyT4O+m/fO+4e+1KyDaBbvGtDIaADbzxNSFffYIaae1GrUdgcL7Mjmjfs1URKQSqB0kxBDgl/whJiH69grOzvakesPO3WXF0xPsnttPE51W/fsyYw/UQ5NC9UO2TqUgJS/y50oNJB9f3LiFemd6/Jj3A+MOTwlKi/H67U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WcfkDWFJZMm3ZdyhEfkQBLdlGELz1y1WgBddEBmcsnmOxv1FxJfXG1zdSUPc?=
 =?us-ascii?Q?4bsoyuJQfzWntR9X+oIGOXpzGmCfkPMgoj8HzG6+WEhFAoYFOOFCFY1zwRd/?=
 =?us-ascii?Q?gCjOdSU1z0J3zIPDRacSKE5U43+rdhh7n2oUnb5tOU359je+W/jOOgETxsxp?=
 =?us-ascii?Q?oMw4uFzXZmlAW15BQJRv3EJbGySVHBKnEm9N9pDmcmd8DnhR7GLgSpBECA4e?=
 =?us-ascii?Q?6tEQFIt9lg8IDMKVz6qrsOgWeJLg9bu3fDkvbJIXLcm5CAy3DRAg3VZHE/c1?=
 =?us-ascii?Q?eDjbf+/z68Ik+Zvo6BPCWSYiLUN41W/iHlK88UF7eXC3KMzG93uGoDONi3BB?=
 =?us-ascii?Q?L7OxbIDCVlSfWc2wj/Zi152z5Logg+cqr3YJ/CXAJ8mrw8JRpgFfNdXFBhc9?=
 =?us-ascii?Q?70lnds5ahxP0ZMAfbtU5i+zYg37YWBMODrfUsqlOXVZCwYD5Rm1eJ77KJl6E?=
 =?us-ascii?Q?OHUt8bCZwo+eKbcS0pgehrksavx35suEdxV0vAku6mRLbheqYPk8nU2H/kYX?=
 =?us-ascii?Q?Zjixw/QprumLO6us1DSVHj6uUM3TMVI+ipYqy6nHIy78xi65fZsuhSFT4fV6?=
 =?us-ascii?Q?6ih64liYr9T7t6SxOFy2/52xE9uKqHQIhQ9Jf0u3gbnFgeb67AybrutNwGAz?=
 =?us-ascii?Q?wNhP253QoyiHh6prGb1kAtaZUGSLRxz/TXHIEbMwqcfwK+IckXsEQLo+SZZM?=
 =?us-ascii?Q?3iCkNoahNPAa0S/OezX9VOIv3AoqncVt32+Xtux/oSpGINMKH4pSdyEFXnWe?=
 =?us-ascii?Q?SZ77WwpdCiOTUltxSjIr8OWY8niw9h/Q+cT1r0d1GDkJmXIcBvEAvKmkcXTk?=
 =?us-ascii?Q?2v/kwwLVfEmDN7Qgb/+E2xMjkU2zEs0nO4guEFM5s4rRzeFw+3BcZcchD5mr?=
 =?us-ascii?Q?k64SbkPs1Y9OI3Phke9R5r917i4Qe3NCbkJTgRGXlBm7rLpyAYQxrRnJJPD+?=
 =?us-ascii?Q?g8RbShGQgGQ+3ks/uFM1BIpDa/47L3lI00qUJkkg0m2fRurWPbFwmalzbwr4?=
 =?us-ascii?Q?IhC+z3Exao/Yg1iXlURjBboel7pVCNIwbybflniSsmw4+rQ3JIJA6Zj4K6qm?=
 =?us-ascii?Q?SFaO3eZa95o8mVfIBBm27hmYgZ+/qnVWH8GJJ91JI6vj3v9r8sSeLUQLCbXK?=
 =?us-ascii?Q?5rxL0mYB5RZWDFTaYeLSegnt+gKYRUkMF0B3y3zmFKfD671notWtbpEUf3Bz?=
 =?us-ascii?Q?MFBgjHYBXgnV+EAvY2zfHD5S1NklqkwG6bGKe4bwduPA3ClKiwoMvqJrR3On?=
 =?us-ascii?Q?hJH1mUZGkvDzwPuNIuKwgetr+hmik1QcO237R7YpIQTC4w3PgsDL+c/3Zzv8?=
 =?us-ascii?Q?v0fSnGB75Tx5oV8dnTEfw0DhMMosU+AYtFpkve6HOt83h74R65IDabEPu88s?=
 =?us-ascii?Q?lCg0hTjjGkTbNX8A7hUp2oV30YgLcdPAwZvFhByduEGuw8dyUoNC6V+3yn5q?=
 =?us-ascii?Q?AwnZgW7ogDpfwFPJNvsDBs1jlD43aZj3mqwtO2+5QPAbpPpyiluTI1XmxKfU?=
 =?us-ascii?Q?Sk9ADbuDnv5wcoz/C/6oEyI9DYEdkT1RlGW7B23feWdhZLI3QTBVcgMYfFde?=
 =?us-ascii?Q?YfmLxH1t58AyN7ygkRTGXTS+XDVm6cEWOVdEe6hi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be4c95c-0a24-4b7d-f075-08dc3eca90a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 17:18:11.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fFVbu9PjrgUT86KBBF7BBhsE7LfeEi/TyWrUTxkaZJHmc+10HyGh4yku6PLuRfrjkF+HWRdYEHT68426racwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-OriginatorOrg: intel.com

>>If so, what should it be named? "snc_ways" as a kernel variable was
>>later replaced by "snc_nodes_per_l3_cache". Is that a good filename?
>
> "snc_nodes_per_l3_cache" seems okay to me.
>
> And I understand that the file content would show SNC mode and the presen=
ce or
> absence of this file would tell if kernel supports SNC?

Yes. The existence of the file indicates the kernel is SNC aware.

The value read from the file would give the number of nodes per L3 (obvious=
ly :-) )

SNC not supported by this platform or not enabled:

$ cat /sys/fs/resctrl/info/L3_mon/ snc_nodes_per_l3_cache
1

SNC2 enabled:

$ cat /sys/fs/resctrl/info/L3_mon/ snc_nodes_per_l3_cache
2

etc.

-Tony



