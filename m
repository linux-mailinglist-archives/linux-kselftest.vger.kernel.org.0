Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD8774092
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjHHRFP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 13:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjHHREh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 13:04:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8225C0EB;
        Tue,  8 Aug 2023 09:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510521; x=1723046521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EbLWs+sVhKoFAJ1LC8EpfkrAMk0yeGJ+xD3HuigvYjA=;
  b=Yn8bl/zEew/45McotFSj0gwz1HOAtzwNw9P7Oki8NsmSu9A7EIqhP3XF
   VCaDNAMqal9a895rGsLvBC1fqKikvG+uabBl4No+jKN8Bfy4LyplLQvBW
   4EAI6mNDgSbAd7QyXB6CfYr0UZGWZ7EOp0iUx+DYf3ZbGovsAdHaMtV88
   kKJu8aHCuuQCgIRxQ1nYlIdwYGJS9UVOjhI+n3PRQmmLjqa9sWcD30ZFm
   R5Hdbu4hcrcNXaN7Wd3RnbL2I3/4kD6TxxlW5ZhVsLC2ejr3w8qnUfjxu
   pQAhg5EeHIqQC27EkywtzfEb5Bern6ktNhik4VTRbyOuNMJT9zFkDs/YP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350449654"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="350449654"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 08:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760933499"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="760933499"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2023 08:36:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 08:36:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 08:36:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 08:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a23zRZoe2JJAx/ZdxMd6nlU8vxk6EAYXQa9uJOntn/8cyvjAAtF9fPtXCPuRA9XUSy/0nnQfyB5+kJQCOFXPYbO5+t8wb47DbnhvaLxDC/mJXIaYpk0rE60ETo+ccJSGF/Do0GIHrACRqpE1U3/C012zUp0HDtimDWqILcCJUjqD/ARMtpLEApz/gEMQX9ELNpLxe4Rf+LTUR3N0cMUsGwVcmD3Wf9nStbUX8T0ed2sq+hnxeqV85FpZgGGkd6niGDY+z3XAFKacecT0fQvzRxiSck1u4ue7T4bNNyPiZ1u6OWeLfVjhRAyl5SyM1MGoPpLTYVtKY3fTD3i0YXOygg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBwv8Qa8M3eQVbPMAoOKHuTS2Cld/5+mc0br2hkTNxo=;
 b=OJjoDi5Z2Rbwd12E/8x/F9M/38jSQXl/+fbhcZ7fzzuEmu5C1Qou8YKM0NQaClTlsoQ/qZpHO6o2hhQ5XsjhaqZ9XqJ5zRRERt9NpQYUzE7cbWXAKLnZNfLhK6OJ8dxqhfNHdnVYAR3yut6txyCLFeUBEDmHKSWRXyfEHckrQ23IDHFhQ7WGpZrqp7ldBIVY0lccaDb4lIOG4uu9Agw2Qjf3iGaU+stQdY/IpcKitJadBXwcWEi9dOqf+awQJYR9h0zQwOhLou+D4Udarjgiox51+2u62menj4uV8a+zZqX8Bxhbg3CXx60VyNAYUC+vH68C1FR8k7YydrSEHBoGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:36:01 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b556:42c4:772f:d47e%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:36:01 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Topic: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Thread-Index: AQHZxhdBKtNyRcHbIEGMXGrFUJBCcK/ZYleAgADMzICABFl4IIAB3HIAgAAqu1A=
Date:   Tue, 8 Aug 2023 15:36:01 +0000
Message-ID: <DS0PR11MB75294A425E0FE50B83132D09C30DA@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-4-yi.l.liu@intel.com>
 <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
 <ZM0HO02QRHnIKIIJ@nvidia.com>
 <DS0PR11MB7529E1B07B438DA42B0C9F81C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNI88hEKdIt7QJHJ@nvidia.com>
