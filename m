Return-Path: <linux-kselftest+bounces-12850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF4191A30A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E571F2361E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C328E13AD09;
	Thu, 27 Jun 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ylz/Bij7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CF7D3E3;
	Thu, 27 Jun 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481911; cv=fail; b=RAkT8PxYe2YZ2IRTy4L6LlYbCMwGEUe7MyBMcKL6rR/M3fmd2nFRIN0ivfeOMB5TjIxfmI5Vfz5MKB1PdcUCSmvTMzfP2FfJawGL/4ELwcgwFiODPVCtzV2zFxR+WMQBc/hAtocvQlrb5uJ9NPW5T25/n5+dl3YSq4Qbq/fz2zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481911; c=relaxed/simple;
	bh=B9GbTfwhxWlarNIEhZVom+9Qwsu3Xx9dXeTlxmox1Jw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J4NUHeexqM0LHh7xPT02vL6uUJ+ibdmI7gbt3TXFguv741STBL7BuJT1Sj/pS0kpJ0km8NykahmxKi/dJlrVuV6cejaZ/Fa1ZJFtyoufoPk9Gqfh1POu8HcwMPSIz7NbZY43A9FtG2Z1YMNPOLuI6Viep2yaM7i8LzR910JnAAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ylz/Bij7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719481910; x=1751017910;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=B9GbTfwhxWlarNIEhZVom+9Qwsu3Xx9dXeTlxmox1Jw=;
  b=Ylz/Bij7+w5SluFEHwdOkn2I8H6I8zPgHyuKz512E+KhWF9FgNbrc9KB
   3X2FuhIryUgyOjVfO3MayELIGWC3nWYzPmn95MyJiIVNS+O00q28mr/Yh
   1QsMTG7wmskE5g/fAmyZ9WLJMaHhLzXoOYuHx1CUVg+kUVVSZcL8mYe8H
   5akGGBLo249kWpPalqR0qwnkhQyWveaiGWzyZbFnD9Bj8h8SX6qgj7BEz
   Pz5wp227cOJ7a8q9hRs9tkhrpxtK599OdA+GWpQgdPqBfoE3C0nUkaMd+
   Q5Q/F83BDggLCleY3PS5IN5+QDNrfBXGqa7MC6h6T1LmzxZmNIRfNNJOU
   A==;
X-CSE-ConnectionGUID: NE88udwvQcanFiEShFMDNw==
X-CSE-MsgGUID: dPtfpbKhT/CpIgTyOAJgPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16744512"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="16744512"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:51:49 -0700
X-CSE-ConnectionGUID: p0m3mkcnSOyhiWHjx8sAjg==
X-CSE-MsgGUID: iDKf2zLWS1iTLjywk7IxLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="48927049"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 02:51:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 02:51:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 02:51:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 02:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5mF8d9w4kIn4xyD0iEaYy85WGRXH3d2TqTBWJZLov7zzoDqxbfW4Xh0AFYp++y8zmER8M0VbaKC+UA02XScHynxEwNWuu8jn1GsqZw5T7qPXpSG14QbdDdZEexcZ5aj14lw3zWh05GbglAqZyBiAZRtxwZAiGw2l1eVg9KTUX4LYG8OaprJaronnrlV343x9J6RfQY/Zy2eRmG7m6exf9dRg9syqsRFjb0bl2lHKFSOyqs8cOCEsE2Fq1p3OBeW3WR3pNAncubr/GsXNawaedlLECt7C2b7gLoecHWQZH3ZOIOk7MxModso5OH8/6dw0bw3DGrEEPd15PK6wnQ09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAfURUop+RO+MePSN7hrgvGjjWpg794ZiticO/dktdA=;
 b=hJVVr6I0ROZey1QJ35Ho9P9hcNq/FNkYik/KCxLgiZoY9uyFgmI9pLyIT6w9lcw3Au/CbX7+yEUn0RJd3juLVVUSCbWmJBGgMigvGprp9FsM29OF5ZnMHT8QEcPaOLnpxy6miWulf5asnDl6r+qoY34TcgoBSUDu/rtun/jjES8OPB3hZPFWYB8Of4M4N7TBrFUh5m3s2BT9DaO36sJzVri9ZZeSp26/chGhLGet5lig0PIYBQxHLJuwflAXIdTKViSKJqYDp4QLKFjwQoUXH3U85lMRPVZS+1+Z6IDdU2ruznwE2kJvSRriIQA9jYjL0PncS6WjaRo/0U7CwEg2Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by DS0PR11MB6398.namprd11.prod.outlook.com (2603:10b6:8:c9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.35; Thu, 27 Jun 2024 09:51:46 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%3]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 09:51:46 +0000
