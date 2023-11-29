Return-Path: <linux-kselftest+bounces-787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A93B17FCC1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 01:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98621C20FA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FE110E7;
	Wed, 29 Nov 2023 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDc8fvxr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9F170B;
	Tue, 28 Nov 2023 16:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrL+gokNP954A9nLppYc9IQ0/zxA9L+Ky6e/636eunSLLR1kz5/Ek2pUbQKpEoZKsQRhPhZd8jm1e5hsMIluY/Nf4NiSeWPz+o2Mbirf8kBl+7gaaPkHhLefPQevHC844Iev38Cr6uORSvor6rPEsNZLEMzLeeXb/LGmfzW5fdNEWzTB5jk5hD7WPIU5DcJ8wNYKWYnqPrn57FRhIfZ64HHJVjPNuI7u0gPAZGdYW4OUkLiorHpALbsxmwJ7ImbQPQ+XsH/4rjXHOTDBHaRdOkqztGQU9/w7Cyi7GF+2NX798rKeCGUK8FD9Wh0s87kMYC6uy/6C9x9fn28cO1wwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G85CKKGx76lm2ER+eX1sX8JHPXYo81UAgeZ5anJ5oaE=;
 b=jmJH1vvA9+EiEKzMw3EPdJY7rzipQfDg+Ny326S+b+Av00+evcTHzp3KmiuR/4MbzZbgUv1f1preCvRqv+6awpgk7y8DANfMz0FebNB8cME6GXWykWIPN3E3gNqL/uL18RUFfA6PGQgYvAgFZOIAyFyAVIogqQ/D45zblSjWJEgm56uKJy8xQ7W8GAGcNDnTLoNrZfiZEpREa4AW20/3SL/q/x7vz/MBgy+z0qPWsuURn/HYvIWdW4VC4VEvEyn3VA/ftDvLJYTYRo2cdMRt8OF8JlccBWMVm0KPTN2mGXy+YUhYTx7WqXPFWmairUO/v8WC4qLVK+judSjARwzpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G85CKKGx76lm2ER+eX1sX8JHPXYo81UAgeZ5anJ5oaE=;
 b=CDc8fvxry+0usjKh4w0LUNtlL27rKxgU9pmnkLaiioL16wEM5gI9NgyYveIzoN/VeRgKhSPD3RyM/U5jgyFxxek7fgyHaeFBtfAtGPL7sP8ag6j15/AGu87Tqeye7dP3lti9HoZDu3kxHq+k2ysPtkmiEdSSganqkpFssOq8MpwJjQwXfBVIiLEeTavPlmIzQkUADfkWKWXnL7QzdAG3ObMtbel4T+N9x9UEdsUoCQ9nj5T4r3I+VFOwcEuEmiMIYt00iAkz/axzl3zwGzYTn4X+7qsqQwabsplws8Ps26OqyCjlTXirjsL3npHLEedHqQ9btLF74SQuu8OEo8FD9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by CO6PR12MB5411.namprd12.prod.outlook.com (2603:10b6:5:356::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 00:57:17 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::7d0e:720a:6192:2e6b]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::7d0e:720a:6192:2e6b%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 00:57:16 +0000
