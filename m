Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7F617798
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 08:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCHYu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKCHYs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 03:24:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE75FCC;
        Thu,  3 Nov 2022 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667460288; x=1698996288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pa4Tl8vIMPTpDJ/9rvnKDGM/xFbQvPW3wp4ufS0vlc4=;
  b=ezazsBQXPVMNfFmGMPvswlWPh///6OSoEcRa45dmThGuUGCL12BFuOSi
   0rkobCIQkj/bXHxDJdI6lNru1QxXszLXObsdIaOx5f1rQ3N2teUtjIpxt
   ss9T7qfJcff7kQt5dF8h16//vUl7NpKmThIcahxkvb+dXROLK2EyBp+IZ
   Xt5bRNPSYT7pcOYahGhAO1Q45irCG0fAeGWszZ/0zdd/ituc6ml1JDA1O
   HXMmUJacUjxvUM9HmWXINzJP4P5b7ZkeP+cRP0fDiOBxaiJ6HXbHFtICP
   Ip2M73fZc6UDIO5tesfJ7r7IFLISDO5E9uolWIGFXGxZHcmb0hCYC6SNI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="310721769"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="310721769"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 00:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="777198978"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="777198978"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2022 00:24:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 00:24:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 00:24:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 00:24:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW2tmqDAZE8nh3NwPGJrZqjpkmtVoNWSCYx3M5grWMAaVTsYJopoRvX172BnlnfTagRJ98wYrQRbfT0/YQ+OtyY8yd6Lo4A2ajs3GgKDf/mMl1OFDfkSYpGwr05Qz3Iu+qn55Jp7g/HU4DIURySNiookeaI+QjTvvew/lfr2tSfTkCvClRnOIKDraObmk6efMPsWRRKF16ilaoNx1U7fcfTDi6ARgIrTD2qRGLHjJi+Vf9t3qGtrMgpkYuXlc1dPGCtdyVDNUO82DRfbOwIyDDAf+92/f0GGiRDrWnt12uJe7R2Uzxe3NWCYhx+xzJmZFjPRkFIvhE/btFgHnfANCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa4Tl8vIMPTpDJ/9rvnKDGM/xFbQvPW3wp4ufS0vlc4=;
 b=Gs2QiGoYXe+2dcm4DBQkSEM/T6fpRRldllVg3iC/RKVMuHmcD7jBFrynjVjW+P2Sw1/hISelDG2u6sOtxtYfDPu5GCFh6SbYdLdVXG2YQZIrPZNLHIrbfevfTQHACLMjuc0RgTNDUVAF7Nj0cdNq9NRx4rvDHplk4J/SLZyljNOuW8gUH+HuLSvm2Wr7X6zETNuHg/jNqxXFtiQ/1yDNDAVeagb9P9jqvrvSaV6g6M2P3a70HQB+nEpDa+BgNraM/mJILEfDWIlrrOIqhO0QPKNEsE6smNV3hyk4bVYAunn6TR8+I2qquPORzFbRyQ51yqxrQ/k4pdBySBYHTNgJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Thu, 3 Nov
 2022 07:23:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::737e:211a:bb53:4cd7%5]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 07:23:57 +0000
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
Subject: RE: [PATCH v3 06/15] kernel/user: Allow user::locked_vm to be usable
 for iommufd
Thread-Topic: [PATCH v3 06/15] kernel/user: Allow user::locked_vm to be usable
 for iommufd
