Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BE668CB3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 01:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBGAfG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 19:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBGAfF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 19:35:05 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B713D6E;
        Mon,  6 Feb 2023 16:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675730097; x=1707266097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/gWn3VNgf/uuNMOaj1iY5A5/QRffDhqoSdYo1thrtAU=;
  b=iq8cUg2SwqPTFQwI/uWPyAJ9lU2KzdATtRb8umAA/N6GKfPRYnEDF/zh
   j4WewJUHHaVu/6EM4pYH4IJ7JYjHJTnFcprbpaSKClKiprxCsw2Aj6jQx
   772aAEyAO2tmNqYzmXVq3xyi2SVUkxadS0DuB2VfZeIOH+lO70FIPDOuf
   lpu5edY8F5AKSt+GVUMyAIoP+NFr5evz0dt4QRC+77rcmhQzBBgb41tep
   OJoYeAMJVis6gG9G8ceDggiiQfiDv8e8PfF+nhaHjHua20ddXuSY5do1o
   D9bqMLvukfk3iNXjErJHmQBfkw4A+che9OGcXutNsu9bK7vntgQ0TmLRr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="309004232"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309004232"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 16:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="735350043"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="735350043"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 06 Feb 2023 16:34:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 16:34:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 16:34:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 16:34:55 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 6 Feb 2023 16:34:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAlVOXVIJ5zTRi8LJUsp6CV33bRmbrGyD6zV17zpzNHZJGY3Y9qChuT9TI3YnAqQloTpiWrj2dUTh5AJ8Ml6HyvaiaZv9Ab7gkWsdaHOlG+1gF332mifIhpt139gmZQiqXFfXqfTidxTvfPbLmdIgXrXc0/fYafz8fEdpz9Q/0lgUUk9MgcypLYtLYr9FHKDDq8AkV6SWGVpRADngXmKgHOmCPAZYq5e21OlXHGOvSJMr7wu0V10ep8JxX88VnpjdzlvbGjw6n5C46A/ohJ9gcPlLM4e2jXEA1Bapsx/6K+4nvDdV2g6pC6GbihT8ORt6yBLoUGIeHDHSXt1nqcG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gWn3VNgf/uuNMOaj1iY5A5/QRffDhqoSdYo1thrtAU=;
 b=kk9TxUf3WbtH4HTars4xJwxxpEm8y2ghLmaqoqadn9QaxA2/a3nMvGma79MTLxyw1GVctVVvWIh/QL4OX/4301KXhgt2X+HXTlO4KkOGPpliHFOWhkvWzgUvnK0oXMrb8QMuGHyMacfaM+4wwS1n8JM2JSHmk0XWGiLf+zLmH9EmP6CmI80+leIh6EtoA+KuJgz3lF2nzSTXfzjAdWI+vKGPlF1+yyxrUPcDtLE7IFA6bY9GP2PzKemV99gTy25my/JVYqy46YzgLsOlwHyot17tJ51z5l5nn5RMyrDSjH4YqRzFjd5qgA7srn5DcNFMeVbF6/jTjzbHIxWgt4xgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 00:34:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%8]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 00:34:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
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
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1 0/8] Add IO page table replacement support
Thread-Topic: [PATCH v1 0/8] Add IO page table replacement support
Thread-Index: AQHZNtTGXgNRh4XDNU64JbwG3sv0b6683tSAgAB1HoCABClQUIAAckAAgAC6ZuA=
Date:   Tue, 7 Feb 2023 00:34:47 +0000
Message-ID: <BN9PR11MB5276918F3FFF87555F84CD1F8CDB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB527680F63EC5443DD7A5E98A8CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90ieTgl7I2GZfsX@ziepe.ca>
 <BN9PR11MB5276A84ABA311151949215518CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+D/9j8Yc444k8QE@nvidia.com>