In-Reply-To: <ZNI88hEKdIt7QJHJ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|CH3PR11MB8381:EE_
x-ms-office365-filtering-correlation-id: ab39b0c1-2cc3-4905-a5f5-08db98252b55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e3lyiZ5z6wQ/FVBXPuUmm9msRKV/8F+YS55a/T4zzy9X11q+QkZNUUaC1NB4qBpdQanDzfDZwo2/5Am8Gsmxi+XVmPvbpPrV1D8wAvq0X/Ewf86GZhEoXezRaOMBwj6MCYLOhm24vKajEZUvRXcvU0dYfpx9JSNnfXEaT6yBwME+NsG2FoE7tD+CbzHxIC5HZED33z736Vmqt73Mky2QOpCy2LFDq9QfPAxxSiqiQ7k3motVIHJ6gVqXYHO0SLiYKs9yfgwNC5pilmEvqcr1r9NwZGC9JcVwMEEwGdgplVwoErPwRTuyxAWuG2vaw1FH7ux8IY0i919EqoNxWtuZf3/OqNsP0ISBOO4y6NtnqVUs00K1PP+hhonYxTOhGDNuqpVPry1VShhj+j6m2y18zhSmkqC+c67/vxh+m4hn4oUq+2VGKgwJdMsQM0sGXucEpgI1hBdrLNe1t9ab8FGBY3mr6zn5K9LgfudX0ROSKPmYwj54Y5bVLOHG50u6Eeort9kA9vdmBKvHvY4fhpZaPWcWKPv14uA8ZJaTVcmxjkhiWg2+btSIWK43m9XkpCYCh/jJUKvCcl7LdJxO3YHVoaMWGCx3Z8oZhj6jqCe1Rd3BJOag/hX1QdTUekHVeFZP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(186006)(1800799003)(8936002)(7416002)(38070700005)(8676002)(52536014)(5660300002)(64756008)(6916009)(66446008)(4326008)(41300700001)(316002)(86362001)(55016003)(2906002)(4744005)(9686003)(7696005)(71200400001)(6506007)(76116006)(66476007)(66556008)(66946007)(82960400001)(478600001)(122000001)(54906003)(38100700002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YrMuCoJTK2AxyweLPNeWgT7UZAPaxUEgEHnafoabRKWtrZl/49s18f66KVoE?=
 =?us-ascii?Q?66tjlThjVrGM+563JQjgbzmu1PNRkPHuZg+/P7dIG5uuo1O9+UIT0/13EqAx?=
 =?us-ascii?Q?P9VCfPOTZHb0/XW9Jid3jQWLLxppRxTrHSPUEwB+G+VoZXj+x/aY0srKW5YA?=
 =?us-ascii?Q?9Ddhh6MfFxBTTlLVho9Tv8t8HaooVz39rnWvf8LnYZdlpcvUdy7rr/QpVxVJ?=
 =?us-ascii?Q?r7ICUVYuWNRJo7g/UKWSk4Xvl06thtCY/qI527IW5mMhrqBE657UCC9k1mbb?=
 =?us-ascii?Q?4xYDA1mXdrWDqVV9cDR9mDAYk/l5AKXoDxgwRvvasWqoZ0adeH8YJDzZXvwV?=
 =?us-ascii?Q?wXjjY9gfDcPeo5iVIOCHY+0RQmdBG480d7ahYTcZBYGN5SJqXnrqGKpkjxv1?=
 =?us-ascii?Q?Yc6s6p3No153dH2QJxI9rSBhA1ZShLb7QjH8K9l7trgAq1c9mfGX7/hCk6hU?=
 =?us-ascii?Q?YVnsVDxBqZy/wD40AyQRqnY0TJCHnbKgr0U6ToDPKuTGNeMKovPmO/1mAWtq?=
 =?us-ascii?Q?CQ7sDesfJdC5Uorv3ZafmTCt+7V/qtIuQdbAN2uKG0LSLvRjrG2JRx0PvGN6?=
 =?us-ascii?Q?Z7DaiGh1gr8YiqaLgU1lEQZcTCepoLYp3ugCHWMU9ZnVD9ZWAJmeLDSGV7Eb?=
 =?us-ascii?Q?TNM4kgPLLiIvloP6QtzBOUPwpmLwEBhQVnU/i1Mq0OUy6CGHcE73nxBSkoc2?=
 =?us-ascii?Q?WDWco3NVqDVwM6LvdAqMf50XJTi3jlhYAxxZGCfUfQlQGvsiBof9WVKUqpyF?=
 =?us-ascii?Q?hTn1cq9J0sbbseSTTt4ITkF7HgZWeaXa2nDLfKZvBrh+QhssnjFI14iTIKso?=
 =?us-ascii?Q?To2zKGvG9z3VODcQUI7nxs/P49+ljYWaZPgAk+WnNkt7nQfLL//bgI6W/STJ?=
 =?us-ascii?Q?Xnulc+txeMCEHyfqtkrXrQiCp5hc+SI+R/Hj6PoYU8wAbvbUCku7kobIWzro?=
 =?us-ascii?Q?5C4Lyx31Y1bvWwgMMnifwrhrEY5EvKy3UQKQ28F+WWbFLZlFILtSbGndHU3K?=
 =?us-ascii?Q?P1XB0hVJbES3hL89oni0YUusn6L+erC/01iI+R3LdyFwAtbTmrmEAtt5D7op?=
 =?us-ascii?Q?ET8IUfAsMauxoqRVHk/AfjZCyOfJ2P2+cDUXfzcy+64J8nZW0LCNnEpsRFz3?=
 =?us-ascii?Q?gpiIYv5UBIHW4tReH7R1k4doXndR1w7NVQOvDJrn5Bk3xt75BvsnaN8hD2At?=
 =?us-ascii?Q?BwN7osKIE6APZYmX+zrElzSQEfM3QgJ/7OJh2zuvDAZePJPXLfMjgWEo1G0k?=
 =?us-ascii?Q?2CacOg2+FrCODQ4cOKQ5mVbwAunGu/rjD5eldZiYg4JTZnyJyNGe1Z4r1fzl?=
 =?us-ascii?Q?yC6RsdBYgo7ldASZk6CsJhlgR4v0onVaZbh8hLJ2XuuvBBOVUuOj3VtDwMKY?=
 =?us-ascii?Q?9JvWHPnlSieM4b+YWf3jdeeHqrhjd2G6U/4bwhIRHUyQuHNlSRg3EW4gxa6e?=
 =?us-ascii?Q?FnjOT6ziCAY1s/TNXtnCgv3whwpMcT35ceHhvh9U5ecdGp+UPGDgR4wPegzJ?=
 =?us-ascii?Q?aX+moDxBL8LBUDWI1ScHNpm0zvrA9p+t/LIxl8CmKXH5U72MTOCa0etVzQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab39b0c1-2cc3-4905-a5f5-08db98252b55
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 15:36:01.1041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3hF+mYGN8EoNRq2sb0KsagjsIOqtRs4HRntoBU5aLSBdZAd/Nd/obDmwKzfpitZYzeaUfHZijEch6YjAczZ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, August 8, 2023 9:03 PM
>=20
> On Mon, Aug 07, 2023 at 08:49:27AM +0000, Liu, Yi L wrote:
>=20
> > > > > +	/* driver has hw_info callback should have a unique hw_info_typ=
e */
> > > > > +	if (WARN_ON_ONCE(hw_info_type =3D=3D IOMMU_HW_INFO_TYPE_NONE))
> {
> > > > > +		rc =3D -ENODEV;
> > > > > +		goto out_err;
> > > > > +	}
> > > > > +
> > > > > +	length =3D min(cmd->data_len, data_len);
> > > > > +	if (copy_to_user(user_ptr, data, length)) {
> > > > > +		rc =3D -EFAULT;
> > > > > +		goto out_err;
> > > > > +	}
> > > > > +
> > > > > +done:
> > >
> > > No label here, put it in a if {}
> >
> > How about below?
>=20
> Looks better
>=20
> You could also consider putting the content of the if {} in a function

Sure.

Regards,
Yi Liu
