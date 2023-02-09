Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06FA68FD5E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 03:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjBICxm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 21:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjBICwc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 21:52:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365037A8C;
        Wed,  8 Feb 2023 18:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675911006; x=1707447006;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hjutfj9YtzAsVFwi4iJIGOY74ULwsrufGpFrRF4N5xs=;
  b=arer7pmJFVSc1env3lsExRvvD3FAT0ACNcN3ehS7uxIZKw/B0tlJ6mYc
   EGJYJffFitAA7Z4WbZDJ/uzt/GIG3rK9Qni3kM97Wb49bpPgi3/xqk0/W
   Gq2qa7v5XJx59lBZNQ15afTLbfYqS6L48GSdFF9zqFvoecY2hMkh8AqjE
   W6lsYGic7pRBnBtiMsMpKnYvaQJoEev/xvRpmxOJJSgVGYwwm4Zv/r9Oz
   PPNPqZ3/Jil+7yNCUDbdqSGnJg8x6NcXgOImQvLUOTkCKj8awmf6kKg8m
   SAMCA7rHGxxqgCDX4uw1qs3+wM1R/yb83wiGV3JW539mBJM+1prXhuzkY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="394587842"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="394587842"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 18:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="645095917"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="645095917"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2023 18:50:05 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:50:05 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 18:50:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 18:50:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 18:50:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4YwqFAqzrwQ2jmFdhNBgk4gCy9HTqfAtwD8p/HfqBsR/wu0PFeYH2Mhr3Wxc5AW2NFkYN+vmEWLDkpzC/URTuyD66uoezge6lwHSVMEDXD2fb418hdq21F44U/Hl68eyXBncLEvJO0s/bcinvzZAorULswqFQdAsln/kAKGaQnZbrYQ+CxhAL98XWs5befbfaqtTtlrnCfEw1o6FFopGEFNsP1z0/pXH6hldiGCrlJ6s/jifXUxpx6g3PRp5N/mS7ojfLW0yGWch+/SN4jWbpqQXexx8qS7/JFnqckPzMGbBO9m+DdP8QqiglT57li5R4VveqZiVm/X3iz6cndOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjutfj9YtzAsVFwi4iJIGOY74ULwsrufGpFrRF4N5xs=;
 b=lRZ/SReJUX1jpXpEmldGGSkmKoEu62jhR95zyMF963qKMxLkRnZ37PcAz334+wkPIPjHPLTK8fp5SRABlE2BGqfwl7yG1g9stm4TVGVPkI7KTELC784F0ijBCggcBheHThw/xN76zmuUSzEZqibPQES0/KsfXkfTnHe7W1MrOuJgzVXtqPDb094+qHUk7Lh5WQO0OY5XtElQwJpBQviuX2to+NO/Cx/w/HKImpznIfpggosnVfccspKUs3YBBSLwYAdNSjDZ//17SMnEeCHfhhbrj+u4H9SR5pBfsHRYmQvt6bklydb2FVTxvMR3bJrvuvRpsOLRdTwGASjT7WUw1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5202.namprd11.prod.outlook.com (2603:10b6:303:97::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:49:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 02:49:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 01/10] iommu: Move dev_iommu_ops() to private header
