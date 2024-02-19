Return-Path: <linux-kselftest+bounces-4917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7BD859A3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 01:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF1828143F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6F394;
	Mon, 19 Feb 2024 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j91IBDVo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27736B;
	Mon, 19 Feb 2024 00:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708303251; cv=fail; b=KiV0TgSP+Mpffny7HnUzmgGAWJwkJeNN7OG997yv0WKy0HwaNqSHakBz1uy5+Upc+JAxzDn5VhbufqBlSbYgFEAFRMBM2UGyDI2uIUOvxe8GXPsYQ7ptyGwxPmadL2JeH29a0PjKtd1Vay8uiJCpYG0a3lwrPlI8r3mAnnnc4xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708303251; c=relaxed/simple;
	bh=ggapZ0DBAoIK4JVHEIBPczvhv0t4+L33CHUjlNuO4MQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ACqADBh/+1FpdyRyl3ZXSN5iJWnCkEUC7+FcRM4lnOSE+SL/b2prw18ul/QLjBnpfapQ149KYlVZzERWvd14NcMBIGDwzJARcU/taBCL9NlqkW5NHyfkzX6P7jbVDfLp5+J+9SgtK+HvNMfoUG9xduhi8Uu7ZZSRHOtAiPwOsPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j91IBDVo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708303250; x=1739839250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ggapZ0DBAoIK4JVHEIBPczvhv0t4+L33CHUjlNuO4MQ=;
  b=j91IBDVojdiwzlmIiES67R1O64MYNm/gLix0Yj8+zZssFDqq08q9tgxI
   oI6FCGoS6JkJ5R0oVKcSQA95C/OxJJYxlfrIZvyYnLy7Mlp6qVp94t03b
   SyRycBp3b1YMq/xvMqmueXg93Z85wiDBSTrweGETIDu738ESK0Rji+TV1
   jAaiHHLkpb0L2nVrPehq0c3WLa3sNOhd75FK8mVirHCbFhtqoz6v54wfu
   mzAWER32emTui5gNABsDmmHtTcwLjxAv5tiyZUFeyfnbkW+Q1L2ipHdiN
   OxloGkom44JhP4AsSiXoBBPmRnK5iz/mAiip4uXd3+q9EF0rbbaDa0Z2x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2804396"
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="2804396"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 16:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,169,1705392000"; 
   d="scan'208";a="4735480"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Feb 2024 16:40:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 16:40:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 18 Feb 2024 16:40:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 18 Feb 2024 16:40:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3bekuuPSpiSIP9+4OF5vMrWeu3tIVHoRjkTSeptFuhAjscAqCHkdWdj0M6WGloCG7cU26ms23jQHr/1Uh1v2T0NUDoirFfc50znCcd+4HTlvuO4La/vaFJeLtybvg42F3snYjk74TCZcXoImLopye1g5Ji0M+gMVW2FbxgmTJy9hkkF1nJFnz38SYILZCSlUxW22M7UkEism4oDdQTjPoXbdag8bvegk7iEcLKpuafRgWYYNNZd4drJwsiD+sOHuOnyo6PKIa3Q8riickixDTGSRxKauR1w6Ui3SL4T/wPCGt61k3hNiq39P0dmI1EkV/mzgYX3aufneGIimQuPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggapZ0DBAoIK4JVHEIBPczvhv0t4+L33CHUjlNuO4MQ=;
 b=O5Ur9y2VsJgClm/DrIzZ6re/Eak9tOi1ahSHpsAfZmyRxafdTJgGwslr2APuZ5JO6Aud0vPoFc7I90alectY9qzwLx0en3KB7eTjAOYHcQAbRkNAnZnrh1ZKUDRBr7/aC1WHQ0w4yWDsNmB+mKJYlwomGSdGfFANAvJCIzl2EeahgPP+nvTjBfh1x84+8uCmiGiO09pe5kxo/CbaeqfSynEMp+yFHGzi+uJT+qkXFBo1S+JCy/4UIbENVpARo9XuSJFwRdfiYfOxjO5mOJmwlcS22cwjmFcewYzuhUdcI/hlLEmCFqjoEEkBJDhyPrw/dfSz6aXqZiZWkHmOwDdmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8195.namprd11.prod.outlook.com (2603:10b6:208:47f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 00:40:41 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::bc62:d78b:f7d4:3917]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::bc62:d78b:f7d4:3917%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 00:40:41 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH] iommu/vt-d: Set SSADE when attaching to a parent with
 dirty tracking
Thread-Topic: [PATCH] iommu/vt-d: Set SSADE when attaching to a parent with
 dirty tracking