Date: Thu, 27 Jun 2024 11:50:49 +0200
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
Message-ID: <ewkiaarsl4s4aofw2uykhup3eyutnzitlow3muzbaqqf4xp53g@6lgc5o2dkmor>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
 <9b976e89-0320-430f-9f0f-48e25612ec98@intel.com>
 <b5xggwzdvavhqmxpaeisovp3e2xzjjhvkoqcbt6hg3sv3wzh3i@a7qaatwfpbf6>
 <5bd8e17a-5810-49a2-a07b-88c05ca21af7@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bd8e17a-5810-49a2-a07b-88c05ca21af7@intel.com>
X-ClientProxiedBy: DB8PR06CA0036.eurprd06.prod.outlook.com
 (2603:10a6:10:100::49) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|DS0PR11MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b86d586-fb0c-468d-8f5b-08dc968ec1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?/0qM1iWF8Yyxu4edRMUyDam8Rb0ny+eS9JKq43rBBq8CRE8ZqyERCuAJfm?=
 =?iso-8859-1?Q?W0CESvzKCq6y0rwGi0RxZgVsPgPnkgYIQoW3w06zghN68bA4zlNx+XQSw1?=
 =?iso-8859-1?Q?XKGlAgJpWZT9eINjTIiA8mRhfT32jZSOLkS7eH763TUSKO9iCpG0wkc3PF?=
 =?iso-8859-1?Q?+8pLNqiTofSnZSBSqmdmYE2XU/YPD3YU3Ad9ETDGFM7I/lxymmhdL/IrZ3?=
 =?iso-8859-1?Q?eBlq2nX2Uu+WOWQpZy03Yynyqh58e5ItmLdCiTBCwUe0GoRaRCs/7AHU7z?=
 =?iso-8859-1?Q?JuhEf8SmPjeCXRHBnbMhBFqNkA3dPBBtDTiAbiKyiAy7jNEAby+rlPNrvC?=
 =?iso-8859-1?Q?4QybdUS2X1owHtuD4oztOa2L5NaJe5KKqhexeZzHMS/FOHAH2adn1n7uEc?=
 =?iso-8859-1?Q?yNDfMNLBd0JYUHYjxjqyJwucVQWndhzUq2CQNxZiPQgwK9uRGFYBEHGnEV?=
 =?iso-8859-1?Q?0+n+T0X6gEc4X6wpgzZCT+KqQQPOCuMDIuigi5+olbq3hrwCTe3M1Q8BvE?=
 =?iso-8859-1?Q?2HS/bSeGMpArKbbThMOZtOsWfcaN+pWPbOEkrSCeY0mWxqxMH01gNDdxe0?=
 =?iso-8859-1?Q?K8YcqaHFd0/pFfUXEg9hhzRmebBf7vEDVRruR6WDlsPF6Qlw0kv9Q9G5my?=
 =?iso-8859-1?Q?LeuYVq1tDJrhcXbougbmGD/eDo9slLgDpDCOZulh//2IF9SJo8pGauX22I?=
 =?iso-8859-1?Q?a2kNq7Pvgk+rfVXXKKNExMbRNdRYYcPLt4pDJNJ8wCr7j1nIbyDE+uvign?=
 =?iso-8859-1?Q?Ge021Q7dHDzVVQK1oK/f7GgroX4719dZbkk0EFDIRjD/07Mw5nSRPprW1I?=
 =?iso-8859-1?Q?jmpbgCB9yTYajdE20iP5HjWsX8j2xyp9ZyevTN57wsYae8QccZzrvmUagg?=
 =?iso-8859-1?Q?XofjJcT0N5J1l5+HotsZQyALzT0MhAPlcHyoChF0fC2139lpYFKLjC45LU?=
 =?iso-8859-1?Q?xA9hpwIYhg6Todpn6ABCQAkt311lasasKxMKCKV90bHiaaYkJUztcRyLjD?=
 =?iso-8859-1?Q?x5WA2F7e36u5fGp+wKeYXVbaEwfHxFImGw/2IeXTZdGCQZnDht8nTFfz96?=
 =?iso-8859-1?Q?63+L90SqFeJkqFdRW0JnIsWhH7rsFW5v3rffHHCr9SsuAiwJ0GQ6nZhJ09?=
 =?iso-8859-1?Q?JA4exiS06gdUhtsiRP501tmEcFe0OnHZRGZxKpE3lF1nGA9ftk2bo1W10n?=
 =?iso-8859-1?Q?pXEQMdsNWBblG42CJyq0nJk/EOoQ70HLe1IN/DxYQPpGc6HnfpxMKHFJR8?=
 =?iso-8859-1?Q?jvreXZYv5d1wFk+ITkj0DRon74cr5hkSyMf+mNEplrsYK6JyfaSng4dVJm?=
 =?iso-8859-1?Q?BJuzxtr0kniWV5JM+AIvk6vAF26D66ew+sTKyWZ+GGPk+dw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Gfmuodgr/iyGSi3yk5GMDzulCyPlJI/ZZicY3crZ9w9emwZ2d7JZeEA7om?=
 =?iso-8859-1?Q?tznngylngBF3nDYDEOaZhtXIcBIJzZKQh7gD8AqG6zurBlKHQ6JVEMKDI6?=
 =?iso-8859-1?Q?+zg4sLRi0ouEtAO7hPaXKlNH4gJB/snsG34AAJ5YTw7qA3q6QRUUw8IiJr?=
 =?iso-8859-1?Q?r7UEcUp7b8fLyq98hYewYjSlnQgktoF7yRc6y5VongbgZJSVitIknt7Qu9?=
 =?iso-8859-1?Q?7Jd3+uugRuUX6YUxFSBmBOX8hYB9Pf+wpusVVodsoX46fEsUbknbiTQ/KV?=
 =?iso-8859-1?Q?c5zUmbioBvh3chGAxVQeq0ZdUghRaB4mCAMo2mCr3LfiT0Nws8V7x5b2wB?=
 =?iso-8859-1?Q?7oQGZqhyJqAP0HEEUOLFy56Yrd87xrg4zzrCQllp+qFIKoMrRId+lvpBrc?=
 =?iso-8859-1?Q?2SYqWcYFRD3ZdtuVgVV1Kpjx+snJtpQOcu8cdsLm0veBWu32EuJQDXHqQp?=
 =?iso-8859-1?Q?umuWxziiarMClSjyQnDOTkGV1sFRZkey9HrQLmzHgRieRdpbFKQLuoRokW?=
 =?iso-8859-1?Q?txI91HTjBGuJVHG6/hsmqyW4qWS+HQ/UOZi5c11m7A/IoxpiAwwDqCWiQm?=
 =?iso-8859-1?Q?twR7gAHF8jdqVOKgJ50vdkIIM3jXgA66yaJCxW77yOWDARLmrWHolXtdkx?=
 =?iso-8859-1?Q?vTUbcLIn49iYzx2s/Ri55kHdpjWS3yP837gTcp9o8zKt+4YbIskN3o+D3C?=
 =?iso-8859-1?Q?aAXKEKMpChhpdp8u91Bjw2Myjbx6jjRuc72sEo1TpJripgiFeBunAJ5uZb?=
 =?iso-8859-1?Q?bo+NPQHL3clF4y0S3QEtmWd3OYzK21msZiTo1DsLZvAzRHhJ0YuJr85y12?=
 =?iso-8859-1?Q?TOk7KTIensDSQut7eLNBYgCECM0jmKOx0AAb4Rb7T6xYrjlpYjcK5TntW+?=
 =?iso-8859-1?Q?SXmNHJ/FHspINnfOe0sAuFHN7QzJwYVCs7bkqbV4fdQjZxvMcksWJXK+8h?=
 =?iso-8859-1?Q?XFVpnlppz3jVmjwKnMnCdfAxVABczhi+xS0x8RtqtEUdTuxzunZqGjf/Qa?=
 =?iso-8859-1?Q?DG+SaLQzGR/DBBr1JQi4aKvv6A0uuIDB7ODjQ3mpYbbPUZaj7mJFCc9w+k?=
 =?iso-8859-1?Q?kGZs+OFI9u3HEOB8JSnovczxl4yYcz/1bQN/rCuP77xNkY7oDBoe3mwrap?=
 =?iso-8859-1?Q?636L6T4gUYqBulwM9z/zHpGAZSqWbjjV7nG+fEwW0PMc+eJAy+d0tfpi01?=
 =?iso-8859-1?Q?YfkyqOg6UQB6VoYKYhDLclpmQ46zCoKd5g7y7XkzyLD3CAZWu+2Iy6VLSf?=
 =?iso-8859-1?Q?CYi5Iy+i9+0Kna1o2vna3x0Q7/Gu56jLnf/K5W6SUV2YdH8zZCQhzVRxmK?=
 =?iso-8859-1?Q?wFyc1ZJlS6z3rJi5+mxKEqdaUXCsMLXzDL5q/2c6M4IshMGbXhy8f3d1c6?=
 =?iso-8859-1?Q?mUZ5k3uBZp15W0LSoNzBexlvlM+I/J0HTffPoOnSdpG2ea4ndKiUGNslM+?=
 =?iso-8859-1?Q?FTiJKF8XdiJAD4BGJEMnMjtpMZ5J0aaRG9jvSHTWKgp5809sNUXL2u8iCC?=
 =?iso-8859-1?Q?9G7sQmvWN2gDsXvFnbMn9ob4xsPhgBHqK8GbC1XUuOCF535H0kZ7tIxf/o?=
 =?iso-8859-1?Q?nmzPCHzSgyphECezZfxF9ALt8YDDnsD7nz3oLaWNKJEO5VHBJURF99OXjI?=
 =?iso-8859-1?Q?n8bd52krB+wDq40uDZ9mdqLwaPVKAw0U0UJA7uG8GEDdrzyoG4/+4PMBmK?=
 =?iso-8859-1?Q?7PJ8eE+IsyBfoNRUDG8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b86d586-fb0c-468d-8f5b-08dc968ec1a9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 09:51:46.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ScIE/j1abGs+8qIcXgS7YYNTJTViROvlNvuhK7+5fN4obqkWWWIC9qiqsPFNUzWOQidrG8KdfnAJ3JtRvJqV1cLOWUSEmZHrvfsmMjPEnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6398