In-Reply-To: <Y+D/9j8Yc444k8QE@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4764:EE_
x-ms-office365-filtering-correlation-id: a2172423-2eb4-49e8-84d9-08db08a31e0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1BHYpSQlt7YHNANkFrWqmaGPNfRISa/DtJcuHs6w5PVfQonSu65HjeGLNSwWzM/LXL8HIm5TcRRQ+lpYdjv+OTA0bAfXUKKZvXUZRLTPfBqoNeZhSurgT0qXCi9D4hkIgHQMDLD0uSu0c1KxOruKZrFOeGci0DB+kVBgfcxgKWj7wQrwJGaNflIVHhEf3/76CmUAaJ8NbOtolLmqEkWXzy+0wTHM7LP63+p6mUvn/+3p9HCo4qUyx9dWXtFG7aBK4k6reRpFsFTdz7uDNnjoCDjzM5nSvb+07YCtwe7Uwj0kZWOVtMlXG6cOVrBkN7pUXiMJstk6zOIVggOfKldWLaM6KvzC53E3IfXhsqarYVAfuiwrqRyuOphAeOmxxH94SMcfFrpFbIlGbfyDPFdmkPIOmhzpEIXgVpjDv9zClkyBJ7WTNDBTRJx6tMOF0cwgdkr9MAUnqU2fBmI4qQ34/ShtWRWeXCnfE1LeNKVPLbX+NahhH5MNEdT1+CGjYrBZemkevg8zyLq31qoRIz/ii/doUsiYzbDLJnvaIX/6qGM4SRTG8dZMojF5CmgwOJeCGcWV+/gWmIGOKTnXKvz0AWIdKa+35P2txCz4rJhrVZSpcSM+Ufa3Sp/4oDyhYs7VpTHAuGIlXg5CR5ZoJ90krDNKtGiyOkggsPW6ttocOWamMnQk+WB7w3fF+29y1EbRiG0O2J6WLY3CkxHKvbcu9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199018)(6506007)(2906002)(71200400001)(54906003)(82960400001)(316002)(55016003)(38100700002)(7696005)(33656002)(86362001)(38070700005)(478600001)(122000001)(9686003)(7416002)(26005)(4326008)(8936002)(8676002)(6916009)(52536014)(76116006)(186003)(5660300002)(66446008)(66946007)(66476007)(66556008)(64756008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9lrt/7mplEZX4XG7i0Z3P0wjA046BpmITgved8EUs0mUIAyUWz8pJKtX9jt3?=
 =?us-ascii?Q?Nx3+0N9TTHSl4ndt2VDFK1g69lNMTKOBabnQ3b1ctQgdxsFCJ9nt/4x9CdNY?=
 =?us-ascii?Q?GlR8x6fbvOfwzyChROrI7W5EaOrO37eyfEuTiRxLqrFKucNhQXxtIJvbomcO?=
 =?us-ascii?Q?KFZPukOJysAP/JjkZgO63kfYEMdougYccgLGdvxcGn40GTyvrknSjfY5j7VN?=
 =?us-ascii?Q?ihBKbhSJf8zeLAhnFm+2QeVA4uLu0vNqsRm8DAN25vof6Va5eacLElYUeUwA?=
 =?us-ascii?Q?lcANGovT2rkPR8JfYhootc2uRIQDUz1sgBQeYq/3nKOTd1mrTuEVrXMCziHJ?=
 =?us-ascii?Q?oVvOTd7h3dVwO2h6Iw9euFbtVqJVXWu6e3HbY+RrSI636DY0yPXdldAaOkC3?=
 =?us-ascii?Q?wDRfoOzPcLXQkg74FoY7l3KAO8W5KemglJ/cz1oeZ8As8BxpYPkzNkKkFBXy?=
 =?us-ascii?Q?VjYoIS2I1cfEMYf+3OMeX/hlZniiVt00J2jxV9C2OEWaP3fixcct/NWwe4n1?=
 =?us-ascii?Q?FLHuXKloPN61r93T2vjHA2vAoQlDgTNZA0wM7g73Wc3tKcaP//H68O12ntW8?=
 =?us-ascii?Q?xjf4BzqOpYbEcp1XcF9lcBMHakNXpQuScBQKQtZfjosrksDlYUT8TWmbFU3f?=
 =?us-ascii?Q?QJm4EfuRjElA3T7D1KbSCTmSniwg+kcjonsGhdzXLuQGlvZKyxfAJcgx3mEH?=
 =?us-ascii?Q?UzdQ8KQ7bP8ju5dlVgW+dlvOvX/8DkpDYXCbBM6crwHofBtPXYsKwKTFVWVc?=
 =?us-ascii?Q?TaachQFJxFdbOwkUDv2JnrFm6nQ6VySgIobdAU0zuNPtF89XcaxhRvm/NhqF?=
 =?us-ascii?Q?SYoFbZi8IqMRHcdFHITUsHMpGo0TrTVomIlHpQjpOrySRemjBNDHgDIMzFb1?=
 =?us-ascii?Q?6JTXSOddXZTmKaOioh+tUfwj+/0BwAR4V59OT20YCXFG+sfYA4PAvN8zKLMx?=
 =?us-ascii?Q?+aX2VR0/kcbLViJCUX4B2mN7wpVH93bxH+x1Q6iKj+jxdIkqQWdv37b0GTZQ?=
 =?us-ascii?Q?nUYZQnZYZUKdfZMS+4vYLT/b+5P4eJh6AC+me4FCK48eR7uLFOrwnNRSDRPT?=
 =?us-ascii?Q?Ts1CiUswhZcN9HnkPBun6DoWiluFs8PUZ+X+/S4EyTUtLCDadgKxr7rbiBoP?=
 =?us-ascii?Q?/qeaGbyIiHfaNywfC/vSbH3Wf3gSd53dUmURvTN9mAi/mYBtq/GycwnwPWEk?=
 =?us-ascii?Q?ie5bjWmUVsVcOA0GSnmmJkqlYigGpAu2PG271WMczZrHf55iXoETkFvb5shM?=
 =?us-ascii?Q?T18fiunLBUMwOua/0yDjuSq8kba8SUIQPkiqXBr/66nvBx7rltkOHVPE9oGi?=
 =?us-ascii?Q?Mdy9KrVXSdr3JAPLxELb9KoonD01gYZEwJI3bgsgLLpCxqv+sFl/agfbaTkr?=
 =?us-ascii?Q?/e+7/eM0wS9zTPoQnFgcj99xrB2f0lzjHfYbhGvoyVrBadgbQM0VSN7l/dgX?=
 =?us-ascii?Q?o6pq+giY3eQH5FfrR4huFPG0hEyDrlOukLnczhJd7+WLMqnyzXu+pGQWZhBy?=
 =?us-ascii?Q?xEmPOmOYGtTTG0pqWjudpNJLssmZbtfxlnvsLzWQ3/2SnCehVmfxtfBPmJzS?=
 =?us-ascii?Q?SRc5+i+unDvAOIj56CHumyDb0Umxue6+H0P2WUwz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2172423-2eb4-49e8-84d9-08db08a31e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2023 00:34:47.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBwlzTkzBHu1J0TJ2l4yBdCPjEknnwc4igZLAYcbIZ4eWGwUH0Nt7FDtgaYgXWwSRdY00UxrVfgPbKpv9XrgSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4764
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, February 6, 2023 9:26 PM
>=20
> On Mon, Feb 06, 2023 at 06:39:29AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, February 3, 2023 11:04 PM
> > >
> > > On Fri, Feb 03, 2023 at 08:09:30AM +0000, Tian, Kevin wrote:
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Sent: Thursday, February 2, 2023 3:05 PM
> > > > >
> > > > > QEMU with this feature should have the vIOMMU maintain a cache of
> the
> > > > > guest io page table addresses and assign a unique IOAS to each
> unique
> > > > > guest page table.
> > > >
> > > > I didn't get why we impose such requirement to userspace.
> > >
> > > I read this as implementation guidance for qemu. qemu can do what it
> > > wants of course
> > >
> >
> > sure but I still didn't get why this is a guidance specific to the
> > new replace cmd...
>=20
> I think the guidance is about the change to VFIO uAPI where it is now
> possible to change the domain attached, previously that was not
> possible
>=20

that is fine. I just didn't get why the original description emphasized
the cache and unique IOAS aspects in Qemu.