Thread-Index: AQHaWm82Vf9fjEbUgECSdV/MQLQNu7EAPx0AgAGTrACADw8NsA==
Date: Mon, 19 Feb 2024 00:40:41 +0000
Message-ID: <BN9PR11MB527608270BDF76C1460573368C512@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240208091414.28133-1-yi.l.liu@intel.com>
 <a945cd6c-7737-4d66-a319-613e1dbc3798@oracle.com>
 <324a1c52-359c-44c4-9872-0ad712d9f610@oracle.com>
In-Reply-To: <324a1c52-359c-44c4-9872-0ad712d9f610@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8195:EE_
x-ms-office365-filtering-correlation-id: df149fdb-3bf3-44e6-1b06-08dc30e3669c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 88kupbWhS+2NxPH/lWzlJeezc98WK+TkTCmnDyf07UsB4xydhWvSp4aHEP55tsCS2Ad4S7H0LWcCQXlGOSRiCyScJrFz7r/K4FL1xqSdTzX/7eyXSVMGXeXxtqWAtN9CS85NxyWtTuVdEkNSJmf+uxQWlGikUHIpxxsvNkneU/8qn9EzmKmsTKRhVld9b6LytEito0m9178I8aZ7suplCrPyY4CITgfLANu1CegycttmeF02xfusBEoxjLQfZlRmdYwL4+L8l8xbh0qQnygZg9aZ5EXrALuqzS7BkJep3xweu1LSwwWOmO08dZoRZ5oX3mu77wbKzmf3CvAUCwBsVTRAPB1HPwzJCxdVn1I34tq/8tuykkQ3sVNEDuCURAeLyoYAVZ0wivyDX4+0sIH9zccwWibf7oaoQ2fgH6EiCHSnAkQpJIRjvFOXjInzxBe9MozDW8DHebaYC7qyhlFRMRe0rOYxvcU/lFj4i8S8w6RQdpHr2WE0iSmMFUIZP7cbqWM+5/rpVCUuV3y2LC6HCZv3rdYmLbED2gjl+w+B8hlKnrTJ2PbVUZEaZb4gmzHh2lkmdwDC9JXisQWFD0Fd7q7Ytx1fQMQgYADWA/M95Fo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(8936002)(52536014)(8676002)(4326008)(5660300002)(2906002)(41300700001)(55016003)(7416002)(82960400001)(83380400001)(122000001)(38100700002)(33656002)(86362001)(38070700009)(26005)(71200400001)(66946007)(110136005)(76116006)(7696005)(53546011)(6506007)(66556008)(66476007)(66446008)(54906003)(6636002)(64756008)(316002)(966005)(478600001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG1pbkc5QUNsNDNWdHU5d3YyS21URlpPcDAvWnE0c2NNWTQyanJYNmswdVhM?=
 =?utf-8?B?YjdlbDU2cGxNTUYwcVFUbFc1UnFyRlBHbjNQYnZWQ3lNVUlRZ0h2bjhvWGZV?=
 =?utf-8?B?OVJwRElkSG9TSGY5S2UycUNGQmU3N0dTYW5TQndVWnJjWEVhT2QzQ3V4Lzha?=
 =?utf-8?B?MmFRNlpaejF3d1h0NTNkb3BndnZKSTdsWGF0Y3VNN1JURktkeEtBeXpKR3JS?=
 =?utf-8?B?SnNrb0kyODBoS05ERllCeWFuYkk3aWFtRW53SmtxWUVKZmowMGRySktYUzhq?=
 =?utf-8?B?WnhRb1RqRDJsR2l4dmVNN3BuL1R2QzEvTG5rRlhCUlVTM1liZ2l1ODhRaE1q?=
 =?utf-8?B?d0NTRUorRHJySzQrTzdlTXFTOXpXR3ZiSDhkWVlQT1JiTnRoWWVOekZzVVFr?=
 =?utf-8?B?R2JOdVZqbUNUOGhpcHR1NjVaeTNpQVhtWGZ6S01iMGdQUFRDU00vWkR4dE9u?=
 =?utf-8?B?c0NNdWxiREtuS05ORUtPOERMV0VwbFAyMjhNRnQ5Tk9EK2thNW9TMmZjdW5S?=
 =?utf-8?B?WE9hdjVRdEh1ZzhRcDAzUlpRNmIyTXhRNFo3QTdBaFNIVVUrMjFLS2JqK0Yz?=
 =?utf-8?B?OXRYUHBLVzlLd29qTC8xdW9UemVMVXVveDRyTTgrc0t1RXkwbUxMenpIM21w?=
 =?utf-8?B?eCtCU3p6TEJRM0RFaGNtT2JTTzQxc3RMdHhIVXhsMkNFQlZqa2FiZjJOY0xi?=
 =?utf-8?B?ZDI3YjlrUGwxcUJhcnVkV1Foa1I3N3JCSGIwamxQQWU0cSthNjFpWlFCZGZo?=
 =?utf-8?B?WGJLL1poN0dNTUtUMkdkVTUvVHBuMWw0bUdzKzRQakZjMDBZOWNsaGVOWStt?=
 =?utf-8?B?RjN3cm0vWWk4Mk1XeEt2bmRQVDRJQUptL24weERFNFJ2OS9BVGpqWHVodFJp?=
 =?utf-8?B?LzZxSDNZNmJzQmFEdVh5L0FTNjRBUkIyQldTa1BjUGZHdDVaNUxDSTFxNUw0?=
 =?utf-8?B?WHRrMHFyRkVHeldmZmcyblRnNDFtVHp6VzZtWmN6ZnZVa1RoYVQyN0xoTWE1?=
 =?utf-8?B?dmI4SWhLSStEeHZ6UHE2K1ZKbUFvWDFnY1AzVHcxMm5QVFJqaGg5WnJtcjJr?=
 =?utf-8?B?bnBrNDlQQngrVngwd09LNzVBSlZ0ajdqTkFNdVUvYTJqZFdoeTZlVjJwcXhB?=
 =?utf-8?B?TTlZajdyYzM4Sk1DTDNhRzBzRTk3OUQwN3BUeGVIZjF4OW5RTE53QXg2cEFx?=
 =?utf-8?B?d0NpaUIwZFJsaStQWWJuckh2c28zRkhtdHZRQ3VvQ0pRVFlFbk9tOGxaMHJT?=
 =?utf-8?B?S1pYaHJ4cU16TmZKdU4wWnhlaEcwVEsxWldPT2dJektRUUVZK0dNVGJiUFRI?=
 =?utf-8?B?RzRQZHU3ZFlDa3RCb2xEMit4REJFeVJQSTRNaHRINFN0NW44YzZTTmlZaDdw?=
 =?utf-8?B?MTk5bVk2dDJKNjJjbXV2Q2QrcFFtU05HZjBXejlacno5aHRySmwrUzFrSlJw?=
 =?utf-8?B?OGVacjJ3WWplNnVuRTVEWXNpZS9KN2drSTRFbDN0WUxobUJYL1BGb01VT3hj?=
 =?utf-8?B?NHlFU1E2WWFCWnFxRzVXWEtrTXU2RXZ4bEd4U1VJQzNBVjJCZzN3RFJsZkJ4?=
 =?utf-8?B?cUhtT3pjY2YzcUVqQUlqeVk0cGRENWRjcWdGQzZqWk1LL2dQN2R0ZWpjcFFY?=
 =?utf-8?B?UnZQYUg4RUtzOEdLeGdLTnZySHp6dndkRWw2T25zd1pwWWd3WWRLVzlOLzB2?=
 =?utf-8?B?aE5hZWxGNG02eDJPU3VQSC85RHZGaldiSEd3dmZ6VGJ6Y1FuRzJRZ29MdTE4?=
 =?utf-8?B?S1AzdFEwTllGNzBGQ0E1WFBzMnoyeUxiYzZ5NTBMdXpDTG40QW4yUS84WGd3?=
 =?utf-8?B?NWdHOE81Q3FmRnBQMjJZMmlqMUE4UFp4a041cklqRS9lZFBMZnRJak85eFky?=
 =?utf-8?B?VUxwa1JrZWc5NWNoMHlLVThtdWwvcjVuSUI1R21KaVMrbmUrRld5VmsxQlkr?=
 =?utf-8?B?S1hpRDZHM2ljUDR2RUhyMHRiWjN5R3VITUVYaWQyWjhGYXloTUMwUEJtMjNE?=
 =?utf-8?B?NG5PZ0NXZ05EUlorcy9zcXdFcVh4ZTFUaElmNXgrQ3I3cmx4bW1MY01vMGds?=
 =?utf-8?B?RU5ZU2htaHlZci9YUkpxMDVqbUFEdk5qc2I1eGw5cDFyNTBCeEl2SlovUFRl?=
 =?utf-8?Q?/K9ZX06N3+BQA2HS0XkA/jYAT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df149fdb-3bf3-44e6-1b06-08dc30e3669c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 00:40:41.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FqWOL4oiQZ50SiFKv4UYm15NpJuIB9ZOJgKjd4TSVL5Jd9AaJs70xNWSSRSLMLqNMu/F+cnRkyt8xtqsbLqPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8195
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgRmVicnVhcnkgOSwgMjAyNCA2OjM2IFBNDQo+IA0KPiBPbiAwOC8wMi8yMDI0IDEw
OjMxLCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+ID4gT24gMDgvMDIvMjAyNCAwOToxNCwgWWkgTGl1
IHdyb3RlOg0KPiA+PiBTaG91bGQgc2V0IHRoZSBTU0FERSAoU2Vjb25kIFN0YWdlIEFjY2Vzcy9E
aXJ0eSBiaXQgRW5hYmxlKSBiaXQgb2YgdGhlDQo+ID4+IHBhc2lkIGVudHJ5IHdoZW4gYXR0YWNo
aW5nIGEgZGV2aWNlIHRvIGEgbmVzdGVkIGRvbWFpbiBpZiBpdHMgcGFyZW50DQo+ID4+IGhhcyBh
bHJlYWR5IGVuYWJsZWQgZGlydHkgdHJhY2tpbmcuDQo+ID4+DQo+ID4+IEZpeGVzOiAxMTFiZjg1
YzY4ZjYgKCJpb21tdS92dC1kOiBBZGQgaGVscGVyIHRvIHNldHVwIHBhc2lkIG5lc3RlZA0KPiB0
cmFuc2xhdGlvbiIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwu
Y29tPg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEpvYW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNA
b3JhY2xlLmNvbT4NCj4gPg0KPiBPbiBhIHNlY29uZCB0aG91Z2h0LCB3aGlsZSB0aGUgcGF0Y2gg
bG9va3MgZmluZSBpZiB0aGlzIGlzIHdoYXQgd2Ugd2FubmEgZG8sDQo+IGp1c3QgYSBxdWljayBj
bGFyaWZpY2F0aW9uIG9uIHRoZSB3aHkgKHRoYXQncyBhbHNvIGFwcGxpY2FibGUgdG8gdGhlIGxh
c3QgcGF0Y2gNCj4gb2YgeW91ciBvdGhlciBzZXJpZXNbMF0pLiBJIGFtIHN1cmUgSSBhbSBtaXNz
aW5nIHNvbWV0aGluZyA6KQ0KPiANCj4gU2hvdWxkbid0IHRoZSBuZXN0ZWQgZG9tYWluIGJlIHN1
YmR1ZWQgdG8gd2hhdGV2ZXIgZmVhdHVyZXMgZ3Vlc3QgaWRlYSBvZg0KPiBlY2FwL2NhcCBpbnN0
ZWFkIG9mIGhvc3QncyB2aWV3PyBPciBpcyB0aGlzIGJlY2F1c2UgZ3Vlc3QgZmlyc3Qtc3RhZ2Ug
cGFnZQ0KPiB0YWJsZQ0KPiBvbiBJbnRlbCBpcyBzdXBwb3NlZCB0byBiZSBhbHdheXMtZW5hYmxl
ZCBkaXJ0eSB0cmFja2luZyAocGVyIFNETSkgPyBJZiBpdCdzIHRoZQ0KPiBsYXR0ZXIsIGl0IHBy
b2JhYmx5IHNob3VsZCBiZSBzcHJpbmtsZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlKHMpLg0KPiAN
Cj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjQwMjA4MDgyMzA3
LjE1NzU5LTktDQo+IHlpLmwubGl1QGludGVsLmNvbS8NCj4gDQoNCmZpcnN0LXN0YWdlIGRpcnR5
IHRyYWNraW5nIGlzIGFsd2F5cyBlbmFibGVkLiBidXQgdGhlIHJlYWwgcG9pbnQgaGVyZSBpcw0K
dGhhdCB0aGUgaG9zdCBoYXMgZW5hYmxlZCBkaXJ0eS10cmFja2luZyBpbiBzZWNvbmQtc3RhZ2Ug
c28gd2hlbiANCmEgZGV2aWNlIGlzIGF0dGFjaGVkIHRvIGEgbmVzdGVkIGRvbWFpbiBvbiB0b3Ag
b2YgdGhhdCBzZWNvbmQtc3RhZ2UNCndlIHNob3VsZCBzZXQgU1NBREUgaW4gdGhlIHBhc2lkIGVu
dHJ5IGZvciB0aGF0IGRldmljZS4NCg0KZXZlbiBpZiB0aGVyZSBpcyBhIGd1ZXN0IGVjYXAvY2Fw
IGZvciBmaXJzdC1zdGFnZSBkaXJ0eSB0cmFja2luZyB0aGF0DQpzaG91bGRuJ3QgYWZmZWN0IHRo
ZSBob3N0IHNldHRpbmcgZm9yIHNlY29uZC1zdGFnZSB3aGljaCBpcyBpbnZpc2libGUNCnRvIHRo
ZSBndWVzdC4NCg==

