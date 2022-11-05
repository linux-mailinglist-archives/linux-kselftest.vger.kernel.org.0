Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA961D920
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 10:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKEJb4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEJbv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 05:31:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ED61B4;
        Sat,  5 Nov 2022 02:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667640709; x=1699176709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lnoeH8ImXyB9OIKtjUTL8lTBgIRM9wzXyKyHn8+HB8E=;
  b=Sx4vI5Jc1CU7Vp8JI+m/PX9YfM8EHl4jlrwvZHChhuccK7HloqUfNLx0
   Bk5d1r4wELgK9hTnmRiiQXwPjnWIXolbMpxxuJqtA+wQfwT8L9tIGoLe2
   KNeDWKJoipx3+Qy46WqfEvOc0lOo284C1LmKwZ7L7rTh2iNYbnFOlSfa7
   DT8ZGBeBgIvA6o22dabIJb2/oY5VwVoLYsIhS5qnZ+4ilBlQzMBkTmtpj
   Z7S17ASctShTAsM03gjkWyNHnbAlj+TkS1UIHDWrpo7Nq1O5D0kuPxK6N
   oks+O7u5lvc4kf/F+eKhiAsqb1eBDptNr06yU/GFvPXxswwSnTIYbaDtk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="396444803"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="396444803"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 02:31:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="964610537"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="964610537"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2022 02:31:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 5 Nov 2022 02:31:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 5 Nov 2022 02:31:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 5 Nov 2022 02:31:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktCmpt9X0RM/fgbuLkHou4/JB2Bt2DWJbBYyiZNQ576Z1U/2ypdLRd0DkIEEU3ti1E0KfI6NyRAInhUiVeZqJsxcog8Iv1gHtOx9KxUbeE+H1oc22nOJC+82h/FfcTddGxzBXM9hQ+gI2MccAz+B7FkiliXAt0aM7Dlp2+/bL7aAlEukU8pfLnC2iwj1OZSuB83X9PFK4jjHoM7o56yTn+N70wRNQJ4nh72h04+XMnVllkciRfPYHZWlIYc1Hfb8CAFPkvJS3HIR6LhQtq71vtDwTjS9ubP6+UOBgTaET4uj7dYuK5eiVorL/NcJFXQcsKIzJfs7JFIYY0EnnsTn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKk1QPJcKyahn3uH9ovh79K/4tvEHUf8cozGi6WxZlI=;
 b=LsIoT7G5+1f5H/g78R/m/fYw5YI4hOXnjGSXm0cjntX+P7S9KUYxnl+6M/P0aXRqb82scrg22bhqFyapjrHKVvGBH/euUwbLMELuvrXUy0PtvEjFph8IBuWQURxGIt5mdk3nOOuIuye+1GRiKpdUkou2khhNeAeNreybMRoXhTkd58/0mC2f3nECEINEp3FufS0F9mnR0iW1KorIR0Vwvv4qHJ1ZrlGUKiQCMFW6sBC4CivLBk0WR51ANiHQvxYNGo1Da5RzFwzNz7akjFHu2KJxss6xKZ9VavnsHUCLX3l46EeBLNu5An40QD2XiDnboTMVKWhkKCgz0Q/nJVOoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sat, 5 Nov
 2022 09:31:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 09:31:39 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: RE: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Thread-Topic: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Thread-Index: AQHY6J1rgVJHY6EaeUmpkBEcYy6wd64wHMEw