Thread-Index: AQHY6J1oCrPbP04ZE0StrYmKUQ2d/q4s2SbQ
Date:   Thu, 3 Nov 2022 07:23:57 +0000
Message-ID: <BN9PR11MB5276CEF0379EAB0B7EFA31228C389@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <6-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <6-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5861:EE_
x-ms-office365-filtering-correlation-id: 387f4266-94a3-4a36-1cf2-08dabd6c5f1b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SaOW49sdO2xCbkh8ah+892FNFPWk4kWDPPoxP6f5Y1s247rngGiS6InxKVSlAYf8754bYGzgmnNyQY+RY5T/9epg+iUuH6dX3jR0pFF/awBgkxuOud4XAuxZLy0su4jj2E08ptGGX8W/VyPtUqIzC9W4WsoUbZVHPXjSyQZ/w8v+OGk99uUo4/YVKnOZljqurliQuPHOnkHCkU1aiNlm71tKklq+xH2bNZjMv+e8HEUYxVQtgThgf118ow/TbSnCeTpitzAyhR0DIpOuoy4tg2n0PDTU+VioZAfAU7dJOlZh+a3PzabhfnsL26PzfmUDktug2bBkXs9o4RTjUBZkCm1S6RJ/hU+/W1TglbaBU0AGQPQWT/yDA4WfNlBzL9RMemu10Q5SJglr0pw7xnjUKLP0iPOI9NATRnc+ojmGIcRS6O1K/KRNdISzG1jrB7x+upqrG0M8pQzt8MmWX9gzEn0ITHZuOF9rkSx1pZZggE6CzGP6rpiSBAWOsNfkXOHrIXv2TLFnlxwN++USC97fx3lpGbnUXQc1wSIqsIXmv0apbHPjG02ggPevd2A0qKoOWbZA/XJ2A82tMZjKL9ZQ0a2ybprvMD6T2JyJXMSoBsmftr08ft3smx6R6MZr+en3GyxADiKWJDZdBpo0SaJawE7zaZv4r2P+PZm83a2EccB+9Hp2ZRK46LpJtcF8ZkUMoeglNePlr6E3IY1sf6qtfRjyXRFDVzsuueWlAbFHJISyT0+lAiU3q+dW3TY8ZYtbyPNDbJr2pINw7IxizO+jjz7Qcu4K/wxKpFp1/OLbiDw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(110136005)(478600001)(54906003)(8936002)(66446008)(9686003)(66946007)(7696005)(76116006)(7406005)(66556008)(52536014)(26005)(8676002)(41300700001)(66476007)(4326008)(7416002)(5660300002)(4744005)(186003)(83380400001)(64756008)(38070700005)(2906002)(55016003)(86362001)(71200400001)(6506007)(316002)(82960400001)(33656002)(38100700002)(921005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dd7q3XceR7NZC3EZva+YaKD8yI8PMaKNrCyEEPR7UZ+dr/fmE/K98T+TTIR?=
 =?us-ascii?Q?mHStUpqL14O8GJ9sI9rHYEnE1DMH53zlHXWszP+32B4i96wzvkgtfVodWOP+?=
 =?us-ascii?Q?aS0DM5Kb/y520CO0xYLjS8Rnz47OHGmAlTNX6hedNl3PKSXuyFFxyxu0aAPs?=
 =?us-ascii?Q?gk8f89zmBVddoHBayXxhUD2JmF/BDm3ScWn1IcjBFHqDDxRexPo2NEiCUETk?=
 =?us-ascii?Q?AgFzSgmkxRKnDRppEFOucTmFg4FRlkLmI65K2iJdUwU99zVQi06r7Hkhd4Xh?=
 =?us-ascii?Q?gehdJlWCG68Sj5TBp0tFNNAmWZnouWN6+3fmJYJOsmdjw1U4VIH9Fhq+ddNv?=
 =?us-ascii?Q?zqUbG8Z8kOxGl5xl0NaDqKnNOmil30Q1ofd9mfdkgnDSlJn18sPuQ/T5YQgS?=
 =?us-ascii?Q?za3fnaKsw6mDegzkdeVnwgCFbIfD/bX9tlfEDI2oolqbXp4z7ti2A1jv7fnA?=
 =?us-ascii?Q?JCLaoK6n5E741mASkeRqRcjeZBST4KeQNM/hoeLJBsJXnWYVBeFG+NGbqa2X?=
 =?us-ascii?Q?x1v6TUIbeDcwd0NEKEJFS68F3r2A7toGQqQ7X1Wt0FVQJ0meE2t/SncplPRw?=
 =?us-ascii?Q?F1CGtB3qI2n94IfKufYWt2j+M+8M0k5K2a7i0xklQWADkH3SrnIX7ToRqGrN?=
 =?us-ascii?Q?597yt5/bRf8CFlRdla6SFuW/+f7pDsv3q63hPrZPMoOq5BePm2hVc7WfOJ3C?=
 =?us-ascii?Q?AhyDEoXTQSMbJPZ8iB8wkKKGSDSh9B+uCoJUmnDFquzYxbZ6PsQ+sPBhRycE?=
 =?us-ascii?Q?nN9Pigo9I4/LO8Azzel0VmymFBrtJWDdVbHk8A4LxJoVseE2ZU82qZk9k9oq?=
 =?us-ascii?Q?rF9HGB1bXIjYbtCZRiPxi6g+e1akRtPHp1enWOI5PjVtfi+hgyRqB2Ukwd8M?=
 =?us-ascii?Q?dRCiaMxBnYVx7f1GwTdGPiT5svVjh9TLr0fya89GQQgtFDpnC1hufW4AAqD+?=
 =?us-ascii?Q?cxQV6uh06KgrAysc8z04Op/yUuPUH6an2btBMZHP2JIpQjmbgjly2fTDwIJh?=
 =?us-ascii?Q?NWYt7EHDxIlF6emLwcDPB/jp8eVTMND2VqUqUEDmM9y1LNOsfZ9RfLxizfNh?=
 =?us-ascii?Q?zzTIZKEZdXjhLgSUCND5LcG7dXEXJ14V0l8Km+6AIrOgEgeHgu/kNLy5u89i?=
 =?us-ascii?Q?prjWikpTGn1GZkjSIbzO6r2YF2GnDEs6BbAnXJpAqqxEBF2HmIAiI0hc7B8R?=
 =?us-ascii?Q?Z53S/mFnVSyriMdJyWkdwX3zibf3ygxcluB8ScBndtP6lZuETbxLr88u9Fqd?=
 =?us-ascii?Q?/nFja9gWvUNk4IM8lPGKS4pjbm9s5/966bXdF3/7zq/KT8OyaGPkIJcy0XXu?=
 =?us-ascii?Q?BvJ7mnjflQ5nF4KJnDWUYqsp5dpCFtAWPJG1SF8obT2kxMA1xEUieWUDY/jt?=
 =?us-ascii?Q?OUnhvkowVL29kjfBl3Ou2ssn8l4qyKXPlDEghH3ifbtaQsHMMGKmSOHLFi+n?=
 =?us-ascii?Q?1kf6Kt1xmynBPFLs2M6bWYYgx51bYuLUUsx4e9rTi9YTFBXwS4a8eF+TcAYa?=
 =?us-ascii?Q?leeebL8hVCDFxg3/tc3zxF5AkYe9DPj/l9X5TyNojqlp5/7j9WSs0zj+rq8i?=
 =?us-ascii?Q?d0RamUqatMvtsiGWdGdWj+ZNGes8oTe3iacs46Lw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387f4266-94a3-4a36-1cf2-08dabd6c5f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 07:23:57.5764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrjXu0kFgNiUg8iZUpc/8RRINym9wcwJz42nASLByzO8v7BltaPJtfoUvz4IELZzLbUC/5mKWSeXE4VfSN4shQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 26, 2022 2:12 AM
>=20
> Following the pattern of io_uring, perf, skb, and bpf iommfd will use
> user->locked_vm for accounting pinned pages. Ensure the value is included
> in the struct and export free_uid() as iommufd is modular.
>=20
> user->locked_vm is the good accounting to use for ulimit because it is
> per-user, and the security sandboxing of locked pages is not supposed to
> be per-process. Other places (vfio, vdpa and infiniband) have used
> mm->pinned_vm and/or mm->locked_vm for accounting pinned pages, but
> this
> is only per-process and inconsistent with the new FOLL_LONGTERM users in
> the kernel.
>=20
> Concurrent work is underway to try to put this in a cgroup, so everything
> can be consistent and the kernel can provide a FOLL_LONGTERM limit that
> actually provides security.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
