Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DCA7C84B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjJMLk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjJMLky (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 07:40:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F81BD;
        Fri, 13 Oct 2023 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697197252; x=1728733252;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=82ksFus1FvuHSBd8kr76FyH8yu5P3Jg5Dg52NexXk0M=;
  b=SAiSFoAVIJbfzaiv/PQnBEm1nv4SnE9OTB9qKpDGnVUVbweNub1xOU5t
   ah0sQGXDUO0GwycwqWopx1XV2QcABlh/yXDN1hBgNS3XhWnRtRPabqYzs
   MpDAoBBEXspLzukejli9RkafqixwTGIodc0QZdziHfYmw8d98ksPntGFG
   BodLj7SGyJhH++Us7pf3W+y0XZQBs8ahgETbhxObPm1HdZxdL+v+UuVVO
   fLF/rioRyPJyy4Vsar4uRix2l7YdwrRTixp/FOHF/RIjNyN9G/GgJaT+L
   3UvnbeNFOwGPHrg1gWz8ShHFC/3gUuW0yWmwzyTcykN+IhNUpANaAxGia
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471400194"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="471400194"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731340117"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="731340117"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 04:40:51 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 04:40:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 04:40:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 04:40:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nwag51KBJ2Fx0IZr1ci2EKaDMEusvqy+43ifNK0TThCo0B2J0R9d39xKH73SiUzM7XKhGlCjEwQiE+q3Ml8sv7W2fLqzy9Pq8ZJft4zsl+7950Bl+i6R9dfz9eMkxbziBPeZh293HF8RrpQTsf/+kXu8vDu9tdkMoB3zRHoy1zaTDJ9ov3B8M9Ika5e8Vzx/URspMElGHKHPu3uWSJQx7iJwq/+cTmZq9y0+EwQIwNqwP4NesjahWBjoTvv2Fm6jEAyei56FyIHW0M/3yUzpOHsaOKRzMBXfCIyyKOvPOn6uLE8SbLKAmYYdwa3jkl2hpOSbp68Y0P3WaFL368WTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0/4ojvdnOQflEtxv51n+HeNdprTLByQ87h01ly583k=;
 b=MiyJ/4tsoYsiH9K5+ZBeYKITrvrIPzTURidBNpoHJea5TjtGusDZgujXw7ZhsOU5hpyfLwxo32Z3MGa6lw4pW22LLCX6FiHVWy1PIxyL2J1uWjz91P8yuGlmpFRzTXok1jofCA0SuE6zsfbkR+FaDMaVOk6TNbUKhck88eO7tc7mKWIZJCkWlpRu59q9m0Kakg1GD+LZRx8xTYO0A3G7U/oB9B46gVEPidOjYJXIPKF8KawrPIuRrzdj8YXF2PG6IHUl4w2tdi7tbQ7i3bwSPsMMRaHDu3dnm7oD4WtRoldugc598kY4z/5udnY6dE+Ikfa9oapsKWzzGhrOy11TAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8096.namprd11.prod.outlook.com (2603:10b6:610:155::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 11:40:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 11:40:39 +0000
Message-ID: <b2097fa9-e2da-04f1-fdc4-a77aeb4a15f8@intel.com>
Date:   Fri, 13 Oct 2023 19:42:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-US
From:   Yi Liu <yi.l.liu@intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <BN9PR11MB52767E1B944C0B2F0667D5DE8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <43b3d605-fe3b-bcd6-a328-81d1448b7104@intel.com>
In-Reply-To: <43b3d605-fe3b-bcd6-a328-81d1448b7104@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a22a087-c598-4a9b-a7e1-08dbcbe13910
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/D3CjlIx4mgOm+97zNbfGH3XOGdiROyBc99QRxZucUL7TpcuSQOWFXb7qw6wWIGKsdCluctayWpuUJJqHapbDv/uY9AwPAzQCCKcX/UBOA2UaUCU2FgZDi1Tp+RhJgw3lhj3rDfaKtn2zxkPKinKJoeEjBvBn7GHlCoDcDJMhpY7XtgNG2Texak1ZUzLvY9ALKpa34P4dbufKHlhYIOPfMyVBlpSelxH9Qy0KEltcIBrzYsvO4q0uLgfs6+7g2SbLZKhW2I83mBnjx4UL4NxVnBEdmblLWYHZH1tw+fbWCy+cOwMhyOvCx9NNmX4p8S21EiPtUUWEpQjPLK2ny2Q7QRh2ZEd8Qw82/A27MiWPn9PvNWjQYD1qbAoUapeF+3/R5zfG1b/aAFMjUHBrQunJVgB6LZqZPgLEuuXr1ytnRNeczuFTQQiG1exqIzDkKhN8aTgzWLqgLM0ovrjiWw+rKLl3OWPUwVsFsPJJKFNzAl78nHMuw90wWHE4EBa0edL26sJ0Aa2kw6ylF04HZCEbGmP3oBvn3JRQ7ARwjFcr/5rZBWs9uOwjtkatH3RioRV5GNkZ+47iRxITCwNMEDW7dVKgs/pDVuv6l98OnF3cI6xjiViwchCOOV8ONKnl+MULqn/rn7cKRszJSp0b6bVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82960400001)(26005)(6506007)(36756003)(54906003)(66556008)(66946007)(66476007)(316002)(110136005)(86362001)(6512007)(38100700002)(2616005)(53546011)(31686004)(6486002)(478600001)(31696002)(6666004)(2906002)(966005)(7416002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnErSTRUblhKTTl6UFJLc0FRblNOQ0kxUEt0RDNsUVo1UUYycU5OT1dkd0xI?=
 =?utf-8?B?ZW0vMlZ2TFRydHZpMG01VUxjQXJGQzUwT2lCSHpyUTIzY2hNNjZGbkR6QkpC?=
 =?utf-8?B?VHljSkE2RzdGeDFlRWVJL08wbHFjR0VQZmpiQUxBWnllcHZtUFBhV1VoUkFv?=
 =?utf-8?B?YzJwR1QrUE5KeDVWTFIzYW1ueHBVbVBFZEdKRzVldEpUdnlOL0lxNElnR3ds?=
 =?utf-8?B?SE5HVERZWEE3bXRSOGtiRkRNRjgzUGtoWDZmWERsQ3E3T3haK0NNem44djIw?=
 =?utf-8?B?cEEwNnhiRVc4S3F6OTFkdDBkQXdnZFhCYmxieDB1cWhhNnJRVThkZm9WVnl3?=
 =?utf-8?B?c3RDaUVwSlF1NDRUZlpMQmg0Y2x1bU55Qi8vN05BdXI5VkhTa0ZZWWFJdkF0?=
 =?utf-8?B?ZlZjVzVDc3oxSDhWellpME5jdGt6anFQeGRLQWR2TGdZOStZRlRSRitxanN6?=
 =?utf-8?B?Q1B0YnVOOHBRSm5yNVY4Y0I2NFlHSFczdXRzYmEzd2xodXBrSWR6ZTRCcUlI?=
 =?utf-8?B?cXc4K0pDeUQxd1M5ZjhiZVdZZ1F3QU1QK0FkUGJUR2w0Q0tDRWg3ekVTV0dk?=
 =?utf-8?B?bTdSc1loZGI5L2tvYXRBYU13cTN1VUJ5VG8xZDVoUUJ3MUdUam1MRUpBNmd2?=
 =?utf-8?B?Q3l5V1RRZVpWZEEyVU9LZml1OUtQT09OQ2xvazVHd0lGM3RBT0hBbWdJb0Ni?=
 =?utf-8?B?L0IrbVIwRXA0cHk1WkhEcy85RGxadXQ0S1FOakRpaHowaXNUMHc1Z0hkWkgr?=
 =?utf-8?B?aDhTU0EzVGgrUjVNeTNQZ0p4bGFOaFJNRFBiY3MvU3E2ZWJYeVJqaHI4ZG5Q?=
 =?utf-8?B?VnBUNGFmUjNpN0lIN0RST3lOckd4ZDJackcwWHk1NXlhOXZxYm9WaFVUcXBB?=
 =?utf-8?B?dER2aEJzaXl4VkF6YVF2djJOM2JNQVYxT1RBbkdjQy8ybUUzT1lWRy85ZmVJ?=
 =?utf-8?B?bzdJaEpickZvTGh6M04vTm5GUC9WZWlWcUhZOVVQUGVEd2RQcnpoditHZWpX?=
 =?utf-8?B?WFpvZlIwTFczTGMxRFhjOStwVTU3TENsQnpIdVhBUGl5Z2lEb2RlTWdzR1B0?=
 =?utf-8?B?bklxZFVMMVU2ZWJoVlFxck04VjVDTjJkWE1sRVEwUjRXTlZ0QmxqcVRjNkVX?=
 =?utf-8?B?QWlqZHVmMGNVMitISy9rc2xCamM5cDd6NFVOOWJzT01ZNGJDcFVRUXJUZjdu?=
 =?utf-8?B?U24xTUdmVFFpdUlleXd6eUFaN01XbENlSjFLcHpkcTlFQ3V0MGVtR3dwWGxQ?=
 =?utf-8?B?cERaWkFjQXJLU25QZTVIejlmR1M2eGJTa0lVMjMrUStlOWcyRDVpM0RMMFhn?=
 =?utf-8?B?MFBGVEVKem1JM0w1YWRYNUZtOTdqMWhVNVJjeEJJQm5HcC9haEc1Vm9POFE1?=
 =?utf-8?B?blFacTBvZHI2bUQ0UzlnMmdneHk5RXBSUzNFYXhvQnVmNFoyUFMzcCtXMlJ0?=
 =?utf-8?B?cTdDOElVSUxmVzBEWWxSQ2NDYkNZRmtHaFlYL0VlQXdpMEJSWlNLQWc5ZS9i?=
 =?utf-8?B?cHZ3VGdVaWpsbG5XSGw5T0hqNlhCSmdNQ1AwTmp4RmJ6bFUraFd4eVNja0Jj?=
 =?utf-8?B?RUZnMUo5T3RTZ1ZOOXR0NFRmbW9RaEpueWlVdlZFZEp3a2R3RHIyWkdVb1RH?=
 =?utf-8?B?aXVyNXNoWWNGZ2tOMUxjQ2h3d25FOVNORTRyWGVmWDFwclhkWVhuTi83UUcw?=
 =?utf-8?B?R2NLWnNHL3c2NGZWRDFjN2RVTTdHSnZqUDFTTjN1WUZLbTMzV3FzRlRyNWFV?=
 =?utf-8?B?L05vazY0OWd1MzJvcWpVS0dMbStxNUNCWXU0UjNPSXBvMGEyZUpzRlVQVUZ0?=
 =?utf-8?B?cjB1TmtGWnNISDRPUlV4a0hPWGtsZnZxS3htdDhJMGxnT3ZCTjh1UXl6NnhQ?=
 =?utf-8?B?c3ZqNnpQa1lGempETkFqUFc0V25sSEZtbVd3V0pxS1pMaHFLTUJSdnVnLzFC?=
 =?utf-8?B?eE5PdUVLZHJUTzZqdVgzSmJnSlYydjJXaVM3OHB1Tk13T2tCSFBJTkVKbTc1?=
 =?utf-8?B?c2tsSDdJd1NNamRNL0NTOWdrL0dReXRvV3JCanpUV05vc1hYMlZUZlJGelh1?=
 =?utf-8?B?YUtmWHFUNis2bHdrWHpYRzFaeHdwMkhCSFNzRnJ1UmFOd0xpaVJhVFRYWWdy?=
 =?utf-8?Q?lA2IEVtt7Ju6EevRH9FH8EvtM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a22a087-c598-4a9b-a7e1-08dbcbe13910
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:40:39.2174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCpK2APIwnLflRC1RXIYXO1pl3p6x7iIwGcMbecofNfI/fMKmKoTLs8Acqdf1GhS+TlXaSW+aaPQ4YQ8jDakZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8096
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/12 17:12, Yi Liu wrote:
> On 2023/9/26 14:56, Tian, Kevin wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>> Sent: Thursday, September 21, 2023 3:51 PM
>>> +
>>> +/**
>>> + * iommu_copy_user_data - Copy iommu driver specific user space data
>>> + * @dst_data: Pointer to an iommu driver specific user data that is 
>>> defined
>>> in
>>> + *            include/uapi/linux/iommufd.h
>>> + * @src_data: Pointer to a struct iommu_user_data for user space data info
>>> + * @data_len: Length of current user data structure, i.e. sizeof(struct 
>>> _dst)
>>> + * @min_len: Initial length of user data structure for backward 
>>> compatibility.
>>> + *           This should be offsetofend using the last member in the 
>>> user data
>>> + *           struct that was initially added to 
>>> include/uapi/linux/iommufd.h
>>> + */
>>> +static inline int iommu_copy_user_data(void *dst_data,
>>> +                       const struct iommu_user_data *src_data,
>>> +                       size_t data_len, size_t min_len)
>>
>> iommu_copy_struct_from_user()?
>>
>> btw given the confusion raised on how this would be used is it clearer
>> to move it to the patch together with the 1st user?
> 
> sure. How about your opinion? @Nic.
> 

after a second thinking, the first user of this helper is the patch to
extend mock iommu driver. Is it suitable to introduce a common API together
with selftest code?

https://lore.kernel.org/linux-iommu/20230921075138.124099-14-yi.l.liu@intel.com/

-- 
Regards,
Yi Liu