Date: Tue, 28 Nov 2023 20:57:15 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231129005715.GS436702@nvidia.com>
References: <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
X-ClientProxiedBy: DM6PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:5:bc::31) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|CO6PR12MB5411:EE_
X-MS-Office365-Filtering-Correlation-Id: 82298f0f-4556-4cdf-9f88-08dbf07621ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CS9po6gOME6iZJrsSAZQ59DWtQ0ptr08YRLZ1Pv8XlJocenVHAQGWPjC7/etnTSg5NffPgVPQkIO2BQWH4+bFSMLPIeQUtGE6xSMeHolxl/9ygbLQVMPZlth2pjJC8iY0OetuRZshm7TVjTYtV4UziFxmgg+sJOr27/SS/9L5EWFNhEzyLyu2VwKGogvwFsI7DOTMqlilLLfgKTypC+rbYKKJaeVunqbi+jV3Vz9vNhufTdbyqp9AzDkQujeD1/aXRoFLceWB6DuBGIkOca+NKcXHYvvttq/U6KAbyzR/38o3ZLsb/p327mRJfkZqi6+Qd9PiAyXihHdTIx82LKf8ifMHAVdGa+tfgU7Y6QP3BEvlHgiESFCq6ja0UcWGwJMVmlpv+ThdxEOR0MQunMv8ro579ZEWeMqyvGcESPpR/nusDorqq1OhDRyc/tou8rbjQ2SIrxFD/wz2JPBQ4N00nCSi4VTimBzPeYFvhuls9abU/j8MhyyRAZh7DJHmExwOg4UE6t9BBUlT71w1SSn1nP7uB3zlnLVLk+Je1vw4E4RGgcphrU5JMnMleB6jKyQkemg4iwlq7a9Va8AlZydm3JUwb/RhCHV5YEh1dj1rZ8cjsUSw4wSz31s0/gb/EOP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(2616005)(478600001)(1076003)(26005)(38100700002)(36756003)(86362001)(33656002)(7416002)(2906002)(41300700001)(83380400001)(6636002)(4326008)(37006003)(316002)(66556008)(66476007)(54906003)(6486002)(5660300002)(6506007)(66946007)(8676002)(8936002)(6862004)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SpzK+pZMWsPSacV9/PygGGyvz73woVEtHC5ljJjwidv6ls55wuC0XIhbQEg?=
 =?us-ascii?Q?LlgPegTyBZX9kjlQnV9XDXWawmYBDPzzrESdDEz2rO+qkvpqUwxkSp9R329I?=
 =?us-ascii?Q?V8HNAH/DcaQsjsW/qUA2ma4oJbiY4ZAozRKR8vARnDAw0OXAJy+vxC5DkwXR?=
 =?us-ascii?Q?3lxCkjw3gkB0Ja+fl164XGqNajygWiVD2dZUdvgI1DPIM+xFsvy6gSm5Rdhg?=
 =?us-ascii?Q?KWp4QVhtK31e//nqNrEpTwa+qNm9OJdwqZP3liwZZJFN3g/myyIz2TWHLJvq?=
 =?us-ascii?Q?XyrU2I0zC1EDcM9K6rgt/9ZM79T22ionDPDERRAjZf5FU/Q4yjqRiHBJsvVO?=
 =?us-ascii?Q?GQMDaqrUYJi0TPVyZamstbaXVQPtfV5WQk8jIx5jWux/IowyznA+4NdcPTNE?=
 =?us-ascii?Q?oVJ3YDngk0z9baq6g7E42A8+WzSYpb374PbRd1J+rmarTMmjFnVHXjlEYl6u?=
 =?us-ascii?Q?jn1gYyXePegZfVdqWfVd46vWEqnZsy/atdEUR8kG4NBFdbvKOwUGB9iKE9MS?=
 =?us-ascii?Q?73gnp41whxStUDd+V3/HB07oIjuV4CiAajA0oJVZyLot/B45YFd/ts3VMbt1?=
 =?us-ascii?Q?fK6mWTk7qmj7j8ppAgIDt1z0EOyc5PsDPa5rJVkYaKF3RRdM/w5UYsnimxMN?=
 =?us-ascii?Q?+/uLzdJpAffo6us/NIcRPWpLivss988M6VGmNQRywvPdr1DLRx/mkR7ThRXk?=
 =?us-ascii?Q?9U2J6qgphHZ18NQYFXYhc/gk/yhdAW+8Ed/dwW6SGR1URdf+AHmPazvlh72v?=
 =?us-ascii?Q?cmKpjhK6cH3p34NzRX6CHU8d8eo/N5zEAly4n6tsm0ZtnJbNIF7HLDCUEB+4?=
 =?us-ascii?Q?jBkfwlcliEP7DZPhy04lrOuvDT0WZMAKLT69MzBNzyOxjTj5P/sHMiC5U/OJ?=
 =?us-ascii?Q?ZyXuwWGMj+lW7z5vhz5/B+3sKovI+IZ7sPZzUBzf+lCEM0hIv7CDeyTMzGJq?=
 =?us-ascii?Q?5NhVIZ+DPp6htbrP2T6kp7MyZ+ENc3eyjEed9QtNVhHP49yuZjrcBnnteyAi?=
 =?us-ascii?Q?XwzJ7nFSMSYnNeBPdxf2JVP46GHYJ2DTKtp8KY7n0nhxppkhGS6iR4WAJeap?=
 =?us-ascii?Q?fCiReuFlIF9KJlIgJPZ5OxcYjf9a06DwNHkr3xXGLQXiUia5WNQa/Ea1jSop?=
 =?us-ascii?Q?3owIAdhu0/v3+USdiq1QoD5z63qIfioaniGck+9ZOTDjqQ1qVYtsH99GX8Gl?=
 =?us-ascii?Q?srIBzazlwlcehsMjoGFISfQNcJwZRigtJWd/7GyFMg4RaWEHlFuktjbEAJHE?=
 =?us-ascii?Q?W61qzY+fZaRO4K/SM6DysrUmiB+vW44aKTOmIffn+ka+6ASu8GAUP40EqRct?=
 =?us-ascii?Q?5PuFt2JQt636ry4hunboQhesB/jad5fAMJQKUEOFXqoxzwG5/fCZI4JqEwou?=
 =?us-ascii?Q?G/RykORrOwDoDgxv/WTdpKdxoWTrsdD5hY1uw0XOwz30mBSbQ+xhc/rvnDne?=
 =?us-ascii?Q?ilfOnwMKaCQVEfIxPY0iwV5kB1Tw0BS030sja1WUXmq9CUgVR+rp1m8ET4Fq?=
 =?us-ascii?Q?Q1NscIW+872s/eCmMawqtCyI071W9uOmZJsJfBhUE4mNt0ZOQ2AZNAith4Zz?=
 =?us-ascii?Q?Pyx1qY5Knk2kLtXY6GiGXAecL3aOpvl6yHMD0ueS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82298f0f-4556-4cdf-9f88-08dbf07621ca
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 00:57:16.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaoWgxdX1Yx+e3tIQVeAhfCHA4r0tE7caqRA+qi0tX1q2LlQwuiFSrqYxtcVjN3q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5411

On Tue, Nov 28, 2023 at 04:51:21PM -0800, Nicolin Chen wrote:
> > > I also thought about making this out_driver_error_code per HW.
> > > Yet, an error can be either per array or per entry/quest. The
> > > array-related error should be reported in the array structure
> > > that is a core uAPI, v.s. the per-HW entry structure. Though
> > > we could still report an array error in the entry structure
> > > at the first entry (or indexed by "array->entry_num")?
> > >
> > 
> > why would there be an array error? array is just a software
> > entity containing actual HW invalidation cmds. If there is
> > any error with the array itself it should be reported via
> > ioctl errno.
> 
> User array reading is a software operation, but kernel array
> reading is a hardware operation that can raise an error when
> the memory location to the array is incorrect or so.

Well, we shouldn't get into a situation like that.. By the time the HW
got the address it should be valid.

> With that being said, I think errno (-EIO) could do the job,
> as you suggested too.

Do we have any idea what HW failures can be generated by the commands
this will execture? IIRC I don't remember seeing any smmu specific
codes related to invalid invalidation? Everything is a valid input?

Can vt-d fail single commands? What about AMD?

> > Jason, how about your opinion? I didn't spot big issues
> > except this one. Hope it can make into 6.8.

Yes, lets try

Jason

