Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C25966C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiHQB3A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 21:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiHQB2m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 21:28:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0306595ACE;
        Tue, 16 Aug 2022 18:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660699671; x=1692235671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ScFJaZlrEa89NgLf4jyqoVIWfRJD4uiYYUcRXpapngc=;
  b=HH3naB3+HfiZ4DuD8XdBxfX/UoMUqdCoNdCjFmxhehnUZUi6WBRKokDD
   eUiNxWglKNqnBfyJICXPvYAuoDfyRYaRplcgJOCHHv8rl3PzZqNPNX/NX
   gQKpdVC+8Z/JSMeQPRMfyYGZP6qfAMoXf6+kNqsolV2GXSUCo0GqVD3ZZ
   p5XVBwm8E8xTMKjFrd9QV3Sr6qjrZk6+Hece6XrsZWrUGfSQ5S0kYhaYO
   UrvJoqj1WqBfxeFDmiac6Fmln1ChNLVHHQhNrCUN6/scAmNnFimuBM5kf
   7OGDmih2xk6CPjH/biN7JutbVy3UqGd7OgbK4SDU3fjvazU3SeyotgxmL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="272142117"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="272142117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="710363397"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2022 18:27:41 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 18:27:41 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 18:27:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 18:27:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 18:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MopCy22e0ShyZ59+ztTx+iM0zhVGw8/6GbojvUIW+mpqJWIKzO6+i/La3RA5xAJVRgckWzTrA95ZB5j9kD5nxWcglDPCkm1ZK3rP/TzQtcZQh1rou1NjJT767eDcMTIEdGtvEkDrSreDuAlIJVAOeynSVD9zk6IVxhGDgySrWUwjB12zlOYMnYgTawdI7WYbMuNBcXp0Q+TOlIiIRZvpJgVX/JZ1HIhJjga4GFW7Z0EswhvUgHLsqP+jN0jJL+w52OXMrvj/QFRqLSQ5ZidEtcSZtU4CLOr4bSwBDUFIQt+WmmNLgl4cShtVsgs7CYq/xl/CmhdKQAMqvxAsmAhVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnBn1vIFFa4jfniXu4O2u/b84feJ4/aFLqZsLnkXWSM=;
 b=ePgzB28Bx2Z/7fgAocbdXueFyUV20g4n86J95WDsGYeEHOWQmwobea6AsJQAB8lPm0vVDp5R20VZ9YGs2/vNltTZFOL6GLHexj+0gmKVDbquqzEGG2zC67hiAPcr9JcPd3PapLbM5LSga8OxinnUZIGMjSTqDs8ULHTCKHFrCBONXzk8DgOA/wlADsLCqny6zS6cnoOV84zcnnv9GqmX+LmQ9mtH5WtiNwUXx+8i0jT5cPW6ZTzasRg/aO3sQD1QICsqmkOdjBEhrvlbyC9DGb/htF48YjDslr/3ZGya3AKBgOUssHThIMKDmoGf0UPi9Xr/VDq353FFTibI770UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) by
 DM8PR11MB5575.namprd11.prod.outlook.com (2603:10b6:8:38::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.22; Wed, 17 Aug 2022 01:27:38 +0000
Received: from DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::21ea:5b3b:c98a:d2ee]) by DM8PR11MB5591.namprd11.prod.outlook.com
 ([fe80::21ea:5b3b:c98a:d2ee%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 01:27:38 +0000
From:   "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Thread-Topic: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Thread-Index: AQHYsQBK2Ad8oao9B0eIzoi6SNarlK2xt+wAgAB3W4CAABDRIA==
Date:   Wed, 17 Aug 2022 01:27:38 +0000
Message-ID: <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
In-Reply-To: <YvwpX7pYOW3Jv+vJ@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c712b3bd-6b0a-4cf4-aaa8-08da7fefac01
x-ms-traffictypediagnostic: DM8PR11MB5575:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtKYNSWsKykCRzbll/XQzniJ5L+43zQ1VsjtIrC9g4h5bsk4Lw5VSyKG1GpK/NrCVq+te3PUdBqHyzo2velyLJTZj1qZlzZ1/Z7DdzWj74OrYL1ZRvaXZYLUTmaQSoMJL/fG85bKNRIAl2f+j7sa/kZYzTgfJlK6VoQVrkeUv2fE9LaECUHKwa4GvAD6D5O2EwSjRLEYQKCNP+nl19lGHfBCslzWEZpIlxOjUFt9Zwpjfl1TGHROshDGUqhj2IzppDq63W6Mfi9umg3hong4Cfd9ubf1LzIc9toHbef4CqZpIuQITiUwr500s7vjy3LDZdEDtFEm4FXs/sbXdmBfvm8kXL5j4BtT/nJUH/a7VUG8ZrZFRe9NoOWYkpZkQGvuMSvIhrJtG5hZ1isbUIeRNQR1fsuqSoxMlRee9cjroqfDRrh1dTEtY+JMrXGPSjgNYjagH3v94Y2XrWcCQDoJUHcYRs2NWlgAYzSg1Nf/LQJC6T0UNWMA1A2dcRN1ZYrAeUybzvb3ho4vDUXBtAM6dsdpm2amtP6iNI7pp4KkPL51Ok+ccIdD0UM622+2D75wH4LM/qcEWndR339RK8Q86FTACNWg0NmXY59xvk+y1eYryYpGxHBZm+Lx3hfNXqCAmznxqEYhcdSBn0VV8v96gHJVcdKbRHquZ1TdAkCgXcE6pfyj3I02O/t++jVr/NL4VPry0ft2CLSQ13KC27L5m2taJ3fRHH9jY+m0B3kgJaUDAiMi7mTsjVPm6eqVlpc2cFXwZX6cbNvyT8h+Rsk8BAAqkIU0+lUQPeKLMU6jmpSc9oOkkmU6wszJ4yE+yguI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5591.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(39860400002)(136003)(71200400001)(26005)(55016003)(5660300002)(53546011)(33656002)(6506007)(7696005)(9686003)(478600001)(186003)(110136005)(86362001)(83380400001)(41300700001)(2906002)(38070700005)(76116006)(54906003)(316002)(6636002)(64756008)(30864003)(66946007)(66476007)(66446008)(8936002)(52536014)(66556008)(4326008)(8676002)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0QV3PEMXa4L5TG/TlM4FOOACQqqXLaFBOKJ2JdpcOzjOmVq4vjan1eSApyDU?=
 =?us-ascii?Q?kGV7LjgH/6yHKwHjhEHINNSboeIWY6yvcXxXzsto+8NzPcbHiAgvml8w+RXL?=
 =?us-ascii?Q?fLz3Qzaw7E8whlN240oLd4fpeJjYKmdJLT2hYYDrrIc900dY/pfigVhoOq9J?=
 =?us-ascii?Q?S4JORTg7xpl73/dbkTa28kV4TX5rQMQuviORUp58Ddr9PQwsPvB1B90/nEOc?=
 =?us-ascii?Q?SRFty1KLL7vrxFnCElPcrp/yPFwbPJE/M6xJY0c0fZN08BdWe7sD0tL9EI1b?=
 =?us-ascii?Q?oK2PXqDxfAjnmgTz/YRw27AJsjSwjJnbFr4fE/HPi8St8plv1VjrTw9Ms8d7?=
 =?us-ascii?Q?rVd0SkqylNlAm5IqZrjKQqQUR2l562GTX4/gXvCjCwoA2GkwsZiqYaxLr4Y1?=
 =?us-ascii?Q?3IwAgV3aKdWUlqKnyBEHyz2bzp/JHhuEcE8NVVi6kGWbRn+VtzBVRVFMalpn?=
 =?us-ascii?Q?/U0QPo7PKQ8lwOtAoJixYepJSowwBaolOyweRrgrq+YsOEMhWoLLJWmBa5jk?=
 =?us-ascii?Q?79LD8bvB+e83vBjeJYKAFT5ZXaZdyC2V9/665t9gcok2Sp90AEmH5+XQb5Vw?=
 =?us-ascii?Q?RAPjt5GutSxUFD7g/8lt95uwvxLjzWt83o09LtEmG0kvBFi3YCA4uSswhOrP?=
 =?us-ascii?Q?xcF6IFP1IS04vfur4tFee1AwxJ/goSzzW9I6FZPznvCJ1l4YJXde6ErBKvZe?=
 =?us-ascii?Q?BsH5/3tTb+TZgMLOCGR6k5EJP4V1KPKvk/zhCW9RpMXQIkJHS0YWmXoyvNiv?=
 =?us-ascii?Q?gZGea0V5CdBXisqv80RmoQaZ2UIIfVFiKv/3EvR6WksIDz9Iou6OlEYp/peI?=
 =?us-ascii?Q?Pwt5I/u1XQSkaihvh0AW9tTz3x+k00N9FE8lSZJjYNg9WVKv+FClCBd3aV9V?=
 =?us-ascii?Q?sQ3xIcsCWO7DIWaUD1MBn720UqCRAAoMI6U6s5OnhrD8WzI7F+uvkce5lnhX?=
 =?us-ascii?Q?F2l6V1Enrb1PG80HMWfan/nlT3eMj66s3Yrzt3qxu/0k++RY3IYJuFzkfrMP?=
 =?us-ascii?Q?HqA44r8wip2YhmMYwt5BpwyMZHhHiKCDGNu5TrR3t1SKY4XhvzBQb44l4+4m?=
 =?us-ascii?Q?V4ztY2BWQxCyYFh8fnWmk+L7uWzfvKr40eRwYwUOLww1p0n6wpN1brNRzJRg?=
 =?us-ascii?Q?D6PExmkWSaQKXEMMiEU/YDTbdAMduUEgo1SR6D7v1SiacH2qtwXHyCTZfP/M?=
 =?us-ascii?Q?y0B/KEyjThqGYBiv3NjHzoUk3NKIWV9Gno7TY5IiwKC9JX0cr0rVjJyrQGZd?=
 =?us-ascii?Q?BG55ZnANFz7j4bsSjXi3CopPtM8SVLCaF8ytLEcAsPLbTNx/myW+1o4RLX8/?=
 =?us-ascii?Q?A/zuMYo9jLHxyciQ7ANuh0m9v5sOs4NmnhfbWx43Dq04Qm4cJr4d2pv0Ojgj?=
 =?us-ascii?Q?XJ02dNklYR3YCj7FSAUS8dY2AGz3ukC82rh1QNKK26KHuyCI6tUFhZBXlZRG?=
 =?us-ascii?Q?rgw8rQzCvhcCFFqcGBBas2ouhZ8kyZPoylFWwMA/i72bPKjMJD4eCbSHW3Jr?=
 =?us-ascii?Q?U3j7on6VJfmWw7cM4APo6o73fS7nkyl84tvfL7h+vC1+7OwGQYZ18SwH7p4s?=
 =?us-ascii?Q?zjk/42ot6e03VQi2CHZ7uexN6jhjHuR1/e6RkoY0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5591.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c712b3bd-6b0a-4cf4-aaa8-08da7fefac01
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 01:27:38.5735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvFnOnC7riNR69+wYtj/53q7nQHnc9Sb28sp+Yxv2wA8ShuSIGa8DcKeug9X8aN51JBUUXTxf2Udbg9YYC5brA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5575
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko, Reinette,

> -----Original Message-----
> From: Jarkko Sakkinen <jarkko@kernel.org>
> Sent: Tuesday, August 16, 2022 4:34 PM
> To: Chatre, Reinette <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>; linux-
> sgx@vger.kernel.org; Dhanraj, Vijay <vijay.dhanraj@intel.com>; Shuah Khan
> <shuah@kernel.org>; open list:KERNEL SELFTEST FRAMEWORK <linux-
> kselftest@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
> augment_via_eaccept_long
>=20
> On Tue, Aug 16, 2022 at 09:26:40AM -0700, Reinette Chatre wrote:
> > Hi Vijay,
> >
> > Thank you very much for digging into this. A few comments below.
> >
> > On 8/15/2022 4:39 PM, Jarkko Sakkinen wrote:
> > > From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > >
> > > Add a new test case which is same as augment_via_eaccept but adds a
> > > larger number of EPC pages to stress test EAUG via EACCEPT.
> > >
> > > Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > > I removed Githubisms (hyphens), added missing subsystem tag, and
> > > cleaned up the commit message a bit.
> > >  tools/testing/selftests/sgx/load.c      |   5 +-
> > >  tools/testing/selftests/sgx/main.c      | 120
> +++++++++++++++++++++++-
> > >  tools/testing/selftests/sgx/main.h      |   3 +-
> > >  tools/testing/selftests/sgx/sigstruct.c |   2 +-
> > >  4 files changed, 125 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/sgx/load.c
> > > b/tools/testing/selftests/sgx/load.c
> > > index 94bdeac1cf04..7de1b15c90b1 100644
> > > --- a/tools/testing/selftests/sgx/load.c
> > > +++ b/tools/testing/selftests/sgx/load.c
> > > @@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const
> char *symbol)
> > >  	return 0;
> > >  }
> > >
> > > -bool encl_load(const char *path, struct encl *encl, unsigned long
> > > heap_size)
> > > +bool encl_load(const char *path, struct encl *encl, unsigned long
> heap_size,
> > > +			   unsigned long edmm_size)
> > >  {
> > >  	const char device_path[] =3D "/dev/sgx_enclave";
> > >  	struct encl_segment *seg;
> > > @@ -300,7 +301,7 @@ bool encl_load(const char *path, struct encl
> > > *encl, unsigned long heap_size)
> > >
> > >  	encl->src_size =3D encl->segment_tbl[j].offset +
> > > encl->segment_tbl[j].size;
> > >
> > > -	for (encl->encl_size =3D 4096; encl->encl_size < encl->src_size; )
> > > +	for (encl->encl_size =3D 4096; encl->encl_size < encl->src_size +
> > > +edmm_size;)
> > >  		encl->encl_size <<=3D 1;
> > >
> >
> > This seems to create the hardcoded 8GB larger enclave for all (SGX1
> > and SGX2) tests, not just the test introduced with this commit (and the=
 only
> user of this extra space).
> > Is this intended? This can be done without impacting all the other test=
s.
>=20
> It's a valid point. I can adjust the patch.

Thanks Jarkko.

>=20
> >
> > >  	return true;
> > > diff --git a/tools/testing/selftests/sgx/main.c
> > > b/tools/testing/selftests/sgx/main.c
> > > index 9820b3809c69..65e79682f75e 100644
> > > --- a/tools/testing/selftests/sgx/main.c
> > > +++ b/tools/testing/selftests/sgx/main.c
> > > @@ -25,6 +25,8 @@ static const uint64_t MAGIC =3D
> > > 0x1122334455667788ULL;  static const uint64_t MAGIC2 =3D
> > > 0x8877665544332211ULL;  vdso_sgx_enter_enclave_t
> > > vdso_sgx_enter_enclave;
> > >
> > > +static const unsigned long edmm_size =3D 8589934592; //8G
> > > +
> >
> > Could you please elaborate how this constant was chosen? I understand
> > that this test helped to uncover a bug and it is useful to add to the
> > kernel. When doing so this test will be run on systems with a variety
> > of SGX memory sizes, could you please elaborate (and add a
> > snippet) how 8GB is the right value for all systems?
>=20
> It is the only constant I know for sure that some people (Vijay and Haita=
o)
> have been able to reproduce the bug.
>=20
> Unless someone can show that the same bug reproduces with a smaller
> constant, changing it would make the whole test irrelevant.

I tried with 2GB and it always succeed and with 4GB was able to repro spora=
dically. But with 8GB failure was consistent. One thing to note is even wit=
h 8GB Haitao couldn't reproduce this every time. So not sure if it good for=
 all the systems but on my ICX system, I was able to consistently repro wit=
h this value.
=20
>=20
> >
> > /on page to be added/on every page to be added/ ?
> >
> > > + */
> > > +#define TIMEOUT_LONG 900 /* seconds */ TEST_F_TIMEOUT(enclave,
> > > +augment_via_eaccept_long, TIMEOUT_LONG) {
> > > +	struct encl_op_get_from_addr get_addr_op;
> > > +	struct encl_op_put_to_addr put_addr_op;
> > > +	struct encl_op_eaccept eaccept_op;
> > > +	size_t total_size =3D 0;
> > > +	void *addr;
> > > +	unsigned long i;
> >
> > (reverse fir tree order)
>=20
> I would just change this to "int i" instead.

I think changing it to "int i" will cause a buffer overflow with edmm_size =
being 8GB.

>=20
> >
> > > +
> > > +	if (!sgx2_supported())
> > > +		SKIP(return, "SGX2 not supported");
> > > +
> > > +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self-
> >encl,
> > > +_metadata));
> > > +
> > > +	memset(&self->run, 0, sizeof(self->run));
> > > +	self->run.tcs =3D self->encl.encl_base;
> > > +
> > > +	for (i =3D 0; i < self->encl.nr_segments; i++) {
> > > +		struct encl_segment *seg =3D &self->encl.segment_tbl[i];
> > > +
> > > +		total_size +=3D seg->size;
> > > +		TH_LOG("test enclave: total_size =3D %ld, seg->size =3D %ld",
> total_size, seg->size);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Actual enclave size is expected to be larger than the loaded
> > > +	 * test enclave since enclave size must be a power of 2 in bytes wh=
ile
> > > +	 * test_encl does not consume it all.
> > > +	 */
> > > +	EXPECT_LT(total_size + edmm_size, self->encl.encl_size);
> >
> > Will this test ever fail?
>=20
> With a *quick* look: no.
>=20
> Vijay, what was the point of this check?

Yes we can remove this check. I tried to copy from `augment_via_eaccept` an=
d just changed the request size.

>=20
> > > +
> > > +	/*
> > > +	 * mmap() a page at end of existing enclave to be used for dynamic
> > > +	 * EPC page.
> >
> > copy&paste line still refers to single page
> >
> > > +	 *
> > > +	 * Kernel will allow new mapping using any permissions if it
> > > +	 * falls into the enclave's address range but not backed
> > > +	 * by existing enclave pages.
> > > +	 */
> > > +	TH_LOG("mmaping pages at end of enclave...");
> > > +	addr =3D mmap((void *)self->encl.encl_base + total_size, edmm_size,
> > > +			PROT_READ | PROT_WRITE | PROT_EXEC,
> MAP_SHARED | MAP_FIXED,
> > > +			self->encl.fd, 0);
> > > +	EXPECT_NE(addr, MAP_FAILED);
> > > +
> > > +	self->run.exception_vector =3D 0;
> > > +	self->run.exception_error_code =3D 0;
> > > +	self->run.exception_addr =3D 0;
> > > +
> > > +	/*
> > > +	 * Run EACCEPT on new page to trigger the #PF->EAUG-
> >EACCEPT(again
> > > +	 * without a #PF). All should be transparent to userspace.
> > > +	 */
> >
> > copy&paste from single page test referring to one page
> >
> > > +	TH_LOG("Entering enclave to run EACCEPT for each page of %zd
> bytes may take a while ...",
> > > +			edmm_size);
> > > +	eaccept_op.flags =3D SGX_SECINFO_R | SGX_SECINFO_W |
> SGX_SECINFO_REG | SGX_SECINFO_PENDING;
> > > +	eaccept_op.ret =3D 0;
> > > +	eaccept_op.header.type =3D ENCL_OP_EACCEPT;
> > > +
> > > +	for (i =3D 0; i < edmm_size; i +=3D 4096) {
> > > +		eaccept_op.epc_addr =3D (uint64_t)(addr + i);
> > > +
> > > +		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
> > > +		if (self->run.exception_vector =3D=3D 14 &&
> > > +			self->run.exception_error_code =3D=3D 4 &&
> > > +			self->run.exception_addr =3D=3D self->encl.encl_base) {
> > > +			munmap(addr, edmm_size);
> > > +			SKIP(return, "Kernel does not support adding pages
> to initialized enclave");
> > > +		}
> > > +
> > > +		EXPECT_EQ(self->run.exception_vector, 0);
> > > +		EXPECT_EQ(self->run.exception_error_code, 0);
> > > +		EXPECT_EQ(self->run.exception_addr, 0);
> > > +		ASSERT_EQ(eaccept_op.ret, 0);
> > > +		ASSERT_EQ(self->run.function, EEXIT);
> > > +	}
> > > +
> > > +	/*
> > > +	 * New page should be accessible from within enclave - attempt to
> > > +	 * write to it.
> > > +	 */
> >
> > This portion below was also copied from previous test and by only
> > testing a write to the first page of the range the purpose is not
> > clear. Could you please elaborate if the intention is to only test
> > accessibility of the first page and why that is sufficient?
>=20
> It is sufficient because the test reproduces the bug. It would have to be
> rather elaborated why you would possibly want to do more than that.
>=20
> > > +	put_addr_op.value =3D MAGIC;
> > > +	put_addr_op.addr =3D (unsigned long)addr;
> > > +	put_addr_op.header.type =3D ENCL_OP_PUT_TO_ADDRESS;
> > > +
> > > +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> > > +
> > > +	EXPECT_EEXIT(&self->run);
> > > +	EXPECT_EQ(self->run.exception_vector, 0);
> > > +	EXPECT_EQ(self->run.exception_error_code, 0);
> > > +	EXPECT_EQ(self->run.exception_addr, 0);
> > > +
> > > +	/*
> > > +	 * Read memory from newly added page that was just written to,
> > > +	 * confirming that data previously written (MAGIC) is present.
> > > +	 */
> > > +	get_addr_op.value =3D 0;
> > > +	get_addr_op.addr =3D (unsigned long)addr;
> > > +	get_addr_op.header.type =3D ENCL_OP_GET_FROM_ADDRESS;
> > > +
> > > +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> > > +
> > > +	EXPECT_EQ(get_addr_op.value, MAGIC);
> > > +	EXPECT_EEXIT(&self->run);
> > > +	EXPECT_EQ(self->run.exception_vector, 0);
> > > +	EXPECT_EQ(self->run.exception_error_code, 0);
> > > +	EXPECT_EQ(self->run.exception_addr, 0);
> > > +
> > > +	munmap(addr, edmm_size);
> > > +}
> > > +
> > >  /*
> > >   * SGX2 page type modification test in two phases:
> > >   * Phase 1:
> > > diff --git a/tools/testing/selftests/sgx/main.h
> > > b/tools/testing/selftests/sgx/main.h
> > > index fc585be97e2f..fe5d39ac0e1e 100644
> > > --- a/tools/testing/selftests/sgx/main.h
> > > +++ b/tools/testing/selftests/sgx/main.h
> > > @@ -35,7 +35,8 @@ extern unsigned char sign_key[];  extern unsigned
> > > char sign_key_end[];
> > >
> > >  void encl_delete(struct encl *ctx); -bool encl_load(const char
> > > *path, struct encl *encl, unsigned long heap_size);
> > > +bool encl_load(const char *path, struct encl *encl, unsigned long
> heap_size,
> > > +			   unsigned long edmm_size);
> > >  bool encl_measure(struct encl *encl);  bool encl_build(struct encl
> > > *encl);  uint64_t encl_get_entry(struct encl *encl, const char
> > > *symbol); diff --git a/tools/testing/selftests/sgx/sigstruct.c
> > > b/tools/testing/selftests/sgx/sigstruct.c
> > > index 50c5ab1aa6fa..6000cf0e4975 100644
> > > --- a/tools/testing/selftests/sgx/sigstruct.c
> > > +++ b/tools/testing/selftests/sgx/sigstruct.c
> > > @@ -343,7 +343,7 @@ bool encl_measure(struct encl *encl)
> > >  	if (!ctx)
> > >  		goto err;
> > >
> > > -	if (!mrenclave_ecreate(ctx, encl->src_size))
> > > +	if (!mrenclave_ecreate(ctx, encl->encl_size))
> > >  		goto err;
> > >
> > >  	for (i =3D 0; i < encl->nr_segments; i++) {
> >
> >
> > Looking at mrenclave_ecreate() the above snippet seems separate from
> > this test and incomplete since it now obtains encl->encl_size but
> > continues to compute it again internally. Should this be a separate fix=
?
>=20
> I would remove this part completely but this also needs comment from Vija=
y.

If we restrict the large enclave size just for this test, then the above ch=
ange can be reverted. Calling ` mrenclave_ecreate`  with src_size esults in=
 EINIT failure and I think the reason is because of incorrect MRenclave.
>=20
> > Reinette
>=20
>=20
> BR, Jarkko

Regards, Vijay