Date:   Sat, 5 Nov 2022 09:31:39 +0000
Message-ID: <BN9PR11MB52763ADFBACFE7AFE11F5F078C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6334:EE_
x-ms-office365-filtering-correlation-id: 5d68ff1a-0bf6-41fe-f446-08dabf108af9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /XW5w/xNpoMoyGIFuDA5ialGrLMaDjqzoBkl+QvRur1LIxyknQ0JFlY20DhMla5T7Q2RPqJpnQZR0bJ8pQ5IPesjrtnByqRSsXEm9yuBSt7k5Cl6Bd2bYA8sm4E69yu50MJN6wGZuwPEUfuaxv+Oi3uPCvMjxLonpWqjS+ROvZQrpC7zNNrlOPKXg1HYyYoKSaiPqK7MnAd7rXWSBaqGsjbcRcvGBRvnBu4qhRaz76eK6AjrWsHG/muvOjsofEFkpZPpJOF5e7SRK6a9mMuRYeJ6yjNnzq2dQqhK/H3LokMrMXMf8BlX5y2itgFyoTXIRygS9Zfr0JLky6FKQWt3jqJn8l7pp1/gKFBVMMFuMMUwe3SnQ+tvIWu04ni5iHGwIlnrXJn0Ug2JsPTQMb32jT+/mX4WeUBscWAGu4VlXhImw9m79QAWDkrav1It8JrvowlWf5uL6Yya+NsuOg/eMDiQBtA7elpr99EgOcmds1026NPSoaomtIYI3I7CQ2rAXkzkEk0cBQ2WIcXWU26uDq2FzWfiyIo8gnJeviDpqCUaHVHhdvzQtBSGYpRQwxzHToDcCZkzR//PDhCWerI18jovTw5Yxc/Gx8TbO2rG2OBmd39PSMnBviVLqeziXpcGIdzy7CKtNF7U3xKSr4lwTM3o7HRYSf28aHYrPCTp03GGqHWeP9MCs4vvApPD86WtfxX9K/9nzPiVG2T+87JuYnxqHgWaMKhLatp3nqjoeocSckWt9fGmklSSzWMkN/n6ZOGZxeltAbgomcpEZSYoHPpQNbmLwOazRcVT52sQO1w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199015)(8936002)(478600001)(4744005)(7416002)(26005)(9686003)(7406005)(5660300002)(52536014)(41300700001)(186003)(71200400001)(55016003)(4326008)(66946007)(64756008)(66446008)(8676002)(66476007)(66556008)(2906002)(76116006)(33656002)(6506007)(7696005)(38100700002)(54906003)(82960400001)(921005)(122000001)(86362001)(316002)(38070700005)(110136005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cB+QyDk+JHFazOk130wHx43mQRQGGAUDDdh3tlAX7/t1fVIZPaW0bqcLoVqc?=
 =?us-ascii?Q?Iwj0yvXzAUUgZWNJ1ST4gqN+PHir2uXS6QyuvBWo5g/XaItL73Ylg8g9Herh?=
 =?us-ascii?Q?4VHSsshrrDjzEwqg291/F+DddT/Hc3/K2rtT3og7bnQ6mHR6oi4Q07sYkV0X?=
 =?us-ascii?Q?hijGgQ6PjWldCll5s9K+nRou5SlE8Vuv8dE+y4ZnekRdE3n7sw6qN43OAj3x?=
 =?us-ascii?Q?jfO5QYLzwZ+mupLAjkxrNLyun5cSjjxwcllJP5kcavi/tSzVK0SJT7IWwEsg?=
 =?us-ascii?Q?JzJwarL8hU3HzBz90n52NMYDsNWRirqdksCmM+y8OWf7ot2A18jWr1/D8QL/?=
 =?us-ascii?Q?zG1APZXKs14e8lob5s2fLvfuH3AAf08i/4juU89SJxMaOon29OruaICxuLIZ?=
 =?us-ascii?Q?MdFha8WZIPMQKJObpZOI7Fqm1yaoycA9eZHcecxpwv6+6WlEUth9zCRwu+MD?=
 =?us-ascii?Q?BZjvJrpyJAQx7td5puVK/E2slIJwlAcjH1CeCeVvQ4YlXuok+RMy1qGv/uL5?=
 =?us-ascii?Q?LuXMaT9sfK0XAYfZL3Fo0GvefuyecqO0JlBF3vm6N4tBBaOnx/KyjjgEOE87?=
 =?us-ascii?Q?sTlrx9Z0rIn6MA7xZWYYCpuKEugUAvy8l0+X1NewW8PpO+VQsMh1ZKN3nzk7?=
 =?us-ascii?Q?WsT+gkTGLZwRHCe4DmX0qfF3FBz1GJh5M6OQ0iDZZhd6wDGqMt38HOeXdELz?=
 =?us-ascii?Q?z9KIKAym4BT3Ew6P+vwWFkO6ABIhlkbBLupC9Gr1cmjSvxapKjUNKVPD9RFh?=
 =?us-ascii?Q?9ta5aF4H15Q67WEFTAYfF0Q3Mb1E+anvMYslnBkjWEAM4GmjTGw5lrBr4YFz?=
 =?us-ascii?Q?j9lsy4yneBjOOew4ekaCfjNQXKDIAVVGe84Jq41GJDNNW2I9iizKA34JUJpj?=
 =?us-ascii?Q?vvDEpu0fNDTc2d+ANWzTrU7DbLrc02cRviYif5kcOGw/I6qLQLsz3P34J1Q+?=
 =?us-ascii?Q?pmmdJhS2Nms2IBny5jZROUfMfurfkGUbMOXKAbiVupwFh0eZvCTcDlPk563m?=
 =?us-ascii?Q?PX4x82gJ3MBjlub6rTJdtSUDaSZ+dN3Mu/nJ1grt2c0sc6HW6eF5w73v4eW1?=
 =?us-ascii?Q?rF+lOD++GL69UoTo6uttJRMt4Pvtzh8sc9CyAMUum8X1BOVe0PAluBSG30zJ?=
 =?us-ascii?Q?H8qD7eQiOLkpAY/mgraCzbLyTofBIGlaOf47pgXp69FcKUdHvYafhr3QCz91?=
 =?us-ascii?Q?fwBShb01qfpmVagY5bZdo0wGJuZKzyPEj+RCFRqWA49B4eTwuDj3xtyyiSEi?=
 =?us-ascii?Q?P+wGc8+rJcFrc5DrILzFN6Y4mvGvUOKbSo8vqqu5FvpgH9Hg6HziQ4ZSMMPf?=
 =?us-ascii?Q?tx2Dz+AtknvM4MUbfsuHESK6O6uMduSuvtR+Yr0FhP7doc0IpIWuthJ3/JPX?=
 =?us-ascii?Q?eQtJRCIEPVDfdDL/8dfSX1gE8GZcNS1tm1PfJFklS6tiKYNLVudp4tBK8EDC?=
 =?us-ascii?Q?8W637rMqqb125V5riexnMZTPjZhfBoB8g265Bia1MFoYg6ynUoOfJAOU64Qw?=
 =?us-ascii?Q?cnniSlG1DaoJFNVPLv821Rf/OaogfGao8mSqHgMQcQxjeHhIlg0MTCr+BlxT?=
 =?us-ascii?Q?S5CGyZNa3UuORo0mi5Dlf+3cRcx9rmkpY2Usht+S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d68ff1a-0bf6-41fe-f446-08dabf108af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 09:31:39.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clCx+9FMbw5yk/cQDNrgB40WXVfy5ZeXYWxn219ciJi3KHzpZ5J3HBs/xlbc4qcYwb0b9GS+OqoXldqH5EmC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>
> +int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32
> *out_ioas_id)
> +{
> +	struct iommufd_ioas *ioas =3D NULL;
> +	struct iommufd_ioas *out_ioas;
> +
> +	ioas =3D iommufd_ioas_alloc(ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);

I tried to find out where the auto-created compat_ioas is destroyed.

Is my understanding correct that nobody holds a long-term users
count on it then we expect it to be destroyed in iommufd release?

If yes, probably worth adding a comment to explain this behavior.

> +
> +	case IOMMU_VFIO_IOAS_SET:
> +		ioas =3D iommufd_get_ioas(ucmd, cmd->ioas_id);
> +		if (IS_ERR(ioas))
> +			return PTR_ERR(ioas);
> +		xa_lock(&ucmd->ictx->objects);
> +		ucmd->ictx->vfio_ioas =3D ioas;
> +		xa_unlock(&ucmd->ictx->objects);
> +		iommufd_put_object(&ioas->obj);
> +		return 0;

disallow changing vfio_ioas when it's already in-use e.g. has
a list of hwpt attached?