X-OriginatorOrg: intel.com

On 2024-06-26 at 09:46:01 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 6/26/24 12:09 AM, Maciej Wieczor-Retman wrote:
>> Hello!,
>> 
>> On 2024-06-25 at 09:28:55 -0700, Reinette Chatre wrote:
>> > Hi Maciej,
>> > 
>> > On 6/25/24 4:04 AM, Maciej Wieczor-Retman wrote:
>> > > Hello,
>> > > sorry it took me so long to get back to this. I prepared the next version with
>> > > your comments applied and Tony's replies taken into account.
>> > 
>> > Thank you very much for sticking with this.
>> > 
>> > > 
>> > > I wanted to briefly discuss this before posting:
>> > > 
>> > > On 2024-05-30 at 16:07:29 -0700, Reinette Chatre wrote:
>> > > > On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
>> > > > > +		return 1;
>> > > > > +	}
>> > > > > +
>> > > > > +	for (i = 1; i <= MAX_SNC ; i++) {
>> > > > > +		if (i * node_cpus >= cache_cpus)
>> > > > > +			return i;
>> > > > > +	}
>> > > > 
>> > > > This is not obvious to me. From the function comments this seems to address the
>> > > > scenarios when CPUs from other nodes are offline. It is not clear to me how
>> > > > this loop addresses this. For example, let's say there are four SNC nodes
>> > > > associated with a cache and only the node0 CPUs are online. The above would
>> > > > detect this as "1", not "4", if I read this right?
>> > > > 
>> > > > I wonder if it may not be easier to just follow what the kernel does
>> > > > (in the new version).
>> > > > User space can learn the number of online and present CPUs from
>> > > > /sys/devices/system/cpu/online and /sys/devices/system/cpu/present
>> > > > respectively. A simple string compare of the contents can be used to
>> > > > determine if they are identical and a warning can be printed if they are not.
>> > > > With a warning when accurate detection cannot be done the simple
>> > > > check will do.
>> > > > 
>> > > > Could you please add an informational message indicating how many SNC nodes
>> > > > were indeed detected?
>> > > 
>> > > Should the information "how many SNC nodes are detected?" get printed every time
>> > > (by which I mean at the end of CMT and MBM tests) or only when we get the error
>> > > "SNC enabled but kernel doesn't support it" happens? Of course in the first case
>> > > if there is only 1 node detected nothing would be printed to avoid noise.
>> > 
>> > I agree that it is not needed to print something about SNC if it is disabled.
>> > hmmm ... so SNC impacts every test but it is only detected by default during CAT
>> > and CMT test, with MBA and MBM "detection" only triggered if the test fails?
>> 
>> Yes, snc_ways() ran before starting CAT and CMT to adjust cache size variable.
>> And then after CAT,CMT,MBM and MBA if the return value indicated failure.
>> 
>> > 
>> > What if the "SNC detection" is moved to be within run_single_test() but instead of
>> > repeating the detection from scratch every time it rather works like get_vendor()
>> > where the full detection is only done on first attempt? run_single_test() can detect if
>> > SNC is enabled and (if number of SNC nodes > 1) print an informational message
>> > that is inherited by all tests.
>> > Any test that needs to know the number of SNC nodes can continue to use the
>> > same function used for detection (that only does actual detection once).
>> > 
>> > What do you think?
>> 
>> I think running the detection once at the start and then reusing the results is
>> a good idea. You're proposing adding a value (global or passed through all the
>> tests) that would get initialized on the first run_single_test()?
>
>I was thinking about a solution similar to get_vendor() that uses a static local
>variable. A global variable could work also.

