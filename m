Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C516B6D40
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 03:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjCMCES (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Mar 2023 22:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMCER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Mar 2023 22:04:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689CD2B633;
        Sun, 12 Mar 2023 19:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678673056; x=1710209056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I6n1764iPq3QLkU9B199QCYPqBydWrtjMdH/HNzCMGQ=;
  b=Yd2zSlVJcVZWTNMNaS6LZzRhY9PhZyHXrEYlSY1on/UdRCT++/Ypdx11
   58C4eBY5O+xD0fEOCHxwZPoDgrnYb4fX9o2swKhyPF0Ib0SNM7Cxe1HW/
   lKaAm8hfyjGM5QmRhLztw0Z4vJlwA/G9cbSRKxW3kzx3vUsovwfvRAivi
   R+81UqYJcrwkswXWJY9B4lTUY9QH/+GqHPlFPR1Ba/WaQ0j3ONdGcpr77
   b3K85A0ZLTjuI29b0LXm1jVqcX4BVr2cU+5oGse3tXZ9b22fIHb1fwrQ4
   oBSHR2LKfEPEb8VbUOBGQ5Wft/qoBHXH+dftVzznUQsaGPl7ejnl1OZyf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="334514373"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="334514373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 19:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="747434681"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="747434681"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2023 19:04:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 19:04:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 12 Mar 2023 19:04:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Sun, 12 Mar 2023 19:04:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Sun, 12 Mar 2023 19:04:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfp0gJ8p/jV4MuKW+xmpfRJIsgK9n0CZF683q+wHbF3UAhPlV12bJdWLAONqaCfkZ45KXXgkVtCB2ecazt1puoaLT7SIus+ST1os1pgAkyt9uJJSMg5scSoU6qxwAV8i5qvD6FD0DO1tIYpY+rWAMXdaoClenccMG8IxRPuoVqIm9Kfss9MkOpRwVkefZa6VwRGSPhLNyT/VMwM2X69Z47gS+uvm0wEmgKwK8595QiUhyufNuaW/69p/F3MEdw/fyiYXm0Jd5n4JVyHjUbarvjY2v5b8JCj68SSs2shYnr248a6Dp9nlhhWQLL5vJGw5wBXMpE4c9s9NyUYoTijNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOQ02U1t4sh/Ug7jE+EFBWixiK6D4puy06PyeML/RQ4=;
 b=aNaIxylyo2JonBU8XT47/xBQqRMxqDT01bxdx7AIW0rBifhySHEIkGb3wVZVO5Yzvja0v4w03JJxGx0Q1G3xodRDfvyDbNT/beBhyYfEWaZm17iEm9IySASswAQDn+ymdi1u+ZEosaQ0MeVv8LMyaMEL4TssTHe1/y1TtftUhz8TCK8Gr7Te2Zs8Lh+TnoReVBq8V8VA7TSCw7jsqphdKntC+G5RIqTMj5/A99wC0Pov4p9n4o58qEHUakptVpGUsiBThLPiTERTsOIU00PqDl1J86h5t8A7uZAWJGPh2ZXNhnG45DZzwi8vo9gvXvqQtDu6AWtrbrFt2F1KoR5anQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6055.namprd11.prod.outlook.com (2603:10b6:510:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 02:04:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 02:04:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: RE: [PATCH v4 5/5] vfio: Support IO page table replacement
Thread-Topic: [PATCH v4 5/5] vfio: Support IO page table replacement
Thread-Index: AQHZUcoFRLfg4HbeIES7vtug94baI67z6iAQgADFIACAA0rNEA==
Date:   Mon, 13 Mar 2023 02:04:04 +0000
Message-ID: <BN9PR11MB52763E69446196B5D4C109E28CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1678284812.git.nicolinc@nvidia.com>
 <600343ffb282ff3bed5eb98a9255c0084d01a859.1678284812.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F7F917F76DDC0D9186DD8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZAu/dHzS+ZcLfOHY@Asurada-Nvidia>
In-Reply-To: <ZAu/dHzS+ZcLfOHY@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6055:EE_
x-ms-office365-filtering-correlation-id: b115db5f-9ddb-4abb-9afc-08db236738b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CP4Fsm5ibHRcklgmi5smqJz3GhFefsbkXssv6KN3FTik8htfSU4XX9q+oDBFgqeWxu6vkpf6mv8nX0zvd2qFZFvVpaOQeBP+S3Zynvkbt8MxkSsY8a1Kt/50HVE3uTbRqCq4YE59P85VG4wK4fQ9QVJbWWzAFH+F7iDu53o+cCF9FGBKiznHzuURwKDa95t87ufkGMV1BeBW66hA6M97kRVbARwua+nFk8svvl3qXCRSbqZJiASvEVo0ast8f/5yHG9C4IDkI8T42QfxI7Pykhf/U8zBtwg2kdIH0xkE3MHrWGvCjSuN20cyjyRFGE2p1cjeyUIhsYM3RXArjJklWmziXGLdEUNsS9PxhtflPRSbhqQdl8lSeR8/00CwgOzr8o4D5En2EGYS+hZdrV7bhMPKNXmHUXpBq1ka2Bjtr7a6lSKWOfkH+yBA+h3cz1MGQNwOwTnzs3MVAGo0EKMYBWK0uTIOZFPxOxsloWClrM8HGzsmkhCYgqV0bl5Azor41B95N+gfEXoYpFP4PuFPANbA2LtEPZ7UGYtmHTzQ8zBk3hRPtaMTPniA89E8dLz+UCFxQDMlhVrXYJxf7xc9v70RQnPrJEwE48go8mSjcx8Wn494yXgfQL2TbM8vsK0jILT74jpUlWQ5HeQL8Tf6J1fhPRMTSbz/vqHJIwvQZFqPzY8ImEbpcLjjhMil+kNRaV/BQ7L15XRHpCiAh2lIEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199018)(54906003)(41300700001)(8936002)(478600001)(6916009)(66476007)(4326008)(66946007)(66556008)(66446008)(64756008)(52536014)(76116006)(8676002)(33656002)(86362001)(38070700005)(122000001)(55016003)(38100700002)(82960400001)(26005)(6506007)(7696005)(71200400001)(9686003)(186003)(7416002)(5660300002)(4744005)(2906002)(316002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GanRegBikGGqy2/jWmiB76SXhUv0oP8Z4JYyO1WbL/Cw4RQdeMXUsx80TUoa?=
 =?us-ascii?Q?8hMYGXjPbXwkzNhgtca+aX8dyUfST89IeKqn5BWd55TPz9r/Ci7gJDsrYPqf?=
 =?us-ascii?Q?JfLfojs9ztnP+DuS9qcymUHHBeRJDKZzTj7xGNIj3rRsVhGsKX337RsiBt5w?=
 =?us-ascii?Q?7tWG6Tg20tXhtBIIoy7CLb98vNCVzFeMvUB680kdHVxKdbzhDinPd/HZuUwk?=
 =?us-ascii?Q?Hinl9CJ2JjKgEQXtDLaVlqsF/DMM5KuaoZxq9RVUst4+MUD+1ke7q9aqGMmS?=
 =?us-ascii?Q?OmdoTgam8ye8E3u1cXSFgJfirZfixk00g0S6Nq927vjAIj8brn9wpVaWfGWW?=
 =?us-ascii?Q?e7VF84JR/bgQE/ZvMypip3+1wXoeb/TmJkyhwsLJV29MGZWwtUtTk6OYdD+0?=
 =?us-ascii?Q?TSZWVtzjd7E0014HGt+m6FUiqosIi9eNuesWmsBPi6rCz1Wa1/BbLbGQlkV5?=
 =?us-ascii?Q?XvFZyw71LXo9uXDgVzqsn7hYaUpchiEaEzwPBNPZA/h/9TBkoAEd2kdV1pyB?=
 =?us-ascii?Q?4bNs4iieaZ+GCPqJqWYuEKbFQbJ84FHuZwkGQj6S+R3UukfWWPOb0h6+Pgkp?=
 =?us-ascii?Q?SrHfPLOIFUWQoEEyLh+ReCmbI0d4+4DxrjlkdXEBfg4W+nKWsQOezYan003G?=
 =?us-ascii?Q?1f9I585Kzq+p+FkZlxOfSro80bIXFT9K8jTcSmDX5Zp6WL2GNBK+9Ue0HeEr?=
 =?us-ascii?Q?/fUeEp+1P81q2G0b3YhMLWQfXNB6bbopraRVeBRxui0l5JtsobL0+aFbs1N+?=
 =?us-ascii?Q?IPSO0jBsX82lFCuB9BTQiJ3HgzdnFo8j9hnBMAXEWgIe5dADbmmr45GZQwJM?=
 =?us-ascii?Q?TVM1rCgj0Xbsiu2mBWlWqqAGQgcEPGWMVD9XvDTt+Zagfqun/Y3qzpq3LESc?=
 =?us-ascii?Q?pUi9qI5m+vmNdWEWHsbSobhd2wo3WcJJlg7tSJ/2cFWmvZy/Ze5/ExOb32ya?=
 =?us-ascii?Q?Wr0WlXTRIR5sKePTRmWosaTIn2BkC9/QzhAyYeE0UlpwGURvOUiIJjE3vuyq?=
 =?us-ascii?Q?vjQGoQhGeEcX4ZID5PAhldRBMNPeqeOtMQ75F5zWY9Ha3FUQNz6NoBjv2NW0?=
 =?us-ascii?Q?k9Mcw06HwFVJK1Jg5/qMoiTicoMVK6Befwg6Oou9JxR4jbSZll8hmGzUcLzi?=
 =?us-ascii?Q?1qjWzWi1Sj1r+b+bkY1thTfLN9/9ws3NL/IeZKG92ZRjWzZDbVwAptD4G8k9?=
 =?us-ascii?Q?FqEoBD7psbQjj9PBwG2TXDZ1fsiEYByZvZ9lM6sHi5+QXzEovkT1vvivar88?=
 =?us-ascii?Q?dtFjkmCUj2U1byQWXUIKJUfFDyBh/jJEnFoC3yKXEgMjENudubtaARFsR9gi?=
 =?us-ascii?Q?YiJ+Pt8n2JwBzsz5mVnKSxRT3TaBMfVK60Hj69YKH+77TJgXp8WTcHWGnsTw?=
 =?us-ascii?Q?sN0A7D0LnXZTLv+arjl9WPEOfJK3ZWLVy68ATJLTAG3j+SR/0GnXUs9ooc3U?=
 =?us-ascii?Q?aR5JVO5Y020iuFZ+TzFExjf9DvKpyDbbbiMLuATTTTMAWG1JyqCYsipO74y/?=
 =?us-ascii?Q?5TdegdrCHV1Muo/1dbAA5wfcNYx8cHXj5uVoAJssKjXNMNkcm+Ehulu8s7yu?=
 =?us-ascii?Q?baA24x/RbYw6txkv8AALrN+DCbl2QqV8OW7jkN30?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b115db5f-9ddb-4abb-9afc-08db236738b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 02:04:04.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CY2b/1jFicI79QC1D42KYcdqaukZpr7zAZPRblY2HIi1a+L+9D7i2jEdAZe8XYOvZ6dbvVcCfAhhnopk/z5bWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6055
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
> Sent: Saturday, March 11, 2023 7:38 AM
>=20
> On Fri, Mar 10, 2023 at 11:53:56AM +0000, Tian, Kevin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, March 8, 2023 10:26 PM
> > >
> > > Now both the physical path and the emulated path should support an IO
> > > page
> > > table replacement.
> > >
> > > Call iommufd_device_replace() when vdev->iommufd_attached is true.
> > >
> >
> > why is replace enabled only in physical path in this patch?
>=20
> The emulated pathway does not call iommufd_device_attach() but
> iommufd_access_set_ioas() in the other patch, which internally
> takes care of the replacement for the access pointer.
>=20

I thought there is a similar check as in physical path which should
be removed:

	if (vdev->iommufd_attached)
-		return -EBUSY;

but looks it's not the case for the emulated path.=20
