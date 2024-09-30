Return-Path: <linux-kselftest+bounces-18570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29223989B43
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B76281CB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6774914E2DF;
	Mon, 30 Sep 2024 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp7aXMok"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C88487AE
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680796; cv=fail; b=rrYAswYY1DaXfMFndhUCepuLpIdw8cPmkoHNJWwTqczjVNhTEAzWVwnDIWKlCg1IxWoQ9+YySlvixfA98gWHk2XOpV1v0nEGbRORdhMohbIsN/5UKpIE1uBI/n9f7usInGZYUZKkuUqyo0rNJc0Ivp3PonNPpWNrSSh9iDiIvrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680796; c=relaxed/simple;
	bh=cKIUbUFMFZbaH9qC2NlaWNUSbRgIkDn0TP5v3KWmfDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJOmfFOqVA/k3ou/w5t8d5e67jNqLIAspM2xErWmGNZVTRFI2sLrufHn45UbGGgop5+i06hJkzJ7t1dQ+QanmpNKyGn+vUcoXUF30HO1BKqe1fYudWWKTP53y8kgIUbVbxVqGHJUuwcGOg+LTMkiha/RWI4fvN3NA03ar5bQt9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp7aXMok; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727680795; x=1759216795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cKIUbUFMFZbaH9qC2NlaWNUSbRgIkDn0TP5v3KWmfDE=;
  b=cp7aXMokCeQ+IXEF04F8bpwSHDcowEIrDObergbzUcmhxwYfTayTgPHV
   5Vyq0C1h91RnxaIpNCChdJvnJf23D81eLE+aew1AkBuEJMr9J4oA3cT+P
   Jdz5OcctpBmpYOYIkeGFmoKIJnk5DTlCa/GPbqtKnJe/s2UHSVF8WETva
   Tby4Z79N5Qe8T0j0vA0jq8HimGnay4+HvjvXVpmVaM5HslLBd18FrbFih
   wHjfTHDrVlz4BI7US4kFm/PgFZ52ttoHFbHKFBKQM3ABIzSWuP5MvtWy1
   0ig2yv8iPse3YOscNC8nCRDyXh/OCgEXmy1eZRxXlIuOgZ22S2CiBYT9Z
   w==;
X-CSE-ConnectionGUID: tL4AVjIyTaW4oj3KRZ7EUw==
X-CSE-MsgGUID: UIFHro0oQneLKGilNEVqwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="38138308"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="38138308"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:19:54 -0700
X-CSE-ConnectionGUID: fdYZLBwPS1SMPOaf2r7EPg==
X-CSE-MsgGUID: zHj1PkWTTcWnwlGc9v7uVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="77601967"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:19:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:19:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:19:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:19:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3CBH1cT/lQqhEckQTyr5JvGX3QO+YDLwTSWyn+IPK4WeCi1NCAKHDSb1B+eny/gb1OKB1rZZ/y/H9VqU3aHa8j+Kv7/bfmvl+AovhyaL0bsPHERuBqX8Y9P7gPa6Dx+R+be8nI+FuLhn+Xt4D7QmR6+HknVEVvKjqZSU389zbivIFcMWHihxaWWJAmopZNWAtBhplwMiWurKUTI5KbR/K5Uc5oT/IDRrprxSuWXVhFqYd4O4ffC/iQC3dnP9D6JE4dXMD5fNL3YzZP8vWi2MwIcWN2i7cMA6uHT/cDkO7WIKK+o7yWt3woza9pQpivMSOmDcx98DNY09T2olBgoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKIUbUFMFZbaH9qC2NlaWNUSbRgIkDn0TP5v3KWmfDE=;
 b=CSAqI8dvIkZCeb2J9RDbOo9iaMgAFDd4cy7IpKhJlWYjVhi/cu59V3epAVcYPMqGVxhtabC3NMM7npV5rXCSHbzN6yzpF0B0Y1XcfnCu2j2akLYYXAwLy1ZcdPAywNJWJ6mdfRrprxvR0yD/c0TPEslM/PE8DZ4WMoEsD5nn9JMwZdFMIP/k4adWdRhGDP6c0mUU+yAYrQt6sevCsp4MCRkBvVkxyHtmkzGvKjNI9HsgOyle7lhQTVy3LB0vOd8pjdJgZ/v5SGidKQfKJAqgqZmIaQaiw0pEs3+rfq5sPn7tGifq6k4NF4oW9URygBhr2xAtAeYeUgBIoiJLG5AsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 07:19:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:19:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: RE: [PATCH v2 4/6] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Thread-Topic: [PATCH v2 4/6] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Thread-Index: AQHbBRRbRIoiTvkSc02Ul0V3i7s5mbJwB/pQ
Date: Mon, 30 Sep 2024 07:19:51 +0000
Message-ID: <BN9PR11MB527664B9758385F2ED075CA38C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
 <20240912130427.10119-5-yi.l.liu@intel.com>
