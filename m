Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462DE691654
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 02:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBJBq0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 20:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBJBqY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 20:46:24 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C56A735;
        Thu,  9 Feb 2023 17:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675993583; x=1707529583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uZv32lQy4LqGo39++7jDZ3eaOjstGWC+x2j5CqcL1cA=;
  b=L7011vY0pisr6eqfQk+zExCisJHAIigt+bTu24cYEy0DuurvUjuY3+JG
   /OaStmPvpIcBPcoKuaH/ev0u+oxWEXgYEh4/JDg2Pd1TFlq5s/3IJJcPL
   BFq1IW8wSBHy1ZzPnai997HnYefIlvaDwY2cRE3KKIAnMAEu8jWC6xBB/
   yndRkLRnn9QHdsqPcS4uQoNEpsgr4UClCWX3AX5RdyZyi91seb0EB1acd
   aO0KZkPtu/yVSxL8wmm31Lzyz/0as/SB/NwaBMm2nYXJsZt/yTbRebFDB
   5geqVrnzE1d16jW0v2r+9o3KZVKCd32zaa+2K+eLTlsQRVNaG5P+N8YJc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="313953110"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="313953110"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 17:46:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="667891528"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="667891528"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 09 Feb 2023 17:46:20 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 17:46:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 17:46:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 17:46:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TovvzypzzycPqUenaD3w3H0X1JaKRQSnDIKF0hAe/tpVj4oNExsFGyZHYerv42AzfoHf8u7ZGl/6oQQ8HjA3DrYyOSDHu1pEykv0V5ONA8w3V8HqWMYOfiskTg0T0EmAjsllRMSodsl3KbSOe9XRpqTBBTKdt9nJx6kVCviX+2/ZqwFI+hQ60Sugi4JgPoKYt7x4B73dixfzWtmwqhuUFl1y/FH8WjfntBigVRF8LatfDDN5yFlOPEM1Dx9tSHwmkjQE3PELJw7KxhzPLYmP09Gj3P/fbxqNDfJKEUdFRs4K0grwEFwdLEB+DSE9AfMkFMl0h/GD9MdHUNfAOE4psQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PTRZ+uNpcfcwuw6VO4rG5mB6Y6ILGHTGQgF9zj9ktM=;
 b=OLI6t7VfeY9oX7ygKdww/zWgqIRGjw0+NTrjEG/5uvZKMPL5QkA1sIvpWLgIKRCWgdPtsW4xu+EBTKiebFZOg2WsDlX4/+s62Nj4VNO0owoe+QVm/TxnMSsnkY9B5q8sg7y/O0qu4UD3jvLZb8q98ICHZIeQR/xjUrsgDlYVbkWIfqf2HiqB0szb0i5BNnAKB4/Ikv/4IGBw/inAAz78ekMFhQOukkzbS5tIPccmuU3x8y7CUvNob75tBaKA0bClvmyTO1DJXy9xXpsIm3cQQsL0o0HN2ZMl2RK99aSbemqu3fdU3icb7FpHA2wz4kBt74ipPlVTXvxfi0XhZrtkGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6074.namprd11.prod.outlook.com (2603:10b6:208:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Fri, 10 Feb
 2023 01:46:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 01:46:18 +0000
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
Subject: RE: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Topic: [PATCH v2 07/10] iommufd/device: Make hwpt_list list_add/del
 symmetric
Thread-Index: AQHZOzoSQMv1v33l6Eyp7LBz8BGoIq7F9D6AgACo6ACAAM2SAA==
Date:   Fri, 10 Feb 2023 01:46:18 +0000
Message-ID: <BN9PR11MB5276CA32940B6886F8238FA38CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <9d0d4f935c4972771f5aed4b4837d8ae35814e06.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F36D2F07209AC7155BAB8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Tz/kkZ68e9QWR/@nvidia.com>
In-Reply-To: <Y+Tz/kkZ68e9QWR/@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6074:EE_
x-ms-office365-filtering-correlation-id: 6c8904d9-b458-412a-cfb0-08db0b089ac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6j9apckqUQHo0B4z0qFWs/7YGys5q+larCSpRFu+GH5IVocNCrdYKwwN5Qp7l3XKLxGcVo7jpntjp5Wv9NLuju/fePthoPYCMhReLOUM6z3IglQRo4NcI3tIBu9sOxzTacZHV2vpMq/BUEmwT8Bu9T3tuofl3rP6bHcnrBPk71Aa/hsQ/8nLmBbkcspGIKPTmzMBThamMC7cijPGCdLZ3Fh4ZbNlvJLXn67TiUXL1nXXauN1DkNBlHk3KMXm32hznbVzI5Zlkmc8nau3FLri2qRenetXILu/KWGFQERziO/XsjY9jAcg0SJGTQ5MFY42brTH8oQz7eiaE4KjOhpttNkgyX53P0VoL0bQxaLV/QeV7NDe1LRneENJ2D5uIztHTgY/1rTSAJndYQ2w9LHT4MstsBG/KmOHMLCN0gKSLR1LYBaXeDwrYQO1w94dvHDpbVWQRFfpqb1Nt1mm+sTUykh8SUUQ76Hwv3wqfp3vQmZhcjLzMc/ap9/JGocWLzwECnQVy0ZXcgiyfKYKK+7W1MR5haM1J2YAlrjHoBd7dKcZdId+RCOWUQTyoIm/M0YrPz8AQ0HPVn6T7uPgRLMbPIq+0KXmKE4LmO0pKNZgRSv+bZxXkD/gC2O0f8pMzweZ+A2OiVvwtEeqXZ22j+iuUEiSFhQyb/9hp1OqOuI2qONJiPwfg1liqpnVTHX9hsG0O3UkZfYlymu4fX+YOBfMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(5660300002)(66446008)(2906002)(7696005)(7416002)(83380400001)(66476007)(82960400001)(76116006)(38100700002)(6916009)(38070700005)(55016003)(8676002)(4326008)(122000001)(54906003)(66946007)(8936002)(52536014)(64756008)(66556008)(33656002)(71200400001)(186003)(9686003)(6506007)(41300700001)(478600001)(86362001)(26005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oGzvTtHX2GI23rYB/7O5yLhOLj3DnQ/xLUZjYHIvVb/B/xYyCuepNhWa05eq?=
 =?us-ascii?Q?C0+ncMbPk1B4Nt20DgXwxcphYV5JeeQTq/X3A9aIkfA3EuPHNA9n9J+e2Rfp?=
 =?us-ascii?Q?7rLfgHVbU5/+2ZAVPKYPPiN1xKg6mF4Q44CVGykSbLedcngGSNS3n5870VUQ?=
 =?us-ascii?Q?wJHvSK2M4Lot+Mmup0d1balhXM/HK7EVuYe2xwDMf3PyUGKRGqN8j/9lBm1K?=
 =?us-ascii?Q?UgLSD3v3L69puv/U6qexq80ZDdd6FFeb2HVt/RRnWF3Cxo8JxPh0GxCOj/lx?=
 =?us-ascii?Q?RN8GXyfGDt1gEv9TBrA3oI2n6lexA8gnNt4Z3M2x88OoVpkTQz3WeG64yZdB?=
 =?us-ascii?Q?yK42NmBPZIZTz8S1rn4q/ZZFgVb2O+dJKDxy5O+UFlrJdSa/R0GO6NP5S8p8?=
 =?us-ascii?Q?tSoEctRPg2IznIhoi1sv3jq5FiZBV/PgncM+8cLOQ9VvTSgWOiRWXnUPkAuD?=
 =?us-ascii?Q?IdiNcMJkP+/G5DTELndJmhIGDTkvHuJ+DURBieTtr0HN139E+NrXi7dkKzRf?=
 =?us-ascii?Q?VtfnR6tbmHLVHP2mkCzP1IHqbpci/IWyqwenTkummywQxvtW6LDk12jacwMK?=
 =?us-ascii?Q?SO6tGRW5Q/LEe1pTiB0Vo7HK4aH4dbwMSvC00EeAElicpgCjqnWpwhrv8hi/?=
 =?us-ascii?Q?GZTFR96pHiq6dzHaIahjloml1okD+Yek6pwDhub7JvvdQhY6s5pH/+Fer37d?=
 =?us-ascii?Q?gY2acWZNYLQ1wzM3dwEF7ypzLFqX+uawJUkgIAWFIeQ2WfLnLWbVgq9qY6zF?=
 =?us-ascii?Q?T7uMB058gXyhirfD43GbcS40wgP8QfbL9MqOVlvPfXkVRhYrYlpku90dZQne?=
 =?us-ascii?Q?gdNddLqmKKGp1pXkARmTMkXV+5IVjAgTkIMQ/P/ICZSePbTS6++ZK4hsrdGx?=
 =?us-ascii?Q?HcaHgnS4WiOO5JnUJmj3z/bPktf2I61mtdq0N3ef16YtKd7TlrVCvKZXC1Br?=
 =?us-ascii?Q?GaQQwzaN8URok9CwctX2XHb7idTN2YXltpfHlsX8lB+cgMMcfz3lp8QMhNCO?=
 =?us-ascii?Q?osV6JAe7ipfK5Y6W+u69ivAvpDjzYH+/R2D9XU7M8MtHsBnnfoS+AcI3BRIZ?=
 =?us-ascii?Q?yJptX0fZ+dvtqjOYzQpjpwNK7s3RqKqDTEd1GKcKAJTMUxrGgDbt9TT0pO0/?=
 =?us-ascii?Q?cQAejhP/0/tpo6SR0G6VOhVaea/gMP5rZAwZGo6Mbsz1usq6LS5GPbfGqYvG?=
 =?us-ascii?Q?2EcMc9QQuJtDNpmxorJtT+3kiG8trcDXNBDobUro9CY8OH9sSP8xGpOSIw4Z?=
 =?us-ascii?Q?C2/13vUuHFdhG8TFrwH9muRGLemDaRWbEMzzfIc9ru7t96EeRtxhiWUT97qm?=
 =?us-ascii?Q?JCHen5Aj5ycRgAUGt0ElzXRV38QeqLTsRDTrSWmYyBCrewFNyNFhHGvFFqu7?=
 =?us-ascii?Q?Ztv+yxqYH2cjp1+tZKS+f5wkP91l7XOzMGLROIXqYMZuNmH3NO8h0G18dmLi?=
 =?us-ascii?Q?HRA4sVi8VGXvNQ47DhEjnr9fWvNX80sPpv22pdPIuzJvmW7oELMpHGx8dlS4?=
 =?us-ascii?Q?KE1nSzu9ast5Z9VdqTT2lT5aREoGlTa+QFgP9juKgqeLqU8ixXUHEWij5/oL?=
 =?us-ascii?Q?pQLyiWQvPHQkTYA/AtEpqS2tYXKeJSJRULDVaqH0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8904d9-b458-412a-cfb0-08db0b089ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 01:46:18.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mk9fkh5CO1PDRWf8z7yNq0Jfo+uIt9RWQwjXrcKA5bNKxGu+DZebI5VAGcDbva8efAgpG5HFx0p2V8hE4REzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6074
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, February 9, 2023 9:24 PM
>=20
> On Thu, Feb 09, 2023 at 03:23:47AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, February 8, 2023 5:18 AM
> > >
> > > Because list_del() is together with iopt_table_remove_domain(), it ma=
kes
> > > sense to have list_add_tail() together with iopt_table_add_domain().
> > >
> > > Also place the mutex outside the iommufd_device_do_attach() call,
> similar
> > > to what's in the iommufd_device_auto_get_domain() function.
> > >
> > > Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> >
> > shouldn't this be a separate bug fix and backported? double adding a
> > list item would certainly clobber the list...
>=20
> AFAIK there is no bug, this is just reorganizing things
>=20

there is semantics change.

here is the current code:

	case IOMMUFD_OBJ_HW_PAGETABLE: {
		struct iommufd_hw_pagetable *hwpt =3D
			container_of(pt_obj, struct iommufd_hw_pagetable, obj);

		rc =3D iommufd_device_do_attach(idev, hwpt);
		if (rc)
			goto out_put_pt_obj;

		mutex_lock(&hwpt->ioas->mutex);
		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
		mutex_unlock(&hwpt->ioas->mutex);
		break;
	}

Above means every attach to hwpt will try to add the hwpt to the
list tail. Isn't it a bug?

with this patch the hwpt is added to the list only when it's attached
by the first device, i.e. when iopt_table_add_domain() is called.

	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
		rc =3D iommu_attach_group(hwpt->domain, idev->group);
		if (rc)
			goto out_iova;

		if (list_empty(&hwpt->devices)) {
			rc =3D iopt_table_add_domain(&hwpt->ioas->iopt,
						hwpt->domain);
			if (rc)
				goto out_detach;
			list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
		}
	}

so it's actually a bug fix.