Thread-Topic: [PATCH v2 01/10] iommu: Move dev_iommu_ops() to private header
Thread-Index: AQHZOzoQQRehDOjJPkCWswfj5x1nQ67F69uw
Date:   Thu, 9 Feb 2023 02:49:56 +0000
Message-ID: <BN9PR11MB5276E1DCA5F98CDEADC01EC68CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <f4df58c6ab16fe6b38dd4925dabbd071eb8d3158.1675802050.git.nicolinc@nvidia.com>
In-Reply-To: <f4df58c6ab16fe6b38dd4925dabbd071eb8d3158.1675802050.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5202:EE_
x-ms-office365-filtering-correlation-id: 38ca45d3-86be-45e9-990f-08db0a485439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZusMD59cTbAq8ygxMA5Yw1heVbQ/aNdgsHrdmBiYzhxwDE2obhfcxCX19xs4yJJ10r3BCICexlDz0sigI9TAilhGLjuJMITOVAnYxRZ9QEGuRPOJdoNtQ+mvv4RQLWCxxHVMFnuVXgfueM+DWArbgGLeiGbK8m2TwYjAne0l1fgi6jPu1aiRsuAFUg8F617hASdirlZYB/VDNjfmMurW/lqhT7npy4fn/WOzw8EIv249PJXwkCvfpZsXX7jL6pw75PTUJ/gC9UZZFzODMMoy7m20BazG1pL6IDq1ZGBGfAPNM6EP2WgrQyk2cOKHxYXP5bss4QbNcg8wqzCwzr1uEc05X7BUhMrSr90OWOZz1GAEyK9fX62+9loCDibiDYJbOIywjAose/mr3rB/t3u+cGUa0RJpUiFv4OLLKvzEbElN//cj3CeY7bul8sDy9yWPMScggyPPU9gHRQuqU1KXyDoTMzqVaax89sSrLV0AZoC3aTBD5aahR1g7htFuJuQhH5rntscRk0CnoLrwZNi0uNI2rYk+Z6thTDL56a5v2/r4LjCaRhpPzaLPtHSqoVCFCAZXxwmZCn8BdHJ/2wMv8weRhPXPkH574m+HdQAJ204gt4kg0XNqXJglmJcVL/IUiwogvPxH1TX12AEFE5BEkZ+4Qo8u0ajk7D/Wf5BAen14cy4rbbDiUljPE1Um4darNp4S4XeWU7t7HKkp9FLusQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199018)(316002)(8936002)(52536014)(55016003)(2906002)(33656002)(7696005)(71200400001)(478600001)(86362001)(122000001)(4744005)(54906003)(5660300002)(66946007)(7416002)(110136005)(66446008)(66476007)(66556008)(64756008)(38070700005)(6506007)(76116006)(41300700001)(4326008)(26005)(186003)(8676002)(9686003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K/hkE3lxiv864WSgqE4NnTJoggLY2B6wgJ78i9UNkAGKinBfARYmw90SJqf1?=
 =?us-ascii?Q?GoD+tn/4nwwy2WS8RqkNF0xmQweu7t6M9SxZNofqSI+YH5RKvD1iRGzr0RiK?=
 =?us-ascii?Q?C6+DaDXjHcSyGvl8yLApTxH2B5JWyc35VNaBAkIPq+dN1f/nXVKsVOLllMmi?=
 =?us-ascii?Q?3UojpCzl4r7M9rJWiyJhlT182fZDBAxgPkvskg8XCAT8bxsKQLKRFC1Cw1Fj?=
 =?us-ascii?Q?CF3eYU63iJW+nfIQ1kZ7sMRJys5hf+lDgVZyGTPGvNy/3g5qs7E1OIFxGnlB?=
 =?us-ascii?Q?1EZLLw7R2whEYXPiExu5O1E9gI8OYrcE69FCWHirBtieb+jAR5PtIEK5/i0r?=
 =?us-ascii?Q?gfFk3v7+Str3pnBEAqSOo8/7ogDvG1NeZfkKA+2BID1SviRjIsgzuIQt+P7j?=
 =?us-ascii?Q?gAR6IpCek/7lvnUeJJjuE1li8/CkdEkdoiEGpoJD6WZYyC5QcbepMXNKVN3P?=
 =?us-ascii?Q?nQE4jNzlT15UoMQT8v+OKIX0udVsQSOCcK76q748fGBkd/CM2z969Hu1BI2z?=
 =?us-ascii?Q?ZfZy9PNpn8hLZp/JY2VENMIHeDaFALifD2+hJNrTxcnPgBELgt+MOx/PCKdx?=
 =?us-ascii?Q?M1NE4jWUASWtwUnjLq8MXRjYwNeLqTVgoX1KnfaC7XIcpKgX+CP9y+URigGB?=
 =?us-ascii?Q?QpBcXOiH9gj289h2oNTeboV1PDE+Cdtrdb1aNrpnsA7FBrpJ0MAnJ7lvU2HE?=
 =?us-ascii?Q?gmZUhuEVF0i4J/VA4G4LSAhSB8Py96YyVqfZeHw0LWSGX7IfADcOjVr3ugMf?=
 =?us-ascii?Q?LrHd/pqKkDiF3tS8ZNDoOGtm+VMKrSFhTdZ/C/uUAIxrmxpJUeStt8cCOoCJ?=
 =?us-ascii?Q?sOQW7q4yFs9FaLWYO37+IRy67px9yE4M207CbT2raxcTidEID22CDPeZyREa?=
 =?us-ascii?Q?V4E9TJguO6EqtTY9t4kHz+OV3rSW3vM+oq0nrDWYxKxZgrOcxDCnCecJ3Bwa?=
 =?us-ascii?Q?MgqN9/vsnntLjhiEOy+Ag53Dpt0vhbtc4b87pmta4mzmBgKzMzaLb6u6ZOGv?=
 =?us-ascii?Q?sfa+6ZSLKnTVpVi7iTyKEceA1xMf3c+D6xS75Sop5aGwjYya/NU2zAFP7wKz?=
 =?us-ascii?Q?kUD429a3MAqsJNGpzYJv+kuHuodjAnus8UhqeX+bxkSpt9xE/hXUy0HbhFhk?=
 =?us-ascii?Q?IECOqk8g8RuSXr8v++PjqM6LW0FCoQGTQOfxq33wYZVjZ67xqUpAG+Qk1Nzb?=
 =?us-ascii?Q?TD0w2nfRL1j5LVuiNN41wgVJGj0uZqqgMa4UYcMFn1zRnbmcqfNldD4FHnnb?=
 =?us-ascii?Q?omZN0N70A9PCCk/NsvEXpZXkNkDERvU0gdPOVWMOGHEPAyzHpnemDNWqAdR8?=
 =?us-ascii?Q?EKN5NBqR0tOaYNOFYzPctKUA22gfdQfjv3CHRsP88nXAKbNjAh8sYnat4fqU?=
 =?us-ascii?Q?+SH6madN7gfZTXZIor+4h3VNvdENmoYUGb3Gj3zYZzzWPFvNg7/DeM5P8jnt?=
 =?us-ascii?Q?Nd1WaEHye91CJl1ssqvM6RIuAxni62uAzFVwl9bjTMv7VOTNod13RWA5iXwb?=
 =?us-ascii?Q?4vtcezRQv7+omOJUvr7fgvF4T9SpaLfNtIYSghgLMhQmlvlS2e/V44AnCten?=
 =?us-ascii?Q?TD7SPPKGgJERqO2SOFy7V7ILHzL779To2xLNyzRJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ca45d3-86be-45e9-990f-08db0a485439
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 02:49:56.9884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjhQ7XC9IZ93wwd6V8/yWPGMqt88riVNJS7P89ryaKMjw80KKwJN/DvXQS01AvFWVchnb2ftr/KiePk4MWHnKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5202
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, February 8, 2023 5:18 AM
>=20
> From: Yi Liu <yi.l.liu@intel.com>
>=20
> dev_iommu_ops() is essentially only used in iommu subsystem, so
> move to a private header to avoid being abused by other drivers.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
