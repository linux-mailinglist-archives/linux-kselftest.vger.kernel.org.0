Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8913A6A78D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Mar 2023 02:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCBBZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 20:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBBZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 20:25:12 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5148E0D
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 17:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677720312; x=1709256312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4vS4EIZtHd7KU9UzYWfuf6f/LrLYP3razT8MpkqjkzQ=;
  b=icTcNaP779W1V/PBeOmdyzT1dgLLKIQqZg6vEsk+xtbb5AfFSPFJwVxh
   n5heiW3RHsw+RLw9EdmH2t5njRj/X4kGTjnQHtTVUEaxnUwbuE813sJ4f
   LfXoYB0rOX8wJMmeeLiSAKFb+YJC+7pPyihtV24IyH2gOtoeBlVY4kDvG
   ICvRRYzPj1e06diB0NKkq+jCUmmDQilhT5BGDEpwrBBVlwpmxlTrg+g+E
   glfTg16KELdTjx8j4AOeePdjsTE9WInyTDNzcIGZoCg6sJTsL0N8mZaC7
   pThp8xs0OlAreK4ojWPKhrPVmLraXOr+Kj3JB6vIqR7KkjuSrIt05lbBO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336875351"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="336875351"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:25:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="848890764"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="848890764"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2023 17:25:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:25:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:25:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:25:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDraQ2DwnVC8FaF4Zl6s15V6HYOfXlL7i37pqd5dtisrCWNJE+d513DadfWvzwJoN+mgAl5UFPjU2bpaswQ2Hopwu0plJGI4cItZNYE13zdzPS/T9GpoKywBxL/dU2YI+SQaDS6tZlMKd41M6lVed6YtyXI8mai8FeRUG9P2+D3tuhCThK/tbc1/5f87WVbwrBFPVoCfH77hPNOyb9xmc3YpVAnk5KKNWwcE5jiGmknmPsuuIXSqBnS/WK8VD5pBxXPG1T3KrZY5AD8juWZ8Qz68kSIy4xGddLY1ph3Ixt89lUqVB5rwSL5Od9mqiuN9tE1RBG6v2KtDJJsYLLdMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vS4EIZtHd7KU9UzYWfuf6f/LrLYP3razT8MpkqjkzQ=;
 b=UWP7/QTzyvegNMERY1Zli3iYf96AdD5HBiLs5GYCJ8pFI06UU1TQJAlzgc/RoVIIXTbIoVYjtfK90xMKBixCYwpCc8xT4VIgK/mvNK1m6+Cd8YpTALsRLZ/mZL7LWH1F7iv83sCQcY9TH5wFShiHWoRdPdWnbaHeCI7bTtleQZoskwqeLXHmOcfgvprY7YxVglRZZHpUZIPQg5uIJwQ3M5A8LMRgl0SmHqmTXmYp4Fiobn5+PN7jaQ8TojpoJ5gc0f5+ODsiMZKU1D0f6JJ6FkYsYimMGzVn+OuspIMxSjNcZlWW9+67boA13FozU+doQhoA1hrvGh/812KXld8cZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Thu, 2 Mar
 2023 01:25:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%9]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 01:25:04 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
CC:     Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 10/12] iommufd/selftest: Rename the remaining mock
 device_id's to stdev_id
Thread-Topic: [PATCH v3 10/12] iommufd/selftest: Rename the remaining mock
 device_id's to stdev_id
Thread-Index: AQHZTHRbKuSp0HEf+Ea7YlpiVddR4q7msqOw
Date:   Thu, 2 Mar 2023 01:25:04 +0000
Message-ID: <BN9PR11MB52765DBAB51D6629897AC6C08CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
 <10-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <10-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6059:EE_