In-Reply-To: <20240912130427.10119-5-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6529:EE_
x-ms-office365-filtering-correlation-id: 686a4720-2405-4e0e-d229-08dce120464a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NLMZp79rldt5cXHHvA4Fo3m/kFq2kJzwYUac4J9MhOK/jGypmyZydhYcolay?=
 =?us-ascii?Q?sciMMSLgxqg/YFGutaea7WMuahlgshwX+2BgKMUqXkGthtQ5W0hlKvUmu5EE?=
 =?us-ascii?Q?2WOR7e4b/SPWnvoJwIFUwTSl9ICwQqE82P3fr7WoK6YCpfSZEdiw2TzJyuer?=
 =?us-ascii?Q?hEj6BgAFuTaPEyhKQYDE7cr0KBcORen/HEiQOHIixOGbNdA5hMPMue7zlbZ0?=
 =?us-ascii?Q?oZbGpwOMlKAljT+UY/iex9sQnZHvhJP7ZYfhND4ucivtKmqYHTs/U3OI45QE?=
 =?us-ascii?Q?B1RROJoB8WtB71/e0ttgpqYQPodxJygjx6JfE6eIZraclaNFnkX8wTTZwRSa?=
 =?us-ascii?Q?2z53BDfJtUguI0yiCTXorYJygDqc8fSq7ES4YnZXd6XNGQE8gP0TGxMQgOCO?=
 =?us-ascii?Q?KqQ0oRfYodIrSS4Gdowpz36AlmT1yUr5C6C6y0Ro6FJtXdOfXTh5KzaDYjhx?=
 =?us-ascii?Q?T5Ic5UCSV0JcIYR7CBBB1NwBciSCbENfv+61UeqT/8sO7RfPqpRSrFTnEsb9?=
 =?us-ascii?Q?NnpGHK+gc0bcP5sGx24uurKCVco7z6pLfpu19x2PsclZqdbsRwjvKMqD4KHH?=
 =?us-ascii?Q?5bR8mwRu6ilrThyP0O9RV+PoofhyW7XY3YERSA1juSU1VglJp4S5lO6WQQo4?=
 =?us-ascii?Q?3AiYqUmzYBfhoPJgSj4v+Yb0FHbHjwk6cKpKpGTs+pTm3xoE7eFi50OmyusQ?=
 =?us-ascii?Q?zQCcJjmGvYSSMSWXXStLbwifv7FdY99n3Oy6qTRUgTUpwujIHBc5g7hAcCJh?=
 =?us-ascii?Q?XUuxB4wNsKgCkI/MEppTENuxvIXhhwO3R680K6fwNPHej6PntdCUkGR6pFR+?=
 =?us-ascii?Q?5G042OF0UAasbGpvPyzGwQmDC6cK2zv3fG787vIc6kV2kwOy9Ne1sfK6Vv/G?=
 =?us-ascii?Q?Fmz3d/lWL3kv475i9x/F2KM99C3lPlSbDx9UEYA0NCD142pdvjtdN+PuQzku?=
 =?us-ascii?Q?7rZZ2f13MsbA7MxJ+6JaaSMISY+ieYfO+NcsEpiR+tFw53tgZd0tav9Pf1em?=
 =?us-ascii?Q?SLYgGmSkkGd0bpX+YTYANundJ+FGMM+Ez2jjyZGGbZIIddRcTJ+vc6s+9Ntl?=
 =?us-ascii?Q?PES8ENQU+XhpVpQEURM5NbkCfvrLN/IbwaN43L4jws4MMTUb6usJ6cqHI9RO?=
 =?us-ascii?Q?92qdsam6UlxGjIwVlljJXyGfjHZidao3D+0o9oobEgTjn8Jdq+hzgHujEd7W?=
 =?us-ascii?Q?CzAl99fdLUVV7Ey465kdmLvkkDPYiWw4pbz1VY/lK1pYwcCLBLe3pDlbroUj?=
 =?us-ascii?Q?AZheajdUAlrtv7np68FvNJINIJWuGUHhRQnl3PtpbQEoP+qRYK/dFqeJOS05?=
 =?us-ascii?Q?WpcIk9MUkAk+NOmtT7Od2f7gbu9C6ugNOlvcylrkRtCBWjwnD8sUnbdxrLy2?=
 =?us-ascii?Q?fdqT8LAJ1XHrfL1VxkUY41J+i/6FBszJIu7ko6P0n8QCu7MwPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kfrsqRrNfgbgmw4lYeXsQ84gmryyfQxNFSDz2HZ3Z7QBgmu8+hjeVVJjw4XN?=
 =?us-ascii?Q?0o49FaIJJdoJfhLizxRboBhKEBapfS/Go0X6nY+IjQGFkTfEYjCrBuSBAe8z?=
 =?us-ascii?Q?zJeV1k9uzG1HCdFt+hMyN6lrDQY0wQ/rZJ92sZGXFAcKxURW/t7g2BjdFbns?=
 =?us-ascii?Q?7C+GiwYyV0QgstxhAK2izftOwuVSAJXCHo2AUGLijWYZofuXmKs5bmj3ljg4?=
 =?us-ascii?Q?tCbeGcY1Os/vW9pMfF5VCb02cfyAlxWFz5FjrSnHuJkZuhZ1qi4us1VJ/o6z?=
 =?us-ascii?Q?DdOzujisP31BwC6aWWcuEQBslEwNGbyg9AzGjIBeuTfXpLhaMQHIFPGUL61p?=
 =?us-ascii?Q?ysh4HUS/MPwgDF2PjdbexaVCfeEqIzRhkAsgoXgk2p8WER2CQeHyjhSQd7cz?=
 =?us-ascii?Q?UuorGdMCWEj2iLfx+10jDfLlEMViGfe7sVYX+yUgq13ceTKzW4xls14wewMv?=
 =?us-ascii?Q?lSgq4ePSuxveQw57ZeFtYp8TFv75lT6FkvZsAR7w6QA91xJ+AXvn73F7Wosk?=
 =?us-ascii?Q?SLRlT6i82GL9FyGdwUnRN6HVCs0Gt3EvQyDjRHBZI4TPc9IKjwk5LaykQY/x?=
 =?us-ascii?Q?JeBv7TOxKyHwaU/OU2wLT2hEMwZVPh96WYH4kmbNspV4JAS984iuqlZErqot?=
 =?us-ascii?Q?IV5SntUjCt/pxNc5EWV8SmsXHEVuf7/ZYbrzA5/AqoXHdnYOAWeKmDL9TpuY?=
 =?us-ascii?Q?wjl39eg0VZ+aV5WL6taYyQsYXyaheU4avjcW1fSrf+y2pReHdhWYBs4hWJVp?=
 =?us-ascii?Q?2zM2SaMR0IDIF8sxn8xkBsf9Ol2lPcfZj0fi+Z3sabckYZm1zoIpbqpWIKfY?=
 =?us-ascii?Q?d97ZK7hNRYIqvc8gUNJ0f/DmNriFx0X+vhHkI70Vcp6o2p+bIlCA8fR+tx5r?=
 =?us-ascii?Q?/kMityiSXJUxTh/SRVSASTSbdJCMrq28fp3pcE0mtBNXEGxOkD2pxxvxj+WD?=
 =?us-ascii?Q?XQ37jJPu5ywzQpBs7uS4xcFeKIlBwVLFlDaJVejpBta2TSaICAr14TE/baQT?=
 =?us-ascii?Q?tZz5w42gVNfdfLnDSYmLe80Z8zMUuGw50TE/V3mSEh4q0ihf7WCbtN1jj7vt?=
 =?us-ascii?Q?FSLvqjWyXBGhOMJE7EIXyfTLGluNjscUAdrRvcHzdXjEluz3dvUakiGsvNEg?=
 =?us-ascii?Q?ogMW6En99mc8QRJzo6zaQ8bCaMm9CoYRJ/ZUVLMY/p1g/09jeeM7bbUwce39?=
 =?us-ascii?Q?UHztRNW3RnB3XZg7pV0NGOZwjanjBiY2AJMkdKgN5GhpiWvfo3SrW58hkgtW?=
 =?us-ascii?Q?XHa0Mc/eLqfWR1elYE6KfJg6I5aqdtqcXBHmUeUto/Wjm7wUfD+WrK1AXGOL?=
 =?us-ascii?Q?g24bzt0pppLlZDPvLfHGeblYsR6tYpUzC8k2rm1ZHL/kR72c/n8yxMeNrBmI?=
 =?us-ascii?Q?lyMHFdHcYCbsPmwE0gPRHE+UgWHBHImmXPAe9aumT5oiT5c4BRXTdtJlsLsr?=
 =?us-ascii?Q?XPP5elGH4FTwEgzGhPYI99S1sJwYHZ0+5hoBTvWYdq80eAlug9cxJ/YhI4rJ?=
 =?us-ascii?Q?VIancMvwTOYwWDzJ6UmPcuQbMH84LwavUoNOQtCWJe/EB9e/JoISfanBpzvY?=
 =?us-ascii?Q?3h4NdSEt63eIheLemyk4zXpZ46XTPeCaGoYUb978?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 686a4720-2405-4e0e-d229-08dce120464a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 07:19:51.3733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5WnWb45kyY6oHNqRlkiBM83iogxf3nyoP5z1WIbro5Q6Q/kTInrSjO27iFVYm1LArVSsW9KMKjZl8P9COmQLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:04 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> Extend intel_iommu_set_dev_pasid() to set a nested type domain to a PASID
> of a device.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