Oh yes, static local is good too, I'll try that.

>
>> And then the SNC status (if enabled) + a warning if the detection could be wrong
>> (because of the online/present cpus ratio) would happen before the test runs?
>
>I do not think this was part of previous tests, but yes, this is a concern where
>a warning would be helpful.
>
>> On the warning placement I think it should be moved out of being printed only on
>> failure. I did some experiments using "chcpu" to enable/disable cores and then
>> run selftests. They didn't have any problems succeeding even though SNC
>> detection detected different mode every time (I added a printf() around the line
>
>I am not surprised here since there has not been much tuning of the CAT test.
>
>> that cache size is modified to show what SNC mode is detected). While I
>> understand these tests shouldn't fail since they just use a different portion of
>> the cache I think the user should be informed it's not really NUMA aware if the
>> detection was wrong:
>
>Seems like there are two warnings to consider:
>(a) SNC detection may be wrong.
>(b) If SNC is enabled and kernel does not support SNC then the tests may fail.
>
>For (a) I think that it is possible to know when SNC detection may be wrong. A test
>similar to the kernel test that compares the "online" and "present" CPUs [1] can
>be used. The /sys/devices/system/cpu/online and /sys/devices/system/cpu/present
>files are available for this. A simpler way may be to just print a warning if
>/sys/devices/system/cpu/offline is not empty and set the number of SNC nodes
>to 1. Instead, a new "snc_unreliable" global can be set that can be used
>to print additional information during test failure.

The empty offline file is a cool idea, less files to open :)

>
>I do think that it is fair to print all the SNC details during detection but
>I am concerned that those messages will be out of sight during test failures
>and I thus do think it is useful to have extra information during test
>failure.

Yeah, I've been thinking about what is the best way to display these for a
while. Maybe you're right that messages at the top will be lost. What about this
set of messages:

1. First run of run_single_test()
	1.1. For all tests:
		- detected snc mode (if > 1)
			- check if cpu/offline file is empty, set the global
			  variable and print a message saying snc mode might be
			  wrong

2. At the end of tests
	2.1. For CMT, CAT, MBM, MBA:
		- test failed
		- snc detection reports it's enabled
		- kernel version doesn't support snc

	2.2. Additional message for CMT, CAT (since the cache size is divided):
		- test failed or succeeded
		- snc detection reports the offline file is not empty
		- kernel version supports snc

The 1. message will be printed at the top since it's more informational (what is
the SNC mode?) and then 2. messages will deal with possible issues / failures
and will be nicely visible at the end. What do you think about this?

>
>Reinette
>
>[1] https://lore.kernel.org/lkml/20240621223859.43471-18-tony.luck@intel.com/

-- 
Kind regards
Maciej Wieczór-Retman