x-ms-office365-filtering-correlation-id: 08e8ab04-a920-46c6-8dbb-08db1abcf34d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypifpqZHh2DWHi6GZNGB859+/bLN2mzoiqWZpJWzlJ1NO3or3SrN3saI0sjz7iL0N8GrRW9S8/qNinFAQvD7hUEBj93ToerY/gR56WjJ13xoqDXUdf1Vnxdfi2cmMlQEgsTaTNTbZJ35l+xjIUEKaBwNXWarq8EEO4AL5ESo++w6RZTB6GVoINUoGKQp0jhlr3eEH5P3hNiqRmvffgR8tex9K9Uq4qF3oE4r2oLzKf1CLlXlERNA3v66CL/JgQMUsmhqIWApXV4ahVzPd7X9dZzkMHiClI62El1nweO5fNaA5Qc1BLWK2ar5zxu+JFKaEzo4o+YB5l2hygRwCX2l5Ht67T4KoWyDI4eky25puGYCap1qpVImfXygSaM03bbkplye6Ti5RIpvvN55aICHkklFFrChtF2HTAR+W2ZQzV+qohcajK5teymfuvB8w8XubVChru6wHOHKJvMHA+CJes1+6KX+dCojGCdi3cb9bTEEMwTlRE8z1NBWqPfkCcJfXIdSmQdC+xsux0LBCv0/BT0obfABNc4DQ1EPcf9MSh2nMq+4pmkevLhiOpgTNbRc4lVwHiNqRB3U8vHbrBA1a+N2mbqkEj24AVt7WGltIyQ0G7nZHGOSWk3lKpznyZs1WBCCvMu7Jm/y225pw6Barqxx3JfI0f7S1QFADe55FAuXNJKu+auVRVstVGnFFVa0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199018)(86362001)(558084003)(33656002)(41300700001)(8676002)(54906003)(110136005)(2906002)(186003)(9686003)(5660300002)(66446008)(107886003)(64756008)(76116006)(6506007)(66946007)(66476007)(66556008)(8936002)(7696005)(26005)(4326008)(55016003)(478600001)(71200400001)(82960400001)(38070700005)(122000001)(316002)(52536014)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVfNepLypBAie3v091cy4FQ0YkcbLmpzFRBWFxcZFVniTXs7CqsxXGtR5oKY?=
 =?us-ascii?Q?2K/PuK0BwXnlQhzVEZb1Hzd4ZNdcbxR9KwKhwhWTOsZ140aaGmkNjrzLLzFO?=
 =?us-ascii?Q?BLWa/iTJcWZ0vUN/MM6crnEAaLRzjxZeKihcPSyWWAbxdjZRExHAbZMuY74P?=
 =?us-ascii?Q?j6yKau0QIWR0S9qYaSCPMmQI7PSCBEDea1hzLrdlyamVWeEZrDtDqiq9O4t3?=
 =?us-ascii?Q?cv+3ZOpDDHg3eB1EupAcdF3SfvVoegN6eH7IEALDiIROz5d77zLBFMN4S9q2?=
 =?us-ascii?Q?BeEr7oyuQYqntLuWfGCSs0ou4ZXSR317aO/gAX83womOaR2Xfh6+sF1lhYf9?=
 =?us-ascii?Q?3eFcoxtbOKqcmk8Wb80y2QaGMTpNz4nT2PJw7Pc84xvtjy6V7jfzM51tRzmI?=
 =?us-ascii?Q?7h7hqZjczdhbhZD1PiEVDwNBMXY9oPtA5L+ef/4fspPrOitL3MtIxYH1ZHoN?=
 =?us-ascii?Q?dP2d0Imvn74YruO1kX7Z3rP8XmOsx9Z2UjCRfj3Tx/zMQcc1wYQ0Tt6zj4eM?=
 =?us-ascii?Q?Wlg1pLLsWAzS+srImhzuZjjQj/DlR3kRMTBmEumnYn0Rya5I7rLhkHyk3BOc?=
 =?us-ascii?Q?OsGi+4ti/4MNw48I7zi371A6/xyZNBeUtFkHQU169FqUYdgdds8CO6t3XhWH?=
 =?us-ascii?Q?atGNsMt9nZJSvD2L+C0vR81FezupG+1zPIMautjMOY85POa8tBvXgHWxkniG?=
 =?us-ascii?Q?n4lSI+2OHTY73aiAa7L+QG4UQRvZ65hsNlauhaY0ADR8AX7pGfBRL/0A4AOA?=
 =?us-ascii?Q?h+wXE7PevLKE7gFuHCsT+g71cb1bXqJNfItAWC2xTv09G4h7YZUzeRIMDb9a?=
 =?us-ascii?Q?t56zxRnkkH7c2qL0YTEkgUorH2UwsPfcGt3kkKvz4pLi6wb7PAzUA1s9wu7E?=
 =?us-ascii?Q?KiXqtgynmGR+NHu1azp3OspL7b1YuSG7luR5PDOSUQt6BfAjOXJtLEFWZ+zm?=
 =?us-ascii?Q?lxRk2YSHd6tFX6kYoMavxEFeUFuUGy4BKPF4LIPd1eBSZ7NZrgicP02BBOvb?=
 =?us-ascii?Q?+KT/0/NrZtprUwLRknEhu5XWgmEQ6aW/J8NkT5EQ/ztaIS0kG2ZKWT2WEsqy?=
 =?us-ascii?Q?Wjy2yId6tIQXVr7RH7b/5+eVJRC8NP6tcqiuTixedhhH9Wc6hEE0Inmyz8K7?=
 =?us-ascii?Q?gsUGwvqjRks6PF9E+0PJA2aRsXxWLF65PvG3jjX9hI4OvEm6euy3oNNK6+/N?=
 =?us-ascii?Q?+c1Fk0MC4iaAqrfBr1U0LMrqbmq98wjMvegm3h7Ja/64rzZBbXuVudcXQV8/?=
 =?us-ascii?Q?fG8yNDWrk/av4B6akPT+QbYLfPU9CJJlf9ICsNLoBpvLRWtww443w5M+uarK?=
 =?us-ascii?Q?uwHad39A6pMZ6aJ1jzzjWZtYfsz4VYxMpaKoQ1bHvv3On51ifzWaWSPj9HPr?=
 =?us-ascii?Q?bWhQlbsYIR5bhXH32ONWcXMTwsGvsLw4ZeXkb7gUqguqkZwoGzEQWO+lrT0J?=
 =?us-ascii?Q?iIMp/hO8atFyulPJRa5k8U4S7ZovvCNPoXuLkQW3iKOWm21HIFyWbosmEly5?=
 =?us-ascii?Q?4SYOu2rbB7Wk0Lzabsa99JpWPwOGghsQTcRPYacmQvW6M+nEorJyngwbk72P?=
 =?us-ascii?Q?78GiwOzMRj3RXCguwrurVeLFmPqKSmpIn6aGVJmO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e8ab04-a920-46c6-8dbb-08db1abcf34d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 01:25:04.0552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dnmRG2l43/LLuaOTxFTeCPllnRn6WFD8+tq8mvVIvEvD6R0MCsjDMnug5TQ4Ruggy9pGeOudRFZpvWNT2O1SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, March 2, 2023 3:30 AM
>=20
> For consistency.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
