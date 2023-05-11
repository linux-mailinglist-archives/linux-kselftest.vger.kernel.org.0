Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45D56FFBFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjEKVk4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjEKVkz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:40:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1495BA1;
        Thu, 11 May 2023 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683841254; x=1715377254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=INjQiAUviEtI+BBSqQdZFlQtYhe0jRn9xJji4K9IKmM=;
  b=Jlc1CL7j0udd2MAQYNGXWeFtUC2+d9qBwNjwYx7ft++egt6jZ8WcU5un
   gbFufJOMRf2GyxyX9LI4+p5kr0LKHJxvuSmeQmrB2ktMhgDvFszRdYuaf
   AoGHDJoSRT89tHBm28/gVVSvcSoxcWw8xo+YEJ3KgyOyO1p691hPwm46r
   FhGOFvDWCMG/9ScRgA+v4O4LWpuoXDd7ex79cx4yW891AsMli3QHwhETl
   lv2sXh6qosOLkqSZNCFE/12jLXR4BrSPBAdJGwaICBhYikzn65fTd2Snk
   iRhY1L7UMSOVnPfXPQAimdjnATCq/TOQC+qy2DUniN6++9l0JriEg6Avb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="330258243"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="330258243"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="650392830"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="650392830"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2023 14:40:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:40:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:40:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:40:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:40:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyDgtsoZ8D75fIknDBjWVpYz/Rvxx3uDD+6mRRcKDGzkXad7W36s3Dh88O03SUZlMZ8qrB/JwhTFLJktRQBHrkpNFUUEtVwx7NP1Nc0rhSWTSK0QK3j0kicpNn4ZS1/s/KEkimuu49x4bR5FQNQz+tVEEywq6YXYo/hLKGXxZ11CT1xOiYntoMEKnI9h+NIUc9MhhHc/UjFNqsKVBsPNf2dxCWDW03LYHaL4GP7hq/Hh58BPd6u7hTHvPc2SUhRdcCAhXal/N0usmQvfd2VNodEfWpMHyXW23i1RQyuNcIPKkxhgcHfN53rDsJCkqybKUmGF8DeKoPd2NeSPSIa/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJFcufktc0v3fSaAPSBw5+ZmwhmKSLnRD4iZXD3VRMk=;
 b=OIV+l77LncfUQ0BsHMrTbIxut7C6ZHxotZZfra4HoYkNdpkEEVLDmXv/1XSIB6yysqvkJ8b0zeHp2z1dgOHuqBSBw44AAkU6A4xO7dskMWtZkuqYN7iwqXtAXc7ReY7NhsBvKlySOkfb2lWpBvRgF1HCgC6tegb8reRzsMWw49Hknl/AguFegzZjKd+++rQ9nPRinpZgWYJz5uGmI/2o9TKM+66XC37lvtSrfFOYy7yxQTL0KiCImmjicDe7x2LVqFW0pQm1rVT0YnZJErVOSrR34gtFm76nb1b0I+PENV+c1nZ7hIhMUi9BkrhMU4spDCqRK89B0gfC6vfy7S0jlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6109.namprd11.prod.outlook.com (2603:10b6:208:3cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 21:40:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:40:45 +0000
Message-ID: <c27972ef-1b17-36dd-50b8-790f7994733f@intel.com>
Date:   Thu, 11 May 2023 14:40:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 8/9] x86/resctrl: Use mbm_update() to push soft RMID
 counts
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-9-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-9-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d38fd84-2217-4f02-d217-08db5268609a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ed+KdbFzg6nstSgO5FV6d6Gv1/sRKzYeCje1C853EyazhjOPk0Msk9m1xbpAXjKrI2++lE/xxC4mXsALO8XAu0LesoQ+f2blprFCeBJ2X5aDHZ+xQqgLk8JWKu6wn/KwtHpgCcVC2NHTFiOmRpTyymCeuu+heb85Y3+rfg52RPJ1BHShI18pJYsGjFYlcZPMTYzNxv1OuLZh2hjpHPZ5VpYTHGJpuG93BFx1rkhSeHbMPL7cvfLLu97z8IC01F4b4ubOKTuZyq6WRPEV5raOX/cfZsucTIdPtoK/ez1KrsVs0uD8HR9H/G6wrK14ZjyUcKHwS20ZFnXWLVTWyz0vRZRERtMH9DStOfYsvqeQDR6OSRK1W9ZYgGoz7QKwH+mNpU0j7liXZuSPrgcL02o5WTbIGhYAGU0Cn2WL0yLpaI1H8OO55IfA7Bmmi68m/e5v1N3LcupTzqr1b7RQ8jNS7NDTgETGyW70U6RhMKwqLSe5E58e+xeI5JApcoQXvP4vXXtf3F3BTrVcwkhZa6/VBMdapgjBttyXMKCYp07yWP0itLA5dZ+0NHAVcq5Cu3r64GL+rGx8jJqmTonV91OrEK5jYS+8UeXSauRjLUmDOkhpzGoXvpWp04Nsyv2bxfE2Nj7ytQ6F2q//ZUKIMKA0Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(478600001)(110136005)(54906003)(7416002)(44832011)(5660300002)(8676002)(8936002)(2906002)(86362001)(36756003)(31696002)(66476007)(6636002)(82960400001)(4326008)(66556008)(66946007)(316002)(38100700002)(41300700001)(31686004)(186003)(6486002)(53546011)(2616005)(6512007)(83380400001)(26005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHFRM1p0YyttNU1SZVVXTTRhSHlQbU9YVnlrS1dPZEJhNk02b2RDYTdJSE16?=
 =?utf-8?B?YlNXY3lyeWtiekx2aUZCRHJuVjVPVUtFUmVlcGVnRUxldkRsUkVqUGNMVXFC?=
 =?utf-8?B?MzhsRzVlMmMyOUxxWi9Ld0d2YTJFV0lEaElidEpabG9zWVl5ZExmaFZvR2ZF?=
 =?utf-8?B?SU94czNYRmRaK2I1ckVLSElJMjJrWEdqM0hrWnFHTFlZU09YUytydzZSVklE?=
 =?utf-8?B?T3Y4YWIzeHBYWkJMSVdLSEdndXh4bGkvTHNlaHpMTjV1ZlBpNWdPWm1rMmw0?=
 =?utf-8?B?MC8rVDVHV1RWUG5BUU9QRGNBQS8xOXVaY1NOelNMZUNzNm1KSUpqalcvNkl0?=
 =?utf-8?B?V3UxSi9VSWNkSkdsTCtWQkloeU1DaEloM3Y5UERjM0wrNjlxUmJwbnRTL2Zj?=
 =?utf-8?B?RXdBcnF3YlVwU3liWjhobzdsOUlJWkdBQW1Kb3g2T3ZVQW1rRVVRUlZtUUxt?=
 =?utf-8?B?SDA3Rkk0NnorandvQW1veWUxY3BYWFJQOFBGRzZXbm1kQ1laNlorclpYcmNx?=
 =?utf-8?B?MDl1SG1TNUVDMjRCbUxDbkF4Wml0Q1lQRjN0eXAyd2FDdjlrellKcXd3Z2ti?=
 =?utf-8?B?WUNFNndJWUFEaTU2VDZDcnZvTUFLb3FGWFdMMUhNVzVQdjBjMWFhcUxXWWlZ?=
 =?utf-8?B?ME5ua01KTFRjMHZ5QkJGcDZ1KzJwY2x1S3BQZ1hJSS9SZ25iWUZHWlpRMTVo?=
 =?utf-8?B?TWNhSFllYXBUUmdkNFlzVnROd2UyaDlDV3YwaXdPZnB2ZG1UQ0grRVNCbUZ6?=
 =?utf-8?B?emJtMEZGT29jdzk5NTU0NzVla001L2xsd0Z2b0pIbHh5N05OeHRnZ3FFS1J1?=
 =?utf-8?B?UHZxczEyMEFNb1g4QkEyMDliTHI5QWN1cEl3OTI1a3JESmV1U3M0aHc5NkE1?=
 =?utf-8?B?QXZ2bXl3V01yWTRIdHpkV3ordHE2YzJmZ21rQjlwdkVzaDA5cGdyVUk3UmtV?=
 =?utf-8?B?RHIraVNISk56dmpaTnVvZ2hMVjR1SGpzSEQranJUdTNrMGRENGxvQ1l0UHZh?=
 =?utf-8?B?djRpQkFZdnlwc2Q1SmtQaG1OQ3VYTnFNSEl4MnFobGFZaWdBUGNWWWRQNE8z?=
 =?utf-8?B?ZktGZDVJVm53Uys0YVBHTGViZ3lvaTdSMDZldUZPU2RYKzEzUllmbHJJYWQw?=
 =?utf-8?B?WWVMb0Z5bXgzVHBpUk9sTlRJcEpXbzdINUpNK2c2SFNndXBWL1pJeTFOT2tI?=
 =?utf-8?B?TzlRcXMxblc4M0c0NU5tQ0pEdnRYWG9XRXVRWSszcFZUbC9qV1BuUzNWWHlr?=
 =?utf-8?B?WGV0YmFSRUMvOGFmSXJGV2Yzc2lFMWFtTFd4bE5uTWlQWjBlRVMyeGdhTDV1?=
 =?utf-8?B?OVdJMXIvd0s2cjYzK0hNMmlEWHhUNmVEc1ZJTXpMREFLNHB4cUtBdHZYKy8w?=
 =?utf-8?B?OXQySlFnUFBkMy94RFQ0YmoreUJUazhzZnJRazFySkNlS1NheHZCYUsrMU1h?=
 =?utf-8?B?RDFiS3JLZ2VTMlhESTdWWHR5WStWV0tZUTQ3dVp4dTJjeWdoSVYvVFV5cW94?=
 =?utf-8?B?S0JNRlREZEorTTFhakxIZ0tudk1lUXd0ei81YWgvSzdXaFcwMzZ6TXF6TmhG?=
 =?utf-8?B?RjhSc3I1bDJtYlkxV041dVlwWEg5VzNsdW5pZEVYZDAxaTR1U2htMHJ5T0dv?=
 =?utf-8?B?Si91ZXRHSE9NcXdHZzNJSDJSVTRhMTB0UFViR2ZBV2t1dzVqV243TnVGSU1L?=
 =?utf-8?B?OXhpYTJhYXNxODkzV1cwTUpld2VVZ3c1eFZPUGtNcUdpVFlzaWxhR2VjaHpL?=
 =?utf-8?B?aHNHeU9uWlE0WlB1ak1xWVUrT3NhY2liNjdnNHZ2cUw5d2JxbnhhYzAyTStv?=
 =?utf-8?B?dFArajdTMVBJaWtZSkd0bDZPUDA0S3RqemFnVXpOVXNZUU1meUV4WXJWaHhE?=
 =?utf-8?B?ajRzVUppdDlPNTVrbW5SbWhqdXJ4aFhLV1FSOWpBcVE1NGxZRXd4bVpuVFlv?=
 =?utf-8?B?Z05veFFpZU51Nkl2UVJwTW9nZjhhSWJKSjVwbG1LMS9SdmtTOHNVQzdHVVRy?=
 =?utf-8?B?RGFETDlnVmQ5d0UxczVOM1VqWnljWEdXMml3eUp1OFlIK1hQdkVDZFdCMUxR?=
 =?utf-8?B?dzdWZkFCK2FjcCtzbHVqYlZ2MDE5ZVppRi9iNnNLYzhjUEZ6MkdaRW03b1c4?=
 =?utf-8?B?OGxjL1VScnF0Y01ZVFhlOUxXNnNVOUwycFNibUphVzUxcUVkbS9aQ3RoODky?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d38fd84-2217-4f02-d217-08db5268609a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:40:45.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5Rbk7K7TGTfSf9PTC+BdDZI/isNcdxJnkxmXi37FoOXO/GQGJnCUE95Fr0s6taZWiZTjPwMBkoqt7ivc7wq85KCbmJdo+q5X2ZvXujtcTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 4/21/2023 7:17 AM, Peter Newman wrote:
> @@ -806,12 +811,27 @@ void mbm_handle_overflow(struct work_struct *work)
>  	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  	d = container_of(work, struct rdt_domain, mbm_over.work);
>  
> +	if (rdt_mon_soft_rmid) {
> +		/*
> +		 * HW RMIDs are permanently assigned to CPUs, so only a per-CPU
> +		 * flush is needed.
> +		 */
> +		on_each_cpu_mask(&d->cpu_mask, mbm_flush_cpu_handler, NULL,
> +				 false);
> +	}
> +
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->mon.rmid);
> +		/*
> +		 * mbm_update() on every RMID would result in excessive IPIs
> +		 * when RMIDs are soft.
> +		 */
> +		if (!rdt_mon_soft_rmid) {
> +			mbm_update(r, d, prgrp->mon.rmid);
>  
> -		head = &prgrp->mon.crdtgrp_list;
> -		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->mon.rmid);
> +			head = &prgrp->mon.crdtgrp_list;
> +			list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> +				mbm_update(r, d, crgrp->mon.rmid);
> +		}
>  
>  		if (is_mba_sc(NULL))
>  			update_mba_bw(prgrp, d);


hmmm ... I think that update_mba_bw() relies on mbm_update() to call
mbm_bw_count() to update the data it depends on. Keeping update_mba_bw()
while dropping mbm_update() thus seems problematic. AMD does not support the
software controller though so it may make things simpler if support for
software RMIDs disables support for software controller (in a clear way).

Reinette
